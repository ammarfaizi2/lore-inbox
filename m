Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSL0XH1>; Fri, 27 Dec 2002 18:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265249AbSL0XH1>; Fri, 27 Dec 2002 18:07:27 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:2578 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265242AbSL0XHY>;
	Fri, 27 Dec 2002 18:07:24 -0500
Date: Sat, 28 Dec 2002 00:15:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: kbuild/x86_64: archhelp + various clean-up
Message-ID: <20021227231540.GB24461@mars.ravnborg.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi.

[This is one step of the Makefile clean-up as discussed in private mail]

Moved archhelp to arch/x86_64/Makefile
Introduced usage of $(build) and $(clean)
Use kbuild clean infrastructure

Please apply,
	Sam


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.962, 2002-12-27 23:54:14+01:00, sam@mars.ravnborg.org
  kbuild/x86_64: archhelp, $(build) usage and cleaning
  
  Moved archhelp to arch/x86_64/Makefile
  Introduced usage of $(build) and $(clean)
  Use kbuild clean infrastructure


 Makefile                 |   26 ++++++++++++++++----------
 boot/Makefile            |   18 ++----------------
 boot/compressed/Makefile |    4 ----
 3 files changed, 18 insertions(+), 30 deletions(-)


diff -Nru a/arch/x86_64/Makefile b/arch/x86_64/Makefile
--- a/arch/x86_64/Makefile	Fri Dec 27 23:56:21 2002
+++ b/arch/x86_64/Makefile	Fri Dec 27 23:56:21 2002
@@ -55,32 +55,30 @@
 core-$(CONFIG_IA32_EMULATION)		+= arch/x86_64/ia32/
 drivers-$(CONFIG_PCI)			+= arch/x86_64/pci/
 
-makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/x86_64/boot $(1)
+boot := arch/x86_64/boot
 
 .PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk install \
-		clean archclean archmrproper
+	archclean
 
 BOOTIMAGE=arch/x86_64/boot/bzImage
 zImage zlilo zdisk: BOOTIMAGE=arch/x86_64/boot/zImage
 
 zImage bzImage: vmlinux
-	$(call makeboot,$(BOOTIMAGE))
+	$(Q)$(MAKE) $(build)=$(boot) $(BOOTIMAGE)
 
 compressed: zImage
 
 zlilo bzlilo: vmlinux
-	$(call makeboot,BOOTIMAGE=$(BOOTIMAGE) zlilo)
+	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zlilo
 
 zdisk bzdisk: vmlinux
-	$(call makeboot,BOOTIMAGE=$(BOOTIMAGE) zdisk)
+	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zdisk
 
 install: vmlinux
-	$(call makeboot,BOOTIMAGE=$(BOOTIMAGE) install)
+	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) install
 
 archclean:
-	$(call makeboot,clean)
-
-archmrproper:
+	$(Q)$(MAKE) $(clean)=$(boot)
 
 prepare: include/asm-$(ARCH)/offset.h
 
@@ -95,4 +93,12 @@
 	@$(update-if-changed)
 
 CLEAN_FILES += include/asm-$(ARCH)/offset.h.tmp \
-	       include/asm-$(ARCH)/offset.h
\ No newline at end of file
+	       include/asm-$(ARCH)/offset.h
+
+define archhelp
+  echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
+  echo  '  install	- Install kernel using'
+  echo  '                  (your) ~/bin/installkernel or'
+  echo  '                  (distribution) /sbin/installkernel or'
+  echo  '        	  install to $$(INSTALL_PATH) and run lilo'
+endef
diff -Nru a/arch/x86_64/boot/Makefile b/arch/x86_64/boot/Makefile
--- a/arch/x86_64/boot/Makefile	Fri Dec 27 23:56:21 2002
+++ b/arch/x86_64/boot/Makefile	Fri Dec 27 23:56:21 2002
@@ -31,7 +31,7 @@
 CFLAGS += -m32
 
 host-progs	:= tools/build
-
+subdir-		:= compressed	#Let make clean descend in compressed/
 # ---------------------------------------------------------------------------
 
 $(obj)/zImage:  IMAGE_OFFSET := 0x1000
@@ -58,8 +58,7 @@
 	$(call if_changed,ld)
 
 $(obj)/compressed/vmlinux: FORCE
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/compressed \
-					IMAGE_OFFSET=$(IMAGE_OFFSET) $@
+	$(Q)$(MAKE) $(build)=$(obj)/compressed IMAGE_OFFSET=$(IMAGE_OFFSET) $@
 
 zdisk: $(BOOTIMAGE)
 	dd bs=8192 if=$(BOOTIMAGE) of=/dev/fd0
