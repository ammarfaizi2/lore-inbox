Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbTCFX0c>; Thu, 6 Mar 2003 18:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbTCFXZ3>; Thu, 6 Mar 2003 18:25:29 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:59559 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261273AbTCFXZT>; Thu, 6 Mar 2003 18:25:19 -0500
Date: Fri, 7 Mar 2003 00:30:47 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, Brett <generica@email.com>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: [PATCH] pcmcia: it works again! [Was: Re: [PATCH] Re: pcmcia no worky in 2.5.6[32]]
Message-ID: <20030306233047.GB1016@brodo.de>
References: <20030305063635.GA2507@brodo.de> <Pine.LNX.4.44.0303061307130.15121-100000@bad-sports.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303061307130.15121-100000@bad-sports.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Mar 06, 2003 at 01:07:58PM +1100, Brett wrote:
> > Yes: platform_match within the pcmcia core wasn't doing was it was supposed
> > to do... and it still doesn't work in 2.5.64. So could you please try if it
> > works with this patch against 2.5.64?
> 
> Yep, the patch fixed it.
> Now happy in 2.5.64 with pcmcia again
> 
> many thanks,
> 
> 	/ Brett

please apply this patch:

platform_device_register may only be called after all class-specific 
device data is initialized, or else the class-type add_device call (which
enables the pcmcia sockets) will fail.

 hd64465_ss.c |    2 +-
 i82365.c     |    4 ++--
 tcic.c       |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

   Dominik

diff -ruN linux-original/drivers/pcmcia/hd64465_ss.c linux/drivers/pcmcia/hd64465_ss.c
--- linux-original/drivers/pcmcia/hd64465_ss.c	2003-03-05 07:19:13.000000000 +0100
+++ linux/drivers/pcmcia/hd64465_ss.c	2003-03-05 07:35:34.000000000 +0100
@@ -1070,8 +1070,8 @@
 	}
 
 /*	hd64465_io_debug = 0; */
-	platform_device_register(&hd64465_device);
 	hd64465_device.dev.class_data = &hd64465_data;
+	platform_device_register(&hd64465_device);
 
 	return 0;
 }
diff -ruN linux-original/drivers/pcmcia/i82365.c linux/drivers/pcmcia/i82365.c
--- linux-original/drivers/pcmcia/i82365.c	2003-03-05 07:19:13.000000000 +0100
+++ linux/drivers/pcmcia/i82365.c	2003-03-05 07:35:34.000000000 +0100
@@ -1628,11 +1628,11 @@
 	request_irq(cs_irq, pcic_interrupt, 0, "i82365", pcic_interrupt);
 #endif
     
-    platform_device_register(&i82365_device);
-
     i82365_data.nsock = sockets;
     i82365_device.dev.class_data = &i82365_data;
     
+    platform_device_register(&i82365_device);
+
     /* Finally, schedule a polling interrupt */
     if (poll_interval != 0) {
 	poll_timer.function = pcic_interrupt_wrapper;
diff -ruN linux-original/drivers/pcmcia/tcic.c linux/drivers/pcmcia/tcic.c
--- linux-original/drivers/pcmcia/tcic.c	2003-03-05 07:19:13.000000000 +0100
+++ linux/drivers/pcmcia/tcic.c	2003-03-05 07:35:34.000000000 +0100
@@ -452,8 +452,6 @@
 	sockets++;
     }
 
-    platform_device_register(&tcic_device);
-
     switch (socket_table[0].id) {
     case TCIC_ID_DB86082:
 	printk("DB86082"); break;
@@ -527,6 +525,8 @@
     tcic_data.nsock = sockets;
     tcic_device.dev.class_data = &tcic_data;
 
+    platform_device_register(&tcic_device);
+
     return 0;
     
 } /* init_tcic */
