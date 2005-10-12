Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVJLQ55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVJLQ55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVJLQ55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:57:57 -0400
Received: from smtpout.mac.com ([17.250.248.45]:4062 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932368AbVJLQ55 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:57:57 -0400
X-PGP-Universal: processed;
	by AlPB on Wed, 12 Oct 2005 11:57:57 -0500
Date: Wed, 12 Oct 2005 11:57:47 -0500
From: Mark Rustad <MRustad@mac.com>
Subject: Re: KBuild problem (or difference) in 2.6.14-rc3
To: linux-kernel@vger.kernel.org
X-Priority: 3
Message-ID: <r02010300-1042-5106A5323B4111DAA5280011248907EC@[10.64.61.32]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Mailer: Mailsmith 2.1.3 (Blindsider)
In-Reply-To: <A7D1D429-D1C7-4FBD-80F2-B3EDFF9E2200@mac.com>
References: <A7D1D429-D1C7-4FBD-80F2-B3EDFF9E2200@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that I have found and fixed the problem that I encountered yesterday with Makefiles not being used from the objects directory. I also verified that the same problem exists in 2.6.14-rc4. I believe that the following patch fixes it.


Signed-off-by: Mark Rustad <mrustad@mac.com>

--- a/scripts/Makefile.build	2005-10-11 09:27:42.150471811 -0500
+++ b/scripts/Makefile.build	2005-10-11 11:28:10.748640516 -0500
@@ -12,7 +12,11 @@
 
 # The filename Kbuild has precedence over Makefile
 kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
-include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
+kbuild-inc := $(wildcard $(obj)/Kbuild)
+kbuild-inc := $(if $(kbuild-inc),$(kbuild-inc),$(wildcard $(kbuild-dir)/Kbuild))
+kbuild-inc := $(if $(kbuild-inc),$(kbuild-inc),$(wildcard $(obj)/Makefile))
+kbuild-inc := $(if $(kbuild-inc),$(kbuild-inc),$(kbuild-dir)/Makefile)
+include $(kbuild-inc)
 
 include scripts/Kbuild.include
 include scripts/Makefile.lib
--- a/scripts/Makefile.clean	2005-10-11 09:27:42.150471811 -0500
+++ b/scripts/Makefile.clean	2005-10-11 11:28:20.622769436 -0500
@@ -14,7 +14,11 @@
 
 # The filename Kbuild has precedence over Makefile
 kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
-include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
+kbuild-inc := $(wildcard $(obj)/Kbuild)
+kbuild-inc := $(if $(kbuild-inc),$(kbuild-inc),$(wildcard $(kbuild-dir)/Kbuild))
+kbuild-inc := $(if $(kbuild-inc),$(kbuild-inc),$(wildcard $(obj)/Makefile))
+kbuild-inc := $(if $(kbuild-inc),$(kbuild-inc),$(kbuild-dir)/Makefile)
+include $(kbuild-inc)
 
 # Figure out what we need to build from the various variables
 # ==========================================================================


I also encountered a build error with 2.6.14-rc4 when CONFIG_KALLSYMS is not defined. The error message in a fragment of the output was:

  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
/bin/sh: line 1: +@: command not found
make[3]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
  CHK     include/linux/compile.h

The following patch seems to fix it.


Signed-off-by: Mark Rustad <mrustad@mac.com>

--- a/Makefile	2005-10-12 10:42:37.787722969 -0500
+++ b/Makefile	2005-10-12 10:42:58.396913248 -0500
@@ -662,6 +662,7 @@
 # Generate System.map and verify that the content is consistent
 
 define rule_vmlinux__
+	:
 	$(if $(CONFIG_KALLSYMS),,+$(call cmd,vmlinux_version))
 
 	$(call cmd,vmlinux__)

-- 
Mark Rustad, mrustad@mac.com
