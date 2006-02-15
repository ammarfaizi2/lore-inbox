Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030608AbWBODRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030608AbWBODRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbWBODRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:17:13 -0500
Received: from smtpout.mac.com ([17.250.248.45]:31173 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030608AbWBODRN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:17:13 -0500
X-PGP-Universal: processed;
	by AlPB on Tue, 14 Feb 2006 21:17:11 -0600
Date: Tue, 14 Feb 2006 21:15:31 -0600
From: Mark Rustad <MRustad@mac.com>
Subject: [PATCH] elf: 0-length loading issue
To: linux-kernel@vger.kernel.org
X-Priority: 3
Message-ID: <r02010500-1044-527BBEA29DD111DA99F10011248907EC@[192.168.1.21]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Mailer: Mailsmith 2.1.5 (Blindsider)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have run into an elf loading issue when moving a program from running with a 2.6.5-
derived SuSE kernel to the 2.6.15 kernel.org kernel. The image being loaded is admittedly
unusual, but used to work and seems to me to be valid.

The program header for the troublesome image is the following:

Back.t:     file format elf32-i386

Program Header:
    LOAD off    0x00000000 vaddr 0x08048000 paddr 0x08048000 align 2**12
         filesz 0x00135718 memsz 0x00135718 flags r-x
    LOAD off    0x00135720 vaddr 0x0817e720 paddr 0x0817e720 align 2**12
         filesz 0x0000ffbc memsz 0x0002e594 flags rw-
    LOAD off    0x00146000 vaddr 0x63c03000 paddr 0x63c03000 align 2**12
         filesz 0x00000000 memsz 0x0008134c flags rw-
    NOTE off    0x00000200 vaddr 0x08048200 paddr 0x08048200 align 2**2
         filesz 0x00000020 memsz 0x00000020 flags r--
    NOTE off    0x00000220 vaddr 0x08048220 paddr 0x08048220 align 2**2
         filesz 0x00000018 memsz 0x00000018 flags r--
   STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**2
         filesz 0x00000000 memsz 0x00000000 flags rw-

Note that the third LOAD area has a filesz of 0. This causes the elf loader to
attempt to do an mmap of zero length. In the older kernel, this seemed to "work"
in that no error was generated. Now in mm/mmap.c there is a check on the length
which returns -EINVAL if the length being mapped is zero. That error currently
results in a SIGKILL before things even get started.

In case you are wondering how this image was created, this funny load section was
the result from the following lines in a custom linker script:

  . = 0x63c03000;
  PROVIDE (SHMEM_START = .);
  .shmem (NOLOAD) :  { *(.shmem) }

AFAIK, this is not an invalid thing to do. If I am wrong about that, please
let me know.

The following patch allows this image to be successfully run. This patch attempts
to tread lightly on the source by only modifying the existing error path. It might
be better to check for the zero length to avoid making the doomed elf_map call.

From: Mark Rustad <MRustad@mac.com>

Allow zero-length load sections once again. They stopped working when do_mmap
began failing 0-length mappings.

Signed-off-by: Mark Rustad <MRustad@mac.com>
---

--- a/fs/binfmt_elf.c	2006-01-02 21:21:10.000000000 -0600
+++ b/fs/binfmt_elf.c	2006-02-02 10:03:05.686253489 -0600
@@ -842,8 +842,11 @@ static int load_elf_binary(struct linux_
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags);
 		if (BAD_ADDR(error)) {
-			send_sig(SIGKILL, current, 0);
-			goto out_free_dentry;
+			if (elf_ppnt->p_filesz) {
+				send_sig(SIGKILL, current, 0);
+				goto out_free_dentry;
+			}
+			error = ELF_PAGESTART(load_bias + vaddr);
 		}
 
 		if (!load_addr_set) {
-- 
Mark Rustad, mrustad@mac.com
