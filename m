Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274404AbRITKYV>; Thu, 20 Sep 2001 06:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274403AbRITKYM>; Thu, 20 Sep 2001 06:24:12 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:61848 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S274402AbRITKX5>; Thu, 20 Sep 2001 06:23:57 -0400
Date: Thu, 20 Sep 2001 11:24:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Make kernel build numbers work again (was: Re: Cannot compile 2.4.10pre12aa1 with 2.95.2 on Debian)
Message-ID: <20010920112419.F1577@flint.arm.linux.org.uk>
In-Reply-To: <20010919193128.A8650@cm.nu> <Pine.OSF.4.21.0109201149110.3983-100000@prfdec.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.OSF.4.21.0109201149110.3983-100000@prfdec.natur.cuni.cz>; from mmokrejs@natur.cuni.cz on Thu, Sep 20, 2001 at 11:57:02AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 11:57:02AM +0200, Martin MOKREJ© wrote:
> . scripts/mkversion > .version

People,

As I'm sure you're all aware, being experts in userland programming, that
the above obviously cannot work and is totally bogus.

The mkversion script contains:

if [ ! -f .version ]
then
    echo 1
else
    expr 0`cat .version` + 1
fi

but wait!  As far as the script is concerned, .version will always exist
because its created before the script is run (the open occurs, the file is
truncated, and passed to the script as STDOUT).

This has a nice effect - the build number of the kernel is now fixed at '1'.
So, why don't we get rid of the above crap and just do "echo 1 > .version"
and be done with it? ;)

Alternatively, the following patch fixes things such that we can read the
original .version file within the script, if it existed prior to invocation,
and produce the correct build number.

Note that as illustrated by the previous poster, -linus now has the problem,
and -ac also has the same.  The following patch was generated against
2.4.9-ac10, but should apply to both trees without problem.

--- ref/Makefile	Wed Sep 19 14:00:24 2001
+++ linux/Makefile	Thu Sep 20 11:19:43 2001
@@ -234,7 +234,7 @@
 	drivers/sound/pndsperm.c \
 	drivers/sound/pndspini.c \
 	drivers/atm/fore200e_*_fw.c drivers/atm/.fore200e_*.fw \
-	.version .config* config.in config.old \
+	.version* .config* config.in config.old \
 	scripts/tkparse scripts/kconfig.tk scripts/kconfig.tmp \
 	scripts/lxdialog/*.o scripts/lxdialog/lxdialog \
 	.menuconfig.log \
@@ -306,7 +306,8 @@
 $(TOPDIR)/include/linux/compile.h: include/linux/compile.h
 
 newversion:
-	. scripts/mkversion > .version
+	. scripts/mkversion > .version.tmp
+	@mv -f .version.tmp .version
 
 include/linux/compile.h: $(CONFIGURATION) include/linux/version.h newversion
 	@echo -n \#define UTS_VERSION \"\#`cat .version` > .ver

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

