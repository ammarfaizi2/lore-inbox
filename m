Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759848AbWLDFQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759848AbWLDFQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 00:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759858AbWLDFQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 00:16:07 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43202 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1759848AbWLDFQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 00:16:05 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: USB development list <linux-usb-devel@lists.sourceforge.net>
Cc: Greg KH <gregkh@suse.de>, "Lu, Yinghai" <yinghai.lu@amd.com>,
       Stefan Reinauer <stepan@coresystems.de>,
       Peter Stuge <stuge-linuxbios@cdy.org>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: [RFC][PATCH 1/2] x86_64:  Preallocate the fixmap pud and pmd entries.
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
	<20061201191916.GB3539@suse.de>
	<m13b7xf084.fsf@ebiederm.dsl.xmission.com>
	<m1hcwcuu17.fsf_-_@ebiederm.dsl.xmission.com>
Date: Sun, 03 Dec 2006 22:13:57 -0700
In-Reply-To: <m1hcwcuu17.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Sun, 03 Dec 2006 22:09:08 -0700")
Message-ID: <m1d570utt6.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To use the debug device I need to work through a port so I need
to call ioreamp or similar.  Since we are doing this very early
I chose to use a fixmap (because we are unlikely to free the mapping)
and because it is simple.  If we preallocate the fixmap pud and pmd
entries the existing fixmap codes works anytime from power up without
modifications or memory allocations.  So we don't need a special case.

---
 arch/x86_64/kernel/head.S |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
index 2f65469..4004965 100644
--- a/arch/x86_64/kernel/head.S
+++ b/arch/x86_64/kernel/head.S
@@ -271,7 +271,16 @@ NEXT_PAGE(level3_kernel_pgt)
 	.fill	510,8,0
 	/* (2^48-(2*1024*1024*1024)-((2^39)*511))/(2^30) = 510 */
 	.quad	phys_level2_kernel_pgt | 0x007
-	.fill	1,8,0
+	.quad	phys_level2_fixmap_pgt | 0x007
+
+NEXT_PAGE(level2_fixmap_pgt)
+	.fill	506,8,0
+	.quad	phys_level1_fixmap_pgt | 0x007
+	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
+	.fill	5,8,0
+
+NEXT_PAGE(level1_fixmap_pgt)
+	.fill	512,8,0
 
 NEXT_PAGE(level2_ident_pgt)
 	/* 40MB for bootup. 	*/
-- 
1.4.2.rc3.g7e18e-dirty

