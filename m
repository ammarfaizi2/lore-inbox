Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276173AbRI1RAt>; Fri, 28 Sep 2001 13:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276172AbRI1RAj>; Fri, 28 Sep 2001 13:00:39 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:61201 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S276170AbRI1RA1>;
	Fri, 28 Sep 2001 13:00:27 -0400
Date: Fri, 28 Sep 2001 09:55:48 -0700
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.9-ac16] usb serial compile error.
Message-ID: <20010928095547.C29329@kroah.com>
In-Reply-To: <20010928115203.F21524@come.alcove-fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20010928115203.F21524@come.alcove-fr>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 28, 2001 at 11:52:03AM +0200, Stelian Pop wrote:
> When compiling a USB serial driver (mct_u232 in my case) 
> without USB generic serial support, the compile process
> stops because of undefined 'vendor' and 'product'
> symbols.
> 
> The attached patch corrects this issue.

Here's a bit nicer patch, which has been sent to Alan.

thanks,

greg k-h

--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-serial-2.4.9-ac16.patch"

diff --minimal -Nru a/drivers/usb/serial/usbserial.c b/drivers/usb/serial/usbserial.c
--- a/drivers/usb/serial/usbserial.c	Fri Sep 28 09:51:10 2001
+++ b/drivers/usb/serial/usbserial.c	Fri Sep 28 09:51:10 2001
@@ -307,7 +307,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.3"
+#define DRIVER_VERSION "v1.4"
 #define DRIVER_AUTHOR "Greg Kroah-Hartman, greg@kroah.com, http://www.kroah.com/linux-usb/"
 #define DRIVER_DESC "USB Serial Driver core"
 
@@ -343,6 +343,13 @@
 	num_ports:		1,
 	shutdown:		generic_shutdown,
 };
+
+#define if_generic_do(x)					\
+	if ((serial->dev->descriptor.idVendor == vendor) &&	\
+	    (serial->dev->descriptor.idProduct == product))	\
+	                x
+#else
+#define if_generic_do(x)
 #endif
 
 
@@ -765,9 +772,7 @@
 		return -ENODEV;
 
 	/* only increment our usage count, if this device is _really_ a generic device */
-	if ((serial->dev->descriptor.idVendor == vendor) &&
-	    (serial->dev->descriptor.idProduct == product))
-		MOD_INC_USE_COUNT;
+	if_generic_do(MOD_INC_USE_COUNT);
 
 	dbg(__FUNCTION__ " - port %d", port->number);
 
@@ -829,9 +834,7 @@
 	up (&port->sem);
 
 	/* only decrement our usage count, if this device is _really_ a generic device */
-	if ((serial->dev->descriptor.idVendor == vendor) &&
-	    (serial->dev->descriptor.idProduct == product))
-		MOD_DEC_USE_COUNT;
+	if_generic_do(MOD_DEC_USE_COUNT);
 }
 
 

--WYTEVAkct0FjGQmd--
