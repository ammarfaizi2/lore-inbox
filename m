Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286590AbSASPLO>; Sat, 19 Jan 2002 10:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSASPLH>; Sat, 19 Jan 2002 10:11:07 -0500
Received: from fs1.ml.kva.se ([130.237.201.20]:19984 "EHLO fs1.ml.kva.se")
	by vger.kernel.org with ESMTP id <S286590AbSASPKv>;
	Sat, 19 Jan 2002 10:10:51 -0500
Date: Sat, 19 Jan 2002 16:11:54 +0100 (CET)
From: Lukas Geyer <geyer@ml.kva.se>
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: 2.4.18pre4 on PPC, Byteswap in dmasound_awacs.c
Message-ID: <Pine.LNX.4.33.0201191547510.6868-100000@cauchy.ml.kva.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ibook2 and the Keylargo controller of this laptop seems not to
be able to do hardware byteswap. However, the driver set hw_can_byteswap
to 1 due to the following in drivers/sound/dmasound/dmasound_awacs.h:

+       struct device_node *mio ;
+       unsigned int *p, rev = 0 ;
+
+       /* if seems that Keylargo (at least rev2) can't byte-swap  */
+
+       for (mio = io->parent; mio ; mio = mio->parent) {
+               if (strcmp(mio->name, "mac-io") == 0) {
+                       if (device_is_compatible(mio, "Keylargo")){
+                               p = (unsigned int *)
+                                       get_property(mio, "revision-id", 0);
+                               if (p)
+                                       rev = *p ;
+                       }
+                       break;
+                }
+       }
+       if (rev >= 2) {
+               hw_can_byteswap = 0;

My Keylargo controller reports 0 as the revision number, thus it might
either be advisable to put that hw_can_byteswap = 0 into the innermost
block and not check the revision at all (if no Keylargo can do byteswap)
or or to put a check for revision <= 2 (after all, isn't it logical to
assume that only later revisions will be able to do byteswap?) inside the
innermost block and set hw_can_byteswap to 0 there.

Lukas

