Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWDXA6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWDXA6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 20:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWDXA6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 20:58:45 -0400
Received: from mx15.sac.fedex.com ([199.81.195.17]:48912 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S1751157AbWDXA6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 20:58:44 -0400
Date: Sun, 23 Apr 2006 21:54:17 +0800 (SGT)
From: Jeff Chua <jeff.chua.linux@gmail.com>
X-X-Sender: root@boston.corp.fedex.com
To: Hugh Dickins <hugh@veritas.com>
cc: Chris Ball <cjb@mrao.cam.ac.uk>, Pavel Machek <pavel@suse.cz>,
       Arkadiusz Miskiewicz <arekm@maven.pl>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ... (fwd)
Message-ID: <Pine.LNX.4.64.0604232153230.2890@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/24/2006
 08:58:33 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/24/2006
 08:58:36 AM,
	Serialize complete at 04/24/2006 08:58:36 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Apr 2006, Hugh Dickins wrote:

> On Sat, 22 Apr 2006, Chris Ball wrote:
>> FWIW, this patch fixes S3 resume for me too.  I'm on an Alienware m5500
>> using sd_mod and ata_piix, and I think your T43p is using AHCI, so it
>> seems that this fixes a libata-wide problem rather than something
>> specific to your hardware.
> 
> Thanks for the info, that is useful; but in fact I'm ata_piix not ahci.


May be just me, not matter what I tried, it still doesn't work. Closest I can 
get is to use "resume=/dev/sda" on boot, able to suspend, able to resume to X 
windows, can do anything, but can't access disk. ... simple "ls" would hang. 
Dmesg is show SATA disk timeout.


I've tried both "piix" and "ahci". Both suspend to disk and mem.


My config ...
 	CONFIG_SOFTWARE_SUSPEND=y
 	CONFIG_PM_STD_PARTITION="/dev/sda3"
 	CONFIG_SUSPEND_SMP=y
 	CONFIG_SUSPEND2_CRYPTO=y
 	CONFIG_SUSPEND2=y
 	CONFIG_SUSPEND2_SWAPWRITER=y
 	CONFIG_SUSPEND2_DEFAULT_RESUME2="swap:/dev/sda3"
 	CONFIG_SUSPEND_SHARED=y


Tried suspending via ...

 	echo shutdown > /sys/power/disk; echo disk > /sys/power/state
 	echo platform > /sys/power/disk; echo disk > /sys/power/state
 	echo mem > /sys/power/state


Grub.cfg ...
 	linux /linux/bzc1 root=/dev/sda2 resume=/dev/sda3


To use "piix" ...
 	Power On -> BIOS Setup -> SATA -> select "Compatibility"

To use "ahci" ...
 	Power On -> BIOS Setup -> SATA -> select "AHCI"


Linux version is 2.6.17-rc2. IBM X60s is Pentium D, so SMP ... may be this has 
something to do with it.

I would really like to get suspend to work, so whatever ideas you've, I'm 
willing to try it.


Thanks,
Jeff.

PS. Official email jchua at fedex dot com, but simply got too much spam at 
jeffchua@silk.corp.fedex.com and not easy to access as I'm travelling now.



--- arch/i386/kernel/time.c.org	2006-04-21 22:32:15 +0800
+++ arch/i386/kernel/time.c	2006-04-21 22:34:01 +0800
@@ -379,6 +379,8 @@
  }

  static long clock_cmos_diff, sleep_start;
+unsigned long resume_mdelay = 2000;
+

  static struct timer_opts *last_timer;
  static int timer_suspend(struct sys_device *dev, pm_message_t state)
@@ -386,9 +388,8 @@
  	/*
  	 * Estimate time zone so that set_time can update the clock
  	 */
-	clock_cmos_diff = -get_cmos_time();
-	clock_cmos_diff += get_seconds();
  	sleep_start = get_cmos_time();
+	clock_cmos_diff = get_seconds() - sleep_start;
  	last_timer = cur_timer;
  	cur_timer = &timer_none;
  	if (last_timer->suspend)
@@ -407,10 +408,11 @@
  		hpet_reenable();
  #endif
  	setup_pit_timer();
-	sec = get_cmos_time() + clock_cmos_diff;
-	sleep_length = (get_cmos_time() - sleep_start) * HZ;
+	mdelay(resume_mdelay);
+	sec = get_cmos_time();
+	sleep_length = (sec - sleep_start) * HZ;
  	write_seqlock_irqsave(&xtime_lock, flags);
-	xtime.tv_sec = sec;
+	xtime.tv_sec = clock_cmos_diff + sec;
  	xtime.tv_nsec = 0;
  	jiffies_64 += sleep_length;
  	wall_jiffies += sleep_length;
--- linux/drivers/scsi/libata-core.c.org	2006-04-23 00:27:00 +0800
+++ linux/drivers/scsi/libata-core.c	2006-04-23 00:22:47 +0800
@@ -4287,7 +4287,8 @@
  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
  {
  	if (ap->flags & ATA_FLAG_SUSPENDED) {
  		ap->flags &= ~ATA_FLAG_SUSPENDED;
+		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
  		ata_set_mode(ap);
  	}
  	if (!ata_dev_present(dev))
