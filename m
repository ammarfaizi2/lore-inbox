Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751976AbWG1I2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbWG1I2a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWG1I2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:28:30 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:32355 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751976AbWG1I23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:28:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NiJDUbGwrGKwFxIN2U7SU7Nn9SSBEsHbB/RSpd8q7cM3/fH7CjQBUeUyFERCADHTAtn9Lbo7bWKxXvQorSwpECze6l4CedpQyPmb0u2LqbQ7XYTOd9yD80wvM0EDdZpNE7l1wIQChUIj3L1IyzZil0o9Ik+k8phvA+ov4xezi90=
Message-ID: <710c0ee0607280128g2d968c49ycff3bac9e073e7fa@mail.gmail.com>
Date: Fri, 28 Jul 2006 14:28:28 +0600
From: "Zed 0xff" <zed.0xff@gmail.com>
To: kernel-janitors@osdl.org
Subject: [patch] fix common mistake in polling loops
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrej Zaikin <zed.0xff@gmail.com>
Signed-off-by: Andrej Zaikin <zed.0xff@gmail.com>

task taken from http://kerneljanitors.org/TODO:

A _lot_ of drivers end up caring about absolute time, because a _lot_ of
drivers have a very simple issue like:

 - poll this port every 10ms until it returns "ready", or until we time
   out after 500ms.

And the thing is, you can do it the stupid way:

	for (i = 0; i < 50; i++) {
		if (ready())
			return 0;
		msleep(10);
	}
	.. timeout ..

or you can do it the _right_ way. The stupid way is simpler, but anybody
who doesn't see what the problem is has some serious problems in kernel
programming. Hint: it might not be polling for half a second, it might be
polling for half a _minute_ for all you know.

In other words, the _right_ way to do this is literally

	unsigned long timeout = jiffies + msecs_to_jiffies(500);
	for (;;) {
		if (ready())
			return 0;
		if (time_after(timeout, jiffies))
			break;
		msleep(10);
	}

which is unquestionably more complex, yes, but it's more complex because
it is CORRECT!

### Diffstat output
 drivers/acpi/sbs.c                             |   11 +++++++----
 drivers/atm/firestream.c                       |   17 +++++++++--------
 drivers/block/sx8.c                            |   12 +++++++-----
 drivers/char/sonypi.c                          |   14 ++++++++++++--
 drivers/char/tpm/tpm_infineon.c                |   21 ++++++++++++---------
 drivers/char/watchdog/pcwd.c                   |    8 ++++++--
 drivers/hwmon/hdaps.c                          |   10 +++++++---
 drivers/infiniband/hw/mthca/mthca_reset.c      |    8 ++++++--
 drivers/input/mouse/psmouse-base.c             |    7 ++++++-
 drivers/media/video/cx88/cx88-core.c           |    9 +++++++--
 drivers/media/video/meye.c                     |   11 +++++++++--
 drivers/media/video/ov511.c                    |    9 +++++++--
 drivers/media/video/ovcamchip/ovcamchip_core.c |   10 ++++++++--
 drivers/pcmcia/cs.c                            |    9 +++++++--
 drivers/serial/icom.c                          |   11 +++++++----
 sound/isa/cs423x/cs4231_lib.c                  |   10 +++++-----
 sound/pci/cs46xx/cs46xx_lib.c                  |   19 ++++++++++++-------
 17 files changed, 134 insertions(+), 62 deletions(-)
