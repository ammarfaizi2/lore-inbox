Return-Path: <linux-kernel-owner+w=401wt.eu-S1750865AbWLQTan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWLQTan (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 14:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWLQTam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 14:30:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:51901 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbWLQTal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 14:30:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:mime-version:content-type:content-transfer-encoding;
        b=o1qpOJ8EYVkg/3ZyOvbLvIhxCtU9YJ/YgrejYhl5P05L6I3avpp/0A68DiDPsAAiZbqJ75lVVSUB1GFSUPPkACDssfyoLwgoe3NmQOVR/NIdsqrulUnsEvF5RPs18H4RAYP6S2UjUMS2vDaCj8ibUmVICMDGJ8VVAf3p1B6RkGw=
Date: Sun, 17 Dec 2006 21:30:36 +0200
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <1866913935.20061217213036@gmail.com>
To: linux-kernel@vger.kernel.org, kernel-discuss@handhelds.org
CC: David Brownell <david-b@pacbell.net>, Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH] RTC classdev: Add sysfs support for wakeup alarm (r/w)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

Informal part
=============

    Small battery-powered systems, like PDAs, need a way to be
suspended most of the time and woken up just from time to time to
process pending tasks. Obvious way to achieve this is to use timer, or
alarm, wakeup. Unfortunately, this matter is bit confusing in Linux.
There's only one "good" "supported" way to set alarm - via ioctl() on
an RTC device fd. Unfortunately, this alarm is not persistent - as soon
as fd is closed, alarm id discharged. So, this calls for a daemon to
hold RTC fd all the time, IPC to it, etc. This may be just too
cumbersome for all tasks and for small devices, especially if we
talk solely about *wakeup* alarm.

    In this respect, I found insightful communication between David
Brownell and Russell King:

http://lkml.org/lkml/2006/11/20/311
http://lkml.org/lkml/2006/11/20/326
http://lkml.org/lkml/2006/11/20/371

    David's patch addresses exactly PDAs' need, so please count
another vote for it (except that I here have patch to address
his TODO, and which doesn't remove useful /proc data ;-) ).

    What's left after this is a nice way to set a wakeup alarm. The
patch below is initial try to implement it.

Formal part
===========

Implement "alarm" attribute group for RTC classdevs. At this time,
add "since_epoch", "wakeup_enabled", and "pending" attributes. First
two support both read and write.

Signed-off-by: Paul Sokolovsky <pmiscml@gmail.com>


Index: drivers/rtc/rtc-sysfs.c
===================================================================
RCS file: /cvs/linux/kernel26/drivers/rtc/rtc-sysfs.c,v
retrieving revision 1.3
diff -u -r1.3 rtc-sysfs.c
--- drivers/rtc/rtc-sysfs.c     17 Dec 2006 19:07:14 -0000      1.3
+++ drivers/rtc/rtc-sysfs.c     17 Dec 2006 19:09:49 -0000
@@ -66,6 +66,90 @@
 }
 static CLASS_DEVICE_ATTR(since_epoch, S_IRUGO, rtc_sysfs_show_since_epoch, NULL);
 
