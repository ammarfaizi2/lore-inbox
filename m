Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWF1PFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWF1PFG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWF1PFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:05:05 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:25545 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1751123AbWF1PFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:05:02 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] fix kbuild module names (was: Re: oom-killer problem)
Date: Wed, 28 Jun 2006 17:06:15 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606281706.15514.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-03.tornado.cablecom.ch 1378;
	Body=3 Fuz1=3 Fuz2=3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

had a look again. this one on top of "kbuild: fix make -rR breakage" (ie. revert
the revert) should fix the module nameing.

Sam if you agree, please add your signed-off-by and forward to Linus.

rgds
-daniel

---

[PATCH] kbuild: fix module names

commit e5c44fd88c146755da6941d047de4d97651404a9 (kbuild: fix make -rR breakage)
replaced the usage of the $(*F) variable with $(basetarget) which is defined as
	 basetarget = $(basename $(notdir $@))
to get the same, but without using the stem $(*F) because make not always
correctly supplys it. the problem are the module names which depend on the name
of 'foo.mod.o'. the original usage of the stem $(*F) gave 'foo' in this case, but
the new $(basetarget) does not. example from a
	make -p SUBDIRS=drivers/pcmcia modules

	drivers/pcmcia/pcmcia.mod.o: drivers/pcmcia/pcmcia.mod.c FORCE
	#  Implicit rule search has not been done.
	#  Implicit/static pattern stem: `drivers/pcmcia/pcmcia'
	#  Last modified 2006-06-28 16:00:14
	#  File has been updated.
	#  Successfully updated.
	# automatic
	# @ := drivers/pcmcia/pcmcia.mod.o
	# automatic
	# % :=
	# automatic
	# * := drivers/pcmcia/pcmcia
	[snip]

so the stem for 'drivers/pcmcia/pcmcia.mod.o' is just 'drivers/pcmcia/pcmcia' which
gives the correct module name. so to get back the "old" behaviour without using the
stem do an additional patsubst to get rid of the '.mod'

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index ac5f275..af3c1b6 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -15,7 +15,7 @@ depfile = $(subst $(comma),_,$(@D)/.$(@F
 ###
 # basetarget equals the filename of the target with no extension.
 # So 'foo/bar.o' becomes 'bar'
-basetarget = $(basename $(notdir $@))
+basetarget = $(patsubst %.mod,%,$(basename $(notdir $@)))
 
 ###
 # Escape single quote for use in echo statements



