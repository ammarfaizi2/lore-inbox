Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbTCZO02>; Wed, 26 Mar 2003 09:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbTCZO02>; Wed, 26 Mar 2003 09:26:28 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:58974 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261685AbTCZO0X>;
	Wed, 26 Mar 2003 09:26:23 -0500
Message-ID: <3E81BAFF.7060002@mvista.com>
Date: Wed, 26 Mar 2003 08:36:47 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>, Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5 patch] fix ipmi_devintf.c compilation
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com> <20030326124523.GO24744@fs.tum.de>
In-Reply-To: <20030326124523.GO24744@fs.tum.de>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080502080207050804050106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080502080207050804050106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for the quick heads-up.

Linus, I have attached a patch (with some documentation updates and 
another minor fix, too).  Please apply for the next release.

Thanks,

-Corey

Adrian Bunk wrote:

>On Mon, Mar 24, 2003 at 03:26:47PM -0800, Linus Torvalds wrote:
>  
>
>>...
>>Summary of changes from v2.5.65 to v2.5.66
>>============================================
>>...
>>Christoph Hellwig <hch@sgi.com>:
>>...
>>  o misc devfs_register cleanups
>>...
>>    
>>
>
>
>  
>


--------------080502080207050804050106
Content-Type: text/plain;
 name="linux-ipmi-2.5.66-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-ipmi-2.5.66-fix.diff"

diff -urN linux.orig/Documentation/IPMI.txt linux-main/Documentation/IPMI.txt
--- linux.orig/Documentation/IPMI.txt	Tue Jan 14 11:16:08 2003
+++ linux-main/Documentation/IPMI.txt	Wed Mar 26 08:05:10 2003
@@ -5,6 +5,18 @@
 			  <minyard@mvista.com>
 			    <minyard@acm.org>
 
+The Intelligent Platform Management Interface, or IPMI, is a
+standard for controlling intelligent devices that monitor a system.
+It provides for dynamic discovery of sensors in the system and the
+ability to monitor the sensors and be informed when the sensor's
+values change or go outside certain boundaries.  It also has a
+standardized database for field-replacable units (FRUs) and a watchdog
+timer.
+
+To use this, you need an interface to an IPMI controller in your
+system (called a Baseboard Management Controller, or BMC) and
+management software that can use the IPMI system.
+
 This document describes how to use the IPMI driver for Linux.  If you
 are not familiar with IPMI itself, see the web site at
 http://www.intel.com/design/servers/ipmi/index.htm.  IPMI is a big
diff -urN linux.orig/drivers/char/ipmi/Kconfig linux-main/drivers/char/ipmi/Kconfig
--- linux.orig/drivers/char/ipmi/Kconfig	Tue Jan 14 11:16:10 2003
+++ linux-main/drivers/char/ipmi/Kconfig	Wed Mar 26 08:05:10 2003
@@ -7,8 +7,14 @@
        tristate 'IPMI top-level message handler'
        help
          This enables the central IPMI message handler, required for IPMI
-	 to work.  Note that you must have this enabled to do any other IPMI
-	 things.  See IPMI.txt for more details.
+	 to work.
+
+         IPMI is a standard for managing sensors (temperature,
+         voltage, etc.) in a system.
+
+         See Documentation/IPMI.txt for more details on the driver.
+
+	 If unsure, say N.
 
 config IPMI_PANIC_EVENT
        bool 'Generate a panic event to all BMCs on a panic'
diff -urN linux.orig/drivers/char/ipmi/ipmi_devintf.c linux-main/drivers/char/ipmi/ipmi_devintf.c
--- linux.orig/drivers/char/ipmi/ipmi_devintf.c	Wed Mar 26 08:00:57 2003
+++ linux-main/drivers/char/ipmi/ipmi_devintf.c	Wed Mar 26 08:13:31 2003
@@ -449,7 +449,7 @@
 	if (if_num > MAX_DEVICES)
 		return;
 
-	snprinf(name, sizeof(name), "ipmidev/%d", if_num);
+	snprintf(name, sizeof(name), "ipmidev/%d", if_num);
 
 	handles[if_num] = devfs_register(NULL, name, DEVFS_FL_NONE,
 					 ipmi_major, if_num,
diff -urN linux.orig/drivers/char/ipmi/ipmi_kcs_intf.c linux-main/drivers/char/ipmi/ipmi_kcs_intf.c
--- linux.orig/drivers/char/ipmi/ipmi_kcs_intf.c	Fri Feb 28 16:03:18 2003
+++ linux-main/drivers/char/ipmi/ipmi_kcs_intf.c	Wed Mar 26 08:14:11 2003
@@ -826,7 +826,7 @@
 	if (kcs_port && kcs_physaddr)
 		return -EINVAL;
 
-	new_kcs = kmalloc(kcs_size(), GFP_KERNEL);
+	new_kcs = kmalloc(sizeof(*new_kcs), GFP_KERNEL);
 	if (!new_kcs) {
 		printk(KERN_ERR "ipmi_kcs: out of memory\n");
 		return -ENOMEM;

--------------080502080207050804050106--

