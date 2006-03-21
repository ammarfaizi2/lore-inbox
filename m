Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWCUQ1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWCUQ1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWCUQVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:20 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29452 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932376AbWCUQVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:11 -0500
Cc: Jan Beulich <jbeulich@novell.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 13/46] kbuild: fix mkmakefile
In-Reply-To: <1142958055873-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <11429580553691-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the current way of generating the Makefile in the output directory
for builds outside of the source tree, specifying real targets (rather
than phony ones) doesn't work in an already (partially) built tree, as
the stub Makefile doesn't have any dependency information available.
Thus, all targets where files may actually exist must be listed
explicitly and, due to what I'd call a make misbehavior, directory
targets must then also be special cased.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mkmakefile |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

96678281bfaa5f04752a98f9b93454041169fd3b
diff --git a/scripts/mkmakefile b/scripts/mkmakefile
index c4d621b..a22cbed 100644
--- a/scripts/mkmakefile
+++ b/scripts/mkmakefile
@@ -21,11 +21,13 @@ KERNELOUTPUT := $2
 
 MAKEFLAGS += --no-print-directory
 
+.PHONY: all \$(MAKECMDGOALS)
+
 all:
 	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT)
 
-%::
-	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT) \$@
+Makefile:;
 
+\$(filter-out all Makefile,\$(MAKECMDGOALS)) %/:
+	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT) \$@
 EOF
-
-- 
1.0.GIT


