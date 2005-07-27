Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVG0Frp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVG0Frp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 01:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVG0Frp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 01:47:45 -0400
Received: from ozlabs.org ([203.10.76.45]:1159 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261970AbVG0Fro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 01:47:44 -0400
Date: Wed, 27 Jul 2005 15:47:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Remove nested feature sections
Message-ID: <20050727054723.GH27870@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

The {BEGIN,END}_FTR_SECTION asm macros used in ppc64 to nop out
sections of code at runtime cannot be nested.  However, we do nest
them in hash_low.S.  We get away with it there, because there is
nothing between the BEGIN markers for each section.  However, that's
confusing to someone reading the code.

This patch removes the nested ifset and ifclr feature sections,
replacing them with a single feature section in the full mask/value
form.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/ppc64/mm/hash_low.S
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hash_low.S	2005-07-26 10:36:48.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hash_low.S	2005-07-26 17:35:49.000000000 +1000
@@ -129,12 +129,10 @@
 	 * code rather than call a C function...) 
 	 */
 BEGIN_FTR_SECTION
-BEGIN_FTR_SECTION
 	mr	r4,r30
 	mr	r5,r7
 	bl	.hash_page_do_lazy_icache
-END_FTR_SECTION_IFSET(CPU_FTR_NOEXECUTE)
-END_FTR_SECTION_IFCLR(CPU_FTR_COHERENT_ICACHE)
+END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FTR_COHERENT_ICACHE, CPU_FTR_NOEXECUTE)
 
 	/* At this point, r3 contains new PP bits, save them in
 	 * place of "access" in the param area (sic)


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
