Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293283AbSCAQfH>; Fri, 1 Mar 2002 11:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293256AbSCAQe5>; Fri, 1 Mar 2002 11:34:57 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:59311 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S293228AbSCAQc4>; Fri, 1 Mar 2002 11:32:56 -0500
Date: Fri, 1 Mar 2002 11:32:37 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] #define yield() for 2.4 scheduler (anticipating O(1))
Message-ID: <20020301163237.GC16716@opeth.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: multipart/mixed; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In response to Rik's post concerning a #define yield(), I've done a
quick egrep over the 2.4.19-pre2 tree and modified as necessary. This is
a strict search and replace. Thanks to Rik and Davide for assistance.
Please correct me if I erred.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="yield.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux.orig/arch/alpha/mm/fault.c linux/arch/alpha/mm/fault.c
--- linux.orig/arch/alpha/mm/fault.c	Mon Sep 17 19:15:02 2001
+++ linux/arch/alpha/mm/fault.c	Fri Mar  1 11:05:19 2002
@@ -196,8 +196,7 @@
  */
 out_of_memory:
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -uNr linux.orig/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- linux.orig/arch/i386/mm/fault.c	Thu Feb 28 21:59:44 2002
+++ linux/arch/i386/mm/fault.c	Fri Mar  1 11:03:47 2002
@@ -86,8 +86,7 @@
=20
 out_of_memory:
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		goto survive;
 	}
 	goto bad_area;
diff -uNr linux.orig/arch/ia64/mm/fault.c linux/arch/ia64/mm/fault.c
--- linux.orig/arch/ia64/mm/fault.c	Thu Feb 28 21:59:59 2002
+++ linux/arch/ia64/mm/fault.c	Fri Mar  1 11:17:26 2002
@@ -196,8 +196,7 @@
   out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -uNr linux.orig/arch/ppc/mm/fault.c linux/arch/ppc/mm/fault.c
--- linux.orig/arch/ppc/mm/fault.c	Tue Oct  2 12:12:44 2001
+++ linux/arch/ppc/mm/fault.c	Fri Mar  1 11:06:02 2002
@@ -197,8 +197,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -uNr linux.orig/arch/sh/mm/fault.c linux/arch/sh/mm/fault.c
--- linux.orig/arch/sh/mm/fault.c	Mon Oct 15 16:36:48 2001
+++ linux/arch/sh/mm/fault.c	Fri Mar  1 11:15:44 2002
@@ -207,8 +207,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -uNr linux.orig/drivers/char/drm-4.0/ffb_drv.c linux/drivers/char/drm-=
4.0/ffb_drv.c
--- linux.orig/drivers/char/drm-4.0/ffb_drv.c	Thu Feb 28 21:59:45 2002
+++ linux/drivers/char/drm-4.0/ffb_drv.c	Fri Mar  1 10:59:38 2002
@@ -710,8 +710,7 @@
 		/* Contention */
 		atomic_inc(&dev->total_sleeps);
 		current->state =3D TASK_INTERRUPTIBLE;
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		if (signal_pending(current)) {
 			ret =3D -ERESTARTSYS;
 			break;
diff -uNr linux.orig/drivers/char/drm-4.0/tdfx_drv.c linux/drivers/char/drm=
-4.0/tdfx_drv.c
--- linux.orig/drivers/char/drm-4.0/tdfx_drv.c	Thu Feb 28 21:59:45 2002
+++ linux/drivers/char/drm-4.0/tdfx_drv.c	Fri Mar  1 11:01:46 2002
@@ -578,10 +578,7 @@
=20
                                 /* Contention */
                         atomic_inc(&dev->total_sleeps);
-#if 1
-			current->policy |=3D SCHED_YIELD;
-#endif
-                        schedule();
+                        yield();
                         if (signal_pending(current)) {
                                 ret =3D -ERESTARTSYS;
                                 break;
@@ -604,8 +601,7 @@
                    when dev->last_context =3D=3D lock.context
                    NOTE WE HOLD THE LOCK THROUGHOUT THIS
                    TIME! */
-		current->policy |=3D SCHED_YIELD;
-	        schedule();
+	        yield();
 	        current->state =3D TASK_RUNNING;
 	        remove_wait_queue(&dev->context_wait, &entry);
 	        if (signal_pending(current)) {
diff -uNr linux.orig/drivers/ide/ataraid.c linux/drivers/ide/ataraid.c
--- linux.orig/drivers/ide/ataraid.c	Thu Oct 25 16:58:35 2001
+++ linux/drivers/ide/ataraid.c	Fri Mar  1 11:03:28 2002
@@ -123,8 +123,7 @@
 		ptr=3Dkmalloc(sizeof(struct buffer_head),GFP_NOIO);
 		if (!ptr) {
 			__set_current_state(TASK_RUNNING);
-	                current->policy |=3D SCHED_YIELD;
-	                schedule();            =20
+	                yield();
 		}
 	}
 	return ptr;
@@ -139,8 +138,7 @@
 		ptr=3Dkmalloc(sizeof(struct ataraid_bh_private),GFP_NOIO);
 		if (!ptr) {
 			__set_current_state(TASK_RUNNING);
-	                current->policy |=3D SCHED_YIELD;
-	                schedule();            =20
+	                yield();
 		}
 	}
 	return ptr;
diff -uNr linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Thu Feb 28 22:00:02 2002
+++ linux/fs/buffer.c	Fri Mar  1 10:29:52 2002
@@ -735,9 +735,8 @@
 	wakeup_bdflush();
 	try_to_free_pages(zone, GFP_NOFS, 0);
 	run_task_queue(&tq_disk);
-	current->policy |=3D SCHED_YIELD;
 	__set_current_state(TASK_RUNNING);
-	schedule();
+	yield();
 }