+
+static ssize_t rtc_sysfs_show_alarm_since_epoch(struct class_device *dev, char *buf)
+{
+       ssize_t retval;
+       struct rtc_wkalrm alrm;
+
+       retval = rtc_read_alarm(dev, &alrm);
+       if (retval == 0) {
+               unsigned long time;
+               rtc_tm_to_time(&alrm.time, &time);
+               retval = sprintf(buf, "%lu\n", time);
+       }
+
+       return retval;
+}
+
+static ssize_t rtc_sysfs_store_alarm_since_epoch(struct class_device *dev, const char *buf, size_t count)
+{
+       ssize_t retval;
+       struct rtc_wkalrm alrm;
+
+       unsigned long time = simple_strtoul(buf, NULL, 0);
+
+       retval = rtc_read_alarm(dev, &alrm);
+       if (retval)
+               return retval;
+       rtc_time_to_tm(time, &alrm.time);
+       retval = rtc_set_alarm(dev, &alrm);
+       if (retval)
+               return retval;
+
+       return count;
+}
+/* Use sysfs attribute name consistent with clock's */
+struct class_device_attribute class_device_attr_alarm_since_epoch = \
+       __ATTR(since_epoch, 0644 ,rtc_sysfs_show_alarm_since_epoch, rtc_sysfs_store_alarm_since_epoch);
+
+static ssize_t rtc_sysfs_show_alarm_wakeup_enabled(struct class_device *dev, char *buf)
+{
+       ssize_t retval;
+       struct rtc_wkalrm alrm;
+
+       retval = rtc_read_alarm(dev, &alrm);
+       if (retval == 0) {
+               retval = sprintf(buf, "%d\n", alrm.enabled);
+       }
+
+       return retval;
+}
+
+static ssize_t rtc_sysfs_store_alarm_wakeup_enabled(struct class_device *dev, const char *buf, size_t count)
+{
+       ssize_t retval;
+       struct rtc_wkalrm alrm;
+
+       unsigned long enabled = simple_strtoul(buf, NULL, 0);
+
+       retval = rtc_read_alarm(dev, &alrm);
+       if (retval)
+               return retval;
+       alrm.enabled = !!enabled;
+       retval = rtc_set_alarm(dev, &alrm);
+       if (retval)
+               return retval;
+
+       return count;
+}
+static CLASS_DEVICE_ATTR(wakeup_enabled, 0644, rtc_sysfs_show_alarm_wakeup_enabled, rtc_sysfs_store_alarm_wakeup_enabled);
+
+static ssize_t rtc_sysfs_show_alarm_pending(struct class_device *dev, char *buf)
+{
+       ssize_t retval;
+       struct rtc_wkalrm alrm;
+
+       retval = rtc_read_alarm(dev, &alrm);
+       if (retval == 0) {
+               retval = sprintf(buf, "%d\n", alrm.pending);
+       }
+
+       return retval;
+}
+static CLASS_DEVICE_ATTR(pending, S_IRUGO, rtc_sysfs_show_alarm_pending, NULL);
+
+
 static struct attribute *rtc_attrs[] = {
        &class_device_attr_name.attr,
        &class_device_attr_date.attr,
@@ -78,6 +162,19 @@
        .attrs = rtc_attrs,
 };
 
+static struct attribute *rtc_alarm_attrs[] = {
+       &class_device_attr_alarm_since_epoch.attr,
+       &class_device_attr_wakeup_enabled.attr,
+       &class_device_attr_pending.attr,
+       NULL,
+};
+
+static struct attribute_group rtc_alarm_attr_group = {
+       .name   = "alarm",
+       .attrs  = rtc_alarm_attrs,
+};
+
+
 static int __devinit rtc_sysfs_add_device(struct class_device *class_dev,
                                        struct class_interface *class_intf)
 {
@@ -86,10 +183,19 @@
        dev_dbg(class_dev->dev, "rtc intf: sysfs\n");
 
        err = sysfs_create_group(&class_dev->kobj, &rtc_attr_group);
-       if (err)
+       if (err) {
                dev_err(class_dev->dev,
                        "failed to create sysfs attributes\n");
+               goto error;
+       }
+       err = sysfs_create_group(&class_dev->kobj, &rtc_alarm_attr_group);
+       if (err) {
+               sysfs_remove_group(&class_dev->kobj, &rtc_attr_group);
+               dev_err(class_dev->dev,
+                       "failed to create sysfs alarm attributes\n");
+       }
 
+error:
        return err;
 }
 
@@ -97,6 +203,7 @@
                                struct class_interface *class_intf)
 {
        sysfs_remove_group(&class_dev->kobj, &rtc_attr_group);
+       sysfs_remove_group(&class_dev->kobj, &rtc_alarm_attr_group);
 }
 
 /* interface registration */



-- 
Best regards,
 Paul                          mailto:pmiscml@gmail.com

