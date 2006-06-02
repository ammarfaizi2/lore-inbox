Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWFBB2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWFBB2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWFBB2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:28:53 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:18920 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751075AbWFBB2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:28:53 -0400
From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] obj-dirs is calculated incorrectly if hostprogs-y is defined
Date: Thu, 01 Jun 2006 21:28:50 -0400
To: linux-kernel@vger.kernel.org
Message-Id: <20060602012850.19981.41444.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Roskin <proski@gnu.org>

When Makefile.host is included, $(obj-dirs) is subjected to the
addprefix operation for the second time.  Prefix only needs to be added
to the newly added directories, but not to those that came from
Makefile.lib.

This causes the build system to create unneeded empty directories in the
build tree when building in a separate directory.  For instance,
lib/lib/zlib_inflate is created in the build tree.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 scripts/Makefile.host |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 2d51970..2b066d1 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -33,8 +33,8 @@ # Note: Shared libraries consisting of C
 __hostprogs := $(sort $(hostprogs-y)$(hostprogs-m))
 
 # hostprogs-y := tools/build may have been specified. Retreive directory
-obj-dirs += $(foreach f,$(__hostprogs), $(if $(dir $(f)),$(dir $(f))))
-obj-dirs := $(strip $(sort $(filter-out ./,$(obj-dirs))))
+host-objdirs := $(foreach f,$(__hostprogs), $(if $(dir $(f)),$(dir $(f))))
+host-objdirs := $(strip $(sort $(filter-out ./,$(host-objdirs))))
 
 
 # C code
@@ -73,7 +73,9 @@ host-cxxmulti	:= $(addprefix $(obj)/,$(h
 host-cxxobjs	:= $(addprefix $(obj)/,$(host-cxxobjs))
 host-cshlib	:= $(addprefix $(obj)/,$(host-cshlib))
 host-cshobjs	:= $(addprefix $(obj)/,$(host-cshobjs))
-obj-dirs        := $(addprefix $(obj)/,$(obj-dirs))
+host-objdirs    := $(addprefix $(obj)/,$(host-objdirs))
+
+obj-dirs += $(host-objdirs)
 
 #####
 # Handle options to gcc. Support building with separate output directory

