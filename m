Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRKSHjO>; Mon, 19 Nov 2001 02:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273065AbRKSHiz>; Mon, 19 Nov 2001 02:38:55 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:38157 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S273261AbRKSHin>; Mon, 19 Nov 2001 02:38:43 -0500
Date: Mon, 19 Nov 2001 01:37:28 -0600
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [upatch] kernel build with 'make -r'
Message-ID: <20011119013728.G1188@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel makefiles are completely self-contained, so for a minor
speed boost we can use 'make -r -R' aka 'make --no-builtin-rules
--no-builtin-variables'.

However, due to an apparent bug in gmake 3.79.1 (possibly others),
'make -r' doesn't work if you use the '$*' variable in non-implicit
rules.  (The info page specifically warns against doing this.)  The
symptom is that init/main.o doesn't build.

The following is correct, safe and IMHO more readable anyway:


--- 2.4.15pre6/Makefile~	Sun Nov 18 16:40:49 2001
+++ 2.4.15pre6/Makefile	Sun Nov 18 20:02:19 2001
@@ -333,7 +333,7 @@
 	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -c -o init/version.o init/version.c
 
 init/main.o: init/main.c include/config/MARKER
-	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -c -o $*.o $<
+	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -c -o $@ $<
 
 fs lib mm ipc kernel drivers net: dummy
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" $(subst $@, _dir_$@, $@)


These other patch hunks should be just as safe and correct, but I don't
have the architectures to test them..

Peter


--- 2.4.15pre6/arch/cris/boot/rescue/Makefile~	Wed Oct 17 21:34:01 2001
+++ 2.4.15pre6/arch/cris/boot/rescue/Makefile	Sun Nov 18 20:36:43 2001
@@ -36,13 +36,13 @@
 	rm ktr.bin tmp2423 kimagerescue_tmp.bin
 
 head.o: head.S
-	$(CC) -D__ASSEMBLY__ -traditional -c $< -o $*.o
+	$(CC) -D__ASSEMBLY__ -traditional -c $< -o $@
 
 testrescue.o: testrescue.S
-	$(CC) -D__ASSEMBLY__ -traditional -c $< -o $*.o
+	$(CC) -D__ASSEMBLY__ -traditional -c $< -o $@
 
 kimagerescue.o: kimagerescue.S
-	$(CC) -D__ASSEMBLY__ -traditional -c $< -o $*.o
+	$(CC) -D__ASSEMBLY__ -traditional -c $< -o $@
 
 clean:
 	rm -f *.o *.bin
--- 2.4.15pre6/arch/sparc/kernel/Makefile~	Mon Jan 29 20:49:26 2001
+++ 2.4.15pre6/arch/sparc/kernel/Makefile	Sun Nov 18 20:36:43 2001
@@ -38,7 +38,7 @@
 endif
 
 head.o: head.S
-	$(CC) $(AFLAGS) -ansi -c $*.S -o $*.o
+	$(CC) $(AFLAGS) -ansi -c $< -o $@
 
 check_asm: dummy
 	@if [ ! -r $(HPATH)/asm/asm_offsets.h ] ; then \
--- 2.4.15pre6/arch/sparc64/kernel/Makefile~	Mon Jun 11 02:47:26 2001
+++ 2.4.15pre6/arch/sparc64/kernel/Makefile	Sun Nov 18 20:36:43 2001
@@ -43,7 +43,7 @@
 
 head.o: head.S ttable.S itlb_base.S dtlb_base.S dtlb_backend.S dtlb_prot.S \
 	etrap.S rtrap.S winfixup.S entry.S
-	$(CC) $(AFLAGS) -ansi -c $*.S -o $*.o
+	$(CC) $(AFLAGS) -ansi -c $< -o $@
 
 #
 # This is just to get the dependencies...
