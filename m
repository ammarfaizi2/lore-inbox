Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWEPUNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWEPUNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 16:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWEPUNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 16:13:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:24301 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750730AbWEPUNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 16:13:12 -0400
Date: Tue, 16 May 2006 13:06:32 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] SPARSEMEM incorrectly calculates section number
Message-ID: <20060516200631.GA9362@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bad calculation/loop in __section_nr() could result in incorrect section
information being put into sysfs memory entries.  This primarily impacts
memory add operations as the sysfs information is used while onlining new
memory.

Fix suggested by Dave Hansen.

Note that the bug may not be obvious from the patch.  It actually occurs
in the function's return statement:

	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);

In the existing code, root_nr has already been multiplied by SECTIONS_PER_ROOT.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.17-rc4-mm1/mm/sparse.c linux-2.6.17-rc4-mm1.work/mm/sparse.c
--- linux-2.6.17-rc4-mm1/mm/sparse.c	2006-05-16 18:56:44.000000000 +0000
+++ linux-2.6.17-rc4-mm1.work/mm/sparse.c	2006-05-16 19:10:37.000000000 +0000
@@ -87,11 +87,8 @@ int __section_nr(struct mem_section* ms)
 	unsigned long root_nr;
 	struct mem_section* root;
 
-	for (root_nr = 0;
-	     root_nr < NR_MEM_SECTIONS;
-	     root_nr += SECTIONS_PER_ROOT) {
-		root = __nr_to_section(root_nr);
-
+	for (root_nr = 0; root_nr < NR_SECTION_ROOTS; root_nr++) {
+		root = __nr_to_section(root_nr * SECTIONS_PER_ROOT);
 		if (!root)
 			continue;
 
