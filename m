Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291809AbSBNRxw>; Thu, 14 Feb 2002 12:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291806AbSBNRxn>; Thu, 14 Feb 2002 12:53:43 -0500
Received: from [66.150.46.254] ([66.150.46.254]:29832 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S291802AbSBNRxa>;
	Thu, 14 Feb 2002 12:53:30 -0500
Message-ID: <3C6BF994.A002AEA4@wgate.com>
Date: Thu, 14 Feb 2002 12:53:24 -0500
From: Michael Sinz <msinz@wgate.com>
Organization: WorldGate Communications Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; FreeBSD 4.5-STABLE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Core dump file control
In-Reply-To: <361c88b8047e6c07d2@[192.168.1.4]>
Content-Type: multipart/mixed;
 boundary="------------FE40BC1C3832D1991F6523E6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FE40BC1C3832D1991F6523E6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Michael Sinz wrote:
> 
> I have, for a long time, wished that Linux had a way to specify where
> core dumps are stored and what the name of the core dump is.  Now that
> I have been building large linux clusters with many diskless nodes,
> this need has become even more important.

[...]

This patch is the one for Linux 2.5.4 (albeit not as heavily tested)

-- 
Michael Sinz ---- Worldgate Communications ---- msinz@wgate.com
A master's secrets are only as good as
	the master's ability to explain them to others.
--------------FE40BC1C3832D1991F6523E6
Content-Type: text/plain; charset=us-ascii;
 name="myPatch-2.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="myPatch-2.5"

diff -urP linux-2.5.4/fs/exec.c linux-2.5.4-patch/fs/exec.c
--- linux-2.5.4/fs/exec.c	Sun Feb 10 20:50:15 2002
+++ linux-2.5.4-patch/fs/exec.c	Thu Feb 14 12:45:00 2002
@@ -35,6 +35,7 @@
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/personality.h>
+#include <linux/utsname.h>
 #include <linux/binfmts.h>
 #define __NO_VERSION__
 #include <linux/module.h>
@@ -49,6 +50,12 @@
 
 int core_uses_pid;
 
+/* The format string for the core file name...
+   We default to "core" such that past behavior
+   remains unchanged.  The 64 character limit is
+   arbitrary but must match the sysctl table. */
+char core_name_format[64] = {"core"};
+
 static struct linux_binfmt *formats;
 static rwlock_t binfmt_lock = RW_LOCK_UNLOCKED;
 
@@ -934,14 +941,37 @@
 		__MOD_DEC_USE_COUNT(old->module);
 }
 
