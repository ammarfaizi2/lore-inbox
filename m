Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUHEU3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUHEU3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267811AbUHEU3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:29:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:45532 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267808AbUHEU31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:29:27 -0400
Date: Thu, 5 Aug 2004 22:29:25 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: mingo@elte.hu, vda@port.imtp.ilyichevsk.odessa.ua,
       gene.heskett@verizon.net, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Possible dcache BUG
Message-Id: <20040805222925.354c8bf9.ak@suse.de>
In-Reply-To: <Pine.LNX.4.58.0408051144520.24588@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<200408042216.12215.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
	<200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org>
	<20040805180634.GA26732@elte.hu>
	<Pine.LNX.4.58.0408051144520.24588@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004 11:50:33 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Thu, 5 Aug 2004, Ingo Molnar wrote:
> > 
> > * Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > > Anyway, one other thing that makes me worry is the fact that Gene
> > > apparently has a K7. One of the things AMD has gotten wrong several
> > > times is prefetching, and it so happens that the dcache code is one of
> > > the users of the prefetch instruction. prude_dcache() in particular.
> > 
> > hm, i too happen to have an Athlon64 box (running the x86 kernel) where
> > i can reproduce dcache pruning crashes after a few hours of testing
> > using a near-vanilla kernel.
> 
> Very interesthing.
> 
> The K8 core (aka Opteron or Athlon64) has exactly the same prefetch page
> fault bugs that the K7 core has. This, coupled with your observation

Yep, but they should be handled. Of course in theory it could be a subtle
bug in the prefetch handler. But normally even when that goes wrong you
just get a obvious oops on the prefetch instruction itself.

When you disable the use of prefetch does it still happen? 

diff -u linux-2.6.8rc2-update/include/asm-i386/processor.h-o linux-2.6.8rc2-update/include/asm-i386/processor.h
--- linux-2.6.8rc2-update/include/asm-i386/processor.h-o	2004-07-28 02:23:44.000000000 +0200
+++ linux-2.6.8rc2-update/include/asm-i386/processor.h	2004-08-05 22:25:46.000000000 +0200
@@ -612,6 +612,7 @@
 
 #define ASM_NOP_MAX 8
 
+#if 0
 /* Prefetch instructions for Pentium III and AMD Athlon */
 /* It's not worth to care about 3dnow! prefetches for the K6
    because they are microcoded there and very slow.
@@ -640,6 +641,7 @@
 			  "r" (x));
 }
 #define spin_lock_prefetch(x)	prefetchw(x)
+#endif
 
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 


> > NOTE2: i tried hard but couldnt reproduce the problem using the very
> > same kernel and the same workload on a PIII box. Once i ran it overnight
> > to check. Only the Athlon64 box does it. It could also be a hardware
> > problem - albeit the box withstood days of memtest86.

Both K8/K7 are usually a lot faster and a lot more aggressive in out of order 
execution than the P3 box. A P4 would be a better comparison.

> Andi, I think you were the contact for the AMD prefetch bug. Can you ask 
> around the same people whether there might be other problems in this area? 
> No point in putting a lot of effort into it, but just as one thing to 
> check for..

A bigger sample size that shows it really only happens on AMD first would be useful.

-Andi
