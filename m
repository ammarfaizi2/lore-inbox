Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263650AbUJ3Icu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbUJ3Icu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 04:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbUJ3IcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 04:32:05 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:58269 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263652AbUJ3I3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 04:29:30 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 4/4] Driver core: bus_rescan_devices improper locking
Date: Sat, 30 Oct 2004 03:29:18 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20041029185753.53517.qmail@web81307.mail.yahoo.com> <200410300328.13995.dtor_core@ameritech.net> <200410300328.48554.dtor_core@ameritech.net>
In-Reply-To: <200410300328.48554.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410300329.20539.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1958, 2004-10-30 03:13:25-05:00, dtor_core@ameritech.net
  Driver core: bus_rescan_devices() should take write lock to guarantee
               that 2 threads will not probe same device and therefore
               can not be implemented with bus_for_each_dev().
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 bus.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)


===================================================================



diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-10-30 03:15:58 -05:00
+++ b/drivers/base/bus.c	2004-10-30 03:15:58 -05:00
@@ -571,18 +571,6 @@
 }
 
 
-/* Helper for bus_rescan_devices's iter */
-static int bus_rescan_devices_helper(struct device *dev, void *data)
-{
-	int *count = data;
-
-	if (!dev->driver && device_attach(dev))
-		(*count)++;
-
-	return 0;
-}
-
-
 /**
  *	bus_rescan_devices - rescan devices on the bus for possible drivers
  *	@bus:	the bus to scan.
@@ -594,9 +582,19 @@
  */
 int bus_rescan_devices(struct bus_type * bus)
 {
+	struct device *dev;
 	int count = 0;
 
-	bus_for_each_dev(bus, NULL, &count, bus_rescan_devices_helper);
+	if (!(bus = get_bus(bus)))
+		return 0;
+
+	down_write(&bus->subsys.rwsem);
+	list_for_each_entry(dev, &bus->devices.list, bus_list) {
+		if (!dev->driver && device_attach(dev))
+			count++;
+	}
+	up_write(&bus->subsys.rwsem);
+	put_bus(bus);
 
 	return count;
 }
