Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267600AbUHRXRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267600AbUHRXRa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 19:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267603AbUHRXRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 19:17:30 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:10173 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S267600AbUHRXQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:16:54 -0400
Message-ID: <4123E171.3070104@shadowconnect.com>
Date: Thu, 19 Aug 2004 01:08:33 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
Organization: Shadow Connect
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hch@infradead.org
CC: alan@lxorguk.ukuu.org.uk, wtogami@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
Content-Type: multipart/mixed;
 boundary="------------050205050101040006040306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050205050101040006040306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi...

Christoph Hellwig wrote:
 > What really seems to miss in your model is a callback to i2o_scsi
 > from the main i2o code when a new i2o_controller is found, if you
 > implemented
 > that we'd allocate/deallocate the Scsi_Host in that callback and
 > ->probe/->remove could be sure it'd always have it.
 > i2o_scsi_get_host would get inlined into i2o_scsi_probe.
 > i2o_scsi_remove basically needs a full rewrite, you need to find a way
 > to store a scsi_device ini i2o_dev and it becomes completely trivial.
 > Not sure about how to sanitize the scsi_devie probing logic
 > in i2o_scsi_probe yet.

Okay, patch i2o_scsi-cleanup.patch adds a notification facility to the 
i2o_driver, which notify if a controller is added or removed. The 
i2o_controller structure has now the ability to store per-driver data 
and the SCSI-OSM now takes advantage of this. So all ugly parts should 
be removed now :-)

If you have further things which should be changed, please let me know...



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com

--------------050205050101040006040306
Content-Type: text/x-patch;
 name="i2o_scsi-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o_scsi-cleanup.patch"

Index: include/linux/i2o.h
===================================================================
--- a/include/linux/i2o.h	(revision 111)
+++ b/include/linux/i2o.h	(revision 112)
@@ -34,6 +34,10 @@
 /* message queue empty */
 #define I2O_QUEUE_EMPTY		0xffffffff
 
+enum i2o_driver_notify {
+	I2O_DRIVER_NOTIFY_CONTROLLER_ADD = 0,
+	I2O_DRIVER_NOTIFY_CONTROLLER_REMOVE = 1,
+};
 
 /*
  *	Message structures
@@ -113,6 +117,9 @@
 
 	struct device_driver driver;
 
+	/* notification of changes */
+	void (*notify)(enum i2o_driver_notify, void *);
+
 	struct semaphore lock;
 };
 
@@ -201,6 +208,8 @@
 #endif
 	spinlock_t lock;			/* lock for controller
 						   configuration */
+
+	void *driver_data[I2O_MAX_DRIVERS];	/* storage for drivers */
 };
 
 /*
@@ -275,6 +284,7 @@
 extern u32 i2o_cntxt_list_add(struct i2o_controller *, void *);
 extern void *i2o_cntxt_list_get(struct i2o_controller *, u32);
 extern u32 i2o_cntxt_list_remove(struct i2o_controller *, void *);
+extern u32 i2o_cntxt_list_get_ptr(struct i2o_controller *, void *);
 
 static inline u32 i2o_ptr_low(void *ptr)
 {
@@ -301,6 +311,11 @@
 	return (u32)ptr;
 };
 
+static inline u32 i2o_cntxt_list_get_ptr(struct i2o_controller *c, void *ptr)
+{
+	return (u32)ptr;
+};
+
 static inline u32 i2o_ptr_low(void *ptr)
 {
 	return (u32)ptr;
@@ -316,6 +331,19 @@
 extern int i2o_driver_register(struct i2o_driver *);
 extern void i2o_driver_unregister(struct i2o_driver *);
 
+/**
+ *	i2o_driver_notify - Send notification to a single I2O drivers
+ *
+ *	Send notifications to a single registered driver.
+ */
+static inline void i2o_driver_notify(struct i2o_driver *drv,
+			enum i2o_driver_notify notify, void *data) {
+	if(drv->notify)
+			drv->notify(notify, data);
+}
+
+extern void i2o_driver_notify_all(enum i2o_driver_notify, void *);
+
 /* I2O device functions */
 extern int i2o_device_claim(struct i2o_device *);
 extern int i2o_device_claim_release(struct i2o_device *);
@@ -890,6 +918,7 @@
 #define I2O_TIMEOUT_RESET		30
 #define I2O_TIMEOUT_STATUS_GET		5
 #define I2O_TIMEOUT_LCT_GET		20
