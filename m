Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUDJMKf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 08:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUDJMKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 08:10:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12553 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262007AbUDJMKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 08:10:32 -0400
Date: Sat, 10 Apr 2004 13:10:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [RFC] Force build error on undefined symbols
Message-ID: <20040410131028.A4221@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've checked the date, and it isn't April Fools day.  I wish it was
though.

It appears that all binutils versions for ARM which are capable of
building 2.6 kernels which have been tested so far contain a serious
bug - it is possible to successfully link an object and still have
various symbols undefined.  Currently, these binutils have been
tested on ARM (as cross-compilers and/or native) and found wanting:

GNU assembler 2.13.90.0.18 20030206
GNU assembler 2.14 20030612
GNU assembler 2.14.90 20031229
GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux
Assembleur GNU 2.15.90.0.1 20040303

So far, we have discovered two cases:

1. When building a certain file, an undefined symbolic constant
   (TI_USED_CP) ended up in the symbol table without a relocation,
   and the value the assembler decided to use was '0'.  The effect
   of this is that we ended up setting bits in thread_info->flags.

   This appears to be a binutils "as" error.

2. When building the decompressor for ARM kernels, GCC appears to
   inexplicably emit ".global" directives for symbols not defined
   in the files being built, even though the symbols themselves are
   not actually used.  I'm not sure whether this is a real bug;
   binutils on x86 appears to accept and link such objects.

In both cases, the linker successfully created executable programs
which ran.  In the first case, it is a silent error; the kernel had
been linked, and able to run, but the program is not correct.

Obviously, the one true correct solution is to fix the toolchain and
upgrade to the latest version.  However, since we have potentially
multiple binutils versions spread across more than a year affected,
I think we need to detect such errors as well.

Therefore, I propose the following patch to detect undefined symbols
in the final image and force an error if this is the case.

Comments?

--- orig/Makefile	Sat Apr 10 12:31:36 2004
+++ linux/Makefile	Sat Apr 10 13:01:05 2004
@@ -502,7 +502,8 @@ define cmd_vmlinux__
 	$(net-y) \
 	--end-group \
 	$(filter .tmp_kallsyms%,$^) \
-	-o $@
+	-o $@; \
+	$(NM) $@ | egrep -q '^ +U ' && { echo "Link failed: undefined symbols found in final object."; $(NM) $@ | egrep '^ +U '; rm -f $@; exit 1; } || :
 endef
 
 #	set -e makes the rule exit immediately on error
--- orig/arch/arm/boot/compressed/Makefile	Sat Apr 10 12:31:36 2004
+++ linux/arch/arm/boot/compressed/Makefile	Sat Apr 10 13:01:13 2004
@@ -68,6 +68,7 @@ LDFLAGS_vmlinux := -p -X \
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.o \
 	 	$(addprefix $(obj)/, $(OBJS)) FORCE
 	$(call if_changed,ld)
+	@$(NM) $@ | egrep -q '^ +U ' && { echo "Link failed: undefined symbols found in final object."; $(NM) $@ | egrep '^ +U '; rm -f $@; exit 1; } || :
 	@:
 
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
