Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751729AbWIFRHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbWIFRHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 13:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbWIFRHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 13:07:19 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:38554 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751729AbWIFRHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 13:07:17 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 6 Sep 2006 19:06:36 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [RFT PATCH 2/2] ieee1394: nodemgr: grab class.subsys.rwsem in
 nodemgr_resume_ne
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Miles Lane <miles.lane@gmail.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Ben Collins <bcollins@ubuntu.com>, Greg KH <gregkh@suse.de>
In-Reply-To: <tkrat.a76041f4792feb5b@s5r6.in-berlin.de>
Message-ID: <tkrat.249c4dbc1c15282d@s5r6.in-berlin.de>
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>
 <20060905111306.80398394.akpm@osdl.org> <44FDCEAD.5070905@s5r6.in-berlin.de>
 <44FE751E.4030505@s5r6.in-berlin.de> <44FEFC68.90201@s5r6.in-berlin.de>
 <tkrat.a76041f4792feb5b@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nodemgr_resume_ne was iterating over nodemgr_ud_class.children without
protection by nodemgr_ud_class.subsys.rwsem.

FIXME:
Shouldn't we rather use class->sem there, not class->subsys.rwsem?

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-09-06 18:34:35.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-09-06 18:38:20.000000000 +0200
@@ -1352,6 +1352,7 @@ static void nodemgr_resume_ne(struct nod
 	ne->in_limbo = 0;
 	device_remove_file(&ne->device, &dev_attr_ne_in_limbo);
 
+	down_read(&nodemgr_ud_class.subsys.rwsem);
 	down_read(&ne->device.bus->subsys.rwsem);
 	list_for_each_entry(cdev, &nodemgr_ud_class.children, node) {
 		ud = container_of(cdev, struct unit_directory, class_dev);
@@ -1363,6 +1364,7 @@ static void nodemgr_resume_ne(struct nod
 			ud->device.driver->resume(&ud->device);
 	}
 	up_read(&ne->device.bus->subsys.rwsem);
+	up_read(&nodemgr_ud_class.subsys.rwsem);
 
 	HPSB_DEBUG("Node resumed: ID:BUS[" NODE_BUS_FMT "]  GUID[%016Lx]",
 		   NODE_BUS_ARGS(ne->host, ne->nodeid), (unsigned long long)ne->guid);


