Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUIIQNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUIIQNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUIIQNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:13:42 -0400
Received: from open.hands.com ([195.224.53.39]:53207 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S266209AbUIIQKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:10:48 -0400
Date: Thu, 9 Sep 2004 17:22:00 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040909162200.GB9456@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

wow, gosh, it works.

okay, this is a patch to add support in iptables for per-program
firewall filtering.

also included is the patches to iptables-1.2.11.

i have confidence that this patch will provide support for
BOTH incoming AND outgoing per-program packet filtering.

reasons why patch was developed:

	fireflier is an on-demand popup firewall program that
	queues packets and asks the user there-and-then to create
	a firewall rule.

	fireflier can do a limited amount of per-program packet
	filtering but it is stateless.

	this patch hooks into netfilter, thereby allowing STATEFUL
	per-program per-connection firewall rules to be created.


potential uses:

	only allowing certain programs to do certain network
	activities (e.g. only allowing skype or other VoIP apps
	to do incoming connections on a certain port; only allowing
	mozilla to access port 80 but allowing lynx to do more)

	i cannot forsee a need for people to only do per-inode
	filtering that is going to cause them havoc.

	i _can_ however sort-of forsee a need for people to
	do per-mount-point filtering.

	for example, an nfs mount point or /usr/local may
	contain untrusted executables.

writing firewall rule - preconditions for use:

	note that of course you will need to ensure a userspace iptables
	policy of "DENY ALL" and "ALLOW specific".

	if you apply "DENY specific" rules on a per-program basis, all a
	non-root user has to do is to copy the binary, they will have
	changed the inode, the rule no longer applies.

importance for users:

	the strategic importance of this functionality (for the
	ordinary computer user) should not be underestimated.

	it allows "on-demand" firewalling to be done in
	userspace: generation of rules "on-the-fly" using
	programs like fireflier.

	no windows "personal firewall" program
	would be seen dead without being able to do
	per-program-plus-per-connection firewall filtering.

caveats:

	the task is not yet entirely complete: in userspace,
	it is necessary to do ls --inode <programname> and
	also determine the mount point, and then *keep that
	info up-to-date*.

	programs get installed by the administrator, the
	inode changes...

loads of rubbish questions about how to do a better job:

	i do not believe it to be sensible to have the kernel
	code doing that kind of checking (resolving the full
	pathname of an executable) but hey, if anyone feels
	otherwise, and knows of some pre-existing code to point
	me in the direction of, i'll add it, because it might
	be easier in the long run.

	for example... do i just hunt down the dentry
	cache entries back down the parent dentry->parent,
	prepending dentry->d_name and a "/" to construct the
	full path name?

	can i expect the dentry cache entries to all exist, i'm
	not going to run into flushed or out-of-date entries,
	am i? (what's this DCACHE_DISCONNECTED thing?)

	also where do i go from the root mount point?

	how do i turn the vfsmount mountpoint entry (/dev/hda5)
	into its mount point name?  hunt down its dentry again?

	what if i hit another mount point: how do i look up
	a mount point of another filesystem, given just an
	inode of the root of the device?


	has someone already done this before now, and if so,
	where?

	because it's the kind of code that would be extremely
	useful to have in selinux auditing.

	the selinux auditing log messages only presently include
	the name of the file (not the fully qualified path) and
	things like "error access denied to a local directory
	named "lib" isn't exactly very helpful!)

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ipt_owner.patch"

Index: fs/proc/base.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/fs/proc/base.c,v
retrieving revision 1.1.1.9
diff -u -u -r1.1.1.9 base.c
--- fs/proc/base.c	18 Jun 2004 19:30:20 -0000	1.1.1.9
+++ fs/proc/base.c	9 Sep 2004 15:32:32 -0000
@@ -206,11 +206,12 @@
 	return -ENOENT;
 }
 
-static int proc_exe_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
+extern int proc_task_dentry_lookup(struct task_struct *task, struct dentry **dentry, struct vfsmount **mnt);
+
+int proc_task_dentry_lookup(struct task_struct *task, struct dentry **dentry, struct vfsmount **mnt)
 {
 	struct vm_area_struct * vma;
 	int result = -ENOENT;
-	struct task_struct *task = proc_task(inode);
 	struct mm_struct * mm = get_task_mm(task);
 
 	if (!mm)
@@ -233,6 +234,11 @@
 	return result;
 }
 
+static int proc_exe_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
+{
+	return proc_task_dentry_lookup(proc_task(inode), dentry, mnt);
+}
+
 static int proc_cwd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
 	struct fs_struct *fs;
Index: fs/proc/root.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/fs/proc/root.c,v
retrieving revision 1.1.1.2
diff -u -u -r1.1.1.2 root.c
--- fs/proc/root.c	8 Apr 2004 14:13:50 -0000	1.1.1.2
+++ fs/proc/root.c	9 Sep 2004 15:32:32 -0000
@@ -147,6 +147,8 @@
 	.parent		= &proc_root,
 };
 
