Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319039AbSIDDqi>; Tue, 3 Sep 2002 23:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319041AbSIDDqh>; Tue, 3 Sep 2002 23:46:37 -0400
Received: from dp.samba.org ([66.70.73.150]:62166 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319039AbSIDDqe>;
	Tue, 3 Sep 2002 23:46:34 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2/2 daemonize calls reparent_to_init() cleanup
Date: Wed, 04 Sep 2002 13:51:08 +1000
Message-Id: <20020904035108.8DA012C057@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: daemonize() calls reparent_to_init cleanup
Author: Rusty Russell
Status: Cleanup

D: This makes daemonize() call reparent_to_init() itself, as long
D: suggested for 2.5, and fixes the callers so they don't call it again.
D: Also fixes callers which set current->tty to NULL themselves (also
D: no longer neccessary).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/kernel/exit.c .32153-linux-2.5.33.updated/kernel/exit.c
--- .32153-linux-2.5.33/kernel/exit.c	2002-09-01 12:23:08.000000000 +1000
+++ .32153-linux-2.5.33.updated/kernel/exit.c	2002-09-04 13:41:26.000000000 +1000
@@ -233,6 +233,8 @@ void daemonize(void)
  	exit_files(current);
 	current->files = init_task.files;
 	atomic_inc(&current->files->count);
+
+	reparent_to_init();
 }
 
 static void reparent_thread(task_t *p, task_t *reaper, task_t *child_reaper)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/kernel/ksyms.c .32153-linux-2.5.33.updated/kernel/ksyms.c
