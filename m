Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWJEEop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWJEEop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWJEEop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:44:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49568 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750811AbWJEEoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:44:44 -0400
Date: Wed, 4 Oct 2006 21:44:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-Id: <20061004214403.e7d9f23b.akpm@osdl.org>
In-Reply-To: <m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 22:06:27 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> > Seems that the entire kernel effort is an ongoing plot to make my poor
> > little Vaio stop working.  This patch turns it into a black-screened rock
> > as soon as it does grub -> linux.  Stock-standard FC5 install, config at
> > http://userweb.kernel.org/~akpm/config-sony.txt.
> 
> Ugh.  I just tested this with a grub 0.97-5 from what I assume is a
> standard FC5 install (I haven't touched it) and the kernel boots.
> I only have a 64bit user space on that machine so init doesn't
> start but I get the rest of the kernel messages.
> 
> There were several testers working at redhat so a pure redhat
> incompatibility would be a surprise.
> 
> I don't think the formula is a simple grub+bzImage == death.
> 
> There is something more subtle going on here.  
> 
> I'm not certain where to start looking.  Andrew it might help if we
> could get the dying binary just in case some weird compile or
> processing problem caused insanely unlikely things like the multiboot
> binary to show up in your grub install.  I don't think that is it,
> but it should allow us to rule out that possibility.

I tested it with Vivek's fix (below) and it still dies immediately.

The grub record is

title new (2.6.19-rc1)
        root (hd0,5)
        kernel /boot/bzImage-2.6.19-rc1 ro root=LABEL=/ rhgb vga=0x263
        initrd /boot/initrd-2.6.19-rc1.img

various binares are at http://userweb.kernel.org/~akpm/reloc/





 arch/i386/boot/bootsect.S |   42 +-----------------------------------
 1 files changed, 2 insertions(+), 40 deletions(-)

diff -puN arch/i386/boot/bootsect.S~i386-boot-add-an-elf-header-to-bzimage-fix arch/i386/boot/bootsect.S
--- a/arch/i386/boot/bootsect.S~i386-boot-add-an-elf-header-to-bzimage-fix
+++ a/arch/i386/boot/bootsect.S
@@ -17,7 +17,6 @@
 #include <linux/utsrelease.h>
 #include <linux/compile.h>
 #include <linux/elf.h>
-#include <linux/elf_boot.h>
 #include <asm/page.h>
 #include <asm/boot.h>
 
@@ -73,8 +72,8 @@ ehdr:
 	.int  0					# e_shoff
 	.int  0					# e_flags
 	.word e_ehdr - ehdr			# e_ehsize
-	.word e_phdr1 - phdr			# e_phentsize
-	.word (e_phdr - phdr)/(e_phdr1 - phdr)	# e_phnum
+	.word e_phdr - phdr			# e_phentsize
+	.word 1					# e_phnum
 	.word 40				# e_shentsize
 	.word 0					# e_shnum
 	.word 0					# e_shstrndx
@@ -95,45 +94,8 @@ phdr:
 	.int 0						# p_memsz
 	.int PF_R | PF_W | PF_X				# p_flags
 	.int CONFIG_PHYSICAL_ALIGN			# p_align
-e_phdr1:
-
-	.int PT_NOTE					# p_type
-	.int b_note - _start				# p_offset
-	.int 0						# p_vaddr
-	.int 0						# p_paddr
-	.int e_note - b_note				# p_filesz
-	.int 0						# p_memsz
-	.int 0						# p_flags
-	.int 0						# p_align
 e_phdr:
 
-.macro note name, type
-	.balign 4
-	.int	2f - 1f			# n_namesz
-	.int	4f - 3f			# n_descsz
-	.int	\type			# n_type
-	.balign 4
-1:	.asciz "\name"
-2:	.balign 4
-3:
-.endm
-.macro enote
-4:	.balign 4
-.endm
-
-	.balign 4
-b_note:
-	note ELF_NOTE_BOOT, EIN_PROGRAM_NAME
-		.asciz	"Linux"
-	enote
-	note ELF_NOTE_BOOT, EIN_PROGRAM_VERSION
-		.asciz	UTS_RELEASE
-	enote
-	note ELF_NOTE_BOOT, EIN_ARGUMENT_STYLE
-		.asciz	"Linux"
-	enote
-e_note:
-
 start2:
 	movw	%cs, %ax
 	movw	%ax, %ds
_

