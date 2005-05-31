Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVEaQEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVEaQEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEaQCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:02:54 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:17844
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261921AbVEaQCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:02:42 -0400
Date: Tue, 31 May 2005 17:02:37 +0100
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1 - missing #define SECTIONS_SHIFT in sparsemem
Message-ID: <20050531160237.GA21094@shadowen.org>
References: <200505282238.j4SMcYdN014990@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505282238.j4SMcYdN014990@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you try this patch out for me.  I've reordered the code
slightly to better match the original intent of the code whilst
avoiding the reference to the undefined value.

Cheers.

-apw

=== 8< ===

valdis.kletnieks@vt.edu reported that with -Wundef triggers warnings
for each use of mm.h, out of the flags fit code for SPARSEMEM.
Change this check so that it uses the actually allocated flags widths
rather than the maxima for each.  This matches the original intent,
adding the nodes field if there is space and avoids the reference
to SECTIONS_SHIFT which was triggering the warning.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---
 mm.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/linux/mm.h current/include/linux/mm.h
--- reference/include/linux/mm.h
+++ current/include/linux/mm.h
@@ -421,12 +421,6 @@ static inline void put_page(struct page 
  * with space for node: | SECTION | NODE | ZONE | ... | FLAGS |
  *   no space for node: | SECTION |     ZONE    | ... | FLAGS |
  */
-#if SECTIONS_SHIFT+NODES_SHIFT+ZONES_SHIFT <= FLAGS_RESERVED
-#define NODES_WIDTH		NODES_SHIFT
-#else
-#define NODES_WIDTH		0
-#endif
-
 #ifdef CONFIG_SPARSEMEM
 #define SECTIONS_WIDTH		SECTIONS_SHIFT
 #else
@@ -435,6 +429,12 @@ static inline void put_page(struct page 
 
 #define ZONES_WIDTH		ZONES_SHIFT
 
+#if SECTIONS_WIDTH+ZONES_WIDTH+NODES_SHIFT <= FLAGS_RESERVED
+#define NODES_WIDTH		NODES_SHIFT
+#else
+#define NODES_WIDTH		0
+#endif
+
 /* Page flags: | [SECTION] | [NODE] | ZONE | ... | FLAGS | */
 #define SECTIONS_PGOFF		((sizeof(page_flags_t)*8) - SECTIONS_WIDTH)
 #define NODES_PGOFF		(SECTIONS_PGOFF - NODES_WIDTH)
