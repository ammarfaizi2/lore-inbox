Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277355AbRJELd6>; Fri, 5 Oct 2001 07:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277356AbRJELdt>; Fri, 5 Oct 2001 07:33:49 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:6614 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S277355AbRJELdh>; Fri, 5 Oct 2001 07:33:37 -0400
Message-ID: <3BBD9ABD.6040909@wipro.com>
Date: Fri, 05 Oct 2001 17:04:21 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH]Small Minor optimization to kmem_cache_estimate
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A small minor optimization in kmem_cache_estimate() slab.c

The patch below saves some CPU cycles, especially when the value of size
is small. This is against 2.4.2-2.

--- slab.c.org  Fri Oct  5 16:09:39 2001
+++ slab.c      Fri Oct  5 16:46:34 2001
@@ -386,10 +386,10 @@
                base = sizeof(slab_t);
                extra = sizeof(kmem_bufctl_t);
        }
-       i = 0;
+       i = (wastage - base)/(size + extra);
        while (i*size + L1_CACHE_ALIGN(base+i*extra) <= wastage)
                i++;
-       if (i > 0)
+       while (i*size + L1_CACHE_ALIGN(base+i*extra) > wastage)
                i--;

instead of looping through to get the right value, we make a guess
(mathematically) and move a bit to get the correct value.

Hey, I remember reading the Newton-Raphson method in school.

I verified the number of objects per slab is the same in both cases.
This patch may not improve the performance of your CPU by a great amount,
but when there is a faster way to do things, why live with the slower one.

NOTE: The code hardly does one loop in both the while statements.

Comments,
Balbir



--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
