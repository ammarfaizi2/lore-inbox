Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWAOV0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWAOV0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWAOV0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:26:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:16402 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750900AbWAOV0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:26:05 -0500
Date: Sun, 15 Jan 2006 22:26:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kbuild: fix make -jN with multiple targets with make O=...
Message-ID: <20060115212602.GB26627@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[It is pushed out at:
git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git]

The way multiple targets was handled with make O=...
broke because for each high-level target make spawned
a parallel make resulting in a broken build.
Reported by Keith Owens <kaos@ocs.com.au>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

296e0855b0f9a4ec9be17106ac541745a55b2ce1
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
-- 
1.0.GIT



