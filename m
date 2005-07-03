Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVGCTXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVGCTXd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVGCTXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:23:33 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:675 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S261497AbVGCTWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:22:21 -0400
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested?
	(Accelerometer)
From: Dave Hansen <dave@sr71.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       Yani Ioannou <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <42C82BBB.9090008@gmail.com>
References: <1119559367.20628.5.camel@mindpipe>
	 <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
	 <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>
	 <42BD9EBD.8040203@linuxwireless.org> <20050625200953.GA1591@ucw.cz>
	 <42C7A3B2.4090502@linuxwireless.org> <20050703101613.GA2372@ucw.cz>
	 <9a8748490507030407547fa29b@mail.gmail.com>  <42C82BBB.9090008@gmail.com>
Content-Type: multipart/mixed; boundary="=-3phVltJ/uabhVpWhy09X"
Date: Sun, 03 Jul 2005 12:21:54 -0700
Message-Id: <1120418514.4351.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3phVltJ/uabhVpWhy09X
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-07-03 at 20:17 +0200, Jesper Juhl wrote:
> Ok, just to show you people what I've done so far.
> This doesn't work yet, but it should be resonably close (at least it
> builds ;)

On top of what you sent at first this morning (not the most recent one)
I did some stuff (in the attached patch).  It implements the last bit of
initialization that your earlier one didn't do, but I see you've done in
the most recent one.

Anyway, I get 10 reads out of it, 1 second apart, and it appears to be
getting real data:

10 seconds while tilting my thinkpad around:

x_accel: 372
y_accel: 339
x_accel: 475
y_accel: 396
x_accel: 429
y_accel: 414
x_accel: 441
y_accel: 519
x_accel: 431
y_accel: 525
x_accel: 387
y_accel: 311
x_accel: 389
y_accel: 246
x_accel: 385
y_accel: 266

10 seconds of stationary reads:

x_accel: 368
y_accel: 390
x_accel: 368
y_accel: 391
x_accel: 368
y_accel: 390
x_accel: 369
y_accel: 390
x_accel: 369
y_accel: 391
x_accel: 369
y_accel: 390
x_accel: 370
y_accel: 390
x_accel: 369
y_accel: 392
x_accel: 369
y_accel: 392
x_accel: 368
y_accel: 390
x_accel: 368
y_accel: 391


-- Dave

