Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317783AbSGKH0H>; Thu, 11 Jul 2002 03:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317785AbSGKH0G>; Thu, 11 Jul 2002 03:26:06 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:40959 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317783AbSGKH0E>; Thu, 11 Jul 2002 03:26:04 -0400
Message-ID: <3D2D3398.1030206@us.ibm.com>
Date: Thu, 11 Jul 2002 00:28:24 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] HPFS fix return without releasing BKL
Content-Type: multipart/mixed;
 boundary="------------060606010003060606000907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060606010003060606000907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
This was found by Dan Carpenter <error27@email.com>, using an smatch 
script.  Looks to me like like an error caused during all the BKL 
pushing.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------060606010003060606000907
Content-Type: text/plain;
 name="hpfs-bkl_ret-2.5.25-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hpfs-bkl_ret-2.5.25-0.patch"

--- linux-2.5.25-clean/fs/hpfs/dir.c	Thu Jun 20 15:53:48 2002
+++ linux/fs/hpfs/dir.c	Thu Jul 11 00:16:55 2002
@@ -211,7 +211,10 @@
 
 	lock_kernel();
 	if ((err = hpfs_chk_name((char *)name, &len))) {
-		if (err == -ENAMETOOLONG) return ERR_PTR(-ENAMETOOLONG);
+		if (err == -ENAMETOOLONG) {
+			unlock_kernel();
+			return ERR_PTR(-ENAMETOOLONG);
+		}
 		goto end_add;
 	}
 

--------------060606010003060606000907--

