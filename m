Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269658AbUJSQlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269658AbUJSQlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269768AbUJSQhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:37:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15579 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269658AbUJSQaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:30:19 -0400
Date: Tue, 19 Oct 2004 18:31:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019163125.GA13498@elte.hu>
References: <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019144642.GA6512@elte.hu> <28172.195.245.190.93.1098199429.squirrel@195.245.190.93> <20041019155008.GA9116@elte.hu> <20041019162047.GA12055@elte.hu> <20041019162811.GA13454@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019162811.GA13454@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > i found older .config's from you and i tried your desktop one and it
> > didnt crash. But when i tried your laptop's U3 .config then i got the
> > bootup crash immediately. Debugging it ...
> 
> one difference in your config is that you have 4K stacks enabled.
> Could you disable them? Especially with rwsem-detection and tracing
> enabled the stack footprint can get pretty large ...

indeed, this is what triggers with your .config:

 testing NMI watchdog ... OK.
 ENABLING IO-APIC IRQs
 ..TIMER: vector=0x31 pin1=2 pin2=-1
 mcount: stack overflow: 1008
  [<c012cd9f>] ___trace+0x105/0x117
  [<c012cdd7>] __mcount+0x1d/0x1f
  [<c013e015>] cache_grow+0xe/0x1ab
  [<c013e3cd>] cache_alloc_refill+0x21b/0x253

enabling 8K stacks ought to help this one. I've made the limit a bit too
conservative - there's still 1000 bytes left and the assert hits. Here's
the full trace, the large footprint seems to be in zlib initialization:

mcount: stack overflow: 1008
 [<c012cd9f>] ___trace+0x105/0x117
 [<c012cdd7>] __mcount+0x1d/0x1f
 [<c013e015>] cache_grow+0xe/0x1ab
 [<c013e3cd>] cache_alloc_refill+0x21b/0x253
 [<c010efec>] mcount+0x14/0x18
 [<c013e015>] cache_grow+0xe/0x1ab
 [<c013e3cd>] cache_alloc_refill+0x21b/0x253
 [<c013e730>] __kmalloc+0x82/0x9f
 [<c03607c8>] malloc+0x1e/0x20
 [<c01008c9>] huft_build+0x309/0x5e8
 [<c0101bec>] inflate+0x4c/0xb0
 [<c010efec>] mcount+0x14/0x18
 [<c0101279>] inflate_fixed+0xcb/0x1a4
 [<c0101bec>] inflate+0x4c/0xb0
 [<c010efec>] mcount+0x14/0x18
 [<c0101eae>] gunzip+0x1d4/0x396
 [<c036130e>] unpack_to_rootfs+0x162/0x225
 [<c010efec>] mcount+0x14/0x18
 [<c0100434>] init+0x0/0x124
 [<c03613fe>] populate_rootfs+0x2d/0x3f
 [<c010046b>] init+0x37/0x124
 [<c0102365>] kernel_thread_helper+0x5/0xb

	Ingo
