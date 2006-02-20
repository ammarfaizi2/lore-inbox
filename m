Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbWBTSUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWBTSUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbWBTSUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:20:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53638 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161104AbWBTSUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:20:48 -0500
Date: Mon, 20 Feb 2006 18:20:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       billion.wu@areca.com.tw, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       erich@areca.com.tw, arjan@infradead.org, oliver@neukum.org
Subject: Re: Areca RAID driver remaining items?
Message-ID: <20060220182045.GA1634@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dax Kelson <dax@gurulabs.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, billion.wu@areca.com.tw,
	alan@lxorguk.ukuu.org.uk, akpm@osdl.org, erich@areca.com.tw,
	arjan@infradead.org, oliver@neukum.org
References: <1140458552.3495.26.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140458552.3495.26.camel@mentorng.gurulabs.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 11:02:32AM -0700, Dax Kelson wrote:
> This appears to be the most current version of the driver:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/broken-out/areca-raid-linux-scsi-driver.patch
> 
> Is this the current TODO list?
> 
> =================
> Issues not yet patched:
> 
> 13. uintNN_t int types:  use kernel types except for userspace
> interfaces
> 14. use kernel-doc
> 18. Put arcmsr.txt in Documentation/scsi/, not in scsi/arcmsr/.
> 19. Maybe use sysfs (/sys) instead of /proc.
> 20. check stack usage, init/exit sections;


 - remove internal queueing
 - fix hardware datastructures
 - remove odd ioctls
 - remove useless forward prototypes
 - give types like ACB useful names
 - give variable useful names, especially follow kernel conventions,
   e.g. a struct pci_dev is usually named pdev
 - kill ->proc_info method
 - use normal comment style even for comments not fitting into the
   kernel-doc item above.  kill useless separator comments without
   text
 - convert arcmsr_show_firmware_info to useful one value per
   file attributes.  best follow the schemes used in aacraid or
   lpfc
 - convert arcmsr_show_driver_state to useful one value per
   file attributes.
 - remove never called release method in the host template
 - audit whether setting unchecked_isa_dma to false really makes
   sense (I strongly doubt it)
 - remove shutdown notifier, add pci_driver ->shutdown method instead
 - remove CameCase PCI Ids.  The vendor Id should go into pci_ids.h,
   the device ids either removed or spelled the normal linux way
 - arcmsr_do_interrupt should stop walking the global host list
   and use the private data passed to request_irq
 - the global host list should go away completely
 - arcmsr_bios_param looks like duplicating the generic CAM version?
 - locking needs to be redone.  If the driver really needs more than
   one per-host lock we'll want a very good explanation
 - arcmsr_device_probe needs to be rewritten to do goto-based
   error unwinding.
 - msi should be a module options if at all, but defintitly not
   a config options
 - arcmsr_scsi_host_template_init should go away.  the host template
   must be initialized statically with no run-time writes to it
 - the hardware documentation should be split out of arcmsr.h
   into a separate file (btw, thanks a lot to areca to provide such
   detailed hardware informations, it's just the wrong format..)
 - remove the SCSISTAT_* defines, and use the generic ones from
   <scsi/scsi.h> instead.  Dito for various other SAM defines.
 - the driver has just two files and should go directly into
   drivers/scsi instead of a subdirectory
