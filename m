Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267944AbUHPU3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267944AbUHPU3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267946AbUHPU3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:29:36 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:17964 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267944AbUHPU3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:29:33 -0400
Date: Tue, 17 Aug 2004 00:29:34 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild + kconfig: Updates
Message-ID: <20040816222934.GA26768@mars.ravnborg.org>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040815201224.GI7682@mars.ravnborg.org> <20040815204229.GJ12308@parcelfarce.linux.theplanet.co.uk> <20040816204550.GA20956@mars.ravnborg.org> <20040816200159.GK12308@parcelfarce.linux.theplanet.co.uk> <20040816222005.GB24450@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816222005.GB24450@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 12:20:05AM +0200, Sam Ravnborg wrote:
> > 
> > Uhh...  It ends up running sparse *twice* and still runs gcc on every
> > file.

This one should be better.

On the sparse topic. Do you see anything against
introducing CHECKFLAGS?
CHECKFLAGS would be assigned the sparse specific flags in
arch/*/Makefile.

I see no reason to introduce EXTRA_CHECKFLAGS, CHECKFLAGS_$(F*)
as known from CFLAGS, AFLAGS. But I like the split into CHECKFLAGS.
That should allow me to do:
make CHECK=my_hacked_sparse C=2

	Sam


===== scripts/Makefile.build 1.47 vs edited =====
--- 1.47/scripts/Makefile.build	2004-08-15 21:54:06 +02:00
+++ edited/scripts/Makefile.build	2004-08-17 00:23:52 +02:00
@@ -83,8 +83,13 @@
 
 # Linus' kernel sanity checking tool
 ifneq ($(KBUILD_CHECKSRC),0)
-quiet_cmd_checksrc = CHECK   $<
-      cmd_checksrc = $(CHECK) $(c_flags) $< ;
+  ifeq ($(KBUILD_CHECKSRC),2)      
+    quiet_cmd_force_checksrc = CHECK   $<
+          cmd_force_checksrc = $(CHECK) $(c_flags) $< ;
+  else  
+    quiet_cmd_checksrc = CHECK   $<
+          cmd_checksrc = $(CHECK) $(c_flags) $< ;
+  endif
 endif
 
 
@@ -182,11 +187,13 @@
 # Built-in and composite module parts
 
 %.o: %.c FORCE
+	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
 # Single-part modules are special since we need to mark them in $(MODVERDIR)
 
 $(single-used-m): %.o: %.c FORCE
+	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 	@{ echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
 
