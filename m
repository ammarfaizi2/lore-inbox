Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUAYRbE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUAYRbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:31:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27643 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264941AbUAYRa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:30:59 -0500
Date: Sun, 25 Jan 2004 18:30:48 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Fabio Coatti <cova@ferrara.linux.it>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>
Cc: Eric <eric@cisu.net>, linux-kernel@vger.kernel.org
Subject: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040125173048.GL513@fs.tum.de>
References: <200401232253.08552.eric@cisu.net> <200401251639.56799.cova@ferrara.linux.it> <20040125162122.GJ513@fs.tum.de> <200401251811.27890.cova@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401251811.27890.cova@ferrara.linux.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 06:11:27PM +0100, Fabio Coatti wrote:
> Alle Sunday 25 January 2004 17:21, Adrian Bunk ha scritto:
> 
> >
> > What's your gcc version ("gcc --version")?
> 
> gcc (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)
> 
> 
> >
> > Could you back out ("patch -p1 -R < ..." or manually remove the lines)
> > the patch below and retry?
> 
> Yep, and now it works :)
> Now I'm running  2.6.1-mm4, tested both UP and SMP (SMT) and it boots just 
> fine. Later I'll try with more recents releases, but I'm pretty sure that 
> these will work.
> 
> Many thanks, the patch has solved this issue :)


Many thanks to Eric and you for your help in tracking the problem down!


@Andi,Andrew:

It seems use-funit-at-a-time breaks with distributions shipping a gcc
3.3 that supports -funit-at-a-time.

Th patch below replaces use-funit-at-a-time.patch and uses 
scripts/gcc-version.sh from add-config-for-mregparm-3-ng* to use 
-funit-at-a-time only with gcc >= 3.4 .

cu
Adrian


--- linux-2.6.2-rc1-mm3/Makefile.old	2004-01-25 18:22:25.000000000 +0100
+++ linux-2.6.2-rc1-mm3/Makefile	2004-01-25 18:26:56.000000000 +0100
@@ -441,6 +441,15 @@
 CFLAGS		+= -g
 endif
 
+# Enable unit-at-a-time mode when possible. It shrinks the
+# kernel considerably.
+#
+# Check the gcc version since -funit-at-a-time is available since gcc 3.4,
+# but some distributions ship a gcc 3.3 patched with a broken
+# -funit-at-a-time implementation
+GCC_VERSION = $(shell $(CONFIG_SHELL) scripts/gcc-version.sh $(CC))
+CFLAGS += $(shell if [ $(GCC_VERSION) -ge 0304 ] ; then echo "-funit-at-a-time"; fi ;)
+
 # warn about C99 declaration after statement
 CFLAGS += $(call check_gcc,-Wdeclaration-after-statement,)
 


