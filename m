Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTLXWl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 17:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTLXWl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 17:41:59 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:21001 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263996AbTLXWlq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 17:41:46 -0500
Date: Wed, 24 Dec 2003 23:42:42 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, second wave (3/5)
Message-Id: <20031224234242.4f3f0084.khali@linux-fr.org>
In-Reply-To: <20031224225707.749707e5.khali@linux-fr.org>
References: <20031224225707.749707e5.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the i2c-core locking mechanism.

Most of the work was done by Kyösti Mälkki. Original comment follows:
***
Replace use of ADAP_LOCK and DRV_LOCK with down(&core_lists).
In many cases we need both, some return path forgot UNLOCK, and locks
were claimed in varying order and sometimes not at all.

Replace use of I2C_LOCK with down(&adapter->bus).

Remove unused adapter, driver and client counts.
***

>From Kyösti's original patch, I removed a few things that did not
stricly belong to it. A few locks are still missing, even after applying
this patch. All these changes will be merged into a more generic
i2c-core code cleanup patch, to be submitted later. 

diff -ru linux-2.4.24-pre2-k2/drivers/i2c/i2c-core.c linux-2.4.24-pre2-k3/drivers/i2c/i2c-core.c
--- linux-2.4.24-pre2-k2/drivers/i2c/i2c-core.c	Tue Dec 23 19:02:05 2003
+++ linux-2.4.24-pre2-k3/drivers/i2c/i2c-core.c	Wed Dec 24 19:04:55 2003
@@ -39,32 +39,14 @@
 
 /* ----- global defines ---------------------------------------------------- */
 
-/* exclusive access to the bus */
-#define I2C_LOCK(adap) down(&adap->lock)
-#define I2C_UNLOCK(adap) up(&adap->lock) 
-
-#define ADAP_LOCK()	down(&adap_lock)
-#define ADAP_UNLOCK()	up(&adap_lock)
-
-#define DRV_LOCK()	down(&driver_lock)
-#define DRV_UNLOCK()	up(&driver_lock)
-
 #define DEB(x) if (i2c_debug>=1) x;
 #define DEB2(x) if (i2c_debug>=2) x;
 
 /* ----- global variables -------------------------------------------------- */
 
-/**** lock for writing to global variables: the adapter & driver list */
-struct semaphore adap_lock;
-struct semaphore driver_lock;
-
-/**** adapter list */
+DECLARE_MUTEX(core_lists);
 static struct i2c_adapter *adapters[I2C_ADAP_MAX];
-static int adap_count;
-
-/**** drivers list */
 static struct i2c_driver *drivers[I2C_DRIVER_MAX];
-static int driver_count;
 
 /**** debug level */
 static int i2c_debug=1;
@@ -112,9 +94,9 @@
  */
 int i2c_add_adapter(struct i2c_adapter *adap)
 {
-	int i,j,res;
+	int i,j,res = 0;
 
-	ADAP_LOCK();
+	down(&core_lists);
 	for (i = 0; i < I2C_ADAP_MAX; i++)
 		if (NULL == adapters[i])
 			break;
@@ -127,11 +109,10 @@
 	}
 
 	adapters[i] = adap;
-	adap_count++;
-	ADAP_UNLOCK();
 	
 	/* init data types */
-	init_MUTEX(&adap->lock);
+	init_MUTEX(&adap->bus);
+	init_MUTEX(&adap->list);
 
 #ifdef CONFIG_PROC_FS
 
@@ -146,7 +127,7 @@
 			printk("i2c-core.o: Could not create /proc/bus/%s\n",
 			       name);
 			res = -ENOENT;
-			goto ERROR1;
+			goto ERROR0;
 		}
 
 		proc_entry->proc_fops = &i2cproc_operations;
@@ -157,36 +138,25 @@
 #endif /* def CONFIG_PROC_FS */
 
 	/* inform drivers of new adapters */
