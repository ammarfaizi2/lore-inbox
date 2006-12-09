Return-Path: <linux-kernel-owner+w=401wt.eu-S937668AbWLIUld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937668AbWLIUld (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 15:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937669AbWLIUlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 15:41:32 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:51003 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937668AbWLIUlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 15:41:32 -0500
Date: Sat, 9 Dec 2006 12:41:08 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, khc@pm.waw.pl, davem@davemloft.net
Subject: [PATCH] fix WAN routers kconfig dependency
Message-Id: <20061209124108.a25bb375.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Currently WAN router drivers can be built in-kernel while the
register/unregister_wan_device interfaces are built as modules.
This causes:

drivers/built-in.o: In function `cycx_init':
cycx_main.c:(.init.text+0x5c4b): undefined reference to `register_wan_device'
drivers/built-in.o: In function `cycx_exit':
cycx_main.c:(.exit.text+0x560): undefined reference to `unregister_wan_device'
make: *** [.tmp_vmlinux1] Error 1

The problem is caused by tristate -> bool conversion (y or m => y),
so convert WAN_ROUTER_DRIVERS to a tristate so that the correct
dependency is preserved.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/net/wan/Kconfig |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.19-git13.orig/drivers/net/wan/Kconfig
+++ linux-2.6.19-git13/drivers/net/wan/Kconfig
@@ -382,7 +382,7 @@ config SDLA
 
 # Wan router core.
 config WAN_ROUTER_DRIVERS
-	bool "WAN router drivers"
+	tristate "WAN router drivers"
 	depends on WAN && WAN_ROUTER
 	---help---
 	  Connect LAN to WAN via Linux box.
@@ -393,7 +393,8 @@ config WAN_ROUTER_DRIVERS
 	  <file:Documentation/networking/wan-router.txt>.
 
 	  Note that the answer to this question won't directly affect the
-	  kernel: saying N will just cause the configurator to skip all
+	  kernel except for how subordinate drivers may be built:
+	  saying N will just cause the configurator to skip all
 	  the questions about WAN router drivers.
 
 	  If unsure, say N.


---
