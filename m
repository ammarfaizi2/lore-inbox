Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUFWR46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUFWR46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUFWR46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:56:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:1920 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265127AbUFWR4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:56:40 -0400
Date: Wed, 23 Jun 2004 10:53:46 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] consolidate in kernel configuration
Message-Id: <20040623105346.018d90db.rddunlap@osdl.org>
In-Reply-To: <200406231428.i5NESu5V023376@voidhawk.shadowen.org>
References: <20040622111559.1fa0dc99.akpm@osdl.org>
	<200406231428.i5NESu5V023376@voidhawk.shadowen.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004 15:28:56 +0100 Andy Whitcroft wrote:

| === 8< ===
| Being able to recover the configuration from a kernel is very
| useful and it would be nice to default this option to Yes.
| Currently, to have the config available both from the image (using
| extract-ikconfig) and via /proc we keep two copies of the original
| .config in the kernel.  One in plain text and one gzip compressed.
| This is not optimal.
| 
| This patch removes the plain text version of the configuration and
| updates the extraction tools to locate and use the gzip'd version
| of the file.  This has the added bonus of providing us with the
| exact same results in both cases, the original .config; including
| the comments.
| 
| Revision: $Rev: 274 $
| 
| Signed-off-by: Andy Whitcroft <apw@shadowen.org>
| 
| ---

Yes, looks good and works for me.

We also need a decent way to run scripts/extract-ikconfig and build
scripts/binoffset.  I recall that SuSE has/had a 'make cloneconfig'
once upon a time (in 2.4.x).  I've begun on a 'make getconfig' (but
I can rename it to 'cloneconfig' if that's more appropriate), but
it needs some more work (i.e., not yet working).  [patch below]


Thanks,
--
~Randy



(beginning, not working...)
add 'getconfig' target to extract kernel config from the kernel image file

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 Makefile         |    6 ++++++
 scripts/Makefile |    3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff -Naurp ./scripts/Makefile~getconfig ./scripts/Makefile
--- ./scripts/Makefile~getconfig	2004-06-23 07:21:28.000000000 -0700
+++ ./scripts/Makefile	2004-06-23 09:16:06.266845368 -0700
@@ -5,7 +5,8 @@
 # docproc: 	 Preprocess .tmpl file in order to generate .sgml docs
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
-host-progs	:= conmakehash kallsyms modpost mk_elfconfig pnmtologo bin2c
+host-progs	:= conmakehash kallsyms modpost mk_elfconfig pnmtologo \
+		   bin2c binoffset
 always		:= $(host-progs) empty.o
 
 modpost-objs	:= modpost.o file2alias.o sumversion.o
diff -Naurp ./Makefile~getconfig ./Makefile
--- ./Makefile~getconfig	2004-06-23 07:21:23.000000000 -0700
+++ ./Makefile	2004-06-23 09:22:46.571989736 -0700
@@ -675,6 +675,11 @@ include/config/MARKER: include/linux/aut
 	@scripts/basic/split-include include/linux/autoconf.h include/config
 	@touch $@
 
+.PHONY: getconfig
+getconfig: $(srctree)/scripts/binoffset
+	scripts/extract-ikconfig $@
+
+
 # Generate some files
 # ---------------------------------------------------------------------------
 
@@ -879,6 +884,7 @@ help:
 	@echo  ''
 	@echo  'Configuration targets:'
 	@$(MAKE) -f $(srctree)/scripts/kconfig/Makefile help
+	@echo  '  getconfig kernel_filename - extract kernel config to stdout'
 	@echo  ''
 	@echo  'Other generic targets:'
 	@echo  '  all		  - Build all targets marked with [*]'
