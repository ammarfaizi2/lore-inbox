Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266101AbUGAQxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbUGAQxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUGAQxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:53:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39180 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266101AbUGAQwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:52:37 -0400
Date: Thu, 1 Jul 2004 17:52:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: binutils woes
Message-ID: <20040701175231.B8389@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On ARM, we appear to have somewhat of a problem with binutils.  At
least the following binutils suffer from a problem whereby it is
possible to create programs which contain undefined symbols:

GNU assembler 2.13.90.0.18 20030206
GNU assembler 2.14 20030612
GNU assembler 2.14.90 20031229
GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux
Assembleur GNU 2.15.90.0.1 20040303

We discovered this back in April, and at the time we thought that
adding --no-undefined to the linker command line would ensure that
we caught this bug.

However, this appears not to be the case.  I recently committed
this change:

  http://linux.bkbits.net:8080/linux-2.5/cset@1.1769.3.12??nav=index.html|ChangeSet@-4d

and tested it - it appeared to build fine, and nothing untoward.
However, as you can see from this patch:

  http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=1950/1

It appears that we are successfully build a kernel without the correct
value of SIZEOF_MACHINE_DESC - in fact, this constant appears to be
undefined in arch/arm/kernel/head.S.  Upon checking the build logs
and object files here, I have been able to confirm that this is
exactly what has happened.

Here is an example of the build output around the affected files:

...
  AS      arch/arm/kernel/debug.o
  LD      arch/arm/kernel/built-in.o
  AS      arch/arm/kernel/head.o
  CC      arch/arm/kernel/init_task.o
...
  CC      arch/arm/lib/udivdi3.o
  AR      arch/arm/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  OBJCOPY arch/arm/boot/Image
  Kernel: arch/arm/boot/Image is ready

As you can see - there is no indication of failure what so ever.
However, if we inspect the symbol information for vmlinux, we find:

[rmk@dyn-67 versatile]$ arm-linux-nm vmlinux | grep SIZEOF -2
c0008000 T _sinittext
c0060634 T si_swapinfo
         U SIZEOF_MACHINE_DESC
c013cb7c T sk_alloc
c014cc34 T sk_attach_filter

and further investigation of the disassembly indicates that the
assembler subsituted a value of zero for this constant.

Since ld --no-undefined does not catch this error, and this error
affects a range of binutils versions from 2.13 through to 2.15, I
don't think we can ignore the problem.

I think the only way we can ensure kernel correctness is to add a
subsequent stage to kbuild such that whenever we generate a final
program, we grep the 'nm' output for undefined symbols.

Comments?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
