Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbVLWWoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbVLWWoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbVLWWoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:44:16 -0500
Received: from fmr19.intel.com ([134.134.136.18]:64195 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161079AbVLWWoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:44:15 -0500
From: mgross <mgross@linux.intel.com>
To: "Gross, Mark" <mark.gross@intel.com>, torvalds@osdl.org
Subject: [PATCH] Re: [PATCH/RFT] tlclk: convert to the new platform device interface
Date: Fri, 23 Dec 2005 14:43:36 -0800
User-Agent: KMail/1.7.1
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Al Viro" <viro@ftp.linux.org.uk>,
       "\"\"Randy.Dunlap\"\"" <rdunlap@xenotime.net>, torvalds@osdl.org
References: <F760B14C9561B941B89469F59BA3A8470C36C8F9@orsmsx401.amr.corp.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470C36C8F9@orsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y2HrD8VR9EihgXJ"
Message-Id: <200512231443.36906.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Y2HrD8VR9EihgXJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a patch against 2.6.15-rc6-git4 to update the telecom clock to 
match an update to the TPS.

This patch also includes a few clean ups.
Signed-off-by: Mark Gross <mark.gross@intel.com>

--mgross

On Friday 23 December 2005 11:14, Gross, Mark wrote:
> The patch "looks" ok, but I have two issues:
>
> 2.6.15-rc6, hangs on the udev startup on my RHEL4 system so I can't
> smoke test this and more importantly an errata update patch I sent out
> earlier didn't make it in.  (I was having email client issues with kmail
> changing tabs to spaces on me that day so it may be my fault that patch
> got dropped.)
>
> How would you like to proceed?
> 1) Should I send out an update patch that includes yours and the errata
> patch, knowing that we can only say that it compiles.
> 2) Should I send a unit tested errata patch to a 2.6.14.latest version?
there is only the 2.6.15-rc versions, duh.

