Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTEaV0M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 17:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264458AbTEaV0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 17:26:12 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:36000 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264456AbTEaV0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 17:26:10 -0400
Date: Sat, 31 May 2003 22:42:23 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Pasi Savolainen <psavo@iki.fi>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] amd76x_pm port to 2.5.70
Message-ID: <20030531214223.GA21788@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Pasi Savolainen <psavo@iki.fi>, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030531183321.GA3408@varg.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531183321.GA3408@varg.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 09:33:21PM +0300, Pasi Savolainen wrote:
 > +	/* Clear W4SG, and set PMIOEN, if using a 765/766 set STPGNT as well.
 > +	 * AMD-766: C3A41; page 59 in AMD-766 doc
 > +	 * AMD-768: DevB:3x41C; page 94 in AMD-768 doc */
 > +	pci_read_config_byte(pdev_sb, 0x41, &regbyte);
 > +	if(enable) {
 > +		regbyte |= ((0 << 0) | (is_766?1:0 << 1) | (1 << 7));
                         ^^^^^^
 
This looks totally bogus. If you want that bit clearing, you need
to AND its inverse, not OR it.  The second statement also looks a
bit funny to the eye.
								 
 > +	}
 > +	else {
 > +		regbyte |= (0 << 7);

Ditto.
 
 > +/*
 > + * Idle loop for SMP systems, supports currently only 2 processors.
 > + *
 > + * Note; for 2.5 folks - not pre-empt safe

Indeed.

 > +static void
 > +amd76x_smp_idle(void)
 > +{
 > +	/*
 > +	 * Exit idle mode immediately if the CPU does not change.
 > +	 * Usually that means that we have some load on another CPU.
 > +	 */
 > +
 > +	if (prs[0].idle && prs[1].idle && amd76x_pm_cfg.last_pr == smp_processor_id()) {
 > +		prs[0].idle = 0;
 > +		prs[1].idle = 0;
 > +		/* This looks redundent as it was just checked in the if() */
 > +		/* amd76x_pm_cfg.last_pr = smp_processor_id(); */

except with preemption, it may have changed. This needs to be fixed,
as noted in the function header. Either get_cpu(),put_cpu() or explicit
preempt_enable/disable()		

 > +
 > +/*
 > + *    Info exported through "/proc/driver/amd76x_pm"

This should really be using sysfs. Adding extra junk to /proc is
somewhat frowned upon, and with the other PM stuff now living in
sysfs, that seems to be the way forward.

 > +static void __exit
 > +amd76x_pm_cleanup(void)
 > +{
 > +#ifndef AMD76X_NTH
 > +	pm_idle = amd76x_pm_cfg.orig_idle;
 > +	wmb();
 > +	//__asm__ __volatile__ ("wbinvd;"); // propagate through SMP

Not sure why this was there, is it noted in the 766 spec to flush
the cache ? if so, it needs to be reenabled, and used with on_each_cpu()

 > +	/* 
 > +	 * FIXME: We want to wait until all CPUs have set the new
 > +	 * idle function, otherwise we will oops. This may not be
 > +	 * the right way to do it, but seems to work.
 > +	 *
 > +	 * - Best answer is going to be to ban unload, but when its debugged
 > +	 *   --- Alan
 > +	 */
 > +	schedule();
 > +	mdelay(1000);

Ummmm, oh-kay. That's a little funky. Look at how the MTRR driver
does its synchronisation, it maybe sucky, but it looks a little
cleaner than this IMO.


 > +#define LAZY_IDLE_DELAY	800	/* 0: Best savings,  3000: More responsive */

Sounds like possible candidate for something that should be exposed
via sysfs.


		Dave

