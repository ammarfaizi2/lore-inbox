Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWARHiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWARHiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWARHiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:38:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030296AbWARHiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:38:23 -0500
Date: Tue, 17 Jan 2006 23:37:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: mingo@elte.hu, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
       michael@ellerman.id.au, linuxppc64-dev@ozlabs.org, serue@us.ibm.com,
       paulus@au1.ibm.com
Subject: Re: 2.6.15-mm4 failure on power5
Message-Id: <20060117233734.506c2f2e.akpm@osdl.org>
In-Reply-To: <20060118072815.GR2846@localhost.localdomain>
References: <20060116063530.GB23399@sergelap.austin.ibm.com>
	<200601180032.46867.michael@ellerman.id.au>
	<20060117140050.GA13188@elte.hu>
	<200601181119.39872.michael@ellerman.id.au>
	<20060118033239.GA621@cs.umn.edu>
	<20060118063732.GA21003@elte.hu>
	<20060117225304.4b6dd045.akpm@osdl.org>
	<20060118072815.GR2846@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <ntl@pobox.com> wrote:
>
> Andrew Morton wrote:
> > Ingo Molnar <mingo@elte.hu> wrote:
> > > - so buggy early bootup code which relies on interrupts being 
> > > off might be surprised by it.
> > 
> > I don't think it's necessarily buggy that bootup code needs interrupts
> > disabled.  It _is_ buggy that bootup code which needs interrupts disabled
> > is calling lock_cpu_hotplug().
> 
> I guess I don't understand -- why is it wrong for code that runs only
> in early early bootup, when there is only one process context, to use
> common code to e.g. register a hotplug cpu notifier?

OK, it's not wrong I guess - we're running code which requires
local_irq_disable() and that code is calling functions which do
local_irq_enable() but we know that those functions won't do that because
there cannot be any lock contention.

So it works, and will continue to work, but it's all rather unpleasant, IMO.

>  Should the
> powerpc numa code be made to wait to register its notifier until
> initcall time or something?

I think the powerpc code is busted, really - it shouldn't be keeling over
like that if someone enables local interrupts.  That being said, it's a
good way of detecting accidental interrupt-enablings.

> Yes, which would be why this code never triggered a warning when
> cpucontrol was a semaphore.

Yup.  Perhaps a sane fix which preserves the unpleasant semantics is to do
irqsave in the mutex debug code.
