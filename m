Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWFTLtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWFTLtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbWFTLtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:49:41 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:63360 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S965128AbWFTLtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:49:19 -0400
Message-Id: <20060620114657.947738000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:04 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/13] SPARC64: Fix missing fold at end of checksums.
Content-Disposition: inline; filename=sparc64-fix-missing-fold-at-end-of-checksums.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

Both csum_partial() and the csum_partial_copy*() family of routines
forget to do a final fold on the computed checksum value on sparc64.
So do the standard Sparc "add + set condition codes, add carry"
sequence, then make sure the high 32-bits of the return value are
clear.

Based upon some excellent detective work and debugging done by
Richard Braun and Samuel Thibault.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 arch/sparc64/lib/checksum.S  |    5 +++--
 arch/sparc64/lib/csum_copy.S |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.16.21.orig/arch/sparc64/lib/checksum.S
+++ linux-2.6.16.21/arch/sparc64/lib/checksum.S
@@ -165,8 +165,9 @@ csum_partial_end_cruft:
 	sll		%g1, 8, %g1
 	or		%o5, %g1, %o4
 
-1:	add		%o2, %o4, %o2
+1:	addcc		%o2, %o4, %o2
+	addc		%g0, %o2, %o2
 
 csum_partial_finish:
 	retl
-	 mov		%o2, %o0
+	 srl		%o2, 0, %o0
--- linux-2.6.16.21.orig/arch/sparc64/lib/csum_copy.S
+++ linux-2.6.16.21/arch/sparc64/lib/csum_copy.S
@@ -221,11 +221,12 @@ FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len
 	sll		%g1, 8, %g1
 	or		%o5, %g1, %o4
 
-1:	add		%o3, %o4, %o3
+1:	addcc		%o3, %o4, %o3
+	addc		%g0, %o3, %o3
 
 70:
 	retl
-	 mov		%o3, %o0
+	 srl		%o3, 0, %o0
 
 95:	mov		0, GLOBAL_SPARE
 	brlez,pn	%o2, 4f

--