-	DRV_LOCK();	
 	for (j=0;j<I2C_DRIVER_MAX;j++)
 		if (drivers[j]!=NULL && 
 		    (drivers[j]->flags&(I2C_DF_NOTIFY|I2C_DF_DUMMY)))
 			/* We ignore the return code; if it fails, too bad */
 			drivers[j]->attach_adapter(adap);
-	DRV_UNLOCK();
 	
 	DEB(printk(KERN_DEBUG "i2c-core.o: adapter %s registered as adapter %d.\n",
 	           adap->name,i));
-
-	return 0;	
-
-
-ERROR1:
-	ADAP_LOCK();
-	adapters[i] = NULL;
-	adap_count--;
 ERROR0:
-	ADAP_UNLOCK();
+	up(&core_lists);
 	return res;
 }
 
 
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	int i,j,res;
-
-	ADAP_LOCK();
+	int i,j,res = 0;
 
+	down(&core_lists);
 	for (i = 0; i < I2C_ADAP_MAX; i++)
 		if (adap == adapters[i])
 			break;
@@ -202,17 +172,14 @@
 	 * *detach* it! Of course, each dummy driver should know about
 	 * this or hell will break loose...
 	 */
-	DRV_LOCK();
 	for (j = 0; j < I2C_DRIVER_MAX; j++) 
 		if (drivers[j] && (drivers[j]->flags & I2C_DF_DUMMY))
 			if ((res = drivers[j]->attach_adapter(adap))) {
 				printk(KERN_WARNING "i2c-core.o: can't detach adapter %s "
 				       "while detaching driver %s: driver not "
 				       "detached!",adap->name,drivers[j]->name);
-				goto ERROR1;	
+				goto ERROR0;
 			}
-	DRV_UNLOCK();
-
 
 	/* detach any active clients. This must be done first, because
 	 * it can fail; in which case we give upp. */
@@ -240,17 +207,9 @@
 #endif /* def CONFIG_PROC_FS */
 
 	adapters[i] = NULL;
-	adap_count--;
-	
-	ADAP_UNLOCK();	
 	DEB(printk(KERN_DEBUG "i2c-core.o: adapter unregistered: %s\n",adap->name));
-	return 0;
-
 ERROR0:
-	ADAP_UNLOCK();
-	return res;
-ERROR1:
-	DRV_UNLOCK();
+	up(&core_lists);
 	return res;
 }
 
@@ -264,7 +223,8 @@
 int i2c_add_driver(struct i2c_driver *driver)
 {
 	int i;
-	DRV_LOCK();
+
+	down(&core_lists);
 	for (i = 0; i < I2C_DRIVER_MAX; i++)
 		if (NULL == drivers[i])
 			break;
@@ -273,19 +233,12 @@
 		       " i2c-core.o: register_driver(%s) "
 		       "- enlarge I2C_DRIVER_MAX.\n",
 			driver->name);
-		DRV_UNLOCK();
+		up(&core_lists);
 		return -ENOMEM;
 	}
-
 	drivers[i] = driver;
-	driver_count++;
-	
-	DRV_UNLOCK();	/* driver was successfully added */
-	
 	DEB(printk(KERN_DEBUG "i2c-core.o: driver %s registered.\n",driver->name));
 	
-	ADAP_LOCK();
-
 	/* now look for instances of driver on our adapters
 	 */
 	if (driver->flags& (I2C_DF_NOTIFY|I2C_DF_DUMMY)) {
@@ -294,15 +247,15 @@
 				/* Ignore errors */
 				driver->attach_adapter(adapters[i]);
 	}
-	ADAP_UNLOCK();
+	up(&core_lists);
 	return 0;
 }
 
 int i2c_del_driver(struct i2c_driver *driver)
 {
-	int i,j,k,res;
+	int i,j,k,res = 0;
 
-	DRV_LOCK();
+	down(&core_lists);
 	for (i = 0; i < I2C_DRIVER_MAX; i++)
 		if (driver == drivers[i])
 			break;
@@ -310,7 +263,7 @@
 		printk(KERN_WARNING " i2c-core.o: unregister_driver: "
 				    "[%s] not found\n",
 			driver->name);
-		DRV_UNLOCK();
+		up(&core_lists);
 		return -ENODEV;
 	}
 	/* Have a look at each adapter, if clients of this driver are still
@@ -322,7 +275,6 @@
 	 * invalid operation might (will!) result, when using stale client
 	 * pointers.
 	 */
