Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTJMX0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 19:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTJMX0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 19:26:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:10892 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262095AbTJMX02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 19:26:28 -0400
Date: Mon, 13 Oct 2003 16:25:59 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>,
       Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org
Subject: [PATCH] sysfs -- don't crash if removing non-existant attribute
 group
Message-Id: <20031013162559.5ff55929.shemminger@osdl.org>
In-Reply-To: <20031003224931.57ac536a.davem@redhat.com>
References: <20031003224931.57ac536a.davem@redhat.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some (buggy) network drivers in 2.6 decide to set the statistics hook,
after registration. This causes unregister_netdevice to crash because it attempts 
to remove the 'statistics' attribute group it thought was created.  

This fixes sysfs so it ignores the problem.  Another set of patches
will address the remaining buggy ether drivers.

diff -Nru a/fs/sysfs/group.c b/fs/sysfs/group.c
--- a/fs/sysfs/group.c	Mon Oct 13 16:04:31 2003
+++ b/fs/sysfs/group.c	Mon Oct 13 16:04:31 2003
@@ -65,9 +65,11 @@
 {
 	struct dentry * dir;
 
-	if (grp->name)
+	if (grp->name) {
 		dir = sysfs_get_dentry(kobj->dentry,grp->name);
-	else
+		if (dir == NULL)	/* non-existent */
+			return;
+	} else
 		dir = kobj->dentry;
 
 	remove_files(dir,grp);
