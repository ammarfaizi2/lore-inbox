Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWGYXXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWGYXXI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWGYXXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:23:07 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:22166 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1030251AbWGYXXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:23:05 -0400
Message-ID: <1153869727.44c6a79ff1b2b@portal.student.luth.se>
Date: Wed, 26 Jul 2006 01:22:07 +0200
From: ricknu-0@student.ltu.se
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Michael Buesch <mb@bu3sch.de>, Paul Jackson <pj@sgi.com>
Subject: Re: [RFC][PATCH] A generic boolean (version 5)
References: <1153341500.44be983ca1407@portal.student.luth.se>
In-Reply-To: <1153341500.44be983ca1407@portal.student.luth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here come another, the fifth "version".

Compiled with .config's allyesconfig and allmodconfig.
Diff'ed (with no errors) with recently pulled Linus git-tree.

Changes:
* moved the bool-defining to include/linux/types.h (thanks Jeff for reminding me)
	not sure if it is well-placed. Please comment if you find it to be more suited
on another line.

Regarding the #define false/true in include/linux/stddef.h: Jeff, I can only
find a reason for it is if a userspace-program is including both
<linux/stddef.h> and <stdbool.h>. But since it uses only #define's, why should
we make the cpp care about it?
I does not really care if it's in or not, just since cpia2.h is fixed, there
seems to be no use for it (other then userspace programs).

Have a nice night
/Richard Knutsson

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 drivers/block/DAC960.h            |    2 +-
 drivers/media/video/cpia2/cpia2.h |    4 ----
 drivers/net/dgrs.c                |    1 -
 drivers/scsi/BusLogic.h           |    5 +----
 include/linux/stddef.h            |   11 +++++++++++
 include/linux/types.h             |    2 ++
 6 files changed, 15 insertions(+), 10 deletions(-)


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
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index b3a2cad..e3ad881 100644
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
diff --git a/include/linux/types.h b/include/linux/types.h
index 3f23566..85cf587 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -90,6 +90,8 @@ #define _CADDR_T
 typedef __kernel_caddr_t	caddr_t;
 #endif
 
+typedef _Bool			bool;
+
 /* bsd */
 typedef unsigned char		u_char;
 typedef unsigned short		u_short;

