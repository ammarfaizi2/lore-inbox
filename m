Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268272AbRGZQRf>; Thu, 26 Jul 2001 12:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268296AbRGZQR1>; Thu, 26 Jul 2001 12:17:27 -0400
Received: from moline.gci.com ([205.140.80.106]:57873 "EHLO moline.gci.com")
	by vger.kernel.org with ESMTP id <S268272AbRGZQRP>;
	Thu, 26 Jul 2001 12:17:15 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA315053E12AA@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Andreas Schwab <schwab@suse.de>, Thorsten Kukuk <kukuk@suse.de>,
        "David S. Miller" <davem@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Sparc-64 kernel build fails on version.h during 'make oldconf
	ig'
Date: Thu, 26 Jul 2001 08:17:11 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C115EE.6C850060"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C115EE.6C850060
Content-Type: text/plain;
	charset="iso-8859-15"

Andreas Schwab <schwab@suse.de> responded to:
> Thorsten Kukuk <kukuk@suse.de> who writes:
> 
> |> No, I send you and on the sparclinux list already a patch for 
> |> this 2 weeks ago. The problem is, that make dep will build at
> |> first sparc specific programs (archdep) which needs linux/version.h,
> |> but make dep does create linux/version.h only after building 
> |> this tools. The following patch solved the problem for me:
> |> 
> |> --- linux/Makefile
> |> +++ linux/Makefile      2001/05/21 12:57:07
> |> @@ -440,7 +440,7 @@
> |>  sums:
> |>         find . -type f -print | sort | xargs sum > .SUMS
> |>  
> |> -dep-files: scripts/mkdep archdep include/linux/version.h
> |> +dep-files: include/linux/version.h scripts/mkdep archdep
> 
> This will still fail with parallel builds.  Better make the 
> dependency of archdep on version.h explicit.

Hmm.. didn't think about SMP, as I'm only UP right now.

The enclosed patch then should cover all the architectures
for the stock 2.4.7 kernel.

I tried to find the cleanest place to put the dependancy,
which was usually on the archdep: target, but in the case
of sparc builds, it was on the check-asm: target.

In either case, i'm now building correctly for both i386 and sparc64
for make -j2 dep.  I can also break out of the archdep tools build
and find version.h built, so unless anybody has any major gripes, this
patch should find it's way to the general release, yes?

Alan?


------_=_NextPart_000_01C115EE.6C850060
Content-Type: application/octet-stream;
	name="makefiles.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="makefiles.diff"

diff -ru linux/arch/alpha/Makefile linux-2.4.7/arch/alpha/Makefile=0A=
--- linux/arch/alpha/Makefile	Sun Dec  3 16:45:20 2000=0A=
+++ linux-2.4.7/arch/alpha/Makefile	Thu Jul 26 08:03:47 2001=0A=
@@ -121,7 +121,7 @@=0A=
 =0A=
 archmrproper:=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
 	@$(MAKEBOOT) dep=0A=
 =0A=
 vmlinux: arch/alpha/vmlinux.lds=0A=
diff -ru linux/arch/arm/Makefile linux-2.4.7/arch/arm/Makefile=0A=
--- linux/arch/arm/Makefile	Wed Jun 27 13:12:04 2001=0A=
+++ linux-2.4.7/arch/arm/Makefile	Thu Jul 26 08:03:55 2001=0A=
@@ -207,7 +207,7 @@=0A=
 archclean:=0A=
 	@$(MAKEBOOT) clean=0A=
 =0A=
-archdep: scripts/mkdep archsymlinks=0A=
+archdep: scripts/mkdep archsymlinks include/linux/version.h=0A=
 	@$(MAKETOOLS) dep=0A=
 	@$(MAKEBOOT) dep=0A=
 =0A=
diff -ru linux/arch/cris/Makefile linux-2.4.7/arch/cris/Makefile=0A=
--- linux/arch/cris/Makefile	Wed Jul  4 10:50:38 2001=0A=
+++ linux-2.4.7/arch/cris/Makefile	Thu Jul 26 08:03:47 2001=0A=
@@ -105,5 +105,5 @@=0A=
 =0A=
 archmrproper:=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
 	@$(MAKEBOOT) dep=0A=
diff -ru linux/arch/i386/Makefile linux-2.4.7/arch/i386/Makefile=0A=
--- linux/arch/i386/Makefile	Thu Apr 12 11:20:31 2001=0A=
+++ linux-2.4.7/arch/i386/Makefile	Thu Jul 26 08:03:54 2001=0A=
@@ -143,5 +143,5 @@=0A=
 =0A=
 archmrproper:=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
 	@$(MAKEBOOT) dep=0A=
diff -ru linux/arch/ia64/Makefile linux-2.4.7/arch/ia64/Makefile=0A=
--- linux/arch/ia64/Makefile	Thu Apr  5 11:51:46 2001=0A=
+++ linux-2.4.7/arch/ia64/Makefile	Thu Jul 26 08:03:46 2001=0A=
@@ -131,7 +131,7 @@=0A=
 	rm -f arch/$(ARCH)/vmlinux.lds=0A=
 	@$(MAKE) -C arch/$(ARCH)/tools mrproper=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
 	@$(MAKEBOOT) dep=0A=
 =0A=
 bootpfile:=0A=
