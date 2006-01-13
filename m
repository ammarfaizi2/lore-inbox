Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWAMPvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWAMPvS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWAMPvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:51:18 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:16084 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1422717AbWAMPvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:51:18 -0500
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: axboe@suse.de, bzolnier@gmail.com, rmk@arm.linux.org.uk,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
References: <11371658562541-git-send-email-htejun@gmail.com>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 09:50:19 -0600
Message-Id: <1137167419.3365.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-14 at 00:24 +0900, Tejun Heo wrote:
> This patchset tries to fix data corruption bug caused by not handling
> cache coherency during block PIO.  This patch implements
> blk_kmap/unmap helpers which take extra @dir argument and perform
> appropriate coherency actions.  These are to block PIO what dma_map/
> unmap are to block DMA transfers.
> 
> IDE, libata, SCSI, rd and md are converted.  Still left are nbd, loop
> and pktcddvd.  If I missed something, please let me know.
> 
> Russell, can you please test whether this fixes the bug on arm?  If
> this fixes the bug and people agree with the approach, I'll follow up
> with patches for yet unconverted drivers and documentation update.

Actually, this doesn't look to be the correct thing to do.  The
dma_map/unmap don't make the data coherent with respect to the user
space, only with respect to the kernel space.  I've never liked this
(and indeed I wrote an OLS paper in 2004 trying to explain how we could
fix it) but that's our current model.

Our classic path for data on machines is that the driver makes the
kernel coherent and then whatever's transferring from the page cache to
the user makes user space coherent.  It sounds, therefore, like
whatever's broken (what is the problem, by the way?) is broken in the
second half (page cache to user) not in the first half (driver to
kernel).

James


