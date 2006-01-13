Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422913AbWAMTu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422913AbWAMTu4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422908AbWAMTuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:50:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:5781 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422900AbWAMTuj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:39 -0500
Cc: mcr@sandelman.ottawa.on.ca
Subject: [PATCH] device_shutdown can loop if the driver frees itself
In-Reply-To: <11371818131321@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:13 -0800
Message-Id: <11371818132698@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] device_shutdown can loop if the driver frees itself

This patch changes device_shutdown() to use the newly introduced safe
reverse list traversal.  We experienced loops on system reboot if we had
removed and re-inserted our device from the device list.

We noticed this problem on PPC405. Our PCI IDE device comes and goes a lot.

Our hypothesis was that there was a loop caused by the driver->shutdown
freeing memory.  It is possible that we do something wrong as well, but
being unable to reboot is kind of nasty.

Signed-off-by: Michael Richardson <mcr@marajade.sandelman.ca>
Cc: Patrick Mochel <mochel@digitalimplant.org>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9c08a938ce5a3e1c9d5f764dc6ae844cb1af76ff
tree 9bd0a984b2e5466454e2633783786a516fe14484
parent 2d7b5a70e01ff8b1b054d8313362e454e3057c5a
author Michael Richardson <mcr@sandelman.ottawa.on.ca> Mon, 09 Jan 2006 01:04:51 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:12 -0800

 drivers/base/power/shutdown.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/shutdown.c b/drivers/base/power/shutdown.c
index a47bb74..c2475f3 100644
--- a/drivers/base/power/shutdown.c
+++ b/drivers/base/power/shutdown.c
@@ -35,10 +35,10 @@ extern int sysdev_shutdown(void);
  */
 void device_shutdown(void)
 {
-	struct device * dev;
+	struct device * dev, *devn;
 
 	down_write(&devices_subsys.rwsem);
-	list_for_each_entry_reverse(dev, &devices_subsys.kset.list,
+	list_for_each_entry_safe_reverse(dev, devn, &devices_subsys.kset.list,
 				kobj.entry) {
 		if (dev->bus && dev->bus->shutdown) {
 			dev_dbg(dev, "shutdown\n");

