Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbVKVSIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbVKVSIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbVKVSHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:07:55 -0500
Received: from 81-179-232-225.dsl.pipex.com ([81.179.232.225]:13509 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965084AbVKVSHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:07:52 -0500
Date: Tue, 22 Nov 2005 18:07:44 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, kravetz@us.ibm.com, anton@samba.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] sparse provide pfn_to_nid
Message-ID: <20051122180744.GA10861@shadowen.org>
References: <exportbomb.1132682844@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1132682844@pinky>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparsemem: provide pfn_to_nid

Before SPARSEMEM is initialised we cannot provide an efficient
pfn_to_nid() implmentation; before initialisation is complete we use
early_pfn_to_nid() to provide location information.  Until recently
there was no non-init user of this functionality.  Provide a post
init pfn_to_nid() implementation.

Note that this implmentation assumes that the pfn passed has
been validated with pfn_valid().  The current single user of this
function already has this check.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 mmzone.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)
diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h
+++ current/include/linux/mmzone.h
@@ -606,7 +606,11 @@ static inline int pfn_valid(unsigned lon
  * this restriction.
  */
 #ifdef CONFIG_NUMA
-#define pfn_to_nid		early_pfn_to_nid
+#define pfn_to_nid(pfn)							\
+({									\
+	unsigned long __pfn_to_nid_pfn = (pfn);				\
+	page_to_nid(pfn_to_page(__pfn_to_nid_pfn));			\
+})
 #else
 #define pfn_to_nid(pfn)		(0)
 #endif
