Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264570AbTLLN2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbTLLN2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:28:36 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12475 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264570AbTLLN2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:28:30 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Daniel Tram Lux <daniel@starbattle.com>
Subject: Re: [patch] ide.c as a module
Date: Fri, 12 Dec 2003 14:30:36 +0100
User-Agent: KMail/1.5.4
References: <20031211202536.GA10529@starbattle.com> <200312112225.14540.bzolnier@elka.pw.edu.pl> <20031212092006.GA13250@starbattle.com>
In-Reply-To: <20031212092006.GA13250@starbattle.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312121430.36735.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 of December 2003 10:20, Daniel Tram Lux wrote:
> On Thu, Dec 11, 2003 at 10:25:14PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 11 of December 2003 21:25, Daniel Tram Lux wrote:
> > > Hi,
> >
> > Hi,
> >
> > > I needed the ide-subsytem as a module on 2.4.23 and noticed (due to the
> > > missing modprobe on the embedded linux system) that ide.c tries to load
> > > the module ide-probe-mod which is called ide-detect now. The patch also
> > > get's rid of the need for ide-probe-mini alias ide-detect, but I don't
> > > know if that is desired? (it was in my case).
> >
> > It is incorrect, it will make most of modules for PCI IDE chipsets fail
> > due to always calling ide_init() from ide.c:init_module().
>
> ide_init is called from ide.c:init_module()
> in the original version:
>
> int init_module (void)
> {
> 	parse_options(options);
> 	return ide_init(); <--------
> }

I was thinking about ideprobe_init_module() not ide_init() :-).

> > You need to modprobe ide-detect if you are using generic IDE code
> > (no chipset specific driver - probably the case for your embedded
> > system).
>
> I know this, but ide-detect is basically an empty module, only calling
> ideprobe_init_module() can't this be done right away from ide.c or are
> there any reasons to delay the call until later at a user defined point of
> time?

YES.  If you have some PCI IDE, you must load PCI chipset module before
loading ide-detect.o otherwise (you load ide-detect.o before your PCI chipset
module) generic IDE driver will own your IDE ports and you cannot use your
specific PCI chipset driver.

> > You are right that ide-probe-mini alias is not needed, ide-probe-mini.c
> > should be renamed to ide-detect.c (or ide-detect.o to ide-probe-mini.o).
> >
> > > --- linux-2.4.23.org/drivers/ide/ide.c  2003-11-28 19:26:20.000000000
> > > +0100 +++ linux-2.4.23/drivers/ide/ide.c      2004-03-11
> > > 20:31:51.000000000 +0100 @@ -514,11 +514,7 @@
> > >
> > >  void ide_probe_module (int revaldiate)
> > >  {
> > > -       if (!ide_probe) {
> > > -#if  defined(CONFIG_BLK_DEV_IDE_MODULE)
> > > -               (void) request_module("ide-probe-mod");
> > > -#endif
> > > -       } else {
> > > +       if (ide_probe) {
> > >                 (void) ide_probe->init();
> > >         }
> > >         revalidate_drives(revaldiate);
> >
> > You should make this change in ide_register_hw() instead:
> >
> > -		ide_probe_module();
> > +#ifdef MODULE
> > +		if (ideprobe_init_module() == -EBUSY)
> > +#endif
> > +			ideprobe_init();
>
> Your patch will (if MODULE is defined) call ideprobe_init() twice,
> once from ideprobe_init_module() and once from ideprobe_init()
> should ideprobe_init really not only be called once and only once?

No, think about loading chipset modules.  Some (i.e. ide-cs.o) are
calling ide_register_hw() and expect that this function will probe drives
(without need to load ide-detect.o by user).  Change above preserves
current behavior (note that you may have more than one chipset module).

The same (probing for drives by chipset module) can be done for PCI
drivers but requires a some more work in case of 2.4.x kernels.

--bart

> > And get rid of ide_probe pointer.
> >
> > --bart

