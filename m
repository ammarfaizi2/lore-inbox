Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVBZSIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVBZSIY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 13:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVBZSIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 13:08:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47812 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261252AbVBZSII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 13:08:08 -0500
Date: Sat, 26 Feb 2005 10:48:52 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>, slee@netengine1.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] fix units/partition count in sd.c (2.4.x)
Message-ID: <20050226134851.GC16717@logos.cnet>
References: <42137399.5080600@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42137399.5080600@adaptec.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 11:23:53AM -0500, Luben Tuikov wrote:
> Hi,
> 
> This patch fixes the nr_real count in sd.c, which is also used
> in genhd.c to print out the partitions/units.  The problem is that
> nr_real is decremented on detach, the genhd's nr_sects is
> cleared but the entry is still there and is being counted
> for when displaying the partitions.  Thus when nr_real
> is decremented _and_ a 0-ed partition/unit is counted,
> we get to not display 1 or more entries of the tail of
> the list.
> 
> The solution is to not decrement nr_real on detach, effectively
> never decrementing it, and so that it doesn't grow without a bound,
> to throttle it on attach, incrementing it only if it would be
> smaller than nr_dev.
> 
> This was observed on a RH kernel and on the current BK kernel.
> Tested and fixed on 2.4.30-pre1 (BK).  This patch is against 2.4.30-pre1.
> 
> To reproduce: assume 4 scsi disks sda, sdb, sdc, sdd.
> #echo "scsi remove-single-device <sdb-HCTL>" > /proc/scsi/scsi
> #cat /proc/partitions
> <<sdb _and_ sdd are not listed>>

Luben,

On James Bottomley advice I have applied Soo Lee's fix, which looks cleaner.

Also as James notice this will increase overhead of /proc/partitions which might be
a problem on higher-end systems with many devices. 

Testing of it on such systems is highly appreciated.


# 05/02/26      slee@netengine1.com     1.1558
# [PATCH] Fix units/partition count in sd.c
#
# Symptom:
#    When a scsi disk is removed other scsi disk with biggest minor #
#    disapears in /proc/partition at the same time.
#
# Cause and fix:
#    sd.c decreases nr_real on disk removal but because nr_real is not
#    real # of devices but max # of devices of a major #,
#    it doesn't need to be changed on disk add/remove.
#
# 2.6 has little different structure but it does like this
#
# sd.c:sd_probe()
#       gd->minors = 16;
# --------------------------------------------
#
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c Sat Feb 26 10:46:42 2005
+++ b/drivers/scsi/sd.c Sat Feb 26 10:46:42 2005
@@ -1220,7 +1220,7 @@
                        goto cleanup_gendisks_part;
                memset(sd_gendisks[i].part, 0, (SCSI_DISKS_PER_MAJOR << 4) * sizeof(struct hd_struct));
                sd_gendisks[i].sizes = sd_sizes + (i * SCSI_DISKS_PER_MAJOR << 4);
-               sd_gendisks[i].nr_real = 0;
+               sd_gendisks[i].nr_real = SCSI_DISKS_PER_MAJOR;
                sd_gendisks[i].real_devices =
                    (void *) (rscsi_disks + i * SCSI_DISKS_PER_MAJOR);
        }
@@ -1333,7 +1333,6 @@
        rscsi_disks[i].device = SDp;
        rscsi_disks[i].has_part_table = 0;
        sd_template.nr_dev++;
-       SD_GENDISK(i).nr_real++;
         devnum = i % SCSI_DISKS_PER_MAJOR;
         SD_GENDISK(i).de_arr[devnum] = SDp->de;
         if (SDp->removable)
@@ -1447,7 +1446,6 @@
                        SDp->attached--;
                        sd_template.dev_noticed--;
                        sd_template.nr_dev--;
-                       SD_GENDISK(i).nr_real--;
                        return;
                }
        return;



