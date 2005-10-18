Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbVJRHae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbVJRHae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbVJRHae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:30:34 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:7143 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S1751455AbVJRHad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:30:33 -0400
Message-ID: <4354A49B.6060809@ens-lyon.org>
Date: Tue, 18 Oct 2005 09:30:35 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.14-rc4-mm1
References: <20051016154108.25735ee3.akpm@osdl.org> <43539762.2020706@ens-lyon.org> <20051017132242.2b872b08.akpm@osdl.org> <20051018065843.GB11858@kroah.com>
In-Reply-To: <20051018065843.GB11858@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------090204000700010302060501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090204000700010302060501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Le 18.10.2005 08:58, Greg KH a écrit :
> I know this patch doesn't have the proc path, but it does fix an easy
> oops that I can generate from sysfs input devices.  Can you try it out
> to see if it fixes your issue too?
> 
> thanks,
> 
> greg k-h

No sorry, it doesn't fix my oops.

By the way, your patch didn't apply to my rc4-mm1 tree.
The one I had to apply is attached.

I might add some debugging code into my tree to help debugging.
But, you'll have to tell what code and where :)

Brice

--------------090204000700010302060501
Content-Type: text/x-patch;
 name="fix-hotplug2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-hotplug2.patch"

--- linux-mm/drivers/input/input.c.old	2005-10-18 09:18:13.000000000 +0200
+++ linux-mm/drivers/input/input.c	2005-10-18 09:18:17.000000000 +0200
@@ -641,17 +641,22 @@ static ssize_t input_dev_show_##name(str
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
@@ -727,7 +732,6 @@ static void input_dev_release(struct cla
 static struct class input_dev_class = {
 	.name			= "input_dev",
 	.release		= input_dev_release,
-	.class_dev_attrs	= input_dev_attrs,
 };
 
 struct input_dev *input_allocate_device(void)
@@ -765,6 +769,7 @@ static void input_register_classdevice(s
 	kfree(path);
 
 	class_device_add(&dev->cdev);
+	sysfs_create_group(&dev->cdev.kobj, &input_dev_group);
 	sysfs_create_group(&dev->cdev.kobj, &input_dev_id_attr_group);
 	sysfs_create_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
 }

--------------090204000700010302060501--
