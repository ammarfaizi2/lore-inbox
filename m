Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265206AbUEMWjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUEMWjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUEMWjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:39:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:16599 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265206AbUEMWit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:38:49 -0400
Date: Thu, 13 May 2004 15:40:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: jgarzik@pobox.com, paul@wagland.net, mingo@elte.hu, wli@holomorphy.com,
       greg@kroah.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       davidel@xmailserver.org, Valdis.Kletnieks@vt.edu
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-Id: <20040513154040.6acc8121.akpm@osdl.org>
In-Reply-To: <20040513154002.4988b7f2.akpm@osdl.org>
References: <40A26FFA.4030701@pobox.com>
	<20040512193349.GA14936@elte.hu>
	<200405121947.i4CJlJm5029666@turing-police.cc.vt.edu>
	<Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com>
	<200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu>
	<20040512202807.GA16849@elte.hu>
	<20040512203500.GA17999@elte.hu>
	<20040512205028.GA18806@elte.hu>
	<20040512140729.476ace9e.akpm@osdl.org>
	<20040512211748.GB20800@elte.hu>
	<20040512221823.GK1397@holomorphy.com>
	<61D92BA6-A504-11D8-BD91-000A95CD704C@wagland.net>
	<20040513121141.37f32035.akpm@osdl.org>
	<40A3CA34.60202@pobox.com>
	<20040513154002.4988b7f2.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > For whomever winds up doing this work, I have two requests:
> > 
> > * use a type-safe inline rather than purely a macro, as some drivers do
> > * replace msecs_to_jiffies() occurrences as well as MSECS_TO_JIFFIES() 
> > (and ditto for jiffies_to_msecs)
> 
> ...
> Drivers need to be fixed up to use this instead of their private versions.



Remove various private implementations of msecs_to_jiffies() and
jiffies_to_msecs().

There are various uppercase versions which should be consolidated.


---

 25-akpm/drivers/block/carmel.c        |    5 -----
 25-akpm/drivers/block/genhd.c         |   26 ++++++++------------------
 25-akpm/drivers/char/watchdog/shwdt.c |    1 -
 25-akpm/drivers/net/tulip/de2104x.c   |    9 +--------
 25-akpm/include/linux/libata.h        |    5 -----
 drivers/scsi/libata-core.c            |    0 
 drivers/scsi/sata_promise.c           |    0 
 7 files changed, 9 insertions(+), 37 deletions(-)

diff -puN drivers/block/genhd.c~msec_to_jiffies-drivers drivers/block/genhd.c
--- 25/drivers/block/genhd.c~msec_to_jiffies-drivers	Thu May 13 15:26:38 2004
+++ 25-akpm/drivers/block/genhd.c	Thu May 13 15:26:38 2004
@@ -357,16 +357,6 @@ static ssize_t disk_size_read(struct gen
 	return sprintf(page, "%llu\n", (unsigned long long)get_capacity(disk));
 }
 
