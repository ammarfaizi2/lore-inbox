Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269171AbUIHWIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269171AbUIHWIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 18:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269176AbUIHWIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 18:08:14 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:45802 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269171AbUIHWIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 18:08:01 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Subject: Re: [PATCH] sgiioc4 driver needs /proc/ide entries
Date: Wed, 8 Sep 2004 21:01:48 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <Pine.SGI.4.53.0409081059500.77854@subway.americas.sgi.com> <200409081940.13597.bzolnier@elka.pw.edu.pl> <Pine.SGI.4.53.0409081323210.87183@subway.americas.sgi.com>
In-Reply-To: <Pine.SGI.4.53.0409081323210.87183@subway.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082101.49144.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 September 2004 20:28, Erik Jacobson wrote:
> Hi.  Thanks for the response.
> 
> I'm fine zapping the /proc/ide/sgiioc4 part of the patch.  I didn't want
> it anyway - I just put it there because it was what everybody else did.
> 
> The important part of the patch is this added line:
>   create_proc_ide_interfaces();
> 
> Without this line, /proc/ide contains only the file "drivers".
> 
> I believe this is because the sgiioc4_ide_setup_pci_device function
> is our own version of ide_setup_pci_device.  Since we don't call
> ide_setup_pci_device, create_proc_ide_interfaces is never called
> otherwise - so /proc/ide isn't populated properly.

Oh yes, you are right.  I completely forgot about this fact.
Could you resend minimal patch (without /proc/ide/sgiioc4)?

Thanks.

> On Wed, 8 Sep 2004, Bartlomiej Zolnierkiewicz wrote:
> 
> >
> > On Wednesday 08 September 2004 18:17, Erik Jacobson wrote:
> > > The patch below makes it so the proper /proc/ide files are created when
> > > this driver is loaded.  Previously, /proc/ide would be empty even though
> >
> > This patch only adds /proc/ide/sgiioc4 entry.
> > /proc/ide should be properly populated without it.
> >
> > > the devices could be used, etc.  This is creating problems for us because
> > > some installers and daemons expect the proc files to be in place.
> >
> > Please name these installers and daemons.
> >
> > If your application is checking for /proc/ide/sgiioc4 this is WRONG.
> >
> > Please tell us what do you need this information for and we can
> > see what can be done.
> >
> > > We're open to comments but would appreciate this being accepted ASAP
> > > as this problem is affecting our progress on some projects.
> > >
> > > I verified this exact patch works on 2.6.9-rc1 (and it applies without
> > > fuzz).
> > >
> > > One thing I'll probably hear about is that we create /proc/ide/sgiioc4
> > > but don't produce info and metrics for it.  We may elect to produce some
> >
> > Actually no, these /proc/ide/<chipset> entries are just bloat and should
> > be removed - basic info should be always printed on the console (i.e. while
> > changing transfer mode) and more advanced info should be only printed
> > while debugging driver.
> >
> > > metrics later but this driver is used primarily for the system CDROM and
> > > having metrics there isn't a priority at this moment.  So I create the proc
> > > file anyway but it just reports the type of driver it is.
> > >
> > > diffstat:
> > >
> > >  drivers/ide/pci/sgiioc4.c |   33 +++++++++++++++++++++++++++++++++
> > >  1 files changed, 33 insertions(+)
> > >
> > > Signed-off-by: Erik Jacobson <erikj@sgi.com>
> > >
> > >
> > > diff -Naru linux-2.6.8-orig/drivers/ide/pci/sgiioc4.c linux-2.6.8/drivers/ide/pci/sgiioc4.c
> > > --- linux-2.6.8-orig/drivers/ide/pci/sgiioc4.c	2004-08-14 01:36:58.000000000 -0400
> > > +++ linux-2.6.8/drivers/ide/pci/sgiioc4.c	2004-09-08 08:40:39.624159397 -0400
> > > @@ -34,6 +34,7 @@
> > >  #include <linux/mm.h>
> > >  #include <linux/ioport.h>
> > >  #include <linux/blkdev.h>
> > > +#include <linux/proc_fs.h>
> > >  #include <asm/io.h>
> > >
> > >  #include <linux/ide.h>
> > > @@ -92,6 +93,27 @@
> > >  #define IOC4_PRD_BYTES       16
> > >  #define IOC4_PRD_ENTRIES     (PAGE_SIZE /(4*IOC4_PRD_BYTES))
> > >
> > > +/* Used so we only try to create the /proc/ide/sgiioc4 entry once. */
> > > +static u8 sgiioc4_proc;
> > > +
> > > +/* Produce output for /proc/ide/sgiioc4:
> > > + * At this point, we don't produce any metrics information.
> > > + * Still, it seems we should create this so we behave like other IDE
> > > + * drivers do.  Perhaps someone will write in metrics information some day
> > > + * and that can be hooked in here.
> > > + */
> > > +static int sgiioc4_get_info(char *buffer, char **addr, off_t offset, int count)
> > > +{
> > > +	char *p = buffer;
> > > +	int len;
> > > +
> > > +	p += sprintf(p, "\nSGI IOC4 IDE Driver\n");
> > > +	p += sprintf(p, "This space may be used in the future for metrics.\n");
> > > +
> > > +	len = (p - buffer) - offset;
> > > +	*addr = buffer + offset;
> > > +	return len > count ? count : len;
> > > +}
> > >
> > >  static void
> > >  sgiioc4_init_hwif_ports(hw_regs_t * hw, unsigned long data_port,
> > > @@ -702,6 +724,10 @@
> > >  		       hwif->name, d->name);
> > >
> > >  	probe_hwif_init(hwif);
> > > +
> > > +	/* Create /proc/ide entries */
> > > +	create_proc_ide_interfaces();
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -732,6 +758,13 @@
> > >
> > >  	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
> > >  	class_rev &= 0xff;
> > > +
> > > +	/* create /proc/ide/sgiioc4 entry */
> > > +	if (!sgiioc4_proc) {
> > > +		ide_pci_create_host_proc("sgiioc4", sgiioc4_get_info);
> > > +		sgiioc4_proc = 1;
> > > +	}
> > > +
> > >  	printk(KERN_INFO "%s: IDE controller at PCI slot %s, revision %d\n",
> > >  			d->name, dev->slot_name, class_rev);
> > >  	if (class_rev < IOC4_SUPPORTED_FIRMWARE_REV) {
> > >
> > >
> >
> 
> --
> Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
> 
> 
