Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWBRMLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWBRMLd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWBRMLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:11:33 -0500
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:18380
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S1751151AbWBRMLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:11:32 -0500
From: =?iso-8859-1?q?T=F6r=F6k_Edwin?= <edwin.torok@level7.ro>
Organization: Level 7 Software
To: netfilter-devel@lists.netfilter.org, fireflier-devel@lists.sourceforge.net
Subject: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting both incoming and outgoing packets
Date: Sat, 18 Feb 2006 14:10:59 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, martinmaurer@gmx.at
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602181410.59757.edwin.torok@level7.ro>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - level7.ro
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please Cc: fireflier-devel@lists.sourceforge.net, Martin, and me on replys, 
thanks]
[Excuse me for cross-posting, but I think this rfc/patch concerns both the 
netfilter subsystem, and the kernel in general]

Hi,


This is a patch based on Luke Kenneth Casson Leighton's patch [1] 
One problem with that patch was that it couldn't be used for filtering 
incoming packets, due to the fact that more than one process can listen on 
the same socket ([2],[3]).
I am not familiar with kernel internals, so please correct me where I am 
wrong, and please point out any security holes,race conditions,coding style 
issues, etc.
Also please tell me if there are any (planned) internal kernel API changes 
that would need to change this patch to be changed for kernel 2.6.16.

First of all this is what I'd like to achieve:
- filter packets by the program who sent the packet
- filter packets by the program who is going to receive the packet
- when multiple programs share a socket (i.e. they listen on the same socket), 
allow the packet only if all programs are allowed to receive the packet

A program is identified by the mountpoint and the inode of the file.


Luke searched through all the files of all running threads to find out the 
process that sent the packet (which is pretty much the same what fireflier 
[4] does from userspace: searching /proc).
I tried using a different approach. The kernel has to know which processes 
listen on which sockets (and which processes send data on them), since it has 
to wake them up when a packet comes, right?

So I checked the wait_queue of a socket (sk_sleep, fasync_list) instead. This 
should contain all the programs that would be woken up by an incoming 
packets, so this should be a list of _all_ the programs that are able to read 
that packet. Is there a way for a program to read/send data on a socket 
without being on this list?

IMHO checking the wait_queue is the proper thing to do, because: 
- the performance doesn't depend on the number of threads running, it only 
depends on the number of processes sharing a socket
- it finds all programs that are going to read from the socket, even if it 
(the socket) is shared between multiple processes

Problems with the wait_queue:
- I based __authorize_programs on __wake_up, and __kill_fasync
      - it  duplicates code, and if something changes in those functions, that 
changes needs to be done here
      - in kernel 2.6.11 __wait_queue had a field named task, it has now been 
renamed to private. Does it mean that it shouldn't be accessed directly, but 
only through some functions? Which are those functions?
      - is there a better way to iterate through wait_queue_t? (without waking 
up the processes, I just need to know which those processes are)

Problems with the fasync_list:
- It only gives me the pid of the process (process group), so I need to lookup 
the task corresponding to the pid
- do I really need to check fasync_list too? If a process listens on a socket 
asynchronously, does it appear only in fasync_list, or does it appear in 
sk_sleep too?

Problems with proc_check_exe_fown:
- based on send_sigio
- I need to lock the task_list
	- task_list lock export might be gone some day?
	- is locking tasklist when inside a softirq allowed?
- I need to iterate through all the thread if I get a process group id, is 
there a better way?

Problems with proc_check_exe:
- kernel complains about proc_task_dentry_lookup might_sleep inside a softirq, 
how do I solve this?

Problems with proc_task_dentry_lookup:
- fs/proc/task_mmu.c,task_nommu.c, root.c had to be patched, so one has to 
recompile his kernel in order to make this inode-matching to work (I'd prefer 
if it could be loaded as a module, without recompiling the kernel)
- is there a function I missed that does what proc_task_dentry_lookup would 
do?
- where is the proper place to put this function?


I need this inode filtering done in-kernel, because:
- fireflier currently searches /proc for the first incoming/outgoing packet to 
find out which process sent it. Then it puts its pid in a cache
- when the next packet arrives it only checks if the process who's pid is in 
the cache still has the socket with the right inode, if yes the packet is 
allowed to pass
- if somebody floods with random destination ports, each packet triggers 
a /proc lookup -> slows down fireflier
- when multiple programs share a socket, fireflier only looks at the first
- if we were to find all the programs that share a socket from userspace, we 
would have to do so on every packet, since we can't know when a process 
decides to fork/share its socket

Please note that this patch is work in progress, it is not meant for immediate 
use. If you decide to experiment, you'll also need the iptables userspace 
patch [1]

[1] https://bugzilla.netfilter.org/bugzilla/show_bug.cgi?id=449
[2] http://www.uwsg.iu.edu/hypermail/linux/kernel/0409.1/0499.html
[3] http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/0068.html
[4] http://fireflier.sourceforge.net/

Thanks in advance,
Edwin
---
 fs/proc/root.c                           |    3
 fs/proc/task_mmu.c                       |    9 +
 fs/proc/task_nommu.c                     |    8 +
 include/linux/netfilter_ipv4/ipt_owner.h |    8 +
 net/ipv4/netfilter/ipt_owner.c           |  179 
++++++++++++++++++++++++++++++-
 5 files changed, 199 insertions(+), 8 deletions(-)
diff -uprN -X vanilla/linux-2.6.15.4/Documentation/dontdiff 
vanilla/linux-2.6.15.4/fs/proc/root.c linux-2.6.15.4/fs/proc/root.c
--- vanilla/linux-2.6.15.4/fs/proc/root.c	2006-02-10 09:22:48.000000000 +0200
+++ linux-2.6.15.4/fs/proc/root.c	2006-02-18 11:36:06.000000000 +0200
@@ -149,6 +149,8 @@ struct proc_dir_entry proc_root = {
 	.parent		= &proc_root,
 };
 
+extern int proc_task_dentry_lookup(struct task_struct *task, struct dentry 
**dentry, struct vfsmount **mnt);
+
 EXPORT_SYMBOL(proc_symlink);
 EXPORT_SYMBOL(proc_mkdir);
 EXPORT_SYMBOL(create_proc_entry);
@@ -159,3 +161,4 @@ EXPORT_SYMBOL(proc_net);
 EXPORT_SYMBOL(proc_net_stat);
 EXPORT_SYMBOL(proc_bus);
 EXPORT_SYMBOL(proc_root_driver);
+EXPORT_SYMBOL(proc_task_dentry_lookup);
diff -uprN -X vanilla/linux-2.6.15.4/Documentation/dontdiff 
vanilla/linux-2.6.15.4/fs/proc/task_mmu.c linux-2.6.15.4/fs/proc/task_mmu.c
--- vanilla/linux-2.6.15.4/fs/proc/task_mmu.c	2006-02-10 09:22:48.000000000 
+0200
+++ linux-2.6.15.4/fs/proc/task_mmu.c	2006-02-18 11:38:36.000000000 +0200
@@ -71,11 +71,11 @@ int task_statm(struct mm_struct *mm, int
 	return mm->total_vm;
 }
 
-int proc_exe_link(struct inode *inode, struct dentry **dentry, struct 
vfsmount **mnt)
+extern int proc_task_dentry_lookup(struct task_struct *task, struct dentry 
**dentry, struct vfsmount **mnt);
+int proc_task_dentry_lookup(struct task_struct *task, struct dentry **dentry, 
struct vfsmount **mnt)
 {
 	struct vm_area_struct * vma;
 	int result = -ENOENT;
-	struct task_struct *task = proc_task(inode);
 	struct mm_struct * mm = get_task_mm(task);
 
 	if (!mm)
@@ -101,6 +101,11 @@ out:
 	return result;
 }
 
+int proc_exe_link(struct inode *inode, struct dentry **dentry, struct 
vfsmount **mnt)
+{
+	return proc_task_dentry_lookup(proc_task(inode), dentry, mnt);
+}
+
 static void pad_len_spaces(struct seq_file *m, int len)
 {
 	len = 25 + sizeof(void*) * 6 - len;
diff -uprN -X vanilla/linux-2.6.15.4/Documentation/dontdiff 
vanilla/linux-2.6.15.4/fs/proc/task_nommu.c 
linux-2.6.15.4/fs/proc/task_nommu.c
--- vanilla/linux-2.6.15.4/fs/proc/task_nommu.c	2006-02-10 09:22:48.000000000 
+0200
+++ linux-2.6.15.4/fs/proc/task_nommu.c	2006-02-18 11:38:27.000000000 +0200
@@ -103,11 +103,11 @@ int task_statm(struct mm_struct *mm, int
 	return size;
 }
 
-int proc_exe_link(struct inode *inode, struct dentry **dentry, struct 
vfsmount **mnt)
+extern int proc_task_dentry_lookup(struct task_struct *task, struct dentry 
**dentry, struct vfsmount **mnt);
+int proc_task_dentry_lookup(struct task_struct *task, struct dentry **dentry, 
struct vfsmount **mnt)
 {
 	struct vm_list_struct *vml;
 	struct vm_area_struct *vma;
-	struct task_struct *task = proc_task(inode);
 	struct mm_struct *mm = get_task_mm(task);
 	int result = -ENOENT;
 
@@ -137,6 +137,10 @@ out:
 	return result;
 }
 
+int proc_exe_link(struct inode *inode, struct dentry **dentry, struct 
vfsmount **mnt)
+{
+	return proc_task_dentry_lookup(proc_task(inode), dentry, mnt);
+}
 /*
  * Albert D. Cahalan suggested to fake entries for the traditional
  * sections here.  This might be worth investigating.
diff -uprN -X vanilla/linux-2.6.15.4/Documentation/dontdiff 
vanilla/linux-2.6.15.4/include/linux/netfilter_ipv4/ipt_owner.h 
linux-2.6.15.4/include/linux/netfilter_ipv4/ipt_owner.h
--- vanilla/linux-2.6.15.4/include/linux/netfilter_ipv4/ipt_owner.h	2006-02-10 
09:22:48.000000000 +0200
+++ linux-2.6.15.4/include/linux/netfilter_ipv4/ipt_owner.h	2006-02-17 
21:39:41.000000000 +0200
@@ -7,6 +7,10 @@
 #define IPT_OWNER_PID	0x04
 #define IPT_OWNER_SID	0x08
 #define IPT_OWNER_COMM	0x10
+#define IPT_OWNER_INO   0x20
+#define IPT_OWNER_DEV   0x40
+
+#define IPT_DEVNAME_SZ  80
 
 struct ipt_owner_info {
     uid_t uid;
@@ -14,6 +18,10 @@ struct ipt_owner_info {
     pid_t pid;
     pid_t sid;
     char comm[16];
+    /* set these as a pair: specify the filesystem, specify the inode */
+    /* it's the only simple (and unambigous) way to reference a program */
+    char device[IPT_DEVNAME_SZ];
+    unsigned long ino;
     u_int8_t match, invert;	/* flags */
 };
 
diff -uprN -X vanilla/linux-2.6.15.4/Documentation/dontdiff 
vanilla/linux-2.6.15.4/net/ipv4/netfilter/ipt_owner.c 
linux-2.6.15.4/net/ipv4/netfilter/ipt_owner.c
--- vanilla/linux-2.6.15.4/net/ipv4/netfilter/ipt_owner.c	2006-02-10 
09:22:48.000000000 +0200
+++ linux-2.6.15.4/net/ipv4/netfilter/ipt_owner.c	2006-02-18 
11:48:44.000000000 +0200
@@ -1,7 +1,21 @@
 /* Kernel module to match various things tied to sockets associated with
-   locally generated outgoing packets. */
+ locally generated outgoing packets.
+ lkcl 2004sep9: match against filesystem on which program handling the
+                packet can be found (IPT_OWNER_DEV) and also the inode
+                on that filesystem of that same program.
+
+                why anyone would want to only check just the mountpoint
+				  i don't know (well, i do - e.g. /usr/local is a
+				  separate untrusted or even an nfs-mounted partition)
+				  but i had to include and check the mountpoint because
+				  otherwise the inode is meaningless.
+edwin 2006feb17: use the wait queue of the socket instead of walking through 
the tasklist
+                 this should allow ipt_owner to be used for incoming packets 
as well
+*/
 
 /* (C) 2000 Marc Boucher <marc@mbsi.ca>
+ * (C) 2004 Luke Kenneth Casson Leighton <lkcl@lkcl.net>
+ * (C) 2006 Torok Edwin <edwin@gurde.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -17,10 +31,157 @@
 #include <linux/netfilter_ipv4/ipt_owner.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/dcache.h>
+#include <linux/string.h>
+#include <linux/sched.h>
+#include <linux/rwsem.h>
+#include <linux/spinlock.h>
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Marc Boucher <marc@mbsi.ca>");
 MODULE_DESCRIPTION("iptables owner match");
 
+/* lkcl: this function is in fs/proc/base.c.  it's a generic function
+ * derived from proc_exe_link().  it's inappropriate to leave that
+ * function in fs/proc/base.c.  but i don't care: i don't have the
+ * knowledge to say where it should go.  therefore i'm leaving
+ * it in fs/proc/base.c.
+*/
+extern int proc_task_dentry_lookup(struct task_struct *task,
+		                           struct dentry **dentry,
+								   struct vfsmount **mnt);
+/*
+ * look up the dentry (for the inode) of the task's executable,
+ * plus lookup the mountpoint of the filesystem from where that
+ * executable came from.   then do exactly the same socket checking
+ * that all the other checks seem to be doing.
+ * returns 0 if program is authorized
+*/
+static int proc_exe_check(struct task_struct* task,u_int8_t match,
+			  const char *devname, unsigned long i_num)
+{
+	int result = -ENOENT;
+	struct vfsmount *mnt;
+	struct dentry *dentry;
+	printk(KERN_DEBUG "proc_exe_check:%s\n",task->comm);
+	result = proc_task_dentry_lookup(task, &dentry, &mnt);
+	if (result != 0) {
+		printk(KERN_DEBUG "proc_task_dentry_lookup error:%d\n",result);
+		return result;
+	}
+
+	if (!dentry->d_inode) {
+		printk(KERN_DEBUG "dentry inode not found\n");
+		return -ENOENT;
+	}
+
+	/* lkcl: i can't be bothered to make obtuse code out of some
+	 * boolean overkill logic cleverness.
+	 */
+	if (match & IPT_OWNER_INO && match & IPT_OWNER_DEV)
+		if (dentry->d_inode->i_ino == i_num &&
+		    strncmp(mnt->mnt_devname, devname, IPT_DEVNAME_SZ) == 0) {
+                        printk(KERN_DEBUG "if(1) return 0");
+			return 0;
+		}
+	if (match & IPT_OWNER_INO)
+		if (dentry->d_inode->i_ino == i_num) {
+                        printk(KERN_DEBUG "if(2) return 0");
+			return 0;
+		}
+	if (match & IPT_OWNER_DEV)
+		if (strncmp(mnt->mnt_devname, devname, IPT_DEVNAME_SZ) == 0) {
+                        printk(KERN_DEBUG "if(3) return 0");
+			return 0;
+		}
+	printk(KERN_DEBUG "proc_exe_check: ENOENT");
+	return -ENOENT;
+}
+
+//check that the process or process group is authorized (process in 
fasync_list)
+static int proc_exe_check_fown(struct fown_struct* fown,u_int8_t match,
+			       const char *devname, unsigned long i_num)
+{
+	//based on send_sigio
+	struct task_struct* task;
+	int pid;
+	int result=-ENOENT;
+
+	read_lock(&fown->lock);
+	pid=fown->pid;
+	if(!pid)
+		goto out_unlock_fown;
+	read_lock(&tasklist_lock);
+	if(pid>0)
+	{
+		task = find_task_by_pid(pid);
+		if(task)
+			if(proc_exe_check(task,match,devname,i_num))
+			{
+				result=-ENOENT;
+				goto out_unlock_tasklist;
+			}
+	} else
+	{
+		do_each_task_pid(~pid,PIDTYPE_PGID,task)
+		{
+			if(proc_exe_check(task,match,devname,i_num))
+			{
+				result=-ENOENT;
+				goto out_unlock_tasklist;
+			}
+		} while_each_task_pid(~pid,PIDTYPE_PGID,task);
+	}
+	result=0;
+	out_unlock_tasklist:
+		read_unlock(&tasklist_lock);
+	out_unlock_fown:
+		read_unlock(&fown->lock);
+        return result;
+}
+
+static int __authorize_programs(struct sock* sk, u_int8_t match,
+				const char* devname, unsigned long i_num)
+{
+	//walk through all tasks that would be awakened, based on __wake_up
+	wait_queue_head_t* q = sk->sk_sleep;
+	struct list_head* tmp,*next;
+        struct fasync_struct* fa;
+	list_for_each_safe(tmp, next, &q->task_list)
+	{
+		wait_queue_t *curr;
+		curr = list_entry(tmp, wait_queue_t, task_list);
+		if(proc_exe_check(curr->private,match,devname,i_num))
+			return 0;
+	}
+	//walk through fasync_list, based on __kill_fasync
+	fa = sk->sk_socket->fasync_list;
+	while (fa)
+	{
+		struct fown_struct * fown;
+		if (fa->magic != FASYNC_MAGIC)
+		{
+			printk(KERN_ERR "kill_fasync: bad magic number in "
+			       "fasync_struct!\n");
+			return 0;
+		}
+		fown = &fa->fa_file->f_owner;
+		if(proc_exe_check_fown(fown,match,devname,i_num))
+			return 0;
+		fa = fa->fa_next;
+	}
+	return 1;//authorized all programs
+}
+
+static int
+match_inode(const struct sk_buff* skb,u_int8_t match,const char* 
devname,unsigned long i_num)
+{
+	return __authorize_programs(skb->sk,match,devname,i_num);
+}
+
+
 static int
 match(const struct sk_buff *skb,
       const struct net_device *in,
@@ -46,6 +207,14 @@ match(const struct sk_buff *skb,
 			return 0;
 	}
 
+	if (info->match & IPT_OWNER_INO || info->match & IPT_OWNER_DEV)
+	{
+	    if(!match_inode(skb,info->match,info->device,info->ino)^
+	       !!(info->invert & IPT_OWNER_INO)) {
+		    return 0;
+	    }
+	}
+
 	return 1;
 }
 
@@ -75,7 +244,7 @@ checkentry(const char *tablename,
 		       "not supported anymore\n");
 		return 0;
 	}
-
+   
 	return 1;
 }
 
@@ -88,12 +257,14 @@ static struct ipt_match owner_match = {
 
 static int __init init(void)
 {
-	return ipt_register_match(&owner_match);
+    printk(KERN_DEBUG "ipt_owner (with enhanced inode rules) startup\n");
+    return ipt_register_match(&owner_match);
 }
 
 static void __exit fini(void)
 {
-	ipt_unregister_match(&owner_match);
+    printk(KERN_DEBUG "ipt_owner shutdown");
+    ipt_unregister_match(&owner_match);
 }
 
 module_init(init);