+#define I2O_TIMEOUT_SCSI_SCB_ABORT	240
 
 /* retries */
 #define I2O_HRT_GET_TRIES		3
Index: drivers/message/i2o/iop.c
===================================================================
--- a/drivers/message/i2o/iop.c	(revision 111)
+++ b/drivers/message/i2o/iop.c	(revision 112)
@@ -108,8 +108,8 @@
 #if BITS_PER_LONG == 64
 /**
  *      i2o_cntxt_list_add - Append a pointer to context list and return a id
+ *	@c: controller to which the context list belong
  *	@ptr: pointer to add to the context list
- *	@c: controller to which the context list belong
  *
  *	Because the context field in I2O is only 32-bit large, on 64-bit the
  *	pointer is to large to fit in the context field. The i2o_cntxt_list
@@ -117,7 +117,7 @@
  *
  *	Returns context id > 0 on success or 0 on failure.
  */
-u32 i2o_cntxt_list_add(struct i2o_controller * c, void *ptr)
+u32 i2o_cntxt_list_add(struct i2o_controller *c, void *ptr)
 {
 	struct i2o_context_list_element *entry;
 	unsigned long flags;
@@ -154,15 +154,15 @@
 
 /**
  *      i2o_cntxt_list_remove - Remove a pointer from the context list
+ *	@c: controller to which the context list belong
  *	@ptr: pointer which should be removed from the context list
- *	@c: controller to which the context list belong
  *
  *	Removes a previously added pointer from the context list and returns
  *	the matching context id.
  *
  *	Returns context id on succes or 0 on failure.
  */
-u32 i2o_cntxt_list_remove(struct i2o_controller * c, void *ptr)
+u32 i2o_cntxt_list_remove(struct i2o_controller *c, void *ptr)
 {
 	struct i2o_context_list_element *entry;
 	u32 context = 0;
@@ -189,9 +189,11 @@
 
 /**
  *      i2o_cntxt_list_get - Get a pointer from the context list and remove it
+ *	@c: controller to which the context list belong
  *	@context: context id to which the pointer belong
- *	@c: controller to which the context list belong
- *	returns pointer to the matching context id
+ *
+ *	Returns pointer to the matching context id on success or NULL on
+ *	failure.
  */
 void *i2o_cntxt_list_get(struct i2o_controller *c, u32 context)
 {
@@ -216,6 +218,37 @@
 
 	return ptr;
 };
+
+/**
+ *      i2o_cntxt_list_get_ptr - Get a context id from the context list
+ *	@c: controller to which the context list belong
+ *	@ptr: pointer to which the context id should be fetched
+ *
+ *	Returns context id which matches to the pointer on succes or 0 on
+ *	failure.
+ */
+u32 i2o_cntxt_list_get_ptr(struct i2o_controller * c, void *ptr)
+{
+	struct i2o_context_list_element *entry;
+	u32 context = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->context_list_lock, flags);
+	list_for_each_entry(entry, &c->context_list, list)
+	    if (entry->ptr == ptr) {
+		context = entry->context;
+		break;
+	}
+	spin_unlock_irqrestore(&c->context_list_lock, flags);
+
+	if (!context)
+		printk(KERN_WARNING "i2o: Could not find nonexistent ptr "
+		       "%p\n", ptr);
+
+	pr_debug("get context id from context list %p -> %d\n", ptr, context);
+
+	return context;
+};
 #endif
 
 /**
@@ -782,6 +815,8 @@
 
 	pr_debug("Deleting controller %s\n", c->name);
 
+	i2o_driver_notify_all(I2O_DRIVER_NOTIFY_CONTROLLER_REMOVE, c);
+
 	list_del(&c->list);
 
 	list_for_each_entry_safe(dev, tmp, &c->devices, list)
@@ -1098,6 +1133,8 @@
 
 	list_add(&c->list, &i2o_controllers);
 
+	i2o_driver_notify_all(I2O_DRIVER_NOTIFY_CONTROLLER_ADD, c);
+
 	printk(KERN_INFO "%s: Controller added\n", c->name);
 
 	return 0;
@@ -1209,6 +1246,7 @@
 EXPORT_SYMBOL(i2o_cntxt_list_add);
 EXPORT_SYMBOL(i2o_cntxt_list_get);
 EXPORT_SYMBOL(i2o_cntxt_list_remove);
+EXPORT_SYMBOL(i2o_cntxt_list_get_ptr);
 #endif
 EXPORT_SYMBOL(i2o_msg_get_wait);
 EXPORT_SYMBOL(i2o_msg_nop);
Index: drivers/message/i2o/i2o_scsi.c
===================================================================
--- a/drivers/message/i2o/i2o_scsi.c	(revision 111)
+++ b/drivers/message/i2o/i2o_scsi.c	(revision 112)
@@ -67,13 +67,12 @@
 
 #define VERSION_STRING        "Version 0.1.2"
 
+static struct i2o_driver i2o_scsi_driver;
+
 static int i2o_scsi_max_id = 16;
 static int i2o_scsi_max_lun = 8;
 
-static LIST_HEAD(i2o_scsi_hosts);
-
 struct i2o_scsi_host {
-	struct list_head list;	/* node in in i2o_scsi_hosts */
 	struct Scsi_Host *scsi_host;	/* pointer to the SCSI host */
 	struct i2o_controller *iop;	/* pointer to the I2O controller */
 	struct i2o_device *channel[0];	/* channel->i2o_dev mapping table */
@@ -81,19 +80,6 @@
 
 static struct scsi_host_template i2o_scsi_host_template;
 
-/*
- * This is only needed, because we can only set the hostdata after the device is
- * added to the scsi core. So we need this little workaround.
- */
-static DECLARE_MUTEX(i2o_scsi_probe_lock);
-static struct i2o_device *i2o_scsi_probe_dev = NULL;
-
-static int i2o_scsi_slave_alloc(struct scsi_device *sdp)
-{
-	sdp->hostdata = i2o_scsi_probe_dev;
-	return 0;
-};
-
 #define I2O_SCSI_CAN_QUEUE	4
 
 /* SCSI OSM class handling definition */
@@ -169,37 +155,11 @@
  *	is returned, otherwise the I2O controller is added to the SCSI
  *	core.
  *
- *	Returns pointer to the I2O SCSI host on success or negative error code
- *	on failure.
+ *	Returns pointer to the I2O SCSI host on success or NULL on failure.
  */
 static struct i2o_scsi_host *i2o_scsi_get_host(struct i2o_controller *c)
 {
-	struct i2o_scsi_host *i2o_shost;
-	int rc;
-
-	/* skip if already registered as I2O SCSI host */
-	list_for_each_entry(i2o_shost, &i2o_scsi_hosts, list)
-	    if (i2o_shost->iop == c)
-		return i2o_shost;
-
-	i2o_shost = i2o_scsi_host_alloc(c);
-	if (IS_ERR(i2o_shost)) {
-		printk(KERN_ERR "scsi-osm: Could not initialize SCSI host\n");
-		return i2o_shost;
-	}
-
-	rc = scsi_add_host(i2o_shost->scsi_host, &c->device);
-	if (rc) {
-		printk(KERN_ERR "scsi-osm: Could not add SCSI host\n");
-		scsi_host_put(i2o_shost->scsi_host);
-		return ERR_PTR(rc);
-	}
-
-	list_add(&i2o_shost->list, &i2o_scsi_hosts);
-	pr_debug("new I2O SCSI host added\n");
-
-	return i2o_shost;
-
+	return c->driver_data[i2o_scsi_driver.context];
 };
 
 /**
@@ -252,8 +212,8 @@
 	int i;
 
 	i2o_shost = i2o_scsi_get_host(c);
-	if (IS_ERR(i2o_shost))
-		return PTR_ERR(i2o_shost);
+	if (!i2o_shost)
+		return -EFAULT;
 
 	scsi_host = i2o_shost->scsi_host;
 
@@ -292,11 +252,8 @@
 		return -EFAULT;
 	}
 
-	down_interruptible(&i2o_scsi_probe_lock);
-	i2o_scsi_probe_dev = i2o_dev;
-	scsi_dev = scsi_add_device(i2o_shost->scsi_host, channel, id, lun);
-	i2o_scsi_probe_dev = NULL;
-	up(&i2o_scsi_probe_lock);
+	scsi_dev =
+	    __scsi_add_device(i2o_shost->scsi_host, channel, id, lun, i2o_dev);
 
 	if (!scsi_dev) {
 		printk(KERN_WARNING "scsi-osm: can not add SCSI device "
@@ -536,13 +493,67 @@
 				 cmd->request_bufflen, cmd->sc_data_direction);
 
 	return 1;
-}
+};
 
+/**
+ *	i2o_scsi_notify - Retrieve notifications of controller added or removed
+ *	@notify: the notification event which occurs
+ *	@data: pointer to additional data
+ *
+ *	If a I2O controller is added, we catch the notification to add a
+ *	corresponding Scsi_Host. On removal also remove the Scsi_Host.
+ */
+void i2o_scsi_notify(enum i2o_driver_notify notify, void *data)
+{
+	struct i2o_controller *c = data;
+	struct i2o_scsi_host *i2o_shost;
+	int rc;
+
+	switch (notify) {
+	case I2O_DRIVER_NOTIFY_CONTROLLER_ADD:
+		i2o_shost = i2o_scsi_host_alloc(c);
+		if (IS_ERR(i2o_shost)) {
+			printk(KERN_ERR "scsi-osm: Could not initialize"
+			       " SCSI host\n");
+			return;
+		}
+
+		rc = scsi_add_host(i2o_shost->scsi_host, &c->device);
+		if (rc) {
+			printk(KERN_ERR "scsi-osm: Could not add SCSI "
+			       "host\n");
+			scsi_host_put(i2o_shost->scsi_host);
+			return;
+		}
+
+		c->driver_data[i2o_scsi_driver.context] = i2o_shost;
+
+		pr_debug("new I2O SCSI host added\n");
+		break;
+
+	case I2O_DRIVER_NOTIFY_CONTROLLER_REMOVE:
+		i2o_shost = i2o_scsi_get_host(c);
+		if (!i2o_shost)
+			return;
+
+		c->driver_data[i2o_scsi_driver.context] = NULL;
+
+		scsi_remove_host(i2o_shost->scsi_host);
+		scsi_host_put(i2o_shost->scsi_host);
+		pr_debug("I2O SCSI host removed\n");
+		break;
+
+	default:
+		break;
+	}
+};
+
 /* SCSI OSM driver struct */
 static struct i2o_driver i2o_scsi_driver = {
 	.name = "scsi-osm",
 	.reply = i2o_scsi_reply,
 	.classes = i2o_scsi_class_id,
+	.notify = i2o_scsi_notify,
 	.driver = {
 		   .probe = i2o_scsi_probe,
 		   .remove = i2o_scsi_remove,
@@ -736,54 +747,47 @@
 	return 0;
 };
 
-#if 0
-FIXME
 /**
- *	i2o_scsi_abort	-	abort a running command
+ *	i2o_scsi_abort - abort a running command
  *	@SCpnt: command to abort
  *
  *	Ask the I2O controller to abort a command. This is an asynchrnous
- *	process and our callback handler will see the command complete
- *	with an aborted message if it succeeds.
+ *	process and our callback handler will see the command complete with an
+ *	aborted message if it succeeds.
  *
- *	Locks: no locks are held or needed
+ *	Returns 0 if the command is successfully aborted or negative error code
+ *	on failure.
  */
 int i2o_scsi_abort(struct scsi_cmnd *SCpnt)
 {
+	struct i2o_device *i2o_dev;
 	struct i2o_controller *c;
-	struct Scsi_Host *host;
-	struct i2o_scsi_host *hostdata;
-	u32 msg[5];
+	struct i2o_message *msg;
+	u32 m;
 	int tid;
 	int status = FAILED;
 
 	printk(KERN_WARNING "i2o_scsi: Aborting command block.\n");
 
-	host = SCpnt->device->host;
-	hostdata = (struct i2o_scsi_host *)host->hostdata;
-	tid = hostdata->task[SCpnt->device->id][SCpnt->device->lun];
-	if (tid == -1) {
-		printk(KERN_ERR "i2o_scsi: Impossible command to abort!\n");
-		return status;
-	}
-	c = hostdata->controller;
+	i2o_dev = SCpnt->device->hostdata;
+	c = i2o_dev->iop;
+	tid = i2o_dev->lct_data.tid;
 
-	spin_unlock_irq(host->host_lock);
+	m = i2o_msg_get_wait(c, &msg, I2O_TIMEOUT_MESSAGE_GET);
+	if (m == I2O_QUEUE_EMPTY)
+		return SCSI_MLQUEUE_HOST_BUSY;
 
-	msg[0] = FIVE_WORD_MSG_SIZE;
-	msg[1] = I2O_CMD_SCSI_ABORT << 24 | HOST_TID << 12 | tid;
-	msg[2] = scsi_context;
-	msg[3] = 0;
-	msg[4] = i2o_context_list_remove(SCpnt, c);
-	if (i2o_post_wait(c, msg, sizeof(msg), 240))
+	writel(FIVE_WORD_MSG_SIZE | SGL_OFFSET_0, &msg->u.head[0]);
+	writel(I2O_CMD_SCSI_ABORT << 24 | HOST_TID << 12 | tid,
+	       &msg->u.head[1]);
+	writel(i2o_cntxt_list_get_ptr(c, SCpnt), &msg->body[0]);
+
+	if (i2o_msg_post_wait(c, m, I2O_TIMEOUT_SCSI_SCB_ABORT))
 		status = SUCCESS;
 
-	spin_lock_irq(host->host_lock);
 	return status;
 }
 
-#endif
-
 /**
  *	i2o_scsi_bios_param	-	Invent disk geometry
  *	@sdev: scsi device
@@ -817,15 +821,12 @@
 	.name = "I2O SCSI Peripheral OSM",
 	.info = i2o_scsi_info,
 	.queuecommand = i2o_scsi_queuecommand,
-/*
-	.eh_abort_handler	= i2o_scsi_abort,
-*/
+	.eh_abort_handler = i2o_scsi_abort,
 	.bios_param = i2o_scsi_bios_param,
 	.can_queue = I2O_SCSI_CAN_QUEUE,
 	.sg_tablesize = 8,
 	.cmd_per_lun = 6,
 	.use_clustering = ENABLE_CLUSTERING,
-	.slave_alloc = i2o_scsi_slave_alloc,
 };
 
 /*
@@ -867,14 +868,6 @@
  */
 static void __exit i2o_scsi_exit(void)
 {
-	struct i2o_scsi_host *i2o_shost, *tmp;
-
-	/* Remove I2O SCSI hosts */
-	list_for_each_entry_safe(i2o_shost, tmp, &i2o_scsi_hosts, list) {
-		scsi_remove_host(i2o_shost->scsi_host);
-		scsi_host_put(i2o_shost->scsi_host);
-	}
-
 	/* Unregister I2O SCSI OSM from I2O core */
 	i2o_driver_unregister(&i2o_scsi_driver);
 };
Index: drivers/message/i2o/driver.c
===================================================================
--- a/drivers/message/i2o/driver.c	(revision 111)
+++ b/drivers/message/i2o/driver.c	(revision 112)
@@ -72,6 +72,7 @@
  */
 int i2o_driver_register(struct i2o_driver *drv)
 {
+	struct i2o_controller *c;
 	int i;
 	int rc = 0;
 	unsigned long flags;
@@ -108,6 +109,9 @@
 	spin_unlock_irqrestore(&i2o_drivers_lock, flags);
 
 	pr_debug("driver %s gets context id %d\n", drv->name, drv->context);
+	
+	list_for_each_entry(c, &i2o_controllers, list)
+		i2o_driver_notify(drv, I2O_DRIVER_NOTIFY_CONTROLLER_ADD, c);
 
 	rc = driver_register(&drv->driver);
 	if (rc)
@@ -125,12 +129,16 @@
  */
 void i2o_driver_unregister(struct i2o_driver *drv)
 {
+	struct i2o_controller *c;
 	unsigned long flags;
 
 	pr_debug("unregister driver %s\n", drv->name);
 
 	driver_unregister(&drv->driver);
 
+	list_for_each_entry(c, &i2o_controllers, list)
+		i2o_driver_notify(drv, I2O_DRIVER_NOTIFY_CONTROLLER_REMOVE, c);
+
 	spin_lock_irqsave(&i2o_drivers_lock, flags);
 	i2o_drivers[drv->context] = NULL;
 	spin_unlock_irqrestore(&i2o_drivers_lock, flags);
@@ -220,6 +228,23 @@
 }
 
 /**
+ *	i2o_driver_notify_all - Send notification to all I2O drivers
+ *
+ *	Send notifications to all registered drivers.
+ */
+void i2o_driver_notify_all(enum i2o_driver_notify evt, void *data) {
+	int i;
+	struct i2o_driver *drv;
+
+	for(i = 0; i < I2O_MAX_DRIVERS; i ++) {
+		drv = i2o_drivers[i];
+
+		if(drv)
+			i2o_driver_notify(drv, evt, data);
+	}
+}
+
+/**
  *	i2o_driver_init - initialize I2O drivers (OSMs)
  *
  *	Registers the I2O bus and allocate memory for the array of OSMs.
@@ -267,3 +292,4 @@
 
 EXPORT_SYMBOL(i2o_driver_register);
 EXPORT_SYMBOL(i2o_driver_unregister);
+EXPORT_SYMBOL(i2o_driver_notify_all);

--------------050205050101040006040306--
