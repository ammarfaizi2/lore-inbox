Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161535AbWJLGPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161535AbWJLGPh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWJLGPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:15:37 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:22389 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932493AbWJLGPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:15:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dav7W6jQzFp5E2CRETGxBw1WEr+EVLV4B4IrBhg0D+E0HUBLvydE8NYC8vkQqWWJTuJnUF/kx2r3pqbrJFVm64OMxhP86+OTrr0La4JmrzldaeJkJK+HHYn6kZjHagIaEpv2ABkYdqGMemKzcR7VYciOeJt/hSr4KnNBAKHsFkw=
Message-ID: <452DDDA0.4050708@gmail.com>
Date: Thu, 12 Oct 2006 14:16:00 +0800
From: Liyu <raise.sail@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Li Yu <raise.sail@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Greg Kroah Hartman <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Vincent Legoll <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.0 documentation
References: <200610121348386870668@gmail.com>
In-Reply-To: <200610121348386870668@gmail.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liyu <raise.sail@gmail.com>

--- linux-2.6.18/Documentation/input/no-such.txt 1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.18/Documentation/input/simple-hid.txt 2006-10-12
09:34:42.000000000 +0800
@@ -0,0 +1,251 @@
+==================================
+HID device simple driver interface
+==================================
+
+------------------------
+Note
+------------------------
+
+ If you just begin to study from writing input device driver, please
see the
+input-programming.txt, I am afraid this is not you want, do not confuse
with the
+"simple" in this name.
+
+------------------------
+Version
+------------------------
+
+ This is the version 0.4.0
+
+--------------------------
+Overview
+--------------------------
+
+ Under standard HID device driver development means, we need to write
+one interrupt handler for each new HID device to report event to
+input subsystem. However, although the most of they can not merge into
+mainstream kernel tree, they have only some extended keys, e.g. many
+remote controllers. I think it seem break a fly on the wheel, which
+write one new interrupt handler for this reason.
+
+ The basic idea is reuse the interrupt handler in hid-core.c. so writing
+driver for new simple HID device will be more easier, quickly, and do not
+need touch hid core.
+
+ In essence, this interface just is some hooks in HID core.
+
+ The hid-simple.h include this API. But, defore use this interface, you
must
+include hid.h first.
+
+------------------------
+What's you will get from this interface.
+------------------------
+
+ Use me, you can:
+
+ 1. Write the driver of USB input device without write code take care of
+ details of setup and clear usage.
+ 2. A driver use this interface can be as a HID device input filter.
+ 3. Write USB force-feed driver without touch hid-input core. however, this
+ feature is confilct with HID_FF.
+
+ This interface can not support the more drivers handle one device at
same time
+yet. I can not sure if we really need this feature.
+
+------------------------
+The driver use this interface
+------------------------
+
+ So far, there are two drivers:
+ 1. MS Natural Ergonomic Keyboard 4000 driver. (usbnek4k.c)
+ 2. Betop BTP-2118 joystick force-feed driver. (btp2118.c)
+
+-------------------------
+Requires
+-------------------------
+
+ Before use this interface, you must turn on these kernel configuration
+items:
+
+ CONFIG_HID_SIMPLE : HID simple driver interface
+ CONFIG_HID_SIMPLE_FF : HID simple driver interface force feedback support
+
+ Note: You can see the latter only if you turn off CONFIG_HID_FF and turn
+on CONFIG_HID_SIMPLE.
+
+--------------------------
+Register and unregister
+--------------------------
+
+1. Register a simple driver.
+
+ int hidinput_register_simple_driver(struct hidinput_simple_driver *simple)
+
+ Like any driver register function, it register your driver to kernel,
+when the chance that match device come, your driver can probe it. At
least, you
+must fill the member of parameter simple : name.
+ Return 0 mean register successfully. elsewise mean there have some
+failures in register process.
+ So far, this function only can return 0 and -EINVAL.
+ When you driver matched one device, it will reregister it into input
+subsystem (see the function hidinput_reconnect_core(), if you want).
+
+2. Unregister a simple driver.
+
+ void hidinput_unregister_simple_driver(struct hidinput_simple_driver
*simple)
+
+ Like any driver register function, it clean your driver from kernel, and
+in this process, your driver will disconnect any device which it
matched. However,
+it do not free your memory of driver structure, that's your task.
+ This may reregister the device into input subsystem (see the function
+hidinput_reconnect_core(), if you want).
+
+----------------------------------
+Usage
+----------------------------------
+
+ Each simple driver have one data structure hidinput_simple_driver:
+
+struct hidinput_simple_driver {
+ /*
+ * The members for implement only are ignored here,
+ * please do not depend on them
+ */
+ /* public */
+ struct module *owner;
+ char *name;
+ int (*connect)(struct hid_device *, struct hid_input *);
+ void (*disconnect)(struct hid_device *, struct hid_input *);
+ void (*setup_usage)(struct hid_field *, struct hid_usage *);
+ void (*clear_usage)(struct hid_field *, struct hid_usage *);
+ int (*pre_event)(const struct hid_device *, const struct hid_field *,
+ const struct hid_usage *, const __s32,
+ const struct pt_regs *regs);
+ int (*post_event)(const struct hid_device *, const struct hid_field *,
+ const struct hid_usage *, const __s32,
+ const struct pt_regs *regs);
+
+ int (*open)(struct input_dev *dev);
+ void (*close)(struct input_dev *dev);
+ int (*upload_effect)(struct input_dev *dev, struct ff_effect *effect);
+ int (*erase_effect)(struct input_dev *dev, int effect_id);
+ int (*flush)(struct input_dev *dev, struct file *file);
+ int (*ff_event)(struct input_dev *dev, int type, int code, int value);
+
+ void *private;
+ struct usb_device_id *id_table;
+ struct usage_page_block *usage_page_table;
+};
+
+The data member description:
+
+ struct module *owner;
+
+ In most cases, set this member to THIS_MODULE is your want to.
+
+ char *name;
+
+ The name of your driver. you must fill this member before register it.
+
+ void *private;
+
+ You can save the data that your driver use only here. HID simple driver
+core do not take care of this.
+
+ struct usb_device_id *id_table;
+
+ As same with other USB device driver, this is used by matching device,
+if so, then call probe()/connect() methods of your driver.
+ In general, you always want to fill this member with something.
+
+ struct usage_page_block *usage_page_table;
+
+ Totally, there are three means you can complete setup and clean HID
usage work,
+which use this member is one of them. Moreover, this means is the most
simplest one.
+By fill this member, kernel will complete setup and clean usage work
automatically.
+ It will spend many words to explain details, I think the best
documentation
+of this is the example, you can find them in usbnek4k.c and btp2118.c.
I believe
+you have enough intelligence to understand them, but if you had familiar
+with HID first. :) When you read these examples, you also will find out
some other
+related data structures ,however, don't worry, they are too simple to
not discuss
+them.
+
+--------------------------------
+Generic Methods
+--------------------------------
+
+The simple driver methods description:
+
+ Although this simple driver have not direct relation with Linux
+device driver architecture, but I still make its API like it on purpose.
+The simple driver have follow methods:
+
+1. int (*connect)(struct hid_device *, struct hid_input *);
+2. void (*disconnect)(struct hid_device *, struct hid_input *);
+
+ When you simple driver is to bind with one real HID device, we will
+call connect() method first. To return 0 flag that it complete its mission
+successfully, so we can continue, return any other value is looked as
+error, any processing do not come.
+ When the device which your simple driver connect with is down, or
+this simple driver is unregistered, we will call disconnect() method first.
+
+3. void (*setup_usage)(struct hid_field *, struct hid_usage *);
+4. void (*clear_usage)(struct hid_field *, struct hid_usage *);
+
+ The setup_usage() method like hidinput_configure_usage() in
+hid_input.c. You also can setup input_dev here. I think
+you should be fill the pointer slot for this method, or fill
usage_page_table
+member of hidinput_simple_driver, elsewise the event() method do not
work for
+you at all. Please see example in "MS Natural Ergonomic Keyboard 4000"
driver.
+ The clear_usage() method is used to clear side-effect that came from
+setup_usage() method when one driver disconnect one device.
+ Of course, you can do same things in connect/disconnect() method, but
+these method can make your life more simpler.
+ At last, you can use these two methods and usage_page_table member
+at same time. These two methods always will be called after kernel process
+usage_page_table.
+
+6. int (*pre_event)(const struct hid_device *, const struct hid_field
+*, const struct hid_usage *, const __s32, const struct pt_regs *regs);
+
+ First, you can use this method send event to input subsystem,
+moreover, you can use this as one usage code filter: this method is called
+before all other event handling. If it return non-zero , any other event
+handling do not be processed, even the hid-input itself. If this method
+return zero, the normally event handling process will continue.
+ See the note [1].
+
+7. void (*post_event)(const struct hid_device *, const struct
+hid_field *, const struct hid_usage *, const __s32, const struct pt_regs
+*regs);
+
+ This is called after all other event handling. So if the pre_event()
method
+return non-zero value, this method also do not called at all.
+ See the note [1].
+
+8. int (*open)(struct input_dev *dev);
+9. void (*close)(struct input_dev *dev);
+
+ They are same with corresponding methods of struct input_dev. I assume
+you already familiar with them.
+
+---------------------------
+Force-feed support Methods
+---------------------------
+Follow methods are valid only if you turn on CONFIG_HID_SIMPLE_FF:
+
+10. int (*upload_effect)(struct input_dev *dev, struct ff_effect *effect);
+11. int (*erase_effect)(struct input_dev *dev, int effect_id);
+12. int (*flush)(struct input_dev *dev, struct file *file);
+13. int (*ff_event)(struct input_dev *dev, int type, int code, int value);
+
+ They are same with corresponding methods of struct input_dev. I assume
+you already familiar with them.
+
+
+=================================================================================
+
+NOTE:
+
+[1] If you do not configure usage correctly, this method do not work as
+ you want.

