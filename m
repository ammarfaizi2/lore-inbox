Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268765AbUJEDT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268765AbUJEDT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 23:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268759AbUJEDT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 23:19:59 -0400
Received: from ozlabs.org ([203.10.76.45]:57568 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268765AbUJEDQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 23:16:01 -0400
Date: Tue, 5 Oct 2004 13:13:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Linas Vepstas <linas@austin.ibm.com>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PPC64] Squash EEH warnings
Message-ID: <20041005031341.GA3695@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Linas Vepstas <linas@austin.ibm.com>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

A slightly non-ideal version of the recent patch which fixed EEH being
a no-op went in.  The srcsave variable in eeh_memcpy_to_io() is now
never referenced on non-pSeries machines, and so spews hundreds of
warnings.  The variable doesn't actually accomplish anything, so this
patch gets rid of it.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/asm-ppc64/eeh.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/eeh.h	2004-10-05 10:08:10.000000000 +1000
+++ working-2.6/include/asm-ppc64/eeh.h	2004-10-05 13:09:24.730992368 +1000
@@ -196,7 +196,6 @@
 static inline void eeh_memcpy_fromio(void *dest, const volatile void __iomem *src, unsigned long n) {
 	void *vsrc = (void __force *) src;
 	void *destsave = dest;
-	const volatile void __iomem *srcsave = src;
 	unsigned long nsave = n;
 
 	while(n && (!EEH_CHECK_ALIGN(vsrc, 4) || !EEH_CHECK_ALIGN(dest, 4))) {
@@ -227,7 +226,7 @@
 	 */
 	if ((nsave >= 4) &&
 		(EEH_POSSIBLE_ERROR((*((u32 *) destsave+nsave-4)), u32))) {
-		eeh_check_failure(srcsave, (*((u32 *) destsave+nsave-4)));
+		eeh_check_failure(src, (*((u32 *) destsave+nsave-4)));
 	}
 }
 


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