> 3) Both 1 and 2?
> 4) Just ack your patch (I did review it and it compiles and looks fine)
> and re-submit my errata changes on top of your update
>
> Thanks,
>
> --mgross
>
>
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dtor_core@ameritech.net]
> Sent: Thursday, December 15, 2005 10:56 PM
> To: LKML
> Cc: Russell King; Al Viro; torvalds@osdl.org; Gross, Mark
> Subject: [PATCH/RFT] tlclk: convert to the new platform device interface
>
> tlclk: convert to the new platform device interface
>
> Do not use platform_device_register_simple() as it is going away,
> define dcdbas_driver and implement ->probe() and ->remove() functions
> so manual binding and unbinding will work with this driver.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
>  drivers/char/tlclk.c |  143
> +++++++++++++++++++++++++++++++--------------------
>  1 files changed, 89 insertions(+), 54 deletions(-)
>
> Index: work/drivers/char/tlclk.c
> ===================================================================
> --- work.orig/drivers/char/tlclk.c
> +++ work/drivers/char/tlclk.c
> @@ -202,6 +202,10 @@ static int tlclk_open(struct inode *inod
>  {
>  	int result;
>
> +	alarm_events = kzalloc(sizeof(struct tlclk_alarms), GFP_KERNEL);
> +	if (!alarm_events)
> +		return -ENOMEM;
> +
>  	/* Make sure there is no interrupt pending while
>  	 * initialising interrupt handler */
>  	inb(TLCLK_REG6);
> @@ -212,6 +216,8 @@ static int tlclk_open(struct inode *inod
>  			     SA_INTERRUPT, "telco_clock",
> tlclk_interrupt);
>  	if (result == -EBUSY) {
>  		printk(KERN_ERR "telco_clock: Interrupt can't be
> reserved!\n");
> +		kfree(alarm_events);
> +		alarm_events = NULL;
>  		return -EBUSY;
>  	}
>  	inb(TLCLK_REG6);	/* Clear interrupt events */
> @@ -222,6 +228,9 @@ static int tlclk_open(struct inode *inod
>  static int tlclk_release(struct inode *inode, struct file *filp)
>  {
>  	free_irq(telclk_interrupt, tlclk_interrupt);
> +	del_timer_sync(&switchover_timer);
> +	kfree(alarm_events);
> +	alarm_events = NULL;
>
>  	return 0;
>  }
> @@ -733,89 +742,115 @@ static struct attribute_group tlclk_attr
>  	.attrs = tlclk_sysfs_entries,
>  };
>
> -static struct platform_device *tlclk_device;
> -
> -static int __init tlclk_init(void)
> +static int __devinit tlclk_probe(struct platform_device *dev)
>  {
> -	int ret;
> +	int error;
>
> -	ret = register_chrdev(tlclk_major, "telco_clock", &tlclk_fops);
> -	if (ret < 0) {
> +	init_timer(&switchover_timer);
> +
> +	error = register_chrdev(tlclk_major, "telco_clock",
> &tlclk_fops);
> +	if (error < 0) {
>  		printk(KERN_ERR "telco_clock: can't get major! %d\n",
> tlclk_major);
> -		return ret;
> +		return error;
>  	}
> -	alarm_events = kzalloc( sizeof(struct tlclk_alarms),
> GFP_KERNEL);
> -	if (!alarm_events)
> -		goto out1;
> +
> +	error = misc_register(&tlclk_miscdev);
> +	if (error < 0) {
> +		printk(KERN_ERR "tlclk: misc_register retruns %d\n",
> error);
> +		goto err_unregister_chrdev;
> +	}
> +
> +	error = sysfs_create_group(&dev->dev.kobj,
> &tlclk_attribute_group);
> +	if (error) {
> +		printk(KERN_ERR
> +			"tlclk: failed to create sysfs device
> attributes\n");
> +		goto err_misc_deregister;
> +	}
> +
> +	return 0;
> +
> + err_misc_deregister:
> +	misc_deregister(&tlclk_miscdev);
> + err_unregister_chrdev:
> +	unregister_chrdev(tlclk_major, "telco_clock");
> +	return error;
> +}
> +
> +static int __devexit tlclk_remove(struct platform_device *dev)
> +{
> +	sysfs_remove_group(&dev->dev.kobj, &tlclk_attribute_group);
> +	misc_deregister(&tlclk_miscdev);
> +	unregister_chrdev(tlclk_major, "telco_clock");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver tlclk_driver = {
> +	.driver		= {
> +		.name	= "telco_clock",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= tlclk_probe,
> +	.remove		= __devexit_p(tlclk_remove),
> +};
> +
> +static struct platform_device *tlclk_device;
> +
> +static int __init tlclk_init(void)
> +{
> +	int error;
>
>  	/* Read telecom clock IRQ number (Set by BIOS) */
>  	if (!request_region(TLCLK_BASE, 8, "telco_clock")) {
>  		printk(KERN_ERR "tlclk: request_region failed! 0x%X\n",
>  			TLCLK_BASE);
> -		ret = -EBUSY;
> -		goto out2;
> +		return -EBUSY;
>  	}
> -	telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
>
> -	if (0x0F == telclk_interrupt ) { /* not MCPBL0010 ? */
> -		printk(KERN_ERR "telclk_interrup = 0x%x non-mcpbl0010
> hw\n",
> +	telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
> +	if (0x0F == telclk_interrupt) { /* not MCPBL0010 ? */
> +		printk(KERN_ERR
> +			"tlclk: telclk_interrupt = 0x%x non-mcpbl0010
> hw\n",
>  			telclk_interrupt);
> -		ret = -ENXIO;
> -		goto out3;
> +		error = -ENODEV;
> +		goto err_release_region;
>  	}
>
> -	init_timer(&switchover_timer);
> -
> -	ret = misc_register(&tlclk_miscdev);
> -	if (ret < 0) {
> -		printk(KERN_ERR " misc_register retruns %d\n", ret);
> -		ret = -EBUSY;
> -		goto out3;
> +	error = platform_driver_register(&tlclk_driver);
> +	if (error) {
> +		printk(KERN_ERR "tlclk: failed to register platform
> driver\n");
> +		goto err_free_device;
>  	}
>
> -	tlclk_device = platform_device_register_simple("telco_clock",
> -				-1, NULL, 0);
> +	tlclk_device = platform_device_alloc("telco_clock", -1);
>  	if (!tlclk_device) {
> -		printk(KERN_ERR " platform_device_register retruns
> 0x%X\n",
> -			(unsigned int) tlclk_device);
> -		ret = -EBUSY;
> -		goto out4;
> +		printk(KERN_ERR "tlclk: failed to allocate platform
> device\n");
> +		error = -ENOMEM;
> +		goto err_unregister_driver;
>  	}
>
> -	ret = sysfs_create_group(&tlclk_device->dev.kobj,
> -			&tlclk_attribute_group);
> -	if (ret) {
> -		printk(KERN_ERR "failed to create sysfs device
> attributes\n");
> -		sysfs_remove_group(&tlclk_device->dev.kobj,
> -			&tlclk_attribute_group);
> -		goto out5;
> +	error = platform_device_add(tlclk_device);
> +	if (error) {
> +		printk(KERN_ERR "tlclk: failed to register platform
> device\n");
> +		goto err_free_device;
>  	}
>
>  	return 0;
> -out5:
> -	platform_device_unregister(tlclk_device);
> -out4:
> -	misc_deregister(&tlclk_miscdev);
> -out3:
> +
> + err_free_device:
> +	platform_device_put(tlclk_device);
> + err_unregister_driver:
> +	platform_driver_unregister(&tlclk_driver);
> + err_release_region:
>  	release_region(TLCLK_BASE, 8);
> -out2:
> -	kfree(alarm_events);
> -out1:
> -	unregister_chrdev(tlclk_major, "telco_clock");
> -	return ret;
> +	return error;
>  }
>
>  static void __exit tlclk_cleanup(void)
>  {
> -	sysfs_remove_group(&tlclk_device->dev.kobj,
> &tlclk_attribute_group);
>  	platform_device_unregister(tlclk_device);
> -	misc_deregister(&tlclk_miscdev);
> -	unregister_chrdev(tlclk_major, "telco_clock");
> -
> +	platform_driver_unregister(&tlclk_driver);
>  	release_region(TLCLK_BASE, 8);
> -	del_timer_sync(&switchover_timer);
> -	kfree(alarm_events);
> -
>  }
>
>  static void switchover_timeout(unsigned long data)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--Boundary-00=_Y2HrD8VR9EihgXJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="tlclk_2.6.15.rc6.git4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tlclk_2.6.15.rc6.git4.diff"

diff -urN -X dontdiff linux-2.6.15-rc6-git4.org/drivers/char/tlclk.c linux-2.6.15-rc6-git4/drivers/char/tlclk.c
--- linux-2.6.15-rc6-git4.org/drivers/char/tlclk.c	2005-12-23 12:52:42.000000000 -0800
+++ linux-2.6.15-rc6-git4/drivers/char/tlclk.c	2005-12-23 14:25:55.000000000 -0800
@@ -34,7 +34,6 @@
 #include <linux/kernel.h>	/* printk() */
 #include <linux/fs.h>		/* everything... */
 #include <linux/errno.h>	/* error codes */
-#include <linux/delay.h>	/* udelay */
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
@@ -165,7 +164,7 @@
 filter_select			:
 hardware_switching		:
 hardware_switching_mode		:
-interrupt_switch		:
+telclock_version		:
 mode_select			:
 refalign			:
 reset				:
@@ -173,7 +172,6 @@
 select_amcb2_transmit_clock	:
 select_redundant_clock		:
 select_ref_frequency		:
-test_mode			:
 
 All sysfs interfaces are integers in hex format, i.e echo 99 > refalign
 has the same effect as echo 0x99 > refalign.
@@ -202,6 +200,11 @@
 {
 	int result;
 
+	alarm_events = kzalloc(sizeof(struct tlclk_alarms), GFP_KERNEL);
+	if (!alarm_events)
+		return -ENOMEM;
+
+	init_timer(&switchover_timer);
 	/* Make sure there is no interrupt pending while
 	 * initialising interrupt handler */
 	inb(TLCLK_REG6);
@@ -212,6 +215,8 @@
 			     SA_INTERRUPT, "telco_clock", tlclk_interrupt);
 	if (result == -EBUSY) {
 		printk(KERN_ERR "telco_clock: Interrupt can't be reserved!\n");
+		kfree(alarm_events);
+		alarm_events = NULL;
 		return -EBUSY;
 	}
 	inb(TLCLK_REG6);	/* Clear interrupt events */
@@ -222,11 +227,14 @@
 static int tlclk_release(struct inode *inode, struct file *filp)
 {
 	free_irq(telclk_interrupt, tlclk_interrupt);
+	del_timer_sync(&switchover_timer);
+	kfree(alarm_events);
+	alarm_events = NULL;
 
 	return 0;
 }
 
-ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
+static ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
 		loff_t *f_pos)
 {
 	if (count < sizeof(struct tlclk_alarms))
@@ -242,7 +250,7 @@
 	return  sizeof(struct tlclk_alarms);
 }
 
-ssize_t tlclk_write(struct file *filp, const char __user *buf, size_t count,
+static ssize_t tlclk_write(struct file *filp, const char __user *buf, size_t count,
 	    loff_t *f_pos)
 {
 	return 0;
@@ -278,21 +286,21 @@
 static DEVICE_ATTR(current_ref, S_IRUGO, show_current_ref, NULL);
 
 
-static ssize_t show_interrupt_switch(struct device *d,
+static ssize_t show_telclock_version(struct device *d,
 		struct device_attribute *attr, char *buf)
 {
 	unsigned long ret_val;
 	unsigned long flags;
 
 	spin_lock_irqsave(&event_lock, flags);
-	ret_val = inb(TLCLK_REG6);
+	ret_val = inb(TLCLK_REG5);
 	spin_unlock_irqrestore(&event_lock, flags);
 
 	return sprintf(buf, "0x%lX\n", ret_val);
 }
 
-static DEVICE_ATTR(interrupt_switch, S_IRUGO,
-		show_interrupt_switch, NULL);
+static DEVICE_ATTR(telclock_version, S_IRUGO,
+	show_telclock_version, NULL);
 
 static ssize_t show_alarms(struct device *d,
 		struct device_attribute *attr,  char *buf)
@@ -436,26 +444,6 @@
 static DEVICE_ATTR(enable_clka0_output, S_IWUGO, NULL,
 		store_enable_clka0_output);
 
-static ssize_t store_test_mode(struct device *d,
-		struct device_attribute *attr,  const char *buf, size_t count)
-{
-	unsigned long flags;
-	unsigned long tmp;
-	unsigned char val;
-
-	sscanf(buf, "%lX", &tmp);
-	dev_dbg(d, "tmp = 0x%lX\n", tmp);
-
-	val = (unsigned char)tmp;
-	spin_lock_irqsave(&event_lock, flags);
-	SET_PORT_BITS(TLCLK_REG4, 0xfd, 2);
-	spin_unlock_irqrestore(&event_lock, flags);
-
-	return strnlen(buf, count);
-}
-
-static DEVICE_ATTR(test_mode, S_IWUGO, NULL, store_test_mode);
-
 static ssize_t store_select_amcb2_transmit_clock(struct device *d,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -475,7 +463,7 @@
 			SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x38);
 			switch (val) {
 			case CLK_8_592MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
 				break;
 			case CLK_11_184MHz:
 				SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
@@ -484,7 +472,7 @@
 				SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
 				break;
 			case CLK_44_736MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
 				break;
 			}
 		} else
@@ -653,9 +641,7 @@
 	dev_dbg(d, "tmp = 0x%lX\n", tmp);
 	spin_lock_irqsave(&event_lock, flags);
 	SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
-	udelay(2);
 	SET_PORT_BITS(TLCLK_REG0, 0xf7, 0x08);
-	udelay(2);
 	SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
 	spin_unlock_irqrestore(&event_lock, flags);
 
@@ -706,7 +692,7 @@
 
 static struct attribute *tlclk_sysfs_entries[] = {
 	&dev_attr_current_ref.attr,
-	&dev_attr_interrupt_switch.attr,
+	&dev_attr_telclock_version.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_enable_clk3a_output.attr,
 	&dev_attr_enable_clk3b_output.attr,
@@ -714,7 +700,6 @@
 	&dev_attr_enable_clka1_output.attr,
 	&dev_attr_enable_clkb0_output.attr,
 	&dev_attr_enable_clka0_output.attr,
-	&dev_attr_test_mode.attr,
 	&dev_attr_select_amcb1_transmit_clock.attr,
 	&dev_attr_select_amcb2_transmit_clock.attr,
 	&dev_attr_select_redundant_clock.attr,
@@ -744,16 +729,13 @@
 		printk(KERN_ERR "telco_clock: can't get major! %d\n", tlclk_major);
 		return ret;
 	}
-	alarm_events = kzalloc( sizeof(struct tlclk_alarms), GFP_KERNEL);
-	if (!alarm_events)
-		goto out1;
 
 	/* Read telecom clock IRQ number (Set by BIOS) */
 	if (!request_region(TLCLK_BASE, 8, "telco_clock")) {
 		printk(KERN_ERR "tlclk: request_region failed! 0x%X\n",
 			TLCLK_BASE);
 		ret = -EBUSY;
-		goto out2;
+		goto out1;
 	}
 	telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
 
@@ -761,16 +743,14 @@
 		printk(KERN_ERR "telclk_interrup = 0x%x non-mcpbl0010 hw\n",
 			telclk_interrupt);
 		ret = -ENXIO;
-		goto out3;
+		goto out2;
 	}
 
-	init_timer(&switchover_timer);
-
 	ret = misc_register(&tlclk_miscdev);
 	if (ret < 0) {
 		printk(KERN_ERR " misc_register retruns %d\n", ret);
 		ret = -EBUSY;
-		goto out3;
+		goto out2;
 	}
 
 	tlclk_device = platform_device_register_simple("telco_clock",
@@ -779,7 +759,7 @@
 		printk(KERN_ERR " platform_device_register retruns 0x%X\n",
 			(unsigned int) tlclk_device);
 		ret = -EBUSY;
-		goto out4;
+		goto out3;
 	}
 
 	ret = sysfs_create_group(&tlclk_device->dev.kobj,
@@ -788,18 +768,16 @@
 		printk(KERN_ERR "failed to create sysfs device attributes\n");
 		sysfs_remove_group(&tlclk_device->dev.kobj,
 			&tlclk_attribute_group);
-		goto out5;
+		goto out4;
 	}
 
 	return 0;
-out5:
-	platform_device_unregister(tlclk_device);
 out4:
-	misc_deregister(&tlclk_miscdev);
+	platform_device_unregister(tlclk_device);
 out3:
-	release_region(TLCLK_BASE, 8);
+	misc_deregister(&tlclk_miscdev);
 out2:
-	kfree(alarm_events);
+	release_region(TLCLK_BASE, 8);
 out1:
 	unregister_chrdev(tlclk_major, "telco_clock");
 	return ret;
@@ -813,9 +791,6 @@
 	unregister_chrdev(tlclk_major, "telco_clock");
 
 	release_region(TLCLK_BASE, 8);
-	del_timer_sync(&switchover_timer);
-	kfree(alarm_events);
-
 }
 
 static void switchover_timeout(unsigned long data)

--Boundary-00=_Y2HrD8VR9EihgXJ--
