Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVK2U3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVK2U3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVK2U3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:29:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932383AbVK2U3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:29:21 -0500
Date: Tue, 29 Nov 2005 13:30:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org, jbglaw@lug-owl.de, torvalds@osdl.org
Subject: Re: [PATCH 2.6.15-rc2-git6] Fix tar-pkg target
Message-Id: <20051129133042.6d344110.akpm@osdl.org>
In-Reply-To: <20051128170414.GA10601@harddisk-recovery.nl>
References: <20051128170414.GA10601@harddisk-recovery.nl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> wrote:
>
> The various tar-pkg Makefile targets forget to apply the
> CONFIG_LOCALVERSION_AUTO to the vminux and System.map files because the
> script (scripts/package/buildtar) doesn't know about it. This can be
> fixed by computing the correct "version" variable, but it's better to
> use the one computed by Kbuild itself, just like the like the
> "builddeb" and "mkspec" scripts do.
> 
> Without this patch, "make tar-pkg" would generate a file
> linux-2.6.15-rc2.tar containing vmlinuz-2.6.15-rc2. With this patch, it
> generates linux-2.6.15-rc2-g458af543.tar containing
> vmlinuz-2.6.15-rc2-g458af543.
> 
> ...
> --- a/scripts/package/buildtar
> +++ b/scripts/package/buildtar
> @@ -15,7 +15,7 @@ set -e
>  #
>  # Some variables and settings used throughout the script
>  #
> -version="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}${EXTRANAME}"
> +version="${KERNELRELEASE}"


I already have the below queued up, which is a bit different.  Does it work
OK?



From: Brian Gerst <bgerst@didntduck.org>

Clean up two more open-coded uses of KERNELRELEASE.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/frv/boot/Makefile   |    4 ++--
 scripts/package/buildtar |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/frv/boot/Makefile~use-kernelrelease arch/frv/boot/Makefile
--- devel/arch/frv/boot/Makefile~use-kernelrelease	2005-11-27 21:56:54.000000000 -0800
+++ devel-akpm/arch/frv/boot/Makefile	2005-11-27 21:56:54.000000000 -0800
@@ -57,10 +57,10 @@ initrd:
 # installation
 #
 install: $(CONFIGURE) Image
-	sh ./install.sh $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) Image $(TOPDIR)/System.map "$(INSTALL_PATH)"
+	sh ./install.sh $(KERNELRELEASE) Image $(TOPDIR)/System.map "$(INSTALL_PATH)"
 
 zinstall: $(CONFIGURE) zImage
-	sh ./install.sh $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) zImage $(TOPDIR)/System.map "$(INSTALL_PATH)"
+	sh ./install.sh $(KERNELRELEASE) zImage $(TOPDIR)/System.map "$(INSTALL_PATH)"
 
 #
 # miscellany
diff -puN scripts/package/buildtar~use-kernelrelease scripts/package/buildtar
--- devel/scripts/package/buildtar~use-kernelrelease	2005-11-27 21:56:54.000000000 -0800
+++ devel-akpm/scripts/package/buildtar	2005-11-27 21:56:54.000000000 -0800
@@ -15,7 +15,7 @@ set -e
 #
 # Some variables and settings used throughout the script
 #
-version="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}${EXTRANAME}"
+version="${KERNELRELEASE}${EXTRANAME}"
 tmpdir="${objtree}/tar-install"
 tarball="${objtree}/linux-${version}.tar"
 
_

