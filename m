Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTFACDL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 22:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbTFACDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 22:03:11 -0400
Received: from a11a.mannikko1.ton.tut.fi ([195.148.185.30]:65286 "EHLO
	a11a.mannikko1.ton.tut.fi") by vger.kernel.org with ESMTP
	id S261161AbTFACDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 22:03:09 -0400
Date: Sun, 1 Jun 2003 05:16:11 +0300
From: Pasi Savolainen <pvsavola@luukku.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] amd76x_pm port to 2.5.70
Message-ID: <20030601021611.GA13152@a11a.mannikko1.ton.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531214223.GA21788@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Jones <davej@codemonkey.org.uk>:
> On Sat, May 31, 2003 at 09:33:21PM +0300, Pasi Savolainen wrote:
> > +	/* Clear W4SG, and set PMIOEN, if using a 765/766 set STPGNT as well.
> > +	 * AMD-766: C3A41; page 59 in AMD-766 doc
> > +	 * AMD-768: DevB:3x41C; page 94 in AMD-768 doc */
> > +	pci_read_config_byte(pdev_sb, 0x41, &regbyte);
> > +	if(enable) {
> > +		regbyte |= ((0 << 0) | (is_766?1:0 << 1) | (1 << 7));
>                          ^^^^^^
>  
> This looks totally bogus. If you want that bit clearing, you need
> to AND its inverse, not OR it.  The second statement also looks a
> bit funny to the eye.

AFAICT, it's 'for future expansion', NMC. I'll trim it down. Either way,
that enable seems to work, at least on my machine. As I don't know much
about it, I can't say what's right/wrong.
(I don't have the spec. Only code that does desired thing)

> > +static void
> > +amd76x_smp_idle(void)
> > +{
> > +	/*
> > +	 * Exit idle mode immediately if the CPU does not change.
> > +	 * Usually that means that we have some load on another CPU.
> > +	 */
> > +
> > +	if (prs[0].idle && prs[1].idle && amd76x_pm_cfg.last_pr == smp_processor_id()) {
> > +		prs[0].idle = 0;
> > +		prs[1].idle = 0;
> > +		/* This looks redundent as it was just checked in the if() */
> > +		/* amd76x_pm_cfg.last_pr = smp_processor_id(); */
> 
> except with preemption, it may have changed. This needs to be fixed,
> as noted in the function header. Either get_cpu(),put_cpu() or explicit
> preempt_enable/disable()		

This is idle loop, like we're not doing anything, and if somebody is to
preempt us, then it sure means we're not supposed to idle.

Second point is (I'm _really_ on thin ground here..) that if we get_cpu()
here, and other CPU is sleeping, then it'd be woken up sooner, for cache
will need syncing.

> > +/*
> > + *    Info exported through "/proc/driver/amd76x_pm"
> 
> This should really be using sysfs. Adding extra junk to /proc is
> somewhat frowned upon, and with the other PM stuff now living in
> sysfs, that seems to be the way forward.

done.

> 
> > +static void __exit
> > +amd76x_pm_cleanup(void)
> > +{
> > +#ifndef AMD76X_NTH
> > +	pm_idle = amd76x_pm_cfg.orig_idle;
> > +	wmb();
> > +	//__asm__ __volatile__ ("wbinvd;"); // propagate through SMP
> 
> Not sure why this was there, is it noted in the 766 spec to flush
> the cache ? if so, it needs to be reenabled, and used with on_each_cpu()

Zwane told me to use synchronize_kernel(); it cured my crashes on rmmod
amd76x_pm. -> hack removed.

> Sounds like possible candidate for something that should be exposed
> via sysfs.

done.

Iteration n at
<http://varg.dyndns.org/psi/files/misc/amd76x_pm-2.5.70.patch.bz2>

/sys/devices/pci0/00:00.0/C2_cnt  (ro) number of C2 calls made.
/sys/devices/pci0/00:00.0/lazy_idle (rw) number of successfull idle
 calls to be made before entering C2.


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>
