Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVCUXyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVCUXyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVCUXyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:54:31 -0500
Received: from royk.itea.ntnu.no ([129.241.190.230]:52643 "EHLO
	royk.itea.ntnu.no") by vger.kernel.org with ESMTP id S262169AbVCUXtM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:49:12 -0500
From: Per Christian Henden <perchrh@pvv.org>
Organization: NTNU
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc dmasound compilation fix (TRIVIAL), kernel 2.6.11
Date: Tue, 22 Mar 2005 00:47:15 +0100
User-Agent: KMail/1.8
Cc: benh@kernel.crashing.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503220047.16008.perchrh@pvv.org>
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes the following problem: 
Compile error when compiling with CONFIG_DMASOUND_PMAC defined
and CONFIG_NVRAM not defined.

The 2.6 kernel has had this problem since 2.6.8 [1], possibly longer.

Details:

The error is 

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
sound/built-in.o(.init.text+0xb68): In function `dmasound_awacs_init':
: undefined reference to `pmac_xpram_read'
make[1]: *** [.tmp_vmlinux1] Error 1

sound/oss/dmasound/dmasound_awacs.c calls the function pmac_xpram_read(int) in 
the function dmasound_awacs_init() without making sure that CONFIG_NVRAM (the 
"provider" of this function) is defined. Other users of pmac_xpram_read(int) 
checks for this. 

The specific call is 

vol = ((pmac_xpram_read( 8 ) & 7 ) << 1 );
 -- it just sets the volume, so we don't need to force users of 
CONFIG_DMASOUND_PMAC to use CONFIG_NVRAM, IMHO.


Patch against 2.6.11.5:

--- linux-2.6.11.5-orig/sound/oss/dmasound/dmasound_awacs.c     2005-03-22 
00:32:10.000000000 +0100
+++ linux-2.6.11.5-new/sound/oss/dmasound/dmasound_awacs.c      2005-03-22 
00:30:50.000000000 +0100
@@ -2987,10 +2987,13 @@

        set_hw_byteswap(io) ; /* figure out if the h/w can do it */

-       /* get default volume from nvram
-        * vol = (~nvram_read_byte(0x1308) & 7) << 1;
-       */
+#ifdef CONFIG_NVRAM
+       /* get default volume from nvram */
        vol = ((pmac_xpram_read( 8 ) & 7 ) << 1 );
+#else
+       vol = 0;
+#endif
+
        /* set up tracking values */
        spk_vol = vol * 100 ;
        spk_vol /= 7 ; /* get set value to a percentage */


-----------

I've tested the new case when vol gets set to 0, and it has no ill effects. 
It's how it's done in dmasound_atari.c:TTMixerInit(). 
The test was limited to compile and boot the patched kernel, test 
that sound and boot-up worked as normal (as it did earlier without the patch 
applied).


[1] see http://lists.debian.org/debian-powerpc/2005/03/msg00482.html


PS: Please CC me if replying, as I'm not subscribed to the lkml.


Cheers, 

Per Christian Henden
