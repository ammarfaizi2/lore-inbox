Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbREPTtt>; Wed, 16 May 2001 15:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261997AbREPTtj>; Wed, 16 May 2001 15:49:39 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:33481 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261317AbREPTtc>; Wed, 16 May 2001 15:49:32 -0400
From: Ulrich.Weigand@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org
Message-ID: <C1256A4E.006CDEF5.00@d12mta11.de.ibm.com>
Date: Wed, 16 May 2001 21:49:03 +0200
Subject: IP checksum broken in 2.2 .18 ip_decrease_ttl
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Alan,

the fast IP checksum update in ip_decrease_ttl appears
to be broken (at least on big endian machines) since 2.2.18.

Even on little endian machines IMO the overflow is incorrect
in two cases:

  0xfeff goes to 0x0000 instead of 0xffff
  0xffff goes to 0x0000 instead of 0x0100

On big endian machines, the overflow from the high byte
is never carried over correctly:

  0xfeff goes to 0x0000 instead of 0xffff
  0xff00 goes to 0x0000 instead of 0x0001
  0xff01 goes to 0x0001 instead of 0x0002
  ...
  0xffff goes to 0x00ff instead of 0x0100


The following patch reverts the ip_decrease_ttl routine
to the pre-2.2.18 level, which might be less efficient,
but should at least be correct ...

diff -urN linux-2.2.19/include/net/ip.h linux-2.2.19-s390/include/net/ip.h
--- linux-2.2.19/include/net/ip.h  Sun Mar 25 18:37:40 2001
+++ linux-2.2.19-s390/include/net/ip.h   Wed May 16 14:51:03 2001
@@ -171,8 +171,10 @@
 int ip_decrease_ttl(struct iphdr *iph)
 {
     u16 check = iph->check;
-    check += __constant_htons(0x0100);
-    iph->check = check + ((check>=0xFFFF) ? 1 : 0);
+    check = ntohs(check) + 0x0100;
+    if ((check & 0xFF00) == 0)
+         check++;                /* carry overflow */
+    iph->check = htons(check);
     return --iph->ttl;
 }



Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com


