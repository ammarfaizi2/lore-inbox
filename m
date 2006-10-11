Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWJKV2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWJKV2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWJKVFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:05:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:14494 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161386AbWJKVEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:04:42 -0400
Date: Wed, 11 Oct 2006 14:03:39 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jeff Dike <jdike@addtoit.com>,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/67] uml: use DEFCONFIG_LIST to avoid reading hosts config
Message-ID: <20061011210339.GD16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="uml-use-defconfig_list-to-avoid-reading-host-s-config.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This should make sure that, for UML, host's configuration files are not
considered, which avoids various pains to the user. Our dependency are such that
the obtained Kconfig will be valid and will lead to successful compilation -
however they cannot prevent an user from disabling any boot device, and if an
option is not set in the read .config (say /boot/config-XXX), with make
menuconfig ARCH=um, it is not set. This always disables UBD and all console I/O
channels, which leads to non-working UML kernels, so this bothers users -
especially now, since it will happen on almost every machine
(/boot/config-`uname -r` exists almost on every machine). It can be workarounded
with make defconfig ARCH=um, but it is non-obvious and can be avoided, so please
_do_ merge this patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Acked-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/Kconfig |    5 +++++
 init/Kconfig    |    1 +
 2 files changed, 6 insertions(+)

--- linux-2.6.18.orig/arch/um/Kconfig
+++ linux-2.6.18/arch/um/Kconfig
@@ -1,3 +1,8 @@
+config DEFCONFIG_LIST
+	string
+	option defconfig_list
+	default "arch/$ARCH/defconfig"
+
 # UML uses the generic IRQ sugsystem
 config GENERIC_HARDIRQS
 	bool
--- linux-2.6.18.orig/init/Kconfig
+++ linux-2.6.18/init/Kconfig
@@ -1,5 +1,6 @@
 config DEFCONFIG_LIST
 	string
+	depends on !UML
 	option defconfig_list
 	default "/lib/modules/$UNAME_RELEASE/.config"
 	default "/etc/kernel-config"

--
