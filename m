Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030982AbVIIX0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030982AbVIIX0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 19:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030981AbVIIX0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 19:26:12 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:59564 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030362AbVIIX0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 19:26:10 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4321E51F.8040906@adaptec.com>
References: <4321E51F.8040906@adaptec.com>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 18:25:03 -0500
Message-Id: <1126308304.4799.45.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 15:40 -0400, Luben Tuikov wrote:
> +/**
> + * sas_do_lu_discovery -- Discover LUs of a SCSI device
> + * @dev: pointer to a domain device of interest

Aside from all the other problems, this one completely duplicates the
mid-layer infrastructure for handling devices with Logical Units.

> + * Discover logical units present in the SCSI device.  I'd like this
> + * to be moved to SCSI Core, but SCSI Core has no concept of a "SCSI
> + * device with a SCSI Target port".  A SCSI device with a SCSI Target
> + * port is a device which the _transport_ found, but other than that,
> + * the transport has little or _no_ knowledge about the device.
> + * Ideally, a LLDD would register a "SCSI device with a SCSI Target
> + * port" with SCSI Core and then SCSI Core would do LU discovery of
> + * that device.

That would be what scsi_scan_target() actually does.

> + * REPORT LUNS is mandatory.  If a device doesn't support it,
> + * it is broken and you should return it.  Nevertheless, we
> + * assume (optimistically) that the link hasn't been severed and
> + * that maybe we can get to the device anyhow.

That's a surprisingly optimistic statement from someone who claims to
have worked in SCSI for so long.  We have a huge list of heuristics for
devices that violate the standards in one way or another.  We already
have a flag for a SCSI3 device that doesn't respond correctly to
REPORT_LUNS ... and we have a few other reports of potentially more
suspect devices.

Now, if you did this properly and used the mid-layer infrastructure you
wouldn't have to worry about any of this.

> +static int sas_do_lu_discovery(struct domain_device *dev)

Please just handle targets ... scanning beyond targets is best handled
in generic code.

James


