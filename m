Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264149AbTDOXBx (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 19:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbTDOXBx 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 19:01:53 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:8645 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264149AbTDOXBu (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 19:01:50 -0400
Message-ID: <3E9C8FE2.8040001@myrealbox.com>
Date: Tue, 15 Apr 2003 16:04:02 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
References: <fa.chdor2j.u72387@ifi.uio.no> <fa.gs8uudl.196640l@ifi.uio.no>
In-Reply-To: <fa.gs8uudl.196640l@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:
> On Sun, Apr 13, 2003 at 07:44:04PM +0200, Gert Vervoort wrote:
> 
> Here is a patch against 2.5.67, can you try it out?
> 
> I did not compile let alone run with this patch.
> 
> We never hold the host_lock while calling the detect function (unlike the
> io_request_lock, see the bizzare 2.4 code), so acquiring it inside
> ppa_detect is very wrong. I don't know why your scsi scan did not hang.
> 
> --- linux-2.5.67/drivers/scsi/ppa.c-orig	Mon Apr  7 10:31:47 2003
> +++ linux-2.5.67/drivers/scsi/ppa.c	Tue Apr 15 11:54:34 2003
> @@ -219,15 +219,12 @@
>  	    printk("  supported by the imm (ZIP Plus) driver. If the\n");
>  	    printk("  cable is marked with \"AutoDetect\", this is what has\n");
>  	    printk("  happened.\n");
> -	    spin_lock_irq(hreg->host_lock);
>  	    return 0;
>  	}
>  	try_again = 1;
>  	goto retry_entry;
> -    } else {
> -	spin_lock_irq(hreg->host_lock);
> +    } else
>  	return 1;		/* return number of hosts detected */
> -    }
>  }
>  
>  /* This is to give the ppa driver a way to modify the timings (and other


Yes!  Thank you.  This patch fixes the segfault of modprobe that I've 
been seeing for ages.

Note that the problems I have been seeing are completely different from 
Geert's problems.  I have had no problems mounting a FAT-16 fs with the 
2.5.x kernels but modprobe has been segfaulting all along, even though 
the ppa module works fine for me once it has been loaded.

When I compile ppa into the kernel I see a kernel panic during bootup.
I will also try compiling your patch into the kernel and see if it
prevents the panic.

The parallel Zip drive is the only scsi device I have, so I can't 
comment on the more general situation.  This is the scsi section
of my kernel config:

# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_DC390T is not set


