Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUJRVCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUJRVCr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUJRVCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:02:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:61833 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267360AbUJRVCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:02:19 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: using cc-option in arch/ppc64/boot/Makefile
Date: Mon, 18 Oct 2004 15:58:38 +0000
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200410141611.32198.hollisb@us.ibm.com> <200410181347.55746.hollisb@us.ibm.com> <20041018210128.GA16283@mars.ravnborg.org>
In-Reply-To: <20041018210128.GA16283@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410181558.38286.hollisb@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 October 2004 21:01, Sam Ravnborg wrote:
> Skip the include of Mafilefile.lib and try again. If you still has troubles
> try posting a complete diff.

Complete diff:

===== arch/ppc64/boot/Makefile 1.25 vs edited =====
--- 1.25/arch/ppc64/boot/Makefile       Sun Oct  3 12:23:50 2004
+++ edited/arch/ppc64/boot/Makefile     Mon Oct 18 14:24:50 2004
@@ -72,7 +72,12 @@
 quiet_cmd_stripvm = STRIP $@
       cmd_stripvm = $(STRIP) -s $< -o $@

+HAS_BIARCH      := $(call cc-option-yn, -lalala)
+
 vmlinux.strip: vmlinux FORCE
+       echo $(cc-option-yn)
+       echo $(HAS_BIARCH)
+       $(call cc-option-yn, -m64)
        $(call if_changed,stripvm)
 $(obj)/vmlinux.initrd: vmlinux.strip $(obj)/addRamDisk 
$(obj)/ramdisk.image.gz FORCE
        $(call if_changed,ramdisk)
===== scripts/Makefile.lib 1.26 vs edited =====
--- 1.26/scripts/Makefile.lib   Sun Aug 15 05:17:51 2004
+++ edited/scripts/Makefile.lib Wed Oct 13 14:13:38 2004
@@ -232,3 +232,28 @@
 # Usage:
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.build obj
+
+######
+# cc support functions to be used (only) in arch/$(ARCH)/Makefile
+# See documentation in Documentation/kbuild/makefiles.txt
+
+# cc-option
+# Usage: cflags-y += $(call gcc-option, -march=winchip-c6, -march=i586)
+
+cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
+             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
+
+# For backward compatibility
+check_gcc = $(warning check_gcc is deprecated - use cc-option) \
+            $(call cc-option, $(1),$(2))
+
+# cc-option-yn
+# Usage: flag := $(call gcc-option-yn, -march=winchip-c6)
+cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null 
\
+                > /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
+
+# cc-version
+# Usage gcc-ver := $(call cc-version $(CC))
+cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
+              $(if $(1), $(1), $(CC)))
+


Output:
...
make -f scripts/Makefile.build obj=arch/ppc64/boot arch/ppc64/boot/zImage
echo y
y
echo

y
make[1]: y: Command not found


-- 
Hollis Blanchard
IBM Linux Technology Center
