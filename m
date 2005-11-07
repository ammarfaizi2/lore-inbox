Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVKGKNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVKGKNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVKGKNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:13:31 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:30188 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964809AbVKGKNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:13:31 -0500
Date: Mon, 7 Nov 2005 11:13:16 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, thang@redhat.com, linux-kernel@vger.kernel.org,
       Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH] kbuild updates
In-Reply-To: <20051106132111.GA9042@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0511071102380.12843@scrub.home>
References: <20051106101844.GA11921@mars.ravnborg.org>
 <Pine.LNX.4.61.0511061341290.12843@scrub.home> <20051106132111.GA9042@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 6 Nov 2005, Sam Ravnborg wrote:

> On Sun, Nov 06, 2005 at 01:44:32PM +0100, Roman Zippel wrote:
> > 
> > What exactly is the problem? How does Fedora use QTLIB?
> 
> See:
>  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=137926

I'm not really happy with this patch. I don't really like relying on 
QTLIB, it's a really ugly hack.
If the nonextisting ../lib64 dir is the problem, I'd more prefer a patch 
like this:

Index: linux-2.6/scripts/kconfig/Makefile
===================================================================
--- linux-2.6.orig/scripts/kconfig/Makefile	2005-11-06 00:27:29.000000000 +0100
+++ linux-2.6/scripts/kconfig/Makefile	2005-11-07 11:08:58.000000000 +0100
@@ -162,9 +164,10 @@ $(obj)/.tmp_qtcheck:
 	  echo "*"; \
 	  false; \
 	fi; \
-	LIBPATH=$$DIR/lib; LIB=qt; \
+	LIBPATH=$$DIR/lib; LIB=qt; osdir=""; \
 	$(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
-	  LIBPATH=$$DIR/lib/$$($(HOSTCXX) -print-multi-os-directory); \
+	  osdir=$$($(HOSTCXX) -print-multi-os-directory); \
+	if [ -d $$LIBPATH/$$osdir ]; then LIBPATH=$$LIBPATH/$$osdir; fi; \
 	if [ -f $$LIBPATH/libqt-mt.so ]; then LIB=qt-mt; fi; \
 	echo "QTDIR=$$DIR" > $@; echo "QTLIBPATH=$$LIBPATH" >> $@; \
 	echo "QTLIB=$$LIB" >> $@; \

Does this also solve the problem?

bye, Roman
