Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272334AbRH3Qyd>; Thu, 30 Aug 2001 12:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272335AbRH3Qya>; Thu, 30 Aug 2001 12:54:30 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:28051 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271986AbRH3QyV>; Thu, 30 Aug 2001 12:54:21 -0400
Date: Thu, 30 Aug 2001 12:53:29 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.rutgers.edu
Subject: [PATCH] Fix bug in binfmt_elf.c
Message-ID: <20010830125329.E25384@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

--- linux/fs/binfmt_elf.c.jj	Mon Aug 27 20:18:34 2001
+++ linux/fs/binfmt_elf.c	Thu Aug 30 09:37:04 2001
@@ -607,7 +607,7 @@ static int load_elf_binary(struct linux_
 			if (elf_ex.e_type == ET_DYN) {
 				load_bias += error -
 				             ELF_PAGESTART(load_bias + vaddr);
-				load_addr += error;
+				load_addr += load_bias;
 			}
 		}
 		k = elf_ppnt->p_vaddr;

If libc.so.6 is prelinked, it cannot be run as program:
(ld-linux.so.2 as program works, since it does not use AT_PHDR)

LD_SHOW_AUXV=1 /tmp/libc-2.2.4.so
AT_HWCAP:    fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx osfxsr
AT_PAGESZ:      4096
AT_CLKTCK:      100
AT_PHDR:        0xc101e034
AT_PHENT:       32
AT_PHNUM:       6
AT_BASE:        0x0
AT_FLAGS:       0x0
AT_ENTRY:       0x8001e410
AT_UID:         2140
AT_EUID:        2140
AT_GID:         2140
AT_EGID:        2140
AT_PLATFORM:    i686
Segmentation fault (core dumped)

It dies because it tries to dereference AT_PHDR (see the strange value above).
Interesting data:
...
  Entry point address:               0x4103c410
  Size of this header:               52 (bytes)
...
  LOAD           0x000000 0x4101e000 0x4101e000 0x1333a6 0x1333a6 R E 0x1000
  LOAD           0x1333c0 0x411523c0 0x411523c0 0x04708 0x088e8 RW  0x1000

41000000-41016000 r-xp 00000000 08:83 162914     /tmp/ld-2.2.4.so
41016000-41017000 rw-p 00015000 08:83 162914     /tmp/ld-2.2.4.so
80000000-80134000 r-xp 00000000 08:83 162922     /tmp/libc-2.2.4.so
80134000-80139000 rw-p 00133000 08:83 162922     /tmp/libc-2.2.4.so
80139000-8013d000 rwxp 00000000 00:00 0
bffff000-c0000000 rwxp 00000000 00:00 0

So, AT_ENTRY is correct ((e_entry 0x4103c410 - first_pt_load_vaddr 0x4101e000) + mmap address 0x80000000),
AT_BASE too (though the source is confusing, AT_BASE is in fact bias, not
address), but AT_PHDR is wrong, points to kernel memory.
AT_PHDR was computed as first PT_LOAD's p_vaddr (0x4101e000) minus first
PT_LOAD's p_offset (0) plus mmap address (0x80000000) plus e_phoff.
But we want AT_PHDR to be a pointer to ElfW(Phdr) where it is mapped in
memory, and e_phoff is offset from start of the file.
Above is a fix (load_bias is the difference between addresses actually mapped
and virtual addresses noted in file, first PT_LOAD's p_vaddr - p_offset is
the difference between virtual addresses noted in file and file locations,
so adding them together we get actual virtual addresses minus file locations
difference, which is exactly what we need, so that we can add e_phoff
(offset into file in bytes) to it to get ElfW(Phdr) virtual address).
Should apply to any kernel out there, at least all 2.2.*-2.4.* kernels have
this bug.

	Jakub
