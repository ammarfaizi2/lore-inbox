Return-Path: <linux-kernel-owner+w=401wt.eu-S932152AbXAOJf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbXAOJf1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 04:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbXAOJf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 04:35:27 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:36192 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbXAOJf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 04:35:26 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HZ9ftVcVdkgwi4LoSrfETrcOBRgIWOSF4l7Rs6IGReXyFf+ipgSrAr7+QRw4xQanAHYDS5P3Zj3k6unctGCqXox11vfOQmm9vET16aDNtUC8KmLhqqqIvNUXsOLIXR4Xq/ePonIM/zL2ndHx7MplvlEBJgdJG2Sp+nfGMPleSbo=
Message-ID: <6bb9c1030701150135x173f95c0lb67247b641137367@mail.gmail.com>
Date: Mon, 15 Jan 2007 10:35:25 +0100
From: "Pelle Svensson" <pelle2004@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Skeleton, Makefile extension - Separate source tree with only valid source files
Cc: "Sam Ravnborg" <sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did some hacks to the Makefile which might be of interest for those who
feel like there are too many source files in the Linux tree. Running following
make will create a separate directory including only the files which are
active i.e. they are include in the final build configuration.

source = /home/john/src/linux-2.6.20
build_dir = /home/john/src/linux-2.6.20-build
edit_dir = /home/john/src/linux-2.6.20-edit

cd $(source)
make O=$(build_dir) ACTIVE_SRC=$(edit_dir) active_srctree

Links will be create in $(edit_dir) and what ever IDE that are in use for
editing should target the $(edit_dir). The good thing is that grep will only
hit valid files not 50 other files which are not in my interest.


Due to lack of time this is not complete. Phrasing the dependency need to
be added for all the include files.


Part added to root Makefile
==================

# Generate source tree with only active files based on the configuration
# ---------------------------------------------------------------------------

ifneq ($(ACTIVE_SRCTREE),)
edittree	:= $(ACTIVE_SRCTREE)
edittree-alldir	:= $(subst usr,,$(vmlinux-alldirs))
edittree-alldir	:= $(addprefix $(edittree)/, $(edittree-alldir) )
endif

PHONY += active_srctree validate_active_srctree $(edittree-alldir)

validate_active_srctree:
	$(if $(ACTIVE_SRCTREE),, $(error Must define ACTIVE_SRCTREE=...))
	
$(edittree-alldir):
	$(Q) $(MAKE) -f $(srctree)/scripts/Makefile.srctree
edittree=$(edittree) srctree=$(srctree) dst=$@

active_srctree: validate_active_srctree $(edittree-alldir)


New file created scripts/Makefile.srctree
============================

# ==========================================================================
# Building a source tree consisting of links into main source.
# Links are only created for files currently in use by the configuration
# ==========================================================================

#src := $(src)
sdir := $(subst $(edittree)/,,$(dst))
sdir := $(subst %/,%,$(sdir))

PHONY := link
link:

# Read .config if it exist, otherwise ignore
-include include/config/auto.conf

include $(srctree)/scripts/Kbuild.include

include $(srctree)/$(sdir)/Makefile

__subdir-y	:= $(patsubst %/,%,$(filter %/, $(obj-y)))
subdir-y	+= $(__subdir-y)
__subdir-m	:= $(patsubst %/,%,$(filter %/, $(obj-m)))
subdir-m	+= $(__subdir-m)

subdir-ym	:= $(sort $(subdir-y) $(subdir-m))
subdir-ym	:= $(addprefix $(sdir)/, $(subdir-ym))

obj-y		:= $(filter-out %/, $(obj-y))
obj-m		:= $(filter-out %/, $(obj-m))

obj-names := $(patsubst %.o,%,$(obj-y) $(obj-m) $(head-y))
obj-names := $(filter-out /% , $(obj-names))
src-files := $(addprefix $(srctree)/$(sdir)/, $(obj-names))
src-files := $(wildcard $(addsuffix .*, $(src-files)))
dst-files := $(subst $(srctree)/,,$(src-files))
dst-files := $(addprefix $(edittree)/, $(dst-files))

link: $(dst-files) $(subdir-ym)

$(dst-files): $(edittree)/%: $(srctree)/%
	$(Q) mkdir -p $(@D)
	$(Q) if test -f $@; then touch $@; else cp -l $< $@; fi

# Descending
# ---------------------------------------------------------------------------

PHONY += $(subdir-ym)
$(subdir-ym):
	$(Q) $(MAKE) -f $(srctree)/scripts/Makefile.srctree
edittree=$(edittree) srctree=$(srctree) dst=$@

# ---------------------------------------------------------------------------

.PHONY: $(PHONY)

# ---------------------------------------------------------------------------
