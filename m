Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132334AbQKDB2x>; Fri, 3 Nov 2000 20:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132347AbQKDB2n>; Fri, 3 Nov 2000 20:28:43 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:45330 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132334AbQKDB2f>; Fri, 3 Nov 2000 20:28:35 -0500
Date: Fri, 3 Nov 2000 19:28:17 -0600
To: TenThumbs <tenthumbs@cybernex.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre18: many calls to kwhich
Message-ID: <20001103192817.J1041@wire.cadcamlab.org>
In-Reply-To: <3A017FBB.AF8C596D@cybernex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A017FBB.AF8C596D@cybernex.net>; from tenthumbs@cybernex.net on Thu, Nov 02, 2000 at 09:52:43AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[TenThumbs]
> I noticed that kwhich is called a lot:
> 
> make oldconfig:        10
> make dep:              65
> make bzImage modules: 142

Yes indeed, I suggested the ':=' when kwhich first went in, for this
reason.  I suspect my mail was either ignored or overlooked.

That whole raft of variables uses '=' instead of ':=' and I've
occasionally wondered if this was intentional.  Possibly so, because
arch/{mips,m68k}/Makefile both set CROSS_COMPILE, which wouldn't work
if the toplevel used ':='.

I don't like it, though.  I think the user should be assumed to either
have a standard toolchain installed, in which case gcc and binutils
should be in the path under standard names --- or the user should know
enough to specify ARCH= and CROSS_COMPILE= on the compile line.


Alan: to avoid the 'CROSS_COMPILE defined too early' problem in the
stable series, I suggest the following, which will at least prevent the
kwhich script from being execed 200 times as reported.

Peter

--- 2.2.18pre19/Makefile~	Fri Nov  3 19:20:31 2000
+++ 2.2.18pre19/Makefile	Fri Nov  3 19:26:08 2000
@@ -28,8 +28,8 @@
 #	kgcc for Conectiva and Red Hat 7
 #	otherwise 'cc'
 #
-CC	=$(shell if [ -n "$(CROSS_COMPILE)" ]; then echo $(CROSS_COMPILE)gcc; else \
-	$(CONFIG_SHELL) scripts/kwhich gcc272 2>/dev/null || $(CONFIG_SHELL) scripts/kwhich kgcc 2>/dev/null || echo cc; fi) \
+FOUNDCC := $(shell $(CONFIG_SHELL) scripts/kwhich gcc272 kgcc cc 2>/dev/null)
+CC	=$(shell if [ -n "$(CROSS_COMPILE)" ]; then echo $(CROSS_COMPILE)gcc; else echo $(FOUNDCC); fi) \
 	-D__KERNEL__ -I$(HPATH)
 CPP	=$(CC) -E
 AR	=$(CROSS_COMPILE)ar
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
