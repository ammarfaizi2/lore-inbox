Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317383AbSFMA1p>; Wed, 12 Jun 2002 20:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSFMA1o>; Wed, 12 Jun 2002 20:27:44 -0400
Received: from [209.237.59.50] ([209.237.59.50]:26195 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317383AbSFMA1o>; Wed, 12 Jun 2002 20:27:44 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.name>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] use __dma_buffer for USB
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 12 Jun 2002 17:27:40 -0700
Message-ID: <52ofeg2fb7.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use __dma_buffer to align buffer in struct usb_hub and descriptor in
struct usb_device since both are used for DMA.

Patch is against 2.4.19-pre10.

Thanks,
  Roland

 drivers/usb/hub.h   |    3 ++-
 include/linux/usb.h |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff -Naur linux-2.4.19-pre9.orig/drivers/usb/hub.h linux-2.4.19-pre9/drivers/usb/hub.h
--- linux-2.4.19-pre9.orig/drivers/usb/hub.h	Wed Jun 12 14:53:36 2002
+++ linux-2.4.19-pre9/drivers/usb/hub.h	Wed Jun 12 14:55:58 2002
@@ -3,6 +3,7 @@
 
 #include <linux/list.h>
 #include <linux/compiler.h>	/* likely()/unlikely() */
+#include <asm/dma_buffer.h>
 
 /*
  * Hub request types
@@ -125,7 +126,7 @@
 
 	struct urb *urb;		/* Interrupt polling pipe */
 
-	char buffer[(USB_MAXCHILDREN + 1 + 7) / 8]; /* add 1 bit for hub status change */
+	char buffer[(USB_MAXCHILDREN + 1 + 7) / 8] __dma_buffer; /* add 1 bit for hub status change */
 					/* and add 7 bits to round up to byte boundary */
 	int error;
 	int nerrors;
diff -Naur linux-2.4.19-pre9.orig/include/linux/usb.h linux-2.4.19-pre9/include/linux/usb.h
--- linux-2.4.19-pre9.orig/include/linux/usb.h	Wed Jun 12 14:53:52 2002
+++ linux-2.4.19-pre9/include/linux/usb.h	Wed Jun 12 14:55:40 2002
@@ -139,6 +139,7 @@
 #include <linux/interrupt.h>	/* for in_interrupt() */
 #include <linux/config.h>
 #include <linux/list.h>
+#include <asm/dma_buffer.h>
 
 #define USB_MAJOR 180
 
@@ -781,7 +782,7 @@
 	struct usb_device *parent;
 	struct usb_bus *bus;		/* Bus we're part of */
 
-	struct usb_device_descriptor descriptor;/* Descriptor */
+	struct usb_device_descriptor descriptor __dma_buffer;/* Descriptor */
 	struct usb_config_descriptor *config;	/* All of the configs */
 	struct usb_config_descriptor *actconfig;/* the active configuration */
 