=20
 void init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void *priva=
te)
diff -uNr linux.orig/fs/jbd/journal.c linux/fs/jbd/journal.c
--- linux.orig/fs/jbd/journal.c	Thu Feb 28 21:59:47 2002
+++ linux/fs/jbd/journal.c	Fri Mar  1 10:40:34 2002
@@ -460,8 +460,7 @@
 			printk (KERN_NOTICE __FUNCTION__
 				": ENOMEM at get_unused_buffer_head, "
 				"trying again.\n");
-			current->policy |=3D SCHED_YIELD;
-			schedule();
+			yield();
 		}
 	} while (!new_bh);
 	/* keep subsequent assertions sane */
@@ -1541,8 +1540,7 @@
 			last_warning =3D jiffies;
 		}
 	=09
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 	}
 }
=20
@@ -1600,8 +1598,7 @@
 			last_warning =3D jiffies;
 		}
 		while (ret =3D=3D 0) {
-			current->policy |=3D SCHED_YIELD;
-			schedule();
+			yield();
 			ret =3D kmem_cache_alloc(journal_head_cache, GFP_NOFS);
 		}
 	}
diff -uNr linux.orig/fs/jbd/revoke.c linux/fs/jbd/revoke.c
--- linux.orig/fs/jbd/revoke.c	Thu Feb 28 21:59:47 2002
+++ linux/fs/jbd/revoke.c	Fri Mar  1 10:42:04 2002
@@ -137,8 +137,7 @@
 	if (!journal_oom_retry)
 		return -ENOMEM;
 	jbd_debug(1, "ENOMEM in " __FUNCTION__ ", retrying.\n");
-	current->policy |=3D SCHED_YIELD;
-	schedule();
+	yield();
 	goto repeat;
 }
=20
diff -uNr linux.orig/fs/jbd/transaction.c linux/fs/jbd/transaction.c
--- linux.orig/fs/jbd/transaction.c	Thu Feb 28 21:59:47 2002
+++ linux/fs/jbd/transaction.c	Fri Mar  1 10:42:39 2002
@@ -1379,8 +1379,7 @@
 		do {
 			old_handle_count =3D transaction->t_handle_count;
 			set_current_state(TASK_RUNNING);
-			current->policy |=3D SCHED_YIELD;
-			schedule();
+			yield();
 		} while (old_handle_count !=3D transaction->t_handle_count);
 	}
=20
diff -uNr linux.orig/fs/locks.c linux/fs/locks.c
--- linux.orig/fs/locks.c	Thu Oct 11 10:52:18 2001
+++ linux/fs/locks.c	Fri Mar  1 10:32:16 2002
@@ -445,8 +445,7 @@
 			/* Let the blocked process remove waiter from the
 			 * block list when it gets scheduled.
 			 */
