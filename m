Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262400AbRE3CIk>; Tue, 29 May 2001 22:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262564AbRE3CI2>; Tue, 29 May 2001 22:08:28 -0400
Received: from femail18.sdc1.sfba.home.com ([24.0.95.145]:45981 "EHLO
	femail18.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262400AbRE3CIY>; Tue, 29 May 2001 22:08:24 -0400
Message-ID: <3B145606.7494C177@didntduck.org>
Date: Tue, 29 May 2001 22:08:06 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rsousa@grad.physics.sunysb.edu
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] EMU10K1 joystick bug
Content-Type: multipart/mixed;
 boundary="------------640D7CC8580BAF9FBCAB74E6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------640D7CC8580BAF9FBCAB74E6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The EMU10K1 driver currently disables the joystick port on module load
and unload.  This patch preserves the HCFG_JOYENABLE bit when the HCFG
register is modified.

-- 

						Brian Gerst
--------------640D7CC8580BAF9FBCAB74E6
Content-Type: text/plain; charset=us-ascii;
 name="diff-emu10k1joy"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-emu10k1joy"

diff -urN linux-2.4.5/drivers/sound/emu10k1/main.c linux/drivers/sound/emu10k1/main.c
--- linux-2.4.5/drivers/sound/emu10k1/main.c	Sat May 26 09:41:32 2001
+++ linux/drivers/sound/emu10k1/main.c	Tue May 29 21:17:06 2001
@@ -363,10 +363,11 @@
 static int __devinit hw_init(struct emu10k1_card *card)
 {
 	int nCh;
-	u32 pagecount; /* tmp */
+	u32 pagecount, tmp;
 
 	/* Disable audio and lock cache */
-	emu10k1_writefn0(card, HCFG, HCFG_LOCKSOUNDCACHE | HCFG_LOCKTANKCACHE_MASK | HCFG_MUTEBUTTONENABLE);
+	tmp = emu10k1_readfn0(card, HCFG) & HCFG_JOYENABLE;
+	emu10k1_writefn0(card, HCFG, tmp | HCFG_LOCKSOUNDCACHE | HCFG_LOCKTANKCACHE_MASK | HCFG_MUTEBUTTONENABLE);
 
 	/* Reset recording buffers */
 	sblive_writeptr_tag(card, 0,
@@ -557,6 +558,7 @@
 static void __devinit emu10k1_exit(struct emu10k1_card *card)
 {
 	int ch;
+	u32 tmp;
 
 	emu10k1_writefn0(card, INTE, 0);
 
@@ -574,7 +576,8 @@
 	}
 
 	/* Disable audio and lock cache */
-	emu10k1_writefn0(card, HCFG, HCFG_LOCKSOUNDCACHE | HCFG_LOCKTANKCACHE_MASK | HCFG_MUTEBUTTONENABLE);
+	tmp = emu10k1_readfn0(card, HCFG) & HCFG_JOYENABLE;
+	emu10k1_writefn0(card, HCFG, tmp | HCFG_LOCKSOUNDCACHE | HCFG_LOCKTANKCACHE_MASK | HCFG_MUTEBUTTONENABLE);
 
 	sblive_writeptr_tag(card, 0,
                             PTB, 0,

--------------640D7CC8580BAF9FBCAB74E6--

