Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVIKCcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVIKCcG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 22:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVIKCcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 22:32:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:23431 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932410AbVIKCcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 22:32:05 -0400
Date: Sun, 11 Sep 2005 03:32:03 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050911023203.GH25261@ZenIV.linux.org.uk>
References: <20050911012033.5632152f.sfr@canb.auug.org.au> <20050910161917.GA22113@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910161917.GA22113@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 06:19:17PM +0200, Sam Ravnborg wrote:
> On Sun, Sep 11, 2005 at 01:20:33AM +1000, Stephen Rothwell wrote:
> > The latest Linus-git tree generates asm-offsets.h in the source tree even
> > if you use O=... I don't know how to fix this, but it means that the
> > source tree cannot be read only.
> My bad. I checked it compiled, not where it saved the file.
> I will have a fix tonight.

BTW, early build stages on uml with O= are still broken, even with that
patch.  The following fixes them, but first chunk is a bad kludge.

What happens:
	a) silentconfig expects to have include/linux in build tree already
created.  Normally that happens earlier, but only by accident.  We need to
force that somehow and the way I'd done it is almost certainly wrong - it
should be in top-level makefile, to start with.  Suggestions?
	b) kernel-offsets.h needs symlinks already in place.  prepare1 does
everything we need, so that dependency is probably the right thing (the second
chunk).

diff -urN RC13-git10-base/arch/um/Makefile current/arch/um/Makefile
--- RC13-git10-base/arch/um/Makefile	2005-09-10 19:28:53.000000000 -0400
+++ current/arch/um/Makefile	2005-09-10 18:34:51.000000000 -0400
@@ -213,6 +213,8 @@
          echo "#endif" )
 endef
 
+include/linux/autoconf.h : include/linux/version.h
+
 $(ARCH_DIR)/include/uml-config.h : include/linux/autoconf.h
 	$(call filechk,umlconfig)
 
@@ -227,9 +229,8 @@
 $(ARCH_DIR)/kernel-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/kernel-offsets.c \
 				   $(ARCH_SYMLINKS) \
 				   $(SYS_DIR)/sc.h \
-				   include/asm include/linux/version.h \
-				   include/config/MARKER \
-				   $(ARCH_DIR)/include/user_constants.h
+				   $(ARCH_DIR)/include/user_constants.h \
+				   prepare1
 	$(CC) $(CFLAGS) $(NOSTDINC_FLAGS) $(CPPFLAGS) -S -o $@ $<
 
 $(ARCH_DIR)/kernel-offsets.h: $(ARCH_DIR)/kernel-offsets.s
