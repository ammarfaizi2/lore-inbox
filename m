Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVBZTXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVBZTXS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 14:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVBZTXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 14:23:18 -0500
Received: from mailhost.netengine1.com ([209.237.6.203]:9229 "EHLO
	netengine1.com") by vger.kernel.org with ESMTP id S261262AbVBZTXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 14:23:06 -0500
Date: Sat, 26 Feb 2005 11:29:57 -0800
Message-Id: <200502261129.AA15598038@netengine1.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Soo Lee" <slee@netengine1.com>
Reply-To: <slee@netengine1.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] fix units/partition count in sd.c (2.4.x)
X-Mailer: <IMail v6.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your attention.
I think It only matters when there're many scsi controllers but less disks like one disk per controller.

Even in such case
The main user of nr_real does
genhd.c:part_show()
        /* show the full disk and all non-0 size partitions of it */
        for (n = 0; n < (gp->nr_real << gp->minor_shift); n++) {
                if (gp->part[n].nr_sects) {

It's very tight loop when there's no real device.
If "(gp->nr_real << gp->minor_shift)" part is taken out from the loop
it'll be much more efficient.

And much simpler proof of "It's safe" is that
we are already living with monsters.
./drivers/md/md.c:      nr_real: MAX_MD_DEVS,   == 256
./drivers/md/lvm.c:     .nr_real        = MAX_LV,  ==  256

So using md or lvm simply adds overhead of 16 scsi controllers.
So we are safe or we are not safe already.

Soohoon Lee.

---------- Original Message ----------------------------------
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Date: Sat, 26 Feb 2005 10:48:52 -0300

>On Wed, Feb 16, 2005 at 11:23:53AM -0500, Luben Tuikov wrote:
>> Hi,
>> 
>> This patch fixes the nr_real count in sd.c, which is also used
>> in genhd.c to print out the partitions/units.  The problem is that
>> nr_real is decremented on detach, the genhd's nr_sects is
>> cleared but the entry is still there and is being counted
>> for when displaying the partitions.  Thus when nr_real
>> is decremented _and_ a 0-ed partition/unit is counted,
>> we get to not display 1 or more entries of the tail of
>> the list.
>> 
>> The solution is to not decrement nr_real on detach, effectively
>> never decrementing it, and so that it doesn't grow without a bound,
>> to throttle it on attach, incrementing it only if it would be
>> smaller than nr_dev.
>> 
>> This was observed on a RH kernel and on the current BK kernel.
>> Tested and fixed on 2.4.30-pre1 (BK).  This patch is against 2.4.30-pre1.
>> 
>> To reproduce: assume 4 scsi disks sda, sdb, sdc, sdd.
>> #echo "scsi remove-single-device <sdb-HCTL>" > /proc/scsi/scsi
>> #cat /proc/partitions
>> <<sdb _and_ sdd are not listed>>
>
>Luben,
>
>On James Bottomley advice I have applied Soo Lee's fix, which looks cleaner.
>
>Also as James notice this will increase overhead of /proc/partitions which might be
>a problem on higher-end systems with many devices. 
>
>Testing of it on such systems is highly appreciated.
>
>
># 05/02/26      slee@netengine1.com     1.1558
># [PATCH] Fix units/partition count in sd.c
>#
># Symptom:
>#    When a scsi disk is removed other scsi disk with biggest minor #
>#    disapears in /proc/partition at the same time.
>#
># Cause and fix:
>#    sd.c decreases nr_real on disk removal but because nr_real is not
>#    real # of devices but max # of devices of a major #,
>#    it doesn't need to be changed on disk add/remove.
>#
># 2.6 has little different structure but it does like this
>#
># sd.c:sd_probe()
>#       gd->minors = 16;
># --------------------------------------------
>#
>diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>--- a/drivers/scsi/sd.c Sat Feb 26 10:46:42 2005
>+++ b/drivers/scsi/sd.c Sat Feb 26 10:46:42 2005
>@@ -1220,7 +1220,7 @@
>                        goto cleanup_gendisks_part;
>                memset(sd_gendisks[i].part, 0, (SCSI_DISKS_PER_MAJOR << 4) * sizeof(struct hd_struct));
>                sd_gendisks[i].sizes = sd_sizes + (i * SCSI_DISKS_PER_MAJOR << 4);
>-               sd_gendisks[i].nr_real = 0;
>+               sd_gendisks[i].nr_real = SCSI_DISKS_PER_MAJOR;
>                sd_gendisks[i].real_devices =
>                    (void *) (rscsi_disks + i * SCSI_DISKS_PER_MAJOR);
>        }
>@@ -1333,7 +1333,6 @@
>        rscsi_disks[i].device = SDp;
>        rscsi_disks[i].has_part_table = 0;
>        sd_template.nr_dev++;
>-       SD_GENDISK(i).nr_real++;
>         devnum = i % SCSI_DISKS_PER_MAJOR;
>         SD_GENDISK(i).de_arr[devnum] = SDp->de;
>         if (SDp->removable)
>@@ -1447,7 +1446,6 @@
>                        SDp->attached--;
>                        sd_template.dev_noticed--;
>                        sd_template.nr_dev--;
>-                       SD_GENDISK(i).nr_real--;
>                        return;
>                }
>        return;
>
>
>
>
