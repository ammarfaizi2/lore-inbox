Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267876AbUHPSti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267876AbUHPSti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267875AbUHPSr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:47:59 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:25492 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267876AbUHPSpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:45:52 -0400
Date: Mon, 16 Aug 2004 22:45:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild + kconfig: Updates
Message-ID: <20040816204550.GA20956@mars.ravnborg.org>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040815201224.GI7682@mars.ravnborg.org> <20040815204229.GJ12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815204229.GJ12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 09:42:29PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Speaking of kbuild, is there any reasonable way to do check-only runs?
> Simple "set CC et.al. to scripts that will create target and do nothing
> else" doesn't work for obvious reasons - we have some stuff that really
> has to be compiled (e.g. empty.c + some arch-dependent files).  Same
> goes for make -n C=1 | grep sparse | ... variants.

Usage:
make C=2

===== scripts/Makefile.build 1.47 vs edited =====
--- 1.47/scripts/Makefile.build	2004-08-15 21:54:06 +02:00
+++ edited/scripts/Makefile.build	2004-08-16 22:38:51 +02:00
@@ -85,6 +85,9 @@
 ifneq ($(KBUILD_CHECKSRC),0)
 quiet_cmd_checksrc = CHECK   $<
       cmd_checksrc = $(CHECK) $(c_flags) $< ;
+  ifeq ($(KBUILD_CHECKSRC),2)      
+    cmd_force_checksrc = $(call cmd,checksrc)
+  endif
 endif
 
 
@@ -182,11 +185,13 @@
 # Built-in and composite module parts
 
 %.o: %.c FORCE
+	$(cmd_force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
 # Single-part modules are special since we need to mark them in $(MODVERDIR)
 
 $(single-used-m): %.o: %.c FORCE
+	$(cmd_force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 	@{ echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
 

That should do it?
I will push this if you are OK with it.

> 
> Another thing that would be very nice to have: analog of allmodconfig with
> some options pre-set.  Trivial cases can be hanlded by patching Kconfig
> (basically, adding depends on BROKEN), but IWBN to have something like
> make allmodconfig PRESET=<file that looks like a subset of .config>...

Agree. Discussed a long time ago if we should introduce
preprocessed _defconfig files, but people told me
there were too little in common.

IIRC it is possible just to add to a .config file, and then the last
assignment will decide.
But I have not tested it since long time ago so I may be wrong.

	Sam
