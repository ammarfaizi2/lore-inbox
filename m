Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVEUPuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVEUPuk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 11:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVEUPuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 11:50:40 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:24716 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261709AbVEUPuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 11:50:20 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sat, 21 May 2005 17:50:15 +0200
From: Samuel Thibault <samuel.thibault@labri.fr>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: Re: [PATCH] spin_unlock_bh() and preempt_check_resched()
Message-ID: <20050521155015.GA3687@bouh.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@labri.fr>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20050520151846.GP3690@bouh.labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050520151846.GP3690@bouh.labri.fr>
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Samuel Thibault, le Fri 20 May 2005 17:18:46 +0200, a dit :
> I'm wondering about macros like _spin_unlock_bh(lock):
> do { \
>         _raw_spin_unlock(lock); \
>         preempt_enable(); \
>         local_bh_enable(); \
>         __release(lock); \
> } while (0)
> 
> Is there a reason for using preempt_enable() instead of a simple
> preempt_enable_no_resched() ?
> 
> Since we know bottom halves are disabled, preempt_schedule() will always
> return at once (preempt_count!=0), and hence preempt_check_resched() is
> useless here...

Here is a patch.

Avoid useless preempt_check_resched() just before re-enabling bottom
halves.
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff -urNp linux-2.6-git/include/linux/spinlock.h linux-2.6-git-mine/include/linux/spinlock.h
--- linux-2.6-git/include/linux/spinlock.h	2005-05-21 15:41:33.000000000 +0200
+++ linux-2.6-git-mine/include/linux/spinlock.h	2005-05-21 15:45:11.000000000 +0200
@@ -248,7 +248,7 @@
 
 #define _spin_trylock_bh(lock)	({preempt_disable(); local_bh_disable(); \
 				_raw_spin_trylock(lock) ? \
-				1 : ({preempt_enable(); local_bh_enable(); 0;});})
+				1 : ({preempt_enable_no_resched(); local_bh_enable(); 0;});})
 
 #define _spin_lock(lock)	\
 do { \
@@ -383,7 +383,7 @@
 #define _spin_unlock_bh(lock) \
 do { \
 	_raw_spin_unlock(lock); \
-	preempt_enable(); \
+	preempt_enable_no_resched(); \
 	local_bh_enable(); \
 	__release(lock); \
 } while (0)
@@ -391,7 +391,7 @@
 #define _write_unlock_bh(lock) \
 do { \
 	_raw_write_unlock(lock); \
-	preempt_enable(); \
+	preempt_enable_no_resched(); \
 	local_bh_enable(); \
 	__release(lock); \
 } while (0)
@@ -423,8 +423,8 @@
 #define _read_unlock_bh(lock)	\
 do { \
 	_raw_read_unlock(lock);	\
+	preempt_enable_no_resched();	\
 	local_bh_enable();	\
-	preempt_enable();	\
 	__release(lock); \
 } while (0)
 
diff -urNp linux-2.6-git/kernel/spinlock.c linux-2.6-git-mine/kernel/spinlock.c
--- linux-2.6-git/kernel/spinlock.c	2005-05-21 15:41:08.000000000 +0200
+++ linux-2.6-git-mine/kernel/spinlock.c	2005-05-21 15:42:36.000000000 +0200
@@ -294,7 +294,7 @@
 void __lockfunc _spin_unlock_bh(spinlock_t *lock)
 {
 	_raw_spin_unlock(lock);
-	preempt_enable();
+	preempt_enable_no_resched();
 	local_bh_enable();
 }
 EXPORT_SYMBOL(_spin_unlock_bh);
@@ -318,7 +318,7 @@
 void __lockfunc _read_unlock_bh(rwlock_t *lock)
 {
 	_raw_read_unlock(lock);
-	preempt_enable();
+	preempt_enable_no_resched();
 	local_bh_enable();
 }
 EXPORT_SYMBOL(_read_unlock_bh);
@@ -342,7 +342,7 @@
 void __lockfunc _write_unlock_bh(rwlock_t *lock)
 {
 	_raw_write_unlock(lock);
-	preempt_enable();
+	preempt_enable_no_resched();
 	local_bh_enable();
 }
 EXPORT_SYMBOL(_write_unlock_bh);
@@ -354,7 +354,7 @@ int __lockfunc _spin_trylock_bh(spinlock
 	if (_raw_spin_trylock(lock))
 		return 1;
 
-	preempt_enable();
+	preempt_enable_no_resched();
 	local_bh_enable();
 	return 0;
 }

Regards,
Samuel Thibault
