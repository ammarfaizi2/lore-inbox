Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVF1FeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVF1FeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVF1FeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:34:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:5612 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261561AbVF1Fda convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:30 -0400
Cc: keithmo@exmsft.com
Subject: [PATCH] cpqphp: fix oops during unload without probe
In-Reply-To: <1119936774843@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:55 -0700
Message-Id: <1119936775691@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] cpqphp: fix oops during unload without probe

drivers/pci/hotplug/cpqphp_core.c calls cpqphp_event_start_thread()
in one_time_init(), which is called whenever the hardware is probed.
Unfortunately, cpqphp_event_stop_thread() is *always* called when
the module is unloaded. If the hardware is never probed, then
cpqphp_event_stop_thread() tries to manipulate a couple of
uninitialized mutexes.

Signed-off-by: Keith Moore <keithmo@exmsft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4002307d2b563a6ab317ca4d7eb1d201a6673d37
tree a95936bd9f9180eeaac3c41fae0baaf878486a2d
parent 70549ad9cf074e12f12cdc931b29b2616dfb873a
author Keith Moore <keithmo@exmsft.com> Thu, 02 Jun 2005 12:42:37 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:46 -0700

 drivers/pci/hotplug/cpqphp_core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -60,6 +60,7 @@ static void __iomem *smbios_start;
 static void __iomem *cpqhp_rom_start;
 static int power_mode;
 static int debug;
+static int initialized;
 
 #define DRIVER_VERSION	"0.9.8"
 #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>"
@@ -1271,7 +1272,6 @@ static int one_time_init(void)
 {
 	int loop;
 	int retval = 0;
-	static int initialized = 0;
 
 	if (initialized)
 		return 0;
@@ -1441,7 +1441,8 @@ static void __exit unload_cpqphpd(void)
 	}
 
 	// Stop the notification mechanism
-	cpqhp_event_stop_thread();
+	if (initialized)
+		cpqhp_event_stop_thread();
 
 	//unmap the rom address
 	if (cpqhp_rom_start)

