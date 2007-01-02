Return-Path: <linux-kernel-owner+w=401wt.eu-S964971AbXABVEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbXABVEa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbXABVEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:04:30 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:49636 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964971AbXABVE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:04:29 -0500
Date: Wed, 3 Jan 2007 06:03:22 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] Sanely size hash tables when using large base pages. take 2.
Message-ID: <20070102210322.GA20697@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resubmission of the earlier patch with the pidhash bits
dropped.

At the moment the inode/dentry cache hash tables (common by way of
alloc_large_system_hash()) are incorrectly sized by their respective
detection logic when we attempt to use large base pages on systems
with little memory.

This results in odd behaviour when using a 64kB PAGE_SIZE, such as:

Dentry cache hash table entries: 8192 (order: -1, 32768 bytes)
Inode-cache hash table entries: 4096 (order: -2, 16384 bytes)

The mount cache hash table is seemingly the only one that gets this right
by directly taking PAGE_SIZE in to account.

The following patch attempts to catch the bogus values and round it up to
at least 0-order.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 mm/page_alloc.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8c1a116..4a9a83f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3321,6 +3321,10 @@ void *__init alloc_large_system_hash(con
 			numentries >>= (scale - PAGE_SHIFT);
 		else
 			numentries <<= (PAGE_SHIFT - scale);
+
+		/* Make sure we've got at least a 0-order allocation.. */
+		if (unlikely((numentries * bucketsize) < PAGE_SIZE))
+			numentries = PAGE_SIZE / bucketsize;
 	}
 	numentries = roundup_pow_of_two(numentries);
 