-	ADAP_LOCK(); /* should be moved inside the if statement... */
 	for (k=0;k<I2C_ADAP_MAX;k++) {
 		struct i2c_adapter *adap = adapters[k];
 		if (adap == NULL) /* skip empty entries. */
@@ -341,8 +293,7 @@
 				       "not be detached properly; driver "
 				       "not unloaded!",driver->name,
 				       adap->name);
-				ADAP_UNLOCK();
-				return res;
+				goto ERROR0;
 			}
 		} else {
 			for (j=0;j<I2C_CLIENT_MAX;j++) { 
@@ -365,31 +316,41 @@
 						       driver->name,
 						       client->addr,
 						       adap->name);
-						ADAP_UNLOCK();
-						return res;
+						goto ERROR0;
 					}
 				}
 			}
 		}
 	}
-	ADAP_UNLOCK();
 	drivers[i] = NULL;
-	driver_count--;
-	DRV_UNLOCK();
-	
 	DEB(printk(KERN_DEBUG "i2c-core.o: driver unregistered: %s\n",driver->name));
-	return 0;
+
+ERROR0:
+	up(&core_lists);
+	return res;
 }
 
-int i2c_check_addr (struct i2c_adapter *adapter, int addr)
+static int __i2c_check_addr (struct i2c_adapter *adapter, int addr)
 {
 	int i;
 	for (i = 0; i < I2C_CLIENT_MAX ; i++) 
 		if (adapter->clients[i] && (adapter->clients[i]->addr == addr))
 			return -EBUSY;
+
 	return 0;
 }
 
+int i2c_check_addr (struct i2c_adapter *adapter, int addr)
+{
+	int rval;
+
+	down(&adapter->list);
+	rval = __i2c_check_addr(adapter, addr);
+	up(&adapter->list);
+
+	return rval;
+}
+
 int i2c_attach_client(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
@@ -398,6 +359,7 @@
 	if (i2c_check_addr(client->adapter,client->addr))
 		return -EBUSY;
 
+	down(&adapter->list);
 	for (i = 0; i < I2C_CLIENT_MAX; i++)
 		if (NULL == adapter->clients[i])
 			break;
@@ -405,11 +367,11 @@
 		printk(KERN_WARNING 
 		       " i2c-core.o: attach_client(%s) - enlarge I2C_CLIENT_MAX.\n",
 			client->name);
+		up(&adapter->list);
 		return -ENOMEM;
 	}
-
 	adapter->clients[i] = client;
-	adapter->client_count++;
+	up(&adapter->list);
 	
 	if (adapter->client_register) 
 		if (adapter->client_register(client)) 
@@ -431,6 +393,7 @@
 	struct i2c_adapter *adapter = client->adapter;
 	int i,res;
 
+	down(&adapter->list);
 	for (i = 0; i < I2C_CLIENT_MAX; i++)
 		if (client == adapter->clients[i])
 			break;
@@ -438,6 +401,7 @@
 		printk(KERN_WARNING " i2c-core.o: unregister_client "
 				    "[%s] not found\n",
 			client->name);
+		up(&adapter->list);
 		return -ENODEV;
 	}
 	
@@ -453,7 +417,7 @@
 		}
 
 	adapter->clients[i] = NULL;
-	adapter->client_count--;
+	up(&adapter->list);
 
 	DEB(printk(KERN_DEBUG "i2c-core.o: client [%s] unregistered.\n",client->name));
 	return 0;
@@ -595,6 +559,7 @@
 	int i;
 	int nr = 0;
 	/* Note that it is safe to write a `little' beyond len. Yes, really. */
+	down(&core_lists);
 	for (i = 0; (i < I2C_ADAP_MAX) && (nr < len); i++)
 		if (adapters[i]) {
 			nr += sprintf(buf+nr, "i2c-%d\t", i);
@@ -611,6 +576,7 @@
 			              adapters[i]->name,
 			              adapters[i]->algo->name);
 		}
