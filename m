Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbTFWX3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263949AbTFWX3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:29:23 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:14839 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262445AbTFWX3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:29:18 -0400
Message-ID: <3EF78EEE.4020706@us.ibm.com>
Date: Mon, 23 Jun 2003 16:36:14 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [patch] fix types for generic_hweight64
Content-Type: multipart/mixed;
 boundary="------------030100000504050001000606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030100000504050001000606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A user reported to me that he had errors compiling a userspace portion 
of iptables because the u64 data type isn't exported to userspace.  This 
patch changes generic_hweight64 to use unsigned long longs instead of 
u64s.  It also changes the return type to unsigned int, to match the 
other generic_hweight functions.  Please apply.

Cheers!

-Matt

--------------030100000504050001000606
Content-Type: text/plain;
 name="hweight64_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hweight64_fix.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.5.73-vanilla/include/linux/bitops.h linux-2.5.73-hweight64_fix/include/linux/bitops.h
--- linux-2.5.73-vanilla/include/linux/bitops.h	Sun Jun 22 11:33:32 2003
+++ linux-2.5.73-hweight64_fix/include/linux/bitops.h	Mon Jun 23 11:31:18 2003
@@ -108,19 +108,20 @@ static inline unsigned int generic_hweig
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
 
-static inline unsigned long generic_hweight64(__u64 w)
+static inline unsigned int generic_hweight64(unsigned long long w)
 {
 #if BITS_PER_LONG < 64
 	return generic_hweight32((unsigned int)(w >> 32)) +
 				generic_hweight32((unsigned int)w);
 #else
-	u64 res;
+	unsigned long long res;
 	res = (w & 0x5555555555555555) + ((w >> 1) & 0x5555555555555555);
 	res = (res & 0x3333333333333333) + ((res >> 2) & 0x3333333333333333);
 	res = (res & 0x0F0F0F0F0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F0F0F0F0F);
 	res = (res & 0x00FF00FF00FF00FF) + ((res >> 8) & 0x00FF00FF00FF00FF);
 	res = (res & 0x0000FFFF0000FFFF) + ((res >> 16) & 0x0000FFFF0000FFFF);
-	return (res & 0x00000000FFFFFFFF) + ((res >> 32) & 0x00000000FFFFFFFF);
+	res = (res & 0x00000000FFFFFFFF) + ((res >> 32) & 0x00000000FFFFFFFF);
+	return (unsigned int)res;
 #endif
 }
 

--------------030100000504050001000606--

