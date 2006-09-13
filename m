Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWIMQlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWIMQlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWIMQik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:38:40 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:27065 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750742AbWIMQi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:29 -0400
Date: Wed, 13 Sep 2006 18:38:48 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [06/12] driver core fixes: bus_add_attrs() retval check
Message-ID: <20060913183848.05a956a0@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check return value of bus_add_attrs() in bus_register().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 bus.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.18-rc6/drivers/base/bus.c	2006-09-12 14:15:16.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/bus.c	2006-09-12 17:10:50.000000000 +0200
@@ -744,11 +744,15 @@ int bus_register(struct bus_type * bus)
 
 	klist_init(&bus->klist_devices, klist_devices_get, klist_devices_put);
 	klist_init(&bus->klist_drivers, klist_drivers_get, klist_drivers_put);
-	bus_add_attrs(bus);
+	retval = bus_add_attrs(bus);
+	if (retval)
+		goto bus_attrs_fail;
 
 	pr_debug("bus type '%s' registered\n", bus->name);
 	return 0;
 
+bus_attrs_fail:
+	kset_unregister(&bus->drivers);
 bus_drivers_fail:
 	kset_unregister(&bus->devices);
 bus_devices_fail:
