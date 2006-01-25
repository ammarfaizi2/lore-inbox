Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWAYRDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWAYRDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWAYRDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:03:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:17855 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932070AbWAYRDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:03:06 -0500
Date: Wed, 25 Jan 2006 18:03:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: [patch, validator] fix proc_subdir_lock related deadlock
Message-ID: <20060125170331.GA29339@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

proc_subdir_lock can also be used from softirq (tasklet) context, which 
may lead to deadlocks.

This bug was found via the lock validator:

  ============================
  [ BUG: illegal lock usage! ]
  ----------------------------
  illegal {enabled-softirqs} -> {used-in-softirq} usage.
  ifup/2283 [HC0[0]:SC1[2]:HE1:SE0] takes {proc_subdir_lock [u:25]}, at:
   [<c0196363>] remove_proc_entry+0x33/0x1f0
  {enabled-softirqs} state was registered at:
   [<c04d7c0d>] _spin_unlock_bh+0xd/0x10
  hardirqs last enabled at: [<c04d7bb5>] _spin_unlock_irqrestore+0x25/0x30
  softirqs last enabled at: [<c0127624>] free_uid+0x24/0x80
  
  other info that might help in debugging this:
  ------------------------------
  | showing all locks held by: |  (ifup/2283 [c31a6790, 125]):
  ------------------------------
  
   [<c010432d>] show_trace+0xd/0x10
   [<c0104347>] dump_stack+0x17/0x20
   [<c0137181>] print_usage_bug+0x1e1/0x200
   [<c0137739>] mark_lock+0x259/0x290
   [<c0137bd5>] debug_lock_chain_spin+0x465/0x10f0
   [<c0264a6d>] _raw_spin_lock+0x2d/0x90
   [<c04d7a18>] _spin_lock+0x8/0x10
   [<c0196363>] remove_proc_entry+0x33/0x1f0
   [<c0141d79>] unregister_handler_proc+0x19/0x20
   [<c014153b>] free_irq+0x7b/0xe0
   [<c02f15e2>] floppy_release_irq_and_dma+0x1b2/0x210
   [<c02efad7>] set_dor+0xc7/0x1b0
   [<c02f2b51>] motor_off_callback+0x21/0x30
   [<c01272b5>] run_timer_softirq+0xf5/0x1f0
   [<c0122c17>] __do_softirq+0x87/0x120
   [<c0105519>] do_softirq+0x69/0xb0
   =======================

the way i fixed this bug was to make all uses of the proc_subdir_lock 
softirq-safe. Alternatively, we may want to forbid the use of this lock 
(and remove_proc_entry()) from softirq contexts - but a quick glance 
showed that quite some drivers are affected, and it would need a full 
review to make sure the block is never taken from a softirq context. So 
this seemed the safest fix.

the patched 2.6.16-rc1-mm1 kernel now passes validation.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 fs/proc/generic.c      |   34 +++++++++++++++++++---------------
 fs/proc/proc_devtree.c |    4 ++--
 2 files changed, 21 insertions(+), 17 deletions(-)

Index: linux/fs/proc/generic.c
===================================================================
--- linux.orig/fs/proc/generic.c
+++ linux/fs/proc/generic.c
@@ -30,6 +30,10 @@ static ssize_t proc_file_write(struct fi
 			       size_t count, loff_t *ppos);
 static loff_t proc_file_lseek(struct file *, loff_t, int);
 
+/*
+ * Is mostly used from process, but can occasionally be used from
+ * softirq context too - hence all locking must be softirq-safe:
+ */
 DEFINE_SPINLOCK(proc_subdir_lock);
 
 int proc_match(int len, const char *name, struct proc_dir_entry *de)
