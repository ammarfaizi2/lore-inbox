Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316511AbSEUEtF>; Tue, 21 May 2002 00:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSEUEtE>; Tue, 21 May 2002 00:49:04 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:31915 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316511AbSEUEtD>; Tue, 21 May 2002 00:49:03 -0400
Date: Mon, 20 May 2002 23:48:56 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Peter Chubb <peter@chubb.wattle.id.au>, <trivial@rustcorp.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Allow aic7xx firmware to be built from BK tree. 
In-Reply-To: <200205210338.g4L3cn947655@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.44.0205202339300.1673-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Justin T. Gibbs wrote:

> >This patch removes the two generate files (that are also in the
> >distributed kernel) before attempting to regenerate them.
> 
> Why is this necessary?

Well, I'll take Keith Owen's role and answer:

Some people are using source control management systems which
leave the managed files read-only.

If you rm the file first and then overwrite it with the generated file, it
will at least work, as opposed to trying to overwrite the read-only file.

It's still no good, because the SCM will notice that the file changed and
ask you to check in the new version, which you most likely don't want.

Some developers use bitkeeper these days, and it'll show exactly this
problem. I suppose the only reason that not more people complain about it
is that hardly anyone has set CONFIG_AIC7XXX_BUILD_FIRMWARE=y.

The correct way to fix this is to not overwrite the shipped files. The
appended patch is a suggestion on how to avoid the mentioned problems.

(I should pay credit to Keith Owens, since he proposed a similar solution
before)

Justin, do you have objections against this patch?

--Kai


-----------------------------------------------------------------------------
ChangeSet@1.581, 2002-05-20 23:33:06-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: aic7xxx firmware build should not overwrite shipped files
  
  o Add dependencies on generated files explicitly to the
    aic7xxx Makefile - These cannot be figured out
    automatically
  
  o Rename the precompiled firmware files to 
    shipped_aic7xxx_{reg,seq}.h, so that we don't overwrite 
    shipped files when regenerating the firmware
   

 ----------------------------------------------------------------------------
 b/Makefile                                   |    2 
 b/drivers/scsi/aic7xxx/Makefile              |   13 
 b/drivers/scsi/aic7xxx/shipped_aic7xxx_reg.h |  716 ++++++++++++++
 b/drivers/scsi/aic7xxx/shipped_aic7xxx_seq.h | 1299 +++++++++++++++++++++++++++
 drivers/scsi/aic7xxx/aic7xxx_reg.h           |  716 --------------
 drivers/scsi/aic7xxx/aic7xxx_seq.h           | 1299 ---------------------------
 6 files changed, 2030 insertions(+), 2015 deletions(-)





=============================================================================
unified diffs follow for reference
=============================================================================


diff -Nru a/Makefile b/Makefile
--- a/Makefile	Mon May 20 23:36:18 2002
+++ b/Makefile	Mon May 20 23:36:18 2002
@@ -330,6 +330,8 @@
 	drivers/zorro/devlist.h drivers/zorro/gen-devlist \
 	sound/oss/bin2hex sound/oss/hex2hex \
 	drivers/atm/fore200e_mkfirm drivers/atm/{pca,sba}*{.bin,.bin1,.bin2} \
+	drivers/scsi/aic7xxx/aic7xxx_seq.h \
+	drivers/scsi/aic7xxx/aic7xxx_reg.h \
 	drivers/scsi/aic7xxx/aicasm/aicasm_gram.c \
 	drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
 	drivers/scsi/aic7xxx/aicasm/y.tab.h \
diff -Nru a/drivers/scsi/aic7xxx/Makefile b/drivers/scsi/aic7xxx/Makefile
--- a/drivers/scsi/aic7xxx/Makefile	Mon May 20 23:36:18 2002
+++ b/drivers/scsi/aic7xxx/Makefile	Mon May 20 23:36:18 2002
@@ -24,9 +24,22 @@
 
 include $(TOPDIR)/Rules.make
 
+# Dependencies for generated files need to be listed explicitly
+
+aic7xxx_core.o: aic7xxx_seq.h
+
+$(aic7xxx-objs): aic7xxx_reg.h
+
 ifeq ($(CONFIG_AIC7XXX_BUILD_FIRMWARE),y)
+
 aic7xxx_seq.h aic7xxx_reg.h: aic7xxx.seq aic7xxx.reg aicasm/aicasm
 	aicasm/aicasm -I. -r aic7xxx_reg.h -o aic7xxx_seq.h aic7xxx.seq
+
+else
+
+aic7xxx_seq.h aic7xxx_reg.h: %.h : shipped_%.h
+	ln -s $< $@
+
 endif
 
 aicasm/aicasm: aicasm/*.[chyl]

[skipped the 

	mv aic7xxx_reg.h shipped_aic7xxx_reg.h
	mv aic7xxx_seq.h shipped_aic7xxx_seq.h

 diff]

