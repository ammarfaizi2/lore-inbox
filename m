Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTEFTpI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbTEFTos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:44:48 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:13761 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261294AbTEFTmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:42:49 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 6 May 2003 21:34:30 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       Frank Davis <fdavis@si.rr.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Ronald Bultje <R.S.Bultje@pharm.uu.nl>
Subject: [patch] i2c #1/3: listify i2c core
Message-ID: <20030506193430.GA865@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is the first of tree patches for i2c.  Trying to get the i2c
cleanups finshed before 2.6.x, so we (hopefully) don't have a
ever-changing i2c subsystem in 2.7.x again (which is very annonying for
driver maintainance).

Changes:

 * listify i2c-core, i.e. make it use <linux/list.h> instead of
   statically-sized arrays, removed lots of ugly code :)
 * added i2c_(get|put)_adapter, changed i2c-dev.c to use these
   functions instead maintaining is own adapter list.
 * killed the I2C_DF_DUMMY flag which had the strange semantics to
   make the i2c subsystem call driver->attach_adapter on detaches.
   Added a detach_adapter() callback instead.
 * some other minor cleanups along the way ...

Please apply,

  Gerd

diff -urN -X /home/kraxel/.kdontdiff linux-vanilla-2.5.69/drivers/i2c/i2c-core.c linux-i2c-1-2.5.69/drivers/i2c/i2c-core.c
--- linux-vanilla-2.5.69/drivers/i2c/i2c-core.c	2003-05-06 14:01:54.000000000 +0200
+++ linux-i2c-1-2.5.69/drivers/i2c/i2c-core.c	2003-05-06 13:42:07.000000000 +0200
@@ -38,8 +38,8 @@
 #define DEB(x) if (i2c_debug>=1) x;
 #define DEB2(x) if (i2c_debug>=2) x;
 
-static struct i2c_adapter *adapters[I2C_ADAP_MAX];
-static struct i2c_driver *drivers[I2C_DRIVER_MAX];
+static LIST_HEAD(adapters);
+static LIST_HEAD(drivers);
 static DECLARE_MUTEX(core_lists);
 
 /**** debug level */
@@ -75,23 +75,17 @@
  */
 int i2c_add_adapter(struct i2c_adapter *adap)
 {
-	int res = 0, i, j;
+	static int nr = 0;
+	struct list_head   *item;
+	struct i2c_driver  *driver;
 
 	down(&core_lists);
-	for (i = 0; i < I2C_ADAP_MAX; i++)
-		if (NULL == adapters[i])
-			break;
-	if (I2C_ADAP_MAX == i) {
-		dev_warn(&adap->dev,
-			"register_adapter - enlarge I2C_ADAP_MAX.\n");
-		res = -ENOMEM;
-		goto out_unlock;
-	}
 
-	adapters[i] = adap;
-
-	init_MUTEX(&adap->bus);
-	init_MUTEX(&adap->list);
+	adap->nr = nr++;
+	init_MUTEX(&adap->bus_lock);
+	init_MUTEX(&adap->clist_lock);
+	list_add_tail(&adap->list,&adapters);
+	INIT_LIST_HEAD(&adap->clients);
 
 	/* Add the adapter to the driver core.
 	 * If the parent pointer is not set up,
@@ -99,77 +93,65 @@
 	 */
 	if (adap->dev.parent == NULL)
 		adap->dev.parent = &legacy_bus;
-	sprintf(adap->dev.bus_id, "i2c-%d", i);
+	sprintf(adap->dev.bus_id, "i2c-%d", adap->nr);
 	adap->dev.driver = &i2c_generic_driver;
 	device_register(&adap->dev);
 
 	/* inform drivers of new adapters */
-	for (j=0;j<I2C_DRIVER_MAX;j++)
-		if (drivers[j]!=NULL && 
-		    (drivers[j]->flags&(I2C_DF_NOTIFY|I2C_DF_DUMMY)))
+	list_for_each(item,&drivers) {
+		driver = list_entry(item, struct i2c_driver, list);
+		if (driver->flags & I2C_DF_NOTIFY)
 			/* We ignore the return code; if it fails, too bad */
-			drivers[j]->attach_adapter(adap);
+			driver->attach_adapter(adap);
+	}
 	up(&core_lists);
-	
-	DEB(dev_dbg(&adap->dev, "registered as adapter %d.\n", i));
 
- out_unlock:
-	up(&core_lists);
-	return res;;
+	DEB(dev_dbg(&adap->dev, "registered as adapter #%d\n", adap->nr));
+	return 0;
 }
 
 
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	int res = 0, i, j;
+	struct list_head  *item;
+	struct i2c_driver *driver;
+	struct i2c_client *client;
+	int res = 0;
 
 	down(&core_lists);