-static inline unsigned jiffies_to_msec(unsigned jif)
-{
-#if 1000 % HZ == 0
-	return jif * (1000 / HZ);
-#elif HZ % 1000 == 0
-	return jif / (HZ / 1000);
-#else
-	return (jif / HZ) * 1000 + (jif % HZ) * 1000 / HZ;
-#endif
-}
 static ssize_t disk_stats_read(struct gendisk * disk, char *page)
 {
 	disk_round_stats(disk);
@@ -377,14 +367,14 @@ static ssize_t disk_stats_read(struct ge
 		"\n",
 		disk_stat_read(disk, reads), disk_stat_read(disk, read_merges),
 		(unsigned long long)disk_stat_read(disk, read_sectors),
-		jiffies_to_msec(disk_stat_read(disk, read_ticks)),
+		jiffies_to_msecs(disk_stat_read(disk, read_ticks)),
 		disk_stat_read(disk, writes), 
 		disk_stat_read(disk, write_merges),
 		(unsigned long long)disk_stat_read(disk, write_sectors),
-		jiffies_to_msec(disk_stat_read(disk, write_ticks)),
+		jiffies_to_msecs(disk_stat_read(disk, write_ticks)),
 		disk->in_flight,
-		jiffies_to_msec(disk_stat_read(disk, io_ticks)),
-		jiffies_to_msec(disk_stat_read(disk, time_in_queue)));
+		jiffies_to_msecs(disk_stat_read(disk, io_ticks)),
+		jiffies_to_msecs(disk_stat_read(disk, time_in_queue)));
 }
 static struct disk_attribute disk_attr_dev = {
 	.attr = {.name = "dev", .mode = S_IRUGO },
@@ -498,13 +488,13 @@ static int diskstats_show(struct seq_fil
 		gp->major, n + gp->first_minor, disk_name(gp, n, buf),
 		disk_stat_read(gp, reads), disk_stat_read(gp, read_merges),
 		(unsigned long long)disk_stat_read(gp, read_sectors),
-		jiffies_to_msec(disk_stat_read(gp, read_ticks)),
+		jiffies_to_msecs(disk_stat_read(gp, read_ticks)),
 		disk_stat_read(gp, writes), disk_stat_read(gp, write_merges),
 		(unsigned long long)disk_stat_read(gp, write_sectors),
-		jiffies_to_msec(disk_stat_read(gp, write_ticks)),
+		jiffies_to_msecs(disk_stat_read(gp, write_ticks)),
 		gp->in_flight,
-		jiffies_to_msec(disk_stat_read(gp, io_ticks)),
-		jiffies_to_msec(disk_stat_read(gp, time_in_queue)));
+		jiffies_to_msecs(disk_stat_read(gp, io_ticks)),
+		jiffies_to_msecs(disk_stat_read(gp, time_in_queue)));
 
 	/* now show all non-0 size partitions of it */
 	for (n = 0; n < gp->minors - 1; n++) {
diff -puN drivers/net/tulip/de2104x.c~msec_to_jiffies-drivers drivers/net/tulip/de2104x.c
--- 25/drivers/net/tulip/de2104x.c~msec_to_jiffies-drivers	Thu May 13 15:26:38 2004
+++ 25-akpm/drivers/net/tulip/de2104x.c	Thu May 13 15:26:38 2004
@@ -357,13 +357,6 @@ static u16 t21041_csr14[] = { 0xFFFF, 0x
 static u16 t21041_csr15[] = { 0x0008, 0x0006, 0x000E, 0x0008, 0x0008, };
 
 
-static inline unsigned long
-msec_to_jiffies(unsigned long ms)
-{
-	return (((ms)*HZ+999)/1000);
-}
-
-
 #define dr32(reg)		readl(de->regs + (reg))
 #define dw32(reg,val)		writel((val), de->regs + (reg))
 
@@ -1216,7 +1209,7 @@ static void de_adapter_wake (struct de_p
 
 		/* de4x5.c delays, so we do too */
 		current->state = TASK_UNINTERRUPTIBLE;
-		schedule_timeout(msec_to_jiffies(10));
+		schedule_timeout(msecs_to_jiffies(10));
 	}
 }
 
diff -puN drivers/char/watchdog/shwdt.c~msec_to_jiffies-drivers drivers/char/watchdog/shwdt.c
--- 25/drivers/char/watchdog/shwdt.c~msec_to_jiffies-drivers	Thu May 13 15:26:38 2004
+++ 25-akpm/drivers/char/watchdog/shwdt.c	Thu May 13 15:26:38 2004
@@ -64,7 +64,6 @@
  */
 static int clock_division_ratio = WTCSR_CKS_4096;
 
-#define msecs_to_jiffies(msecs)	(jiffies + (HZ * msecs + 9999) / 10000)
 #define next_ping_period(cks)	msecs_to_jiffies(cks - 4)
 
 static unsigned long shwdt_is_open;
diff -puN drivers/scsi/libata-core.c~msec_to_jiffies-drivers drivers/scsi/libata-core.c
diff -puN drivers/scsi/sata_promise.c~msec_to_jiffies-drivers drivers/scsi/sata_promise.c
diff -puN drivers/block/carmel.c~msec_to_jiffies-drivers drivers/block/carmel.c
--- 25/drivers/block/carmel.c~msec_to_jiffies-drivers	Thu May 13 15:26:38 2004
+++ 25-akpm/drivers/block/carmel.c	Thu May 13 15:26:38 2004
@@ -438,11 +438,6 @@ static int carm_bdev_ioctl(struct inode 
 	return -EOPNOTSUPP;
 }
 
-static inline unsigned long msecs_to_jiffies(unsigned long msecs)
-{
-	return ((HZ * msecs + 999) / 1000);
-}
-
 static void msleep(unsigned long msecs)
 {
 	set_current_state(TASK_UNINTERRUPTIBLE);
diff -puN include/linux/libata.h~msec_to_jiffies-drivers include/linux/libata.h
--- 25/include/linux/libata.h~msec_to_jiffies-drivers	Thu May 13 15:26:38 2004
+++ 25-akpm/include/linux/libata.h	Thu May 13 15:26:38 2004
@@ -408,11 +408,6 @@ extern int ata_std_bios_param(struct scs
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 
 
-static inline unsigned long msecs_to_jiffies(unsigned long msecs)
-{
-	return ((HZ * msecs + 999) / 1000);
-}
-
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;

_

