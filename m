Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266230AbUAQXoG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 18:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUAQXoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 18:44:06 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:35338 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266230AbUAQXnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 18:43:31 -0500
Date: 18 Jan 2004 02:43:25 +0300
Message-Id: <87brp23zvm.fsf@mtu-net.ru>
From: serge <33554432@mtu-net.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.6.1] oops in load_elf_binary()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This small (91 byte) program produces lots of output:
(look at p_memsz field in program header)

------------------------------------------------------------------------------
;; -*- mode: text; compile-command: "nasm -f bin true.asm; chmod +x true" -*-
;; @GPL_HEADER@

		bits	32
		org	0x00000000
  
  ehdr:					; Elf32_Ehdr
		db	0x7F, "ELF"	;   e_ident	[ELFMAG]
		db	1		;		[ELFCLASS32]
		db	1		;		[ELFDATA2LSB]
		db	1		;		[EV_CURRENT]
		db	3		;		[ELFOSABI_LINUX]
		db	0		;   		(abi version)
    times 7	db	0		;   		(padding)
		dw	2		;   e_type	[ET_EXEC]
		dw	3		;   e_machine	[EM_386]
		dd	1		;   e_version	[EV_CURRENT]
		dd	_start		;   e_entry
		dd	phdr - $$	;   e_phoff
		dd	0		;   e_shoff
		dd	0		;   e_flags
		dw	ehdrsize	;   e_ehsize
		dw	phdrsize	;   e_phentsize
		dw	1		;   e_phnum
		dw	0		;   e_shentsize
		dw	0		;   e_shnum
		dw	0		;   e_shstrndx
  
  ehdrsize	equ	$ - ehdr
  
  phdr:					; Elf32_Phdr
		dd	1		;   p_type	[PT_LOAD]
		dd	0		;   p_offset
		dd	$$		;   p_vaddr
		dd	0		;   p_paddr	(ignored)
		dd	filesize	;   p_filesz
;		dd	filesize	;   p_memsz
		dd	0x50000000	;   p_memsz <-- *** WARNING HERE ***
		dd	7		;   p_flags	[PF_X|PF_R|PF_W]
		dd	0x1000		;   p_align	[ELF_EXEC_PAGESIZE]

  
  phdrsize	equ	$ - phdr
  
  _start:
		xor	eax, eax
		inc	eax		; __NR_exit
		xor	ebx, ebx
		int	0x80		; sys_exit

  filesize	equ	$ - $$

;; file true.asm ends here
------------------------------------------------------------------------------

The output is:

------------------------------------------------------------------------------
Unable to handle kernel paging request at virtual address ffffffe4
 printing eip:
c017d978
*pde = 00002067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c017d978>]    Not tainted
EFLAGS: 00010297
EIP is at eventpoll_release_file+0x38/0xa0
eax: 464c457f   ebx: 00000000   ecx: ffffffc8   edx: 03010101
esi: 00000000   edi: 00000078   ebp: c04b3e70   esp: cbf05cb0
ds: 007b   es: 007b   ss: 0068
Process true (pid: 721, threadinfo=cbf04000 task=cfd45320)
Stack: 00000002 fffffff4 00000000 cfde7fc0 00000000 00000000 c0158f47 00000000 
       0000007b 00000000 fffffff4 cfde7fc0 00000000 cbf05e54 c0180244 00000009 
       00000000 cfd45320 00000007 00001812 cbf05e54 00000080 cbf05d2c cfde7fa0 
Call Trace:
 [<c0158f47>] __fput+0x117/0x120
 [<c0180244>] load_elf_binary+0x6f4/0xc20
 [<c013f21c>] buffered_rmqueue+0xdc/0x1c0
 [<c013f3a6>] __alloc_pages+0xa6/0x320
 [<c0162b84>] copy_strings+0x194/0x220
 [<c017fb50>] load_elf_binary+0x0/0xc20
 [<c0163ebf>] search_binary_handler+0x17f/0x2b0
 [<c01641b2>] do_execve+0x1c2/0x230
 [<c0107c52>] sys_execve+0x42/0x80
 [<c01093c9>] sysenter_past_esp+0x52/0x71

Code: 8b 59 1c 89 50 04 89 02 c7 46 04 00 02 20 00 c7 06 00 01 10 

------------------------------------------------------------------------------

If p_flags is 5 (PF_X|PF_R) then oops is slightly different:

------------------------------------------------------------------------------
Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c0158e12
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0158e12>]    Not tainted
EFLAGS: 00010246
EIP is at fput+0x2/0x20
eax: 00000000   ebx: fffffff4   ecx: cb377938   edx: 00000000
esi: cfde7d20   edi: 00000000   ebp: caf4fe54   esp: caf4fce8
ds: 007b   es: 007b   ss: 0068
Process true (pid: 684, threadinfo=caf4e000 task=cf21ad40)
Stack: c0180244 00000009 00000000 cf21ad40 00000005 00001812 caf4fe54 00000080 
       caf4fd2c cfde7d00 00000000 0000005b 00000000 0000005b 00000000 00000000 
       00000001 00000003 50000000 0000005b 00000001 00000000 00000000 00000001 
Call Trace:
 [<c0180244>] load_elf_binary+0x6f4/0xc20
 [<c013f21c>] buffered_rmqueue+0xdc/0x1c0
 [<c013f3a6>] __alloc_pages+0xa6/0x320
 [<c0162b84>] copy_strings+0x194/0x220
 [<c017fb50>] load_elf_binary+0x0/0xc20
 [<c0163ebf>] search_binary_handler+0x17f/0x2b0
 [<c01641b2>] do_execve+0x1c2/0x230
 [<c0107c52>] sys_execve+0x42/0x80
 [<c01093c9>] sysenter_past_esp+0x52/0x71

Code: ff 48 14 0f 94 c0 84 c0 75 04 90 c3 89 f6 89 d0 e9 09 00 00 
 
------------------------------------------------------------------------------

$ dmesg | head -n 1
Linux version  (ssb@metahost) (gcc version 3.3.3 20040101 (prerelease)) #27 Fri Jan 9 17:19
:20 MSK 2004
$

------------------------------------------------------------------------------

Looks like load_elf_binary() doesn't check value returned by do_mmap, but I am
unable to find where.

PS: Why I cannot map region larger than 256MB in one mmap call?

