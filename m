Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTLPTej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 14:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTLPTej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 14:34:39 -0500
Received: from linux-bt.org ([217.160.111.169]:25229 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262128AbTLPTeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 14:34:36 -0500
Subject: Problem with keyboard LED's and 2.4.x
From: Marcel Holtmann <marcel@holtmann.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1071603216.27574.25.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Dec 2003 20:33:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I already sent a patch for this, but forgot to include a detailed
description what is going wrong here.

The initial keyboard LED state is not send to a new attached keyboard if
this keyboard is connected through the input subsystem and driven by the
keybdev.o kernel driver. This is problematic for USB keyboards through
the USB HID driver and Bluetooth keyboard that send their events through
the uinput.o driver from a userspace daemon.

This is the problematic code from drivers/input/keybdev.c (I stripped
some unimportant things):

	static struct input_handler keybdev_handler;
	
	void keybdev_ledfunc(unsigned int led)
	{
	        struct input_handle *handle;
	
	        for (handle = keybdev_handler.handle; handle; handle = handle->hnext) {
	                input_event(handle->dev, EV_LED, LED_SCROLLL, !!(led & 0x01));
	                input_event(handle->dev, EV_LED, LED_NUML,    !!(led & 0x02));
	                input_event(handle->dev, EV_LED, LED_CAPSL,   !!(led & 0x04));
	        }
	}
	
	static struct input_handle *keybdev_connect(struct input_handler *handler, struct input_dev *dev)
	{
	        struct input_handle *handle;
	        int i;
		
	        if (!(handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
        	        return NULL;
	        memset(handle, 0, sizeof(struct input_handle));
	
	        handle->dev = dev;
	        handle->handler = handler;
	
	        input_open_device(handle);
	
	        kbd_refresh_leds();
	
        	return handle;
	}

The problematic part is the call of kbd_refresh_leds() which triggers
the sending of the LED events to every keyboard by keybdev_ledfunc().
But at this point keybdev_ledfunc() don't know anything about this new
keyboard, because the list of handles from keybdev_handler are not
updated by now. This first happens when keybdev_connect() returns this
new handle.

To solve this problem we have to know the current LED state when we
connect a new keyboard and send out the LED events before returning the
new handle. My patch is tested with an USB keyboard and the Bluetooth
mediapad from Logitech.

Regards

Marcel


Please do a

        bk pull http://linux-mh.bkbits.net/input-2.4

This will update the following files:

 drivers/input/keybdev.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

through these ChangeSets:

<marcel@holtmann.org> (03/12/16 1.1304)
   [PATCH] Fix LED's for input subsystem keyboards
   
   This patch propagates the current LED's to every new keyboard device
   that is attached through the input subsystem.



