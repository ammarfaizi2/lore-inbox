Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbTDIIQ6 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 04:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbTDIIQ6 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 04:16:58 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.28]:34357 "EHLO
	mwinf0303.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262905AbTDIIQ4 (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 04:16:56 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH] USB speedtouch: don't open a connection if no firmware
Date: Wed, 9 Apr 2003 10:28:25 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200304080926.43403.baldrick@wanadoo.fr> <200304082222.10919.baldrick@wanadoo.fr> <20030408214045.GA6376@kroah.com>
In-Reply-To: <20030408214045.GA6376@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304091028.25268.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Greg, I'm waiting on the fixes to the ATM layer (coming soon to a
> > kernel near you).
>
> Ah, ok, that makes sense.
>
> > As for the position of MOD_INC_USE_COUNT, did you ever hear
> > of anyone getting bitten by a race like this?  If it makes you feel
> > better, I will move it up, probably just before I take the semaphore
> > (since that is the first place we can sleep).  I will do it tomorrow, OK?
>
> Yes, it needs to be before any function that can sleep.  I'll hold off
> applying this patch then.

How about this one instead.  MOD_INC_USE_COUNT is placed before I call
any functions that can sleep.  Let's just hope that the call to me doesn't
come after some sleeping in the higher layers...

Duncan.

--- redux-2.5/drivers/usb/misc/speedtch.c	2003-04-08 08:49:33.000000000 +0200
+++ bollux-2.5/drivers/usb/misc/speedtch.c	2003-04-09 10:08:27.000000000 +0200
@@ -933,15 +933,24 @@
 	if (vcc->qos.aal != ATM_AAL5)
 		return -EINVAL;
 
+	if (!instance->firmware_loaded) {
+		dbg ("firmware not loaded!");
+		return -EAGAIN;
+	}
+
+	MOD_INC_USE_COUNT;
+
 	down (&instance->serialize); /* vs self, udsl_atm_close */
 
 	if (udsl_find_vcc (instance, vpi, vci)) {
 		up (&instance->serialize);
+		MOD_DEC_USE_COUNT;
 		return -EADDRINUSE;
 	}
 
 	if (!(new = kmalloc (sizeof (struct udsl_vcc_data), GFP_KERNEL))) {
 		up (&instance->serialize);
+		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 
@@ -967,10 +976,7 @@
 
 	dbg ("Allocated new SARLib vcc 0x%p with vpi %d vci %d", new, vpi, vci);
 
-	MOD_INC_USE_COUNT;
-
-	if (instance->firmware_loaded)
-		udsl_fire_receivers (instance);
+	udsl_fire_receivers (instance);
 
 	dbg ("udsl_atm_open successful");
 
@@ -1041,6 +1047,7 @@
 		int ret;
 
 		if ((ret = usb_set_interface (instance->usb_dev, 1, 1)) < 0) {
+			dbg ("usb_set_interface returned %d!", ret);
 			up (&instance->serialize);
 			return ret;
 		}
