Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbSL0WwA>; Fri, 27 Dec 2002 17:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265205AbSL0WwA>; Fri, 27 Dec 2002 17:52:00 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:35083 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265238AbSL0Wv5>;
	Fri, 27 Dec 2002 17:51:57 -0500
Date: Sat, 28 Dec 2002 00:00:12 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: kbuild/arm: archhelp + $(build)
Message-ID: <20021227230012.GA24310@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduced usage of archhelp for arm.
Introduced usage of $(build)

Please apply,
	Sam

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.960, 2002-12-27 23:32:51+01:00, sam@mars.ravnborg.org
  kbuild/arm: archhelp and $(build)
  
  Moved archhelp to arch/arm/Makefile
  Introduced usage of $(build) and $(clean)


 Makefile      |   34 +++++++++++++++++++++++-----------
 boot/Makefile |   15 ++-------------
 2 files changed, 25 insertions(+), 24 deletions(-)


diff -Nru a/arch/arm/Makefile b/arch/arm/Makefile
--- a/arch/arm/Makefile	Fri Dec 27 23:55:52 2002
+++ b/arch/arm/Makefile	Fri Dec 27 23:55:52 2002
@@ -139,7 +139,7 @@
 # Default target when executing plain make
 all: zImage
 
-makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/arm/boot $(1)
+boot := arch/arm/boot
 
 #	Update machine arch and proc symlinks if something which affects
 #	them changed.  We use .arch and .proc to indicate when they were
@@ -162,17 +162,17 @@
 .PHONY: maketools FORCE
 maketools: include/asm-arm/.arch include/asm-arm/.proc \
 	   include/asm-arm/constants.h include/linux/version.h FORCE
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/arm/tools include/asm-arm/mach-types.h
+	$(Q)$(MAKE) $(build)=arch/arm/tools include/asm-arm/mach-types.h
 
 # Convert bzImage to zImage
 bzImage: vmlinux
-	$(call makeboot,arch/arm/boot/zImage)
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/zImage
 
 zImage Image bootpImage: vmlinux
-	$(call makeboot,arch/arm/boot/$@)
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 zinstall install: vmlinux
-	$(call makeboot,$@)
+	$(Q)$(MAKE) $(build)=$(boot) $@
 
 MRPROPER_FILES	+= \
 	include/asm-arm/arch include/asm-arm/.arch \
@@ -183,14 +183,14 @@
 # We use MRPROPER_FILES and CLEAN_FILES now
 archmrproper:
 archclean:
-	$(Q)$(MAKE) -f scripts/Makefile.clean obj=arch/arm/boot
+	$(Q)$(MAKE) $(clean)=$(boot)
 
 # My testing targets (that short circuit a few dependencies)
-zImg:;	$(call makeboot, arch/arm/boot/zImage)
-Img:;	$(call makeboot, arch/arm/boot/Image)
-bp:;	$(call makeboot, arch/arm/boot/bootpImage)
-i:;	$(call makeboot, install)
-zi:;	$(call makeboot, zinstall)
+zImg:;	$(Q)$(MAKE) $(build)=$(boot) $(boot)/zImage
+Img:;	$(Q)$(MAKE) $(build)=$(boot) $(boot)/Image
+bp:;	$(Q)$(MAKE) $(build)=$(boot) $(boot)/bootpImage
+i:;	$(Q)$(MAKE) $(build)=$(boot) install
+zi:;	$(Q)$(MAKE) $(build)=$(boot) zinstall
 
 #
 # Configuration targets.  Use these to select a
@@ -216,3 +216,15 @@
 	@echo -n '  Generating $@'
 	@$(generate-asm-offsets.h) < $< > $@.tmp
 	@$(update-if-changed)
+
+define archhelp
+  echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
+  echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
+  echo  '  bootpImage    - Combined zImage and initial RAM disk' 
+  echo  '  initrd        - Create an initial image'
+  echo  '  install       - Install uncompressed kernel'
+  echo  '  zinstall      - Install compressed kernel'
+  echo  '                  Install using (your) ~/bin/installkernel or'
+  echo  '                  (distribution) /sbin/installkernel or'
+  echo  '                  install to $$(INSTALL_PATH) and run lilo'
+endef
diff -Nru a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
--- a/arch/arm/boot/Makefile	Fri Dec 27 23:55:52 2002
+++ b/arch/arm/boot/Makefile	Fri Dec 27 23:55:52 2002
@@ -84,10 +84,10 @@
 	@echo '  Kernel: $@ is ready'
 
 $(obj)/compressed/vmlinux: vmlinux FORCE
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/compressed $@
+	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/compressed $@
+	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
 .PHONY: initrd
 initrd:
