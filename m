Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbUJaVpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUJaVpc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUJaVov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:44:51 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:10551 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261666AbUJaVjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:39:53 -0500
Date: Sun, 31 Oct 2004 23:39:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Roland Dreier <roland@topspin.com>, sam@ravnborg.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH/take 2] ppc: fix build with O=$(output_dir)
Message-ID: <20041031223949.GB21471@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Roland Dreier <roland@topspin.com>, sam@ravnborg.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <52is979pah.fsf@topspin.com> <20041019164449.GF6298@smtp.west.cox.net> <521xfua835.fsf_-_@topspin.com> <20041019182928.GA12544@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019182928.GA12544@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 11:29:28AM -0700, Tom Rini wrote:
 
> This misses the bit to invoke the checker as well (when I first thought
> this up I poked Al Viro about the general question of checker on boot
> code, and he wanted it, so...).  And having 2 'magic' rules not just 1
> is why I don't like this too much and was hoping Sam would have some
> idea of a good fix.

Hi Tom.

Finally took a look.
The best approach is to grab a copy of the .c file and compile
that in this dir.
In this way we avoid unessesary recompile etc. but waste a bit disk space.
I do not like symlinks in general and made a copy. (note: uses cat to give
appropriate permission)

If you are OK with this let me know if you want me to push it to linus
or you go via the ppc tree.

PS: Had troubles with kbd so commented out.

	Sam

===== Makefile 1.11 vs edited =====
--- 1.11/arch/ppc/boot/lib/Makefile	2004-10-25 21:47:48 +02:00
+++ edited/Makefile	2004-10-31 23:37:23 +01:00
@@ -2,9 +2,22 @@
 # Makefile for some libs needed by zImage.
 #
 
-CFLAGS_kbd.o	+= -Idrivers/char
+CFLAGS_kbd.o	:= -Idrivers/char
+CFLAGS_vreset.o := -I$(srctree)/arch/ppc/boot/include
 
-lib-y := $(addprefix ../../../../lib/zlib_inflate/, \
-           infblock.o infcodes.o inffast.o inflate.o inftrees.o infutil.o)
-lib-y += div64.o
-lib-$(CONFIG_VGA_CONSOLE) += vreset.o kbd.o
+zlib  := infblock.c infcodes.c inffast.c inflate.c inftrees.c infutil.c
+	 
+lib-y += $(zlib:.c=.o) div64.o
+lib-$(CONFIG_VGA_CONSOLE) += vreset.o #kbd.o
+
+
+# zlib files needs header from their original place
+EXTRA_CFLAGS += -Ilib/zlib_inflate
+
+quiet_cmd_copy_zlib = COPY    $@
+      cmd_copy_zlib = cat $< > $@
+
+$(addprefix $(obj)/,$(zlib)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
+	$(call cmd,copy_zlib)
+
+clean-files := $(zlib)
