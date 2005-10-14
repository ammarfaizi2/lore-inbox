Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVJNDwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVJNDwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 23:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVJNDwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 23:52:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59070 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751144AbVJNDwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 23:52:03 -0400
Date: Fri, 14 Oct 2005 05:52:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-rt1 - enable IRQ-off tracing causes kernel to fault at boot
Message-ID: <20051014035230.GB6513@elte.hu>
References: <5bdc1c8b0510121000i5db112f2p642f66686fb46c57@mail.gmail.com> <20051013073029.GA12801@elte.hu> <5bdc1c8b0510130526k6064c640pecded9ccb0ef7dde@mail.gmail.com> <Pine.LNX.4.58.0510130844070.13098@localhost.localdomain> <5bdc1c8b0510131210i64f7f289q557368b056e59e18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0510131210i64f7f289q557368b056e59e18@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

> Ingo & Steve,
>    Thank you for your great instructions that even a guitar player 
> could basically follow. After about an hour of messing around I did 
> manage to capture the crash. The console file is attached.
> 
> NOTE: The first time I booted the kernel it got to the crash point and 
> the machine rebooted. The second time it booted I got the trace. Both 
> boots are in the capture file.

thanks, this log is much more informative. No smoking gun though, but it 
seems something fundamental (probably lowlevel x64 code) has been broken 
by -rt1.

Do the crashes go away if you take the -rc3-rt13 version of 
arch/x86_64/kernel/entry.S and copy it over into the -rc4-rt1 tree?  
[this undoes a particular set of CONFIG_CRITICAL_IRQSOFF_TIMING fixes 
from the x64 code, which i did during -rc3-rt13 => -rc4-rt1]

(Note that doing this will re-introduce tracing bugs, which can result 
in false-positive latency readings - but it should fix any related 
lowlevel bug in the assembly code.)

if this indeed solves the crash then i'd suggest to restore the -rt1 
version of entry.S, and i'd suggest to disable CRITICAL_IRQSOFF_TIMING 
until i fix it. You should be able to get pretty good latency tracing 
info even without CRITICAL_IRQSOFF_TIMING.

	Ingo
