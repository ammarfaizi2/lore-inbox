Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVHNKui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVHNKui (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 06:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVHNKui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 06:50:38 -0400
Received: from main.gmane.org ([80.91.229.2]:24255 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932484AbVHNKui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 06:50:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Schiefer <cheaterjs@gmx.de>
Subject: Wired linker problem...
Date: Sun, 14 Aug 2005 12:36:42 +0200
Message-ID: <ddn6oa$gl2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: port-195-158-172-119.dynamic.qsc.de
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: de-DE, de, en-us, en
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is not linux kernel related, but at least it's kernel releated.
So I think u're the experts, that can help me. :)



I'm coding a little kernel in C and ASM and I use only GCC + NASM for
coding. GRUB loads my little kernel.
Everything goes well, but there is one really wired problem with ld,
which I use for linking the stuff...

My kernel is about 8kb big and loads well with GRUB. But when I exceed a
specific amount of code the size of my kernel goes up from 8kb to 1 MB
and GRUB won't load it anymore.
It says, it won't recognize the file format anymore. So I think it
doesn't finds the GRUB boot sigmature ( in entry.asm ) anymore.

I use following command for linking: ld -T link.ld -o kernel.bin entry.o
main.o display.o memory.o string.o io.o gdt.o gdt_helper.o

The linker script link.ld:

OUTPUT_FORMAT("binary")
ENTRY(start)
phys = 0x00100000;
SECTIONS
{
  .text phys : AT(phys) {
    code = .;
    *(.text)
    . = ALIGN(4096);
  }
  .data : AT(phys + (data - code))
  {
    data = .;
    *(.data)
    . = ALIGN(4096);
  }
  .bss : AT(phys + (bss - code))
  {
    bss = .;
    *(.bss)
    . = ALIGN(4096);
  }
  end = .;
}

My start code in entry.asm:

[BITS 32]
global start

start:
	mov esp, _sys_stack     ; This points the stack to our new stack area
	jmp stublet

; This part MUST be 4byte aligned, so we solve that issue using 'ALIGN 4'
ALIGN 4
mboot:
    ; Multiboot macros to make a few lines later more readable
    MULTIBOOT_PAGE_ALIGN	equ 1<<0
    MULTIBOOT_MEMORY_INFO	equ 1<<1
    MULTIBOOT_AOUT_KLUDGE	equ 1<<16
    MULTIBOOT_HEADER_MAGIC	equ 0x1BADB002
    MULTIBOOT_HEADER_FLAGS	equ MULTIBOOT_PAGE_ALIGN |
MULTIBOOT_MEMORY_INFO | MULTIBOOT_AOUT_KLUDGE
    MULTIBOOT_CHECKSUM	equ -(MULTIBOOT_HEADER_MAGIC +
MULTIBOOT_HEADER_FLAGS)
    EXTERN code, bss, end

    ; This is the GRUB Multiboot header. A boot signature
    dd MULTIBOOT_HEADER_MAGIC
    dd MULTIBOOT_HEADER_FLAGS
    dd MULTIBOOT_CHECKSUM

    ; AOUT kludge - must be physical addresses. Make a note of these:
    ; The linker script fills in the data for these ones!
    dd mboot
    dd code
    dd bss
    dd end
    dd start

stublet:
	extern k_main
	call k_main
	jmp $

; Here is the definition of our BSS section. Right now, we'll use
; it just to store the stack. Remember that a stack actually grows
; downwards, so we declare the size of the data before declaring
; the identifier '_sys_stack'
SECTION .bss
    resb 8192               ; This reserves 8KBytes of memory here
_sys_stack


I think the problem lies in the liker script, but I'm unable to find it
myself... *sniff* :(

Greetings,
Jan Schiefer!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC/x66zC00UKXFdVcRAhvNAJ9uQ5UOT4wvKk5kKWAdfHE4ZXc8fwCfc4cB
drqR27xFcBEhXNReznruMJo=
=DCVJ
-----END PGP SIGNATURE-----

