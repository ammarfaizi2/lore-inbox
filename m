Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965576AbWI0LYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965576AbWI0LYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965578AbWI0LYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:24:50 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:11204
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S965576AbWI0LYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:24:49 -0400
Date: Wed, 27 Sep 2006 12:23:15 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>, Andy Whitcroft <apw@shadowen.org>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH] zone table removal miss merge
Message-ID: <20060927112315.GA8093@shadowen.org>
References: <20060927021934.9461b867.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20060927021934.9461b867.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As suspected this is not related to SPARSEMEM configuration at all.
But relates to the case where the node,zone size is zero.  Here we
then are trying to shift (sizeof(int) - 0) which is illegal.

We should be defining ZONEID_SHIFT in terms of ZONE_PGSHIFT not
ZONE_PGOFF.  As this was correct in the orginal patch I assume this
was somehow damaged during merge.

The below should fix it.

-apw
=== 8< ===
zone table removal miss-merge

It looks very much like zone table removal v2 suffered during merge
into -mm.  This patch is needed to get rid of the following errors
on arm (and I suspect other platforms):

  include/linux/mm.h: In function `page_zone_id':
  include/linux/mm.h:450: warning: right shift count >= width of type

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7997d9..2eb64fa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -421,7 +421,7 @@ #define ZONEID_SHIFT		(SECTIONS_SHIFT + 
 #else
 #define ZONEID_SHIFT		(NODES_SHIFT + ZONES_SHIFT)
 #endif
-#define ZONEID_PGSHIFT		ZONES_PGOFF
+#define ZONEID_PGSHIFT		ZONES_PGSHIFT
 
 #if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
 #error SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
