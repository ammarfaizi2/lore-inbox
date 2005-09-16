Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVIPV50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVIPV50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVIPV50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:57:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:37261 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750704AbVIPV50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:57:26 -0400
Date: Fri, 16 Sep 2005 14:39:14 -0700
From: Greg KH <greg@kroah.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 6/7] s390: ipl device.
Message-ID: <20050916213914.GA13807@kroah.com>
References: <20050914155509.GE11478@skybase.boeblingen.de.ibm.com> <20050915171718.GA9833@kroah.com> <20050916071444.GA11851@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916071444.GA11851@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 09:14:44AM +0200, Heiko Carstens wrote:
> > > Export the ipl device settings to userspace via the sysfs:
> > >  * /sys/kernel/ipl_device
> > What?  Why that location?  Why not in the proper location for your
> > device, on your bus?
> 
> This interface tells from where the kernel was booted from.

Then why not use /sys/firmware/ipl/ ?  That matches the
/sys/firmware/edd usage we currently have on x86 boxes.

> > > +static ssize_t
> > > +ipl_device_show(struct subsystem *subsys, char *page)
> > > +{
> > > +	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
> > > +
> > > +	if (!IPL_DEVNO_VALID)
> > > +		goto type_unknown;
> > > +	if (!IPL_PARMBLOCK_VALID)
> > > +		goto type_ccw;
> > > +	if (ipl->hdr.header.version > IPL_MAX_SUPPORTED_VERSION)
> > > +		goto type_unknown;
> > > +	if (ipl->fcp.pbt != IPL_TYPE_FCP)
> > > +		goto type_unknown;
> > > +
> > > +	return sprintf(page, "fcp 0.0.%04x,0x%016llx,0x%016llx\n",
> > > +		       ipl->fcp.devno,
> > > +		       (unsigned long long) ipl->fcp.wwpn,
> > > +		       (unsigned long long) ipl->fcp.lun);
> > > + type_unknown:
> > > +	return sprintf(page, "unknown\n");
> > > + type_ccw:
> > > +	return sprintf(page, "ccw 0.0.%04x\n",ipl_devno);
> > 
> > That doesn't look like a "single value" from a single file there.  Can't
> > you break that up into individual files, based on what exactly is
> > present at the time?
> 
> Sure, so I would end up with quite a few files:

That's fine to have.

> always a file which tells the type of ipl e.g. ipl_type and dependent
> on that additionally:
> - in case of ccw ipl:
>    just the bus_id of the ipl device (e.g. ipl_bus_id).
> - in case of fcp ipl:
>    the bus_id, the wwpn and the fcp_lun all exported via different files.
> 
> Does that sound reasonable?

Yes.

thanks,

greg k-h
