Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVAYAAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVAYAAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVAXX60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:58:26 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:28651 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261768AbVAXX4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:56:33 -0500
Date: Tue, 25 Jan 2005 00:56:44 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, patrick.boettcher@desy.de,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Message-ID: <20050124235644.GA19328@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	patrick.boettcher@desy.de, linux-dvb-maintainer@linuxtv.org,
	linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124124840.GH3515@stusta.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20050124124840.GH3515@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 217.86.181.249
Subject: Re: [linux-dvb-maintainer] 2.6.11-rc2-mm1: DVB compile error
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The following compile error comes from Linus' tree:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.bss+0xd50e4): multiple definition of `debug'
> arch/i386/kernel/built-in.o(.text+0x2e4c): first defined here
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> 
> The offender is in drivers/media/dvb/dibusb/dvb-dibusb-core.c:
> 
> "debug" is not a good name for a global variable...

I've sorted this out with Patrick. The attached patch cleans up
various aspects of dibusb module argument handling, so it's a bit
larger than just renaming "debug".

Andrew, could you please make sure this patch and
dib3000mc-build-fix.patch (from rc2-mm1) will be
merged into Linus tree before 2.6.11? Or should I
submit it to Linus seperately?

Thanks,
Johannes


diff -rupN linux-2.6.11-rc2-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c linux-2.6.11-rc2-mm1-dvb/drivers/media/dvb/dibusb/dvb-dibusb-core.c
--- linux-2.6.11-rc2-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-01-24 23:31:05.000000000 +0100
+++ linux-2.6.11-rc2-mm1-dvb/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-01-24 23:16:27.000000000 +0100
@@ -27,17 +27,19 @@
 #include <linux/moduleparam.h>
 
 /* debug */
-#ifdef CONFIG_DVB_DIBCOM_DEBUG
-int debug;
-module_param(debug, int, 0644);
-MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=alotmore,8=ts,16=err,32=rc (|-able)).");
+int dvb_dibusb_debug;
+module_param_named(debug, dvb_dibusb_debug,  int, 0644);
+MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=alotmore,8=ts,16=err,32=rc (|-able))."
+#ifndef CONFIG_DVB_DIBCOM_DEBUG
+		" (debugging is not enabled)"
 #endif
+);
 
-int pid_parse;
+static int pid_parse;
 module_param(pid_parse, int, 0644);
 MODULE_PARM_DESC(pid_parse, "enable pid parsing (filtering) when running at USB2.0");
 
-int rc_query_interval;
+static int rc_query_interval;
 module_param(rc_query_interval, int, 0644);
 MODULE_PARM_DESC(rc_query_interval, "interval in msecs for remote control query (default: 100; min: 40)");
 
@@ -410,6 +412,10 @@ static int dibusb_probe(struct usb_inter
 		dib->udev = udev;
 		dib->dibdev = dibdev;
 
+		/* store parameters to structures */
+		dib->rc_query_interval = rc_query_interval;
+		dib->pid_parse = pid_parse;
+
 		usb_set_intfdata(intf, dib);
 		
 		ret = dibusb_init(dib);
diff -rupN linux-2.6.11-rc2-mm1/drivers/media/dvb/dibusb/dvb-dibusb-remote.c linux-2.6.11-rc2-mm1-dvb/drivers/media/dvb/dibusb/dvb-dibusb-remote.c
--- linux-2.6.11-rc2-mm1/drivers/media/dvb/dibusb/dvb-dibusb-remote.c	2005-01-24 23:31:05.000000000 +0100
+++ linux-2.6.11-rc2-mm1-dvb/drivers/media/dvb/dibusb/dvb-dibusb-remote.c	2005-01-24 18:26:53.000000000 +0100
@@ -143,7 +143,7 @@ static void dibusb_remote_query(void *da
 	   if we're busy. */
 	dibusb_read_remote_control(dib);
 	schedule_delayed_work(&dib->rc_query_work,
-			      msecs_to_jiffies(rc_query_interval));
+			      msecs_to_jiffies(dib->rc_query_interval));
 }
 
 int dibusb_remote_init(struct usb_dibusb *dib)
