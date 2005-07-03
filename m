Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVGCTUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVGCTUM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVGCTUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:20:12 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:60004 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261499AbVGCTUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:20:00 -0400
Date: Sun, 3 Jul 2005 21:22:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.12] Add -Wno-pointer-sign to HOSTCFLAGS
Message-ID: <20050703192224.GB8052@mars.ravnborg.org>
References: <200506190923.j5J9Nbq0011676@harpo.it.uu.se> <11208.1119177144@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11208.1119177144@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >cc-option checks to see if the flag is supported by $(CC) which could
> >be a completely different compiler from $(HOSTCC).  Hence the above
> >can incorrectly supply/fail to supply the argument.
> 
> Good point.  New patch.

I am having this patch queued:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/04/03 22:26:47+02:00 sam@mars.ravnborg.org 
#   kbuild: Use -Wno-pointer-sign when building for host
#   
#   Avoid lot's of useless warning when building host utilities.
#   A brave sould may take a look sometime - but not all warnings are correct.
#   
#   From: Pawel Sikora <pluto@pld-linux.org>
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# Makefile
#   2005/04/03 22:26:24+02:00 sam@mars.ravnborg.org +12 -4
#   -Wno-pointer-sign for gcc 4.xx when compiling host programs
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2005-04-30 00:35:17 +02:00
+++ b/Makefile	2005-04-30 00:35:17 +02:00
@@ -201,10 +201,10 @@
 	  else if [ -x /bin/bash ]; then echo /bin/bash; \
 	  else echo sh; fi ; fi)
 
-HOSTCC  	= gcc
-HOSTCXX  	= g++
-HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-HOSTCXXFLAGS	= -O2
+HOSTCC  	:= gcc
+HOSTCXX  	:= g++
+HOSTCFLAGS	:= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+HOSTCXXFLAGS	:= -O2
 
 # 	Decide whether to build built-in, modular, or both.
 #	Normally, just do built-in.
@@ -538,6 +538,14 @@
 
 # disable pointer signedness warnings in gcc 4.0
 CFLAGS += $(call cc-option,-Wno-pointer-sign,)
+
+HOSTCFLAGS += $(shell if $(HOSTCC) $(HOSTCFLAGS) -Wno-pointer-sign -S \
+              -o /dev/null -xc /dev/null > /dev/null 2>&1; then \
+               echo "-Wno-pointer-sign"; fi ;)
+
+HOSTCXXFLAGS += $(shell if $(HOSTCXX) $(HOSTCXXFLAGS) -Wno-pointer-sign -S \
+              -o /dev/null -xc /dev/null > /dev/null 2>&1; then \
+               echo "-Wno-pointer-sign"; fi ;)
 
 # Default kernel image to build when no specific target is given.
 # KBUILD_IMAGE may be overruled on the commandline or
