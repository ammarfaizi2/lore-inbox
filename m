Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbTEGKBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 06:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTEGKBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 06:01:52 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:54941 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP id S263048AbTEGKBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 06:01:51 -0400
Date: Wed, 07 May 2003 03:12:56 -0700
From: Mark McClelland <mark@alpha.dyndns.org>
Subject: Re: [patch] i2c #3/3: add class field to i2c_adapter
In-reply-to: <20030506195154.GC865@bytesex.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       Frank Davis <fdavis@si.rr.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Ronald Bultje <R.S.Bultje@pharm.uu.nl>
Message-id: <3EB8DC28.8040206@alpha.dyndns.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_eu+4BcNUcwUMd4S4vIfPyw)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
References: <20030506193430.GA865@bytesex.org>
 <20030506194018.GB865@bytesex.org> <20030506195154.GC865@bytesex.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_eu+4BcNUcwUMd4S4vIfPyw)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Gerd Knorr wrote:

>This is the last of three patches for i2c.  It introduces a new field
>to i2c_adapter which classifies the kind of hardware a i2c adapter
>belongs to (analog tv card / dvb card / smbus / gfx card ...).
>

I've attached a patch that adds classes for analog and digital cameras 
(webcams, etc...). I plan to submit one such driver in the next few days.

The patch also fixes a typo ("DIGINAL").

>i2c chip
>drivers can use this infomation to decide whenever they want to look for
>hardware on that adapter or not.  It doesn't make sense to probe for a
>tv tuner on a smbus for example ...
>

Actually it does in some cases. I know of two devices that have analog 
tuners on an smbus-like interface (OV511 USB TV and W9967CF USB TV). The 
tuner can be controlled using a pair of i2c_smbus_write_byte_data() 
calls. This works because, AFAIK, all four-byte tuners can differentiate 
between bytes 0-1 and 2-3 due to their bit patterns.

Would a patch that adds smbus algorithm support to tuner.c be 
acceptable? It will only add about twelve lines, and will still use 
i2c_master_send() when possible.

-- 
Mark McClelland
mark@alpha.dyndns.org


--Boundary_(ID_eu+4BcNUcwUMd4S4vIfPyw)
Content-type: text/plain; name=i2c_adap_class_cam-2.5.69.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=i2c_adap_class_cam-2.5.69.patch


Add I2C classes for analog and digital cameras, and fix a typo.

diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Wed May  7 01:29:59 2003
+++ b/include/linux/i2c.h	Wed May  7 01:29:59 2003
@@ -280,10 +280,12 @@
 						/* Must equal I2C_M_TEN below */
 
 /* i2c adapter classes (bitmask) */
-#define I2C_ADAP_CLASS_SMBUS      (1<<0)        /* lm_sensors, ... */
-#define I2C_ADAP_CLASS_TV_ANALOG  (1<<1)        /* bttv + friends */
-#define I2C_ADAP_CLASS_TV_DIGINAL (1<<2)        /* dbv cards */
-#define I2C_ADAP_CLASS_DDC        (1<<3)        /* i2c-matroxfb ? */
+#define I2C_ADAP_CLASS_SMBUS        (1<<0)      /* lm_sensors, ... */
+#define I2C_ADAP_CLASS_TV_ANALOG    (1<<1)      /* bttv + friends */
+#define I2C_ADAP_CLASS_TV_DIGITAL   (1<<2)      /* dbv cards */
+#define I2C_ADAP_CLASS_DDC          (1<<3)      /* i2c-matroxfb ? */
+#define I2C_ADAP_CLASS_CAM_ANALOG   (1<<4)      /* camera with analog CCD */
+#define I2C_ADAP_CLASS_CAM_DIGITAL  (1<<5)      /* most webcams */
 
 /* i2c_client_address_data is the struct for holding default client
  * addresses for a driver and for the parameters supplied on the


--Boundary_(ID_eu+4BcNUcwUMd4S4vIfPyw)--
