Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315326AbSEAHOj>; Wed, 1 May 2002 03:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315327AbSEAHOi>; Wed, 1 May 2002 03:14:38 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:5641 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315326AbSEAHOh>; Wed, 1 May 2002 03:14:37 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] TRIVIAL 2.5.12 declance patch
Date: Wed, 01 May 2002 17:17:57 +1000
Message-Id: <E172oNB-0007oN-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>: [patch] 2.4.19-pre7: A few declance multicast updates:
  Hello,
  
   It seems all Ethernet device drivers were bulk-converted to use the new
  common CRC functions.  I discovered declance used incorrect endianness to
  calculate the sum for its multicast filter and had a few alignment
  problems there.  I fixed these bugs in the MIPS/Linux CVS tree which is at
  2.4.18 now.  Here is the respective update for the official kernel. 
  
   The bugs make the filter non-functional.  Please apply. 
  
    Maciej
  

--- trivial-2.5.12/drivers/net/declance.c.orig	Wed May  1 17:15:09 2002
+++ trivial-2.5.12/drivers/net/declance.c	Wed May  1 17:15:09 2002
@@ -791,6 +791,8 @@
 	ib->mode = 0;
 	ib->filter [0] = 0;
 	ib->filter [2] = 0;
+	ib->filter [4] = 0;
+	ib->filter [6] = 0;
 
 	lance_init_ring(dev);
 	load_csrs(lp);
@@ -943,9 +945,9 @@
 		if (!(*addrs & 1))
 			continue;
 
-		crc = ether_crc(6, addrs);
+		crc = ether_crc_le(6, addrs);
 		crc = crc >> 26;
-		mcast_table[crc >> 3] |= 1 << (crc & 0xf);
+		mcast_table[2 * (crc >> 4)] |= 1 << (crc & 0xf);
 	}
 	return;
 }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