+extern int proc_task_dentry_lookup(struct task_struct *task, struct dentry **dentry, struct vfsmount **mnt);
+
 #ifdef CONFIG_SYSCTL
 EXPORT_SYMBOL(proc_sys_root);
 #endif
@@ -159,3 +161,4 @@
 EXPORT_SYMBOL(proc_net);
 EXPORT_SYMBOL(proc_bus);
 EXPORT_SYMBOL(proc_root_driver);
+EXPORT_SYMBOL(proc_task_dentry_lookup);
Index: include/linux/netfilter_ipv4/ipt_owner.h
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/include/linux/netfilter_ipv4/ipt_owner.h,v
retrieving revision 1.1.1.1
diff -u -u -r1.1.1.1 ipt_owner.h
--- include/linux/netfilter_ipv4/ipt_owner.h	14 Aug 2003 12:09:16 -0000	1.1.1.1
+++ include/linux/netfilter_ipv4/ipt_owner.h	9 Sep 2004 15:32:40 -0000
@@ -7,6 +7,10 @@
 #define IPT_OWNER_PID	0x04
 #define IPT_OWNER_SID	0x08
 #define IPT_OWNER_COMM	0x10
+#define IPT_OWNER_INO	0x20
+#define IPT_OWNER_DEV	0x40
+
+#define IPT_DEVNAME_SZ 80
 
 struct ipt_owner_info {
     uid_t uid;
@@ -14,6 +18,12 @@
     pid_t pid;
     pid_t sid;
     char comm[16];
+
+	/* set these as a pair: specify the filesystem, specify the inode */
+	/* it's the only simple (and unambigous) way to reference a program */
+	char device[IPT_DEVNAME_SZ];
+    unsigned long ino;
+
     u_int8_t match, invert;	/* flags */
 };
 
Index: net/ipv4/netfilter/ipt_owner.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/net/ipv4/netfilter/ipt_owner.c,v
retrieving revision 1.1.1.4
diff -u -u -r1.1.1.4 ipt_owner.c
--- net/ipv4/netfilter/ipt_owner.c	13 May 2004 18:03:23 -0000	1.1.1.4
+++ net/ipv4/netfilter/ipt_owner.c	9 Sep 2004 15:32:44 -0000
@@ -1,16 +1,34 @@
 /* Kernel module to match various things tied to sockets associated with
-   locally generated outgoing packets. */
+   locally generated outgoing packets.
+   
+   lkcl 2004sep9: match against filesystem on which program handling the
+                  packet can be found (IPT_OWNER_DEV) and also the inode
+				  on that filesystem of that same program.
+
+				  why anyone would want to only check just the mountpoint
+				  i don't know (well, i do - e.g. /usr/local is a
+				  separate untrusted or even an nfs-mounted partition)
+				  but i had to include and check the mountpoint because
+				  otherwise the inode is meaningless.
+   */
 
 /* (C) 2000 Marc Boucher <marc@mbsi.ca>
+ * (C) 2004 Luke Kenneth Casson Leighton <lkcl@lkcl.net>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
  */
 
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/file.h>
+#include <linux/rwsem.h>
+#include <linux/mount.h>
+#include <linux/dcache.h>
+#include <linux/string.h>
+#include <linux/sched.h>
 #include <net/sock.h>
 
 #include <linux/netfilter_ipv4/ipt_owner.h>
