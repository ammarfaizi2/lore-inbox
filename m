Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbSL1TsY>; Sat, 28 Dec 2002 14:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbSL1TsY>; Sat, 28 Dec 2002 14:48:24 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:44555 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265409AbSL1TsX>;
	Sat, 28 Dec 2002 14:48:23 -0500
Date: Sat, 28 Dec 2002 20:56:37 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jochen Hein <jochen@jochen.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.53, KBUILD] missing dependencies for yenta_socket.ko?
Message-ID: <20021228195637.GA14787@mars.ravnborg.org>
Mail-Followup-To: Jochen Hein <jochen@jochen.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <87wulucxhw.fsf@gswi1164.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wulucxhw.fsf@gswi1164.jochen.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 10:18:35AM +0100, Jochen Hein wrote:
> 
> I changed yenta.c and tried to recompile yenta_socket.ko, the
> resulting kernel module.  I get:
> 
> root@gswi1164:/usr/src/linux-2.5.53# LANG=C make drivers/pcmcia/yenta_socket.ko
> make: Nothing to be done for `drivers/pcmcia/yenta_socket.ko'.

Above trick does not work for composite objects.
The best approach is to use the following trick:

make SUBDIRS=drivers/pcmcia

That will build all files - as required - starting with drivers/pcmcia.
The rest of the build process then proceeds as opposed to the normal
single targets.

The top-level Makefile needs an entry to let the above work with single
target .ko files, patch attached (on top of my earlier kbuild changes).

	Sam

===== Makefile 1.349 vs edited =====
--- 1.349/Makefile	Fri Dec 27 21:15:43 2002
+++ edited/Makefile	Sat Dec 28 13:13:55 2002
@@ -419,6 +419,8 @@
 	$(Q)$(MAKE) $(build)=$(@D) $@
 %.o: %.c scripts FORCE
 	$(Q)$(MAKE) $(build)=$(@D) $@
+%.ko: %.c scripts FORCE
+	$(Q)$(MAKE) $(build)=$(@D) KBUILD_BUILTIN=1 KBUILD_MODULES=1 $@
 %.lst: %.c scripts FORCE
 	$(Q)$(MAKE) $(build)=$(@D) $@
 %.s: %.S scripts FORCE
