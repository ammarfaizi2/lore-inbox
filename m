Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWG0KRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWG0KRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 06:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWG0KRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 06:17:11 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:3564 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932116AbWG0KRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 06:17:10 -0400
Date: Thu, 27 Jul 2006 12:17:09 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [WARNING -mm] 2.6.18-rc2-mm1 build kills /dev/null!?
Message-ID: <20060727101709.GB31920@rhlx01.fht-esslingen.de>
References: <20060727101128.GA31920@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727101128.GA31920@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 27, 2006 at 12:11:28PM +0200, Andreas Mohr wrote:
> Hello all,
> 
> for some reason a 2.6.18-rc2-mm1 build seems to kill my /dev/null device!

Replying to myself, this could easily be due to:

--- linux-2.6.18-rc2/scripts/Kbuild.include     2006-07-15 21:41:08.000000000 -
0700
+++ devel/scripts/Kbuild.include        2006-07-27 01:15:54.000000000 -0700
@@ -8,9 +8,13 @@ empty   :=
 space   := $(empty) $(empty)

 ###
+# Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
+dot-target = $(dir $@).$(notdir $@)
+
+###
 # The temporary file to save gcc -MD generated dependencies must not
 # contain a comma
-depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
+depfile = $(subst $(comma),_,$(dot-target).d)

 ###
 # filename of target with directory and extension stripped
@@ -59,6 +63,12 @@ as-option = $(shell if $(CC) $(CFLAGS) $
             -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; \
             else echo "$(2)"; fi ;)

+# as-instr
+# Usage: cflags-y += $(call as-instr, instr, option1, option2)
+
+as-instr = $(shell if echo -e "$(1)" | $(AS) -Z -o /dev/null \
+                  2>&1 >/dev/null ; then echo "$(2)"; else echo "$(3)"; fi;)
+
 # cc-option
 # Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)

@@ -77,14 +87,19 @@ cc-option-align = $(subst -functions=0,,

 # cc-version
 # Usage gcc-ver := $(call cc-version, $(CC))
-cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
-              $(if $(1), $(1), $(CC)))
+cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))

 # cc-ifversion
 # Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
 cc-ifversion = $(shell if [ $(call cc-version, $(CC)) $(1) $(2) ]; then \
                        echo $(3); fi;)

+# ld-option
+# Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
+ld-option = $(shell if $(CC) $(1) \
+                            -nostdlib -o /dev/null -xc /dev/null \
+             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+


Possibly an older binutils doesn't have a "if *output* file /dev/null,
then kill output instead of overwriting file" check builtin as IIRC newer
utils often have?

# which ld
/usr/bin/ld

# rpm -qf /usr/bin/ld
binutils-2.15.92.0.2-5

Andreas Mohr