-			current->policy |=3D SCHED_YIELD;
-			schedule();
+			yield();
 		} else {
 			/* Remove waiter from the block list, because by the
 			 * time it wakes up blocker won't exist any more.
diff -uNr linux.orig/fs/nfs/pagelist.c linux/fs/nfs/pagelist.c
--- linux.orig/fs/nfs/pagelist.c	Thu Feb 28 21:59:38 2002
+++ linux/fs/nfs/pagelist.c	Fri Mar  1 10:35:36 2002
@@ -96,8 +96,7 @@
 			continue;
 		if (signalled() && (server->flags & NFS_MOUNT_INTR))
 			return ERR_PTR(-ERESTARTSYS);
-		current->policy =3D SCHED_YIELD;
-		schedule();
+		yield();
 	}
=20
 	/* Initialize the request struct. Initially, we assume a
diff -uNr linux.orig/fs/reiserfs/buffer2.c linux/fs/reiserfs/buffer2.c
--- linux.orig/fs/reiserfs/buffer2.c	Thu Feb 28 21:59:38 2002
+++ linux/fs/reiserfs/buffer2.c	Fri Mar  1 10:37:11 2002
@@ -33,8 +33,7 @@
 			buffer_journal_dirty(bh) ? ' ' : '!');
     }
     run_task_queue(&tq_disk);
-    current->policy |=3D SCHED_YIELD;
-    schedule();
+    yield();
   }
   if (repeat_counter > 30000000) {
     reiserfs_warning("vs-3051: done waiting, ignore vs-3050 messages for (=
%b)\n", bh) ;
diff -uNr linux.orig/fs/reiserfs/journal.c linux/fs/reiserfs/journal.c
--- linux.orig/fs/reiserfs/journal.c	Thu Feb 28 21:59:47 2002
+++ linux/fs/reiserfs/journal.c	Fri Mar  1 10:36:44 2002
@@ -149,8 +149,7 @@
   }
   bn =3D allocate_bitmap_node(p_s_sb) ;
   if (!bn) {
-    current->policy |=3D SCHED_YIELD ;
-    schedule() ;
+    yield();
     goto repeat ;
   }
   return bn ;
diff -uNr linux.orig/include/linux/sched.h linux/include/linux/sched.h
--- linux.orig/include/linux/sched.h	Thu Feb 28 22:00:03 2002
+++ linux/include/linux/sched.h	Fri Mar  1 10:26:20 2002
@@ -122,6 +122,15 @@
  */
 #define SCHED_YIELD		0x10
=20
+/*
+ * Anticipating inclusion of Ingo's O(1) scheduler...
+ */
+#define yield()					\
+	do {					\
+		current->policy |=3D SCHED_YIELD;	\
+		schedule();			\
+	} while (0)
+
 struct sched_param {
 	int sched_priority;
 };
diff -uNr linux.orig/init/do_mounts.c linux/init/do_mounts.c
--- linux.orig/init/do_mounts.c	Thu Feb 28 22:00:03 2002
+++ linux/init/do_mounts.c	Fri Mar  1 10:43:15 2002
@@ -526,10 +526,8 @@
=20
 		pid =3D kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 		if (pid > 0) {
-			while (pid !=3D wait(&i)) {
-				current->policy |=3D SCHED_YIELD;
-				schedule();
-			}
+			while (pid !=3D wait(&i))
+				yield();
 		}
 		if (MAJOR(real_root_dev) !=3D RAMDISK_MAJOR
 		     || MINOR(real_root_dev) !=3D 0) {
diff -uNr linux.orig/kernel/softirq.c linux/kernel/softirq.c
--- linux.orig/kernel/softirq.c	Wed Oct 31 13:26:02 2001
+++ linux/kernel/softirq.c	Fri Mar  1 10:48:46 2002
@@ -260,8 +260,7 @@
 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
 		current->state =3D TASK_RUNNING;
 		do {
-			current->policy |=3D SCHED_YIELD;
-			schedule();
+			yield();
 		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
 	}
 	tasklet_unlock_wait(t);
@@ -405,10 +404,8 @@
 				  CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			printk("spawn_ksoftirqd() failed for cpu %d\n", cpu);
 		else {
-			while (!ksoftirqd_task(cpu_logical_map(cpu))) {
-				current->policy |=3D SCHED_YIELD;
-				schedule();
-			}
+			while (!ksoftirqd_task(cpu_logical_map(cpu)))
+				yield();
 		}
 	}
=20
diff -uNr linux.orig/mm/highmem.c linux/mm/highmem.c
--- linux.orig/mm/highmem.c	Thu Feb 28 21:59:39 2002
+++ linux/mm/highmem.c	Fri Mar  1 10:51:22 2002
@@ -354,9 +354,8 @@
 	/* we need to wait I/O completion */
 	run_task_queue(&tq_disk);
=20
-	current->policy |=3D SCHED_YIELD;
 	__set_current_state(TASK_RUNNING);
-	schedule();
+	yield();
 	goto repeat_alloc;
 }
=20
@@ -392,9 +391,8 @@
 	/* we need to wait I/O completion */
 	run_task_queue(&tq_disk);
=20
-	current->policy |=3D SCHED_YIELD;
 	__set_current_state(TASK_RUNNING);
-	schedule();
+	yield();
 	goto repeat_alloc;
 }
