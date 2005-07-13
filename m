Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVGMSDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVGMSDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVGMSDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:03:24 -0400
Received: from [151.97.230.9] ([151.97.230.9]:15084 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261545AbVGMSAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:00:33 -0400
Subject: [patch 6/9] uml: reintroduce pcap support
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 13 Jul 2005 20:02:31 +0200
Message-Id: <20050713180232.149E721E743@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The pcap support was not working because of some linking problems (expressing
the construct in Kbuild was a bit difficult) and because there was no user
request. Now that this has come back, here's the support.

This has been tested and works on both 32 and 64-bit hosts, even when
"cross-"building 32-bit binaries.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/arch/um/Kconfig_net      |    2 +-
 linux-2.6.git-broken-paolo/arch/um/Makefile         |   14 +++++++++-----
 linux-2.6.git-broken-paolo/arch/um/drivers/Makefile |   17 ++++++++++++++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff -puN arch/um/drivers/Makefile~uml-reallow-pcap arch/um/drivers/Makefile
--- linux-2.6.git-broken/arch/um/drivers/Makefile~uml-reallow-pcap	2005-07-13 19:43:05.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/drivers/Makefile	2005-07-13 19:43:30.000000000 +0200
@@ -10,7 +10,6 @@ slip-objs := slip_kern.o slip_user.o
 slirp-objs := slirp_kern.o slirp_user.o
 daemon-objs := daemon_kern.o daemon_user.o
 mcast-objs := mcast_kern.o mcast_user.o
-#pcap-objs := pcap_kern.o pcap_user.o $(PCAP)
 net-objs := net_kern.o net_user.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
 hostaudio-objs := hostaudio_kern.o
@@ -18,6 +17,17 @@ ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
 
+LDFLAGS_pcap.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libpcap.a)
+
+$(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
+	$(LD) -r -dp -o $@ $^ $(LDFLAGS) $(LDFLAGS_pcap.o)
+#XXX: The call below does not work because the flags are added before the
+# object name, so nothing from the library gets linked.
+#$(call if_changed,ld)
+
+# When the above is fixed, don't forget to add this too!
+#targets := $(obj)/pcap.o
+
 obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
@@ -26,7 +36,7 @@ obj-$(CONFIG_UML_NET_SLIP) += slip.o sli
 obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
 obj-$(CONFIG_UML_NET_MCAST) += mcast.o 
-#obj-$(CONFIG_UML_NET_PCAP) += pcap.o $(PCAP)
+obj-$(CONFIG_UML_NET_PCAP) += pcap.o
 obj-$(CONFIG_UML_NET) += net.o 
 obj-$(CONFIG_MCONSOLE) += mconsole.o
 obj-$(CONFIG_MMAPPER) += mmapper_kern.o 
@@ -41,6 +51,7 @@ obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
 
-USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o
+# pcap_user.o must be added explicitly.
+USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o
 
 include arch/um/scripts/Makefile.rules
diff -puN arch/um/Kconfig_net~uml-reallow-pcap arch/um/Kconfig_net
--- linux-2.6.git-broken/arch/um/Kconfig_net~uml-reallow-pcap	2005-07-13 19:43:05.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Kconfig_net	2005-07-13 19:43:05.000000000 +0200
@@ -135,7 +135,7 @@ config UML_NET_MCAST
 
 config UML_NET_PCAP
 	bool "pcap transport"
-	depends on UML_NET && BROKEN
+	depends on UML_NET && EXPERIMENTAL
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making 
diff -puN arch/um/Makefile~uml-reallow-pcap arch/um/Makefile
--- linux-2.6.git-broken/arch/um/Makefile~uml-reallow-pcap	2005-07-13 19:43:05.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Makefile	2005-07-13 19:43:05.000000000 +0200
@@ -56,17 +56,21 @@ include $(srctree)/$(ARCH_DIR)/Makefile-
 core-y += $(SUBARCH_CORE)
 libs-y += $(SUBARCH_LIBS)
 
-# -Derrno=kernel_errno - This turns all kernel references to errno into
-# kernel_errno to separate them from the libc errno.  This allows -fno-common
-# in CFLAGS.  Otherwise, it would cause ld to complain about the two different
-# errnos.
+# -Dvmap=kernel_vmap affects everything, and prevents anything from
+# referencing the libpcap.o symbol so named.
 
 CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
-	$(ARCH_INCLUDE) $(MODE_INCLUDE)
+	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
 	$(MODE_INCLUDE) $(ARCH_USER_CFLAGS)
+
+# -Derrno=kernel_errno - This turns all kernel references to errno into
+# kernel_errno to separate them from the libc errno.  This allows -fno-common
+# in CFLAGS.  Otherwise, it would cause ld to complain about the two different
+# errnos.
+
 CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask
 CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
_
