Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWDHIDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWDHIDH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 04:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWDHIDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 04:03:07 -0400
Received: from mail.aknet.ru ([82.179.72.26]:38415 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932290AbWDHIDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 04:03:03 -0400
Message-ID: <44376E2E.3020201@aknet.ru>
Date: Sat, 08 Apr 2006 12:02:54 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: 7eggert@gmx.de, Linux kernel <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
References: <5TCqf-E6-49@gated-at.bofh.it> <5TCqf-E6-51@gated-at.bofh.it>	 <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it>	 <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz>	 <44266472.5080309@aknet.ru> <d120d5000603270834j79e707ffu760eba3062531b64@mail.gmail.com>
In-Reply-To: <d120d5000603270834j79e707ffu760eba3062531b64@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------020306080708010001080305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020306080708010001080305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Dmitry Torokhov wrote:
> etc. All these alternative bells would not disrupt operation of your
> snd_pcsp module but it still would disable the bell because it does
> not know better.
OK, I now used INPUT_DEVICE_ID_MATCH_BUS, and, with something
like the attached patch, it seems to work. So essentially my
driver has enough of the knowledge about the device in question,
and this seems to be possible exactly only with the input subsystem.
(which makes me confident again that using the input subsystem
was exactly the right choice :)
What do you think about that approach?


--------------020306080708010001080305
Content-Type: text/x-patch;
 name="input_en.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="input_en.diff"

--- a/include/linux/input.h	2006-04-05 17:10:01.000000000 +0400
+++ b/include/linux/input.h	2006-04-05 17:36:49.000000000 +0400
@@ -862,7 +862,7 @@
 
 	struct pt_regs *regs;
 	int state;
-
+	int enabled;
 	int sync;
 
 	int abs[ABS_MAX + 1];
@@ -1019,6 +1019,8 @@
 int input_open_device(struct input_handle *);
 void input_close_device(struct input_handle *);
 
+void input_enable_device(struct input_handle *handle, int enab);
+
 int input_accept_process(struct input_handle *handle, struct file *file);
 int input_flush_device(struct input_handle* handle, struct file* file);
 
--- a/drivers/input/input.c	2006-01-12 11:23:09.000000000 +0300
+++ b/drivers/input/input.c	2006-04-05 17:51:27.000000000 +0400
@@ -36,6 +36,7 @@
 EXPORT_SYMBOL(input_release_device);
 EXPORT_SYMBOL(input_open_device);
 EXPORT_SYMBOL(input_close_device);
+EXPORT_SYMBOL(input_enable_device);
 EXPORT_SYMBOL(input_accept_process);
 EXPORT_SYMBOL(input_flush_device);
 EXPORT_SYMBOL(input_event);
@@ -52,7 +53,7 @@
 {
 	struct input_handle *handle;
 
-	if (type > EV_MAX || !test_bit(type, dev->evbit))
+	if (type > EV_MAX || !test_bit(type, dev->evbit) || !dev->enabled)
 		return;
 
 	add_input_randomness(type, code, value);
@@ -265,6 +266,11 @@
 	up(&dev->sem);
 }
 
+void input_enable_device(struct input_handle *handle, int enab)
+{
+	handle->dev->enabled = enab;
+}
+
 static void input_link_handle(struct input_handle *handle)
 {
 	list_add_tail(&handle->d_node, &handle->dev->h_list);
@@ -712,6 +718,7 @@
 		class_device_initialize(&dev->cdev);
 		INIT_LIST_HEAD(&dev->h_list);
 		INIT_LIST_HEAD(&dev->node);
+		dev->enabled = 1;
 	}
 
 	return dev;

--------------020306080708010001080305--