@@ -20,6 +38,86 @@
 MODULE_AUTHOR("Marc Boucher <marc@mbsi.ca>");
 MODULE_DESCRIPTION("iptables owner match");
 
+/* lkcl: this function is in fs/proc/base.c.  it's a generic function
+ * derived from proc_exe_link().  it's inappropriate to leave that
+ * function in fs/proc/base.c.  but i don't care: i don't have the
+ * knowledge to say where it should go.  therefore i'm leaving
+ * it in fs/proc/base.c.
+ */
+extern int proc_task_dentry_lookup(struct task_struct *task,
+		                           struct dentry **dentry, 
+								   struct vfsmount **mnt);
+
+/*
+ * look up the dentry (for the inode) of the task's executable,
+ * plus lookup the mountpoint of the filesystem from where that
+ * executable came from.   then do exactly the same socket checking
+ * that all the other checks seem to be doing.
+ */
+static int proc_exe_check(struct task_struct *task, u_int8_t match,
+		                  const char *devname, unsigned long i_num)
+{
+    int result = -ENOENT;
+	struct vfsmount *mnt;
+    struct dentry *dentry;
+	result = proc_task_dentry_lookup(task, &dentry, &mnt);
+	if (result != 0)
+		return result;
+
+	if (!dentry->d_inode)
+		return -ENOENT;
+
+	/* lkcl: i can't be bothered to make obtuse code out of some
+	 * boolean overkill logic cleverness.
+	 */
+	if (match & IPT_OWNER_INO && match & IPT_OWNER_DEV)
+		if (dentry->d_inode->i_ino == i_num &&
+			strncmp(mnt->mnt_devname, devname, IPT_DEVNAME_SZ) == 0)
+		return 0;
+	if (match & IPT_OWNER_INO)
+		if (dentry->d_inode->i_ino == i_num)
+		    return 0;
+	if (match & IPT_OWNER_DEV)
+		if (strncmp(mnt->mnt_devname, devname, IPT_DEVNAME_SZ) == 0)
+		    return 0;
+	return -ENOENT;
+}
+
+static int
+match_inode(const struct sk_buff *skb, u_int8_t match,
+		    const char *devname, unsigned long i_num)
+{
+	struct task_struct *g, *p;
+	struct files_struct *files;
+	int i;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+
+		if (proc_exe_check(p, match, devname, i_num))
+			continue;
+
+		task_lock(p);
+		files = p->files;
+		if(files) {
+			spin_lock(&files->file_lock);
+			for (i=0; i < files->max_fds; i++) {
+				if (fcheck_files(files, i) ==
+				    skb->sk->sk_socket->file) {
+					spin_unlock(&files->file_lock);
+					task_unlock(p);
+					read_unlock(&tasklist_lock);
+					return 1;
+				}
+			}
+			spin_unlock(&files->file_lock);
+		}
+		task_unlock(p);
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+	return 0;
+}
+
 static int
 match_comm(const struct sk_buff *skb, const char *comm)
 {
@@ -163,6 +261,12 @@
 			return 0;
 	}
 
+	if(info->match & IPT_OWNER_INO || info->match & IPT_OWNER_DEV) {
+		if (!match_inode(skb, info->match, info->device, info->ino) ^
+		    !!(info->invert & IPT_OWNER_INO))
+			return 0;
+	}
+
 	return 1;
 }
 

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="iptables.ipt_owner.patch"

--- iptables-1.2.11/extensions/libipt_owner.c	2004-06-14 23:02:17.000000000 +0100
+++ /home/lkcl/src/iptables-1.2.11/debian/build/iptables-1.2.11/extensions/libipt_owner.c	2004-09-09 17:12:28.000000000 +0100
@@ -1,4 +1,8 @@
 /* Shared library add-on to iptables to add OWNER matching support. */
+
+/* lkcl2004sep09: code to do per-program packet filtering (by device name and inode number)
+ * Copyright (C) Luke Kenneth Casson Leighton <lkcl@lkcl.net>
+ */
 #include <stdio.h>
 #include <netdb.h>
 #include <string.h>
