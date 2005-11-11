Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVKKDLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVKKDLD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 22:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVKKDLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 22:11:03 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:1872 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932311AbVKKDLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 22:11:01 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Kernel Panic 2.6.14-git (pictures)
Date: Thu, 10 Nov 2005 22:10:55 -0500
User-Agent: KMail/1.8.3
Cc: "Alejandro Bonilla" <abonilla@linuxwireless.org>, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, Robert Love <rml@novell.com>
References: <20051110151214.M35138@linuxwireless.org> <20051110175522.1d50c084.akpm@osdl.org>
In-Reply-To: <20051110175522.1d50c084.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511102210.55918.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 November 2005 20:55, Andrew Morton wrote:
> "Alejandro Bonilla" <abonilla@linuxwireless.org> wrote:
> >
> > I have taken some crappy pictures of the panic, I hope they help.
> > 
> > http://linuxwireless.org/kernel
> 
> Yes, photos of the screen work very nicely, thanks.
> 
> Hi, Robert ;)
>

Hmm, I though the following made it into Linus's tree...

-- 
Dmitry

Subject: Convert hdaps driver to dynamic input_dev allocation

Input: convert hdaps to dynamic input_dev allocation.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/hwmon/hdaps.c |   41 +++++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 18 deletions(-)

Index: work/drivers/hwmon/hdaps.c
===================================================================
--- work.orig/drivers/hwmon/hdaps.c
+++ work/drivers/hwmon/hdaps.c
@@ -60,9 +60,11 @@
 
 #define HDAPS_POLL_PERIOD	(HZ/20)	/* poll for input every 1/20s */
 #define HDAPS_INPUT_FUZZ	4	/* input event threshold */
+#define HDAPS_INPUT_FLAT	4
 
 static struct timer_list hdaps_timer;
 static struct platform_device *pdev;
+static struct input_dev *hdaps_idev;
 static unsigned int hdaps_invert;
 static u8 km_activity;
 static int rest_x;
@@ -311,18 +313,6 @@ static struct device_driver hdaps_driver
 	.resume = hdaps_resume
 };
 
-/* Input class stuff */
-
-static struct input_dev hdaps_idev = {
-	.name = "hdaps",
-	.evbit = { BIT(EV_ABS) },
-	.absbit = { BIT(ABS_X) | BIT(ABS_Y) },
-	.absmin  = { [ABS_X] = -256, [ABS_Y] = -256 },
-	.absmax  = { [ABS_X] = 256, [ABS_Y] = 256 },
-	.absfuzz = { [ABS_X] = HDAPS_INPUT_FUZZ, [ABS_Y] = HDAPS_INPUT_FUZZ },
-	.absflat = { [ABS_X] = HDAPS_INPUT_FUZZ, [ABS_Y] = HDAPS_INPUT_FUZZ },
-};
-
 /*
  * hdaps_calibrate - Set our "resting" values.  Callers must hold hdaps_sem.
  */
@@ -344,9 +334,9 @@ static void hdaps_mousedev_poll(unsigned
 	if (__hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y))
 		goto out;
 
-	input_report_abs(&hdaps_idev, ABS_X, x - rest_x);
-	input_report_abs(&hdaps_idev, ABS_Y, y - rest_y);
-	input_sync(&hdaps_idev);
+	input_report_abs(hdaps_idev, ABS_X, x - rest_x);
+	input_report_abs(hdaps_idev, ABS_Y, y - rest_y);
+	input_sync(hdaps_idev);
 
 	mod_timer(&hdaps_timer, jiffies + HDAPS_POLL_PERIOD);
 
@@ -566,12 +556,25 @@ static int __init hdaps_init(void)
 	if (ret)
 		goto out_device;
 
+	hdaps_idev = input_allocate_device();
+	if (!hdaps_idev) {
+		ret = -ENOMEM;
+		goto out_group;
+	}
+
 	/* initial calibrate for the input device */
 	hdaps_calibrate();
 
 	/* initialize the input class */
-	hdaps_idev.dev = &pdev->dev;
-	input_register_device(&hdaps_idev);
+	hdaps_idev->name = "hdaps";
+	hdaps_idev->cdev.dev = &pdev->dev;
+	hdaps_idev->evbit[0] = BIT(EV_ABS);
+	input_set_abs_params(hdaps_idev, ABS_X,
+			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
+	input_set_abs_params(hdaps_idev, ABS_X,
+			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
+
+	input_register_device(hdaps_idev);
 
 	/* start up our timer for the input device */
 	init_timer(&hdaps_timer);
@@ -582,6 +585,8 @@ static int __init hdaps_init(void)
 	printk(KERN_INFO "hdaps: driver successfully loaded.\n");
 	return 0;
 
+out_group:
+	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 out_device:
 	platform_device_unregister(pdev);
 out_driver:
@@ -596,7 +601,7 @@ out:
 static void __exit hdaps_exit(void)
 {
 	del_timer_sync(&hdaps_timer);
-	input_unregister_device(&hdaps_idev);
+	input_unregister_device(hdaps_idev);
 	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 	platform_device_unregister(pdev);
 	driver_unregister(&hdaps_driver);
