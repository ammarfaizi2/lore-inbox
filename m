Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276842AbRJCCxE>; Tue, 2 Oct 2001 22:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276845AbRJCCwz>; Tue, 2 Oct 2001 22:52:55 -0400
Received: from rj.sgi.com ([204.94.215.100]:42661 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S276842AbRJCCwm>;
	Tue, 2 Oct 2001 22:52:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andreas Schwab <schwab@suse.de>, Ian Grant <Ian.Grant@cl.cam.ac.uk>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [patch] 2.4.10 build failure - atomic_dec_and_lock export 
In-Reply-To: Your message of "Tue, 02 Oct 2001 19:52:29 +0200."
             <15289.65245.126409.37240@charged.uio.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Oct 2001 12:52:57 +1000
Message-ID: <30648.1002077577@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001 19:52:29 +0200, 
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>>>>>> " " == Andreas Schwab <schwab@suse.de> writes:
>
>     > Trond Myklebust <trond.myklebust@fys.uio.no> writes:
>     > |> If you have CONFIG_SMP defined then atomic_dec_and_lock will
>     > |> never get defined
>
>     > Unless you use CONFIG_MODVERSIONS, which causes
>     > atomic_dec_and_lock to be versioned and defined as a macro via
>     > <linux/modversions.h>.
>
>Oh great... That's going to confound the test in <linux/spinlock.h>
>too.
>
>Urgh. Can anybody propose a less ugly solution than EXPORT_SYMBOL_NOVERS()?

Use a second flag when atomic_dec_and_lock() is #defined.  No conflict
with modversions then.

Index: 10.1/lib/dec_and_lock.c
--- 10.1/lib/dec_and_lock.c Wed, 29 Aug 2001 09:36:05 +1000 kaos (linux-2.4/j/21_dec_and_lo 1.1.1.1 644)
+++ 10.1(w)/lib/dec_and_lock.c Wed, 03 Oct 2001 12:24:35 +1000 kaos (linux-2.4/j/21_dec_and_lo 1.1.1.1 644)
@@ -26,7 +26,7 @@
  * store-conditional approach, for example.
  */
 
-#ifndef atomic_dec_and_lock
+#ifndef ATOMIC_DEC_AND_LOCK
 int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
 	spin_lock(lock);
Index: 10.1/include/linux/spinlock.h
--- 10.1/include/linux/spinlock.h Thu, 05 Jul 2001 14:00:51 +1000 kaos (linux-2.4/X/48_spinlock.h 1.1.2.1 644)
+++ 10.1(w)/include/linux/spinlock.h Wed, 03 Oct 2001 12:27:02 +1000 kaos (linux-2.4/X/48_spinlock.h 1.1.2.1 644)
@@ -42,6 +42,7 @@
 #if (DEBUG_SPINLOCKS < 1)
 
 #define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
+#define ATOMIC_DEC_AND_LOCK
 
 /*
  * Your basic spinlocks, allowing only a single CPU anywhere
@@ -128,7 +129,7 @@ typedef struct {
 #endif /* !SMP */
 
 /* "lock on reference count zero" */
-#ifndef atomic_dec_and_lock
+#ifndef ATOMIC_DEC_AND_LOCK
 #include <asm/atomic.h>
 extern int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
 #endif

