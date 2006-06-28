Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWF1RFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWF1RFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWF1Q7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:59:19 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41220 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751449AbWF1QzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:01 -0400
Date: Wed, 28 Jun 2006 18:55:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] kernel/lockdep.c: possible cleanups
Message-ID: <20060628165500.GV13915@stusta.de>
References: <20060627015211.ce480da6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 01:52:11AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm2:
>...
> +lockdep-core.patch
>...
>  Locking validator
>...

This patch contains the following possible cleanups:
- make the needlessly global variable lockdep_init_error static
- make the needlessly global lockdep_print_held_locks() static
- #if 0 the unused global print_lock_classes()
  (this also implies to #if 0 some static functions)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/lockdep.h    |    5 -----
 kernel/lockdep.c           |   10 ++++++++--
 kernel/lockdep_internals.h |    7 -------
 3 files changed, 8 insertions(+), 14 deletions(-)

--- linux-2.6.17-mm3-full/kernel/lockdep_internals.h.old	2006-06-27 17:53:22.000000000 +0200
+++ linux-2.6.17-mm3-full/kernel/lockdep_internals.h	2006-06-27 17:53:56.000000000 +0200
@@ -49,13 +49,6 @@
 
 #ifdef CONFIG_DEBUG_LOCKDEP
 /*
- * We cannot printk in early bootup code. Not even early_printk()
- * might work. So we mark any initialization errors and printk
- * about it later on, in lockdep_info().
- */
-extern int lockdep_init_error;
-
-/*
  * Various lockdep statistics:
  */
 extern atomic_t chain_lookup_hits;
--- linux-2.6.17-mm3-full/include/linux/lockdep.h.old	2006-06-27 17:54:35.000000000 +0200
+++ linux-2.6.17-mm3-full/include/linux/lockdep.h	2006-06-27 17:54:57.000000000 +0200
@@ -191,9 +191,6 @@
 extern void lockdep_reset_lock(struct lockdep_map *lock);
 extern void lockdep_free_key_range(void *start, unsigned long size);
 
-extern void print_lock_classes(void);
-extern void lockdep_print_held_locks(struct task_struct *task);
-
 extern void lockdep_off(void);
 extern void lockdep_on(void);
 extern int lockdep_internal(void);
@@ -258,8 +255,6 @@
 # define lock_release(l, n, i)			do { } while (0)
 # define lockdep_init()				do { } while (0)
 # define lockdep_info()				do { } while (0)
-# define print_lock_classes()			do { } while (0)
-# define lockdep_print_held_locks(task)		do { (void)(task); } while (0)
 # define lockdep_init_map(lock, name, key)	do { } while (0)
 # define lockdep_set_class(lock, key)		do { (void)(key); } while (0)
 # define INIT_LOCKDEP
--- linux-2.6.17-mm3-full/kernel/lockdep.c.old	2006-06-27 17:54:03.000000000 +0200
+++ linux-2.6.17-mm3-full/kernel/lockdep.c	2006-06-27 18:55:55.000000000 +0200
@@ -262,7 +262,7 @@
  * might work. So we mark any initialization errors and printk
  * about it later on, in lockdep_info().
  */
-int lockdep_init_error;
+static int lockdep_init_error;
 
 /*
  * Various lockdep statistics:
@@ -373,6 +373,7 @@
 	printk("){%c%c%c%c}", c1, c2, c3, c4);
 }
 
+#if 0
 static void print_lock_name_field(struct lock_class *class)
 {
 	const char *name;
@@ -390,6 +391,7 @@
 			printk("/%d", class->subclass);
 	}
 }
+#endif  /*  0  */
 
 static void print_lockdep_cache(struct lockdep_map *lock)
 {
@@ -410,7 +412,7 @@
 	print_ip_sym(hlock->acquire_ip);
 }
 
-void lockdep_print_held_locks(struct task_struct *curr)
+static void lockdep_print_held_locks(struct task_struct *curr)
 {
 	int i, depth = curr->lockdep_depth;
 
@@ -488,6 +490,8 @@
 	}
 }
 
+#if 0
+
 /*
  * printk all locks that are taken after this lock:
  */
@@ -539,6 +543,8 @@
 	}
 }
 
+#endif  /*  0  */
+
 /*
  * Add a new dependency to the head of the list:
  */

