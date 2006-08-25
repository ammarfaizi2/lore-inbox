Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422667AbWHYOyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422667AbWHYOyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWHYOyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:54:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:12249 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030214AbWHYOx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:53:58 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
Date: Fri, 25 Aug 2006 16:53:52 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200608230806.k7N8654c000504@frankl.hpl.hp.com> <200608251513.58729.ak@suse.de> <20060825142759.GH5330@frankl.hpl.hp.com>
In-Reply-To: <20060825142759.GH5330@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608251653.52898.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 16:27, Stephane Eranian wrote:

> > BTW you might be able to simplify some of your code by exploiting
> > those. i386 currently doesn't have them, but i wouldn't see a problem
> > with adding them there too.
> >  
> I think I will drop the EXCL_IDLE feature given that most PMU stop
> counting when you go low-power. The feature does not quite do what
> we want because it totally exclude the idle from monitoring, yet
> the idle may be doing useful kernel work, such as fielding interrupts.

Ok fine. Anything that makes the code less complex is good.
Currently it is very big and hard to understand.

(actually at least one newer Intel system I saw seemed to continue counting
in idle, but that might have been a specific quirk)


> 
> > > Don't you need more than one counter for this?
> > 
> > I don't think so. Why?
> 
> For NMI, you want the counter to overflow at a certain frequency:
> 
>         wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz * 1000 / nmi_hz));
> 
> But for RDTSC, I would think you'd simply want the counter to count
> monotonically. Given that perfctr0 is not 64-bit but 40, it will also
> overflow (or wraparound) but presumably at a lower frequency than the
> watchdog timer. I think I am not so clear on the intended usage user
> level usage of perfctr0 as a substitute for RDTSC.

Yes we need to underflow. But the users have to live with that.
I can make it longer than before though, but the period will be
<10s or so.

Two counters would be too much I think.


> Perfmon2 would need to check and atomically secure registers 
> its users could use. The trick is when is a good time to do this?
> It cannot just be done at initialiazation of perfmon2. It needs to be
> done each time a context is created, or each time a context is actually
> attached because there is where you really need to access the HW resource.

If you do it global per system (which the curren scheme is anyways) you can
just do it when the user uses system calls.
 
> It is important that we get this allocator in place fairly soon

It's already there.

-Andi
