Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTBJVQ5>; Mon, 10 Feb 2003 16:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTBJVQ4>; Mon, 10 Feb 2003 16:16:56 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:42917 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265174AbTBJVQy>; Mon, 10 Feb 2003 16:16:54 -0500
Date: Mon, 10 Feb 2003 15:26:30 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Kay Sievers <lkml@vrfy.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 defconfig+CONFIG_MODVERSIONS=y -> syntax error
In-Reply-To: <20030210205752.GB16226@vrfy.org>
Message-ID: <Pine.LNX.4.44.0302101523130.3320-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Kay Sievers wrote:

> On Mon, Feb 10, 2003 at 02:49:36PM -0600, Kai Germaschewski wrote:
> > On Mon, 10 Feb 2003, Kay Sievers wrote:
> > >   ld:arch/i386/kernel/.tmp_time.ver:1: syntax error
> > 
> > Interesting. Thanks for testing CONFIG_MODVERSIONS. I cannot reproduce it
> > here, unfortunately (not even with the same .config). What does
> > arch/i386/kernel/.tmp_time.ver look like?
> 
> pim:/usr/src/linux-2.5.60# cat arch/i386/kernel/.tmp_time.ver
> __crc_i = 0x_lock ;     ac2d2492

Okay, that's not a problem with ld, but (most likely) sed.

I hope the appended patch fixes it. For the record, what version of sed do 
you have? (sed -V)

--Kai


===== scripts/Makefile.build 1.27 vs edited =====
--- 1.27/scripts/Makefile.build	Sat Feb  8 14:30:33 2003
+++ edited/scripts/Makefile.build	Mon Feb 10 15:25:44 2003
@@ -94,7 +94,7 @@
 	else								      \
 		$(CPP) -D__GENKSYMS__ $(c_flags) $<			      \
 		| $(GENKSYMS) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)	      \
-		| sed -n 's/\#define __ver_\(\w*\)\W*\(\w*\)/__crc_\1 = 0x\2 ;/gp' \
+		| sed -n 's/\#define __ver_\([^ 	]*\)[ 	]*\([^ 	]*\)/__crc_\1 = 0x\2 ;/gp' \
 		> $(@D)/.tmp_$(@F:.o=.ver);				      \
 									      \
 		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		      \

