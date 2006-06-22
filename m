Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWFVSbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWFVSbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWFVSbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:31:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:53950 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030348AbWFVSao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:30:44 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 6/14] [PATCH] w1: Make w1 connector notifications depend on connector.
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:10 -0700
Message-Id: <11510008583492-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510008553417-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com> <11510008461301-git-send-email-greg@kroah.com> <11510008522327-git-send-email-greg@kroah.com> <11510008553417-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

Make w1 connector notifications depend on connector.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/Kconfig      |   14 +++++++++++++-
 drivers/w1/Makefile     |    4 ----
 drivers/w1/w1_netlink.c |    4 +---
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/w1/Kconfig b/drivers/w1/Kconfig
index 5e61ed5..0c6c435 100644
--- a/drivers/w1/Kconfig
+++ b/drivers/w1/Kconfig
@@ -3,7 +3,7 @@ menu "Dallas's 1-wire bus"
 config W1
 	tristate "Dallas's 1-wire support"
 	---help---
-	  Dallas's 1-wire bus is useful to connect slow 1-pin devices
+	  Dallas' 1-wire bus is useful to connect slow 1-pin devices
 	  such as iButtons and thermal sensors.
 
 	  If you want W1 support, you should say Y here.
@@ -11,6 +11,18 @@ config W1
 	  This W1 support can also be built as a module.  If so, the module
 	  will be called wire.ko.
 
+config W1_CON
+	depends on CONNECTOR
+	bool "Userspace communication over connector"
+	default y
+	--- help ---
+	  This allows to communicate with userspace using connector [Documentation/connector].
+	  There are three types of messages between w1 core and userspace:
+	  1. Events. They are generated each time new master or slave device found
+		either due to automatic or requested search.
+	  2. Userspace commands. Includes read/write and search/alarm search comamnds.
+	  3. Replies to userspace commands.
+
 source drivers/w1/masters/Kconfig
 source drivers/w1/slaves/Kconfig
 
diff --git a/drivers/w1/Makefile b/drivers/w1/Makefile
index f0465c2..93845a2 100644
--- a/drivers/w1/Makefile
+++ b/drivers/w1/Makefile
@@ -2,10 +2,6 @@ #
 # Makefile for the Dallas's 1-wire bus.
 #
 
-ifeq ($(CONFIG_CONNECTOR), n)
-EXTRA_CFLAGS	+= -DNETLINK_DISABLED
-endif
-
 ifeq ($(CONFIG_W1_DS2433_CRC), y)
 EXTRA_CFLAGS	+= -DCONFIG_W1_F23_CRC
 endif
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index d48f3ac..d539e09 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -27,7 +27,7 @@ #include "w1.h"
 #include "w1_log.h"
 #include "w1_netlink.h"
 
-#ifndef NETLINK_DISABLED
+#if defined(CONFIG_W1_CON) && (defined(CONFIG_CONNECTOR) || (defined(CONFIG_CONNECTOR_MODULE) && defined(CONFIG_W1_MODULE)))
 void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
 {
 	char buf[sizeof(struct cn_msg) + sizeof(struct w1_netlink_msg)];
@@ -230,8 +230,6 @@ void w1_fini_netlink(void)
 	cn_del_callback(&w1_id);
 }
 #else
-#warning Netlink support is disabled. Please compile with NET support enabled.
-
 void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
 {
 }
-- 
1.4.0

