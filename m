Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268332AbTCCESB>; Sun, 2 Mar 2003 23:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268341AbTCCESB>; Sun, 2 Mar 2003 23:18:01 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:41157
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268332AbTCCER5>; Sun, 2 Mar 2003 23:17:57 -0500
Date: Sun, 2 Mar 2003 23:26:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][CHECKER] i2c-core locking
Message-ID: <Pine.LNX.4.50.0303022325400.25240-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one looks like it wasn't dropping the driver mutex on some exit 
paths.

Index: linux-2.5.62-numaq/drivers/i2c/i2c-core.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/drivers/i2c/i2c-core.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 i2c-core.c
--- linux-2.5.62-numaq/drivers/i2c/i2c-core.c	18 Feb 2003 00:15:36 -0000	1.1.1.1
+++ linux-2.5.62-numaq/drivers/i2c/i2c-core.c	3 Mar 2003 04:13:01 -0000
@@ -289,6 +289,7 @@
 {
 	int i,j,k,res;
 
+	ADAP_LOCK();
 	DRV_LOCK();
 	for (i = 0; i < I2C_DRIVER_MAX; i++)
 		if (driver == drivers[i])
@@ -298,6 +299,7 @@
 				    "[%s] not found\n",
 			driver->name);
 		DRV_UNLOCK();
+		ADAP_UNLOCK();
 		return -ENODEV;
 	}
 	/* Have a look at each adapter, if clients of this driver are still
@@ -309,7 +311,6 @@
 	 * invalid operation might (will!) result, when using stale client
 	 * pointers.
 	 */
-	ADAP_LOCK(); /* should be moved inside the if statement... */
 	for (k=0;k<I2C_ADAP_MAX;k++) {
 		struct i2c_adapter *adap = adapters[k];
 		if (adap == NULL) /* skip empty entries. */
@@ -328,6 +329,7 @@
 				       "not be detached properly; driver "
 				       "not unloaded!",driver->name,
 				       adap->name);
+				DRV_UNLOCK();
 				ADAP_UNLOCK();
 				return res;
 			}
@@ -352,6 +354,7 @@
 						       driver->name,
 						       client->addr,
 						       adap->name);
+						DRV_UNLOCK();
 						ADAP_UNLOCK();
 						return res;
 					}
@@ -359,11 +362,10 @@
 			}
 		}
 	}
-	ADAP_UNLOCK();
 	drivers[i] = NULL;
 	driver_count--;
 	DRV_UNLOCK();
-	
+	ADAP_UNLOCK();	
 	DEB(printk(KERN_DEBUG "i2c-core.o: driver unregistered: %s\n",driver->name));
 	return 0;
 }
