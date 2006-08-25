Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWHYPOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWHYPOh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWHYPOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:14:37 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:42449 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S964877AbWHYPOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:14:36 -0400
Date: Fri, 25 Aug 2006 08:00:29 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
Message-ID: <20060825150029.GJ5330@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N8654c000504@frankl.hpl.hp.com> <200608251513.58729.ak@suse.de> <20060825142759.GH5330@frankl.hpl.hp.com> <200608251653.52898.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608251653.52898.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Fri, Aug 25, 2006 at 04:53:52PM +0200, Andi Kleen wrote:
> On Friday 25 August 2006 16:27, Stephane Eranian wrote:
> 
> > > BTW you might be able to simplify some of your code by exploiting
> > > those. i386 currently doesn't have them, but i wouldn't see a problem
> > > with adding them there too.
> > >  
> > I think I will drop the EXCL_IDLE feature given that most PMU stop
> > counting when you go low-power. The feature does not quite do what
> > we want because it totally exclude the idle from monitoring, yet
> > the idle may be doing useful kernel work, such as fielding interrupts.
> 
> Ok fine. Anything that makes the code less complex is good.
> Currently it is very big and hard to understand.
> 
> (actually at least one newer Intel system I saw seemed to continue counting
> in idle, but that might have been a specific quirk)
> 

Yes, that's my fear, we may get inconsistent behaviors across architectures.
I think the only way to ensure some consistency would be to use the
enter/exit_idle callbacks you mentioned assuming those would be available for
all architectures.  With this, we could guarantee that we are not monitoring
usless execution (including low-power mode) simply because we would explicitely
stop monitoring on enter_idle() and restart monitoring on exit_idle().

> > For NMI, you want the counter to overflow at a certain frequency:
> > 
> >         wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz * 1000 / nmi_hz));
> > 
> > But for RDTSC, I would think you'd simply want the counter to count
> > monotonically. Given that perfctr0 is not 64-bit but 40, it will also
> > overflow (or wraparound) but presumably at a lower frequency than the
> > watchdog timer. I think I am not so clear on the intended usage user
> > level usage of perfctr0 as a substitute for RDTSC.
> 
> Yes we need to underflow. But the users have to live with that.
> I can make it longer than before though, but the period will be
> <10s or so.

So the goal of this is for a more realiable way of measuring short
sections of code, isn't it? If I recall, the TSC does not quite work
with frequency scaling.

Is anybody lobbying the HW designers to implement another register to
do what you need here? That would certainly simplify things.

> Two counters would be too much I think.
> 
Certainly given that there are other users of that resource and
that on K8 you only have 4.

-- 
-Stephane
