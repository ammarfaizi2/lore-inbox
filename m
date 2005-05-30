Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVE3HpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVE3HpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 03:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVE3HpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 03:45:22 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:22763 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261542AbVE3HpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 03:45:08 -0400
Subject: Re: 2.6.12-rc5-mm1: drivers/usb/atm/speedtch.c: gcc 2.95 compile
	error
From: Duncan Sands <baldrick@free.fr>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <20050529151231.GE10441@stusta.de>
References: <20050525134933.5c22234a.akpm@osdl.org>
	 <20050529151231.GE10441@stusta.de>
Content-Type: text/plain
Date: Mon, 30 May 2005 09:45:06 +0200
Message-Id: <1117439106.9515.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-29 at 17:12 +0200, Adrian Bunk wrote:
> The following compile error with gcc 2.95 seems to be caused by 
> broken-out/gregkh-usb-usb-usbatm-{1,2}.patch:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/usb/atm/speedtch.o
> drivers/usb/atm/speedtch.c: In function `speedtch_check_status':
> drivers/usb/atm/speedtch.c:447: parse error before `;'
> drivers/usb/atm/speedtch.c:456: parse error before `;'
> drivers/usb/atm/speedtch.c:463: parse error before `;'
> drivers/usb/atm/speedtch.c: In function `speedtch_status_poll':
> drivers/usb/atm/speedtch.c:507: parse error before `;'
> drivers/usb/atm/speedtch.c: In function `speedtch_handle_int':
> drivers/usb/atm/speedtch.c:550: parse error before `;'
> drivers/usb/atm/speedtch.c:552: parse error before `;'
> make[3]: *** [drivers/usb/atm/speedtch.o] Error 1
> 
> <--  snip  -->

Hi Adrian, it looks like gcc 2.95 doesn't like this kind of macro

#define atm_info(instance, format, arg...)	\
	atm_printk(KERN_INFO, instance , format , ## arg)

being called with only two arguments.  I don't know what
the best fix is, but this does the trick:

Signed-off-by: Duncan Sands <baldrick@free.fr>

--- Linux/drivers/usb/atm/speedtch.c.orig	3 May 2005 07:30:42 -0000	1.58
+++ Linux/drivers/usb/atm/speedtch.c	30 May 2005 07:37:45 -0000
@@ -444,7 +444,7 @@ static void speedtch_check_status(struct
 	case 0:
 		if (atm_dev->signal != ATM_PHY_SIG_LOST) {
 			atm_dev->signal = ATM_PHY_SIG_LOST;
-			atm_info(usbatm, "ADSL line is down\n");
+			atm_info(usbatm, "%s\n", "ADSL line is down");
 			/* It'll never resync again unless we ask it to... */
 			ret = speedtch_start_synchro(instance);
 		}
@@ -453,14 +453,14 @@ static void speedtch_check_status(struct
 	case 0x08:
 		if (atm_dev->signal != ATM_PHY_SIG_UNKNOWN) {
 			atm_dev->signal = ATM_PHY_SIG_UNKNOWN;
-			atm_info(usbatm, "ADSL line is blocked?\n");
+			atm_info(usbatm, "%s\n", "ADSL line is blocked?");
 		}
 		break;
 
 	case 0x10:
 		if (atm_dev->signal != ATM_PHY_SIG_LOST) {
 			atm_dev->signal = ATM_PHY_SIG_LOST;
-			atm_info(usbatm, "ADSL line is synchronising\n");
+			atm_info(usbatm, "%s\n", "ADSL line is synchronising");
 		}
 		break;
 
@@ -504,7 +504,7 @@ static void speedtch_status_poll(unsigne
 	if (instance->poll_delay < MAX_POLL_DELAY)
 		mod_timer(&instance->status_checker.timer, jiffies + msecs_to_jiffies(instance->poll_delay));
 	else
-		atm_warn(instance->usbatm, "Too many failures - disabling line status polling\n");
+		atm_warn(instance->usbatm, "%s\n", "Too many failures - disabling line status polling");
 }
 
 static void speedtch_resubmit_int(unsigned long data)
@@ -547,9 +547,9 @@ static void speedtch_handle_int(struct u
 
 	if ((count == 6) && !memcmp(up_int, instance->int_data, 6)) {
 		del_timer(&instance->status_checker.timer);
-		atm_info(usbatm, "DSL line goes up\n");
+		atm_info(usbatm, "%s\n", "DSL line goes up");
 	} else if ((count == 6) && !memcmp(down_int, instance->int_data, 6)) {
-		atm_info(usbatm, "DSL line goes down\n");
+		atm_info(usbatm, "%s\n", "DSL line goes down");
 	} else {
 		int i;
 


