Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265166AbTFRNpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 09:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbTFRNpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 09:45:30 -0400
Received: from sunsite.ms.mff.cuni.cz ([195.113.19.66]:21397 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265166AbTFRNp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 09:45:29 -0400
Date: Wed, 18 Jun 2003 15:59:20 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix binfmt_elf.c bug on ppc64
Message-ID: <20030618135920.GO20507@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Any prelinked shared library is impossible to run on ppc64 without this
patch, as they immediately segfault. Say:
/bin/echo
works even if /lib64/ld64.so.1 is prelinked while
/lib64/ld64.so.1 /bin/echo
segfaults.
The problem is that ELF_PLAT_INIT is passed the virtual address of the
shared library, not the difference between the virtual address of the shared
library and p_vaddr of the first PT_LOAD segment in that library
(while for the interpreter interp_load_address is the bias).
ELF_PLAT_INIT sets gpr[2] to this absolute address, but
arch/ppc64/kernel/process.c (start_thread) assumes it is a bias and adds it
to entry and toc values loaded from the entry point descriptor.
For non-prelinked shared libraries, first PT_LOAD segment's p_vaddr is
typically 0 and thus load_addr == load_bias (which is why this bug has not
been discovered that long).

--- linux-2.5.72/fs/binfmt_elf.c.jj	2003-06-17 06:20:00.000000000 +0200
+++ linux-2.5.72/fs/binfmt_elf.c	2003-06-18 15:47:52.000000000 +0200
@@ -697,7 +697,7 @@ static int load_elf_binary(struct linux_
 				load_bias += error -
 				             ELF_PAGESTART(load_bias + vaddr);
 				load_addr += load_bias;
-				reloc_func_desc = load_addr;
+				reloc_func_desc = load_bias;
 			}
 		}
 		k = elf_ppnt->p_vaddr;

	Jakub