-	for (i = 0; i < I2C_ADAP_MAX; i++)
-		if (adap == adapters[i])
-			break;
-	if (I2C_ADAP_MAX == i) {
-		dev_warn(&adap->dev, "unregister_adapter adap not found.\n");
-		res = -ENODEV;
-		goto out_unlock;
-	}
 
-	/* DUMMY drivers do not register their clients, so we have to
-	 * use a trick here: we call driver->attach_adapter to
-	 * *detach* it! Of course, each dummy driver should know about
-	 * this or hell will break loose...
-	 */
-	for (j = 0; j < I2C_DRIVER_MAX; j++) 
-		if (drivers[j] && (drivers[j]->flags & I2C_DF_DUMMY))
-			if ((res = drivers[j]->attach_adapter(adap))) {
+	list_for_each(item,&drivers) {
+		driver = list_entry(item, struct i2c_driver, list);
+		if (driver->detach_adapter)
+			if ((res = driver->detach_adapter(adap))) {
 				dev_warn(&adap->dev, "can't detach adapter"
-				       "while detaching driver %s: driver not "
-				       "detached!", drivers[j]->name);
+					 "while detaching driver %s: driver not "
+					 "detached!", driver->name);
 				goto out_unlock;
 			}
+	}
 
 	/* detach any active clients. This must be done first, because
 	 * it can fail; in which case we give upp. */
