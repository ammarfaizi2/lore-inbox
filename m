Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262732AbTCTWqn>; Thu, 20 Mar 2003 17:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262749AbTCTWqD>; Thu, 20 Mar 2003 17:46:03 -0500
Received: from amdext2.amd.com ([163.181.251.1]:32736 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S262732AbTCTWpu>;
	Thu, 20 Mar 2003 17:45:50 -0500
X-Server-Uuid: 262C4BA7-64EE-471D-8B02-117625D613AB
Message-ID: <99F2150714F93F448942F9A9F112634CA54B2D@txexmtae.amd.com>
From: ravikumar.chakaravarthy@amd.com
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: RE: Loading and executing kernel from a non-standard address
 usin g SY SLINUX
Date: Thu, 20 Mar 2003 16:56:44 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 126498A4682674-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tweaked the SYSLINUX boot loader and kernel to load and execute the kernel from 0x200000 (physical address). However when I try to load the kernel using the SYSLINUX bootloader to an address 0xdf000000(physical address) it doesn't work!!
I want to know if the following should work.

1. Should the syslinux be able to copy to the address DI=(0xdf000000). I think bcopy  function in (SYSLINUX sources) does this.. Though the bcopy is done in the 32-bit mode, SOMETIMES it fails for this physical address). bcopy is called in runkernel.inc.
2. Will I have any problem in the setup.S code in arch/i386/boot or head.S in arch/i386/boot/compressed because of this copy to 0xdf000000?? At times when it gets past step 1, it fails in malloc in arch/i386/boot/compressed/misc.c. The error it gives in "Memory Error"


Following is a list of changes I made to the SYSLINUX and kernel code to get it working for 0x200000. 
---------------------------------------------------------------------
#Number preceded by ":" in the following lines represent the line number. I #am using 2.4.20 source
(Syslinux)
1. runkernel.inc: 
250: sub eax,0x200000
263: mov edi,0x200000

(linux kernel)
1. arch/i386/boot/setup.S
126: .long   0x200000      # 0x200000 = default for big kernel
813: code32: .long   0x2000                      # will be set to 0x200000

2. arch/i386/boot/compressed/head.S
102: movl $0x200000,%edi
127: ljmp $(__KERNEL_CS), $0xdf000000

3. arch/i386/boot/compressed/Makefile
19: BZIMAGE_OFFSET = 0x200000

4. arch/i386/vmlinux.lds
9: . = 0x01000000 + 0x200000;

5. arch/i386/kernel/setup.c
345: static struct resource code_resource = { "Kernel code", 0x200000, 0 };

6. arch/i386/kernel/head.S
ENTRY(swapper_pg_dir)
        .long 0x202007
        .long 0x203007
        .fill BOOT_USER_PGD_PTRS-2,4,0
        /* default: 766 entries */
        .long 0x202007
        .long 0x203007
        /* default: 254 entries */
        .fill BOOT_KERNEL_PGD_PTRS-2,4,0




Thanks in advance
  -Ravi

-----Original Message-----
From: H. Peter Anvin [mailto:hpa@zytor.com] 
Sent: Tuesday, March 04, 2003 5:00 PM
To: linux-kernel@vger.kernel.org
Subject: Re: Loading and executing kernel from a non-standard address using SY SLINUX

Followup to:  <99F2150714F93F448942F9A9F112634CA54B07@txexmtae.amd.com>
By author:    ravikumar.chakaravarthy@amd.com
In newsgroup: linux.dev.kernel
>
> I am trying to load and boot the kernel from a non-standard address
> (0x200000). I am using the SYSLINUX boot loader, which loads the
> kernel at that address. I have also made changes to the kernel to
> setup code and startup_32() function to effect the same. When I boot
> the system It says
> 

Modified, perhaps.  Stock SYSLINUX loads at the standard address
(0x100000).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