@@ -34,6 +38,14 @@
 "\n",
 IPTABLES_VERSION);
 #endif /* IPT_OWNER_COMM */
+#ifdef IPT_OWNER_INO
+	printf(
+"OWNER match v%s options:\n"
+"[!] --dev-owner name       Match local device\n"
+"[!] --ino-owner inode      Match local inode (always use with --dev-owner)\n"
+"\n",
+IPTABLES_VERSION);
+#endif /* IPT_OWNER_INO */
 }
 
 static struct option opts[] = {
@@ -44,6 +56,12 @@
 #ifdef IPT_OWNER_COMM
 	{ "cmd-owner", 1, 0, '5' },
 #endif
+#ifdef IPT_OWNER_INO
+	{ "ino-owner", 1, 0, '6' },
+#endif
+#ifdef IPT_OWNER_DEV
+	{ "dev-owner", 1, 0, '7' },
+#endif
 	{0}
 };
 
@@ -136,6 +154,33 @@
 		*flags = 1;
 		break;
 #endif
+#ifdef IPT_OWNER_INO
+	case '6':
+		check_inverse(optarg, &invert, &optind, 0);
+		ownerinfo->ino = strtoul(optarg, &end, 0);
+		if (*end != '\0' || end == optarg)
+			exit_error(PARAMETER_PROBLEM, "Bad OWNER INODE value `%s'", optarg);
+		if (invert)
+			ownerinfo->invert |= IPT_OWNER_INO;
+		ownerinfo->match |= IPT_OWNER_INO;
+		*flags = 1;
+		break;
+#endif
+#ifdef IPT_OWNER_DEV
+	case '7':
+		check_inverse(optarg, &invert, &optind, 0);
+		if(strlen(optarg) > sizeof(ownerinfo->device))
+			exit_error(PARAMETER_PROBLEM, "OWNER DEV `%s' too long, max %u characters", optarg, (unsigned int)sizeof(ownerinfo->device));
+
+		strncpy(ownerinfo->device, optarg, sizeof(ownerinfo->device));
+		ownerinfo->device[sizeof(ownerinfo->device)-1] = '\0';
+
+		if (invert)
+			ownerinfo->invert |= IPT_OWNER_DEV;
+		ownerinfo->match |= IPT_OWNER_DEV;
+		*flags = 1;
+		break;
+#endif
 
 	default:
 		return 0;
@@ -189,6 +234,16 @@
 			printf("%.*s ", (int)sizeof(info->comm), info->comm);
 			break;
 #endif
+#ifdef IPT_OWNER_DEV
+		case IPT_OWNER_DEV:
+			printf("%.*s ", (int)sizeof(info->device), info->device);
+			break;
+#endif
+#ifdef IPT_OWNER_INO
+		case IPT_OWNER_INO:
+			printf("%lu ", info->ino);
+			break;
+#endif
 		default:
 			break;
 		}
@@ -219,6 +274,12 @@
 #ifdef IPT_OWNER_COMM
 	print_item(info, IPT_OWNER_COMM, numeric, "OWNER CMD match ");
 #endif
+#ifdef IPT_OWNER_INO
+	print_item(info, IPT_OWNER_INO, numeric, "OWNER INO match ");
+#endif
+#ifdef IPT_OWNER_DEV
+	print_item(info, IPT_OWNER_DEV, numeric, "OWNER DEV match ");
+#endif
 }
 
 /* Saves the union ipt_matchinfo in parsable form to stdout. */
@@ -234,6 +295,12 @@
 #ifdef IPT_OWNER_COMM
 	print_item(info, IPT_OWNER_COMM, 0, "--cmd-owner ");
 #endif
+#ifdef IPT_OWNER_DEV
+	print_item(info, IPT_OWNER_DEV, 0, "--dev-owner ");
+#endif
+#ifdef IPT_OWNER_INO
+	print_item(info, IPT_OWNER_INO, 0, "--ino-owner ");
+#endif
 }
 
 static

--X1bOJ3K7DJ5YkBrT--
