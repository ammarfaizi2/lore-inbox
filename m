Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVKUNyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVKUNyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 08:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVKUNyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 08:54:31 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:35737 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932127AbVKUNyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 08:54:31 -0500
Date: Mon, 21 Nov 2005 14:54:20 +0100
From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
To: James Cloos <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] Re: make kernelrelease ignoring LOCALVERSION_AUTO
Message-ID: <20051121135420.GA10389@informatik.uni-freiburg.de>
References: <m3acfz88qj.fsf@lugabout.cloos.reno.nv.us> <m3mzjy7sg2.fsf@lugabout.cloos.reno.nv.us> <20051121105353.GC6664@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121105353.GC6664@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.6+20040523i
Organization: Universitaet Freiburg, Institut f. Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Zeisberger wrote:
> James Cloos wrote:
> > Whatever the solution, it is commit ac4d5f74a9b243d9f3f123fe5ce609478df208d8
> > that breaks $(make kernelrelease).
> That's true, I recently realized that, too, but didn't find the time to
> react.
> 
> In my eyes the solution has to be that .config is included iff it
> exists.

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

-- 
Uwe Zeisberger

primes where sieve (p:xs) = [ x | x<-xs, x `rem` p /= 0 ]; \
primes = map head (iterate sieve [2..])
