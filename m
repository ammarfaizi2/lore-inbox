Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946088AbWJSOft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946088AbWJSOft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946089AbWJSOft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:35:49 -0400
Received: from ns1.suse.de ([195.135.220.2]:7566 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946088AbWJSOfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:35:48 -0400
Date: Thu, 19 Oct 2006 16:35:47 +0200
From: Marcus Meissner <meissner@suse.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] binfmt_elf: randomize PIE binaries
Message-ID: <20061019143547.GA8586@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Randomizes -pie compiled binaries over the whole address
range from 0 up to ELF_ET_DYN_BASE.

Signed-off-by: Marcus Meissner <meissner@suse.de>

----
 binfmt_elf.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


--- linux-2.6.18/fs/binfmt_elf.c.xx	2006-10-19 11:21:49.000000000 +0200
+++ linux-2.6.18/fs/binfmt_elf.c	2006-10-19 11:24:58.000000000 +0200
@@ -856,7 +856,12 @@ static int load_elf_binary(struct linux_
 			 * default mmap base, as well as whatever program they
 			 * might try to exec.  This is because the brk will
 			 * follow the loader, and is not movable.  */
-			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
+			if (current->flags & PF_RANDOMIZE)
+				load_bias = randomize_range(0, ELF_ET_DYN_BASE,
+							    vaddr);
+			else
+				load_bias = ELF_ET_DYN_BASE - vaddr;
+			load_bias = ELF_PAGESTART(load_bias);
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
