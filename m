Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVLGRQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVLGRQQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVLGRQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:16:15 -0500
Received: from fmr13.intel.com ([192.55.52.67]:21383 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751214AbVLGRQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:16:14 -0500
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
From: Shaohua Li <shaohua.li@intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
       pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, akpm <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0512061557420.5519@shark.he.net>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <Pine.LNX.4.58.0512061557420.5519@shark.he.net>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 09:15:57 +0800
Message-Id: <1133918157.2936.5.camel@sli10-mobl.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 16:11 -0800, Randy.Dunlap wrote:
> On Tue, 6 Dec 2005, Shaohua Li wrote:
> 
> > Hi,
> > Adding ACPI IDE hook in IDE suspend/resume. The ACPI spec
> > explicitly says we must call some ACPI methods to restore IDE drives.
> > The sequences defined by ACPI spec are:
> > suspend:
> > 1. Get the DMA and PIO info from IDE channel's _GTM method.
> >
> > resume:
> > 1. Calling IDE channel's _STM to set the transfer timing setting.
> > 2. For each drive on the IDE channel, running drive's _GTF to get the
> > ATA commands required to reinitialize each drive.
> > 3. Sending the ATA commands gotton from step 2 to drives.
> >
> > TODO: invoking ATA commands.
> >
> > Though we didn't invoke ATA commands, this patch fixes the bug at
> > http://bugzilla.kernel.org/show_bug.cgi?id=5604. And Matthew said this
> > actually fixes a lot of systems in his test.
> > I'm not familiar with IDE, so comments/suggestions are welcome.
> >
> > ---
> >
> >  linux-2.6.15-rc5-root/drivers/ide/ide.c |  282 ++++++++++++++++++++++++++++++++
> >  1 files changed, 282 insertions(+)
> >
> > diff -puN drivers/ide/ide.c~acpi-ide drivers/ide/ide.c
> > --- linux-2.6.15-rc5/drivers/ide/ide.c~acpi-ide	2005-12-07 03:01:36.000000000 +0800
> > +++ linux-2.6.15-rc5-root/drivers/ide/ide.c	2005-12-07 03:01:36.000000000 +0800
> > @@ -155,6 +155,10 @@
> >  #include <linux/device.h>
> >  #include <linux/bitops.h>
> >
> > +#ifdef CONFIG_ACPI
> > +#include <linux/acpi.h>
> > +#endif
> 
> Shouldn't need or use ifdef/endif for #includes.
Ok.

> > +
> > +/* The _GTM return package length is 5 dwords */
> > +#define GTM_LEN (sizeof(u32) * 5)
> > +struct acpi_ide_state {
> > +	acpi_handle handle; /* channel device's handle */
> > +	u32 gtm[GTM_LEN/sizeof(u32)]; /* info from _GTM */
> > +	struct hd_driveid id_buff[2]; /* one chanel has two drives */
> 
> s/2/MAX_DRIVES/
> s/chanel/channel/
:), thanks!

> > +	if (!handle) {
> > +		printk(KERN_DEBUG "IDE device's ACPI handler is NULL\n");
> 
> s/handler/handle/ ??
A typo.


> > +	status = acpi_evaluate_object(parent_handle, "_GTM", NULL, &buffer);
> > +	if (ACPI_FAILURE(status)) {
> > +		printk(KERN_ERR "Error evaluating _GTM\n");
> 
> I don't read the ACPI spec. as saying that _GTM is required, (?)
> so I would make this a KERN_DEBUG instead of KERN_ERR.
Yes, _GTM is required.


> > +	status = acpi_evaluate_object(state->handle, "_STM", &input, NULL);
> > +	if (ACPI_FAILURE(status)) {
> > +		printk(KERN_ERR "Evaluating _STM error\n");
> 
> Same as for _GTM, KERN_DEBUG instead of KERN_ERR.
_STM also is required.

> > +	acpi_status status;
> > +
> > +	status = acpi_evaluate_object(handle, "_GTF", NULL, &output);
> > +	if (ACPI_FAILURE(status)) {
> > +		printk(KERN_ERR "evaluate _GTF error\n");
> 
> KERN_DEBUG if not present since it's not required AFAIK.
Actually it's required, but I have no idea how to invoke the ata
commands gotten from _GTF.

Thanks for your time. I'll update this patch as you suggested after the
IDE gurus think it's ok.

Thanks,
Shaohua