=20
diff -uNr linux.orig/mm/oom_kill.c linux/mm/oom_kill.c
--- linux.orig/mm/oom_kill.c	Sat Nov  3 20:05:25 2001
+++ linux/mm/oom_kill.c	Fri Mar  1 10:51:35 2002
@@ -188,8 +188,7 @@
 	 * killing itself before someone else gets the chance to ask
 	 * for more memory.
 	 */
-	current->policy |=3D SCHED_YIELD;
-	schedule();
+	yield();
 	return;
 }
=20
diff -uNr linux.orig/mm/page_alloc.c linux/mm/page_alloc.c
--- linux.orig/mm/page_alloc.c	Thu Feb 28 22:00:03 2002
+++ linux/mm/page_alloc.c	Fri Mar  1 10:49:38 2002
@@ -429,9 +429,8 @@
 		return NULL;
=20
 	/* Yield for kswapd, and try again */
-	current->policy |=3D SCHED_YIELD;
 	__set_current_state(TASK_RUNNING);
-	schedule();
+	yield();
 	goto rebalance;
 }
=20
diff -uNr linux.orig/net/ipv4/tcp_output.c linux/net/ipv4/tcp_output.c
--- linux.orig/net/ipv4/tcp_output.c	Thu Feb 28 21:59:39 2002
+++ linux/net/ipv4/tcp_output.c	Fri Mar  1 10:52:55 2002
@@ -1009,8 +1009,7 @@
 			skb =3D alloc_skb(MAX_TCP_HEADER, GFP_KERNEL);
 			if (skb)
 				break;
-			current->policy |=3D SCHED_YIELD;
-			schedule();
+			yield();
 		}
=20
 		/* Reserve space for headers and prepare control bits. */
diff -uNr linux.orig/net/sched/sch_generic.c linux/net/sched/sch_generic.c
--- linux.orig/net/sched/sch_generic.c	Fri Aug 18 13:26:25 2000
+++ linux/net/sched/sch_generic.c	Fri Mar  1 10:58:07 2002
@@ -475,10 +475,8 @@
=20
 	dev_watchdog_down(dev);
=20
-	while (test_bit(__LINK_STATE_SCHED, &dev->state)) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
-	}
+	while (test_bit(__LINK_STATE_SCHED, &dev->state))
+		yield();
=20
 	spin_unlock_wait(&dev->xmit_lock);
 }
diff -uNr linux.orig/net/socket.c linux/net/socket.c
--- linux.orig/net/socket.c	Thu Feb 28 21:59:39 2002
+++ linux/net/socket.c	Fri Mar  1 10:51:51 2002
@@ -148,8 +148,7 @@
 	while (atomic_read(&net_family_lockct) !=3D 0) {
 		spin_unlock(&net_family_lock);
=20
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
=20
 		spin_lock(&net_family_lock);
 	}
diff -uNr linux.orig/net/sunrpc/sched.c linux/net/sunrpc/sched.c
--- linux.orig/net/sunrpc/sched.c	Thu Feb 28 21:59:48 2002
+++ linux/net/sunrpc/sched.c	Fri Mar  1 10:57:30 2002
@@ -773,8 +773,7 @@
 		}
 		if (flags & RPC_TASK_ASYNC)
 			return NULL;
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 	} while (!signalled());
=20
 	return NULL;
@@ -1115,8 +1114,7 @@
 		__rpc_schedule();
 		if (all_tasks) {
 			dprintk("rpciod_killall: waiting for tasks to exit\n");
-			current->policy |=3D SCHED_YIELD;
-			schedule();
+			yield();
 		}
 	}
=20
@@ -1186,8 +1184,7 @@
 	 * wait briefly before checking the process id.
 	 */
 	current->sigpending =3D 0;
-	current->policy |=3D SCHED_YIELD;
-	schedule();
+	yield();
 	/*
 	 * Display a message if we're going to wait longer.
 	 */
diff -uNr linux.orig/net/unix/af_unix.c linux/net/unix/af_unix.c
--- linux.orig/net/unix/af_unix.c	Thu Feb 28 21:59:48 2002
+++ linux/net/unix/af_unix.c	Fri Mar  1 10:52:34 2002
@@ -565,10 +565,8 @@
 				      addr->hash)) {
 		write_unlock(&unix_table_lock);
 		/* Sanity yield. It is unusual case, but yet... */
-		if (!(ordernum&0xFF)) {
-			current->policy |=3D SCHED_YIELD;
-			schedule();
-		}
+		if (!(ordernum&0xFF))
+			yield();
 		goto retry;
 	}
 	addr->hash ^=3D sk->type;

--ctP54qlpMx3WjD+/--

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8f60lMwVVFhIHlU4RAmkHAJ9CmFjhQ0v42O09D3ZPW/f/HpK/RQCfVKMp
es+K0zqQ7SvVIZGklQyRak8=
=LL2J
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
