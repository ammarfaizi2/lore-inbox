Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVAHHgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVAHHgH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVAHHfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:35:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:51333 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261878AbVAHFsW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:22 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163262994@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:43 -0800
Message-Id: <11051632632984@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.31, 2004/12/22 09:51:50-08:00, duncan.sands@math.u-psud.fr

[PATCH] usb atm: macro consolidation, fixes debugging problem

Hi Greg, the recent reorganisation of the speedtouch driver broke the logic
that turns on debugging output in speedtch.c and usb_atm.c when DEBUG or
CONFIG_USB_DEBUG is set.  This patch fixes things up, and moves duplicated
debugging code into the header file.

Signed-off-by: Duncan Sands <baldrick@free.fr>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/atm/speedtch.c |   20 --------------------
 drivers/usb/atm/usb_atm.c  |   17 -----------------
 drivers/usb/atm/usb_atm.h  |   19 ++++++++++++++++++-
 3 files changed, 18 insertions(+), 38 deletions(-)


diff -Nru a/drivers/usb/atm/speedtch.c b/drivers/usb/atm/speedtch.c
--- a/drivers/usb/atm/speedtch.c	2005-01-07 15:40:08 -08:00
+++ b/drivers/usb/atm/speedtch.c	2005-01-07 15:40:08 -08:00
@@ -44,28 +44,8 @@
 
 #include "usb_atm.h"
 
-/*
-#define DEBUG
-#define VERBOSE_DEBUG
-*/
-
-#if !defined (DEBUG) && defined (CONFIG_USB_DEBUG)
-#	define DEBUG
-#endif
-
-#include <linux/usb.h>
-
 #if defined(CONFIG_FW_LOADER) || defined(CONFIG_FW_LOADER_MODULE)
 #	define USE_FW_LOADER
-#endif
-
-#ifdef VERBOSE_DEBUG
-static int udsl_print_packet(const unsigned char *data, int len);
-#define PACKETDEBUG(arg...)	udsl_print_packet (arg)
-#define vdbg(arg...)		dbg (arg)
-#else
-#define PACKETDEBUG(arg...)
-#define vdbg(arg...)
 #endif
 
 #define DRIVER_AUTHOR	"Johan Verrept, Duncan Sands <duncan.sands@free.fr>"
diff -Nru a/drivers/usb/atm/usb_atm.c b/drivers/usb/atm/usb_atm.c
--- a/drivers/usb/atm/usb_atm.c	2005-01-07 15:40:08 -08:00
+++ b/drivers/usb/atm/usb_atm.c	2005-01-07 15:40:08 -08:00
@@ -83,23 +83,6 @@
 
 #include "usb_atm.h"
 
-/*
-#define DEBUG
-#define VERBOSE_DEBUG
-*/
-
-#if !defined (DEBUG) && defined (CONFIG_USB_DEBUG)
-#	define DEBUG
-#endif
-
-#include <linux/usb.h>
-
-#ifdef DEBUG
-#define UDSL_ASSERT(x)	BUG_ON(!(x))
-#else
-#define UDSL_ASSERT(x)	do { if (!(x)) warn("failed assertion '" #x "' at line %d", __LINE__); } while(0)
-#endif
-
 #ifdef VERBOSE_DEBUG
 static int udsl_print_packet(const unsigned char *data, int len);
 #define PACKETDEBUG(arg...)	udsl_print_packet (arg)
diff -Nru a/drivers/usb/atm/usb_atm.h b/drivers/usb/atm/usb_atm.h
--- a/drivers/usb/atm/usb_atm.h	2005-01-07 15:40:08 -08:00
+++ b/drivers/usb/atm/usb_atm.h	2005-01-07 15:40:08 -08:00
@@ -21,12 +21,29 @@
  *
  ******************************************************************************/
 
+#include <linux/config.h>
 #include <linux/list.h>
-#include <linux/usb.h>
 #include <linux/kref.h>
 #include <linux/atm.h>
 #include <linux/atmdev.h>
 #include <asm/semaphore.h>
+
+/*
+#define DEBUG
+#define VERBOSE_DEBUG
+*/
+
+#if !defined (DEBUG) && defined (CONFIG_USB_DEBUG)
+#	define DEBUG
+#endif
+
+#include <linux/usb.h>
+
+#ifdef DEBUG
+#define UDSL_ASSERT(x)	BUG_ON(!(x))
+#else
+#define UDSL_ASSERT(x)	do { if (!(x)) warn("failed assertion '" #x "' at line %d", __LINE__); } while(0)
+#endif
 
 #define UDSL_MAX_RCV_URBS		4
 #define UDSL_MAX_SND_URBS		4

