Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWEREgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWEREgH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 00:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWEREgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 00:36:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16050 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750890AbWEREgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 00:36:06 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Paul Jackson <pj@sgi.com>
Date: Wed, 17 May 2006 21:36:01 -0700
Message-Id: <20060518043601.15898.25240.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
References: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 02/03] Cpuset: update cpuset_zones_allowed comment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Update the kernel/cpuset.c:cpuset_zone_allowed() comment.

The rule for when mm/page_alloc.c should call cpuset_zone_allowed()
was intended to be:
  Don't call cpuset_zone_allowed() if you can't sleep, unless you
  pass in the __GFP_HARDWALL flag set in gfp_flag, which disables
  the code that might scan up ancestor cpusets and sleep.

The explanation of this rule in the comment above cpuset_zone_allowed()
was stale, as a result of a restructuring of some __alloc_pages() code
in November 2005.

Rewrite that comment ...

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- 2.6.17-rc4-mm1.orig/kernel/cpuset.c	2006-05-17 20:10:43.555129178 -0700
+++ 2.6.17-rc4-mm1/kernel/cpuset.c	2006-05-17 20:31:22.577065566 -0700
@@ -2231,19 +2231,25 @@ static const struct cpuset *nearest_excl
  * So only GFP_KERNEL allocations, if all nodes in the cpuset are
  * short of memory, might require taking the callback_mutex mutex.
  *
- * The first loop over the zonelist in mm/page_alloc.c:__alloc_pages()
- * calls here with __GFP_HARDWALL always set in gfp_mask, enforcing
- * hardwall cpusets - no allocation on a node outside the cpuset is
- * allowed (unless in interrupt, of course).
- *
- * The second loop doesn't even call here for GFP_ATOMIC requests
- * (if the __alloc_pages() local variable 'wait' is set).  That check
- * and the checks below have the combined affect in the second loop of
- * the __alloc_pages() routine that:
+ * The first call here from mm/page_alloc:get_page_from_freelist()
+ * has __GFP_HARDWALL set in gfp_mask, enforcing hardwall cpusets, so
+ * no allocation on a node outside the cpuset is allowed (unless in
+ * interrupt, of course).
+ *
+ * The second pass through get_page_from_freelist() doesn't even call
+ * here for GFP_ATOMIC calls.  For those calls, the __alloc_pages()
+ * variable 'wait' is not set, and the bit ALLOC_CPUSET is not set
+ * in alloc_flags.  That logic and the checks below have the combined
+ * affect that:
  *	in_interrupt - any node ok (current task context irrelevant)
  *	GFP_ATOMIC   - any node ok
  *	GFP_KERNEL   - any node in enclosing mem_exclusive cpuset ok
  *	GFP_USER     - only nodes in current tasks mems allowed ok.
+ *
+ * Rule:
+ *    Don't call cpuset_zone_allowed() if you can't sleep, unless you
+ *    pass in the __GFP_HARDWALL flag set in gfp_flag, which disables
+ *    the code that might scan up ancestor cpusets and sleep.
  **/
 
 int __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
