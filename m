Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbTFMBKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 21:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTFMBKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 21:10:44 -0400
Received: from palrel11.hp.com ([156.153.255.246]:13711 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265101AbTFMBKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 21:10:17 -0400
Date: Thu, 12 Jun 2003 18:24:02 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200306130124.h5D1O2DT025311@napali.hpl.hp.com>
To: torvalds@transmeta.com, roland@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: FIXMAP-related change to mm/memory.c
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to constrain the FIXADDR range on x86/x86-64
(FIXADDR_START-FIXADDR_TOP) such that the entire range is read-only by
user-level?  If so, we could simplify the permission test like this:

===== mm/memory.c 1.124 vs edited =====
--- 1.124/mm/memory.c	Wed May 14 00:53:07 2003
+++ edited/mm/memory.c	Thu Jun 12 18:08:42 2003
@@ -714,8 +714,7 @@
 			if (!pmd)
 				return i ? : -EFAULT;
 			pte = pte_offset_kernel(pmd, pg);
-			if (!pte || !pte_present(*pte) || !pte_user(*pte) ||
-			    !(write ? pte_write(*pte) : pte_read(*pte)))
+			if (!pte || !pte_present(*pte) || write)
 				return i ? : -EFAULT;
 			if (pages) {
 				pages[i] = pte_page(*pte);

Advantages:

	- simpler code
	- gets rid of pte_user() (which was introduced just for this purpose)
	- lets gdb work better on arches which use execute-only page for
	  privilege promotion

I can live with the existing code, but for ia64, it would be useful to
have this patch in place, because otherwise, the gate page used for
lightweight system calls and the signal trampoline is not readable via
ptrace() (that page must be mapped as EXECUTE-only, because otherwise
the SYSENTER-equivalent of ia64, called "epc", cannot be used).
(Note, there is no security issue here, because the EXECUTE-only page
only contains code or ELF-related constant data.)

I considered changing the PTE-checking, but it gets really tricky,
because on many platforms, the privilege-level and the
access-permission bits are not fully orthogonal (for example, the
EXECUTE-only page is actually a kernel-owned page, but it's still
executable at the user level).  In the end I decided that the whole
purpose of the FIXADDR range stuff is to _allow_ user-level access to
that range, so if the range is chosen properly, it should be OK to
allow reads without further pte_read() access checking.  (If writes
needs to be supported, we would have to add back the pte_user() &&
pte_write() checks).

	--david
