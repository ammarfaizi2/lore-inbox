Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSLaJ17>; Tue, 31 Dec 2002 04:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbSLaJ17>; Tue, 31 Dec 2002 04:27:59 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:39685 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265102AbSLaJ15>;
	Tue, 31 Dec 2002 04:27:57 -0500
Date: Tue, 31 Dec 2002 10:36:19 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, gibbs@adaptec.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [aic7xxx] Spurious recompile with defconfig
Message-ID: <20021231093619.GA3738@mars.ravnborg.org>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	Sam Ravnborg <sam@ravnborg.org>, gibbs@adaptec.com,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <20021228085631.GA1835@mars.ravnborg.org> <698528112.1041102051@aslan.scsiguy.com> <145050000.1041297169@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145050000.1041297169@aslan.btc.adaptec.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 06:12:49PM -0700, Justin T. Gibbs wrote:
> The real problem here is that make choses the wrong path for getting
> to reg_print.o and, since "intermediate files" were used, those files
> are removed once the target is made (See "Chained Rules" in the gmake
> info file).  From the "make -d" output, for some reason make decides
> that:
> 
> 	.o <- .s <- .c <- .c_shipped
> 
> is better than
> 
> 	.o <- .c <- .c_shipped
> 
> I can't see, from a cursory investigation of the 2.5.X Makefiles
> why this happens, but it is certainly anoying.
Seems the pattern rule involving _shipped was fooling make somehow.
I listed the dependencies explicit (reg_print.c_shipped -> reg_print.c)
explicit and it worked.
Did a little more makefile tricks while I was there.
aicasm is too overloaded, it would have been better to have separate
tools for some of this.

Please forward to Linus if you find it OK.

	Sam

===== drivers/scsi/aic7xxx/Makefile 1.18 vs edited =====
--- 1.18/drivers/scsi/aic7xxx/Makefile	Sat Dec 21 01:59:49 2002
+++ edited/drivers/scsi/aic7xxx/Makefile	Tue Dec 31 10:31:32 2002
@@ -43,41 +43,39 @@
 # Dependencies for generated files need to be listed explicitly
 
 $(obj)/aic7xxx_core.o: $(obj)/aic7xxx_seq.h
+$(obj)/aic7xxx_reg_print.c: $(src)/aic7xxx_reg_print.c_shipped
+
 $(obj)/aic79xx_core.o: $(obj)/aic79xx_seq.h
+$(obj)/aic79xx_reg_print.c: $(src)/aic79xx_reg_print.c_shipped
 
 $(addprefix $(obj)/,$(aic7xxx-y)): $(obj)/aic7xxx_reg.h
 $(addprefix $(obj)/,$(aic79xx-y)): $(obj)/aic79xx_reg.h
 
-ifeq ($(CONFIG_AIC7XXX_BUILD_FIRMWARE),y)
-aic7xxx_gen = $(obj)/aic7xxx_seq.h $(obj)/aic7xxx_reg.h
-ifeq ($(CONFIG_AIC7XXX_REG_PRETTY_PRINT),y)
-aic7xxx_gen += $(obj)/aic7xxx_reg_print.c
-aic7xxx_asm_cmd = $(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic7xxx_reg.h \
-		 -p $(obj)/aic7xxx_reg_print.c -i aic7xxx_osm.h	   \
-		 -o $(obj)/aic7xxx_seq.h $(src)/aic7xxx.seq
-else
-aic7xxx_asm_cmd = $(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic7xxx_reg.h \
-		 -o $(obj)/aic7xxx_seq.h $(src)/aic7xxx.seq
-endif
+aic7xxx-gen-$(CONFIG_AIC7XXX_BUILD_FIRMWARE)   := $(obj)/aic7xxx_seq.h \
+                                                  $(obj)/aic7xxx_reg.h
+aic7xxx-gen-$(CONFIG_AIC7XXX_REG_PRETTY_PRINT) += $(obj)/aic7xxx_reg_print.c
+
+aicasm-7xxx-flags-$(CONFIG_AIC7XXX_REG_PRETTY_PRINT) := \
+	-p $(obj)/aic7xxx_reg_print.c -i aic7xxx_osm.h
 
-$(aic7xxx_gen): $(src)/aic7xxx.seq $(src)/aic7xxx.reg $(obj)/aicasm/aicasm
-	$(aic7xxx_asm_cmd)
+ifneq ($(CONFIG_AIC7XXX_REG_PRETTY_PRINT)$(CONFIG_AIC7XXX_BUILD_FIRMWARE),)
+$(aic7xxx-gen-y): $(src)/aic7xxx.seq $(src)/aic7xxx.reg $(obj)/aicasm/aicasm
+	$(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic7xxx_reg.h \
+		$(aicasm-7xxx-flags-y) -o $(obj)/aic7xxx_seq.h $<
 endif
 
-ifeq ($(CONFIG_AIC79XX_BUILD_FIRMWARE),y)
-aic79xx_gen = $(obj)/aic79xx_seq.h $(obj)/aic79xx_reg.h
-ifeq ($(CONFIG_AIC79XX_REG_PRETTY_PRINT),y)
-aic79xx_gen += $(obj)/aic79xx_reg_print.c
-aic79xx_asm_cmd = $(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic79xx_reg.h \
-		 -p $(obj)/aic79xx_reg_print.c -i aic79xx_osm.h	   \
-		 -o $(obj)/aic79xx_seq.h $(src)/aic79xx.seq
-else
-aic79xx_asm_cmd = $(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic79xx_reg.h \
-		 -o $(obj)/aic79xx_seq.h $(src)/aic79xx.seq
+aic79xx-gen-$(CONFIG_AIC79XX_BUILD_FIRMWARE)  := $(obj)/aic79xx_seq.h \
+                                                 $(obj)/aic79xx_reg.h
+aic79xx-gen-$(CONFIG_AIC79XX_REG_PRETTY_PRINT) += $(obj)/aic79xx_reg_print.c
+
+aicasm-79xx-flags-$(CONFIG_AIC79XX_REG_PRETTY_PRINT) := \
+	-p $(obj)/aic79xx_reg_print.c -i aic79xx_osm.h
+
+ifneq ($(CONFIG_AIC79XX_REG_PRETTY_PRINT)$(CONFIG_AIC79XX_BUILD_FIRMWARE),)
+$(aic79xx-gen-y): $(src)/aic79xx.seq $(src)/aic79xx.reg $(obj)/aicasm/aicasm
+	$(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic79xx_reg.h
+		$(aicasm-79xx-flags-y) -o $(obj)/aic79xx_seq.h $<
 endif
-$(aic79xx_gen): $(src)/aic79xx.seq $(src)/aic79xx.reg $(obj)/aicasm/aicasm
-	$(aic79xx_asm_cmd)
-endif 
 
 $(obj)/aicasm/aicasm: $(src)/aicasm/*.[chyl]
 	$(MAKE) -C $(src)/aicasm
