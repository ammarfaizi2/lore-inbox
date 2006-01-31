Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWAaLxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWAaLxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 06:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWAaLxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 06:53:30 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:44955 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1750768AbWAaLx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 06:53:29 -0500
Date: Tue, 31 Jan 2006 12:53:43 +0100
From: Sander <sander@humilis.net>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: [OT] 8-port AHCI SATA Controller?
Message-ID: <20060131115343.GA2580@favonius>
Reply-To: sander@humilis.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Uptime: 11:59:51 up  1:42, 10 users,  load average: 0.13, 0.22, 0.18
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm looking for an 8-port SATA controller based on the AHCI chipset, as
according to http://linux.yyz.us/sata/sata-status.html#vendor_support
this chipset is completely open.

I've searched the websides of the companies which according to
http://linux.yyz.us/sata/sata-status.html#ahci base some of their
products on this chipset, but I couldn't find an 8-port controller.

I've also googled, but without success, hence this somewhat offtopic
message. Although I hope the response helps others in their quest.

The question: does an 8-port AHCI based SATA controller exist? And if,
where can I find it? 12, 16 or 24 ports will do too. I don't need HW
raid, just JBOD.


Some background info: I have a 24-disk chassis which is currently filled
with 7 disks, and will soon be filled with 12 disks. The 7 disks are
spread across two Promise SX8 controllers and the onboard nVidia
controller. 3 On each SX8 and one onboard. The disks have a small
partition dedicated to SW raid1 and a large partition dedicated to SW
raid5. One disk acts as a spare.

The performance of the SX8 is very bad because the in-kernel driver
handles one request per controller to safeguard against corruption.

This is what the comment in drivers/block/sx8.c states:

/*
 * SX8 hardware has a single message queue for all ATA ports.
 * When this driver was written, the hardware (firmware?) would
 * corrupt data eventually, if more than one request was outstanding.
 * As one can imagine, having 8 ports bottlenecking on a single
 * command hurts performance.
 *
 * Based on user reports, later versions of the hardware (firmware?)
 * seem to be able to survive with more than one command queued.
 *
 * Therefore, we default to the safe option -- 1 command -- but
 * allow the user to increase this.
 *
 * SX8 should be able to support up to ~60 queued commands
 * (CARM_MAX_REQ),
 * but problems seem to occur when you exceed ~30, even on newer
 * hardware.
 */
static int max_queue = 1;


In my tests with 'static int max_queue' I tried 30, 16, 4 and 2. With 30
and 16 I get instant corruption on the fs (ext3, which remounts ro
quickly on error). With 4 I need to hit it a bit harder to see
corruption, and with 2 the fs is rock solid.

o The performance with anything larger than 2 seems acceptable.
o It was also harder to hit with larger chunk sizes for the SW raid.

I've flashed the SX8 controllers with the latest BIOS/firmware, so
that's not the problem. NCQ is disabled in the SX8 BIOS, as the
in-kernel driver doesn't support NCQ and others have reported instant
corruption with NCQ enabled.

I've contacted Promise Support about this (including the sx8.c comment
and my findings). They replied:

===
   Case Solution: I have not seen this problem in any os.

   We populate all the drives and then put data into all seperate
   logical drives. It has worked fine. One problem that you might be
   having is that you are creating one large volume with a bunch of
   smaller volume. This card is not made for that.

   If you need a raid card use a card with a raid engine. If your trying
   to software raid it your going to get errors.

   I have not seen what you are talking about because we use this card
   for basic or ext 3 ext 2 single hard drives. Try doing this that way.
===

This nonsense reply made me quite angry and disappointed with Promise.
The SX8 seemed a realy nice controller for a good price if you only need
JBOD support. But I guess in the end you always get what you pay for.

FWIW, this is with a pure 64bit kernel 2.6.16-rc1 on a Tyan K8SE
motherboard.

Thanks a lot in advance.

	With kind regards, Sander