--- .32153-linux-2.5.33/kernel/ksyms.c	2002-09-01 12:23:08.000000000 +1000
+++ .32153-linux-2.5.33.updated/kernel/ksyms.c	2002-09-04 13:44:12.000000000 +1000
@@ -524,7 +524,6 @@ EXPORT_SYMBOL(secure_tcp_sequence_number
 EXPORT_SYMBOL(get_random_bytes);
 EXPORT_SYMBOL(securebits);
 EXPORT_SYMBOL(cap_bset);
-EXPORT_SYMBOL(reparent_to_init);
 EXPORT_SYMBOL(daemonize);
 EXPORT_SYMBOL(csum_partial); /* for networking and md */
 EXPORT_SYMBOL(seq_escape);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/drivers/char/hvc_console.c .32153-linux-2.5.33.updated/drivers/char/hvc_console.c
--- .32153-linux-2.5.33/drivers/char/hvc_console.c	2002-08-28 09:29:44.000000000 +1000
+++ .32153-linux-2.5.33.updated/drivers/char/hvc_console.c	2002-09-04 13:44:19.000000000 +1000
@@ -232,7 +232,6 @@ int khvcd(void *unused)
 	int i;
 
 	daemonize();
-	reparent_to_init();
 	strcpy(current->comm, "khvcd");
 	sigfillset(&current->blocked);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/drivers/hotplug/ibmphp_hpc.c .32153-linux-2.5.33.updated/drivers/hotplug/ibmphp_hpc.c
--- .32153-linux-2.5.33/drivers/hotplug/ibmphp_hpc.c	2002-06-09 17:22:48.000000000 +1000
+++ .32153-linux-2.5.33.updated/drivers/hotplug/ibmphp_hpc.c	2002-09-04 13:41:26.000000000 +1000
@@ -1025,7 +1025,6 @@ static int hpc_poll_thread (void *data)
 	debug ("%s - Entry\n", __FUNCTION__);
 	lock_kernel ();
 	daemonize ();
-	reparent_to_init ();
 
 	//  New name
 	strcpy (current->comm, "hpc_poll");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/drivers/md/md.c .32153-linux-2.5.33.updated/drivers/md/md.c
--- .32153-linux-2.5.33/drivers/md/md.c	2002-08-28 09:29:46.000000000 +1000
+++ .32153-linux-2.5.33.updated/drivers/md/md.c	2002-09-04 13:44:24.000000000 +1000
@@ -2486,7 +2486,6 @@ int md_thread(void * arg)
 	 */
 
 	daemonize();
-	reparent_to_init();
 
 	sprintf(current->comm, thread->name);
 	current->exit_signal = SIGCHLD;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/drivers/mtd/devices/blkmtd.c .32153-linux-2.5.33.updated/drivers/mtd/devices/blkmtd.c
--- .32153-linux-2.5.33/drivers/mtd/devices/blkmtd.c	2002-09-01 12:23:01.000000000 +1000
+++ .32153-linux-2.5.33.updated/drivers/mtd/devices/blkmtd.c	2002-09-04 13:41:26.000000000 +1000
@@ -304,7 +304,6 @@ static int write_queue_task(void *data)
   DEBUG(1, "blkmtd: writetask: starting (pid = %d)\n", tsk->pid);
   daemonize();
   strcpy(tsk->comm, "blkmtdd");
-  tsk->tty = NULL;
   spin_lock_irq(&tsk->sigmask_lock);
   sigfillset(&tsk->blocked);
   recalc_sigpending();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/drivers/net/8139too.c .32153-linux-2.5.33.updated/drivers/net/8139too.c
--- .32153-linux-2.5.33/drivers/net/8139too.c	2002-09-01 12:23:01.000000000 +1000
+++ .32153-linux-2.5.33.updated/drivers/net/8139too.c	2002-09-04 13:41:26.000000000 +1000
@@ -1582,8 +1582,7 @@ static int rtl8139_thread (void *data)
 	struct rtl8139_private *tp = dev->priv;
 	unsigned long timeout;
 
-	daemonize ();
-	reparent_to_init();
+	daemonize();
 	spin_lock_irq(&current->sigmask_lock);
 	sigemptyset(&current->blocked);
 	recalc_sigpending();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/drivers/pnp/pnpbios_core.c .32153-linux-2.5.33.updated/drivers/pnp/pnpbios_core.c
--- .32153-linux-2.5.33/drivers/pnp/pnpbios_core.c	2002-08-28 09:29:46.000000000 +1000
+++ .32153-linux-2.5.33.updated/drivers/pnp/pnpbios_core.c	2002-09-04 13:41:26.000000000 +1000
@@ -612,7 +612,6 @@ static int pnp_dock_thread(void * unused
 	static struct pnp_docking_station_info now;
 	int docked = -1, d = 0;
 	daemonize();
-	reparent_to_init();
 	strcpy(current->comm, "kpnpbiosd");
 	while(!unloading && !signal_pending(current))
 	{
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/drivers/scsi/scsi_error.c .32153-linux-2.5.33.updated/drivers/scsi/scsi_error.c
--- .32153-linux-2.5.33/drivers/scsi/scsi_error.c	2002-08-02 11:15:09.000000000 +1000
+++ .32153-linux-2.5.33.updated/drivers/scsi/scsi_error.c	2002-09-04 13:44:22.000000000 +1000
@@ -1878,7 +1878,6 @@ void scsi_error_handler(void *data)
 	 */
 
 	daemonize();
-	reparent_to_init();
 
 	/*
 	 * Set the name of this process.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/drivers/usb/storage/usb.c .32153-linux-2.5.33.updated/drivers/usb/storage/usb.c
--- .32153-linux-2.5.33/drivers/usb/storage/usb.c	2002-08-28 09:29:47.000000000 +1000
+++ .32153-linux-2.5.33.updated/drivers/usb/storage/usb.c	2002-09-04 13:41:26.000000000 +1000
@@ -309,7 +309,6 @@ static int usb_stor_control_thread(void 
 	 * so get rid of all our resources..
 	 */
 	daemonize();
-	reparent_to_init();
 
 	/* avoid getting signals */
 	spin_lock_irq(&current->sigmask_lock);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/fs/jffs2/background.c .32153-linux-2.5.33.updated/fs/jffs2/background.c
--- .32153-linux-2.5.33/fs/jffs2/background.c	2002-08-02 11:15:09.000000000 +1000
+++ .32153-linux-2.5.33.updated/fs/jffs2/background.c	2002-09-04 13:41:26.000000000 +1000
@@ -83,7 +83,6 @@ static int jffs2_garbage_collect_thread(
 	struct jffs2_sb_info *c = _c;
 
 	daemonize();
-	current->tty = NULL;
 	c->gc_task = current;
 	up(&c->gc_thread_start);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/fs/jfs/jfs_logmgr.c .32153-linux-2.5.33.updated/fs/jfs/jfs_logmgr.c
--- .32153-linux-2.5.33/fs/jfs/jfs_logmgr.c	2002-09-01 12:23:04.000000000 +1000
+++ .32153-linux-2.5.33.updated/fs/jfs/jfs_logmgr.c	2002-09-04 13:41:26.000000000 +1000
@@ -2114,7 +2114,6 @@ int jfsIOWait(void *arg)
 	lock_kernel();
 
 	daemonize();
-	current->tty = NULL;
 	strcpy(current->comm, "jfsIO");
 
 	unlock_kernel();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/fs/jfs/jfs_txnmgr.c .32153-linux-2.5.33.updated/fs/jfs/jfs_txnmgr.c
--- .32153-linux-2.5.33/fs/jfs/jfs_txnmgr.c	2002-09-01 12:23:04.000000000 +1000
+++ .32153-linux-2.5.33.updated/fs/jfs/jfs_txnmgr.c	2002-09-04 13:41:26.000000000 +1000
@@ -2763,7 +2763,6 @@ int jfs_lazycommit(void *arg)
 	lock_kernel();
 
 	daemonize();
-	current->tty = NULL;
 	strcpy(current->comm, "jfsCommit");
 
 	unlock_kernel();
@@ -2961,7 +2960,6 @@ int jfs_sync(void *arg)
 	lock_kernel();
 
 	daemonize();
-	current->tty = NULL;
 	strcpy(current->comm, "jfsSync");
 
 	unlock_kernel();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/fs/lockd/clntlock.c .32153-linux-2.5.33.updated/fs/lockd/clntlock.c
--- .32153-linux-2.5.33/fs/lockd/clntlock.c	2002-05-24 15:20:28.000000000 +1000
+++ .32153-linux-2.5.33.updated/fs/lockd/clntlock.c	2002-09-04 13:41:26.000000000 +1000
@@ -202,7 +202,6 @@ reclaimer(void *ptr)
 	struct inode *inode;
 
 	daemonize();
-	reparent_to_init();
 	snprintf(current->comm, sizeof(current->comm),
 		 "%s-reclaim",
 		 host->h_name);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/fs/lockd/svc.c .32153-linux-2.5.33.updated/fs/lockd/svc.c
--- .32153-linux-2.5.33/fs/lockd/svc.c	2002-09-01 12:23:05.000000000 +1000
+++ .32153-linux-2.5.33.updated/fs/lockd/svc.c	2002-09-04 13:41:26.000000000 +1000
@@ -98,7 +98,6 @@ lockd(struct svc_rqst *rqstp)
 	up(&lockd_start);
 
 	daemonize();
-	reparent_to_init();
 	sprintf(current->comm, "lockd");
 
 	/* Process request with signals blocked.  */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32153-linux-2.5.33/mm/pdflush.c .32153-linux-2.5.33.updated/mm/pdflush.c
--- .32153-linux-2.5.33/mm/pdflush.c	2002-07-07 02:12:24.000000000 +1000
+++ .32153-linux-2.5.33.updated/mm/pdflush.c	2002-09-04 13:41:26.000000000 +1000
@@ -88,7 +88,6 @@ struct pdflush_work {
 static int __pdflush(struct pdflush_work *my_work)
 {
 	daemonize();
-	reparent_to_init();
 	strcpy(current->comm, "pdflush");
 
 	/* interruptible sleep, so block all signals */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