@@ -282,7 +286,7 @@ static int xlate_proc_name(const char *n
 	int			len;
 	int 			rtn = 0;
 
-	spin_lock(&proc_subdir_lock);
+	spin_lock_bh(&proc_subdir_lock);
 	de = &proc_root;
 	while (1) {
 		next = strchr(cp, '/');
@@ -303,7 +307,7 @@ static int xlate_proc_name(const char *n
 	*residual = cp;
 	*ret = de;
 out:
-	spin_unlock(&proc_subdir_lock);
+	spin_unlock_bh(&proc_subdir_lock);
 	return rtn;
 }
 
@@ -389,7 +393,7 @@ struct dentry *proc_lookup(struct inode 
 	int error = -ENOENT;
 
 	lock_kernel();
-	spin_lock(&proc_subdir_lock);
+	spin_lock_bh(&proc_subdir_lock);
 	de = PDE(dir);
 	if (de) {
 		for (de = de->subdir; de ; de = de->next) {
@@ -398,15 +402,15 @@ struct dentry *proc_lookup(struct inode 
 			if (!memcmp(dentry->d_name.name, de->name, de->namelen)) {
 				unsigned int ino = de->low_ino;
 
-				spin_unlock(&proc_subdir_lock);
+				spin_unlock_bh(&proc_subdir_lock);
 				error = -EINVAL;
 				inode = proc_get_inode(dir->i_sb, ino, de);
-				spin_lock(&proc_subdir_lock);
+				spin_lock_bh(&proc_subdir_lock);
 				break;
 			}
 		}
 	}
-	spin_unlock(&proc_subdir_lock);
+	spin_unlock_bh(&proc_subdir_lock);
 	unlock_kernel();
 
 	if (inode) {
@@ -460,13 +464,13 @@ int proc_readdir(struct file * filp,
 			filp->f_pos++;
 			/* fall through */
 		default:
-			spin_lock(&proc_subdir_lock);
+			spin_lock_bh(&proc_subdir_lock);
 			de = de->subdir;
 			i -= 2;
 			for (;;) {
 				if (!de) {
 					ret = 1;
-					spin_unlock(&proc_subdir_lock);
+					spin_unlock_bh(&proc_subdir_lock);
 					goto out;
 				}
 				if (!i)
@@ -477,15 +481,15 @@ int proc_readdir(struct file * filp,
 
 			do {
 				/* filldir passes info to user space */
-				spin_unlock(&proc_subdir_lock);
+				spin_unlock_bh(&proc_subdir_lock);
 				if (filldir(dirent, de->name, de->namelen, filp->f_pos,
 					    de->low_ino, de->mode >> 12) < 0)
 					goto out;
-				spin_lock(&proc_subdir_lock);
+				spin_lock_bh(&proc_subdir_lock);
 				filp->f_pos++;
 				de = de->next;
 			} while (de);
-			spin_unlock(&proc_subdir_lock);
+			spin_unlock_bh(&proc_subdir_lock);
 	}
 	ret = 1;
 out:	unlock_kernel();
@@ -520,11 +524,11 @@ static int proc_register(struct proc_dir
 		return -EAGAIN;
 	dp->low_ino = i;
 
-	spin_lock(&proc_subdir_lock);
+	spin_lock_bh(&proc_subdir_lock);
 	dp->next = dir->subdir;
 	dp->parent = dir;
 	dir->subdir = dp;
-	spin_unlock(&proc_subdir_lock);
+	spin_unlock_bh(&proc_subdir_lock);
 
 	if (S_ISDIR(dp->mode)) {
 		if (dp->proc_iops == NULL) {
@@ -718,7 +722,7 @@ void remove_proc_entry(const char *name,
 		goto out;
 	len = strlen(fn);
 
-	spin_lock(&proc_subdir_lock);
+	spin_lock_bh(&proc_subdir_lock);
 	for (p = &parent->subdir; *p; p=&(*p)->next ) {
 		if (!proc_match(len, fn, *p))
 			continue;
@@ -739,7 +743,7 @@ void remove_proc_entry(const char *name,
 		}
 		break;
 	}
-	spin_unlock(&proc_subdir_lock);
+	spin_unlock_bh(&proc_subdir_lock);
 out:
 	return;
 }
Index: linux/fs/proc/proc_devtree.c
===================================================================
--- linux.orig/fs/proc/proc_devtree.c
+++ linux/fs/proc/proc_devtree.c
@@ -136,11 +136,11 @@ void proc_device_tree_add_node(struct de
 		 * properties are quite unimportant for us though, thus we
 		 * simply "skip" them here, but we do have to check.
 		 */
-		spin_lock(&proc_subdir_lock);
+		spin_lock_bh(&proc_subdir_lock);
 		for (ent = de->subdir; ent != NULL; ent = ent->next)
 			if (!strcmp(ent->name, pp->name))
 				break;
-		spin_unlock(&proc_subdir_lock);
+		spin_unlock_bh(&proc_subdir_lock);
 		if (ent != NULL) {
 			printk(KERN_WARNING "device-tree: property \"%s\" name"
 			       " conflicts with node in %s\n", pp->name,
