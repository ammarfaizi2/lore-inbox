Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135204AbRDRPWD>; Wed, 18 Apr 2001 11:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135206AbRDRPVm>; Wed, 18 Apr 2001 11:21:42 -0400
Received: from [207.35.116.203] ([207.35.116.203]:50693 "EHLO
	mail.colubris.com") by vger.kernel.org with ESMTP
	id <S135204AbRDRPVg>; Wed, 18 Apr 2001 11:21:36 -0400
Message-ID: <3ADDB0D1.826456E2@colubris.com>
Date: Wed, 18 Apr 2001 11:20:49 -0400
From: Martin Gadbois <martin.gadbois@colubris.com>
Organization: Colubris Networks
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.15-4mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ddavem@redhat.com
CC: ak@muc.de, kuznet@ms2.inr.ac.ru
Subject: [PATCH] IP forwarded checksum, kernel 2.2.18-19
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!
I realized that some tests were failing due to dropped IP packets. I
traced and discovered the following:

--------Begin patch
# This caused some "holes" in forwarded transfers, that is checksum was
bad
# on some occasions -MG
diff -ur original/include/net/ip.h mpc8xx-2.2.18/include/net/ip.h
--- original/include/net/ip.h   Tue Apr 17 09:36:28 2001
+++ linux-2.2.18/include/net/ip.h      Tue Apr 17 16:30:16 2001
@@ -170,7 +170,7 @@
 extern __inline__
 int ip_decrease_ttl(struct iphdr *iph)
 {
-       u16 check = iph->check;
+       u32 check = iph->check;
        check += __constant_htons(0x0100);
        iph->check = check + (check>=0xFFFF);
        return --iph->ttl;
------------End patch

The expression check>=0xFFFF could only be true(1) when (u16)check ==
0xFFFF, not what is it meant to be.
This is fixed exactly like this patch in 2.4.x.
Kernel 2.2.19 also has the same problems.

Thanks,

--
Martin Gadbois
S/W designer
Colubris Networks (http://www.colubris.com)



