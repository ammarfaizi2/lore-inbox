Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVAQWn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVAQWn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbVAQWXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:23:51 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:9832 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262910AbVAQWAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:00:20 -0500
Date: Mon, 17 Jan 2005 23:00:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild: Implicit dependence on the C compiler
Message-ID: <20050117220052.GB18293@mars.ravnborg.org>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
References: <cshbd7$nff$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cshbd7$nff$1@terminus.zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 09:40:55PM +0000, H. Peter Anvin wrote:
> Okay, this is driving me utterly crazy...
> 
> How the heck do I get kbuild to *not* think that because I'm using a
> different C compiler (including "gcc" versus "distcc"), or I'm on a
> different host, that it has to rebuild every single object file in my
> directory?  This is an unbelievable headache.

It better be difficult. You want to recompile when changing gcc.
Try this untested patch.

There is no way to tell kbuild "ignore gcc change"

	Sam


===== Makefile.lib 1.27 vs edited =====
--- 1.27/scripts/Makefile.lib	2004-10-27 00:06:46 +02:00
+++ edited/Makefile.lib	2005-01-17 22:58:44 +01:00
@@ -187,9 +187,7 @@
 # >'< substitution is for echo to work, >$< substitution to preserve $ when reloading .cmd file
 # note: when using inline perl scripts [perl -e '...$$t=1;...'] in $(cmd_xxx) double $$ your perl vars
 
-if_changed = $(if $(strip $? \
-		          $(filter-out $(cmd_$(1)),$(cmd_$@))\
-			  $(filter-out $(cmd_$@),$(cmd_$(1)))),\
+if_changed = \
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))';) \
 	$(cmd_$(1)); \
@@ -199,9 +197,7 @@
 # execute the command and also postprocess generated .d dependencies
 # file
 
-if_changed_dep = $(if $(strip $? $(filter-out FORCE $(wildcard $^),$^)\
-		          $(filter-out $(cmd_$(1)),$(cmd_$@))\
-			  $(filter-out $(cmd_$@),$(cmd_$(1)))),\
+if_changed_dep = \ 
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))';) \
 	$(cmd_$(1)); \
@@ -213,9 +209,7 @@
 # will check if $(cmd_foo) changed, or any of the prequisites changed,
 # and if so will execute $(rule_foo)
 
-if_changed_rule = $(if $(strip $? \
-		               $(filter-out $(cmd_$(1)),$(cmd_$@))\
-			       $(filter-out $(cmd_$@),$(cmd_$(1)))),\
+if_changed_rule = \
 			@set -e; \
 			$(rule_$(1)))
 
