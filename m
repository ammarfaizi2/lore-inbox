Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751753AbVLBH3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbVLBH3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 02:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbVLBH3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 02:29:06 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:26549 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751753AbVLBH3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 02:29:05 -0500
Date: Fri, 2 Dec 2005 08:28:40 +0100
From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Zachary Amsden <zach@vmware.com>, Russell King <rmk@arm.linux.org.uk>,
       James Cloos <cloos@jhcloos.com>
Subject: Re: [PATCH] Kbuild fixes
Message-ID: <20051202072840.GA3063@informatik.uni-freiburg.de>
References: <20051110213640.GA19831@mars.ravnborg.org> <jehd9s6azn.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jehd9s6azn.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.6+20040523i
Organization: Universitaet Freiburg, Institut f. Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Andreas,

Andreas Schwab wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> > Author: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
> >
> >     [PATCH] kbuild: make kernelrelease in unconfigured kernel prints an error
> >     
> >     Do not include .config for target kernelrelease
> 
> This is wrong.  KERNELRELEASE depends on CONFIG_LOCALVERSION, thus you
> need .config.
James Cloos already indicated that on lkml[1].  I prepared a patch but
didn't sent it to lkml.

Maybe you're happy with the following patch, too?  With it .config is
included if it exists and no error occurs if not.

{{{
Include .config for target kernelrelease if it exists

With this fix the value of CONFIG_LOCALVERSION is appended to the output
of `make kernelrelease`.  The git tag is *not* appended (yet) without a
.config.

Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

---

 Makefile |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

applies-to: bf816f7c7055127415fc3b718e260855df815d55
02a17e7669dcc6abd51fefc65af2278e95e4855f
diff --git a/Makefile b/Makefile
index e7a0443..77b51b8 100644
--- a/Makefile
+++ b/Makefile
@@ -407,16 +407,23 @@ outputmakefile:
 # Detect when mixed targets is specified, and make a second invocation
 # of make so .config is not included in this case either (for *config).
 
-no-dot-config-targets := clean mrproper distclean \
-			 cscope TAGS tags help %docs check% kernelrelease
+no-dot-config-targets  := clean mrproper distclean \
+			  cscope TAGS tags help %docs check%
+
+opt-dot-config-targets := kernelrelease
 
 config-targets := 0
 mixed-targets  := 0
 dot-config     := 1
+opt-dot-config := 0
 
-ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
+ifneq ($(filter $(no-dot-config-targets) $(opt-dot-config-targets), $(MAKECMDGOALS)),)
 	ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
 		dot-config := 0
+	else
+		ifeq ($(filter-out $(opt-dot-config-targets), $(MAKECMDGOALS)),)
+			opt-dot-config := 1
+		endif
 	endif
 endif
 
@@ -483,7 +490,11 @@ ifeq ($(dot-config),1)
 # oldconfig if changes are detected.
 -include .config.cmd
 
+ifeq ($(opt-dot-config),1)
+-include .config
+else
 include .config
+endif
 
 # If .config needs to be updated, it will be done via the dependency
 # that autoconf has on .config.
---
0.99.9g
}}}

[1] http://groups.google.com/group/linux.kernel/browse_thread/thread/25b426027bf5fdba/e5931ac731528c1f?q=Cloos&rnum=2#e5931ac731528c1f

-- 
Uwe Zeisberger

http://www.google.com/search?q=sin%28pi%2F2%29
