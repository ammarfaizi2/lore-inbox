Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946387AbWJTLza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946387AbWJTLza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 07:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946390AbWJTLza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 07:55:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:17874 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946387AbWJTLz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 07:55:29 -0400
Date: Fri, 20 Oct 2006 13:55:27 +0200
From: Marcus Meissner <meissner@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       arjan@linux.intel.com
Subject: [PATCH] binfmt_elf: randomize PIE binaries (2nd try)
Message-ID: <20061020115527.GB14448@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randomizes -pie compiled binaries from PAGE_SIZE up to
ELF_ET_DYN_BASE.

0 -> PAGE_SIZE is excluded to allow NULL ptr accesses
to fail.

Signed-off-by: Marcus Meissner <meissner@suse.de>

----
 binfmt_elf.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.18/fs/binfmt_elf.c.xx	2006-10-20 10:42:03.000000000 +0200
+++ linux-2.6.18/fs/binfmt_elf.c	2006-10-20 10:51:27.000000000 +0200
@@ -856,7 +856,13 @@
 			 * default mmap base, as well as whatever program they
 			 * might try to exec.  This is because the brk will
 			 * follow the loader, and is not movable.  */
-			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
+			if (current->flags & PF_RANDOMIZE)
+				load_bias = randomize_range(PAGE_SIZE,
+							    ELF_ET_DYN_BASE,
+							    0);
+			else
+				load_bias = ELF_ET_DYN_BASE;
+			load_bias = ELF_PAGESTART(load_bias - vaddr);
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