@@ -73,16 +72,3 @@
 
 install: $(BOOTIMAGE)
 	sh $(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
-
-clean:
-	@echo 'Cleaning up (boot)'
-	@rm -f $(host-progs) $(EXTRA_TARGETS)
-	+@$(call descend,$(obj)/compressed) clean
-
-archhelp:
-	@echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
-	@echo  '  install	- Install kernel using'
-	@echo  '                  (your) ~/bin/installkernel or'
-	@echo  '                  (distribution) /sbin/installkernel or'
-	@echo  '        	  install to $$(INSTALL_PATH) and run lilo'
-
diff -Nru a/arch/x86_64/boot/compressed/Makefile b/arch/x86_64/boot/compressed/Makefile
--- a/arch/x86_64/boot/compressed/Makefile	Fri Dec 27 23:56:21 2002
+++ b/arch/x86_64/boot/compressed/Makefile	Fri Dec 27 23:56:21 2002
@@ -30,7 +30,3 @@
 
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,ld)
-
-clean:
-	@echo 'Cleaning up (boot/compressed)'
-	@rm -f $(EXTRA_TARGETS)

===================================================================


This BitKeeper patch contains the following changesets:
1.962
## Wrapped with gzip_uu ##


begin 664 bkpatch24301
M'XL(`)7:##X``[U7;4_C.!#^7/^*D:A$>WMM[+RW4D]T:8%JX>!*5SKI[H2<
MQ*6YI@F*$VY91??;;^*^`J5`M5Q:K-3V/!Z/GWD\',!7*=)V1?(9.8"S1&;M
MRHRGLIGR^]A+TMLF_N'(,$EP1)LD,Z'A7$VFOA:%<?Y-FXHT%I'F3;6IEX=1
M0'#V%<_\"=R+5+8KK&FL>K*'.]&N#/NG7\^[0T(Z'3B>\/A67(L,.AV2)>D]
MCP)YQ+-)E,3-+.6QG(F,-_UD5JRF%CJE.GXLYAC4L@MF4],I?!8PQDTF`JJ;
MKFT2=//HV5:>H#!==W3=I,PHJ&F;.ND!:[9L':BN,5W3'="-MF6VF?F)LC:E
ML!44/AG0H.0S_-@-'!,?YC'5OKGVC6VV@:?^9"*BNY^A6E,C=<@EOQ7`XP#\
M2/`XC&_1#+\7R;T(5@;HFGI?(&D7?"K&821PXB#.TB3(?9P]QTK&:_02MUI3
MR'6<BV19N#1?#<)XG'*9I;F?Y:D@7\#2,8I7ZW,EC7<^A%!.R2_`IT>SW&\&
MHMCTVT,>:AC,NU1(*8+5/A8A989.,:AZH;L.M0J+FB8S'.;SL>[0%M]^?&]?
M8$X7RV2TH*[E&+O=?-$WV[%:A>&QL67SP`XL[HUU\ZV^O>B0[K:L%QUZT1>+
MVK1PA16XW"FYQUN4LC?XLM4-VBIL'6.N4GO;[#++?X2#:Y`_ECGWUT[W&+4,
MVW(*$XEAJ2QG[M,DIZW=2<YL:+"/2?/GR9I-0@D?D*$^#,5,K9;'.1(<,I[>
MBDQBZLZ/[A(:Z3_JB[EXM5TTWI_3/<L%1@:J+6D,[<<$*?M(SV;E)-56RE&U
M`^QV5'?95JJUW^K5VD7W2[^^BD$'7]"^[/A\>3D:7'1/^W72<_323+6[S59&
MG4T`^!Z%48(PEH*Q]H8)0CE%&!4`U>X%$\8RXU%$>BX#@PQ<XSG0G`1+(-)K
MJ26Q;9$*S)\P]J,\$!J7LT:UUAT>G]6U9#R6(FM.R)\DP/.-Q8J(!$#XDP3@
M\"?PO@]FR+U*`XY7Z@CSRQ_"<@1JZD"7J$JL%D;UPS42+'>"2(/YVQ(FEWA[
M/9KZ]*D])'E:AW\U+XRU!<[".$EW6^(I9&GHY5F8Q'70Y!L1*BM_RZRL5FN#
M7Z]'W?/SFZONZ&R>?6D>0TF50R)B#.`S\7LDVR\KX!YWQJLRN/7&6&JA@5>U
M/=="]JS@H;NU4$<IM/\G*=RC;GE3J:(NS!UR]RAX^VB>89;YIUJ9>T&8-BH5
MU+UU=5$Y.,?*=X9++'P,A/211.CKQBQ-":.."KA+RA+O[_I&X0)*-FXN3TZN
M^R,<WOR)=D<H2#8P8SM9M]0_K_!V[Y+L;13>49`MV<Q,A@PJV6R_E\P4&N:'
M</G)5:O.N+VX<9LX?H+[D*@=,A/JS/N_CX;=FU%W>-H?70,6`.D"P'O88`E2
G5Q6?KU%W2]#V8K$!YOJ?.G\B_*G,9QV[Y0KJV8+\!W4'Q39##@``
`
end
