Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265918AbUAPWjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUAPWjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:39:16 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:35850 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265918AbUAPWjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 17:39:10 -0500
Date: Fri, 16 Jan 2004 23:40:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ashish sddf <buff_boulder@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ kernel module + Makefile
Message-ID: <20040116224056.GA3227@mars.ravnborg.org>
Mail-Followup-To: Ashish sddf <buff_boulder@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Does anyone can ideas about how to change the kernel
> makefile to compile the C++ files the same way as C
> files ?

I assume you know the general opinion on C++ in the kernel - even in a module.
I just did a quick untested hack - try this. It assumes extension .cc for
c++ files.
You also need to define CXX in top level makefile and export it.
This patch will _not_ be pushed into mainline.

	Sam

===== scripts/Makefile.build 1.41 vs edited =====
--- 1.41/scripts/Makefile.build	Sun Oct  5 08:50:46 2003
+++ edited/scripts/Makefile.build	Fri Jan 16 23:39:26 2004
@@ -174,6 +174,23 @@
 %.o: %.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
+# C++ support
+      cmd_cc_o_cpp = $(CXX) $(c_flags) -c -o $@ $<
+quiet_cmd_cc_o_cpp = C++    $@
+
+define rule_cc_o_cpp
+	$(if $($(quiet)cmd_checksrc),echo '  $($(quiet)cmd_checksrc)';)   \
+	$(cmd_checksrc)							  \
+	$(if $($(quiet)cmd_cc_o_cpp),echo '  $($(quiet)cmd_cc_o_cpp)';)	  \
+	$(cmd_cc_o_cpp);						  \
+	scripts/fixdep $(depfile) $@ '$(cmd_cc_o_cpp)' > $(@D)/.$(@F).tmp;  \
+	rm -f $(depfile);						  \
+	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd
+endef
+
+%.o: %.cc FORCE
+	$(call if_changed_rule,cc_o_cpp)
+
 # Single-part modules are special since we need to mark them in $(MODVERDIR)
 
 $(single-used-m): %.o: %.c FORCE
