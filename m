Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUIKQ3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUIKQ3x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 12:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268191AbUIKQ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 12:29:53 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5087 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S268077AbUIKQ3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 12:29:50 -0400
Date: Sat, 11 Sep 2004 09:29:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-rc1-bk16] ppc32: Use $(addprefix ...) on arch/ppc/boot/lib/
Message-ID: <20040911162946.GB11438@smtp.west.cox.net>
References: <20040909153031.GA2945@smtp.west.cox.net> <20040909163705.GA7830@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909163705.GA7830@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resubmitting as this is still missing and thus zImage/et al fail when
MODVERSIONS=y ]
On Thu, Sep 09, 2004 at 06:37:05PM +0200, Sam Ravnborg wrote:
> On Thu, Sep 09, 2004 at 08:30:31AM -0700, Tom Rini wrote:
> > The following makes arch/ppc/boot/lib/Makefile use $(addprefix ...) to
> > get lib/zlib_inflate/ source code.  Previously we were manually setting
> > the dependancy and invoking cc_o_c.  Worse, we were invoking the cmd
> > version, not the rule version and thus when MODVERSIONS=y, we wouldn't
> > do the .tmp_foo.o -> foo.o rename, and thus the compile would break.
> > Using $(addprefix ...) gets us using the standard rules again (and is
> > shorter to boot).
> 
> Your patch was pending my comments - sorry.
> 
> 
> Why not:
> 
> lib-y := $(addprefix lib/zlib_inflate/,infblock.o infcodes.o inffast.o \
>                                        inflate.o inftrees.o infutil.o)
> lib-y += div64.o
> lib-$(CONFIG_VGA_CONSOLE) += vreset.o kbd.o
> 
> No need to use that ugly relative path.

If that works, OK.  The example Al Viro pointed me at was
arch/arm/boot/compressed/Makefile.

> I do not like this way of selectng .o files. It will so
> obviously break the build with make -j if there is no synchronisation
> point. vmlinux provide this synchronisation point in this case.
> But in this particular case I see no better alternative.

How hard would it be make some sort of synchronisation point?  I know
SuSE folks who always build with -j5.

Switch arch/ppc/boot/lib/Makefile to $(addprefix ...) for zlib_inflate

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.7/arch/ppc/boot/lib/Makefile	2004-09-07 23:33:06 -07:00
+++ edited/arch/ppc/boot/lib/Makefile	2004-09-09 10:05:34 -07:00
@@ -4,18 +4,7 @@
 
 CFLAGS_kbd.o	+= -Idrivers/char
 
-$(obj)/infblock.o: lib/zlib_inflate/infblock.c
-	$(call cmd,cc_o_c)
-$(obj)/infcodes.o: lib/zlib_inflate/infcodes.c
-	$(call cmd,cc_o_c)
-$(obj)/inffast.o: lib/zlib_inflate/inffast.c
-	$(call cmd,cc_o_c)
-$(obj)/inflate.o: lib/zlib_inflate/inflate.c
-	$(call cmd,cc_o_c)
-$(obj)/inftrees.o: lib/zlib_inflate/inftrees.c
-	$(call cmd,cc_o_c)
-$(obj)/infutil.o: lib/zlib_inflate/infutil.c
-	$(call cmd,cc_o_c)
-
-lib-y := infblock.o infcodes.o inffast.o inflate.o inftrees.o infutil.o div64.o
+lib-y := $(addprefix lib/zlib_inflate/,infblock.o infcodes.o inffast.o \
+				       inflate.o inftrees.o infutil.o)
+lib-y += div64.o
 lib-$(CONFIG_VGA_CONSOLE) += vreset.o kbd.o

-- 
Tom Rini
http://gate.crashing.org/~trini/