+/* This is the maximum expanded core file name.  We use
+   a reasonable number here since we use the stack to
+   do the expansion.  However, the number should be big
+   enough to handle a reasonable command name plus PID
+   and/or UID in addition to the file name part that
+   is in the core_name_format string. */
+#define MAX_CORE_NAME (160)
+
 int do_coredump(long signr, struct pt_regs * regs)
 {
 	struct linux_binfmt * binfmt;
-	char corename[6+sizeof(current->comm)+10];
 	struct file * file;
 	struct inode * inode;
 	int retval = 0;
 
+	int fmt_i;
+	int name_n;
+	int addPID;
+	char *cname;
+
+	/* The +11 is here to simplify the code path.  What
+	   we do is always check that we are less than MAX
+	   but there are times when we also need to append
+	   a number (such as the PID or UID).  Rather than
+	   using another temporary buffer, we provide for
+	   enough extra space such that those numbers can
+	   be added in one gulp even if we are just under
+	   the MAX_CORE_NAME.  Reduction in complexity of
+	   the code path means a more reliable implementation. */
+	char corename[MAX_CORE_NAME + 1 + 11];
+
 	lock_kernel();
 	binfmt = current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
@@ -952,10 +982,92 @@
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
 		goto fail;
 
-	memcpy(corename,"core.", 5);
-	corename[4] = '\0';
- 	if (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)
- 		sprintf(&corename[4], ".%d", current->pid);
+	/* Set this to true if we are going to add the PID.  If the PID
+	   already is added in the format we will end up clearing this.
+	   The purpose is to provide for the old behavior of adding the
+	   PID to the core file name but to not add it if it already
+	   was included via the file name format pattern. */
+	addPID = (core_uses_pid || atomic_read(&current->mm->mm_users) != 1);
+
+	/* Build the core file name as needed from the format string */
+	for (fmt_i=0, name_n=0;
+	     name_n < MAX_CORE_NAME && core_name_format[fmt_i];
+	     fmt_i++)
+	{
+		switch (core_name_format[fmt_i])
+		{
+		case '%':	/* A format character */
+			fmt_i++;
+			switch (core_name_format[fmt_i])
+			{
+			case '%': /* The way we get this character */
+				corename[name_n++] = '%';
+				break;
+
+			case 'N': /* Process name */
+				cname=current->comm;
+
+				/* Only copy as much as will fit within the
+				   MAX_CORE_NAME */
+				while (*cname && (name_n < MAX_CORE_NAME))
+				{
+					if (*cname != '/')
+						corename[name_n++] = *cname;
+					cname++;
+				}
+				break;
+
+			case 'H': /* Node name */
+				cname=system_utsname.nodename;
+
+				/* Only copy as much as will fit within the
+				   MAX_CORE_NAME */
+				while (*cname && (name_n < MAX_CORE_NAME))
+				{
+					if (*cname != '/')
+						corename[name_n++] = *cname;
+					cname++;
+				}
+				break;
+
+			case 'P': /* Process PID */
+				/* Since we are adding it here, don't append */
+				addPID=0;
+
+				/* We don't need to pre-check that the number
+				   fits since we added a padding of 11
+				   characters to the end of the string buffer
+				   just so that we don't need to do an extra
+				   check */
+				name_n += sprintf(&corename[name_n],"%d",current->pid);
+				break;
+
+			case 'U': /* UID of the process */
+				/* We don't need to pre-check that the number
+				   fits since we added a padding of 11
+				   characters to the end of the string buffer
+				   just so that we don't need to do an extra
+				   check */
+				name_n += sprintf(&corename[name_n],"%d",current->uid);
+				break;
+			}
+			break;
+
+		default:	/* Anything else just pass along */
+			corename[name_n++] = core_name_format[fmt_i];
+		}
+	}
+
+	/* If we still want to append the PID and there is room, do so */
+	/* This is to preserve current behavior */
+	if (addPID && (name_n < MAX_CORE_NAME))
+	{
+		name_n += sprintf(&corename[name_n],".%d",current->pid);
+	}
+
+	/* And make sure to null terminate the string */
+	corename[name_n]='\0';
+
 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
 	if (IS_ERR(file))
 		goto fail;
diff -urP linux-2.5.4/include/linux/sysctl.h linux-2.5.4-patch/include/linux/sysctl.h
--- linux-2.5.4/include/linux/sysctl.h	Sun Feb 10 20:50:07 2002
+++ linux-2.5.4-patch/include/linux/sysctl.h	Thu Feb 14 12:43:52 2002
@@ -124,6 +124,7 @@
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
+	KERN_CORE_NAME_FORMAT=55, /* string: core file name format string */
 };
 
 
diff -urP linux-2.5.4/kernel/sysctl.c linux-2.5.4-patch/kernel/sysctl.c
--- linux-2.5.4/kernel/sysctl.c	Sun Feb 10 20:50:09 2002
+++ linux-2.5.4-patch/kernel/sysctl.c	Thu Feb 14 12:43:52 2002
@@ -50,6 +50,7 @@
 extern int max_queued_signals;
 extern int sysrq_enabled;
 extern int core_uses_pid;
+extern char core_name_format[];
 extern int cad_pid;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
@@ -172,6 +173,8 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_CORE_USES_PID, "core_uses_pid", &core_uses_pid, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+	{KERN_CORE_NAME_FORMAT, "core_name_format", core_name_format, 64,
+	 0644, NULL, &proc_doutsstring, &sysctl_string},
 	{KERN_TAINTED, "tainted", &tainted, sizeof(int),
 	 0644, NULL, &proc_dointvec},
 	{KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),

--------------FE40BC1C3832D1991F6523E6--

