Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272649AbRILAAw>; Tue, 11 Sep 2001 20:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272651AbRILAAm>; Tue, 11 Sep 2001 20:00:42 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:12225 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S272649AbRILAAZ>; Tue, 11 Sep 2001 20:00:25 -0400
Date: Wed, 12 Sep 2001 02:02:56 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: <linux-kernel@vger.kernel.org>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: 2.2.20pre10: cannot link ISDN into kernel, netif_wake_queue
Message-ID: <Pine.LNX.4.33.0109120155440.9784-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, I already reported something like this for 2.2.20pre9 and was told
there would be a patch fixing it going to Alan, but this doesn't seem to
be the case.

First, HiSax_setup in drivers/isdn/hisax/config.c is still declared
static, so linking the kernel fails if the HiSax driver is compiled into
the kernel and not as a module.

Second, if I remove the "static", I get the following error during link:

drivers/isdn/isdn.a: In function `isdn_ppp_ioctl':
drivers/isdn/isdn.a(.text+0x1f659): undefined reference to
`netif_wake_queue'
make: *** [vmlinux] Error 1

Grepping through the source for uses of netif_wake_queue, I see that some
users of this function define it themselves and some don't. My guess is
that all users that don't declare it themselves are broken like the ISDN
stuff and cause the kernel link stage to fail. There is some stuff in
drivers/net and drivers/usb that has this problem.

Fix for the HiSax_setup being declared static problem is easy, patch
below, but I don't know about the netif_wake_queue problem.

I think this is a show-stopper for making 2.2.20pre10 the final 2.2.20, I
can't even link a kernel this way.

--- linux-2.2.20pre10/drivers/isdn/hisax/config.c	Wed Sep 12 01:31:33 2001
+++ linux-2.2.20pre10-new/drivers/isdn/hisax/config.c	Wed Sep 12 01:46:54 2001
@@ -434,7 +434,7 @@
 }

 #ifndef MODULE
-static void __init HiSax_setup(char *str, int *ints)
+void __init HiSax_setup(char *str, int *ints)
 {
 	int i, j, argc;
 	argc = ints[0];

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

