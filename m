Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUFENnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUFENnf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 09:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUFENnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 09:43:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:55176 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261369AbUFENnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 09:43:32 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Symlinks for building external modules
Date: Sat, 5 Jun 2004 15:45:07 +0200
User-Agent: KMail/1.6.2
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
References: <200406031858.09178.agruen@suse.de> <20040604192304.GB3530@mars.ravnborg.org> <yw1xy8n3yun6.fsf@kth.se>
In-Reply-To: <yw1xy8n3yun6.fsf@kth.se>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200406051545.07507.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 June 2004 21:45, Måns Rullgård wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> > Andreas - please expalin why you want build to be a symlink, and not
> > the directory used when actually building the kernel.
>
> I can't speak for Andreas, but I prefer to keep my root filesystem as
> clean as possible.  Often it's mounted read-only.

Either way would work, but I prefer to have the actual files below /usr/src.
The /lib directory is meant for files required during boot, whereas /usr may 
be mounted later. If we want to allow both possibilities, we probably want to 
add the following check:

Index: linux-2.6.7-rc2/Makefile
===================================================================
--- linux-2.6.7-rc2.orig/Makefile
+++ linux-2.6.7-rc2/Makefile
@@ -735,7 +735,8 @@ _modinst_:
        @rm -f $(MODLIB)/{source,build}
        @mkdir -p $(MODLIB)/kernel
        @ln -s $(srctree) $(MODLIB)/source
-       @ln -s $(objtree) $(MODLIB)/build
+       @[ $(objtree) -ef  $(MODLIB)/build ] \
+               || ln -s $(objtree) $(MODLIB)/build
        $(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst


Next, we may want to add a Makefile to the output directory so that external 
modules will build the same way they did before, without specifying the 
source tree separately:

Index: linux-2.6.7-rc2/Makefile
===================================================================
--- linux-2.6.7-rc2.orig/Makefile
+++ linux-2.6.7-rc2/Makefile
@@ -125,11 +125,19 @@ ifeq ($(skip-makefile),)
 # but instead _all depend on modules
 .PHONY: all
 ifeq ($(KBUILD_EXTMOD),)
-_all: all
+_all: $(objtree)/Makefile all
 else
 _all: modules
 endif

+.PHONY: $(objtree)/Makefile
+$(objtree)/Makefile:
+       $(Q)if [ ! $(srctree) -ef $(objtree) ]; then \
+               ( echo "modules modules_install clean:" ; \
+                 echo -e "\t\$$(MAKE) -C $(srctree) \$$@ O=\$$(CURDIR)" \
+               ) > $(objtree)/Makefile ; \
+       fi
+
 # Make sure we're not wasting cpu-cycles doing locale handling, yet do make
 # sure error messages appear in the user-desired language
 ifdef LC_ALL


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
