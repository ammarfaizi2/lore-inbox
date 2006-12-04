Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758682AbWLDCAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682AbWLDCAU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 21:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758768AbWLDCAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 21:00:20 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:62858
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1758682AbWLDCAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 21:00:18 -0500
Date: Sun, 3 Dec 2006 18:00:09 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: [PATCH 3/4] lock stat (rt/rtmutex.c mods) for 2.6.19-rt1
Message-ID: <20061204020009.GD28519@gnuppy.monkey.org>
References: <20061204015438.GB28519@gnuppy.monkey.org> <20061204015653.GC28519@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Cp3Cp8fzgozWLBWL"
Content-Disposition: inline
In-Reply-To: <20061204015653.GC28519@gnuppy.monkey.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Rudimentary annotations to the lock initializers to avoid the binary
tree search before attachment. For things like inodes that are created
and destroyed constantly this might be useful to get around some
overhead.

Sorry, about the patch numbering order. I think I screwed up on it.

bill


--Cp3Cp8fzgozWLBWL
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

--Cp3Cp8fzgozWLBWL--
