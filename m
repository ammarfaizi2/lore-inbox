Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWHWLHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWHWLHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWHWLHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:07:34 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:52356 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S964877AbWHWLHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:07:33 -0400
Message-ID: <44EC3878.9070300@student.ltu.se>
Date: Wed, 23 Aug 2006 13:14:00 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Prajakta Gudadhe <pgudadhe@nvidia.com>, jeff@garzik.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc4-mm2] Generic boolean (was: Re: Generic booleans
 in -mm)
References: <1156209426.2840.15.camel@dhcp-172-16-174-114.nvidia.com>	<20060821224457.65de5111.akpm@osdl.org>	<44EB8B2A.8030603@student.ltu.se> <20060822161706.bad04598.akpm@osdl.org>
In-Reply-To: <20060822161706.bad04598.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

This patch defines:
* a generic boolean-type, named 'bool'
* aliases to 0 and 1, named 'false' and 'true'

Removing colliding definitions of 'bool', 'false' and 'true'.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

Patched applied cleanly and compile-tested (also run-tested on .18-rc3)

The boolean is named "bool", this because calling it "boolean" seems long (see: int
and integer) and not "BOOL", because it is a typedef and not a #define.


There has been some who do not want the true and false, but since it is just a
value and not bundled with the boolean type, it is up to the programmer which to
use. Also a quick check:

find . -name *.[chS] | xargs grep "define FALSE" | grep -v "FALSE_" | wc -l
55

tells us there seems to be some who like false (and true) (+ there is a need for a common
definition, as Andrew attempted).



There has been concern about adding other values then 0 and 1. There has been ideas to do something like:
bool b = i & 1 : 0;
/*or*/
bool b = !!i;

but all that is needed is just a casting:

bool b = (bool) i;

which in my opinion is just normal. We do it, after all, every time we want to add a (potentially) larger value in a too small type.


 drivers/block/DAC960.h            |    2 +-
 drivers/media/video/cpia2/cpia2.h |    4 ----
 drivers/net/dgrs.c                |    1 -
 drivers/scsi/BusLogic.h           |    5 +----
 include/linux/stddef.h            |    5 +++++
 include/linux/types.h             |    2 ++
 6 files changed, 9 insertions(+), 10 deletions(-)


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
index b3a2cad..0382065 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -10,6 +10,11 @@ #else
 #define NULL ((void *)0)
 #endif
 
+enum {
+	false	= 0,
+	true	= 1
+};
+
 #undef offsetof
 #ifdef __compiler_offsetof
 #define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)
diff --git a/include/linux/types.h b/include/linux/types.h
index 3f23566..406d4ae 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -33,6 +33,8 @@ typedef __kernel_clockid_t	clockid_t;
 typedef __kernel_mqd_t		mqd_t;
 
 #ifdef __KERNEL__
+typedef _Bool			bool;
+
 typedef __kernel_uid32_t	uid_t;
 typedef __kernel_gid32_t	gid_t;
 typedef __kernel_uid16_t        uid16_t;


