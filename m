Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWAEAvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWAEAvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWAEAus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:58809 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750956AbWAEAtv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:51 -0500
Cc: kay.sievers@suse.de
Subject: [PATCH] keep pnpbios usermod_helper away from hotplug_path[]
In-Reply-To: <11364221693870@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:29 -0800
Message-Id: <11364221691605@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] keep pnpbios usermod_helper away from hotplug_path[]

These days we use udev to manage all kernel events. /proc/sys/kernel/hotplug
will usually be disabled by an init-script. pnpnbios is not integrated with
the driver core and should stay away from the now disabled /sbin/hotplug.

Set the helper to /sbin/phpbios, even when there is probably no current
user of this faciliy. If it's needed, it should definitely get proper driver
core integration instead of forking binaries from the kernel.

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 034382117725f6b6b26fbb138498139c5c012c1b
tree 2f920e992b26b35924753d06765a5d525a364a5c
parent 88026842b0a760145aa71d69e74fbc9ec118ca44
author Kay Sievers <kay.sievers@suse.de> Fri, 11 Nov 2005 04:25:06 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:07 -0800

 drivers/pnp/pnpbios/core.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index f49674f..b154b3f 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -56,7 +56,6 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/slab.h>
-#include <linux/kobject_uevent.h>
 #include <linux/completion.h>
 #include <linux/spinlock.h>
 #include <linux/dmi.h>
@@ -106,8 +105,6 @@ static int pnp_dock_event(int dock, stru
 	char *argv [3], **envp, *buf, *scratch;
 	int i = 0, value;
 
-	if (!hotplug_path [0])
-		return -ENOENT;
 	if (!current->fs->root) {
 		return -EAGAIN;
 	}
@@ -119,8 +116,9 @@ static int pnp_dock_event(int dock, stru
 		return -ENOMEM;
 	}
 
-	/* only one standardized param to hotplug command: type */
-	argv [0] = hotplug_path;
+	/* FIXME: if there are actual users of this, it should be integrated into
+	 * the driver core and use the usual infrastructure like sysfs and uevents */
+	argv [0] = "/sbin/pnpbios";
 	argv [1] = "dock";
 	argv [2] = NULL;
 

