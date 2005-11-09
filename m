Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030656AbVKISXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030656AbVKISXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030654AbVKISXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:23:10 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:21676 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030656AbVKISXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:23:09 -0500
Date: Wed, 9 Nov 2005 19:23:00 +0100
From: Daniel Nilsson <daniel.n.nilsson@home.se>
To: linux-kernel@vger.kernel.org
Cc: Markus.Lidel@shadowconnect.com
Subject: Performance degradation when using partitions
Message-ID: <20051109182300.GA27452@oden.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While setting up a software RAID-5 array I started looking into the
performance aspect of using partioned drives versus the whole disks
for a RAID-5 array. I have an Adaptec 2400a controller which through
the I2O kernel driver gives me access to 4x 250GB disks (JBOD mode).

If I create the raid array on the disks directly, /dev/i2o/hd[abcd] I
can tell from /proc/mdstat that the RAID-5 array is rebuilding at a
rate of about 25MB/sec. If I instead first create one large primary
partition on the drives and then create the raid array on those
partitions /dev/i2o/hd[abcd]1 the array is rebuilding at roughly half
the speed (14MB/sec).

Not trusting this is a good performance measurement I went ahead and
created a 10GB filesystem (ext3) on top of the resulting 700GB RAID-5
array just to find that the speed of the resulting array was affected
quite a bit by using partioned drives versus whole disks. Here are the
results, note that the RAID-5 array was still rebuilding while
performing these benchmarks.

       ------Sequential Output------ --Sequential Input- --Random-
                 --Block-- -Rewrite- ---FS---  --Block-- --Seeks--
                 K/sec %CP K/sec %CP           K/sec %CP  /sec %CP
 Whole disks:    44242  16 21290   7  Ext3     56547  12 290.9   0

 Partitioned:    28383  10 15496   5  Ext3     55089  12 288.9   0


Next step was then to compare performance on just accesses to a single
drive with a filesystem (ReiserFS or ext3) where the file system either
occupied the whole disk or resided in a partition that covered the
whole disk. Here are the results:

       ------Sequential Output------ --Sequential Input- --Random-
                 --Block-- -Rewrite- ---FS---  --Block-- --Seeks--
                 K/sec %CP K/sec %CP           K/sec %CP  /sec %CP
 Whole disk:     61652  20 15886   4  Reiser   25011   3 250.0   0
                 67212  23 16978   4  Ext3     26842   2 234.5   0
                 68275  24 16198   4  Ext3     28969   3 227.0   0

 Partitioned:    57096  19 16218   4  Reiser   23718   3 252.4   0
                 60934  21 15565   3  Ext3     26900   2 228.7   0
                 60866  21 16219   4  Ext3     26272   2 234.2   0

While the results above aren't showing the same kind of drastic
difference as with the raid array it still seems clear that the
partitioned drive is slower on average. I'm on 2.6.14 with a Pentium 4
3GHz CPU with SMP and Hyperthreading active. Has anyone else seem
similar results?

Please CC me and Markus on any replies.

Thanks
Daniel Nilsson
