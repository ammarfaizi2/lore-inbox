Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279591AbRKFO5R>; Tue, 6 Nov 2001 09:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279589AbRKFO5I>; Tue, 6 Nov 2001 09:57:08 -0500
Received: from t2.redhat.com ([199.183.24.243]:35829 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S279591AbRKFO4t>; Tue, 6 Nov 2001 09:56:49 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1005024157.1506.2.camel@phantasy> 
In-Reply-To: <1005024157.1506.2.camel@phantasy>  <17526.1005022179@ocs3.intra.ocs.com.au> 
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 errors on full build - Y 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Nov 2001 14:56:31 +0000
Message-ID: <26659.1005058591@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rml@tech9.net said:
>  Another simple fix...the multiple function declarations should be
> static.  Even better, a lot of the duplication between the driver
> should be shared but that I shall leave as an exercises for the
> maintainer.  Until then, Linus, please apply. 

jedec.c is obsolete and will be going away just as soon as I'm sufficiently 
convinced that jedec_probe.c and the unified flash driver backends are 
actually working for all the hardware in question. You should never need to 
have them both turned on at once. 

Here's the fix, though, which also makes some other stuff static which 
doesn't need to be exported.

Index: include/linux/mtd/jedec.h
===================================================================
RCS file: /home/cvs/mtd/include/linux/mtd/jedec.h,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- include/linux/mtd/jedec.h	2000/07/04 07:21:51	1.1
+++ include/linux/mtd/jedec.h	2001/11/06 14:37:36	1.2
@@ -7,7 +7,7 @@
  *
  * See the AMD flash databook for information on how to operate the interface.
  *
- * $Id: jedec.h,v 1.1 2000/07/04 07:21:51 jgg Exp $
+ * $Id: jedec.h,v 1.2 2001/11/06 14:37:36 dwmw2 Exp $
  */
 
 #ifndef __LINUX_MTD_JEDEC_H__
@@ -63,7 +63,5 @@
    
    struct jedec_flash_chip chips[MAX_JEDEC_CHIPS];  
 };
-
-extern const struct JEDECTable *jedec_idtoinf(__u8 mfr,__u8 id);
 
 #endif
Index: drivers/mtd/chips/jedec.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/chips/jedec.c,v
retrieving revision 1.11
retrieving revision 1.12
diff -u -r1.11 -r1.12
--- drivers/mtd/chips/jedec.c	2001/10/02 15:05:12	1.11
+++ drivers/mtd/chips/jedec.c	2001/11/06 14:37:35	1.12
@@ -11,7 +11,7 @@
  * not going to guess how to send commands to them, plus I expect they will
  * all speak CFI..
  *
- * $Id: jedec.c,v 1.11 2001/10/02 15:05:12 dwmw2 Exp $
+ * $Id: jedec.c,v 1.12 2001/11/06 14:37:35 dwmw2 Exp $
  */
 
 #include <linux/mtd/jedec.h>
@@ -42,6 +42,7 @@
    {0xC2AD,"Macronix MX29F016",2*1024*1024,64*1024,MTD_CAP_NORFLASH},
    {}};
 
+static const struct JEDECTable *jedec_idtoinf(__u8 mfr,__u8 id);
 static void jedec_sync(struct mtd_info *mtd) {};
 static int jedec_read(struct mtd_info *mtd, loff_t from, size_t len, 
 		      size_t *retlen, u_char *buf);
@@ -249,7 +250,7 @@
 /* Take an array of JEDEC numbers that represent interleved flash chips
    and process them. Check to make sure they are good JEDEC numbers, look
    them up and then add them to the chip list */   
-int handle_jedecs(struct map_info *map,__u8 *Mfg,__u8 *Id,unsigned Count,
+static int handle_jedecs(struct map_info *map,__u8 *Mfg,__u8 *Id,unsigned Count,
 		  unsigned long base,struct jedec_private *priv)
 {
    unsigned I,J;
@@ -336,7 +337,7 @@
 }
 
 /* Lookup the chip information from the JEDEC ID table. */
-const struct JEDECTable *jedec_idtoinf(__u8 mfr,__u8 id)
+static const struct JEDECTable *jedec_idtoinf(__u8 mfr,__u8 id)
 {
    __u16 Id = (mfr << 8) | id;
    unsigned long I = 0;
@@ -873,19 +874,19 @@
    }
 }
 
-int __init jedec_probe_init(void)
+int __init jedec_init(void)
 {
 	register_mtd_chip_driver(&jedec_chipdrv);
 	return 0;
 }
 
-static void __exit jedec_probe_exit(void)
+static void __exit jedec_exit(void)
 {
 	unregister_mtd_chip_driver(&jedec_chipdrv);
 }
 
-module_init(jedec_probe_init);
-module_exit(jedec_probe_exit);
+module_init(jedec_init);
+module_exit(jedec_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jason Gunthorpe <jgg@deltatee.com> et al.");


--
dwmw2


