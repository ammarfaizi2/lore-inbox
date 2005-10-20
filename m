Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbVJTPCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbVJTPCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbVJTPCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:02:47 -0400
Received: from smtpout.mac.com ([17.250.248.46]:3009 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751540AbVJTPCq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:02:46 -0400
X-PGP-Universal: processed;
	by AlPB on Thu, 20 Oct 2005 10:02:42 -0500
Date: Thu, 20 Oct 2005 10:02:37 -0500
From: Mark Rustad <MRustad@mac.com>
Subject: [PATCH 2.6.14-rc4] kbuild: once again use Makefiles in obj tree
To: linux-kernel@vger.kernel.org
cc: Sam Ravnborg <sam@ravnborg.org>
X-Priority: 3
Message-ID: <r02010500-1042-8E035B2F417A11DA8DF80011248907EC@[10.64.61.29]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Mailer: Mailsmith 2.1.5 (Blindsider)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a re-send of a patch that I mistakenly only sent to Sam. This reflects a simplfication
of an earlier patch to restore the use of Makefiles from the objects tree, which is something
that stopped working somewhere in 2.6.14. The previous patch had extended the behavior for Kbuild
files, whereas this patch does not do that.

Sam,

On 10/16/05 at 11:15 PM Sam Ravnborg <sam@ravnborg.org> wrote:

>On Fri, Oct 14, 2005 at 09:23:28AM -0500, Mark Rustad wrote:
>> I believe that I have found and fixed the problem that I encountered earlier this week
>> with Makefiles not being used from the objects tree as they had been in every 2.6 kernel
>> I have worked with since 2.6.5. I I view this as a regression in 2.6.14-rc4. I believe
>> that the following patch fixes it.
>
>Hi Mark.
>kbuild will not guarantee you way of working in all cases. Therefore no
>special implementation will be accepted to try to support it for
>specific files.
>
>The changes you point out that breaks your working methodology was added
>to fix broken support for external modules.

I tested the (slightly) simplified patch today and it seems fine. So, this checks for Kbuild
files in one place, and Makefile in two, thereby not extending the behavior that Makefiles
had prior to 2.6.14-rc* to Kbuild files.

Below is the patch I tried today. Please consider it.


This patch restores behavior that the build system had up through 2.6.13.
That is, that Makefiles present in the objects tree are used in favor of
those in the source tree when an objects tree is in use.

This patch does not extend that behavior for Kbuild files.

Signed-off-by: Mark Rustad <mrustad@mac.com>
---

--- a/scripts/Makefile.build	2005-10-11 09:27:42.000000000 -0500
+++ b/scripts/Makefile.build	2005-10-18 09:11:22.042672607 -0500
@@ -12,7 +12,10 @@ __build:
 
 # The filename Kbuild has precedence over Makefile
 kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
-include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
+kbuild-inc := $(wildcard $(kbuild-dir)/Kbuild)
+kbuild-inc := $(if $(kbuild-inc),$(kbuild-inc),$(wildcard $(obj)/Makefile))
+kbuild-inc := $(if $(kbuild-inc),$(kbuild-inc),$(kbuild-dir)/Makefile)
+include $(kbuild-inc)
 
 include scripts/Kbuild.include
 include scripts/Makefile.lib
--- a/scripts/Makefile.clean	2005-10-11 09:27:42.000000000 -0500
+++ b/scripts/Makefile.clean	2005-10-18 09:11:44.165706089 -0500
@@ -14,7 +14,10 @@ clean := -f $(if $(KBUILD_SRC),$(srctree
 
 # The filename Kbuild has precedence over Makefile
 kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
-include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
+kbuild-inc := $(wildcard $(kbuild-dir)/Kbuild)
+kbuild-inc := $(if $(kbuild-inc),$(kbuild-inc),$(wildcard $(obj)/Makefile))
+kbuild-inc := $(if $(kbuild-inc),$(kbuild-inc),$(kbuild-dir)/Makefile)
+include $(kbuild-inc)
 
 # Figure out what we need to build from the various variables
 # ==========================================================================

-- 
Mark Rustad, mrustad@mac.com
