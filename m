Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSE3FBW>; Thu, 30 May 2002 01:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSE3FBV>; Thu, 30 May 2002 01:01:21 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:43430 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316309AbSE3FBU>; Thu, 30 May 2002 01:01:20 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.19 daemonize calls reparent_init for you
Date: Thu, 30 May 2002 15:05:07 +1000
Message-Id: <E17DI7X-00030e-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daemonize() should call reparent_to_init: a classic mistake (I made it
recently).

Future potential cleanups:
	daemonize() should take mask of signals to allow
	kernel_thread() should take a name to copy into ->comm.

Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/kernel/exit.c linux-2.5.19.11306.updated/kernel/exit.c
--- linux-2.5.19.11306/kernel/exit.c	Thu May 30 10:00:59 2002
+++ linux-2.5.19.11306.updated/kernel/exit.c	Thu May 30 14:57:33 2002
@@ -227,6 +227,8 @@
  	exit_files(current);
 	current->files = init_task.files;
 	atomic_inc(&current->files->count);
+
+	reparent_to_init();
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/drivers/hotplug/ibmphp_hpc.c linux-2.5.19.11306.updated/drivers/hotplug/ibmphp_hpc.c
--- linux-2.5.19.11306/drivers/hotplug/ibmphp_hpc.c	Mon May 13 12:00:35 2002
+++ linux-2.5.19.11306.updated/drivers/hotplug/ibmphp_hpc.c	Thu May 30 14:57:32 2002
@@ -1029,7 +1029,6 @@
 	debug ("%s - Entry\n", __FUNCTION__);
 	lock_kernel ();
 	daemonize ();
-	reparent_to_init ();
 
 	//  New name
 	strcpy (current->comm, "hpc_poll");
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/drivers/mtd/devices/blkmtd.c linux-2.5.19.11306.updated/drivers/mtd/devices/blkmtd.c
--- linux-2.5.19.11306/drivers/mtd/devices/blkmtd.c	Mon May  6 11:11:54 2002
+++ linux-2.5.19.11306.updated/drivers/mtd/devices/blkmtd.c	Thu May 30 14:57:32 2002
@@ -305,7 +305,6 @@
   DEBUG(1, "blkmtd: writetask: starting (pid = %d)\n", tsk->pid);
   daemonize();
   strcpy(tsk->comm, "blkmtdd");
-  tsk->tty = NULL;
   spin_lock_irq(&tsk->sigmask_lock);
   sigfillset(&tsk->blocked);
   recalc_sigpending();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/drivers/net/8139too.c linux-2.5.19.11306.updated/drivers/net/8139too.c
--- linux-2.5.19.11306/drivers/net/8139too.c	Sun May 19 12:07:30 2002
+++ linux-2.5.19.11306.updated/drivers/net/8139too.c	Thu May 30 14:57:32 2002
@@ -1556,8 +1556,7 @@
 	struct rtl8139_private *tp = dev->priv;
 	unsigned long timeout;
 
-	daemonize ();
-	reparent_to_init();
+	daemonize();
 	spin_lock_irq(&current->sigmask_lock);
 	sigemptyset(&current->blocked);
 	recalc_sigpending();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/drivers/pnp/pnpbios_core.c linux-2.5.19.11306.updated/drivers/pnp/pnpbios_core.c
--- linux-2.5.19.11306/drivers/pnp/pnpbios_core.c	Sat May 25 14:34:46 2002
+++ linux-2.5.19.11306.updated/drivers/pnp/pnpbios_core.c	Thu May 30 14:57:32 2002
@@ -610,7 +610,6 @@
 	static struct pnp_docking_station_info now;
 	int docked = -1, d = 0;
 	daemonize();
