Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030544AbVIORRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030544AbVIORRl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbVIORRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:17:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:6836 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030544AbVIORRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:17:41 -0400
Date: Thu, 15 Sep 2005 10:17:18 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 6/7] s390: ipl device.
Message-ID: <20050915171718.GA9833@kroah.com>
References: <20050914155509.GE11478@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914155509.GE11478@skybase.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 05:55:09PM +0200, Martin Schwidefsky wrote:
> [patch 6/7] s390: ipl device.
> 
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Export the ipl device settings to userspace via the sysfs:
>  * /sys/kernel/ipl_device

What?  Why that location?  Why not in the proper location for your
device, on your bus?

>    Contains a string in on of the following formats:
>    1) "ccw <bus_id>", or 2) "fcp <bus_id>,<wwpn>,<lun>".
>  * /sys/kernel/ipl_parameter
>    is a binary interface that exports the ipl  parameter block for
>    scsi ipl. For non-scsi ipl the ipl_paramter is irrelevant.

Again, put this in your device directory, not in /sys/kernel/


> +static ssize_t
> +ipl_device_show(struct subsystem *subsys, char *page)
> +{
> +	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
> +
> +	if (!IPL_DEVNO_VALID)
> +		goto type_unknown;
> +	if (!IPL_PARMBLOCK_VALID)
> +		goto type_ccw;
> +	if (ipl->hdr.header.version > IPL_MAX_SUPPORTED_VERSION)
> +		goto type_unknown;
> +	if (ipl->fcp.pbt != IPL_TYPE_FCP)
> +		goto type_unknown;
> +
> +	return sprintf(page, "fcp 0.0.%04x,0x%016llx,0x%016llx\n",
> +		       ipl->fcp.devno,
> +		       (unsigned long long) ipl->fcp.wwpn,
> +		       (unsigned long long) ipl->fcp.lun);
> + type_unknown:
> +	return sprintf(page, "unknown\n");
> + type_ccw:
> +	return sprintf(page, "ccw 0.0.%04x\n",ipl_devno);

That doesn't look like a "single value" from a single file there.  Can't
you break that up into individual files, based on what exactly is
present at the time?

thanks,

greg k-h
