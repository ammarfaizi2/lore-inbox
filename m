Return-Path: <linux-kernel-owner+w=401wt.eu-S932721AbWLNNmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbWLNNmI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWLNNmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:42:08 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:59380
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932725AbWLNNmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:42:07 -0500
Date: Thu, 14 Dec 2006 05:41:59 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: [PATCH 4/5] lock stat kills lock meter for -rt (annotations)
Message-ID: <20061214134159.GD22194@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Rough annotations to speed up the object attachment logic.

bill


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="annotation.diff"

============================================================
--- arch/xtensa/platform-iss/network.c	eee47b0ca011d1c327ce7aff0c9a7547695d3a1f
+++ arch/xtensa/platform-iss/network.c	76b16d29a46677a45d56b64983e0783959aa2160
@@ -648,6 +648,8 @@ static int iss_net_configure(int index, 
 		.have_mac		= 0,
 		});
 
+	spin_lock_init(&lp->lock);
+
 	/*
 	 * Try all transport protocols.
 	 * Note: more protocols can be added by adding '&& !X_init(lp, eth)'.
============================================================
--- fs/dcache.c	20226054e6d6b080847e7a892d0b47a7ad042288
+++ fs/dcache.c	64d2b2b78b50dc2da7e409f2a9721b80c8fbbaf3
@@ -884,7 +884,7 @@ struct dentry *d_alloc(struct dentry * p
 
 	atomic_set(&dentry->d_count, 1);
 	dentry->d_flags = DCACHE_UNHASHED;
-	spin_lock_init(&dentry->d_lock);
+	spin_lock_init_annotated(&dentry->d_lock, &_lock_stat_d_alloc_entry);
 	dentry->d_inode = NULL;
 	dentry->d_parent = NULL;
 	dentry->d_sb = NULL;
============================================================
--- fs/xfs/support/ktrace.c	1136cf72f9273718da47405b594caebaa59b66d3
+++ fs/xfs/support/ktrace.c	122729d6084fa84115b8f8f75cc55c585bfe3676
@@ -162,6 +162,7 @@ ktrace_enter(
 
 	ASSERT(ktp != NULL);
 
+	spin_lock_init(&wrap_lock); //--billh
 	/*
 	 * Grab an entry by pushing the index up to the next one.
 	 */
============================================================
--- include/linux/eventpoll.h	bd142a622609d04952fac6215586fff353dab729
+++ include/linux/eventpoll.h	43271ded1a3b9f40beb37aaff9e02fadeecb4655
@@ -15,6 +15,7 @@
 #define _LINUX_EVENTPOLL_H
 
 #include <linux/types.h>
+#include <linux/lock_stat.h>
 
 
 /* Valid opcodes to issue to sys_epoll_ctl() */
@@ -55,7 +56,7 @@ static inline void eventpoll_init_file(s
 static inline void eventpoll_init_file(struct file *file)
 {
 	INIT_LIST_HEAD(&file->f_ep_links);
-	spin_lock_init(&file->f_ep_lock);
+	spin_lock_init_annotated(&file->f_ep_lock, &_lock_stat_eventpoll_init_file_entry);
 }
 
 
============================================================
--- include/linux/wait.h	12da8de69f1f2660443a04c3df199e5d851ea2ca
+++ include/linux/wait.h	9b7448af82583bd11d18032aedfa8f2af44345f4
@@ -81,7 +81,7 @@ extern void init_waitqueue_head(wait_que
 
 extern void init_waitqueue_head(wait_queue_head_t *q);
 
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_LOCK_STAT)
 # define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) \
 	({ init_waitqueue_head(&name); name; })
 # define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
============================================================
--- init/main.c	636e95fd9af6357291dace2b9995fd72d36e945f
+++ init/main.c	2e30dc30c4aca9b1ff56064887e04d8262db30e7
@@ -608,6 +608,7 @@ asmlinkage void __init start_kernel(void
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
+	lock_stat_sys_init(); //--billh
 	cpuset_init();
 	taskstats_init_early();
 	delayacct_init();
============================================================
--- net/tipc/node.c	d6ddb08c5332517b0eff3b72ee0adc48f47801ff
+++ net/tipc/node.c	9712633ceb8f939fc14a0a4861f7121840beff1d
@@ -77,7 +77,7 @@ struct node *tipc_node_create(u32 addr)
 		
 	memset(n_ptr, 0, sizeof(*n_ptr));
 	n_ptr->addr = addr;
-                spin_lock_init(&n_ptr->lock);
+	spin_lock_init(&n_ptr->lock);
 	INIT_LIST_HEAD(&n_ptr->nsub);
 	n_ptr->owner = c_ptr;
 	tipc_cltr_attach_node(c_ptr, n_ptr);

--Ycz6tD7Th1CMF4v7--
