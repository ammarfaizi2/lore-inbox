Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVCZLe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVCZLe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 06:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVCZLe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 06:34:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:9224 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262035AbVCZLeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 06:34:36 -0500
Date: Sat, 26 Mar 2005 12:34:26 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: Linux 2.4.30-rc2
Message-ID: <20050326113426.GO30052@alpha.home.local>
References: <20050326004631.GC17637@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326004631.GC17637@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

just another one and that's all. Zachary Amsden found an unconditional
write to a debug register in the signal delivery path which is only
needed when we use a breakpoint. This is a very expensive operation on
x86, and doing it conditionnaly enhanced signal delivery speed by 33%
for him.

His patch got merged in 2.6.10, and I've merged it a month ago in my
local tree. Could we get it in 2.4.30, please ?

Thanks in advance,
Willy

--

I noticed an unneeded write to dr7 in the signal handling path for x86.  
We only need to write to dr7 if there is a breakpoint to re-enable, and 
MOVDR is a serializing instruction, which is expensive.  Getting rid of 
it gets a 33% faster signal delivery path (at least on Xeon - I didn't 
test other CPUs, so your gain may vary).

Cheers,

Zachary Amsden
zach@vmware.com

--------------070400020104010700090602
Content-Type: text/plain;
 name="README.i386-fast-signal"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.i386-fast-signal"

Optimize away the unconditional write to debug registers on signal delivery
path.  This is already done on x86_64.  Measured delta TSC for three paths
on a 2.4GHz Xeon.

1) With unconditional write to dr7 :  800-1000 cycles
2) With conditional write to dr7   :  84-112 cycles
3) With unlikely write to dr7      :  84 cycles

Performance test using divzero microbenchmark (3 million divide by zeros):

With unconditional write: 
   7.445 real / 6.136 system
   7.529 real / 6.482 system
   7.541 real / 5.974 system
   7.546 real / 6.217 system
   7.445 real / 6.167 system

With unlikely write:
   5.779 real / 4.518 system
   5.783 real / 4.591 system
   5.552 real / 4.569 system
   5.790 real / 4.528 system
   5.554 real / 4.382 system

That's about a 33% speedup - more than I expected; apparently getting rid
of the serializing instruction makes the do_signal path much faster.

Zachary Amsden (zach@vmware.com)

--------------070400020104010700090602
Content-Type: text/plain;
 name="i386-fast-signal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-fast-signal.patch"

[hand-edited line numbers to match 2.4]
--- linux-2.6.10-rc1/arch/i386/kernel/signal.c	2004-10-25 11:15:43.000000000 -0700
+++ linux-2.6.10-rc1-nsz/arch/i386/kernel/signal.c	2004-10-26 14:30:54.000000000 -0700
@@ -600,7 +600,9 @@
 		 * have been cleared if the watchpoint triggered
 		 * inside the kernel.
 		 */
-		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+		if (unlikely(current->thread.debugreg[7])) {
+			__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+		}
 
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(signr, &info, &ka, oldset, regs);


