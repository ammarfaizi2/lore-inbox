Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWABSz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWABSz0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWABSz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:55:26 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:5833 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750954AbWABSzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:55:25 -0500
Date: Mon, 2 Jan 2006 19:55:25 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix compilation error in SDLA drive
Message-ID: <Pine.LNX.4.61.0601021954260.29938@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,



from the other thread about Arjan's inline...

"There are also some issues in drivers/net/wan/sdla_*.c that I had to
fix before make was able to link to .tmp_vmlinux1.bin." A compile-fix is
attached, and should be merged.

~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
Patch #1: Fix missing symbol error during linking stage.

Desc: isdigit() is a macro, but because someone forgot to include
<ctype.h>, it was thought to be a function (according to C rules).
Un-static'ize sdla_intack() because it is used across two files.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff -dpru rc7-Os/include/linux/sdladrv.h rc7-std/include/linux/sdladrv.h
--- rc7-Os/include/linux/sdladrv.h	2005-12-25 00:47:48.000000000 +0100
+++ rc7-std/include/linux/sdladrv.h	2006-01-02 15:32:12.000000000 +0100
@@ -60,6 +60,7 @@ extern int sdla_peek	(sdlahw_t* hw, unsi
 extern int sdla_poke	(sdlahw_t* hw, unsigned long addr, void* buf,
 			 unsigned len);
 extern int sdla_exec	(void* opflag);
+extern int sdla_intack	(sdlahw_t *hw);
 
 extern unsigned wanpipe_hw_probe(void);
 
diff -dpru rc7-Os/drivers/net/wan/sdla_fr.c rc7-std/drivers/net/wan/sdla_fr.c
--- rc7-Os/drivers/net/wan/sdla_fr.c	2005-12-25 00:47:48.000000000 +0100
+++ rc7-std/drivers/net/wan/sdla_fr.c	2006-01-02 15:29:15.000000000 +0100
@@ -170,6 +170,7 @@
 #include <net/route.h>          	/* Dynamic Route Creation */
 #include <linux/etherdevice.h>		/* eth_type_trans() used for bridging */
 #include <linux/random.h>
+#include <linux/ctype.h>
 
 /****** Defines & Macros ****************************************************/
 
diff -dpru rc7-Os/drivers/net/wan/sdladrv.c rc7-std/drivers/net/wan/sdladrv.c
--- rc7-Os/drivers/net/wan/sdladrv.c	2005-12-25 00:47:48.000000000 +0100
+++ rc7-std/drivers/net/wan/sdladrv.c	2006-01-02 15:29:58.000000000 +0100
@@ -751,7 +751,7 @@ int sdla_intde (sdlahw_t* hw)
  * Acknowledge SDLA hardware interrupt.
  */
 
-static int sdla_intack (sdlahw_t* hw)
+int sdla_intack (sdlahw_t* hw)
 {
 	unsigned port = hw->port;
 	int tmp;
diff -dpru rc7-Os/drivers/net/wan/sdlamain.c rc7-std/drivers/net/wan/sdlamain.c
--- rc7-Os/drivers/net/wan/sdlamain.c	2005-12-25 00:47:48.000000000 +0100
+++ rc7-std/drivers/net/wan/sdlamain.c	2006-01-02 15:32:30.000000000 +0100
@@ -70,6 +70,7 @@
 
 #include <linux/ip.h>
 #include <net/route.h>
+#include <linux/sdladrv.h>
  
 #define KMEM_SAFETYZONE 8
 
#<<eof>>


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
