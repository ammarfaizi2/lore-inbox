Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWFNABt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWFNABt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWFNABs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:01:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:18346 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964807AbWFNABr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:01:47 -0400
Subject: [PATCH 04/11] Task watchers:  Make process events configurable as
	a module
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
References: <20060613235122.130021000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:54:42 -0700
Message-Id: <1150242882.21787.144.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes process events so that it may be configured as a module. 

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
--

 drivers/connector/Kconfig   |    8 ++++----
 drivers/connector/cn_proc.c |   18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

Index: linux-2.6.17-rc6-mm2/drivers/connector/Kconfig
===================================================================
--- linux-2.6.17-rc6-mm2.orig/drivers/connector/Kconfig
+++ linux-2.6.17-rc6-mm2/drivers/connector/Kconfig
@@ -9,13 +9,13 @@ config CONNECTOR
 
 	  Connector support can also be built as a module.  If so, the module
 	  will be called cn.ko.
 
 config PROC_EVENTS
-	boolean "Report process events to userspace"
-	depends on CONNECTOR=y
-	default y
-	---help---
+	tristate "Report process events to userspace"
+	default m
+	depends on CONNECTOR
+	help
 	  Provide a connector that reports process events to userspace. Send
 	  events such as fork, exec, id change (uid, gid, suid, etc), and exit.
 
 endmenu
Index: linux-2.6.17-rc6-mm2/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/drivers/connector/cn_proc.c
+++ linux-2.6.17-rc6-mm2/drivers/connector/cn_proc.c
@@ -224,6 +224,24 @@ static int __init cn_proc_init(void)
 		cn_del_callback(&cn_proc_event_id);
 out:
 	return err;
 }
 
+static void cn_proc_fini(void)
+{
+	int err;
+
+	err = unregister_task_watcher(&cn_proc_nb);
+	if (err != 0)
+		printk(KERN_WARNING
+		       "cn_proc failed to unregister its task notify block\n");
+
+	cn_del_callback(&cn_proc_event_id);
+}
+
 module_init(cn_proc_init);
+module_exit(cn_proc_fini);
+
+MODULE_AUTHOR("Matt Helsley <matthltc@us.ibm.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Notification of process events.");
+MODULE_VERSION("2:1.0");

--

