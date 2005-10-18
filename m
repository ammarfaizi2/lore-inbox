Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVJRG7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVJRG7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVJRG7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:59:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:22184 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932404AbVJRG73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:59:29 -0400
Date: Mon, 17 Oct 2005 23:57:05 -0700
From: Greg KH <greg@kroah.com>
To: Aaron Gyes <floam@sh.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1: udev/sysfs wierdness
Message-ID: <20051018065705.GA11858@kroah.com>
References: <1129610113.10504.4.camel@localhost> <20051018055003.GA10488@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018055003.GA10488@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 10:50:03PM -0700, Greg KH wrote:
> On Mon, Oct 17, 2005 at 09:35:13PM -0700, Aaron Gyes wrote:
> > For some reason this rule stopped working:
> > 
> > KERNEL=="event*", SYSFS{manufacturer}="Logitech", SYSFS{product}="USB
> > Receiver", NAME="input/mx1000", MODE="0644"
> > 
> > Did stuff in /sys/ change? Do I need to change all my rules to make up
> > for this? udevs fault? I do have the correct /dev/input/event0 node.
> 
> You have that node?  That's a good start :)
> 
> I think the "name" might have changed, it looks like I messed that up
> somehow.  What does:
> 	 udevinfo -p /sys/class/input/input0/event0/ -a
> 
> show (or whatever that sysfs path is.)
> 
> Oops, heh, that dies on my box too.  Ok, I think that's the issue,
> sorry.  I'm working on it...

Can you try the patch below to see if that fixes the issue?  That should
keep udevinfo from dieing.

thanks,

greg k-h


---
 drivers/input/input.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- gregkh-2.6.orig/drivers/input/input.c
+++ gregkh-2.6/drivers/input/input.c
@@ -522,17 +522,22 @@ static ssize_t input_dev_show_##name(str
 	up(&input_dev->sem);							\
 										\
 	return retval;								\
-}
+}										\
+static CLASS_DEVICE_ATTR(name, S_IRUGO, input_dev_show_##name, NULL);
 
 INPUT_DEV_STRING_ATTR_SHOW(name);
 INPUT_DEV_STRING_ATTR_SHOW(phys);
 INPUT_DEV_STRING_ATTR_SHOW(uniq);
 
-static struct class_device_attribute input_dev_attrs[] = {
-	__ATTR(name, S_IRUGO, input_dev_show_name, NULL),
-	__ATTR(phys, S_IRUGO, input_dev_show_phys, NULL),
-	__ATTR(uniq, S_IRUGO, input_dev_show_uniq, NULL),
-	__ATTR_NULL
+static struct attribute *input_dev_attrs[] = {
+	&class_device_attr_name.attr,
+	&class_device_attr_phys.attr,
+	&class_device_attr_uniq.attr,
+	NULL
+};
+
+static struct attribute_group input_dev_group = {
+	.attrs	= input_dev_attrs,
 };
 
 #define INPUT_DEV_ID_ATTR(name)							\
@@ -694,7 +699,6 @@ struct class input_class = {
 	.name			= "input",
 	.release		= input_dev_release,
 	.hotplug		= input_dev_hotplug,
-	.class_dev_attrs	= input_dev_attrs,
 };
 
 struct input_dev *input_allocate_device(void)
@@ -732,6 +736,7 @@ static void input_register_classdevice(s
 	kfree(path);
 
 	class_device_add(&dev->cdev);
+	sysfs_create_group(&dev->cdev.kobj, &input_dev_group);
 	sysfs_create_group(&dev->cdev.kobj, &input_dev_id_attr_group);
 	sysfs_create_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
 }
