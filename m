Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272682AbRHaM7I>; Fri, 31 Aug 2001 08:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272683AbRHaM66>; Fri, 31 Aug 2001 08:58:58 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:29354 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S272682AbRHaM6s>;
	Fri, 31 Aug 2001 08:58:48 -0400
Date: Fri, 31 Aug 2001 14:58:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Roman Zippel <zippel@linux-m68k.org>,
        "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108311213.OAA01600@nbd.it.uc3m.es>
Message-ID: <Pine.LNX.4.33.0108311433070.24580-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 31 Aug 2001, Peter T. Breuer wrote:

> > What bug are you trying to fix here?
>
> Wake up!

I'm trying.

> Try reading the last 10 days kernel messages. The last 48 hours are
> particularly rewarding.

I have, but I only get the feeling, we're hunting here for imaginary bugs.
Real bugs could be found with -Wsign-compare, but nobody wants to use it
because our master doesn't want it...
Please define the bugs first, you're trying to fix! If you don't like
-Wsign-compare, consider defining rules for the Stanford checker. This way
you can check all compares and not just the few uses of min.

>   C silently transforms signed int to unsigned int in cross-signed
>   comparisons. This results in 1U < -2, and gives rise to all kinds
>   of error paths from min/max codes (in particular, but they're not
>   all) of the form

Care to give an example? For the cases I tried gcc gave a warning.

> Linus wants possible mistakes flagged. He specifically does not want
> -Wsign-compare because it apparently gives false positives.

diff -u -r1.1.1.23 Makefile
--- Makefile	16 Aug 2001 20:50:22 -0000	1.1.1.23
+++ Makefile	31 Aug 2001 11:15:21 -0000
@@ -87,7 +87,11 @@

 CPPFLAGS := -D__KERNEL__ -I$(HPATH)

-CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+WFLAGS := -Wall -Wstrict-prototypes -Wno-trigraphs
+ifdef CONFIG_EXTRA_WARNINGS
+WFLAGS := $(WFLAGS) -Wsign-compare
+endif
+CFLAGS := $(CPPFLAGS) $(WFLAGS) -O2 \
 	  -fomit-frame-pointer -fno-strict-aliasing -fno-common
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)

diff -u -r1.1.1.15 config.in
--- arch/i386/config.in	21 Jul 2001 12:48:20 -0000	1.1.1.15
+++ arch/i386/config.in	31 Aug 2001 11:12:56 -0000
@@ -390,4 +390,5 @@

 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Extra compile warnings' CONFIG_EXTRA_WARNINGS
 endmenu
diff -u -r1.1.1.23 Configure.help
--- Documentation/Configure.help	16 Aug 2001 20:55:53 -0000	1.1.1.23
+++ Documentation/Configure.help	31 Aug 2001 11:21:10 -0000
@@ -15766,6 +15766,15 @@
   keys are documented in Documentation/sysrq.txt. Don't say Y unless
   you really know what this hack does.

+Extra compile warnings
+CONFIG_EXTRA_WARNINGS
+  If you say Y here, the compilation will generate lots of extra
+  warnings. Some of them warn about constructions that users generally
+  do not consider questionable, but which occasionally you might wish
+  to check for; others warn about constructions that are necessary or
+  hard to avoid in some cases, and there is no simple way to modify the
+  code to suppress the warning. Unless you look for bugs, say N.
+
 ISDN subsystem
 CONFIG_ISDN
   ISDN ("Integrated Services Digital Networks", called RNIS in France)

bye, Roman




