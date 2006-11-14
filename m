Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965357AbWKNM01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965357AbWKNM01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965368AbWKNM01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:26:27 -0500
Received: from cantor.suse.de ([195.135.220.2]:2247 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965357AbWKNM00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:26:26 -0500
Date: Tue, 14 Nov 2006 13:26:25 +0100
From: Marcus Meissner <meissner@suse.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: binfmt_elf: randomize PIE binaries (3rd try)
Message-ID: <20061114122625.GA25856@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randomizes -pie compiled binaries from 64k (0x10000) up to
ELF_ET_DYN_BASE.

0 -> 64k is excluded to allow NULL ptr array accesses
to fail.

Signed-off-by: Marcus Meissner <meissner@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@codemonkey.org.uk>
Cc: Arjan van de Ven <arjan@linux.intel.com>

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
+				load_bias = randomize_range(0x10000,
+							    ELF_ET_DYN_BASE,
+							    0);
+			else
+				load_bias = ELF_ET_DYN_BASE;
+			load_bias = ELF_PAGESTART(load_bias - vaddr);
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
