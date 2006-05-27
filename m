Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932783AbWE0Axh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbWE0Axh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 20:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbWE0Axh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 20:53:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:21110 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932783AbWE0Axg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 20:53:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=m9O3vrA/ihFwTKcl+mS+8EhgiyCfR71bUDEzvxiCiuZgBK4b+Jjdq/DfKehDqGTLdj2xIG0uUK5re29o4LrrDGN+Mbat6eMJRV68kGtdaoqFBL2xi/fhTpGNVf53sm31f6O1uwveAg0cufZfITUKqVTr8v24fLy404ucPkZBmak=
Message-ID: <4477A30D.5030904@gmail.com>
Date: Sat, 27 May 2006 03:53:33 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [patch] input: use event handler in ff drivers
References: <20060526161129.557416000@gmail.com>	<20060526162902.227348000@gmail.com>	<20060526141603.054f0459.akpm@osdl.org>	<44777340.7030905@gmail.com>	<20060526144309.60469bcd.akpm@osdl.org>	<447778DA.8080507@gmail.com>	<20060526150804.0ae11b1f.akpm@osdl.org>	<44777F98.4080004@gmail.com>	<20060526153246.267991ed.akpm@osdl.org>	<44778A14.4060500@gmail.com>	<20060526162842.4da6b447.akpm@osdl.org>	<447790BB.4060707@gmail.com> <20060526164543.52f5b8a0.akpm@osdl.org>
In-Reply-To: <20060526164543.52f5b8a0.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020708010606090506030106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020708010606090506030106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Call input_ff_event() from drivers when they receive EV_FF event through
event() of struct input_dev.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---

This is to be applied after other patches in my last patchset.

 input/joystick/iforce/iforce-main.c |    1 +
 input/misc/uinput.c                 |    3 +++
 usb/input/hid-input.c               |    3 +++
 3 files changed, 7 insertions(+)

--------------020708010606090506030106
Content-Type: text/x-patch;
 name="ff-refactoring-use-event-handler-in-drivers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ff-refactoring-use-event-handler-in-drivers.diff"

Index: linux-2.6.17-rc4-git12/drivers/usb/input/hid-input.c
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/usb/input/hid-input.c	2006-05-27 03:45:06.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/usb/input/hid-input.c	2006-05-27 03:45:07.000000000 +0300
@@ -717,6 +717,9 @@ static int hidinput_input_event(struct i
 	struct hid_field *field;
 	int offset;
 
+	if (type == EV_FF)
+		return input_ff_event(dev, type, code, value);
+
 	if (type != EV_LED)
 		return -1;
 
Index: linux-2.6.17-rc4-git12/drivers/input/joystick/iforce/iforce-main.c
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/input/joystick/iforce/iforce-main.c	2006-05-27 03:45:06.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/input/joystick/iforce/iforce-main.c	2006-05-27 03:45:07.000000000 +0300
@@ -306,6 +306,7 @@ int iforce_init_device(struct iforce *if
 	input_dev->name = "Unknown I-Force device";
 	input_dev->open = iforce_open;
 	input_dev->close = iforce_release;
+	input_dev->event = input_ff_event;
 	if (!ff_err)
 		input_dev->ff_effects_max = 10;
 
Index: linux-2.6.17-rc4-git12/drivers/input/misc/uinput.c
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/input/misc/uinput.c	2006-05-27 03:45:06.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/input/misc/uinput.c	2006-05-27 03:45:07.000000000 +0300
@@ -43,6 +43,9 @@ static int uinput_dev_event(struct input
 {
 	struct uinput_device	*udev;
 
+	if (type == EV_FF)
+		return input_ff_event(dev, type, code, value);
+
 	udev = dev->private;
 
 	udev->buff[udev->head].type = type;

--------------020708010606090506030106--
