Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264031AbUDFWGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbUDFWGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:06:38 -0400
Received: from nevyn.them.org ([66.93.172.17]:32388 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S264048AbUDFWE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:04:29 -0400
Date: Tue, 6 Apr 2004 18:04:28 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc3: irq#19 - nobody cared - with an au88xx
Message-ID: <20040406220428.GA28882@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE0023E89C2@hdsmsx402.hd.intel.com> <1076134307.2562.1553.camel@dhcppc4> <20040406180238.GA7439@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406180238.GA7439@nevyn.them.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 02:02:38PM -0400, Daniel Jacobowitz wrote:
> I still haven't figured out which kernel first introduced the problem,
> but it's still present, at 2.6.5.  I didn't see it while I was running
> 2.6.3-rc3, for some reason.
> 
> Now I'm using the ALSA au8830 driver.  There was no output from the
> driver before the nobody-cared message, so it was caused by one of
> these (sound/pci/au88x0/au88x0_core.c):
> 
>         //check if the interrupt is ours.
>         if (!(hwread(vortex->mmio, VORTEX_STAT) & 0x1))
>                 return IRQ_NONE;

It's this one.  If I wait until it locks up - it did at exactly 600,001
interrupts, interesting... then reload the module with this:
        //check if the interrupt is ours.
        if (!(hwread(vortex->mmio, VORTEX_STAT) & 0x1))
{
		printk ("vortex: Interrupt not ours\n");
                return IRQ_NONE;
}

I get _exactly_ 100,000 copies of that printout, and then the interrupt
is disabled with a 'nobody cares' response.  The first time, all
100,000 were on CPU0; the second time, 2 were on CPU0 and the other
99,998 on CPU1.

So it looks as if something gets wedged, and then the interrupt fires
continuously for no reason.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
