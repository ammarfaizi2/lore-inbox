Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWGAKvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWGAKvO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 06:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWGAKvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 06:51:14 -0400
Received: from ns.suse.de ([195.135.220.2]:31210 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750745AbWGAKvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 06:51:13 -0400
From: Neil Brown <neilb@suse.de>
To: Reuben Farrelly <reuben-lkml@reub.net>
Date: Sat, 1 Jul 2006 20:51:03 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17574.21399.979888.127483@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Weird RAID/SATA problem [ once was Re: 2.6.17-mm3 ]
In-Reply-To: message from Reuben Farrelly on Saturday July 1
References: <20060630105401.2dc1d3f3.akpm@osdl.org>
	<44A5C1D5.20200@reub.net>
	<17573.50871.307879.557218@cse.unsw.edu.au>
	<44A5D079.6070505@reub.net>
	<17573.55937.866300.638738@cse.unsw.edu.au>
	<44A6390E.1030608@reub.net>
	<17574.15295.828980.278323@cse.unsw.edu.au>
	<44A64BD8.90906@reub.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday July 1, reuben-lkml@reub.net wrote:
> >>
> >> md: super_written gets error=-5, uptodate=0
> >>
> >> messages on the console that didn't seem to want to stop...
> > 
> > '5' == EIO 
> > 
> > We try to write the superblock and we get EIO - something wrong somewhere.
> > 
> > What sort of device are we writing to here?  What controller, what
> > driver (if you know), what drives?
> 
> The two raid-1 disks are the Seagate ST380817AS SATA disks on the onboard
> controller.  The motherboard is an Intel D945GNT motherboard.  See dmesg..
> 
> > Can you write to the device without using md?
> 
> Yes.
> 

So... When md writes a superblock to this device, it reliably (or
close to reliably) gets EIO.  When mkfs writes, it works fine.

Only difference I can think of is still barriers... Does this patch
make any difference?

NeilBrown

(For readers on linux-kernel who are wondering where the history of
this thread is - you won't find it.  We were having a discussion in
private and finally got embarrassed about keeping such gems to
ourselves so we decided to share)


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-07-01 12:12:14.000000000 +1000
+++ ./drivers/md/md.c	2006-07-01 20:48:44.000000000 +1000
@@ -454,7 +454,7 @@ void md_super_write(mddev_t *mddev, mdk_
 	bio->bi_rw = rw;
 
 	atomic_inc(&mddev->pending_writes);
-	if (!test_bit(BarriersNotsupp, &rdev->flags)) {
+	if (0 && !test_bit(BarriersNotsupp, &rdev->flags)) {
 		struct bio *rbio;
 		rw |= (1<<BIO_RW_BARRIER);
 		rbio = bio_clone(bio, GFP_NOIO);
