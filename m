Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274903AbTHPTPN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 15:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274904AbTHPTPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 15:15:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:29378 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274903AbTHPTPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 15:15:03 -0400
Date: Sat, 16 Aug 2003 12:15:13 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 current - firewire compile error
Message-ID: <20030816191510.GA14960@kroah.com>
References: <3F3E288B.3010105@cornell.edu> <20030816163553.GA9735@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030816163553.GA9735@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 09:35:53AM -0700, Greg KH wrote:
> On Sat, Aug 16, 2003 at 08:50:19AM -0400, Ivan Gyurdiev wrote:
> > Hopefully, this is not a duplicate post:
> > ===========================================
> > 
> > drivers/ieee1394/nodemgr.c: In function `nodemgr_update_ud_names':
> > drivers/ieee1394/nodemgr.c:471: error: structure has no member named `name'
> > drivers/ieee1394/nodemgr.c: In function `nodemgr_create_node':
> > drivers/ieee1394/nodemgr.c:723: error: structure has no member named `name'
> > drivers/ieee1394/nodemgr.c: In function `nodemgr_update_node':
> > drivers/ieee1394/nodemgr.c:1318: error: structure has no member named `name'
> > drivers/ieee1394/nodemgr.c: In function `nodemgr_add_host':
> > drivers/ieee1394/nodemgr.c:1775: error: structure has no member named `name'
> > make[2]: *** [drivers/ieee1394/nodemgr.o] Error 1
> > make[1]: *** [drivers/ieee1394] Error 2
> > make: *** [drivers] Error 2
> 
> I removed struct device.name and forgot to change the firewire code :(
> 
> I'll work on a patch for this later this evening, unless someone beats
> me to it.

Ok, here's the patch that I just sent to Linus and Ben for this, and
some other problems in the ieee1394 code (due to the i2c changes in
2.6.0-test3.)  Please let me know if you have any problems after
applying them.

Again, sorry for missing this.

greg k-h


--- a/drivers/ieee1394/nodemgr.c	Tue Aug  5 12:13:20 2003
+++ b/drivers/ieee1394/nodemgr.c	Sat Aug 16 12:08:09 2003
@@ -460,21 +460,6 @@
 }
 
 
-static void nodemgr_update_ud_names(struct host_info *hi, struct node_entry *ne)
-{
-	struct list_head *lh;
-
-	list_for_each(lh, &ne->device.children) {
-		struct unit_directory *ud;
-		ud = container_of(list_to_dev(lh), struct unit_directory, device);
-
-		snprintf(ud->device.name, DEVICE_NAME_SIZE,
-			 "IEEE-1394 unit directory " NODE_BUS_FMT "-%u",
-			 NODE_BUS_ARGS(hi->host, ne->nodeid), ud->id);
-	}
-}
-
-
 static void nodemgr_remove_ne(struct node_entry *ne)
 {
 	struct device *dev = &ne->device;
@@ -720,9 +705,6 @@
 	ne->device.parent = &host->device;
 	snprintf(ne->device.bus_id, BUS_ID_SIZE, "%016Lx",
 		 (unsigned long long)(ne->guid));
-	snprintf(ne->device.name, DEVICE_NAME_SIZE,
-		 "IEEE-1394 device " NODE_BUS_FMT,
-		 NODE_BUS_ARGS(host, ne->nodeid));
 
 	device_register(&ne->device);
 
@@ -732,8 +714,6 @@
 
 	nodemgr_process_config_rom (hi, ne, busoptions);
 
-	nodemgr_update_ud_names(hi, ne);
-
 	HPSB_DEBUG("%s added: ID:BUS[" NODE_BUS_FMT "]  GUID[%016Lx]",
 		   (host->node_id == nodeid) ? "Host" : "Node",
 		   NODE_BUS_ARGS(host, nodeid), (unsigned long long)guid);
@@ -1312,18 +1292,11 @@
 				struct host_info *hi, nodeid_t nodeid,
 				unsigned int generation)
 {
-	int update_ud_names = 0;
-
 	if (ne->nodeid != nodeid) {
-		snprintf(ne->device.name, DEVICE_NAME_SIZE,
-			 "IEEE-1394 device " NODE_BUS_FMT,
-			 NODE_BUS_ARGS(hi->host, ne->nodeid));
 		HPSB_DEBUG("Node changed: " NODE_BUS_FMT " -> " NODE_BUS_FMT,
 			   NODE_BUS_ARGS(ne->host, ne->nodeid),
 			   NODE_BUS_ARGS(ne->host, nodeid));
 		ne->nodeid = nodeid;
-
-		update_ud_names++;
 	}
 
 	if (ne->busopt.generation != ((busoptions >> 4) & 0xf)) {
@@ -1333,13 +1306,8 @@
 
 		/* This will re-register our unitdir's */
 		nodemgr_process_config_rom (hi, ne, busoptions);
-
-		update_ud_names++;
 	}
 
-	if (update_ud_names)
-		nodemgr_update_ud_names(hi, ne);
-
 	/* Since that's done, we can declare this record current */
 	ne->generation = generation;
 
@@ -1772,8 +1740,6 @@
 	       sizeof(host->device));
 	host->device.parent = &host->pdev->dev;
 	snprintf(host->device.bus_id, BUS_ID_SIZE, "fw-host%d", host->id);
-	snprintf(host->device.name, DEVICE_NAME_SIZE, "IEEE-1394 Host %s-%d",
-		 host->driver->name, host->id);
 
 	sprintf(hi->daemon_name, "knodemgrd_%d", host->id);
 
--- a/drivers/ieee1394/pcilynx.c	Mon Aug 11 09:21:39 2003
+++ b/drivers/ieee1394/pcilynx.c	Sat Aug 16 12:08:53 2003
@@ -144,9 +144,7 @@
 	.id 			= 0xAA, //FIXME: probably we should get an id in i2c-id.h
 	.client_register	= bit_reg,
 	.client_unregister	= bit_unreg,
-	.dev			= {
-		.name		= "PCILynx I2C",
-	},
+	.name			= "PCILynx I2C",
 };
 
 
