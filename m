Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbUAPJfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 04:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbUAPJfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 04:35:54 -0500
Received: from hermes.iil.intel.com ([192.198.152.99]:17814 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S265332AbUAPJfZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 04:35:25 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH]: non-readable binaries - binfmt_misc 2.6.0
Date: Fri, 16 Jan 2004 11:35:09 +0200
Message-ID: <2C83850C013A2540861D03054B478C0601CF68D0@hasmsx403.iil.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]: non-readable binaries - binfmt_misc 2.6.0
Thread-Index: AcPb+V1UqqRxx5eaQCa7XQ9MAAPzrAAGmk+g
From: "Zach, Yoav" <yoav.zach@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Jan 2004 09:35:10.0127 (UTC) FILETIME=[08C7BBF0:01C3DC14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> can you send a version which isn't all wordwrapped?
> 

i prepared a patch that solves a couple of problems that interpreters
have when invoked via binfmt_misc. currently - 
1) such interpreters cannot open non-readable binaries
2) the processes will have their credentials and security attributes
calculated according to interpreter permissions and not those of the
original binary

the proposed patch solves these problems by -
1) opening the binary on behalf of the interpreter and passing its fd
instead of the path as argv[1] to the interpreter
2) calling prepare_binprm with the file struct of the binary and not the
one of the interpreter

new functionality is enabled by adding a special flag to the
registration string. if this flag is not added then old behavior is not
changed.

preliminary version of this patch was sent to the list on 9/1/2003 with
the title "[PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4".
this new version fixes the concerns that were raised by the patch,
except of calling unshare_files() before allocating a new fd. this is
because this feature did not enter 2.6 yet. 

the patch is against 2.6.0 -

-------------------------- BEGIN PATCH ---------------------------------
diff -r -U 3 linux-2.6.0/fs/binfmt_misc.c linux/fs/binfmt_misc.c
--- linux-2.6.0/fs/binfmt_misc.c	2004-01-08
16:28:44.000000000+0200
+++ linux/fs/binfmt_misc.c	2004-01-12 15:16:11.550249310 +0200
@@ -38,6 +38,7 @@
 
 enum {Enabled, Magic};
 #define MISC_FMT_PRESERVE_ARGV0 (1<<31)
+#define MISC_FMT_OPEN_BINARY (1<<30)
 
 typedef struct {
 	struct list_head list;
@@ -101,10 +102,13 @@
 static int load_misc_binary(struct linux_binprm *bprm, struct pt_regs
*regs)
 {
 	Node *fmt;
-	struct file * file;
+	struct file * interp_file;
 	char iname[BINPRM_BUF_SIZE];
 	char *iname_addr = iname;
 	int retval;
+	int fd;
+	char fd_str[32];
+	char * fdsp = fd_str;
 
 	retval = -ENOEXEC;
 	if (!enabled)
@@ -119,15 +123,36 @@
 	if (!fmt)
 		goto _ret;
 
-	allow_write_access(bprm->file);
-	fput(bprm->file);
-	bprm->file = NULL;
+ 	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
+		/* if the binary should be opened on behalf of the
+		 * interpreter than keep it open and assign descriptor 
+		 * to it */
+ 		fd = get_unused_fd ();
+ 		if (fd < 0) {
+ 			retval = fd;
+ 			goto _ret;
+ 		} else {
+ 			fd_install (fd, bprm->file);
+ 			snprintf (fd_str, sizeof(fd_str)-1, "%d", fd);
+ 		}
+ 	} else {
+ 		allow_write_access(bprm->file);
+ 		fput(bprm->file);
+ 		bprm->file = NULL;
+ 	}
 
 	/* Build args for interpreter */
 	if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
 		remove_arg_zero(bprm);
 	}
-	retval = copy_strings_kernel(1, &bprm->interp, bprm);
+
+ 	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
+		/* make argv[1] be the file descriptor of the binary */
+ 		retval = copy_strings_kernel(1, &fdsp, bprm);
+ 	} else {
+		/* make argv[1] be the path to the binary */
+ 		retval = copy_strings_kernel(1, &bprm->interp, bprm);
+ 	}
 	if (retval < 0) goto _ret; 
 	bprm->argc++;
 	retval = copy_strings_kernel(1, &iname_addr, bprm);
@@ -135,15 +160,39 @@
 	bprm->argc++;
 	bprm->interp = iname;	/* for binfmt_script */
 
-	file = open_exec(iname);
-	retval = PTR_ERR(file);
-	if (IS_ERR(file))
+	interp_file = open_exec(iname);
+	retval = PTR_ERR(interp_file);
+	if (IS_ERR(interp_file))
 		goto _ret;