-	reparent_to_init();
 	strcpy(current->comm, "kpnpbiosd");
 	while(!unloading && !signal_pending(current))
 	{
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/drivers/usb/storage/usb.c linux-2.5.19.11306.updated/drivers/usb/storage/usb.c
--- linux-2.5.19.11306/drivers/usb/storage/usb.c	Thu May 30 10:00:55 2002
+++ linux-2.5.19.11306.updated/drivers/usb/storage/usb.c	Thu May 30 14:57:32 2002
@@ -317,7 +317,6 @@
 	 * so get rid of all our resources..
 	 */
 	daemonize();
-	reparent_to_init();
 
 	/* avoid getting signals */
 	spin_lock_irq(&current->sigmask_lock);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/fs/jffs2/background.c linux-2.5.19.11306.updated/fs/jffs2/background.c
--- linux-2.5.19.11306/fs/jffs2/background.c	Thu Mar 21 14:14:51 2002
+++ linux-2.5.19.11306.updated/fs/jffs2/background.c	Thu May 30 14:57:32 2002
@@ -100,7 +100,6 @@
 	struct jffs2_sb_info *c = _c;
 
 	daemonize();
-	current->tty = NULL;
 	c->gc_task = current;
 	up(&c->gc_thread_start);
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/fs/jfs/jfs_logmgr.c linux-2.5.19.11306.updated/fs/jfs/jfs_logmgr.c
--- linux-2.5.19.11306/fs/jfs/jfs_logmgr.c	Sat May 25 14:34:51 2002
+++ linux-2.5.19.11306.updated/fs/jfs/jfs_logmgr.c	Thu May 30 14:57:32 2002
@@ -2148,7 +2148,6 @@
 	lock_kernel();
 
 	daemonize();
-	current->tty = NULL;
 	strcpy(current->comm, "jfsIO");
 
 	unlock_kernel();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/fs/jfs/jfs_txnmgr.c linux-2.5.19.11306.updated/fs/jfs/jfs_txnmgr.c
--- linux-2.5.19.11306/fs/jfs/jfs_txnmgr.c	Tue May 21 16:33:35 2002
+++ linux-2.5.19.11306.updated/fs/jfs/jfs_txnmgr.c	Thu May 30 14:57:33 2002
@@ -2771,7 +2771,6 @@
 	lock_kernel();
 
 	daemonize();
-	current->tty = NULL;
 	strcpy(current->comm, "jfsCommit");
 
 	unlock_kernel();
@@ -2895,7 +2894,6 @@
 	lock_kernel();
 
 	daemonize();
-	current->tty = NULL;
 	strcpy(current->comm, "jfsSync");
 
 	unlock_kernel();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/fs/lockd/clntlock.c linux-2.5.19.11306.updated/fs/lockd/clntlock.c
--- linux-2.5.19.11306/fs/lockd/clntlock.c	Wed Feb 20 17:56:39 2002
+++ linux-2.5.19.11306.updated/fs/lockd/clntlock.c	Thu May 30 14:57:33 2002
@@ -202,7 +202,6 @@
 	struct inode *inode;
 
 	daemonize();
-	reparent_to_init();
 	snprintf(current->comm, sizeof(current->comm),
 		 "%s-reclaim",
 		 host->h_name);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/fs/lockd/svc.c linux-2.5.19.11306.updated/fs/lockd/svc.c
--- linux-2.5.19.11306/fs/lockd/svc.c	Mon Apr 15 11:47:40 2002
+++ linux-2.5.19.11306.updated/fs/lockd/svc.c	Thu May 30 14:57:33 2002
@@ -98,7 +98,6 @@
 	up(&lockd_start);
 
 	daemonize();
-	reparent_to_init();
 	sprintf(current->comm, "lockd");
 
 	/* Process request with signals blocked.  */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19.11306/mm/pdflush.c linux-2.5.19.11306.updated/mm/pdflush.c
--- linux-2.5.19.11306/mm/pdflush.c	Thu May 30 10:00:59 2002
+++ linux-2.5.19.11306.updated/mm/pdflush.c	Thu May 30 14:57:33 2002
@@ -82,7 +82,6 @@
 static int __pdflush(struct pdflush_work *my_work)
 {
 	daemonize();
-	reparent_to_init();
 	strcpy(current->comm, "pdflush");
 
 	/* interruptible sleep, so block all signals */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