diff -ru linux/arch/m68k/Makefile linux-2.4.7/arch/m68k/Makefile=0A=
--- linux/arch/m68k/Makefile	Mon Jun 11 18:15:27 2001=0A=
+++ linux-2.4.7/arch/m68k/Makefile	Thu Jul 26 08:03:53 2001=0A=
@@ -173,4 +173,4 @@=0A=
 =0A=
 archmrproper:=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
diff -ru linux/arch/mips/Makefile linux-2.4.7/arch/mips/Makefile=0A=
--- linux/arch/mips/Makefile	Mon Jul  2 12:56:40 2001=0A=
+++ linux-2.4.7/arch/mips/Makefile	Thu Jul 26 08:03:43 2001=0A=
@@ -292,7 +292,7 @@=0A=
 	@$(MAKEBOOT) mrproper=0A=
 	$(MAKE) -C arch/$(ARCH)/tools mrproper=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
 	if [ ! -f $(TOPDIR)/include/asm-$(ARCH)/offset.h ]; then \=0A=
 	 touch $(TOPDIR)/include/asm-$(ARCH)/offset.h; \=0A=
 	fi;=0A=
diff -ru linux/arch/mips64/Makefile linux-2.4.7/arch/mips64/Makefile=0A=
--- linux/arch/mips64/Makefile	Wed Jul  4 10:50:38 2001=0A=
+++ linux-2.4.7/arch/mips64/Makefile	Thu Jul 26 08:03:53 2001=0A=
@@ -165,7 +165,7 @@=0A=
 	@$(MAKEBOOT) mrproper=0A=
 	$(MAKE) -C arch/$(ARCH)/tools mrproper=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
 	if [ ! -f $(TOPDIR)/include/asm-$(ARCH)/offset.h ]; then \=0A=
 	 touch $(TOPDIR)/include/asm-$(ARCH)/offset.h; \=0A=
 	fi;=0A=
diff -ru linux/arch/parisc/Makefile linux-2.4.7/arch/parisc/Makefile=0A=
--- linux/arch/parisc/Makefile	Tue Dec  5 11:29:39 2000=0A=
+++ linux-2.4.7/arch/parisc/Makefile	Thu Jul 26 08:03:42 2001=0A=
@@ -88,4 +88,4 @@=0A=
 =0A=
 archmrproper:=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
diff -ru linux/arch/ppc/Makefile linux-2.4.7/arch/ppc/Makefile=0A=
--- linux/arch/ppc/Makefile	Wed Jul 18 06:14:01 2001=0A=
+++ linux-2.4.7/arch/ppc/Makefile	Thu Jul 26 08:03:52 2001=0A=
@@ -99,5 +99,5 @@=0A=
 =0A=
 archmrproper:=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
 	$(MAKEBOOT) fastdep=0A=
diff -ru linux/arch/s390/Makefile linux-2.4.7/arch/s390/Makefile=0A=
--- linux/arch/s390/Makefile	Wed Apr 11 18:02:27 2001=0A=
+++ linux-2.4.7/arch/s390/Makefile	Thu Jul 26 08:03:41 2001=0A=
@@ -69,5 +69,5 @@=0A=
 =0A=
 archmrproper:=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
 	@$(MAKEBOOT) dep=0A=
diff -ru linux/arch/s390x/Makefile linux-2.4.7/arch/s390x/Makefile=0A=
--- linux/arch/s390x/Makefile	Tue Feb 13 13:13:44 2001=0A=
+++ linux-2.4.7/arch/s390x/Makefile	Thu Jul 26 08:03:51 2001=0A=
@@ -66,5 +66,5 @@=0A=
 =0A=
 archmrproper:=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
 	@$(MAKEBOOT) dep=0A=
diff -ru linux/arch/sh/Makefile linux-2.4.7/arch/sh/Makefile=0A=
--- linux/arch/sh/Makefile	Fri Dec 29 13:07:20 2000=0A=
+++ linux-2.4.7/arch/sh/Makefile	Thu Jul 26 08:03:56 2001=0A=
@@ -98,5 +98,5 @@=0A=
 archmrproper:=0A=
 	rm -f arch/sh/vmlinux.lds=0A=
 =0A=
-archdep:=0A=
+archdep: include/linux/version.h=0A=
 	@$(MAKEBOOT) dep=0A=
diff -ru linux/arch/sparc/Makefile linux-2.4.7/arch/sparc/Makefile=0A=
--- linux/arch/sparc/Makefile	Fri Dec 29 13:07:20 2000=0A=
+++ linux-2.4.7/arch/sparc/Makefile	Thu Jul 26 08:03:51 2001=0A=
@@ -60,7 +60,7 @@=0A=
 =0A=
 archdep: check_asm=0A=
 =0A=
-check_asm:=0A=
+check_asm: include/linux/version.h=0A=
 	$(MAKE) -C arch/sparc/kernel check_asm=0A=
 =0A=
 tftpboot.img:=0A=
diff -ru linux/arch/sparc64/Makefile =
linux-2.4.7/arch/sparc64/Makefile=0A=
--- linux/arch/sparc64/Makefile	Fri Dec 29 13:07:21 2000=0A=
+++ linux-2.4.7/arch/sparc64/Makefile	Thu Jul 26 07:58:36 2001=0A=
@@ -98,7 +98,7 @@=0A=
 =0A=
 archdep: check_asm=0A=
 =0A=
-check_asm:=0A=
+check_asm: include/linux/version.h=0A=
 	$(MAKE) -C arch/sparc64/kernel check_asm=0A=
 =0A=
 tftpboot.img:=0A=

------_=_NextPart_000_01C115EE.6C850060--