@@ -171,11 +171,11 @@ int dibusb_remote_init(struct usb_dibusb
 	INIT_WORK(&dib->rc_query_work, dibusb_remote_query, dib);
 
 	/* Start the remote-control polling. */
-	if (rc_query_interval < 40)
-		rc_query_interval = 100; /* default */
+	if (dib->rc_query_interval < 40)
+		dib->rc_query_interval = 100; /* default */
 
-	info("schedule remote query interval to %d msecs.",rc_query_interval);
-	schedule_delayed_work(&dib->rc_query_work,msecs_to_jiffies(rc_query_interval));
+	info("schedule remote query interval to %d msecs.",dib->rc_query_interval);
+	schedule_delayed_work(&dib->rc_query_work,msecs_to_jiffies(dib->rc_query_interval));
 
 	dib->init_state |= DIBUSB_STATE_REMOTE;
 	
diff -rupN linux-2.6.11-rc2-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c linux-2.6.11-rc2-mm1-dvb/drivers/media/dvb/dibusb/dvb-dibusb-usb.c
--- linux-2.6.11-rc2-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-01-24 23:31:05.000000000 +0100
+++ linux-2.6.11-rc2-mm1-dvb/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-01-24 18:26:53.000000000 +0100
@@ -158,7 +158,7 @@ int dibusb_streaming(struct usb_dibusb *
 
 int dibusb_urb_init(struct usb_dibusb *dib)
 {
-	int ret,i,bufsize;
+	int ret,i,bufsize,def_pid_parse = 1;
 	
 	/*
 	 * when reloading the driver w/o replugging the device 
@@ -210,12 +210,14 @@ int dibusb_urb_init(struct usb_dibusb *d
 		dib->init_state |= DIBUSB_STATE_URB_SUBMIT;
 	}
 
-
-	dib->pid_parse = 1;
+	/* dib->pid_parse here contains the value of the module parameter */
+	/* decide if pid parsing can be deactivated: 
+	 * is possible (by speed) and wanted (by user) 
+	 */
 	switch (dib->dibdev->dev_cl->id) {
 		case DIBUSB2_0:
-			if (dib->udev->speed == USB_SPEED_HIGH && !pid_parse) {
-				dib->pid_parse = 0;
+			if (dib->udev->speed == USB_SPEED_HIGH && !dib->pid_parse) {
+				def_pid_parse = 0;
 				info("running at HIGH speed, will deliver the complete TS.");
 			} else
 				info("will use pid_parsing.");
@@ -223,6 +225,8 @@ int dibusb_urb_init(struct usb_dibusb *d
 		default: 
 			break;
 	}
+	/* from here on it contains the device and user decision */
+	dib->pid_parse = def_pid_parse;
 	
 	return 0;
 }
diff -rupN linux-2.6.11-rc2-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h linux-2.6.11-rc2-mm1-dvb/drivers/media/dvb/dibusb/dvb-dibusb.h
--- linux-2.6.11-rc2-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-01-24 23:31:05.000000000 +0100
+++ linux-2.6.11-rc2-mm1-dvb/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-01-24 18:26:53.000000000 +0100
@@ -27,31 +27,26 @@
 /* debug */
 #ifdef CONFIG_DVB_DIBCOM_DEBUG
 #define dprintk(level,args...) \
-	    do { if ((debug & level)) { printk(args); } } while (0)
+	    do { if ((dvb_dibusb_debug & level)) { printk(args); } } while (0)
 
-#define debug_dump(b,l) if (debug) {\
-	int i; deb_xfer("%s: %d > ",__FUNCTION__,l); \
+#define debug_dump(b,l) {\
+	int i; \
 	for (i = 0; i < l; i++) deb_xfer("%02x ", b[i]); \
 	deb_xfer("\n");\
 }
 
-/* module parameters - declared in -core.c */
-extern int debug;
-
 #else
 #define dprintk(args...)
 #define debug_dump(b,l)
 #endif
 
+extern int dvb_dibusb_debug;
+
 /* Version information */
 #define DRIVER_VERSION "0.3"
 #define DRIVER_DESC "Driver for DiBcom based USB Budget DVB-T device"
 #define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
 
-/* module parameters - declared in -core.c */
-extern int pid_parse;
-extern int rc_query_interval;
-
 #define deb_info(args...) dprintk(0x01,args)
 #define deb_xfer(args...) dprintk(0x02,args)
 #define deb_alot(args...) dprintk(0x04,args)
@@ -162,7 +157,6 @@ struct usb_dibusb {
 	int init_state;
 
 	int feedcount;
-	int pid_parse;
 	struct dib_fe_xfer_ops xfer_ops;
 
 	struct dibusb_tuner *tuner;
@@ -196,6 +190,10 @@ struct usb_dibusb {
 	struct input_dev rc_input_dev;
 	struct work_struct rc_query_work;
 	int rc_input_event;
+
+	/* module parameters */
+	int pid_parse;
+	int rc_query_interval;
 };
 
 /* commonly used functions in the separated files */
