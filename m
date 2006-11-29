Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758386AbWK2WGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386AbWK2WGD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758359AbWK2WEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:04:39 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:7125 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758344AbWK2WEe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:04:34 -0500
Message-Id: <20061129220623.827569000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:30 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Robin Holt <holt@sgi.com>,
       Dean Nelson <dcn@sgi.com>, Tony Luck <tony.luck@intel.com>
Subject: [patch 19/23] IA64: bte_unaligned_copy() transfers one extra cache line.
Content-Disposition: inline; filename=bte_unaligned_copy-transfers-one-extra-cache-line.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Robin Holt <holt@sgi.com>

When called to do a transfer that has a start offset within the cache
line which is uneven between source and destination and a length which
terminates the source of the copy exactly on a cache line, one extra
line gets copied into a temporary buffer.  This is normally not an issue
since the buffer is a kernel buffer and only the requested information
gets copied into the user buffer.

The problem arises when the source ends at the very last physical page
of memory.  That last cache line does not exist and results in the SHUB
chip raising an MCA.

Signed-off-by: Robin Holt <holt@sgi.com>
Signed-off-by: Dean Nelson <dcn@sgi.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/ia64/sn/kernel/bte.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- linux-2.6.18.4.orig/arch/ia64/sn/kernel/bte.c
+++ linux-2.6.18.4/arch/ia64/sn/kernel/bte.c
@@ -382,14 +382,13 @@ bte_result_t bte_unaligned_copy(u64 src,
 		 * bcopy to the destination.
 		 */
 
-		/* Add the leader from source */
-		headBteLen = len + (src & L1_CACHE_MASK);
-		/* Add the trailing bytes from footer. */
-		headBteLen += L1_CACHE_BYTES - (headBteLen & L1_CACHE_MASK);
-		headBteSource = src & ~L1_CACHE_MASK;
 		headBcopySrcOffset = src & L1_CACHE_MASK;
 		headBcopyDest = dest;
 		headBcopyLen = len;
+
+		headBteSource = src - headBcopySrcOffset;
+		/* Add the leading and trailing bytes from source */
+		headBteLen = L1_CACHE_ALIGN(len + headBcopySrcOffset);
 	}
 
 	if (headBcopyLen > 0) {

--
