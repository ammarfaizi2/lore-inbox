Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270229AbRIPKLg>; Sun, 16 Sep 2001 06:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270464AbRIPKL1>; Sun, 16 Sep 2001 06:11:27 -0400
Received: from [195.211.46.202] ([195.211.46.202]:13681 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S270229AbRIPKLN>;
	Sun, 16 Sep 2001 06:11:13 -0400
X-Spam-Filter: check_local@serv02.lahn.de by digitalanswers.org
Date: Sun, 16 Sep 2001 09:49:50 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linux USB Mailinglist <linux-usb-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] hiddev.c in 2.4.10-pre9
Message-ID: <Pine.LNX.4.33.0109160933300.25119-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello USB-ML, LKML!

Since 2.4.10-pre9 includes part
 - Alan Cox: merge input/joystick layer differences...
USB HID / non-input device driver support doesn't work anymore:

linux-2.4.10-pre9/drivers/usb/Config.in:55
dep_tristate '  USB HID / non-input device driver support' CONFIG_USB_HIDDEV $CONFIG_USB $CONFIG_USB_HID

linux-2.4.10-pre9/drivers/usb/Makefile:35
ifeq ($(CONFIG_USB_HIDDEV),y)
        hid-objs        += hiddev.o
endif

As soon as HID is compiled as a module CONFIG_USB_HIDDEV gets 'm' also and
will not be compiled and included in the kernel build. The old patch had a
simple line in drivers/usb/Makefile
obj-$(CONFIG_USB_HIDDEV)        += hiddev.o

As it looks to me, hiddev.o can't be compiled as a module any longer, thus
drivers/usb/Config.in looks wrong and should be changed to:

--- linux-2.4.10-pre9/drivers/usb/Config.in~	Sun Sep 16 09:44:53 2001
+++ linux-2.4.10-pre9/drivers/usb/Config.in	Sun Sep 16 09:47:49 2001
@@ -52,7 +52,9 @@
          dep_tristate '  USB HIDBP Mouse (basic) support' CONFIG_USB_MOUSE $CONFIG_USB $CONFIG_INPUT
       fi
       dep_tristate '  Wacom Intuos/Graphire tablet support' CONFIG_USB_WACOM $CONFIG_USB $CONFIG_INPUT
-      dep_tristate '  USB HID / non-input device driver support' CONFIG_USB_HIDDEV $CONFIG_USB $CONFIG_USB_HID
+      if [ "$CONFIG_USB_HID" != "n" ]; then
+         bool '  USB HID / non-input device driver support' CONFIG_USB_HIDDEV
+      fi
    fi

    comment 'USB Imaging devices'

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