--=-3phVltJ/uabhVpWhy09X
Content-Disposition: attachment; filename=accel-0.diff
Content-Type: text/x-patch; name=accel-0.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- accelerometer.c.orig	2005-07-03 11:37:07.000000000 -0700
+++ accelerometer.c	2005-07-03 12:16:50.000000000 -0700
@@ -53,17 +53,17 @@
 
 static inline int latch_wait(unsigned char value, unsigned short port)
 {
-	printk(KERN_DEBUG DRV_NAME ": latch_wait(0x%x, 0x%x)\n", value, port);
-
 	int status = 0;
 	int i;
 
-	for (i = 0; i < 10; i++) {
+	printk(KERN_DEBUG DRV_NAME ": latch_wait(0x%x, 0x%x)\n", value, port);
+
+	for (i = 0; i < 100; i++) {
 		if (latch_check(value, port)) {
 			status = 1;
 			break;
 		}
-		udelay(5);
+		udelay(10);
 	}
 
 	return status;
@@ -78,9 +78,9 @@
 
 static inline int refresh(int synchronous)
 {
-	printk(KERN_DEBUG DRV_NAME ": refresh(%d)\n", synchronous);
-
 	int status = 0;
+	
+	printk(KERN_DEBUG DRV_NAME ": refresh(%d)\n", synchronous);
 
 	if (refresh_check()) {
 		status = 1;
@@ -103,29 +103,54 @@
 	inb(0x1604);
 }
 
-static int read(void)
-{
-	printk(KERN_DEBUG DRV_NAME ": read()\n");
+struct accelerometer_data { 
+	unsigned char state;
+	unsigned short x_accel;
+	unsigned short y_accel;
+	unsigned char temperature_a;
+	unsigned short x_variation;
+	unsigned short y_variation;
+	unsigned char temperature_b;
+	unsigned char unknown;
+	unsigned char mk_use;
+} __attribute__ ((packed));
 
+static int read(int print)
+{
+	int i;
 	int status = 0;
+	struct accelerometer_data d;
+
+	printk(KERN_DEBUG DRV_NAME ": read()\n");
 
 	if (refresh(ACCELEROMETER_SYNC)) {
+		for (i=0; i< sizeof(struct accelerometer_data); i++) {
+			((unsigned char *)(&d))[i] = inb(0x1611 + i);
+		}
+
 		/* FIXME: read data from 0x1611 through 0x161E */
 
 		read_done();
 		refresh(ACCELEROMETER_ASYNC);
 		status = 1;
 	}
+	if (print) {
+		//for (i=0; i< sizeof(struct accelerometer_data); i++)
+		//	printk("data[%2d]: %02x\n", i, ((unsigned char *)(&d))[i]);
+		printk("x_accel: %d\n", d.x_accel);
+		printk("y_accel: %d\n", d.y_accel);
+	}
 
 	return status;
 }
 
 static int initialize(void)
 {
+	int ret = -EIO;
 	outb(0x13, 0x1610);
 	outb(0x01, 0x161f);
 	if (! latch_wait(0x0, 0x161f))
-		return -EIO;
+		return ret;
 	if (! latch_wait(0x3, 0x1611))
 		return -EIO;
 
@@ -140,6 +165,7 @@
 		return -EIO;
 	if (! latch_wait(0x0, 0x1613))
 		return -EIO;
+	printk("%s() 5\n", __func__);
 
 	outb(0x14, 0x1610);
 	outb(0x01, 0x1611);
@@ -159,9 +185,57 @@
 	if (! latch_wait(0x0, 0x1611))
 		return -EIO;
 
-	/* FIXME: finish init sequence */
+/*
+ * I issue an outb at port 0x1610 of value 0x13,
+ * followed by an outb at port 0x161f of value 0x01.
+ * I then waits for latch 0x161f for value 0x0,
+ * and then wait for latch 0x1611 for value 0x3.
+ *
+ * Three more outbs at ports 0x1610, 0x1611, and 0x161f of values 0x17, 0x81, and 0x01, respectively follow.
+ *
+ * Four more waits for latches 0x161f, 0x1611, 0x1612, and 0x1613 for values 0x0, 0x0, 0x60, and 0x0 respectively.
+ * Then three more outbs at ports 0x1610, 0x1611, and 0x161f of values 0x14, 0x01, and 0x01.
+ *
+ * Then I wait for latch 0x161f for value 0x0.
+ * Then five outbs at ports 0x1610, 0x1611, 0x1612, 0x1613, and 0x161f of values 0x10, 0xc8, 0x00, 0x02, and 0x01
+ *
+ * I then wait for latch 0x161f for value 0x0 again.
+ *
+ * I then issues a synchronous refresh of the accelerometer data, and wait for latch 0x1611 to become 0x0.
+ */
+	
+ /*----------------------------------------------
+ * The next part is a little bit tricky because it can take a long time for the accelerometer to complete.
+ * I loop forever until latch 0x1611 becomes 0x02.
+ * 	Inside this loop, I check the timeout value against the "time waited so far" variable.
+ * 	If the function has taken too long,
+ * 		return failure.
+ * 	else, I call the function which reads the accelerometer data
+ * 	and I throw away the (probably garbage) data
+ * 		(this read somehow seems to kick the accelerometer into being initialized).
+ * 	I set_current_state to TASK_INTERRUPTIBLE, and schedule_timeout for HZ.
+ * 	I then increment our "seconds waited so far" variable and continue the loop.
+ * 	If the loop ever exits successfully, the function returns success.
+ * 	A good value to pass for the initialize timeout value is 10 seconds.
+ *
+ */
+        /* I loop forever until latch 0x1611 becomes 0x02. */ {
+	unsigned long msecs_to_sleep = 10000;
+	unsigned long msecs_per_sleep = 100;
+	unsigned long msecs_slept = 0;
+	while (msecs_slept <= msecs_to_sleep) {
+		if (latch_check(0x2, 0x1611)) {
+			printk("good latch check\n");
+			ret = 0;
+			break;
+		}
+		
+		read(0);
+		msleep_interruptible(msecs_per_sleep);
+		msecs_slept += msecs_per_sleep;
+	}}
 
-	return 0;
+	return ret;
 }
 
 static int __init accelerometer_init(void)
@@ -180,6 +254,17 @@
 	}
 
 	ret = initialize();
+	printk("initialize() ret: %d\n", ret);
+	if (ret)
+		return ret;
+	read(1);
+	{
+		int i;
+		for (i=0; i<10;i++) {
+			msleep_interruptible(1000);
+			read(1);
+		}
+	}
 
 	if (ret != 0) {
 		printk(KERN_ERR DRV_NAME ": initialization failed\n");

--=-3phVltJ/uabhVpWhy09X--

