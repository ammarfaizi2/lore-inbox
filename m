Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262253AbSJNXQ4>; Mon, 14 Oct 2002 19:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSJNXQz>; Mon, 14 Oct 2002 19:16:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53513 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262253AbSJNXQx>; Mon, 14 Oct 2002 19:16:53 -0400
Date: Tue, 15 Oct 2002 00:22:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, kai.germaschewski@gmx.de
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.42 broke ARM zImage/Image
Message-ID: <20021015002243.F2902@flint.arm.linux.org.uk>
References: <20021012123256.C12955@flint.arm.linux.org.uk> <20021012233818.A9394@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021012233818.A9394@mars.ravnborg.org>; from sam@ravnborg.org on Sat, Oct 12, 2002 at 11:38:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam & Kai, lkml and others who join us on this happy day.

As well intentioned as your efforts are, and as patient as you are, I
don't believe we're going to solve this one with the way things now
stand in kbuild.

Everything appears to work correctly with Sam's latest patch.  However,
there is one fundamental problem that looks like it's impossible to
solve.  Here's the relevant fragment of Sam's patch:

===== arch/arm/boot/compressed/Makefile 1.10 vs edited =====
--- 1.10/arch/arm/boot/compressed/Makefile      Sun Oct 13 12:22:02 2002
+++ edited/arch/arm/boot/compressed/Makefile    Mon Oct 14 22:15:08 2002
@@ -65,35 +63,39 @@
 OBJS           += head-xscale.o
 endif
 
-SEDFLAGS       = s/TEXT_START/$(ZTEXTADDR)/;s/LOAD_ADDR/$(ZRELADDR)/;s/BSS_START/$(ZBSSADDR)/
+SEDFLAGS       = s/TEXT_START/$(ZTEXTADDR)/;s/LOAD_ADDR/$(ZRELADDR)/;\
+s/BSS_START/$(ZBSSADDR)/;s#OBJ#$(obj)#
 
-LIBGCC         := $(shell $(CC) $(CFLAGS) --print-libgcc-file-name)
+EXTRA_TARGETS := vmlinux piggy.o font.o head.o $(OBJS)
+EXTRA_CFLAGS  := $(CFLAGS_BOOT) -fpic
+EXTRA_AFLAGS  := -traditional
 
-all:           vmlinux
+include $(TOPDIR)/Rules.make
 
-vmlinux:       $(HEAD) $(OBJS) piggy.o vmlinux.lds
-               $(LD) $(ZLDFLAGS) $(HEAD) $(OBJS) piggy.o $(LIBGCC) -o vmlinux
+LDFLAGS_vmlinux := -p -X -T $(obj)/vmlinux.lds \
+       $(shell $(CC) $(CFLAGS) --print-libgcc-file-name)
 
-$(HEAD):       $(HEAD:.o=.S)
-               $(CC) $(AFLAGS) -traditional -c $(HEAD:.o=.S)
+$(obj)/vmlinux: $(obj)/$(HEAD) $(obj)/piggy.o $(obj)/vmlinux.lds \
+               $(addprefix $(obj)/, $(OBJS))
+       $(call if_changed,ld)

So we end up with the following to link the decompressor vmlinux:

LDFLAGS_vmlinux := -p -X -T $(obj)/vmlinux.lds \
        $(shell $(CC) $(CFLAGS) --print-libgcc-file-name)

$(obj)/vmlinux: $(obj)/$(HEAD) $(obj)/piggy.o $(obj)/vmlinux.lds \
                $(addprefix $(obj)/, $(OBJS))
        $(call if_changed,ld)

When linking vmlinux for the decompressor, we use the following linker
script:

OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
...
  .text : {
    input_data = .;
    arch/arm/boot/compressed/piggy.o
    input_data_end = .;
    . = ALIGN(4);
  }
...
}

which directs the linker to place arch/arm/boot/compressed/piggy.o
between two symbols, input_data and input_data_end.  However, in
practice, we actually get the following:

  ld   -p -X -T arch/arm/boot/compressed/vmlinux.lds
 /usr/lib/gcc-lib/armv4l-unknown-linux-gnu/2.95.3/libgcc.a
 arch/arm/boot/compressed/head.o arch/arm/boot/compressed/piggy.o
 arch/arm/boot/compressed/vmlinux.lds arch/arm/boot/compressed/misc.o
 arch/arm/boot/compressed/head-sa1100.o -o arch/arm/boot/compressed/vmlinux 

00082b5c t lbits
00082b60 t dbits
00082b9c t p.687
00082d80 T _binary_arch_arm_boot_compressed_piggy_gz_start
000c1713 A _binary_arch_arm_boot_compressed_piggy_gz_size
00144493 T _binary_arch_arm_boot_compressed_piggy_gz_end
00144494 T _start
00144494 T input_data
00144494 T input_data_end

Changing the path in the vmlinux.lds.in script makes the linker
correctly complain that the object isn't found, so it is using
it:

  ld   -p -X -T arch/arm/boot/compressed/vmlinux.lds
 /usr/lib/gcc-lib/armv4l-unknown-linux-gnu/2.95.3/libgcc.a
 arch/arm/boot/compressed/head.o arch/arm/boot/compressed/piggy.o
 arch/arm/boot/compressed/vmlinux.lds arch/arm/boot/compressed/misc.o
 arch/arm/boot/compressed/head-sa1100.o -o arch/arm/boot/compressed/vmlinux 

ld: cannot open piggy.o: No such file or directory

Removing the object from the linker command line, but leaving it
in the script results in the same object file layout - in other
words, the linker isn't doing what its being told:

  ld   -p -X -T arch/arm/boot/compressed/vmlinux.lds
 /usr/lib/gcc-lib/armv4l-unknown-linux-gnu/2.95.3/libgcc.a
 arch/arm/boot/compressed/head.o arch/arm/boot/compressed/vmlinux.lds
 arch/arm/boot/compressed/misc.o arch/arm/boot/compressed/head-sa1100.o
 -o arch/arm/boot/compressed/vmlinux 

00082b5c t lbits
00082b60 t dbits
00082b9c t p.687
00082d80 T _binary_arch_arm_boot_compressed_piggy_gz_start
000c1713 A _binary_arch_arm_boot_compressed_piggy_gz_size
00144493 T _binary_arch_arm_boot_compressed_piggy_gz_end
00144494 T _start
00144494 T input_data
00144494 T input_data_end


So I decided to see how x86 does it, and tried it on ARM:

  ld   -r -b binary --oformat elf32-littlearm -T
 arch/arm/boot/compressed/piggy.lds arch/arm/boot/compressed/piggy.gz
 -o arch/arm/boot/compressed/piggy.o 
  ld   -p -X -T arch/arm/boot/compressed/vmlinux.lds
 /usr/lib/gcc-lib/armv4l-unknown-linux-gnu/2.95.3/libgcc.a
 arch/arm/boot/compressed/head.o arch/arm/boot/compressed/piggy.o
 arch/arm/boot/compressed/vmlinux.lds arch/arm/boot/compressed/misc.o
 arch/arm/boot/compressed/head-sa1100.o -o arch/arm/boot/compressed/vmlinux 
ld: Error: arch/arm/boot/compressed/piggy.o uses hard floating point, whereas arch/arm/boot/compressed/vmlinux uses soft floating point
File format not recognized: failed to merge target specific data of file arch/arm/boot/compressed/piggy.o

So, basically, I'm screwed at the moment, unless someone has anything
else to suggest.

If there isn't anything else, I'm going to have to call for the
re-implementation of the make -C method that Kai originally had
in his patch.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
