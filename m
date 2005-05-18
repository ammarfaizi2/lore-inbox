Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVERXD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVERXD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVERXD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:03:58 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:36313 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262393AbVERXB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:01:59 -0400
Date: Thu, 19 May 2005 01:01:20 +0200
From: Per Svennerbrandt <per.svennerbrandt@lbi.se>
To: Per Liden <per@fukt.bth.se>, Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] request_modalias: MODALIAS based module loading
Message-ID: <20050518230120.GC3011@tsiryulnik>
Mail-Followup-To: Per Liden <per@fukt.bth.se>, Greg KH <greg@kroah.com>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik> <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so here finally goes:

The following adds a new function called request_modalias to
lib/kobject_uevent.c and makes the kobject hotplug function call it
whenever it gets called in response of an addition.

Warning: The following also contains perhaps the worst abuse of strcmp
ever to be recorded in the history of public mailinglists, so beware!!!

This is the kind of stuff that has the potential for making pretty much
anyone with only even the slightest hint of technical good taste,
myself included, quickly rush for their b-p-b with a horrid expression
on their faces and a thought on their minds about what's becomming of
the world.

On the other hand it also made the patch so nonintrusive that, for a
proof-of-consept kind of thing, I just couldn't resist it. It also has
the added benefit of making the various subsystems virtually "plug and
play": As soon as they start exporting MODALIAS to the hotplug
enviroment request_module will also, if activated, start requesting
modules for them.

Let's hope I'm not prematurely ending the lives of too many brave brown
paper bags out there.

Signed-off-by: Per Svennerbrandt <per.svennerbrandt@lbi.se>

--- linux-2.6.12-rc2/lib/kobject_uevent.c.orig	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.12-rc2/lib/kobject_uevent.c	2005-05-13 00:13:39.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/string.h>
+#include <linux/kmod.h>
 #include <linux/kobject_uevent.h>
 #include <linux/kobject.h>
 #include <net/sock.h>
@@ -175,6 +176,26 @@
 
 #endif /* CONFIG_KOBJECT_UEVENT */
 
+#ifdef CONFIG_REQUEST_MODALIAS
+/**
+ * request_modalias - try to load any modules specified 
+ * by MODALIAS in the enviroment
+ * @envp: pointer to an enviroment possibly containing a MODALIAS
+ */
+static void request_modalias(char **envp)
+{
+	int i, len = strlen("MODALIAS=");
+	
+	if (envp == NULL) return;
+	
+	for (i = 0; envp[i]; i++)
+		if (!strncmp(envp[i], "MODALIAS=", len))
+			__request_module(envp[i] + len, 0);
+}
+
+#else
+static void request_modalias(char **envp) { }
+#endif /* CONFIG_REQUEST_MODALIAS */
 
 #ifdef CONFIG_HOTPLUG
 char hotplug_path[HOTPLUG_PATH_LEN] = "/sbin/hotplug";
@@ -297,6 +318,10 @@ void kobject_hotplug(struct kobject *kob
 		  __FUNCTION__, argv[0], argv[1], (unsigned long long)seq,
 		  envp[0], envp[1], envp[2], envp[3], envp[4]);
 
+	if (action == KOBJ_ADD)
+		/* since we didn't specify MODALIAS here, it must be beyond i */
+		request_modalias(envp + i);
+
 	send_uevent(action_string, kobj_path, envp, GFP_KERNEL);
 
 	if (!hotplug_path[0])

Here's also a patch to the relevant Kconfig to enable it:

--- linux-2.6.12-rc2/init/Kconfig.orig	2005-05-06 23:42:20.000000000 +0200
+++ linux-2.6.12-rc2/init/Kconfig	2005-05-07 12:16:28.000000000 +0200
@@ -454,6 +454,15 @@
 	  runs modprobe with the appropriate arguments, thereby
 	  loading the module if it is available.  If unsure, say Y.
 
+config REQUEST_MODALIAS
+	bool "MODALIAS based module loading"
+	depends on KMOD && HOTPLUG
+	help
+	  If you say Y here, the resulting kernel will also be able to 
+	  load the modules for most types of hardware attached to buses 
+	  such as PCI, USB and PCMCIA automatically, based on 
+	  information contained in their "module aliases".
+
 config STOP_MACHINE
 	bool
 	default y
