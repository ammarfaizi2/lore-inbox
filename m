Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUGaUnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUGaUnT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 16:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUGaUnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 16:43:18 -0400
Received: from mail.dif.dk ([193.138.115.101]:2206 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262114AbUGaUnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 16:43:09 -0400
Date: Sat, 31 Jul 2004 22:47:40 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Maydell <pmaydell@chiark.greenend.org.uk>,
       Phil Blundell <philb@gnu.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix up return value from dio_find() (fixing a FIXME)
Message-ID: <Pine.LNX.4.60.0407312132490.2660@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch to fix up this FIXME in drivers/dio/dio.c:dio_find() :

* Aargh: we use 0 for an error return code, but select code 0 exists!
* FIXME (trivial, use -1, but requires changes to all the drivers :-< )
*/

I've changed the return value to -1 as suggested by the comment, and then 
went looking for the drivers that needed to be changed (as the comment 
mentions). I only found two users of dio_find() and I've fixed those up to 
not treat 0 as an error, but only values <0.
The FIXME implies (to me at least) that there are many drivers that would 
need to be changed, but I could only find two - did I miss anything?
Also, I don't have the hardware to test the drivers I've changed, so I've 
done compile testing only - could someone please review my changes and 
confirm if they are correct?

Patch is against 2.6.8-rc2-mm1

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


diff -urp linux-2.6.8-rc2-mm1-orig/drivers/dio/dio.c linux-2.6.8-rc2-mm1/drivers/dio/dio.c
--- linux-2.6.8-rc2-mm1-orig/drivers/dio/dio.c	2004-06-16 07:19:43.000000000 +0200
+++ linux-2.6.8-rc2-mm1/drivers/dio/dio.c	2004-07-31 19:12:26.000000000 +0200
@@ -148,9 +148,6 @@ static int __init dio_find_slow(int devi
  	return 0;
  }

-/* Aargh: we use 0 for an error return code, but select code 0 exists!
- * FIXME (trivial, use -1, but requires changes to all the drivers :-< )
- */
  int dio_find(int deviceid)
  {
  	if (blist) 
@@ -160,7 +157,7 @@ int dio_find(int deviceid)
  		for (b = blist; b; b = b->next)
  			if (b->id == deviceid && b->configured == 0)
  				return b->scode;
-		return 0;
+		return -1;
  	}
  	return dio_find_slow(deviceid);
  }
diff -urp linux-2.6.8-rc2-mm1-orig/drivers/net/hplance.c linux-2.6.8-rc2-mm1/drivers/net/hplance.c
--- linux-2.6.8-rc2-mm1-orig/drivers/net/hplance.c	2004-06-16 07:19:22.000000000 +0200
+++ linux-2.6.8-rc2-mm1/drivers/net/hplance.c	2004-07-31 19:10:12.000000000 +0200
@@ -91,7 +91,7 @@ struct net_device * __init hplance_probe
          {
                  int scode = dio_find(DIO_ID_LAN);

-                if (!scode)
+                if (scode < 0)
                          break;

  		dio_config_board(scode);
diff -urp linux-2.6.8-rc2-mm1-orig/drivers/video/hpfb.c linux-2.6.8-rc2-mm1/drivers/video/hpfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/hpfb.c	2004-06-16 07:19:26.000000000 +0200
+++ linux-2.6.8-rc2-mm1/drivers/video/hpfb.c	2004-07-31 13:59:47.000000000 +0200
@@ -197,7 +197,7 @@ int __init hpfb_init(void)
  	} else {
  		int sc = dio_find(DIO_ID_FBUFFER);

-		if (sc) {
+		if (sc >= 0) {
  			unsigned long addr = (unsigned long)dio_scodetoviraddr(sc);
  			unsigned int sid = DIO_SECID(addr);




--
Jesper Juhl <juhl-lkml@dif.dk>

