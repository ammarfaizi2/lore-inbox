Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUADXz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 18:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUADXz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 18:55:29 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:12041 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S265805AbUADXz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 18:55:26 -0500
Date: Mon, 5 Jan 2004 02:54:50 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SYM53c8xx Panic on Boot: 2.6.1rc1 (Alpha)
Message-ID: <20040105025450.A16408@jurassic.park.msu.ru>
References: <slrnbvegjp.4er.jgoerzen@christoph.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <slrnbvegjp.4er.jgoerzen@christoph.complete.org>; from jgoerzen@complete.org on Sat, Jan 03, 2004 at 10:30:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 10:30:17PM +0000, John Goerzen wrote:
> SCSI device sda: drive cache: write back
>  sda:Bad unaligned kernel access at fffffc000043ec28: fffffc001fe72432 22 31
> Kernel panic: Attempted to kill init!
...
> # CONFIG_ALPHA_SRM is not set

So you're booting from MILO - its ancient PALcode doesn't handle
prefetch instructions with invalid target address "properly".
Personally I don't consider this as a PALcode bug, since even
with a "correct" PALcode spin_lock_prefetch() just burns CPU cycles
on uni-processor (and I think this applies not only to Alpha).

Does that old patch work for you?

Ivan.

----- Forwarded message from Ivan Kokshaysky <ink@jurassic.park.msu.ru> -----

Date: Tue, 18 Nov 2003 02:19:22 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Cc: Richard Henderson <rth@twiddle.net>, alpha@steudten.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: Re: BUG: Kernel Panic: kernel-2.6.0-test9-bk21  for alpha in scsi context ll_rw_blk.c
User-Agent: Mutt/1.2.5i
In-Reply-To: <87islid5tq.fsf@student.uni-tuebingen.de>; from falk.hueffner@student.uni-tuebingen.de on Mon, Nov 17, 2003 at 10:48:49PM +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 10:48:49PM +0100, Falk Hueffner wrote:
> Well, the architecture manual requires these instructions have no
> visible effect whatsoever, i. e. they never trap.

No. Unaligned != invalid.

We shouldn't prefetch the spinlocks on UP.

Ivan.

--- 2.6/include/asm-alpha/processor.h	Sat Oct 25 22:44:54 2003
+++ linux/include/asm-alpha/processor.h	Tue Nov 18 01:48:39 2003
@@ -78,6 +78,11 @@ unsigned long get_wchan(struct task_stru
 #define ARCH_HAS_PREFETCHW
 #define ARCH_HAS_SPINLOCK_PREFETCH
 
+#ifndef CONFIG_SMP
+/* Nothing to prefetch. */
+#define spin_lock_prefetch(lock)  	do { } while (0)
+#endif
+
 #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
 extern inline void prefetch(const void *ptr)  
 { 
@@ -89,10 +94,13 @@ extern inline void prefetchw(const void 
 	__builtin_prefetch(ptr, 1, 3);
 }
 
+#ifdef CONFIG_SMP
 extern inline void spin_lock_prefetch(const void *ptr)  
 {
 	__builtin_prefetch(ptr, 1, 3);
 }
+#endif
+
 #else
 extern inline void prefetch(const void *ptr)  
 { 
@@ -104,10 +112,13 @@ extern inline void prefetchw(const void 
 	__asm__ ("ldq $31,%0" : : "m"(*(char *)ptr)); 
 }
 
+#ifdef CONFIG_SMP
 extern inline void spin_lock_prefetch(const void *ptr)  
 {
 	__asm__ ("ldq $31,%0" : : "m"(*(char *)ptr)); 
 }
+#endif
+
 #endif /* GCC 3.1 */
 
 #endif /* __ASM_ALPHA_PROCESSOR_H */

----- End forwarded message -----