-	bprm->file = file;
 
-	retval = prepare_binprm(bprm);
+	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
+		/* if the binary is not readable than enforce
mm->dumpable=0 
+		   regardless of the interpreter's permissions */
+		if
(permission(bprm->file->f_dentry->d_inode,MAY_READ,NULL)) {
+			bprm->interp_flags |=
BINPRM_FLAGS_ENFORCE_NONDUMP;
+		}
+		/* call prepare_binprm before switching to interpreter's
file
+		 * so that all security calculation will be done
according to 
+		 * binary and not interpreter */
+		retval = prepare_binprm(bprm);
+		if (retval < 0) {
+			goto _ret;
+		}
+		/* switch to interpreter and read it's header */
+		bprm->file = interp_file;
+		memset(bprm->buf,0,BINPRM_BUF_SIZE);
+		retval =
kernel_read(bprm->file,0,bprm->buf,BINPRM_BUF_SIZE);
+	} else {
+		bprm->file = interp_file;
+		retval = prepare_binprm(bprm);
+	}
+
+
 	if (retval >= 0)
 		retval = search_binary_handler(bprm, regs);
+
+	if (retval < 0)
+		bprm->interp_flags &= ~BINPRM_FLAGS_ENFORCE_NONDUMP;
 _ret:
 	return retval;
 }
@@ -190,6 +239,26 @@
 	return p - from;
 }
 
+static inline char * check_special_flags (char * sfs, Node * e)
+{
+	char * p = sfs;
+	char SPECIAL_FLAGS[] = "OP";
+
+	/* special flags */
+	while (strchr (SPECIAL_FLAGS, *p)) {
+		switch (*p) {
+			case 'P':
+				p++;
+				e->flags |= MISC_FMT_PRESERVE_ARGV0;
+				break;
+			case 'O':
+				p++;
+				e->flags |= MISC_FMT_OPEN_BINARY;
+				break;
+		}
+	}
+	return p;
+}
 /*
  * This registers a new binary format, it recognises the syntax
  * ':name:type:offset:magic:mask:interpreter:'
@@ -292,10 +361,8 @@
 	if (!e->interpreter[0])
 		goto Einval;
 
-	if (*p == 'P') {
-		p++;
-		e->flags |= MISC_FMT_PRESERVE_ARGV0;
-	}
+
+	p = check_special_flags (p, e);
 
 	if (*p == '\n')
 		p++;
diff -r -U 3 linux-2.6.0/fs/exec.c linux/fs/exec.c
--- linux-2.6.0/fs/exec.c	2004-01-08 16:28:44.000000000 +0200
+++ linux/fs/exec.c	2004-01-12 15:16:11.564897747 +0200
@@ -816,7 +816,8 @@
 	flush_thread();
 
 	if (bprm->e_uid != current->euid || bprm->e_gid != current->egid
|| 
-	    permission(bprm->file->f_dentry->d_inode,MAY_READ, NULL))
+	    permission(bprm->file->f_dentry->d_inode,MAY_READ, NULL) || 
+	    (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP))
 		current->mm->dumpable = 0;
 
 	/* An exec changes our domain. We are no longer part of the
thread
@@ -1085,6 +1087,7 @@
 	bprm.file = file;
 	bprm.filename = filename;
 	bprm.interp = filename;
+	bprm.interp_flags = 0;
 	bprm.sh_bang = 0;
 	bprm.loader = 0;
 	bprm.exec = 0;
diff -r -U 3 linux-2.6.0/include/linux/binfmts.h
linux/include/linux/binfmts.h
--- linux-2.6.0/include/linux/binfmts.h	2004-01-08 16:28:42.000000000
+0200
+++ linux/include/linux/binfmts.h	2004-01-12 15:16:04.960405641
+0200
@@ -35,9 +35,13 @@
 	char * interp;      /* Name of the binary really executed. Most
 					       of the time same as
filename, but could be
 				           different for
binfmt_{misc,script} */
+	unsigned long interp_flags;
 	unsigned long loader, exec;
 };
 
+#define BINPRM_FLAGS_ENFORCE_NONDUMP_BIT 0
+#define BINPRM_FLAGS_ENFORCE_NONDUMP (1 <<
BINPRM_FLAGS_ENFORCE_NONDUMP_BIT)
+
 /*
  * This structure defines the functions that are used to load the
binary formats that
  * linux accepts.
-------------------------- END PATCH
------------------------------------


Yoav Zach
IA-32 Execution Layer
Performance Tools Lab
Intel Corp.
