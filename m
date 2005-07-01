Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVGAIBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVGAIBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 04:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVGAIBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 04:01:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11736 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262666AbVGAIBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 04:01:11 -0400
Date: Fri, 1 Jul 2005 10:02:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] kernel BUG at include/linux/blkdev.h:601
Message-ID: <20050701080243.GX2243@suse.de>
References: <20050630153717.GB2243@suse.de> <20050701004801.50905.qmail@web52607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701004801.50905.qmail@web52607.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01 2005, Srihari Vijayaraghavan wrote:
> --- Jens Axboe <axboe@suse.de> wrote:
> > On Thu, Jun 30 2005, Srihari Vijayaraghavan wrote:
> > > --- Srihari Vijayaraghavan
> > > <sriharivijayaraghavan@yahoo.com.au> wrote:
> > [...] 
> > > 2.6.13-rc1 (plus Hugh's get_request patch) doesn't
> > > suffer from this problem, unlike 2.6.12 and
> > 2.6.12-git
> > > releases.
> > 
> > That's a little strange, as there should be no
> > changes in this area so
> > far. Are you 100% sure?
> 
> Absolutely. 2.6.12 and 2.6.12-git9 crash within
> minutes/seconds; OTOH, 2.6.13-rc1 (plus Hugh's patch)
> survives this torture test for hours (despite
> generating 30+ MB of kernel/IDE error messages :). No
> OOPS, no BUGs, no panics, just truck load of error
> messages.
> 
> I haven't tested whether earlier releases of 2.6
> suffer from this (such as 2.6.10, 2.6.11 ..) or other
> hardware combinations exhibit the same problem etc.
> Tell me, if you want me to.

There are some minor ide updates outside of ide-cd, they must be
accounting for your success in 2.6.13-rc1 then. Could you test 2.6.12
with this patch applied?

diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -1181,7 +1181,8 @@ static ide_startstop_t do_reset1 (ide_dr
 		pre_reset(drive);
 		SELECT_DRIVE(drive);
 		udelay (20);
-		hwif->OUTB(WIN_SRST, IDE_COMMAND_REG);
+		hwif->OUTBSYNC(drive, WIN_SRST, IDE_COMMAND_REG);
+		ndelay(400);
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
 		hwgroup->polling = 1;
 		__ide_set_handler(drive, &atapi_reset_pollfunc, HZ/20, NULL);


-- 
Jens Axboe

