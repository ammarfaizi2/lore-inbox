Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280748AbRKOJxS>; Thu, 15 Nov 2001 04:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280788AbRKOJxI>; Thu, 15 Nov 2001 04:53:08 -0500
Received: from shell7.ba.best.com ([206.184.139.138]:46610 "EHLO
	shell7.ba.best.com") by vger.kernel.org with ESMTP
	id <S280748AbRKOJxC>; Thu, 15 Nov 2001 04:53:02 -0500
Date: Thu, 15 Nov 2001 01:52:30 -0800
From: Nathan Myers <ncm@nospam.cantrip.org>
To: linux-kernel@vger.kernel.org
Subject: Bad cpu_data macro in include/asm-*/processor.h
Message-ID: <20011115015230.A9599@shell7.ba.best.com>
Reply-To: ncm@nospam.cantrip.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In building 2.4.15-pre4 for non-SMP, I get a compile error at
kernel/i386/setup.c, line 2791.  This is traceable to 
include/asm-{i386,mips}/processor.h, the line

  #define cpu_data &boot_cpu_data

has a very stupid non-syntactic macro.  (This is line 54 in the mips 
header, 79 in the x86 header.) The minimal fix is obvious:

  #define cpu_data (&boot_cpu_data)

What stinky code, anyhow.  Why not make it a one-element array
to begin with?

I grepped for other similar macros with

  grep -n '#define[         ][      ]*[a-zA-Z_][a-zA-Z_0-9]*[       ][      ]*[^-A-Za-z0-9_\\{"(    ]' */*.h */*/*.h | less

and found more (mostly involving unary operator~) in 

  asm-m68k/bvme*.h
  asm-mips/asm.h,
  asm-mips64/asm.h
  asm-ppc/io.h
  asm-arm/arch-l7200/aug_reg.h
  linux/pci.h
  linux/ps2esdi.h
  net/irda/nsc-ircc.h
  net/irda/w83977af_ir.h

If you check for things like 
  #define FOO -1
which should be 
  #define FOO (-1)
you find zillions more.

Feh.

Nathan Myers
ncm@nospam.cantrip.org
