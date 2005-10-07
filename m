Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbVJGKJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbVJGKJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 06:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVJGKJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 06:09:14 -0400
Received: from agmk.net ([217.73.31.34]:32531 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S1751030AbVJGKJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 06:09:13 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6] binfmt_elf bug (exposed by klibc).
Date: Fri, 7 Oct 2005 12:09:05 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BlkRDtrIWuSzQLh"
Message-Id: <200510071209.05656.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_BlkRDtrIWuSzQLh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi All,

I've a simple program called empty.c.

$ cat empty.c

int main(int argc, char* argv[])
{
    return 0;
}

$ cat empty410.s

        .file   "empty.c"
        .text
        .p2align 4,,15
.globl main
        .type   main, @function
main:
        xorl    %eax, %eax
        ret
        .size   main, .-main
        .ident  "GCC: (GNU) 4.1.0 20050922 (experimental)"
        .section        .note.GNU-stack,"", at progbits

binutils-2.15.94.0.2.2 produces for this code empty .data and .bss sections:

Program Header:
    PHDR off    0x00000034 vaddr 0x08048034 paddr 0x08048034 align 2**2
         filesz 0x000000c0 memsz 0x000000c0 flags r-x
  INTERP off    0x000000f4 vaddr 0x080480f4 paddr 0x080480f4 align 2**0
         filesz 0x0000002a memsz 0x0000002a flags r--
    LOAD off    0x00000000 vaddr 0x08048000 paddr 0x08048000 align 2**12
         filesz 0x00000123 memsz 0x00000123 flags r-x
    LOAD off    0x00000124 vaddr 0x08049124 paddr 0x08049124 align 2**12
         filesz 0x00000000 memsz 0x00000000 flags rw-
   STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**2
         filesz 0x00000000 memsz 0x00000000 flags rwx
PAX_FLAGS off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**2
         filesz 0x00000000 memsz 0x00000000 flags --- 2800

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .interp       0000002a  080480f4  080480f4  000000f4  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  1 .text         00000003  08048120  08048120  00000120  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .data         00000000  08049124  08049124  00000124  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .bss          00000000  08049124  08049124  00000124  2**2
                  ALLOC

and /lib/klibc-*.so interpeter works fine.

binutils-2.16.91.0.3 doesn't produce useless empty sections:

Program Header:
    PHDR off    0x00000034 vaddr 0x08048034 paddr 0x08048034 align 2**2
         filesz 0x000000a0 memsz 0x000000a0 flags r-x
  INTERP off    0x000000f4 vaddr 0x080480f4 paddr 0x080480f4 align 2**0
         filesz 0x0000002a memsz 0x0000002a flags r--
    LOAD off    0x00000000 vaddr 0x08048000 paddr 0x08048000 align 2**12
         filesz 0x00000123 memsz 0x00000123 flags r-x
   STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**2
         filesz 0x00000000 memsz 0x00000000 flags rwx
PAX_FLAGS off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**2
         filesz 0x00000000 memsz 0x00000000 flags --- 2800

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .interp       0000002a  080480f4  080480f4  000000f4  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  1 .text         00000003  08048120  08048120  00000120  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE

...and klibc's loader doesn't reach crt0.o:_start().

It receives sigsegv from kernel. The load_elf_binary() calls
padzero() for nonexistent .bss mapping.

Attached workaround fixes problem. Could anybody look into this?

Regards,
Paweł.

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke

--Boundary-00=_BlkRDtrIWuSzQLh
Content-Type: text/x-diff;
  charset="utf-8";
  name="linux-2.6-binfmt-empty-bss.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="linux-2.6-binfmt-empty-bss.patch"

--- a/fs/binfmt_elf.c	2005-09-30 23:17:35.000000000 +0200
+++ b/fs/binfmt_elf.c	2005-10-07 11:46:27.159874250 +0200
@@ -905,7 +905,7 @@ static int load_elf_binary(struct linux_
 		send_sig(SIGKILL, current, 0);
 		goto out_free_dentry;
 	}
-	if (padzero(elf_bss)) {
+	if ((elf_bss != elf_brk) && padzero(elf_bss)) {
 		send_sig(SIGSEGV, current, 0);
 		retval = -EFAULT; /* Nobody gets to see this, but.. */
 		goto out_free_dentry;

--Boundary-00=_BlkRDtrIWuSzQLh
Content-Type: application/x-tbz;
  name="testcase.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="testcase.tar.bz2"

QlpoOTFBWSZTWYl95mIAG4z/////////////////////////////////////////////4CqbfHe9
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

--Boundary-00=_BlkRDtrIWuSzQLh--
