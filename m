Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSIERcQ>; Thu, 5 Sep 2002 13:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSIERcQ>; Thu, 5 Sep 2002 13:32:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7897 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317742AbSIERcP>; Thu, 5 Sep 2002 13:32:15 -0400
Date: Thu, 5 Sep 2002 19:36:45 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <paulkf@microgate.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch] Fix .text.exit error with static compile of synclinkmp.c
Message-ID: <Pine.NEB.4.44.0209051931430.7218-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when compiling synclinkmp.c statically into the kernel the following error
occurs at the final linking (this is 2.4.20-pre5-ac2 but the problem also
exists in 2.4.20-pre5):

<--  snip  -->

...
        --end-group \
        -o vmlinux
drivers/char/char.o(.data+0x81b4): undefined reference to `local symbols
in discarded section .text.exit'
make: *** [vmlinux] Error 1

<--  snip  -->

The problem is that the __exit function synclinkmp_remove_one is referred
to in "static struct pci_driver synclinkmp_pci_driver".

The fix is simple:

--- drivers/char/synclinkmp.c.old	2002-09-05 12:40:25.000000000 +0200
+++ drivers/char/synclinkmp.c	2002-09-05 12:42:34.000000000 +0200
@@ -519,7 +519,9 @@
 	name:		"synclinkmp",
 	id_table:	synclinkmp_pci_tbl,
 	probe:		synclinkmp_init_one,
+#ifdef MODULE
 	remove:		synclinkmp_remove_one,
+#endif
 };



cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

