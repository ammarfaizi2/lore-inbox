Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131692AbQKUXD4>; Tue, 21 Nov 2000 18:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131689AbQKUXDg>; Tue, 21 Nov 2000 18:03:36 -0500
Received: from ppp12-pool1c.bham.zebra.net ([209.12.6.203]:14208 "HELO
	bliss.penguinpowered.com") by vger.kernel.org with SMTP
	id <S131688AbQKUXDf>; Tue, 21 Nov 2000 18:03:35 -0500
Date: Tue, 21 Nov 2000 16:26:09 -0600
From: "Forever shall I be." <zinx@microsoftisevil.com>
To: linux-kernel@vger.kernel.org
Subject: page 0 mapped memory in ELF binaries
Message-ID: <20001121162608.A1539@bliss.zebra.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-GPG-Fingerprint: 5746 73A1 2184 A27A 9EC0  EDCC E132 BCEF 921B 1558
X-PGP-Fingerprint: 1F 16 36 AF 28 80 62 20  05 18 A0 AF 47 95 0B 0E
X-GPG-Public-Key: http://pgp5.ai.mit.edu:11371/pks/lookup?op=get&search=0x921B1558
X-PGP-Public-Key: http://pgp5.ai.mit.edu:11371/pks/lookup?op=get&search=0xEB936011
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, I'm sure this isn't any sort of show stopper for the 2.4.0 series
(or any other series for that matter, and they probably all have it),
but when mapping memory to page 0 in the program header of an ELF,
linux completely ignores the ph_memsz field.. I've attached a program
to demonstrate.. nasm is needed for compilation... (nasm is available
at http://www.cryogen.com/Nasm/)

Just so you know, what I want to do is have x bytes at 0x0, when
only y bytes are in the file, and y will almost always be less than x..

And yes, this is a little odd, but I really want to do it ;)

-- 
Zinx Verituse                        (See headers for gpg/pgp key info)
--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="zeromap.asm"


BITS 32

;; Compile with: nasm -f bin zeromap.asm -o zeromap
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set this to size you want mapped, and that much will get mapped.  This is
;; the ph_filesz field, the ph_memsz is already at 4096*2, but Linux seems to
;; completely ignore that when it's mapping to 0x0
%define ZERO_MAPPED_FILE_SIZE 0

;; You'll want to set this if you set the above, else you'll get bus errors,
;; due to the file not actually being as big as you told the kernel it was.
;; Note that I don't want a bigger file, just a bigger amount of memory.
%define PADDING 0

;; Define this if you want it to just loop over and over, so you can,
;; say, type "cat /proc/`pidof zeromap`/maps" and get a picture of
;; what all is happening ;)
%define INFINITE_LOOP 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;
;; Elf Header
ORG 0x8048000
elf_header:
.e_ident:		db	0x7f, "ELF"
.e_ident_class:		db	1		;ELFCLASS32
.e_ident_encoding:	db	1		;ELFDATA2LSB
.e_ident_version:	db	1		;EV_CURRENT
.e_ident_padding:	db	0, 0, 0, 0, 0, 0, 0, 0, 0

.e_type:		dw	2		;ET_EXEC
.e_machine:		dw	3		;EM_386
.e_version:		dd	1		;EV_CURRENT
.e_entry:		dd	main
.e_phoff:		dd	PROGRAM_HEADER
.e_shoff:		dd	0
.e_flags:		dd	0
.e_ehsize:		dw	elf_header_size
.e_phentsize:		dw	32
.e_phnum:		dw	3
.e_shentsize:		dw	0
.e_shnum:		dw	0
.e_shstrndx:		dw	0
elf_header_size equ $ - elf_header

;;;;;;;;;;;;;;;;;;;;
;; Program Header

PROGRAM_HEADER equ $-$$
program_header_1:
	.p_type:		dd	1		;PT_LOAD
	.p_offset:		dd	main - $$
	.p_vaddr:		dd	main
	.p_paddr:		dd	0
	.p_filesz:		dd	main_size
	.p_memsz:		dd	main_size
	.p_flags:		dd	1+2+4		;PF_X + PF_R + PF_W
	.p_align:		dd	4

; Linux 2.4.0-test10 (at least) doesn't like this one at all.
program_header_2:
	.p_type:		dd	1		;PT_LOAD
	.p_offset:		dd	nomem - $$
	.p_vaddr:		dd	0
	.p_paddr:		dd	0
	.p_filesz:		dd	ZERO_MAPPED_FILE_SIZE
	.p_memsz:		dd	4096*2		;PAGE_SIZE*2
	.p_flags:		dd	2+4		;PF_W + PF_R
	.p_align:		dd	4

; Yet, this one is fine... it's the exact same stuff, just mapped somewhere
; other than 0x0
program_header_3:
	.p_type:		dd	1		;PT_LOAD
	.p_offset:		dd	nomem - $$
	.p_vaddr:		dd	nomem
	.p_paddr:		dd	0
	.p_filesz:		dd	0
	.p_memsz:		dd	4096*2		;PAGE_SIZE*2
	.p_flags:		dd	2+4		;PF_W + PF_R
	.p_align:		dd	4

main:
	%if INFINITE_LOOP
	jmp $
	%endif

	mov ebp, nomem
	call try_access
	mov ebp, 0x0
	call try_access

	mov eax, 1		; __NR_exit
	xor ebx, ebx
	int 0x80		; exit(0);

try_access:
	call write_ebp_msg
	xor eax, eax
.loop:
	mov ecx, dword [ebp+eax*4]
	inc eax
	cmp eax, 0x2000
	jg .loop

	ret

write_ebp_msg:
	mov eax, ebp
	mov ebx, 16
	mov ecx, 8
.loop:
	xor edx, edx
	div ebx
	mov dl, [hex+edx]
	mov [msg_try_mapped.addr+ecx-1], dl
	loop .loop

	mov eax, 4		; __NR_write
	mov ebx, 2
	mov ecx, msg_try_mapped
	mov edx, msg_try_mapped.len
	int 0x80		; write(2, msg_try_mapped, strlen(msg_try_mapped));
	ret

; NOT REACHED
msg_try_mapped:	db "Accessing 4096*2 bytes of mapped(?) memory at 0x"
	.addr:	db "00000000"
		db 10
	.len	equ $-msg_try_mapped
hex:		db "0123456789abcdef"

main_size equ $-main

align 4096, db 0		; align to the page size
nomem:
times PADDING db 0

--OXfL5xGRrasGEqWY--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
