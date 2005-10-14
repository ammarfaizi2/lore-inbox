Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVJNOXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVJNOXj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 10:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVJNOXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 10:23:38 -0400
Received: from smtpout.mac.com ([17.250.248.73]:47810 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750755AbVJNOXi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 10:23:38 -0400
X-PGP-Universal: processed;
	by AlPB on Fri, 14 Oct 2005 09:23:39 -0500
Date: Fri, 14 Oct 2005 09:23:28 -0500
From: Mark Rustad <MRustad@mac.com>
Subject: [PATCH 2.6.14-rc4] kbuild: once again use Makefiles in obj tree
To: linux-kernel@vger.kernel.org
X-Priority: 3
Message-ID: <r02010500-1042-1784C9C83CBE11DA99900011248907EC@[10.64.61.29]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Mailer: Mailsmith 2.1.5 (Blindsider)
In-Reply-To: <A7D1D429-D1C7-4FBD-80F2-B3EDFF9E2200@mac.com>
References: <A7D1D429-D1C7-4FBD-80F2-B3EDFF9E2200@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that I have found and fixed the problem that I encountered earlier this week
with Makefiles not being used from the objects tree as they had been in every 2.6 kernel
I have worked with since 2.6.5. I I view this as a regression in 2.6.14-rc4. I believe
that the following patch fixes it.


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


Signed-off-by: Mark Rustad <mrustad@mac.com>
