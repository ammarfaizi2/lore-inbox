Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVJUDlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVJUDlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 23:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVJUDlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 23:41:25 -0400
Received: from ozlabs.org ([203.10.76.45]:8862 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964856AbVJUDlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 23:41:24 -0400
Date: Fri, 21 Oct 2005 13:41:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: ppc64: Fix typo bug in iSeries hash code
Message-ID: <20051021034119.GB12976@localhost.localdomain>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply for 2.6.14 - this one-liner fixes a serious bug.

This patch fixes a stupid typo bug in the iSeries hash table code.
When we place a hash PTE in the secondary bucket, instead of setting
the SECONDARY flag bit, as we should, we (redundantly) set the VALID
flag.  This was introduced with the patch abolishing bitfields from
the hash table code.  Mea culpa, oops.  It hasn't been noticed until
now because in practice we don't hit the secondary bucket terribly
often.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/ppc64/kernel/iSeries_htab.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/iSeries_htab.c	2005-10-21 13:29:50.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/iSeries_htab.c	2005-10-21 13:30:55.000000000 +1000
@@ -66,7 +66,7 @@
 	}
 
 	if (slot < 0) {		/* MSB set means secondary group */
-		vflags |= HPTE_V_VALID;
+		vflags |= HPTE_V_SECONDARY;
 		secondary = 1;
 		slot &= 0x7fffffffffffffff;
 	}


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
