Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRCHKxC>; Thu, 8 Mar 2001 05:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131312AbRCHKww>; Thu, 8 Mar 2001 05:52:52 -0500
Received: from c617208-a.salem1.or.home.com ([24.20.70.203]:56380 "EHLO
	amidala") by vger.kernel.org with ESMTP id <S131311AbRCHKwh>;
	Thu, 8 Mar 2001 05:52:37 -0500
Date: Thu, 8 Mar 2001 02:53:02 -0800
From: Seth Arnold <sarnold@willamette.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1, 2.4.2 don't compile with new 'ld' interface on i386
Message-ID: <20010308025302.A8658@willamette.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings! :)

I was presented with the following error when attempting to compile
kernel 2.4.2 and 2.4.1:

[...]
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw] \)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
make[2]: Entering directory `/home/sarnold/Local/Linux.2.4.1/arch/i386/boot'
make[2]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
gcc -E -D__KERNEL__ -I/home/sarnold/Local/Linux.2.4.1/include -D__BIG_KERNEL__ -traditional -DSVGA_MODE=NORMAL_VGA  bootsect.S -o bbootsect.s
as -o bbootsect.o bbootsect.s
bbootsect.s: Assembler messages:
bbootsect.s:253: Warning: indirect lcall without `*'
ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
ld: cannot open binary: No such file or directory
make[2]: *** [bbootsect] Error 1
make[2]: Leaving directory `/home/sarnold/Local/Linux.2.4.1/arch/i386/boot'
make[1]: *** [bzImage] Error 2
make[1]: Leaving directory `/home/sarnold/Local/Linux.2.4.1'
make: *** [stamp-build] Error 2

Debian bug report #87037 [0] gives many details on the situation.
Upstream for 'ld' has changed -oformat to --oformat. I am probably not
the only person to try compiling the kernel with a new ld (and I
understand older versions of 'ld' support --oformat) so if 2.4.3 could
incorporate the following patch I have created (and tested *only on my
one single machine*) then many people will be spared the trouble I went
through. (Well, not that bad. :)

(Noting that I renamed the original Makefile in arch/i386/boot/Makefile to
Makefile.orig before making the diff; it may not apply cleanly, but I
hope it is obvious ... chances are good other Makefiles will need to be
modified but this is one *I* ran into. It is an exercise to find any
others. :)


[0]: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=87037

-- 
Earthlink: The #1 provider of unsolicited bulk email to the Internet.

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

--- arch/i386/boot/Makefile.orig	Thu Mar  8 02:42:53 2001
+++ arch/i386/boot/Makefile	Thu Mar  8 02:43:04 2001
@@ -43,7 +43,7 @@
 	$(HOSTCC) $(HOSTCFLAGS) -o $@ $< -I$(TOPDIR)/include
 
 bootsect: bootsect.o
-	$(LD) -Ttext 0x0 -s -oformat binary -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -o $@ $<
 
 bootsect.o: bootsect.s
 	$(AS) -o $@ $<
@@ -52,7 +52,7 @@
 	$(CPP) $(CPPFLAGS) -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
 bbootsect: bbootsect.o
-	$(LD) -Ttext 0x0 -s -oformat binary $< -o $@
+	$(LD) -Ttext 0x0 -s --oformat binary $< -o $@
 
 bbootsect.o: bbootsect.s
 	$(AS) -o $@ $<
@@ -61,7 +61,7 @@
 	$(CPP) $(CPPFLAGS) -D__BIG_KERNEL__ -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
 setup: setup.o
-	$(LD) -Ttext 0x0 -s -oformat binary -e begtext -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -e begtext -o $@ $<
 
 setup.o: setup.s
 	$(AS) -o $@ $<
@@ -70,7 +70,7 @@
 	$(CPP) $(CPPFLAGS) -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
 bsetup: bsetup.o
-	$(LD) -Ttext 0x0 -s -oformat binary -e begtext -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -e begtext -o $@ $<
 
 bsetup.o: bsetup.s
 	$(AS) -o $@ $<

--vkogqOf2sHV7VnPd--