@@ -108,14 +108,3 @@
 
 clean-files := $(addprefix $(obj)/,Image zImage bootpImage)
 subdir-	    := bootp compressed
-
-archhelp:
-	@echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
-	@echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
-	@echo  '  bootpImage    - Combined zImage and initial RAM disk' 
-	@echo  '  initrd        - Create an initial image'
-	@echo  '  install       - Install uncompressed kernel'
-	@echo  '  zinstall      - Install compressed kernel'
-	@echo  '                  Install using (your) ~/bin/installkernel or'
-	@echo  '                  (distribution) /sbin/installkernel or'
-	@echo  '                  install to $$(INSTALL_PATH) and run lilo'

===================================================================


This BitKeeper patch contains the following changesets:
1.960
## Wrapped with gzip_uu ##


begin 664 bkpatch24237
M'XL(`'C:##X``[U7_V_B-A3_N?XKGG1(P)T@MA,"86(JZYU6=.W6]:Z_39J<
MQ#0925S92;>KT/[V>TEH@+9`J;:%$(?X\WEY7_W,.[@Q4H]/C$C).SA7)A^?
MI$*;OA;WF:_T;1^_.'.M%,Y8D4JEA5C+Z,!*XJSXVUI(G<G$\A?6PB_B)"2(
MOA)Y$,&]U&9\POIV\R3_=B?')]>??KZYF%X3,IG`622R6_E%YC"9D%SI>Y&$
MYE3D4:*R?JY%9E*9BWZ@TF4#77)*.7X&;&C3@;MD+G6&RX"%C`F'R9!R9^0Z
M!-4\?6;*$RF,\R&G;.!X2^HX+B,?@?4]EP+E%N,6'P*WQS8?#]@'RL:4PHM"
MX0.''B4_P;]KP!D)H/:I)70Z!J&#*)+)'8@LA%:GFNDB!L]+=2_#-2!7U7U)
MLR[%0L[C1")JEN5:A46`T,*(6PEJWLA9"0T2*;(N^0P..H=<K>-#>D<>A%!!
MR8\'?-*HZ6."-;IN.`CUP-AXU+&7DLT]%H[\N>`L&'#V<C#VB:S"S6WNN$MN
M4\]]O7H[-1NZ0[KT?68/I<V8/;)MZ8I#FNU2BHXP(:JZ>`8]7!]OU)7H='$Z
MQUK.^TCN5T5=:MLO%KL49LS#E'7MT=)V;8]716.SIS7CN`=JQH8>8_])U3PO
MASR*#;Q4!GN+H`K'K]#3?U4G)O75"X5U?&5\9`X'1F;U4.8IC#=B7CY`C#NH
M,-5PTNK\UFUU+J>?/W4;=2<-(U<J,1!G05*$TA(F[95/4Q%$O7+--?VHE.?5
M\KR=\O`&7UT]*$?K89;B,H'48:UN-;R.VCHM:;4%P]T6-+02/G(K>#4\@=<A
M>8276`\&B/5L'%#-V_$/1YET!*,F^'>OQ9?7NYH4'^+$F<E%DI"'@\B'1^B,
MLQ$P3GXG(:9?)ILT)P`RB!1`^SW45L+JZ,&92N^T-`93ON[7$%>`3I5!K<[T
M^NR\UGSEH&Y[+0Y@2QJ*N\F"UPM\0=[:18UZ/IH2/NI=EF&<Q7DL$KB>7D(8
MFT4;-B64LSK<,%!+D9?$AE?IT][F5!YL.+/5[^*Y-5N\ARWBFK>?]?1HWF;B
M[!8ZWU2AN_"/A79;*_DK1RJ]5TX'G9'KV"_R6&5=L,S1$A[-P66QU>K,?OGR
M=7IQ\<?5].MYO0#J(H,D3E2;R`QS;+L?;375(YK2&_K[CAW<OO[.&.6<.H,!
M-CN;V55G8M[1G0D;D_T_-::M>MG8J^&V?-V6YDI#BG,8NGL5B#+R!MM3O8?9
MU9^VW/.6)C4:ELMQ==VU-BG_SZZU40?E,N[1DE9=CZ%A[`"W`\U_A2"2P<(4
2Z63NBX%'J23?`52S"/*L#```
`
end
