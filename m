Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWGUX1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWGUX1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 19:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWGUX1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 19:27:35 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:55941 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750812AbWGUX1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 19:27:34 -0400
Message-ID: <1153524422.44c162c65c21b@portal.student.luth.se>
Date: Sat, 22 Jul 2006 01:27:02 +0200
From: ricknu-0@student.ltu.se
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC][PATCH] A generic boolean (version 3)
References: <1153341500.44be983ca1407@portal.student.luth.se>
In-Reply-To: <1153341500.44be983ca1407@portal.student.luth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry about the dummy-mail I just sent. Pressed send by accident.)

Here is the next "version".

Changes since version 2:
* removed __u1 and u1, not really usable and error-prone.
* removed #ifdef __GNUC__ when defining bool.
* changed back the version-checking when defining bool, this since I'm quite
sure Linux 2.4 and 2.6 share (if not all, then large part of) the drivers. And
2.4 is still compiled with the 2.95 Gcc.
* changed to Jeff's version when defining "false" and "true".

Thanks for all the comments and suggestion.
/Richard Knutsson

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 drivers/block/DAC960.h            |    2 +-
 drivers/media/video/cpia2/cpia2.h |    4 ----
 drivers/net/dgrs.c                |    1 -
 drivers/scsi/BusLogic.h           |    5 +----
 include/asm-i386/types.h          |    7 +++++++
 include/linux/stddef.h            |   11 +++++++++++
 6 files changed, 20 insertions(+), 10 deletions(-)


diff --git a/drivers/block/DAC960.h b/drivers/block/DAC960.h
index a82f37f..f9217c3 100644
--- a/drivers/block/DAC960.h
+++ b/drivers/block/DAC960.h
@@ -71,7 +71,7 @@ #define DAC690_V2_PciDmaMask	0xfffffffff
   Define a Boolean data type.
 */
 
-typedef enum { false, true } __attribute__ ((packed)) boolean;
+typedef bool boolean;
 
 
 /*
diff --git a/drivers/media/video/cpia2/cpia2.h b/drivers/media/video/cpia2/cpia2.h
index c5ecb2b..8d2dfc1 100644
--- a/drivers/media/video/cpia2/cpia2.h
+++ b/drivers/media/video/cpia2/cpia2.h
@@ -50,10 +50,6 @@ #define CPIA2_PATCH_VER	0
 /***
  * Image defines
  ***/
-#ifndef true
-#define true 1
-#define false 0
-#endif
 
 /*  Misc constants */
 #define ALLOW_CORRUPT 0		/* Causes collater to discard checksum */
diff --git a/drivers/net/dgrs.c b/drivers/net/dgrs.c
index fa4f094..4dbc23d 100644
--- a/drivers/net/dgrs.c
+++ b/drivers/net/dgrs.c
@@ -110,7 +110,6 @@ static char version[] __initdata =
  *	DGRS include files
  */
 typedef unsigned char uchar;
-typedef unsigned int bool;
 #define vol volatile
 
 #include "dgrs.h"
diff --git a/drivers/scsi/BusLogic.h b/drivers/scsi/BusLogic.h
index 9792e5a..d6d1d56 100644
--- a/drivers/scsi/BusLogic.h
+++ b/drivers/scsi/BusLogic.h
@@ -237,10 +237,7 @@ enum BusLogic_BIOS_DiskGeometryTranslati
   Define a Boolean data type.
 */
 
-typedef enum {
-	false,
-	true
-} PACKED boolean;
+typedef bool boolean;
 
 /*
   Define a 10^18 Statistics Byte Counter data type.
diff --git a/include/asm-i386/types.h b/include/asm-i386/types.h
index 4b4b295..f035a15 100644
--- a/include/asm-i386/types.h
+++ b/include/asm-i386/types.h
@@ -1,6 +1,13 @@
 #ifndef _I386_TYPES_H
 #define _I386_TYPES_H
 
+#if __GNUC__ >= 3
+typedef _Bool bool;
+#else
+#warning You compiler doesn't seem to support boolean types, will set 'bool' as
an 'unsigned int'
+typedef unsigned int bool;
+#endif
+
 #ifndef __ASSEMBLY__
 
 typedef unsigned short umode_t;
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index b3a2cad..f137815 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -10,6 +10,17 @@ #else
 #define NULL ((void *)0)
 #endif
 
+#undef false
+#undef true
+
+enum {
+	false	= 0,
+	true	= 1
+};
+
+#define false false
+#define true true 
+
 #undef offsetof
 #ifdef __compiler_offsetof
 #define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)

