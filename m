Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317661AbSFMPQx>; Thu, 13 Jun 2002 11:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317679AbSFMPQw>; Thu, 13 Jun 2002 11:16:52 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:15314 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S317661AbSFMPQv>; Thu, 13 Jun 2002 11:16:51 -0400
Message-Id: <200206131516.g5DFGiM70818@d06relay02.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Patrick Mochel <mochel@osdl.org>
Subject: [patch] bad locking in {driver,bus}_for_each_{drv,dev}
Date: Thu, 13 Jun 2002 19:16:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just ran in a deadlock in driver_for_each_dev, where read_unlock 
was called without the lock being held. The patch below avoids the
problem there and in the other two places I found it.

	Arnd <><

--- linux-2.5.21/drivers/base/driver.c  Thu Jun 13 19:00:48 2002
+++ drivers/base/driver.c       Thu Jun 13 19:01:25 2002
@@ -31,6 +31,7 @@
                dev = next;
                if ((error = callback(dev,data))) {
                        put_device(dev);
+                       read_lock(&drv->lock);
                        break;
                }
                read_lock(&drv->lock);
--- linux-2.5.21/drivers/base/bus.c     Thu Jun 13 19:05:25 2002
+++ drivers/base/bus.c  Thu Jun 13 19:06:01 2002
@@ -61,6 +61,7 @@
                dev = next;
                if ((error = callback(dev,data))) {
                        put_device(dev);
+                       read_lock(&bus->lock);
                        break;
                }
                read_lock(&bus->lock);
@@ -96,6 +97,7 @@
                drv = next;
                if ((error = callback(drv,data))) {
                        put_driver(drv);
+                       read_lock(&bus->lock);
                        break;
                }
                read_lock(&bus->lock);
