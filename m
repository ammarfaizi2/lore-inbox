Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbTLLJUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 04:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTLLJUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 04:20:16 -0500
Received: from cpe.atm2-0-1071046.0x50a5258e.abnxx8.customer.tele.dk ([80.165.37.142]:5029
	"EHLO starbattle.com") by vger.kernel.org with ESMTP
	id S264522AbTLLJUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 04:20:09 -0500
From: Daniel Tram Lux <daniel@starbattle.com>
Date: Fri, 12 Dec 2003 10:20:06 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] ide.c as a module
Message-ID: <20031212092006.GA13250@starbattle.com>
References: <20031211202536.GA10529@starbattle.com> <200312112225.14540.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312112225.14540.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 10:25:14PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> On Thursday 11 of December 2003 21:25, Daniel Tram Lux wrote:
> > Hi,
> 
> Hi,
> 
> > I needed the ide-subsytem as a module on 2.4.23 and noticed (due to the
> > missing modprobe on the embedded linux system) that ide.c tries to load the
> > module ide-probe-mod which is called ide-detect now. The patch also get's
> > rid of the need for ide-probe-mini alias ide-detect, but I don't know if
> > that is desired? (it was in my case).
> 
> It is incorrect, it will make most of modules for PCI IDE chipsets fail
> due to always calling ide_init() from ide.c:init_module().

ide_init is called from ide.c:init_module()
in the original version:

int init_module (void)
{
	parse_options(options);
	return ide_init(); <--------
}


> 
> You need to modprobe ide-detect if you are using generic IDE code
> (no chipset specific driver - probably the case for your embedded system).
> 

I know this, but ide-detect is basically an empty module, only calling ideprobe_init_module()
can't this be done right away from ide.c or are there any reasons to delay the call
until later at a user defined point of time?

> You are right that ide-probe-mini alias is not needed, ide-probe-mini.c should
> be renamed to ide-detect.c (or ide-detect.o to ide-probe-mini.o).
> 
> > --- linux-2.4.23.org/drivers/ide/ide.c  2003-11-28 19:26:20.000000000 +0100
> > +++ linux-2.4.23/drivers/ide/ide.c      2004-03-11 20:31:51.000000000 +0100
> > @@ -514,11 +514,7 @@
> >
> >  void ide_probe_module (int revaldiate)
> >  {
> > -       if (!ide_probe) {
> > -#if  defined(CONFIG_BLK_DEV_IDE_MODULE)
> > -               (void) request_module("ide-probe-mod");
> > -#endif
> > -       } else {
> > +       if (ide_probe) {
> >                 (void) ide_probe->init();
> >         }
> >         revalidate_drives(revaldiate);
> 
> You should make this change in ide_register_hw() instead:
> 
> -		ide_probe_module();
> +#ifdef MODULE
> +		if (ideprobe_init_module() == -EBUSY)
> +#endif
> +			ideprobe_init();

Your patch will (if MODULE is defined) call ideprobe_init() twice, 
once from ideprobe_init_module() and once from ideprobe_init()
should ideprobe_init really not only be called once and only once?


> 
> And get rid of ide_probe pointer.
> 
> --bart