-	for (j=0;j<I2C_CLIENT_MAX;j++) {
-		struct i2c_client *client = adap->clients[j];
-		if (client!=NULL) {
-		    /* detaching devices is unconditional of the set notify
-		     * flag, as _all_ clients that reside on the adapter
-		     * must be deleted, as this would cause invalid states.
-		     */
-			if ((res=client->driver->detach_client(client))) {
-				dev_err(&adap->dev, "adapter not "
-					"unregistered, because client at "
-					"address %02x can't be detached. ",
-					client->addr);
-				goto out_unlock;
-			}
+	list_for_each(item,&adap->clients) {
+		client = list_entry(item, struct i2c_client, list);
+
+		/* detaching devices is unconditional of the set notify
+		 * flag, as _all_ clients that reside on the adapter
+		 * must be deleted, as this would cause invalid states.
+		 */
+		if ((res=client->driver->detach_client(client))) {
+			dev_err(&adap->dev, "adapter not "
+				"unregistered, because client at "
+				"address %02x can't be detached. ",
+				client->addr);
+			goto out_unlock;
 		}
 	}
 
 	/* clean up the sysfs representation */
 	device_unregister(&adap->dev);
-
-	adapters[i] = NULL;
+	list_del(&adap->list);
 
 	DEB(dev_dbg(&adap->dev, "adapter unregistered\n"));
 
@@ -187,24 +169,11 @@
 
 int i2c_add_driver(struct i2c_driver *driver)
 {
-	int res = 0, i;
+	struct list_head   *item;
+	struct i2c_adapter *adapter;
+	int res = 0;
 
 	down(&core_lists);
-	for (i = 0; i < I2C_DRIVER_MAX; i++)
-		if (NULL == drivers[i])
-			break;
-	if (I2C_DRIVER_MAX == i) {
-		printk(KERN_WARNING 
-		       " i2c-core.o: register_driver(%s) "
-		       "- enlarge I2C_DRIVER_MAX.\n",
-			driver->name);
-		res = -ENOMEM;
-		goto out_unlock;
-	}
-
-	drivers[i] = driver;
-	
-	DEB(printk(KERN_DEBUG "i2c-core.o: driver %s registered.\n",driver->name));
 
 	/* add the driver to the list of i2c drivers in the driver core */
 	driver->driver.name = driver->name;
@@ -216,13 +185,14 @@
 	if (res)
 		goto out_unlock;
 	
-	/* now look for instances of driver on our adapters
-	 */
-	if (driver->flags& (I2C_DF_NOTIFY|I2C_DF_DUMMY)) {
-		for (i=0;i<I2C_ADAP_MAX;i++) {
-			if (adapters[i]!=NULL)
-				/* Ignore errors */
-				driver->attach_adapter(adapters[i]);
+	list_add_tail(&driver->list,&drivers);
+	DEB(printk(KERN_DEBUG "i2c-core.o: driver %s registered.\n",driver->name));
+
+	/* now look for instances of driver on our adapters */
+	if (driver->flags & I2C_DF_NOTIFY) {
+		list_for_each(item,&adapters) {
+			adapter = list_entry(item, struct i2c_adapter, list);
+			driver->attach_adapter(adapter);
 		}
 	}
 
@@ -233,44 +203,29 @@
 
 int i2c_del_driver(struct i2c_driver *driver)
 {
-	int res = 0, i, j, k;
+	struct list_head   *item1;
+	struct list_head   *item2;
+	struct i2c_client  *client;
+	struct i2c_adapter *adap;
+	
+	int res = 0;
 
 	down(&core_lists);
-	for (i = 0; i < I2C_DRIVER_MAX; i++)
-		if (driver == drivers[i])
-			break;
-	if (I2C_DRIVER_MAX == i) {
-		printk(KERN_WARNING " i2c-core.o: unregister_driver: "
-				    "[%s] not found\n",
-			driver->name);
-		res = -ENODEV;
-		goto out_unlock;
-	}
-
-	driver_unregister(&driver->driver);
 
 	/* Have a look at each adapter, if clients of this driver are still
 	 * attached. If so, detach them to be able to kill the driver 
 	 * afterwards.
 	 */
 	DEB2(printk(KERN_DEBUG "i2c-core.o: unregister_driver - looking for clients.\n"));
-
 	/* removing clients does not depend on the notify flag, else 
 	 * invalid operation might (will!) result, when using stale client
 	 * pointers.
 	 */
-	for (k=0;k<I2C_ADAP_MAX;k++) {
-		struct i2c_adapter *adap = adapters[k];
-		if (adap == NULL) /* skip empty entries. */
-			continue;
+	list_for_each(item1,&adapters) {
+		adap = list_entry(item1, struct i2c_adapter, list);
 		DEB2(dev_dbg(&adap->dev, "examining adapter\n"));
-		if (driver->flags & I2C_DF_DUMMY) {
-		/* DUMMY drivers do not register their clients, so we have to
-		 * use a trick here: we call driver->attach_adapter to
-		 * *detach* it! Of course, each dummy driver should know about
-		 * this or hell will break loose...  
-		 */
-			if ((res = driver->attach_adapter(adap))) {
+		if (driver->detach_adapter) {
+			if ((res = driver->detach_adapter(adap))) {
 				dev_warn(&adap->dev, "while unregistering "
 				       "dummy driver %s, adapter could "
 				       "not be detached properly; driver "
@@ -278,31 +233,31 @@
 				goto out_unlock;
 			}
 		} else {
-			for (j=0;j<I2C_CLIENT_MAX;j++) { 
-				struct i2c_client *client = adap->clients[j];
-				if (client != NULL && 
-				    client->driver == driver) {
-					DEB2(printk(KERN_DEBUG "i2c-core.o: "
-						    "detaching client %s:\n",
-					            client->dev.name));
-					if ((res = driver->detach_client(client))) {
-						dev_err(&adap->dev, "while "
-						       "unregistering driver "
-						       "`%s', the client at "
-						       "address %02x of "
-						       "adapter could not "
-						       "be detached; driver "
-						       "not unloaded!",
-						       driver->name,
-						       client->addr);
-						goto out_unlock;
-					}
+			list_for_each(item2,&adap->clients) {
+				client = list_entry(item2, struct i2c_client, list);
+				if (client->driver != driver)
+					continue;
+				DEB2(printk(KERN_DEBUG "i2c-core.o: "
+					    "detaching client %s:\n",
+					    client->dev.name));
+				if ((res = driver->detach_client(client))) {
+					dev_err(&adap->dev, "while "
+						"unregistering driver "
+						"`%s', the client at "
+						"address %02x of "
+						"adapter could not "
+						"be detached; driver "
+						"not unloaded!",
+						driver->name,
+						client->addr);
+					goto out_unlock;
 				}
 			}
 		}
 	}
-	drivers[i] = NULL;
-	
+
+	driver_unregister(&driver->driver);
+	list_del(&driver->list);
 	DEB(printk(KERN_DEBUG "i2c-core.o: driver unregistered: %s\n",driver->name));
 
  out_unlock:
@@ -310,14 +265,16 @@
 	return 0;
 }
 
-static int __i2c_check_addr(struct i2c_adapter *adapter, int addr)
+static int __i2c_check_addr(struct i2c_adapter *adapter, unsigned int addr)
 {
-	int i;
+	struct list_head   *item;
+	struct i2c_client  *client;
 
-	for (i = 0; i < I2C_CLIENT_MAX ; i++)
-		if (adapter->clients[i] && (adapter->clients[i]->addr == addr))
+	list_for_each(item,&adapter->clients) {
+		client = list_entry(item, struct i2c_client, list);
+		if (client->addr == addr)
 			return -EBUSY;
-
+	}
 	return 0;
 }
 
@@ -325,9 +282,9 @@
 {
 	int rval;
 
-	down(&adapter->list);
+	down(&adapter->clist_lock);
 	rval = __i2c_check_addr(adapter, addr);
-	up(&adapter->list);
+	up(&adapter->clist_lock);
 
 	return rval;
 }
@@ -335,28 +292,14 @@
 int i2c_attach_client(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	int i;
-
-	down(&adapter->list);
-	if (__i2c_check_addr(client->adapter, client->addr))
-		goto out_unlock_list;
 
-	for (i = 0; i < I2C_CLIENT_MAX; i++) {
-		if (!adapter->clients[i])
-			goto free_slot;
+	down(&adapter->clist_lock);
+	if (__i2c_check_addr(client->adapter, client->addr)) {
+		up(&adapter->clist_lock);
+		return -EBUSY;
 	}
-
-	printk(KERN_WARNING 
-	       " i2c-core.o: attach_client(%s) - enlarge I2C_CLIENT_MAX.\n",
-	       client->dev.name);
-
- out_unlock_list:
-	up(&adapter->list);
-	return -EBUSY;
-
- free_slot:
-	adapter->clients[i] = client;
-	up(&adapter->list);
+	list_add_tail(&client->list,&adapter->clients);
+	up(&adapter->clist_lock);
 	
 	if (adapter->client_register)  {
 		if (adapter->client_register(client))  {
@@ -388,7 +331,7 @@
 int i2c_detach_client(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	int res = 0, i;
+	int res = 0;
 	
 	if ((client->flags & I2C_CLIENT_ALLOW_USE) && (client->usage_count > 0))
 		return -EBUSY;
@@ -403,22 +346,11 @@
 		}
 	}
 
-	down(&adapter->list);
-	for (i = 0; i < I2C_CLIENT_MAX; i++) {
-		if (client == adapter->clients[i]) {
-			adapter->clients[i] = NULL;
-			goto out_unlock;
-		}
-	}
-
-	printk(KERN_WARNING
-	       " i2c-core.o: unregister_client [%s] not found\n",
-	       client->dev.name);
-	res = -ENODEV;
-
- out_unlock:
+	down(&adapter->clist_lock);
+	list_del(&client->list);
 	device_unregister(&client->dev);
-	up(&adapter->list);
+	up(&adapter->clist_lock);
+
  out:
 	return res;
 }
@@ -516,9 +448,9 @@
 	if (adap->algo->master_xfer) {
  	 	DEB2(dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n", num));
 
-		down(&adap->bus);
+		down(&adap->bus_lock);
 		ret = adap->algo->master_xfer(adap,msgs,num);
-		up(&adap->bus);
+		up(&adap->bus_lock);
 
 		return ret;
 	} else {
@@ -542,9 +474,9 @@
 		DEB2(dev_dbg(&client->adapter->dev, "master_send: writing %d bytes.\n",
 				count));
 	
-		down(&adap->bus);
+		down(&adap->bus_lock);
 		ret = adap->algo->master_xfer(adap,&msg,1);
-		up(&adap->bus);
+		up(&adap->bus_lock);
 
 		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
 		 * transmitted, else error code.
@@ -572,9 +504,9 @@
 		DEB2(dev_dbg(&client->adapter->dev, "master_recv: reading %d bytes.\n",
 				count));
 	
-		down(&adap->bus);
+		down(&adap->bus_lock);
 		ret = adap->algo->master_xfer(adap,&msg,1);
-		up(&adap->bus);
+		up(&adap->bus_lock);
 	
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
 			ret, count, client->addr));
@@ -743,11 +675,30 @@
  */
 int i2c_adapter_id(struct i2c_adapter *adap)
 {
-	int i;
-	for (i = 0; i < I2C_ADAP_MAX; i++)
-		if (adap == adapters[i])
-			return i;
-	return -1;
+	return adap->nr;
+}
+
+struct i2c_adapter* i2c_get_adapter(int id)
+{
+	struct list_head   *item;
+	struct i2c_adapter *adapter;
+	
+	down(&core_lists);
+	list_for_each(item,&adapters) {
+		adapter = list_entry(item, struct i2c_adapter, list);
+		if (id == adapter->nr &&
+		    try_module_get(adapter->owner)) {
+			up(&core_lists);
+			return adapter;
+		}
+	}
+	up(&core_lists);
+	return NULL;
+}
+
+void i2c_put_adapter(struct i2c_adapter *adap)
+{
+	module_put(adap->owner);
 }
 
 /* The SMBus parts */
@@ -1189,10 +1140,10 @@
 	}
 
 	if (adapter->algo->smbus_xfer) {
-		down(&adapter->bus);
+		down(&adapter->bus_lock);
 		res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
 		                                command,size,data);
-		up(&adapter->bus);
+		up(&adapter->bus_lock);
 	} else
 		res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
 	                                      command,size,data);
@@ -1239,6 +1190,8 @@
 EXPORT_SYMBOL(i2c_control);
 EXPORT_SYMBOL(i2c_transfer);
 EXPORT_SYMBOL(i2c_adapter_id);
+EXPORT_SYMBOL(i2c_get_adapter);
+EXPORT_SYMBOL(i2c_put_adapter);
 EXPORT_SYMBOL(i2c_probe);
 
 EXPORT_SYMBOL(i2c_smbus_xfer);
diff -urN -X /home/kraxel/.kdontdiff linux-vanilla-2.5.69/drivers/i2c/i2c-dev.c linux-i2c-1-2.5.69/drivers/i2c/i2c-dev.c
--- linux-vanilla-2.5.69/drivers/i2c/i2c-dev.c	2003-05-06 14:03:11.000000000 +0200
+++ linux-i2c-1-2.5.69/drivers/i2c/i2c-dev.c	2003-05-06 13:46:19.000000000 +0200
@@ -58,6 +58,7 @@
 static int i2cdev_release (struct inode *inode, struct file *file);
 
 static int i2cdev_attach_adapter(struct i2c_adapter *adap);
+static int i2cdev_detach_adapter(struct i2c_adapter *adap);
 static int i2cdev_detach_client(struct i2c_client *client);
 static int i2cdev_command(struct i2c_client *client, unsigned int cmd,
                            void *arg);
@@ -72,15 +73,13 @@
 	.release	= i2cdev_release,
 };
 
-#define I2CDEV_ADAPS_MAX I2C_ADAP_MAX
-static struct i2c_adapter *i2cdev_adaps[I2CDEV_ADAPS_MAX];
-
 static struct i2c_driver i2cdev_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "dev driver",
 	.id		= I2C_DRIVERID_I2CDEV,
-	.flags		= I2C_DF_DUMMY,
+	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= i2cdev_attach_adapter,
+	.detach_adapter	= i2cdev_detach_adapter,
 	.detach_client	= i2cdev_detach_client,
 	.command	= i2cdev_command,
 };
@@ -340,35 +339,31 @@
 {
 	unsigned int minor = minor(inode->i_rdev);
 	struct i2c_client *client;
+	struct i2c_adapter *adap;
 
-	if ((minor >= I2CDEV_ADAPS_MAX) || !(i2cdev_adaps[minor]))
+	adap = i2c_get_adapter(minor);
+	if (NULL == adap)
 		return -ENODEV;
 
 	client = kmalloc(sizeof(*client), GFP_KERNEL);
-	if (!client)
+	if (!client) {
+		i2c_put_adapter(adap);
 		return -ENOMEM;
+	}
 	memcpy(client, &i2cdev_client_template, sizeof(*client));
 
 	/* registered with adapter, passed as client to user */
-	client->adapter = i2cdev_adaps[minor];
+	client->adapter = adap;
 	file->private_data = client;
 
-	/* use adapter module, i2c-dev handled with fops */
-	if (!try_module_get(client->adapter->owner))
-		goto out_kfree;
-
 	return 0;
-
-out_kfree:
-	kfree(client);
-	return -ENODEV;
 }
 
 static int i2cdev_release(struct inode *inode, struct file *file)
 {
 	struct i2c_client *client = file->private_data;
 
-	module_put(client->adapter->owner);
+	i2c_put_adapter(client->adapter);
 	kfree(client);
 	file->private_data = NULL;
 
@@ -377,33 +372,28 @@
 
 int i2cdev_attach_adapter(struct i2c_adapter *adap)
 {
-	int i;
 	char name[12];
+	int i;
 
-	if ((i = i2c_adapter_id(adap)) < 0) {
-		dev_dbg(&adap->dev, "Unknown adapter ?!?\n");
-		return -ENODEV;
-	}
-	if (i >= I2CDEV_ADAPS_MAX) {
-		dev_dbg(&adap->dev, "Adapter number too large?!? (%d)\n",i);
-		return -ENODEV;
-	}
-
+	i = i2c_adapter_id(adap);
 	sprintf (name, "i2c/%d", i);
-	if (! i2cdev_adaps[i]) {
-		i2cdev_adaps[i] = adap;
-		devfs_register (NULL, name,
+
+	devfs_register (NULL, name,
 			DEVFS_FL_DEFAULT, I2C_MAJOR, i,
 			S_IFCHR | S_IRUSR | S_IWUSR,
 			&i2cdev_fops, NULL);
-		dev_dbg(&adap->dev, "Registered as minor %d\n", i);
-	} else {
-		/* This is actually a detach_adapter call! */
-		devfs_remove("i2c/%d", i);
-		i2cdev_adaps[i] = NULL;
-		dev_dbg(&adap->dev, "Adapter unregistered\n");
-	}
+	dev_dbg(&adap->dev, "Registered as minor %d\n", i);
+	return 0;
+}
+
+int i2cdev_detach_adapter(struct i2c_adapter *adap)
+{
+	int i;
+
+	i = i2c_adapter_id(adap);
 
+	devfs_remove("i2c/%d", i);
+	dev_dbg(&adap->dev, "Adapter unregistered\n");
 	return 0;
 }
 
diff -urN -X /home/kraxel/.kdontdiff linux-vanilla-2.5.69/drivers/media/video/dpc7146.c linux-i2c-1-2.5.69/drivers/media/video/dpc7146.c
--- linux-vanilla-2.5.69/drivers/media/video/dpc7146.c	2003-05-06 14:02:27.000000000 +0200
+++ linux-i2c-1-2.5.69/drivers/media/video/dpc7146.c	2003-05-06 13:55:30.000000000 +0200
@@ -96,7 +96,8 @@
 static int dpc_probe(struct saa7146_dev* dev)
 {
 	struct dpc* dpc = 0;	
-	int i = 0;
+	struct i2c_client *client;
+	struct list_head *item;
 
 	dpc = (struct dpc*)kmalloc(sizeof(struct dpc), GFP_KERNEL);
 	if( NULL == dpc ) {
@@ -117,12 +118,10 @@
 	}
 
 	/* loop through all i2c-devices on the bus and look who is there */
-	for(i = 0; i < I2C_CLIENT_MAX; i++) {
-		if( NULL == dpc->i2c_adapter.clients[i] ) {
-			continue;
-		}
-		if( I2C_SAA7111A == dpc->i2c_adapter.clients[i]->addr ) 
-			dpc->saa7111a = dpc->i2c_adapter.clients[i];
+	list_for_each(item,&dpc->i2c_adapter.clients) {
+		client = list_entry(item, struct i2c_client, list);
+		if( I2C_SAA7111A == client->addr ) 
+			dpc->saa7111a = client;
 	}
 
 	/* check if all devices are present */
diff -urN -X /home/kraxel/.kdontdiff linux-vanilla-2.5.69/drivers/media/video/mxb.c linux-i2c-1-2.5.69/drivers/media/video/mxb.c
--- linux-vanilla-2.5.69/drivers/media/video/mxb.c	2003-05-06 14:01:35.000000000 +0200
+++ linux-i2c-1-2.5.69/drivers/media/video/mxb.c	2003-05-06 13:53:36.000000000 +0200
@@ -208,7 +208,8 @@
 static int mxb_probe(struct saa7146_dev* dev)
 {
 	struct mxb* mxb = 0;
-	int i = 0;	
+	struct i2c_client *client;
+	struct list_head *item;
 
 	request_module("tuner");
 	request_module("tea6420");
@@ -235,22 +236,20 @@
 	}
 
 	/* loop through all i2c-devices on the bus and look who is there */
-	for(i = 0; i < I2C_CLIENT_MAX; i++) {
-		if( NULL == mxb->i2c_adapter.clients[i] ) {
-			continue;
-		}
-		if( I2C_TEA6420_1 == mxb->i2c_adapter.clients[i]->addr )
-			mxb->tea6420_1 = mxb->i2c_adapter.clients[i];
-		if( I2C_TEA6420_2 == mxb->i2c_adapter.clients[i]->addr ) 
-			mxb->tea6420_2 = mxb->i2c_adapter.clients[i];
-		if( I2C_TEA6415C_2 == mxb->i2c_adapter.clients[i]->addr ) 
-			mxb->tea6415c = mxb->i2c_adapter.clients[i];
-		if( I2C_TDA9840 == mxb->i2c_adapter.clients[i]->addr ) 
-			mxb->tda9840 = mxb->i2c_adapter.clients[i];
-		if( I2C_SAA7111A == mxb->i2c_adapter.clients[i]->addr ) 
-			mxb->saa7111a = mxb->i2c_adapter.clients[i];
-		if( 0x60 == mxb->i2c_adapter.clients[i]->addr ) 
-			mxb->tuner = mxb->i2c_adapter.clients[i];
+	list_for_each(item,&mxb->i2c_adapter.clients) {
+		client = list_entry(item, struct i2c_client, list);
+		if( I2C_TEA6420_1 == client->addr )
+			mxb->tea6420_1 = client;
+		if( I2C_TEA6420_2 == client->addr ) 
+			mxb->tea6420_2 = client;
+		if( I2C_TEA6415C_2 == client->addr ) 
+			mxb->tea6415c = client;
+		if( I2C_TDA9840 == client->addr ) 
+			mxb->tda9840 = client;
+		if( I2C_SAA7111A == client->addr ) 
+			mxb->saa7111a = client;
+		if( 0x60 == client->addr ) 
+			mxb->tuner = client;
 	}
 
 	/* check if all devices are present */
diff -urN -X /home/kraxel/.kdontdiff linux-vanilla-2.5.69/drivers/media/video/tvmixer.c linux-i2c-1-2.5.69/drivers/media/video/tvmixer.c
--- linux-vanilla-2.5.69/drivers/media/video/tvmixer.c	2003-05-06 14:03:31.000000000 +0200
+++ linux-i2c-1-2.5.69/drivers/media/video/tvmixer.c	2003-05-06 13:49:59.000000000 +0200
@@ -217,8 +217,9 @@
 	.owner           = THIS_MODULE,
 	.name            = "tv card mixer driver",
         .id              = I2C_DRIVERID_TVMIXER,
-	.flags           = I2C_DF_DUMMY,
+	.flags           = I2C_DF_NOTIFY,
         .attach_adapter  = tvmixer_adapters,
+        .detach_adapter  = tvmixer_adapters,
         .detach_client   = tvmixer_clients,
 };
 
@@ -234,14 +235,15 @@
 
 static int tvmixer_adapters(struct i2c_adapter *adap)
 {
-	int i;
+	struct list_head  *item;
+	struct i2c_client *client;
 
 	if (debug)
 		printk("tvmixer: adapter %s\n",adap->dev.name);
-	for (i=0; i<I2C_CLIENT_MAX; i++) {
-		if (!adap->clients[i])
-			continue;
-		tvmixer_clients(adap->clients[i]);
+
+	list_for_each(item,&adap->clients) {
+		client = list_entry(item, struct i2c_client, list);
+		tvmixer_clients(client);
 	}
 	return 0;
 }
@@ -264,7 +266,8 @@
 			       client->adapter->dev.name);
 		return -1;
 	}
-	printk("tvmixer: debug: %s\n",client->dev.name);
+	if (debug)
+		printk("tvmixer: debug: %s\n",client->dev.name);
 
 	/* unregister ?? */
 	for (i = 0; i < DEV_MAX; i++) {
diff -urN -X /home/kraxel/.kdontdiff linux-vanilla-2.5.69/include/linux/i2c.h linux-i2c-1-2.5.69/include/linux/i2c.h
--- linux-vanilla-2.5.69/include/linux/i2c.h	2003-05-06 14:01:56.000000000 +0200
+++ linux-i2c-1-2.5.69/include/linux/i2c.h	2003-05-06 13:41:07.000000000 +0200
@@ -39,12 +39,6 @@
 
 /* --- General options ------------------------------------------------	*/
 
-#define I2C_ALGO_MAX	4		/* control memory consumption	*/
-#define I2C_ADAP_MAX	16
-#define I2C_DRIVER_MAX	16
-#define I2C_CLIENT_MAX	32
-#define I2C_DUMMY_MAX 4
-
 struct i2c_msg;
 struct i2c_algorithm;
 struct i2c_adapter;
@@ -131,6 +125,7 @@
 	 * i2c_attach_client.
 	 */
 	int (*attach_adapter)(struct i2c_adapter *);
+	int (*detach_adapter)(struct i2c_adapter *);
 
 	/* tells the driver that a client is about to be deleted & gives it 
 	 * the chance to remove its private data. Also, if the client struct
@@ -145,6 +140,7 @@
 	int (*command)(struct i2c_client *client,unsigned int cmd, void *arg);
 
 	struct device_driver driver;
+	struct list_head list;
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
@@ -169,6 +165,7 @@
 	int usage_count;		/* How many accesses currently  */
 					/* to the client		*/
 	struct device dev;		/* the device structure		*/
+	struct list_head list;
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
@@ -236,12 +233,10 @@
 	int (*client_unregister)(struct i2c_client *);
 
 	/* data fields that are valid for all devices	*/
-	struct semaphore bus;
-	struct semaphore list;  
+	struct semaphore bus_lock;
+	struct semaphore clist_lock;
 	unsigned int flags;/* flags specifying div. data		*/
 
-	struct i2c_client *clients[I2C_CLIENT_MAX];
-
 	int timeout;
 	int retries;
 	struct device dev;	/* the adapter device */
@@ -250,6 +245,10 @@
 	/* No need to set this when you initialize the adapter          */
 	int inode;
 #endif /* def CONFIG_PROC_FS */
+
+	int nr;
+	struct list_head clients;
+	struct list_head list;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
@@ -265,7 +264,11 @@
 
 /*flags for the driver struct: */
 #define I2C_DF_NOTIFY	0x01		/* notify on bus (de/a)ttaches 	*/
-#define I2C_DF_DUMMY	0x02		/* do not connect any clients */
+#if 0
+/* this flag is gone -- there is a (optional) driver->detach_adapter
+ * callback now which can be used instead */
+# define I2C_DF_DUMMY	0x02
+#endif
 
 /*flags for the client struct: */
 #define I2C_CLIENT_ALLOW_USE		0x01	/* Client allows access */
@@ -352,7 +355,8 @@
  * or -1 if the adapter was not registered. 
  */
 extern int i2c_adapter_id(struct i2c_adapter *adap);
-
+extern struct i2c_adapter* i2c_get_adapter(int id);
+extern void i2c_put_adapter(struct i2c_adapter *adap);
 
 
 /* Return the functionality mask */
