Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755087AbWKRPxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbWKRPxm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 10:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755137AbWKRPxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 10:53:42 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:61582 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1755087AbWKRPxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 10:53:42 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 18 Nov 2006 16:52:29 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.19-rc5-mm2] fs/dlm: fix recursive dependency in Kconfig
To: cluster-devel@redhat.com
cc: linux-kernel@vger.kernel.org, Patrick Caulfield <pcaulfie@redhat.com>,
       David Teigland <teigland@redhat.com>, Andrew Morton <akpm@osdl.org>
Message-ID: <tkrat.c2d67cf7278af0e7@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make xconfig says
"Warning! Found recursive dependency: INET IPV6 DLM (null) DLM_TCP INET"

Seems to be another example of how badly the "select" keyword is handled
by the .config make targets. Replace all occurences of "select" in dlm's
Kconfig by "depends on" and some additional help texts.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 fs/dlm/Kconfig |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

Index: linux-2.6.19-rc5-mm2/fs/dlm/Kconfig
===================================================================
--- linux-2.6.19-rc5-mm2.orig/fs/dlm/Kconfig	2006-11-18 13:25:31.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/dlm/Kconfig	2006-11-18 16:40:21.000000000 +0100
@@ -1,14 +1,22 @@
 menu "Distributed Lock Manager"
 	depends on EXPERIMENTAL
 
+comment "DLM requires CONFIGFS_FS in section 'Pseudo filesystems'"
+	depends on CONFIGFS_FS=n
+
+comment "DLM requires at least one of INET and IP_SCTP in section 'Networking'"
+	depends on !(INET || IP_SCTP)
+
 config DLM
 	tristate "Distributed Lock Manager (DLM)"
-	depends on IPV6 || IPV6=n
-	select CONFIGFS_FS
+	depends on (IPV6 || IPV6=n) && (INET || IP_SCTP) && CONFIGFS_FS
 	help
 	A general purpose distributed lock manager for kernel or userspace
 	applications.
 
+	If you want to link DLM statically instead of as a module, configure
+	IPV6 as statically linked too or switch it off.
+
 choice
 	prompt "Select DLM communications protocol"
 	depends on DLM
@@ -18,13 +26,17 @@ choice
 	SCTP supports multi-homed operations whereas TCP doesn't.
 	However, SCTP seems to have stability problems at the moment.
 
+	Activate INET (TCP/IP networking) in the Networking section
+	to be able to use DLM over TCP.  Activate SCTP in the
+	Networking section to use DLM over SCTP.
+
 config DLM_TCP
 	bool "TCP/IP"
-	select INET
+	depends on INET
 
 config DLM_SCTP
 	bool "SCTP"
-	select IP_SCTP
+	depends on IP_SCTP
 
 endchoice
 


