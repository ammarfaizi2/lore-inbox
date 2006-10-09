Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751692AbWJIHHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbWJIHHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWJIHHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:07:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:7862 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751692AbWJIHHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:07:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=jHsYqGw/zXPmB7XC4tVDb83zNEPNu4A96Za5WCD/qzDw8F1wzkQTkgcumI20TZM3TOfHeM/K/FcT8NOEkCRo4u+jtGBgTUG0ReYV1XZmKRM4iqVkpgbZ0FNAe1WqlZaWtEQHilRANInIeS/Dy1wb5yd4ctFjQUvWXYdKJzl/Z44=
Date: Mon, 9 Oct 2006 16:06:52 +0900
From: Tejun Heo <htejun@gmail.com>
To: Joe Jin <lkmaillist@gmail.com>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
Message-ID: <20061009070652.GE10832@htj.dyndns.org>
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com> <451E7BD2.7020002@gmail.com> <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com> <4529BCC4.8060906@gmail.com> <215036450610082354q34b906bdp54a3b9cee52a5855@mail.gmail.com> <4529F391.3030504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4529F391.3030504@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 04:00:33PM +0900, Tejun Heo wrote:
> Joe Jin wrote:
> >>SRST failure would have still occurred but 30sec timeout should have
> >>gone.  Can you post full dmesg?
> >
> >Yes it is.
> >attachment is the output of dmesg
> 
> Great.
> 
> >>Also, please test the patch in the following mail.  You can use either
> >>git or download the full kernel tarball to get the modified kernel.
> >>
> >
> >Did the pathc against 2.6.19-rc1?
> >I have test it, but it have not any change and timeout also appeared :(
> 
> It's against libata development tree.  So, you downloaded the tar.gz and 
> tested it?

And, one more thing to try.  The following patch should fix your
problem.  It's against v2.6.18.

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 427b73a..3bc7f57 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2271,11 +2271,14 @@ static inline void ata_tf_to_host(struct
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
@@ -2283,25 +2286,30 @@ unsigned int ata_busy_sleep (struct ata_
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
 				"port is slow to respond, please be patient\n");
 
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
 				"(%lu secs)\n", tmout / HZ);
-		return 1;
+		return -EBUSY;
 	}
 
 	return 0;
@@ -2392,10 +2400,8 @@ static unsigned int ata_bus_softreset(st
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
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 66c3100..eb7d90f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -702,9 +702,8 @@ extern int ata_host_set_suspend(struct a
 				pm_message_t mesg);
 extern void ata_host_set_resume(struct ata_host_set *host_set);
 extern int ata_ratelimit(void);
-extern unsigned int ata_busy_sleep(struct ata_port *ap,
-				   unsigned long timeout_pat,
-				   unsigned long timeout);
+extern int ata_busy_sleep(struct ata_port *ap,
+			  unsigned long timeout_pat, unsigned long timeout);
 extern void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *),
 				void *data, unsigned long delay);
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
@@ -1019,7 +1018,7 @@ static inline u8 ata_busy_wait(struct at
 		udelay(10);
 		status = ata_chk_status(ap);
 		max--;
-	} while ((status & bits) && (max > 0));
+	} while (status != 0xff && (status & bits) && (max > 0));
 
 	return status;
 }
@@ -1040,7 +1039,7 @@ static inline u8 ata_wait_idle(struct at
 {
 	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-	if (status & (ATA_BUSY | ATA_DRQ)) {
+	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ))) {
 		unsigned long l = ap->ioaddr.status_addr;
 		if (ata_msg_warn(ap))
 			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",

