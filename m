Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUFPQx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUFPQx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbUFPQxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:53:13 -0400
Received: from witte.sonytel.be ([80.88.33.193]:15536 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264246AbUFPQvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:51:05 -0400
Date: Wed, 16 Jun 2004 18:51:03 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-15?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: make checkstack on m68k
Message-ID: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried to add m68k support to `make checkstack', but got stuck due to my
limited knowledge of complex perl expressions. I actually need to catch both
expressions (incl. the one I commented out). Anyone who can help?

Anyway, here's a first run:
  - Add half-assed m68 support.
  - Make sure `make checkstack' uses the script in the source tree directory
    (BTW, I saw a few more targets in my eye corner that may need this)
  - Fix checkstack.pl naming

--- linux-2.6.7/Makefile	2004-06-16 13:06:15.000000000 +0200
+++ linux-m68k-2.6.7/Makefile	2004-06-16 18:27:13.000000000 +0200
@@ -1070,7 +1070,7 @@ endif #ifeq ($(mixed-targets),1)
 .PHONY: checkstack
 checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
-	$(PERL) scripts/checkstack.pl $(ARCH)
+	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)

 # FIXME Should go into a make.lib or something
 # ===========================================================================
--- linux-2.6.7/scripts/checkstack.pl	2004-06-09 14:51:23.000000000 +0200
+++ linux-m68k-2.6.7/scripts/checkstack.pl	2004-06-16 18:39:06.000000000 +0200
@@ -12,7 +12,7 @@
 #	Random bits by Matt Mackall <mpm@selenic.com>
 #
 #	Usage:
-#	objdump -d vmlinux | stackcheck_ppc.pl [arch]
+#	objdump -d vmlinux | stackcheck.pl [arch]
 #
 #	TODO :	Port to all architectures (one regex per arch)

@@ -40,6 +40,11 @@
 	} elsif ($arch =~ /^ia64$/) {
 		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
 		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;
+	} elsif ($arch =~ /^m68k$/) {
+		#2b6c:       4e56 fb70       linkw %fp,#-1168
+		#$re = qr/.*linkw %fp,#-([0-9]{1,4})/o;
+		#1df770:       defc ffe4       addaw #-28,%sp
+		$re = qr/.*addaw #-([0-9]{1,4}),%sp/o;
 	} elsif ($arch =~ /^mips64$/) {
 		#8800402c:       67bdfff0        daddiu  sp,sp,-16
 		$re = qr/.*daddiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
