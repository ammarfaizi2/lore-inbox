Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWCGTEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWCGTEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWCGTEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:04:38 -0500
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:28871 "EHLO
	outbound1-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751559AbWCGTEh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:04:37 -0500
X-BigFish: V
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] mm: data overlapping in page struct 
Date: Tue, 7 Mar 2006 14:04:34 -0500
Message-ID: <E6F1C74189C227449B7C7BC9F60926F901B4EC4C@torcaexmb2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mm: data overlapping in page struct 
Thread-Index: AcZB0+S3Fi/wMtX4R3KIEKwq8ABJMAAH3MAQ
From: "Hui Yu" <hyu@ati.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Andi Kleen" <ak@suse.de>, "Andrea Arcangeli" <andrea@suse.de>
X-OriginalArrivalTime: 07 Mar 2006 19:04:32.0070 (UTC) FILETIME=[F7814E60:01C64219]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to fix a data overlapping issue in struct page. The
problem was introduced a few months ago by "split page table lock"
change in which mapping is moved into the same union with ptl. Since
private has fixed length (size of unsigned long), depending on config
options, ptl may have larger size than private. In this case, ptl will
overlap to mapping and may overwrite the original data in mapping. 
The simplest way of fixing this is to move mapping out of the union, as
in this patch. There may be better approaches; I'll leave it to the
experts more familiar with this part of code.  

We have discussed this with some of the Novell kernel engineers in the
CC list.

Signed-off-by: Hui Yu <hyu@ati.com>

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 498ff87..edb9a22 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -234,18 +234,18 @@ struct page {
 						 * indicates order in
the buddy
 						 * system.
 						 */
-		struct address_space *mapping;	/* If low bit clear,
points to
-						 * inode address_space,
or NULL.
-						 * If page mapped as
anonymous
-						 * memory, low bit is
set, and
-						 * it points to anon_vma
object:
-						 * see PAGE_MAPPING_ANON
below.
-						 */
 	    };
 #if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
 	    spinlock_t ptl;
 #endif
 	};
+	struct address_space *mapping;	/* If low bit clear, points to
+					 * inode address_space, or NULL.
+					 * If page mapped as anonymous
+					 * memory, low bit is set, and
+					 * it points to anon_vma object:
+					 * see PAGE_MAPPING_ANON below.
+					 */
 	pgoff_t index;			/* Our offset within mapping. */
 	struct list_head lru;		/* Pageout list, eg. active_list
 					 * protected by zone->lru_lock !


