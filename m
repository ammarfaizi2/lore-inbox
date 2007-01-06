Return-Path: <linux-kernel-owner+w=401wt.eu-S1751087AbXAFC1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbXAFC1I (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbXAFC1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:27:06 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47821 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbXAFC0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:26:46 -0500
Message-Id: <20070106023042.224758000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:03 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       htejun@gmail.com, Joe Jin <lkmaillist@gmail.com>,
       Jeff Garzik <jeff@garzik.org>
Subject: [patch 10/50] libata: handle 0xff status properly
Content-Disposition: inline; filename=libata-handle-0xff-status-properly.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Tejun Heo <htejun@gmail.com>

libata waits for !BSY even when the status register reports 0xff.
This causes long boot delays when D8 isn't pulled down properly.  This
patch does the followings.

* don't wait if status register is 0xff in all wait functions

* make ata_busy_sleep() return 0 on success and -errno on failure.
  -ENODEV is returned on 0xff status and -EBUSY on other failures.

* make ata_bus_softreset() succeed on 0xff status.  0xff status is not
  reset failure.  It indicates no device.  This removes unnecessary
  retries on such ports.  Note that the code change assumes unoccupied
  port reporting 0xff status does not produce valid device signature.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Joe Jin <lkmaillist@gmail.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
It fixes a long delay during booting for some hardware.
http://bugs.gentoo.org/157326

 drivers/ata/libata-core.c |   30 ++++++++++++++++++------------
 include/linux/libata.h    |    9 ++++-----
 2 files changed, 22 insertions(+), 17 deletions(-)

--- linux-2.6.19.1.orig/drivers/ata/libata-core.c
+++ linux-2.6.19.1/drivers/ata/libata-core.c
@@ -2325,11 +2325,14 @@ static inline void ata_tf_to_host(struct
  *	Sleep until ATA Status register bit BSY clears,
  *	or a timeout occurs.
  *
- *	LOCKING: None.
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
  */
-
-unsigned int ata_busy_sleep (struct ata_port *ap,
-			     unsigned long tmout_pat, unsigned long tmout)
+int ata_busy_sleep(struct ata_port *ap,
+		   unsigned long tmout_pat, unsigned long tmout)
 {
 	unsigned long timer_start, timeout;
 	u8 status;
@@ -2337,27 +2340,32 @@ unsigned int ata_busy_sleep (struct ata_
 	status = ata_busy_wait(ap, ATA_BUSY, 300);
 	timer_start = jiffies;
 	timeout = timer_start + tmout_pat;
-	while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
+	while (status != 0xff && (status & ATA_BUSY) &&
+	       time_before(jiffies, timeout)) {
 		msleep(50);
 		status = ata_busy_wait(ap, ATA_BUSY, 3);
 	}
 
-	if (status & ATA_BUSY)
+	if (status != 0xff && (status & ATA_BUSY))
 		ata_port_printk(ap, KERN_WARNING,
 				"port is slow to respond, please be patient "
 				"(Status 0x%x)\n", status);
 
 	timeout = timer_start + tmout;
-	while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
+	while (status != 0xff && (status & ATA_BUSY) &&
+	       time_before(jiffies, timeout)) {
 		msleep(50);
 		status = ata_chk_status(ap);
 	}
 
+	if (status == 0xff)
+		return -ENODEV;
+
 	if (status & ATA_BUSY) {
 		ata_port_printk(ap, KERN_ERR, "port failed to respond "
 				"(%lu secs, Status 0x%x)\n",
 				tmout / HZ, status);
-		return 1;
+		return -EBUSY;
 	}
 
 	return 0;
@@ -2448,10 +2456,8 @@ static unsigned int ata_bus_softreset(st
 	 * the bus shows 0xFF because the odd clown forgets the D7
 	 * pulldown resistor.
 	 */
-	if (ata_check_status(ap) == 0xFF) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
-		return AC_ERR_OTHER;
-	}
+	if (ata_check_status(ap) == 0xFF)
+		return 0;
 
 	ata_bus_post_reset(ap, devmask);
 
--- linux-2.6.19.1.orig/include/linux/libata.h
+++ linux-2.6.19.1/include/linux/libata.h
@@ -744,9 +744,8 @@ extern int ata_scsi_device_suspend(struc
 extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
 extern void ata_host_resume(struct ata_host *host);
 extern int ata_ratelimit(void);
-extern unsigned int ata_busy_sleep(struct ata_port *ap,
-				   unsigned long timeout_pat,
-				   unsigned long timeout);
+extern int ata_busy_sleep(struct ata_port *ap,
+			  unsigned long timeout_pat, unsigned long timeout);
 extern void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *),
 				void *data, unsigned long delay);
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
@@ -1061,7 +1060,7 @@ static inline u8 ata_busy_wait(struct at
 		udelay(10);
 		status = ata_chk_status(ap);
 		max--;
-	} while ((status & bits) && (max > 0));
+	} while (status != 0xff && (status & bits) && (max > 0));
 
 	return status;
 }
@@ -1082,7 +1081,7 @@ static inline u8 ata_wait_idle(struct at
 {
 	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-	if (status & (ATA_BUSY | ATA_DRQ)) {
+	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ))) {
 		unsigned long l = ap->ioaddr.status_addr;
 		if (ata_msg_warn(ap))
 			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",

--
