Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267967AbUHXPQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267967AbUHXPQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUHXPQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:16:26 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:3990 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S267967AbUHXPPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:15:53 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 24 Aug 2004 08:15:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] ioport-cache-2.6.8.1.patch
In-Reply-To: <20040824071928.GA7697@elte.hu>
Message-ID: <Pine.LNX.4.58.0408240754140.4132@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
 <20040823233249.09e93b86.ak@suse.de> <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
 <20040824071928.GA7697@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Ingo Molnar wrote:

> another issue is that this code doesnt solve the 64K ports issue: even
> with a perfect decoder ioperm() apps still see a ~80 usecs copying
> latency (plus related cache trash effects) upon the first GPF - either
> IO related or not. I dont think coupling this into the GPF handler is
> all that good.

So, correct me if I'm wrong, you want this price to be paid at *every* 
context switch, isn't it? Independently from the fact that the task does 
or does not I/O operations.



> since 100% of Linux ioperm() apps currently use 1024 ports or less, i'd
> prefer the 128 bytes (one cacheline on a P4) copy over any asynchronous
> solution. (if someone wants more ports the price goes up. It should be
> rare. I dont think X will ever go above 1024 ports.) We've already had
> one security exploit in the lazy IO bitmap code, which further underlies
> how dangerous such asynchronity is.

It was in the lazy FPU code ;) and this patch is utterly simple and sets 
the most restrictive policy, by later verifying in the GPF code. It does 
not leave stale bitmaps from previous tasks in search of optimizations.



> there's yet another danger: apps that _do_ use IO ports frequently will
> see the most serious overhead via the GPF solution. They will most
> likely switch to iopl(3) - which is an even less safe API than ioperm()
> - so robustness suffers. So i think it's wrong policy too. Sorry :-|

Apps that do use I/O a lot will likely issue more than one I/O per context 
switch, and the cost of even one I/O op will be greater than the GPF cost. 
This w/out even accounting the cost saved on context switches where no I/O 
is done. Talking about X for example, yesterday test (that I should better 
confirm today) revealed that more than 60% of context switches do *not* 
trigger the GPF fault, that is, for in 60+% of context switches X does not 
use I/O operations. This is not a surprise given the way the X server works.



> but there's one additional step we can do ontop of the ports-max code to
> get rid of copying in X.org's case: cache the last task that set up the
> IO bitmap. This means we can set the offset to invalid and keep the IO
> bitmap of that task, and switch back to a valid offset (without any
> copying) when switching back to that task. (or do a copy if there is
> another ioperm task we switch to.)

Personally Ingo, I do not like logics like:

if (io_apps <= 1) pretty_good(); then screwed();

But that's just a matter of personal taste. Anyway, today I'll recode with 
Brian get/put_cpu suggestion and on top of var-bitmap bits, and I'll 
repost. Then if you guys like it you take it, otherwise we keep the 
current memcpy/memset on switch_to.



- Davide

