Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUJGVVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUJGVVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269779AbUJGVU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:20:27 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:41225 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268331AbUJGVPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:15:40 -0400
Date: Thu, 7 Oct 2004 22:15:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lsml@rtr.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
Message-ID: <20041007221537.A17712@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
	Mark Lord <lsml@rtr.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
References: <4161A06D.8010601@rtr.ca> <416547B6.5080505@rtr.ca> <20041007150709.B12688@infradead.org> <4165624C.5060405@rtr.ca> <416565DB.4050006@pobox.com> <4165A45D.2090200@rtr.ca> <4165A766.1040104@pobox.com> <4165A85D.7080704@rtr.ca> <4165AB1B.8000204@pobox.com> <4165ACF8.8060208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4165ACF8.8060208@rtr.ca>; from lkml@rtr.ca on Thu, Oct 07, 2004 at 04:54:16PM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, skipping the EXPORTs for now, how do you guys
> feel about the driver ?

 - please kill the #ifndef SERVICE_ACTION_IN section
 - please use <scsi/scsi.h> sense data ifdefs instead of adding your own
 - please kill your scsi_to_pci_dma_dirusage, it's been obsoleted for a reason
 - please remove DRPINTK in favour of pr_debug from <linux/kernel.h>
 - please removæ the global host list, not just the exports for it
 - dito for qs_notify
 - code like
 +       if (dev->raid) {
 +               memset(dev->raid, 0, sizeof(struct qs_raid));
 +               kfree(dev->raid);
 +       }
   is totally bogus, you defeat the slab poisoning with that
 - qs_alloc duplicates kcalloc
 - the !dev case in qs_scsi_queuecomman can't happen
 - no need for the case in sc->host_scribble = (void *)(dev->uhba);
 - never mess with eh_timeout from inside a driver
 - please don't implemente the HDIO_ ioctls, Jeff said this can
   be done via SG_IO
 - if ->info return a static string you can just store it into ->name
 - please don't discard the exact error returned from
   pci_enable_device(pdev)
 - never call scsi_set_device() in a new driver, scsi_add_host does that for
   you
 - never use scsi_assign_lock in a new driver, the midlayer already has
   a per-host lock for you
 - please use the kernel/kthread.c interface for your kernel thread
 - never cast your ioregs before iounmap.
 - in fact it looks like you want to run sparse over the driver and
   fix up everything it found - at least __iomem annotations are missing
 - please don't use set_fs(KERNEL_DS), split up the underlying code for
   user and kernel buffers

This was just a quick 5 minute review, I'll give it a deeper look once I get a
little bit more time.
