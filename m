Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUDRKbi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 06:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbUDRKbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 06:31:38 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:50193 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263429AbUDRKbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 06:31:35 -0400
Date: Sun, 18 Apr 2004 20:31:09 +1000
To: Rolf Kutz <kutz@netcologne.de>, 244207@bugs.debian.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Bug#244207: kernel-source-2.6.5: mwave gives warning on suspend
Message-ID: <20040418103109.GA13756@gondor.apana.org.au>
References: <20040417104311.9C13A1D802@jamaika.kutz.dyndns.org> <20040417113918.GA4846@gondor.apana.org.au> <20040417124850.C14786@flint.arm.linux.org.uk> <20040417122322.GA15052@gondor.apana.org.au> <20040417122954.GA7533@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20040417122954.GA7533@gondor.apana.org.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 17, 2004 at 10:29:54PM +1000, herbert wrote:
> 
> Please scrap that one, it just makes the module unloadable.

This patch resolves the problem of the module getting unloaded before
the device is released by waiting in the module_exit function.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/char/mwave/mwavedd.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/mwave/mwavedd.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 mwavedd.c
--- a/drivers/char/mwave/mwavedd.c	28 Sep 2003 04:44:12 -0000	1.1.1.7
+++ b/drivers/char/mwave/mwavedd.c	18 Apr 2004 10:26:41 -0000
@@ -57,6 +57,7 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/delay.h>
+#include <linux/completion.h>
 #include "smapi.h"
 #include "mwavedd.h"
 #include "3780i.h"
@@ -470,7 +471,17 @@
  * sysfs support <paulsch@us.ibm.com>
  */
 
-struct device mwave_device;
+static DECLARE_COMPLETION(mwave_device_released);
+
+static void mwave_device_release(struct device *dev)
+{
+	complete(&mwave_device_released);
+}
+
+static struct device mwave_device = {
+	.bus_id = "mwave",
+	.release = mwave_device_release,
+};
 
 /* Prevent code redundancy, create a macro for mwave_show_* functions. */
 #define mwave_show_function(attr_name, format_string, field)		\
@@ -518,7 +529,9 @@
 	pDrvData->nr_registered_attrs = 0;
 
 	if (pDrvData->device_registered) {
+		INIT_COMPLETION(mwave_device_released);
 		device_unregister(&mwave_device);
+		wait_for_completion(&mwave_device_released);
 		pDrvData->device_registered = FALSE;
 	}
 
@@ -639,9 +652,6 @@
 	/* uart is registered */
 
 	/* sysfs */
-	memset(&mwave_device, 0, sizeof (struct device));
-	snprintf(mwave_device.bus_id, BUS_ID_SIZE, "mwave");
-
 	if (device_register(&mwave_device))
 		goto cleanup_error;
 	pDrvData->device_registered = TRUE;

--2fHTh5uZTiUOsy+g--
