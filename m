Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSFPMhl>; Sun, 16 Jun 2002 08:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSFPMhk>; Sun, 16 Jun 2002 08:37:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:30955 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316199AbSFPMhj>; Sun, 16 Jun 2002 08:37:39 -0400
Date: Sun, 16 Jun 2002 14:37:36 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Ghozlane Toumi <gtoumi@laposte.net>,
        James Simmons <jsimmons@linux-fbdev.org>
cc: linux-kernel@vger.kernel.org
Subject: [patch] fix .text.exit compile error in sstfb.c
Message-ID: <Pine.NEB.4.44.0206161434070.11043-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following error at the final linking stage of 2.4.19-pre10
(updated to ChangeSet 1.546 from Marcelo's BK repository):

<--  snip  -->

...
drivers/video/video.o: In function `sstfb_remove':
drivers/video/video.o(.text+0x6255c): undefined reference to `local
symbols in discarded section .text.exit'

<--  snip  -->


The problem is that sstfb_remove is __devexit and calls sst_shutdown which
is __exit. This causes the error above when CONFIG_HOTPLUG is set.

I suggest the following fix:


--- drivers/video/sstfb.c.old	Sun Jun 16 14:22:03 2002
+++ drivers/video/sstfb.c	Sun Jun 16 14:23:56 2002
@@ -1694,7 +1694,7 @@
 	return 1;
 }

-static void  __exit sst_shutdown(struct sstfb_info *sst_info)
+static void  __devexit sst_shutdown(struct sstfb_info *sst_info)
 {
 	struct pci_dev * sst_dev = sst_info->dev;
 	struct pll_timing gfx_timings;

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

