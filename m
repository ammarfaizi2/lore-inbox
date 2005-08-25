Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVHYR5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVHYR5s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 13:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVHYR5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 13:57:48 -0400
Received: from ixca-out.ixiacom.com ([67.133.120.10]:8642 "EHLO
	ixca-ex1.ixiacom.com") by vger.kernel.org with ESMTP
	id S1750966AbVHYR5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 13:57:47 -0400
Message-ID: <430E0697.5000503@rincewind.tv>
Date: Thu, 25 Aug 2005 10:57:43 -0700
X-Sybari-Trust: d7535144 453feeff d9cd6d6c 0000010c
From: Ollie Wild <aaw@rincewind.tv>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] arch-sh csum_partial_copy_generic() bugfix
Content-Type: multipart/mixed;
 boundary="------------000005020201060101080208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000005020201060101080208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There's a bug in Hitachi SuperH csum_partial_copy_generic() 
implementation.  If the supplied length is 1 (and several alignment 
conditions are met), the function immediately branches to label 4.  
However, the assembly at label 4 expects the length to be stored in 
register r2.  Since this has not occurred, subsequent behavior is undefined.

This can cause bad payload checksums in TCP connections.

I've fixed the problem by initializing register r2 prior to the branch 
instruction.

Ollie

--------------000005020201060101080208
Content-Type: text/x-patch;
 name="csum_partial_copy_generic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="csum_partial_copy_generic.patch"

diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
--- a/arch/sh/lib/checksum.S
+++ b/arch/sh/lib/checksum.S
@@ -202,8 +202,9 @@ ENTRY(csum_partial_copy_generic)
 	cmp/pz	r6		! Jump if we had at least two bytes.
 	bt/s	1f
 	 clrt
+	add	#2,r6		! r6 was < 2.	Deal with it.
 	bra	4f
-	 add	#2,r6		! r6 was < 2.	Deal with it.
+	 mov	r6,r2
 
 3:	! Handle different src and dest alignments.
 	! This is not common, so simple byte by byte copy will do.

--------------000005020201060101080208--
