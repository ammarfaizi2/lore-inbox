Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751855AbWEPQ3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWEPQ3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbWEPQ3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:29:42 -0400
Received: from mail.aknet.ru ([82.179.72.26]:37646 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751855AbWEPQ3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:29:42 -0400
Message-ID: <4469FDF0.3020403@aknet.ru>
Date: Tue, 16 May 2006 20:29:36 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: dtor_core@ameritech.net, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] add input_enable_device()
References: <44670446.7080409@aknet.ru>	<20060515143119.54b5aff8.akpm@osdl.org>	<4469F709.4040605@aknet.ru> <20060516090324.66ea0ea6.akpm@osdl.org>
In-Reply-To: <20060516090324.66ea0ea6.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030804010705060103080703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030804010705060103080703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Andrew Morton wrote:
> iirc it had to do with the pc-speaker driver, but I don't seem to be able
> to locate the original email.
OK, sorry, I haven't realized its important.

---
The patch below adds input_enable_device() and input_disable_device()
to the input subsystem, that allows to enable and disable the input
devices. The reason to have it, is the snd-pcsp PC-Speaker driver in
an ALSA tree that needs an ability to disable the pcspkr driver.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>
CC: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Vojtech Pavlik <vojtech@suse.cz>


--------------030804010705060103080703
Content-Type: text/x-patch;
 name="input_en2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="input_en2.diff"

--- a/include/linux/input.h	2006-04-05 17:10:01.000000000 +0400
+++ b/include/linux/input.h	2006-04-05 17:36:49.000000000 +0400
@@ -878,7 +878,7 @@
 
 	struct pt_regs *regs;
 	int state;
-
+	int disabled;
 	int sync;
 
 	int abs[ABS_MAX + 1];
@@ -1038,6 +1038,9 @@
 int input_open_device(struct input_handle *);
 void input_close_device(struct input_handle *);
 
+void input_enable_device(struct input_handle *handle);
+void input_disable_device(struct input_handle *handle);
+
 int input_accept_process(struct input_handle *handle, struct file *file);
 int input_flush_device(struct input_handle* handle, struct file* file);
 
--- a/drivers/input/input.c	2006-01-12 11:23:09.000000000 +0300
+++ b/drivers/input/input.c	2006-04-05 17:51:27.000000000 +0400
@@ -37,6 +37,8 @@
 EXPORT_SYMBOL(input_release_device);
 EXPORT_SYMBOL(input_open_device);
 EXPORT_SYMBOL(input_close_device);
+EXPORT_SYMBOL(input_enable_device);
+EXPORT_SYMBOL(input_disable_device);
 EXPORT_SYMBOL(input_accept_process);
 EXPORT_SYMBOL(input_flush_device);
 EXPORT_SYMBOL(input_event);
@@ -53,7 +55,7 @@
 {
 	struct input_handle *handle;
 
-	if (type > EV_MAX || !test_bit(type, dev->evbit))
+	if (type > EV_MAX || !test_bit(type, dev->evbit) || dev->disabled)
 		return;
 
 	add_input_randomness(type, code, value);
@@ -269,6 +271,16 @@
 	mutex_unlock(&dev->mutex);
 }
 
+void input_enable_device(struct input_handle *handle)
+{
+	handle->dev->disabled = 0;
+}
+
+void input_disable_device(struct input_handle *handle)
+{
+	handle->dev->disabled = 1;
+}
+
 static void input_link_handle(struct input_handle *handle)
 {
 	list_add_tail(&handle->d_node, &handle->dev->h_list);

--------------030804010705060103080703--