+	up(&core_lists);
 	return nr;
 }
 
@@ -728,9 +694,9 @@
  	 	DEB2(printk(KERN_DEBUG "i2c-core.o: master_xfer: %s with %d msgs.\n",
 		            adap->name,num));
 
-		I2C_LOCK(adap);
+		down(&adap->bus);
 		ret = adap->algo->master_xfer(adap,msgs,num);
-		I2C_UNLOCK(adap);
+		up(&adap->bus);
 
 		return ret;
 	} else {
@@ -755,9 +721,9 @@
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
 			count,client->adapter->name));
 	
-		I2C_LOCK(adap);
+		down(&adap->bus);
 		ret = adap->algo->master_xfer(adap,&msg,1);
-		I2C_UNLOCK(adap);
+		up(&adap->bus);
 
 		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
 		 * transmitted, else error code.
@@ -785,9 +751,9 @@
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: reading %d bytes on %s.\n",
 			count,client->adapter->name));
 	
-		I2C_LOCK(adap);
+		down(&adap->bus);
 		ret = adap->algo->master_xfer(adap,&msg,1);
-		I2C_UNLOCK(adap);
+		up(&adap->bus);
 	
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
 			ret, count, client->addr));
@@ -1195,10 +1161,10 @@
 	s32 res;
 	flags = flags & I2C_M_TEN;
 	if (adapter->algo->smbus_xfer) {
-		I2C_LOCK(adapter);
+		down(&adapter->bus);
 		res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
 		                                command,size,data);
-		I2C_UNLOCK(adapter);
+		up(&adapter->bus);
 	} else
 		res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
 	                                      command,size,data);
@@ -1228,12 +1194,7 @@
 	printk(KERN_INFO "i2c-core.o: i2c core module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	memset(adapters,0,sizeof(adapters));
 	memset(drivers,0,sizeof(drivers));
-	adap_count=0;
-	driver_count=0;
 
-	init_MUTEX(&adap_lock);
-	init_MUTEX(&driver_lock);
-	
 #ifdef CONFIG_PROC_FS
 	return i2cproc_init();
 #else
diff -ru linux-2.4.24-pre2-k2/drivers/i2c/i2c-sibyte.c linux-2.4.24-pre2-k3/drivers/i2c/i2c-sibyte.c
--- linux-2.4.24-pre2-k2/drivers/i2c/i2c-sibyte.c	Mon Dec 22 22:04:00 2003
+++ linux-2.4.24-pre2-k3/drivers/i2c/i2c-sibyte.c	Wed Dec 24 19:04:55 2003
@@ -67,7 +67,6 @@
                 dec_use:           sibyte_dec_use,
                 client_register:   sibyte_reg,
                 client_unregister: sibyte_unreg,
-		client_count:      0
         } , 
         {
                 name:              "SiByte SMBus 1",
@@ -78,7 +77,6 @@
                 dec_use:           sibyte_dec_use,
                 client_register:   sibyte_reg,
                 client_unregister: sibyte_unreg,
-		client_count:      0
         }
 };
 
diff -ru linux-2.4.24-pre2-k2/include/linux/i2c.h linux-2.4.24-pre2-k3/include/linux/i2c.h
--- linux-2.4.24-pre2-k2/include/linux/i2c.h	Tue Dec 23 20:05:40 2003
+++ linux-2.4.24-pre2-k3/include/linux/i2c.h	Wed Dec 24 20:12:52 2003
@@ -241,11 +241,11 @@
 			/* and can be set via the i2c_ioctl call	*/
 
 			/* data fields that are valid for all devices	*/
-	struct semaphore lock;  
+	struct semaphore bus;
+	struct semaphore list;  
 	unsigned int flags;/* flags specifying div. data		*/
 
 	struct i2c_client *clients[I2C_CLIENT_MAX];
-	int client_count;
 
 	int timeout;
 	int retries;


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
