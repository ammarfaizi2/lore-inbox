Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUDQMXr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 08:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263970AbUDQMXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 08:23:47 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:24074 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262634AbUDQMXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 08:23:44 -0400
Date: Sat, 17 Apr 2004 22:23:22 +1000
To: Rolf Kutz <kutz@netcologne.de>, 244207@bugs.debian.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Bug#244207: kernel-source-2.6.5: mwave gives warning on suspend
Message-ID: <20040417122322.GA15052@gondor.apana.org.au>
References: <20040417104311.9C13A1D802@jamaika.kutz.dyndns.org> <20040417113918.GA4846@gondor.apana.org.au> <20040417124850.C14786@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20040417124850.C14786@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 17, 2004 at 12:48:50PM +0100, Russell King wrote:
> 
> And that's all it does.  It doesn't stop the oops which potentically can
> happen when the struct device is freed (by the module being unloaded)
> while there is still a reference to the struct device.

You're quite right.  Even worse, there was an memset in the init
function which set the release function back to NULL :)

This patch should be better.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/char/mwave/mwavedd.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/mwave/mwavedd.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 mwavedd.c
--- a/drivers/char/mwave/mwavedd.c	28 Sep 2003 04:44:12 -0000	1.1.1.7
+++ b/drivers/char/mwave/mwavedd.c	17 Apr 2004 12:20:07 -0000
@@ -470,7 +470,18 @@
  * sysfs support <paulsch@us.ibm.com>
  */
 
-struct device mwave_device;
+static void mwave_device_release(struct device *dev)
+{
+	pMWAVE_DEVICE_DATA pDrvData = &mwave_s_mdd;
+
+	if (pDrvData->device_registered)
+		module_put(THIS_MODULE);
+}
+
+static struct device mwave_device = {
+	.bus_id = "mwave",
+	.release = mwave_device_release,
+};
 
 /* Prevent code redundancy, create a macro for mwave_show_* functions. */
 #define mwave_show_function(attr_name, format_string, field)		\
@@ -639,11 +650,9 @@
 	/* uart is registered */
 
 	/* sysfs */
-	memset(&mwave_device, 0, sizeof (struct device));
-	snprintf(mwave_device.bus_id, BUS_ID_SIZE, "mwave");
-
 	if (device_register(&mwave_device))
 		goto cleanup_error;
+	__module_get(THIS_MODULE);
 	pDrvData->device_registered = TRUE;
 	for (i = 0; i < ARRAY_SIZE(mwave_dev_attrs); i++) {
 		if(device_create_file(&mwave_device, mwave_dev_attrs[i])) {

--dDRMvlgZJXvWKvBx--
