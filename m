Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWCTTKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWCTTKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWCTTKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:10:09 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:53459 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S965038AbWCTTKG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:10:06 -0500
Message-ID: <441EFE05.8040506@cosmosbay.com>
Date: Mon, 20 Mar 2006 20:09:57 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use unsigned int types for a faster bsearch
References: <20060315054416.GF3205@localhost.localdomain>	<1142403500.26706.2.camel@sli10-desk.sh.intel.com> <20060314233138.009414b4.akpm@osdl.org> <4417E047.70907@cosmosbay.com>
In-Reply-To: <4417E047.70907@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------010009080708070501000602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010009080708070501000602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch avoids arithmetic on 'signed' types that are slower than 
'unsigned'. This saves space and cpu cycles.

size of kernel/sys.o before the patch (gcc-3.4.5)

    text    data     bss     dec     hex filename
   10924     252       4   11180    2bac kernel/sys.o

size of kernel/sys.o after the patch
    text    data     bss     dec     hex filename
   10903     252       4   11159    2b97 kernel/sys.o

I noticed that gcc-4.1.0 (from Fedora Core 5) even uses idiv instruction for 
(a+b)/2 if a and b are signed.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------010009080708070501000602
Content-Type: text/plain;
 name="groups_search.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="groups_search.patch"

--- a/kernel/sys.c	2006-03-20 18:42:41.000000000 +0100
+++ b/kernel/sys.c	2006-03-20 19:00:43.000000000 +0100
@@ -1375,7 +1375,7 @@
 /* a simple bsearch */
 int groups_search(struct group_info *group_info, gid_t grp)
 {
-	int left, right;
+	unsigned int left, right;
 
 	if (!group_info)
 		return 0;
@@ -1383,7 +1383,7 @@
 	left = 0;
 	right = group_info->ngroups;
 	while (left < right) {
-		int mid = (left+right)/2;
+		unsigned int mid = (left+right)/2;
 		int cmp = grp - GROUP_AT(group_info, mid);
 		if (cmp > 0)
 			left = mid + 1;

--------------010009080708070501000602--
