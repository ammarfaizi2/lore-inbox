Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966226AbWKTRPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966226AbWKTRPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966227AbWKTRPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:15:20 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:35200 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S966226AbWKTRPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:15:19 -0500
Message-ID: <4561E290.7060100@gmail.com>
Date: Mon, 20 Nov 2006 18:14:56 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
CC: Greg KH <gregkh@suse.de>
Subject: kobject_add failed with -EEXIST
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Does anybody have some clue, what's wrong with the attached module?
Kernel complains when the module is insmoded second time (DRIVER_DEBUG enabled):


cls_init  				FIRST TIME
device class 'cls_class': registering
DEV: registering device: ID = 'cls_device'
PM: Adding info for No Bus:cls_device
DEV: Unregistering device. ID = 'cls_device'
PM: Removing info for No Bus:cls_device
device_create_release called for cls_device
device class 'cls_class': unregistering
class 'cls_class': release.
class_create_release called for cls_class
cls_exit
cls_init				SECOND TIME
device class 'cls_class': registering
DEV: registering device: ID = 'cls_device'
kobject_add failed for cls_class with -EEXIST, don't try to register things with
the same name in the same directory.
 [<c0103edd>] show_trace_log_lvl+0x26/0x3c
 [<c0104000>] show_trace+0x1b/0x1d
 [<c010480a>] dump_stack+0x24/0x26
 [<c01e39e7>] kobject_add+0x131/0x1b6
 [<c01e3bd7>] kobject_register+0x24/0x4c
 [<c01e3c55>] kobject_add_dir+0x56/0x76
 [<c0256955>] setup_parent+0x6f/0x9e
 [<c0256dff>] device_add+0x7f/0x4ee
 [<c0257288>] device_register+0x1a/0x20
 [<c025731c>] device_create+0x8e/0xb2
 [<f89b0052>] cls_init+0x52/0x9f [cls]
 [<c0140f00>] sys_init_module+0x15a/0x1ace
 [<c01030f8>] syscall_call+0x7/0xb
 =======================
kobject_add_dir: kobject_register error: -17
PM: Adding info for No Bus:cls_device


-8<-----------8<-----------8<-----------8<-
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/device.h>
#include <linux/err.h>

static struct class *cls;
static struct device *dev;

static int __init cls_init(void)
{
        printk(KERN_INFO "cls_init\n");
        cls = class_create(THIS_MODULE, "cls_class");
        if (IS_ERR(cls)) {
                printk(KERN_ERR "class_create: %ld", PTR_ERR(cls));
                return -ENODEV;
        }
        dev = device_create(cls, NULL, 0, "cls_device");
        if (IS_ERR(dev)) {
                printk(KERN_ERR "device_create: %ld", PTR_ERR(dev));
                class_destroy(cls);
                return -ENODEV;
        }

        return 0;
}

static void __exit cls_exit(void)
{
        device_unregister(dev);
        class_destroy(cls);
        printk(KERN_INFO "cls_exit\n");
}

module_init(cls_init);
module_exit(cls_exit);

MODULE_LICENSE("GPL");
-8<-----------8<-----------8<-----------8<-

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
