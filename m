Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVIJUd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVIJUd4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVIJUd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:33:56 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:43621 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932285AbVIJUdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:33:55 -0400
Date: Sat, 10 Sep 2005 22:35:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 3/7] kbuild: adjust .version updating
Message-ID: <20050910203531.GC29334@mars.ravnborg.org>
References: <20050910200347.GA3762@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910200347.GA3762@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to maintain a more correct build number, updates to the
version
number should only be commited after a successful link of vmlinux, not
before (so that errors in the link process don't lead to pointless
increments).

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

4e25d8bb9550fb5912165196fe8502cdb831a336
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -641,8 +641,13 @@ quiet_cmd_vmlinux__ ?= LD      $@
 # Generate new vmlinux version
 quiet_cmd_vmlinux_version = GEN     .version
       cmd_vmlinux_version = set -e;                     \
-	. $(srctree)/scripts/mkversion > .tmp_version;	\
-	mv -f .tmp_version .version;			\
+	if [ ! -r .version ]; then			\
+	  rm -f .version;				\
+	  echo 1 >.version;				\
+	else						\
+	  mv .version .old_version;			\
+	  expr 0$$(cat .old_version) + 1 >.version;	\
+	fi;						\
 	$(MAKE) $(build)=init
 
 # Generate System.map
@@ -756,6 +761,7 @@ endif # ifdef CONFIG_KALLSYMS
 # vmlinux image - including updated kernel symbols
 vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) $(kallsyms.o) FORCE
 	$(call if_changed_rule,vmlinux__)
+	$(Q)rm -f .old_version
 
 # The actual objects are generated when descending, 
 # make sure no implicit rule kicks in

