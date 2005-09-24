Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVIZIXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVIZIXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 04:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVIZIXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 04:23:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:59281 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932428AbVIZIXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 04:23:48 -0400
Date: Fri, 23 Sep 2005 17:48:01 -0700
From: Greg KH <gregkh@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: export ipl device parameters
Message-ID: <20050924004801.GB21283@suse.de>
References: <20050923095002.GA20928@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923095002.GA20928@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 11:50:02AM +0200, Heiko Carstens wrote:
> Hi,
> 
> this is the new "export ipl device parameters" patch with the
> changes integrated as proposed by Greg KH. Now this interface
> resides in /sys/firmware/ipl and all files contain only a single
> value.

Hi, I have a few minor comments on the patch.  It looks much better than
the last one.

> Sysfs interface to export ipl device parameters.
> Dependent on the ipl type the interface will look like this:
> 
> - ccw ipl:
> 
> /sys/firmware/ipl/device
> 		 /ipl_type
> 
> - fcp ipl:
> 
> /sys/firmware/ipl/binary_parameter
> 		 /bootprog
> 		 /br_lba
> 		 /device
> 		 /ipl_type
> 		 /lun
> 		 /scp_data
> 		 /wwpn
> 
> - otherwise (unknown that is):
> 
> /sys/firmware/ipl/ipl_type

Nice interface.

>  
> +#ifdef CONFIG_SYSFS

Does anyone build a s390 kernel without sysfs?  You can probably just
drop this ifdef.

> +#define DEFINE_IPL_ATTR(_name, _format, _value)			\
> +static ssize_t ipl_##_name##_show(struct subsystem *subsys,	\
> +		char *page)					\
> +{								\
> +	return sprintf(page, _format, _value);			\
> +}								\
> +static struct subsys_attribute ipl_##_name##_attr =		\
> +	__ATTR(_name, S_IRUGO, ipl_##_name##_show, NULL);
> +
> +DEFINE_IPL_ATTR(wwpn, "0x%016llx\n", (unsigned long long)
> +		IPL_PARMBLOCK_START->fcp.wwpn);
> +DEFINE_IPL_ATTR(lun, "0x%016llx\n", (unsigned long long)
> +		IPL_PARMBLOCK_START->fcp.lun);
> +DEFINE_IPL_ATTR(bootprog, "%lld\n", (unsigned long long)
> +		IPL_PARMBLOCK_START->fcp.bootprog);
> +DEFINE_IPL_ATTR(br_lba, "%lld\n", (unsigned long long)
> +		IPL_PARMBLOCK_START->fcp.br_lba);

Why have a format field, if you only use the same format?

> +static struct subsys_attribute ipl_type_attr = __ATTR_RO(ipl_type);
> +
> +static ssize_t
> +ipl_device_show(struct subsystem *subsys, char *page)
> +{
> +	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
> +
> +	switch (get_ipl_type()) {
> +	case ipl_type_ccw:
> +		return sprintf(page, "0.0.%04x\n", ipl_devno);
> +	case ipl_type_fcp:
> +		return sprintf(page, "0.0.%04x\n", ipl->fcp.devno);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static struct subsys_attribute ipl_device_attr =
> +	__ATTR(device, S_IRUGO, ipl_device_show, NULL);

Why not use __ATTR_RO() like you did above?

> +#define IPL_PARMBLOCK_ORIGIN	0x2000

You are just directly addressing memory with this address, right?
Shouldn't you iomap it or something first?

thanks,

greg k-h
