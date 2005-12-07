Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVLGPfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVLGPfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVLGPft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:35:49 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:25324 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751141AbVLGPfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:35:41 -0500
Message-ID: <43970136.4010006@cosmosbay.com>
Date: Wed, 07 Dec 2005 16:35:18 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Keith Mannthey <kmannth@gmail.com>, Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] x86_64 NUMA : Bug correction in populate_memnodemap()
References: <a762e240512062124i517a9c35xd1ec681428418341@mail.gmail.com>
In-Reply-To: <a762e240512062124i517a9c35xd1ec681428418341@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------010409020206070609030106"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 07 Dec 2005 16:35:19 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010409020206070609030106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

As reported by Keith Mannthey, there are problems in populate_memnodemap()

The bug was that the compute_hash_shift() was returning 31, with incorrect 
initialization of memnodemap[]

To correct the bug, we must use (1UL << shift) instead of (1 << shift) to 
avoid an integer overflow, and we must check that shift < 64 to avoid an 
infinite loop.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------010409020206070609030106
Content-Type: text/plain;
 name="populate_memnodemap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="populate_memnodemap.patch"

--- linux-2.6.15-rc5/arch/x86_64/mm/numa.c	2005-12-04 06:10:42.000000000 +0100
+++ linux-2.6.15-rc5-ed/arch/x86_64/mm/numa.c	2005-12-07 16:45:15.000000000 +0100
@@ -53,6 +53,8 @@
 	int res = -1;
 	unsigned long addr, end;
 
+	if (shift >= 64)
+		return -1;
 	memset(memnodemap, 0xff, sizeof(memnodemap));
 	for (i = 0; i < numnodes; i++) {
 		addr = nodes[i].start;
@@ -65,7 +67,7 @@
 			if (memnodemap[addr >> shift] != 0xff)
 				return -1;
 			memnodemap[addr >> shift] = i;
-			addr += (1 << shift);
+                       addr += (1UL << shift);
 		} while (addr < end);
 		res = 1;
 	} 

--------------010409020206070609030106--
