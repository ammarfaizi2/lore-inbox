Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264114AbUKZUZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbUKZUZg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264112AbUKZUZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:25:15 -0500
Received: from 80-218-63-145.dclient.hispeed.ch ([80.218.63.145]:15878 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S264047AbUKZUKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:10:23 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] touchkitusb: module_param to swap axes
Date: Thu, 25 Nov 2004 21:18:17 +0100
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>
References: <200411242228.53446.daniel.ritz@gmx.ch> <200411250010.09049.dtor_core@ameritech.net>
In-Reply-To: <200411250010.09049.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411252118.17690.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 November 2004 06:10, Dmitry Torokhov wrote:
> On Wednesday 24 November 2004 04:28 pm, Daniel Ritz wrote:
> > add a module parameter to swap the axes. many displays need this...
> > 
> > --- 1.2/drivers/usb/input/touchkitusb.c	2004-09-18 10:07:25 +02:00
> > +++ edited/drivers/usb/input/touchkitusb.c	2004-11-24 18:57:59 +01:00
> > @@ -59,6 +59,10 @@
> >  #define DRIVER_AUTHOR			"Daniel Ritz <daniel.ritz@gmx.ch>"
> >  #define DRIVER_DESC			"eGalax TouchKit USB HID Touchscreen Driver"
> >  
> > +static int swap_xy;
> > +module_param(swap_xy, bool, 0);
> 
> It looks it can easily be exported to userspace to allow switching "on-fly"
> since it is checked for every packet. I think 0600 will do.
>  

agreed. and when 0600 is ok, i guess 0644 is ok too.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

--- 1.2/drivers/usb/input/touchkitusb.c	2004-09-18 10:07:25 +02:00
+++ edited/drivers/usb/input/touchkitusb.c	2004-11-24 18:57:59 +01:00
@@ -59,6 +59,10 @@
 #define DRIVER_AUTHOR			"Daniel Ritz <daniel.ritz@gmx.ch>"
 #define DRIVER_DESC			"eGalax TouchKit USB HID Touchscreen Driver"
 
+static int swap_xy;
+module_param(swap_xy, bool, 0644);
+MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
+
 struct touchkit_usb {
 	unsigned char *data;
 	dma_addr_t data_dma;
@@ -80,6 +84,7 @@
 {
 	struct touchkit_usb *touchkit = urb->context;
 	int retval;
+	int x, y;
 
 	switch (urb->status) {
 	case 0:
@@ -103,13 +108,19 @@
 		goto exit;
 	}
 
+	if (swap_xy) {
+		y = TOUCHKIT_GET_X(touchkit->data);
+		x = TOUCHKIT_GET_Y(touchkit->data);
+	} else {
+		x = TOUCHKIT_GET_X(touchkit->data);
+		y = TOUCHKIT_GET_Y(touchkit->data);
+	}
+
 	input_regs(&touchkit->input, regs);
 	input_report_key(&touchkit->input, BTN_TOUCH,
 	                 TOUCHKIT_GET_TOUCHED(touchkit->data));
-	input_report_abs(&touchkit->input, ABS_X,
-	                 TOUCHKIT_GET_X(touchkit->data));
-	input_report_abs(&touchkit->input, ABS_Y,
-	                 TOUCHKIT_GET_Y(touchkit->data));
+	input_report_abs(&touchkit->input, ABS_X, x);
+	input_report_abs(&touchkit->input, ABS_Y, y);
 	input_sync(&touchkit->input);
 
 exit:

