Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUFQSep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUFQSep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUFQSep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:34:45 -0400
Received: from S01060007e97748c4.vn.shawcable.net ([24.86.2.57]:23709 "EHLO
	qworks.ca") by vger.kernel.org with ESMTP id S261426AbUFQSeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:34:22 -0400
Date: Thu, 17 Jun 2004 11:30:31 -0700
From: Chris Jones <cjones@sutus.com>
To: linux-kernel@vger.kernel.org
Subject: Problems during assembly of Kernel Module.
Message-ID: <20040617183031.GA6981@qworks.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rand: 11996
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all;

After quite some effort investigation and discussion on the crossgcc
mailing group.

I decided to bring my problem here.

I am trying to compile a kernel module for a mips32 chip.

I am having problems with the <asm/uaccess.h> (asm-mips/uaccess) inline 
assembly routines for both get_user() and put_user().

Both of these generate inline assembly. In specific a line:

   j    2b

My mips compiler does not like this very much and complains loudly:

   /tmp/ccw6NzZv.s: Assembler messages:
   /tmp/ccw6NzZv.s:128: Error: Cannot branch to symbol in another
   section.


This program seems to compile FINE on x86 since the x86 assembly seems
to have been re-written and put in arch/i386/lib/getuser.S and the
functions __get_user() in <asm-x86/uaccess.h> seems to be obsolete.

I have included a sample module using one of these calls to demonstrate
the problem. I have tried several different cross-compilers and one
native mips compiler all giving the same complaint on the "j  2b"
instruction.

I am definitely NOT a kernel module expert, but have done my best to
track down the problem and give a sample program.

Any help would be much appreciated.

Cheers,

      -=chris

x86 -> x86:
-------------
gcc -I/location_of_my_kernel_includes -DMODULE -D__KERNEL__ -c
moduletest.c

x86 -> mips:
-------------
mipsel-unknown-linux-gnu-gcc -I/location_of_my_kernel_includes -DMODULE
-D__KERNEL__ -mips32 -c moduletest.c

mips -> mips:
-------------
gcc -I/location_of_my_kernel_inclues -mips32  -DMODULE -D__KERNEL__ -c
moduletest.c


#include <linux/kernel.h>
#include <linux/module.h>


#include <linux/ppp_channel.h>


int init_module() {
      int j=1;
      unsigned long data;
      int foo = 1024;
      data = &foo;
      //OFFENDING k_call -> get_user() : See <asm/uaccess.h>
      // Generates "j 2b" assembly
      get_user(j,(int *)data);
      return 0;
}

void cleanup_module() {
}

-- 
                  Chris Jones | Software Developer | Sutus, Inc.
                 t: +1.604.987.8866 x 2204 | e: cjones@sutus.com
