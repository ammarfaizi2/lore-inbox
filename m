Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318214AbSGWTjJ>; Tue, 23 Jul 2002 15:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318215AbSGWTjJ>; Tue, 23 Jul 2002 15:39:09 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:18571 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318214AbSGWTjI>;
	Tue, 23 Jul 2002 15:39:08 -0400
Message-ID: <3D3DB161.7090303@us.ibm.com>
Date: Tue, 23 Jul 2002 12:41:21 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@mvista.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Adam G Litke <aglitke@us.ibm.com>
Subject: Re: [PATCH] reduce code in generic spinlock.h
References: <3D3D8414.1040201@us.ibm.com> <1027442320.3581.100.camel@sinai>
Content-Type: multipart/mixed;
 boundary="------------050206080402090003040001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050206080402090003040001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Robert Love wrote:
> It will not apply to Linus's current tree, however, because of the IRQ
> rewrite that is now applied.  If you pull his BK tree and diff against
> that, you should be OK... most notably, the preemption code has moved to
> preempt.h.

OK, this just made it simpler.  Just remove the preempt ifdef and the 
extra spinlock calls.  Patch against latest BK attached.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------050206080402090003040001
Content-Type: text/plain;
 name="spinlock-cleanup-bk0723.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spinlock-cleanup-bk0723.diff"

diff -Nru a/include/linux/spinlock.h b/include/linux/spinlock.h
--- a/include/linux/spinlock.h	Tue Jul 23 13:56:42 2002
+++ b/include/linux/spinlock.h	Tue Jul 23 13:56:42 2002
@@ -119,8 +119,6 @@
 
 #endif /* !SMP */
 
-#ifdef CONFIG_PREEMPT
-
 #define spin_lock(lock)	\
 do { \
 	preempt_disable(); \
@@ -147,20 +145,6 @@
 #define write_unlock(lock)	({_raw_write_unlock(lock); preempt_enable();})
 #define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
-
-#else
-
-#define spin_lock(lock)			_raw_spin_lock(lock)
-#define spin_trylock(lock)		_raw_spin_trylock(lock)
-#define spin_unlock(lock)		_raw_spin_unlock(lock)
-#define spin_unlock_no_resched(lock)	_raw_spin_unlock(lock)
-
-#define read_lock(lock)			_raw_read_lock(lock)
-#define read_unlock(lock)		_raw_read_unlock(lock)
-#define write_lock(lock)		_raw_write_lock(lock)
-#define write_unlock(lock)		_raw_write_unlock(lock)
-#define write_trylock(lock)		_raw_write_trylock(lock)
-#endif
 
 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK

--------------050206080402090003040001--