diff -upr -X linux-2.6.17/Documentation/dontdiff a/drivers/acpi/sbs.c
b/drivers/acpi/sbs.c
--- a/drivers/acpi/sbs.c	2006-07-27 21:55:54.000000000 +0600
+++ b/drivers/acpi/sbs.c	2006-07-28 00:41:12.000000000 +0600
@@ -1573,7 +1573,8 @@ static int acpi_sbs_add(struct acpi_devi
 	struct acpi_ec_hc *ec_hc = NULL;
 	int result, remove_result = 0;
 	unsigned long sbs_obj;
-	int id, cnt;
+	int id;
+	unsigned long timeout;
 	acpi_status status = AE_OK;

 	sbs = kmalloc(sizeof(struct acpi_sbs), GFP_KERNEL);
@@ -1583,13 +1584,15 @@ static int acpi_sbs_add(struct acpi_devi
 	}
 	memset(sbs, 0, sizeof(struct acpi_sbs));

-	cnt = 0;
-	while (cnt < 10) {
-		cnt++;
+	timeout = jiffies + msecs_to_jiffies(10000);
+	for(;;){
 		ec_hc = acpi_get_ec_hc(device);
 		if (ec_hc) {
 			break;
 		}
+		if (time_after(timeout, jiffies)) {
+			break;
+		}
 		msleep(1000);
 	}

diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/atm/firestream.c b/drivers/atm/firestream.c
--- a/drivers/atm/firestream.c	2006-07-27 21:55:47.000000000 +0600
+++ b/drivers/atm/firestream.c	2006-07-28 00:49:30.000000000 +0600
@@ -1652,8 +1652,9 @@ static void fs_poll (unsigned long data)
 static int __devinit fs_init (struct fs_dev *dev)
 {
 	struct pci_dev  *pci_dev;
-	int isr, to;
+	int isr;
 	int i;
+	unsigned long timeout;

 	func_enter ();
 	pci_dev = dev->pci_dev;
@@ -1692,8 +1693,8 @@ static int __devinit fs_init (struct fs_

 	/* 10ms * 100 is 1 second. That should be enough, as AN3:9 says it takes
 	   1ms. */
-	to = 100;
-	while (--to) {
+	timeout = jiffies + msecs_to_jiffies(1000);
+	for(;;) {
 		isr = read_fs (dev, ISR);

 		/* This bit is documented as "RESERVED" */
@@ -1706,15 +1707,15 @@ static int __devinit fs_init (struct fs_
 			break;
 		}

+		if (time_after(timeout, jiffies)) {
+			printk (KERN_ERR "timeout initializing the FS... \n");
+			return 1;
+		}
+		
 		/* Try again after 10ms. */
 		msleep(10);
 	}

-	if (!to) {
-		printk (KERN_ERR "timeout initializing the FS... \n");
-		return 1;
-	}
-
 	/* XXX fix for fs155 */
 	dev->channel_mask = 0x1f;
 	dev->channo = 0;
diff -upr -X linux-2.6.17/Documentation/dontdiff a/drivers/block/sx8.c
b/drivers/block/sx8.c
--- a/drivers/block/sx8.c	2006-07-27 21:56:05.000000000 +0600
+++ b/drivers/block/sx8.c	2006-07-28 00:52:33.000000000 +0600
@@ -550,21 +550,23 @@ static struct carm_request *carm_get_spe
 	unsigned long flags;
 	struct carm_request *crq = NULL;
 	struct request *rq;
-	int tries = 5000;
+	unsigned long timeout= jiffies + msecs_to_jiffies(50000);

-	while (tries-- > 0) {
+	for(;;) {
 		spin_lock_irqsave(&host->lock, flags);
 		crq = carm_get_request(host);
 		spin_unlock_irqrestore(&host->lock, flags);

 		if (crq)
 			break;
+
+		if (time_after(timeout, jiffies)) {
+			return NULL;
+		}
+		
 		msleep(10);
 	}

-	if (!crq)
-		return NULL;
-
 	rq = blk_get_request(host->oob_q, WRITE /* bogus */, GFP_KERNEL);
 	if (!rq) {
 		spin_lock_irqsave(&host->lock, flags);
diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2006-07-27 21:55:57.000000000 +0600
+++ b/drivers/char/sonypi.c	2006-07-28 00:59:48.000000000 +0600
@@ -724,6 +724,7 @@ static void sonypi_camera_off(void)
 static void sonypi_camera_on(void)
 {
 	int i, j;
+	unsigned long timeout;

 	if (sonypi_device.camera_power)
 		return;
@@ -734,9 +735,18 @@ static void sonypi_camera_on(void)
 			msleep(10);
 		sonypi_call1(0x93);

-		for (i = 400; i > 0; i--) {
-			if (sonypi_camera_ready())
+		timeout=jiffies + msecs_to_jiffies(4000);
+		for (;;) {
+			if (sonypi_camera_ready()){
+				i=1;
 				break;
+			}
+
+			if (time_after(timeout, jiffies)){
+				i=0;
+				break;
+			}
+			
 			msleep(10);
 		}
 		if (i)
diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
--- a/drivers/char/tpm/tpm_infineon.c	2006-07-27 21:55:56.000000000 +0600
+++ b/drivers/char/tpm/tpm_infineon.c	2006-07-28 01:03:29.000000000 +0600
@@ -137,21 +137,24 @@ static int empty_fifo(struct tpm_chip *c
 static int wait(struct tpm_chip *chip, int wait_for_bit)
 {
 	int status;
-	int i;
-	for (i = 0; i < TPM_MAX_TRIES; i++) {
+	unsigned long timeout = jiffies +
msecs_to_jiffies(TPM_MAX_TRIES*TPM_MSLEEP_TIME);
+	for (;;) {
 		status = inb(chip->vendor.base + STAT);
 		/* check the status-register if wait_for_bit is set */
 		if (status & 1 << wait_for_bit)
 			break;
+
+		if (time_after(timeout, jiffies)) {
+			/* timeout occurs */
+			if (wait_for_bit == STAT_XFE)
+				dev_err(chip->dev, "Timeout in wait(STAT_XFE)\n");
+			if (wait_for_bit == STAT_RDA)
+				dev_err(chip->dev, "Timeout in wait(STAT_RDA)\n");
+			return -EIO;
+		}
+		
 		msleep(TPM_MSLEEP_TIME);
 	}
-	if (i == TPM_MAX_TRIES) {	/* timeout occurs */
-		if (wait_for_bit == STAT_XFE)
-			dev_err(chip->dev, "Timeout in wait(STAT_XFE)\n");
-		if (wait_for_bit == STAT_RDA)
-			dev_err(chip->dev, "Timeout in wait(STAT_RDA)\n");
-		return -EIO;
-	}
 	return 0;
 };

diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	2006-07-27 21:55:57.000000000 +0600
+++ b/drivers/char/watchdog/pcwd.c	2006-07-28 01:06:33.000000000 +0600
@@ -918,8 +918,8 @@ static int __init pcwd_checkcard(int bas
 {
 	int port0, last_port0;	/* Reg 0, in case it's REV A */
 	int port1, last_port1;	/* Register 1 for REV C cards */
-	int i;
 	int retval;
+	unsigned long timeout;

 	if (!request_region (base_addr, 4, "PCWD")) {
 		printk (KERN_INFO PFX "Port 0x%04x unavailable\n", base_addr);
@@ -932,7 +932,8 @@ static int __init pcwd_checkcard(int bas
 	port1 = inb_p(base_addr + 1);	/* For REV C boards */
 	if (port0 != 0xff || port1 != 0xff) {
 		/* Not an 'ff' from a floating bus, so must be a card! */
-		for (i = 0; i < 4; ++i) {
+		timeout = jiffies + msecs_to_jiffies(2000);
+		for (;;) {

 			msleep(500);

@@ -948,6 +949,9 @@ static int __init pcwd_checkcard(int bas
 				retval = 1;
 				break;
 			}
+			if (time_after(timeout, jiffies)){
+				break;
+			}
 		}
 	}
 	release_region (base_addr, 4);
diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/hwmon/hdaps.c b/drivers/hwmon/hdaps.c
--- a/drivers/hwmon/hdaps.c	2006-07-27 21:56:06.000000000 +0600
+++ b/drivers/hwmon/hdaps.c	2006-07-28 01:12:38.000000000 +0600
@@ -211,7 +211,8 @@ static int hdaps_read_pair(unsigned int
  */
 static int hdaps_device_init(void)
 {
-	int total, ret = -ENXIO;
+	int ret = -ENXIO;
+	unsigned long timeout;

 	down(&hdaps_sem);

@@ -265,7 +266,8 @@ static int hdaps_device_init(void)
 		goto out;

 	/* we have done our dance, now let's wait for the applause */
-	for (total = INIT_TIMEOUT_MSECS; total > 0; total -= INIT_WAIT_MSECS) {
+	timeout = jiffies + msecs_to_jiffies(INIT_TIMEOUT_MSECS);
+	for (;;){
 		int x, y;

 		/* a read of the device helps push it into action */
@@ -274,7 +276,9 @@ static int hdaps_device_init(void)
 			ret = 0;
 			break;
 		}
-
+		if (time_after(timeout, jiffies)){
+			break;
+		}
 		msleep(INIT_WAIT_MSECS);
 	}

diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/infiniband/hw/mthca/mthca_reset.c
b/drivers/infiniband/hw/mthca/mthca_reset.c
--- a/drivers/infiniband/hw/mthca/mthca_reset.c	2006-07-27
21:56:05.000000000 +0600
+++ b/drivers/infiniband/hw/mthca/mthca_reset.c	2006-07-28
01:20:00.000000000 +0600
@@ -168,9 +168,9 @@ int mthca_reset(struct mthca_dev *mdev)
 	/* Now wait for PCI device to start responding again */
 	{
 		u32 v;
-		int c = 0;
+		unsigned long timeout = jiffies + msecs_to_jiffies(10000);

-		for (c = 0; c < 100; ++c) {
+		for (;;) {
 			if (pci_read_config_dword(bridge ? bridge : mdev->pdev, 0, &v)) {
 				err = -ENODEV;
 				mthca_err(mdev, "Couldn't access HCA after reset, "
@@ -181,6 +181,10 @@ int mthca_reset(struct mthca_dev *mdev)
 			if (v != 0xffffffff)
 				goto good;

+			if (time_after(timeout, jiffies)){
+				break;
+			}
+
 			msleep(100);
 		}

diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/input/mouse/psmouse-base.c
b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2006-07-27 21:56:06.000000000 +0600
+++ b/drivers/input/mouse/psmouse-base.c	2006-07-28 01:23:30.000000000 +0600
@@ -898,6 +898,7 @@ static void psmouse_resync(void *p)
 	psmouse_ret_t rc = PSMOUSE_GOOD_DATA;
 	int failed = 0, enabled = 0;
 	int i;
+	unsigned long timeout;

 	mutex_lock(&psmouse_mutex);

@@ -955,11 +956,15 @@ static void psmouse_resync(void *p)
  * repeat our attempts 5 times, otherwise we may be left out with disabled
  * mouse.
  */
-	for (i = 0; i < 5; i++) {
+	timeout = jiffies + msecs_to_jiffies(1000);
+	for (;;) {
 		if (!ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE)) {
 			enabled = 1;
 			break;
 		}
+		if (time_after(timeout, jiffies)) {
+			break;
+		}
 		msleep(200);
 	}

diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/media/video/cx88/cx88-core.c
b/drivers/media/video/cx88/cx88-core.c
--- a/drivers/media/video/cx88/cx88-core.c	2006-07-27 21:56:07.000000000 +0600
+++ b/drivers/media/video/cx88/cx88-core.c	2006-07-28 01:35:40.000000000 +0600
@@ -756,7 +756,7 @@ static int set_pll(struct cx88_core *cor
 	static u32 pre[] = { 0, 0, 0, 3, 2, 1 };
 	u64 pll;
 	u32 reg;
-	int i;
+	unsigned long timeout;

 	if (prescale < 2)
 		prescale = 2;
@@ -774,7 +774,9 @@ static int set_pll(struct cx88_core *cor
 	dprintk(1,"set_pll:    MO_PLL_REG       0x%08x [old=0x%08x,freq=%d]\n",
 		reg, cx_read(MO_PLL_REG), ofreq);
 	cx_write(MO_PLL_REG, reg);
-	for (i = 0; i < 100; i++) {
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	for (;;) {
 		reg = cx_read(MO_DEVICE_STATUS);
 		if (reg & (1<<2)) {
 			dprintk(1,"pll locked [pre=%d,ofreq=%d]\n",
@@ -782,6 +784,9 @@ static int set_pll(struct cx88_core *cor
 			return 0;
 		}
 		dprintk(1,"pll not locked yet, waiting ...\n");
+		if(time_after(timeout, jiffies)){
+			break;
+		}
 		msleep(10);
 	}
 	dprintk(1,"pll NOT locked [pre=%d,ofreq=%d]\n",prescale,ofreq);
diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2006-07-27 21:56:08.000000000 +0600
+++ b/drivers/media/video/meye.c	2006-07-28 01:38:11.000000000 +0600
@@ -558,12 +558,15 @@ static void mchip_dma_free(void)
    reset the dma engine */
 static void mchip_hic_stop(void)
 {
-	int i, j;
+	int j;
+	unsigned long timeout;

 	meye.mchip_mode = MCHIP_HIC_MODE_NOOP;
 	if (!(mchip_read(MCHIP_HIC_STATUS) & MCHIP_HIC_STATUS_BUSY))
 		return;
-	for (i = 0; i < 20; ++i) {
+
+	timeout = jiffies + msecs_to_jiffies(250*20);
+	for (;;) {
 		mchip_set(MCHIP_HIC_CMD, MCHIP_HIC_CMD_STOP);
 		mchip_delay(MCHIP_HIC_CMD, 0);
 		for (j = 0; j < 100; ++j) {
@@ -575,6 +578,10 @@ static void mchip_hic_stop(void)
 		printk(KERN_ERR "meye: need to reset HIC!\n");

 		mchip_set(MCHIP_HIC_CTL, MCHIP_HIC_CTL_SOFT_RESET);
+		
+		if (time_after(timeout, jiffies))
+			break;
+
 		msleep(250);
 	}
 	printk(KERN_ERR "meye: resetting HIC hanged!\n");
diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/media/video/ov511.c b/drivers/media/video/ov511.c
--- a/drivers/media/video/ov511.c	2006-07-27 21:56:09.000000000 +0600
+++ b/drivers/media/video/ov511.c	2006-07-28 01:41:31.000000000 +0600
@@ -1136,6 +1136,7 @@ static int
 init_ov_sensor(struct usb_ov511 *ov)
 {
 	int i, success;
+	unsigned long timeout;

 	/* Reset the sensor */
 	if (i2c_w(ov, 0x12, 0x80) < 0)
@@ -1144,11 +1145,12 @@ init_ov_sensor(struct usb_ov511 *ov)
 	/* Wait for it to initialize */
 	msleep(150);

-	for (i = 0, success = 0; i < i2c_detect_tries && !success; i++) {
+	timeout = jiffies + msecs_to_jiffies(i2c_detect_tries*150);
+	for (i = 0, success = 0; ; i++) {
 		if ((i2c_r(ov, OV7610_REG_ID_HIGH) == 0x7F) &&
 		    (i2c_r(ov, OV7610_REG_ID_LOW) == 0xA2)) {
 			success = 1;
-			continue;
+			break;
 		}

 		/* Reset the sensor */
@@ -1159,6 +1161,9 @@ init_ov_sensor(struct usb_ov511 *ov)
 		/* Dummy read to sync I2C */
 		if (i2c_r(ov, 0x00) < 0)
 			return -EIO;
+
+		if (time_after(timeout, jiffies))
+			break;
 	}

 	if (!success)
diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/media/video/ovcamchip/ovcamchip_core.c
b/drivers/media/video/ovcamchip/ovcamchip_core.c
--- a/drivers/media/video/ovcamchip/ovcamchip_core.c	2006-07-27
21:56:09.000000000 +0600
+++ b/drivers/media/video/ovcamchip/ovcamchip_core.c	2006-07-28
01:43:07.000000000 +0600
@@ -124,6 +124,7 @@ static int init_camchip(struct i2c_clien
 {
 	int i, success;
 	unsigned char high, low;
+	unsigned long timeout;

 	/* Reset the chip */
 	ov_write(c, 0x12, 0x80);
@@ -131,12 +132,13 @@ static int init_camchip(struct i2c_clien
 	/* Wait for it to initialize */
 	msleep(150);

-	for (i = 0, success = 0; i < I2C_DETECT_RETRIES && !success; i++) {
+	timeout = jiffies + msecs_to_jiffies(I2C_DETECT_RETRIES*150);
+	for (i = 0, success = 0; ; i++) {
 		if (ov_read(c, GENERIC_REG_ID_HIGH, &high) >= 0) {
 			if (ov_read(c, GENERIC_REG_ID_LOW, &low) >= 0) {
 				if (high == 0x7F && low == 0xA2) {
 					success = 1;
-					continue;
+					break;
 				}
 			}
 		}
@@ -149,6 +151,10 @@ static int init_camchip(struct i2c_clien

 		/* Dummy read to sync I2C */
 		ov_read(c, 0x00, &low);
+
+		if (time_after(timeout, jiffies)) {
+			break;
+		}
 	}

 	if (!success)
diff -upr -X linux-2.6.17/Documentation/dontdiff a/drivers/pcmcia/cs.c
b/drivers/pcmcia/cs.c
--- a/drivers/pcmcia/cs.c	2006-07-27 21:56:12.000000000 +0600
+++ b/drivers/pcmcia/cs.c	2006-07-28 01:53:57.000000000 +0600
@@ -419,7 +419,8 @@ static void socket_shutdown(struct pcmci

 static int socket_setup(struct pcmcia_socket *skt, int initial_delay)
 {
-	int status, i;
+	int status;
+	unsigned long timeout;

 	cs_dbg(skt, 4, "setup\n");

@@ -429,7 +430,8 @@ static int socket_setup(struct pcmcia_so

 	msleep(initial_delay * 10);

-	for (i = 0; i < 100; i++) {
+	timeout = jiffies + msecs_to_jiffies(10000);
+	for (;;) {
 		skt->ops->get_status(skt, &status);
 		if (!(status & SS_DETECT))
 			return CS_NO_CARD;
@@ -437,6 +439,9 @@ static int socket_setup(struct pcmcia_so
 		if (!(status & SS_PENDING))
 			break;

+		if (time_after(timeout, jiffies))
+			break;
+
 		msleep(100);
 	}

diff -upr -X linux-2.6.17/Documentation/dontdiff
a/drivers/serial/icom.c b/drivers/serial/icom.c
--- a/drivers/serial/icom.c	2006-07-27 21:56:12.000000000 +0600
+++ b/drivers/serial/icom.c	2006-07-28 09:53:19.000000000 +0600
@@ -349,6 +349,7 @@ static void load_code(struct icom_port *
 	unsigned char *new_page = NULL;
 	unsigned char cable_id = NO_CABLE;
 	struct pci_dev *dev = icom_port->adapter->pci_dev;
+	unsigned long timeout;

 	/* Clear out any pending interrupts */
 	writew(0x3FFF, icom_port->int_reg);
@@ -460,15 +461,17 @@ static void load_code(struct icom_port *
 	writeb(START_DOWNLOAD, &icom_port->dram->sync);

 	/* Wait max 1 Sec for data download and processor to start */
-	for (index = 0; index < 10; index++) {
+	timeout = jiffies + msecs_to_jiffies(1000);
+	for (;;) {
 		msleep(100);
 		if (readb(&icom_port->dram->misc_flags) & ICOM_HDW_ACTIVE)
 			break;
+		if (time_after(timeout, jiffies)) {
+			status = -1;
+			break;
+		}
 	}

-	if (index == 10)
-		status = -1;
-
 	/*
 	 * check Cable ID
 	 */
diff -upr -X linux-2.6.17/Documentation/dontdiff
a/sound/isa/cs423x/cs4231_lib.c b/sound/isa/cs423x/cs4231_lib.c
--- a/sound/isa/cs423x/cs4231_lib.c	2006-07-27 21:55:44.000000000 +0600
+++ b/sound/isa/cs423x/cs4231_lib.c	2006-07-28 10:09:25.000000000 +0600
@@ -322,7 +322,7 @@ void snd_cs4231_mce_up(struct snd_cs4231

 void snd_cs4231_mce_down(struct snd_cs4231 *chip)
 {
-	unsigned long flags;
+	unsigned long flags, timeout_l;
 	int timeout;

 	snd_cs4231_busy_wait(chip);
@@ -358,9 +358,9 @@ void snd_cs4231_mce_down(struct snd_cs42
 	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
 #endif
 	/* in 10 ms increments, check condition, up to 250 ms */
-	timeout = 25;
+	timeout_l = jiffies + msecs_to_jiffies(250);
 	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
-		if (--timeout < 0) {
+		if (time_after(timeout_l, jiffies)){
 			snd_printk("mce_down - auto calibration time out (2)\n");
 			return;
 		}
@@ -370,9 +370,9 @@ void snd_cs4231_mce_down(struct snd_cs42
 	printk("(3) jiffies = %li\n", jiffies);
 #endif
 	/* in 10 ms increments, check condition, up to 100 ms */
-	timeout = 10;
+	timeout_l = jiffies + msecs_to_jiffies(100);
 	while (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT) {
-		if (--timeout < 0) {
+		if (time_after(timeout_l, jiffies)){
 			snd_printk(KERN_ERR "mce_down - auto calibration time out (3)\n");
 			return;
 		}
diff -upr -X linux-2.6.17/Documentation/dontdiff
a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
--- a/sound/pci/cs46xx/cs46xx_lib.c	2006-07-27 21:55:45.000000000 +0600
+++ b/sound/pci/cs46xx/cs46xx_lib.c	2006-07-28 10:43:13.000000000 +0600
@@ -2379,8 +2379,9 @@ static void snd_cs46xx_codec_reset (stru

 static int __devinit cs46xx_detect_codec(struct snd_cs46xx *chip, int codec)
 {
-	int idx, err;
+	int err;
 	struct snd_ac97_template ac97;
+	unsigned long timeout;

 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = chip;
@@ -2399,11 +2400,15 @@ static int __devinit cs46xx_detect_codec
 	}

 	snd_cs46xx_codec_write(chip, AC97_MASTER, 0x8000, codec);
-	for (idx = 0; idx < 100; ++idx) {
+	timeout = jiffies + msecs_to_jiffies(1000);
+	for (;;) {
 		if (snd_cs46xx_codec_read(chip, AC97_MASTER, codec) == 0x8000) {
 			err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97[codec]);
 			return err;
 		}
+		if (time_after(timeout, jiffies)){
+			break;
+		}
 		msleep(10);
 	}
 	snd_printdd("snd_cs46xx: codec %d detection timeout\n", codec);
@@ -2913,7 +2918,7 @@ static int snd_cs46xx_dev_free(struct sn
  */
 static int snd_cs46xx_chip_init(struct snd_cs46xx *chip)
 {
-	int timeout;
+	unsigned long timeout;

 	/*
 	 *  First, blast the clock control register to zero so that the PLL starts
@@ -3036,8 +3041,8 @@ static int snd_cs46xx_chip_init(struct s
 	/*
 	 * Wait for the codec ready signal from the AC97 codec.
 	 */
-	timeout = 150;
-	while (timeout-- > 0) {
+	timeout = jiffies + msecs_to_jiffies(1500);
+	while (!time_after(timeout, jiffies)) {
 		/*
 		 *  Read the AC97 status register to see if we've seen a CODEC READY
 		 *  signal from the AC97 codec.
@@ -3085,8 +3090,8 @@ static int snd_cs46xx_chip_init(struct s
 	 *  Wait until we've sampled input slots 3 and 4 as valid, meaning that
 	 *  the codec is pumping ADC data across the AC-link.
 	 */
-	timeout = 150;
-	while (timeout-- > 0) {
+	timeout = jiffies + msecs_to_jiffies(1500);
+	while (!time_after(timeout, jiffies)) {
 		/*
 		 *  Read the input slot valid register and see if input slots 3 and
 		 *  4 are valid yet.
