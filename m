Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVAOKU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVAOKU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 05:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVAOKU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 05:20:57 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:9621
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262256AbVAOKUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 05:20:46 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: karim@opersys.com
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41E87102.2090502@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <1105740276.8604.83.camel@tglx.tec.linutronix.de>
	 <41E85123.7080005@opersys.com>
	 <1105747280.13265.72.camel@tglx.tec.linutronix.de>
	 <20050114162652.73283f2e.akpm@osdl.org>
	 <1105750810.13265.126.camel@tglx.tec.linutronix.de>
	 <41E87102.2090502@opersys.com>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 11:20:45 +0100
Message-Id: <1105784445.13265.222.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 20:25 -0500, Karim Yaghmour wrote:
> Thomas Gleixner wrote:
>
> You have previously demonstrated that you do not understand the
> implementation you are criticizing. You keep repeating the size
> of the patch like a mantra, yet when pressed for actual bits of
> code that need fixing, you use a circular argument to slip away.

Yeah, did you answer one of my arguments except claiming that I'm to
stupid to understand how it works ? 

I completely understand what this code does and I don't beat on the
patch size. I beat on the timing burden and restrictions which are given
by the implementation.

I have no objection against relayfs itself. I can just leave the config
switch off, so it does not affect me.

Adding instrumentation to the kernel is a good thing. 

I just dont like the idea, that instrumentation is bound on relayfs and
adds a feature to the kernel which fits for a restricted set of problems
rather than providing a generic optimized instrumentation framework,
where one can use relayfs as a backend, if it fits his needs. Making
this less glued together leaves the possibility to use other backends. 

> If you feel that there is some unncessary processing being done
> in the kernel, please show me the piece of code affected so that
> it can be fixed if it is broken.

Just doing codepath analysis shows me:

There is a loop in ltt_log_event, which enforces the processing of each
event twice. Spliting traces is postprocessing and can be done
elsewhere.

In _ltt_log_event lives quite a bunch of if(...) processing decisions
which have to be evaluated for _each_ event.

The relay_reserve code can loop in the do { } while() and even go into a
slow path where another do { } while() is found.
So it can not be used in fast paths and for timing related problem
tracking, because it adds variable time overhead.

Due to the fact, that the ltt_log_event path is not preempt safe you can
actually hit the additional go in the do { } while() loop.

I pointed out before, that it is not possible to selectively select the
events which I'm interested in during compile time. I get either nothing
or everything. If I want to use instrumentation for a particular
problem, why must I process a loop of _ltt_log_event calls for stuff I
do not need instead of just compiling it away ?

If I compile a event in, then adding a couple of checks into the
instrumentation macro itself does not hurt as much as leaving the
straight code path for a disabled event.

tglx


