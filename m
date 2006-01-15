Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWAOREa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWAOREa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWAOREa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:04:30 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:14609 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751053AbWAORE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:04:29 -0500
Date: Sun, 15 Jan 2006 18:04:25 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 make fails with multiple targets in parallel
Message-ID: <20060115170425.GA21527@mars.ravnborg.org>
References: <13394.1136968751@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13394.1136968751@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 07:39:11PM +1100, Keith Owens wrote:
> Running make on the kernel tree with multiple targets on the command
> line and in parallel mode gets errors.
Hi Keith.
Can you please try attached patch.
It does the right thing here with:
make -j 24 O=~/o all vmlinux modules prepare bzImage

	Sam

diff --git a/Makefile b/Makefile
index deedaf7..b3dd9db 100644
--- a/Makefile
+++ b/Makefile
@@ -106,12 +106,13 @@ KBUILD_OUTPUT := $(shell cd $(KBUILD_OUT
 $(if $(KBUILD_OUTPUT),, \
      $(error output directory "$(saved-output)" does not exist))
 
-.PHONY: $(MAKECMDGOALS)
+.PHONY: $(MAKECMDGOALS) cdbuilddir
+$(MAKECMDGOALS) _all: cdbuilddir
 
-$(filter-out _all,$(MAKECMDGOALS)) _all:
+cdbuilddir:
 	$(if $(KBUILD_VERBOSE:1=),@)$(MAKE) -C $(KBUILD_OUTPUT) \
 	KBUILD_SRC=$(CURDIR) \
-	KBUILD_EXTMOD="$(KBUILD_EXTMOD)" -f $(CURDIR)/Makefile $@
+	KBUILD_EXTMOD="$(KBUILD_EXTMOD)" -f $(CURDIR)/Makefile $(MAKECMDGOALS)
 
 # Leave processing to above invocation of make
 skip-makefile := 1
