Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWDWNwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWDWNwf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 09:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWDWNwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 09:52:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:13197 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750904AbWDWNwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 09:52:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type;
        b=DdScO+5qzbTIlAF1g/VQFEMJSOQd2cHcLHJiEXzDQD29Ti/qP7f8oAiyR4vvVXtrojfyzmPLpmZ1atgjvUZ0x4ki11+EmVWGyDjy8mi4YyM/xDPkXTb8f90aJ7pA9lfQ+uOB67YYV7n2kCPoc1ArMScohuBFnt6WzsFkvt8cEy8=
Date: Sun, 23 Apr 2006 21:52:21 +0800 (SGT)
From: Jeff Chua <jeff.tw.chua@gmail.com>
X-X-Sender: root@boston.corp.fedex.com
To: Hugh Dickins <hugh@veritas.com>
cc: Chris Ball <cjb@mrao.cam.ac.uk>, Pavel Machek <pavel@suse.cz>,
       Arkadiusz Miskiewicz <arekm@maven.pl>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
In-Reply-To: <Pine.LNX.4.64.0604231341310.2515@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0604232133380.2890@boston.corp.fedex.com>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
 <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com> <20060420134713.GA2360@ucw.cz>
 <Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com>
 <20060421163930.GA1648@elf.ucw.cz> <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
 <yd3bquuqz0y.fsf@islay.ra.phy.cam.ac.uk> <Pine.LNX.4.64.0604231341310.2515@blonde.wat.veritas.com>
MIME-Version: 1.0
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


May be just me, not matter what I tried, it still doesn't work. Closest I 
can get is to use "resume=/dev/sda" on boot, able to suspend, able to 
resume to X windows, can do anything, but can't access disk. ... simple 
"ls" would hang. Dmesg is show SATA disk timeout.


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


Linux version is 2.6.17-rc2. IBM X60s is Pentium D, so SMP ... may be this 
has something to do with it.

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
