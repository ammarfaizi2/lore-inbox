Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUKFRJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUKFRJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 12:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUKFRJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 12:09:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51879 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261424AbUKFRJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 12:09:52 -0500
Message-ID: <418D0553.902@pobox.com>
Date: Sat, 06 Nov 2004 12:09:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: achew <achew@nvidia.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] sata_nv.c, don't have libata perform phy reset
References: <418C3D3A.6010501@nvidia.com>
In-Reply-To: <418C3D3A.6010501@nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

achew wrote:
> This patch works around the issue reported in bug 3352 on the bugzilla 
> bug database.
> 
> Link to the bug report: http://bugme.osdl.org/show_bug_cgi?id=3352
> 
> In particular, we keep libata from performing the phy reset.  Doing the 
> phy reset sometimes results in the busy bit failing to deassert.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> 
> 
> --- linux-2.6.10-rc1-bk15/drivers/scsi/sata_nv.c    2004-11-05 
> 17:49:37.000000000 -0800
> +++ linux/drivers/scsi/sata_nv.c    2004-11-05 17:55:48.000000000 -0800
> @@ -20,6 +20,9 @@
>  *  If you do not delete the provisions above, a recipient may use your
>  *  version of this file under either the OSL or the GPL.
>  *
> + *  0.04
> + *     - Disabled SATA phy reset to work around a problem where busy 
> bit never
> + *       deasserts after a phy reset.
>  *  0.03
>  *     - Fixed a bug where the hotplug handlers for non-CK804/MCP04 were 
> using
>  *       mmio_base, which is only set for the CK804/MCP04 case.
> @@ -44,7 +47,7 @@
> #include <linux/libata.h>
> 
> #define DRV_NAME            "sata_nv"
> -#define DRV_VERSION            "0.03"
> +#define DRV_VERSION            "0.04"
> 
> #define NV_PORTS            2
> #define NV_PIO_MASK            0x1f
> @@ -221,7 +224,6 @@
> static struct ata_port_info nv_port_info = {
>     .sht        = &nv_sht,
>     .host_flags    = ATA_FLAG_SATA |
> -              ATA_FLAG_SATA_RESET |
>               ATA_FLAG_SRST |


I'm not quite ready to apply this just yet.  Reasons:

1) The code has two resets!  I think it would be best to remove 
ATA_FLAG_SRST, since SATA reset should cover that.

2) Once ATA_FLAG_SRST is removed, if the problem still appears, I would 
prefer that you root-caused this problem.  If it's a problem with the 
generic libata SATA reset code, I would prefer to fix that, rather than 
keep working around a bug that should be fixed.

	Jeff



