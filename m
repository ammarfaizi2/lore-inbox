Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269093AbUIHK27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269093AbUIHK27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 06:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269079AbUIHK27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 06:28:59 -0400
Received: from open.hands.com ([195.224.53.39]:24740 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S269093AbUIHK2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 06:28:21 -0400
Date: Wed, 8 Sep 2004 11:39:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] to add device+inode check to ipt_owner.c - HACKED UP
Message-ID: <20040908103922.GD9795@lkcl.net>
References: <20040908100946.GA9795@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20040908100946.GA9795@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

... did i sent a patch?

did i send a patch??  i don't _think_ so *lol* :)

On Wed, Sep 08, 2004 at 11:09:47AM +0100, Luke Kenneth Casson Leighton wrote:
> dear kernel people,
> 
> this is a first pass at attempting to add per-program firewall rule
> checking to iptables.

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ipt_owner.patch"

Index: fs/proc/base.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/fs/proc/base.c,v
retrieving revision 1.1.1.9
diff -u -u -r1.1.1.9 base.c
--- fs/proc/base.c	18 Jun 2004 19:30:20 -0000	1.1.1.9
+++ fs/proc/base.c	8 Sep 2004 01:09:10 -0000
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
+++ fs/proc/root.c	8 Sep 2004 01:09:10 -0000
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
+++ include/linux/netfilter_ipv4/ipt_owner.h	8 Sep 2004 01:09:14 -0000
@@ -7,6 +7,9 @@
 #define IPT_OWNER_PID	0x04
 #define IPT_OWNER_SID	0x08
 #define IPT_OWNER_COMM	0x10
+#define IPT_OWNER_INO	0x20
+
+#define IPT_DEVNAME_SZ 80
 
 struct ipt_owner_info {
     uid_t uid;
@@ -14,6 +17,12 @@
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
+++ net/ipv4/netfilter/ipt_owner.c	8 Sep 2004 01:09:16 -0000
@@ -11,6 +11,11 @@
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
@@ -20,6 +25,117 @@
 MODULE_AUTHOR("Marc Boucher <marc@mbsi.ca>");
 MODULE_DESCRIPTION("iptables owner match");
 
+extern int proc_task_dentry_lookup(struct task_struct *task, struct dentry **dentry, struct vfsmount **mnt);
+
+static int proc_exe_check(struct task_struct *task,
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
+	if (dentry->d_inode->i_ino == i_num &&
+			strncmp(mnt->mnt_devname, devname, IPT_DEVNAME_SZ) == 0)
+		return 0;
+	return -ENOENT;
+}
+
+#if 0
+static int proc_exe_check(struct task_struct *task,
+		                  const char *devname, unsigned long i_num)
+{
+    struct vm_area_struct * vma;
+    int result = -ENOENT;
+    struct mm_struct * mm = get_task_mm(task);
+
+    if (!mm)
+        goto out;
+    down_read(&mm->mmap_sem);
+    vma = mm->mmap;
+    while (vma) {
+        if ((vma->vm_flags & VM_EXECUTABLE) &&
+            vma->vm_file) {
+            struct vfsmount *mnt = mntget(vma->vm_file->f_vfsmnt);
+            struct dentry *dentry = dget(vma->vm_file->f_dentry);
+			if (!dentry->d_inode)
+				continue;
+			if (dentry->d_inode->i_ino == i_num &&
+					strncmp(mnt->mnt_devname, devname, IPT_DEVNAME_SZ) == 0)
+				{
+					result = 0;
+					break;
+				}
+        }
+        vma = vma->vm_next;
+    }
+    up_read(&mm->mmap_sem);
+    mmput(mm);
+out:
+    return result;
+}
+#endif
+
+static int
+match_inode(const struct sk_buff *skb, const char *devname, unsigned long i_num)
+{
+	struct task_struct *g, *p;
+	struct files_struct *files;
+	/*
+	struct inode *inode;
+	struct super_block *sb;
+	struct block_device *bd;
+	*/
+	int i;
+	read_lock(&tasklist_lock);
+
+	/* lkcl: these are fairly obvious (just obtuse): hunt for the
+	 * filesystem device, then its superblock, then the inode is
+	 * relevant to that superblock, _then_ we can find the inode.
+	bd = bdget(dev);
+	if (!bd)
+		goto out;
+
+	sb = get_super(bd);
+	if (!sb)
+		goto out;
+
+	inode = ilookup(sb, i_num);
+	if (!inode)
+		goto out;
+	 */
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+
+		if (proc_exe_check(p, devname, i_num))
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
@@ -163,6 +279,12 @@
 			return 0;
 	}
 
+	if(info->match & IPT_OWNER_INO) {
+		if (!match_inode(skb, info->device, info->ino) ^
+		    !!(info->invert & IPT_OWNER_INO))
+			return 0;
+	}
+
 	return 1;
 }
 

--X1bOJ3K7DJ5YkBrT--
