Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264977AbUD2UeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264977AbUD2UeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264976AbUD2UdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:33:17 -0400
Received: from [213.133.118.2] ([213.133.118.2]:22417 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S264964AbUD2U2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:28:00 -0400
Message-ID: <40916627.50800@shadowconnect.com>
Date: Thu, 29 Apr 2004 22:31:35 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] I2O subsystem fixing and cleanup for 2.6 - i2o-64-bit-fix.patch
Content-Type: multipart/mixed;
 boundary="------------020102030501040002060805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020102030501040002060805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------020102030501040002060805
Content-Type: text/plain;
 name="i2o-64-bit-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-64-bit-fix.patch"

--- a/drivers/message/i2o/i2o_core.c	2004-04-03 17:37:36.000000000 -1000
+++ b/drivers/message/i2o/i2o_core.c	2004-04-25 06:37:54.000000000 -1000
@@ -213,6 +213,135 @@
 
 static int verbose;
 
+#if BITS_PER_LONG == 64
+/**
+ *      i2o_context_list_add -	append an ptr to the context list and return a
+ *				matching context id.
+ *	@ptr: pointer to add to the context list
+ *	@c: controller to which the context list belong
+ *	returns context id, which could be used in the transaction context
+ *	field.
+ *
+ *	Because the context field in I2O is only 32-bit large, on 64-bit the
+ *	pointer is to large to fit in the context field. The i2o_context_list
+ *	functiones map pointers to context fields.
+ */
+u32 i2o_context_list_add(void *ptr, struct i2o_controller *c) {
+	u32 context = 1;
+	struct i2o_context_list_element **entry = &c->context_list;
+	struct i2o_context_list_element *element;
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->context_list_lock, flags);
+	while(*entry && ((*entry)->flags & I2O_CONTEXT_LIST_USED)) {
+		if((*entry)->context >= context)
+			context = (*entry)->context + 1;
+		entry = &((*entry)->next);
+	}
+
+	if(!*entry) {
+		if(unlikely(!context)) {
+			spin_unlock_irqrestore(&c->context_list_lock, flags);
+			printk(KERN_EMERG "i2o_core: context list overflow\n");
+			return 0;
+		}
+
+		element = kmalloc(sizeof(struct i2o_context_list_element), GFP_KERNEL);
+		if(!element) {
+			printk(KERN_EMERG "i2o_core: could not allocate memory for context list element\n");
+			return 0;
+		}
+		element->context = context;
+		element->next = NULL;
+		*entry = element;
+	} else
+		element = *entry;
+
+	element->ptr = ptr;
+	element->flags = I2O_CONTEXT_LIST_USED;
+
+	spin_unlock_irqrestore(&c->context_list_lock, flags);
+	dprintk(KERN_DEBUG "i2o_core: add context to list %p -> %d\n", ptr, context);
+	return context;
+}
+
+/**
+ *      i2o_context_list_remove - remove a ptr from the context list and return
+ *				  the matching context id.
+ *	@ptr: pointer to be removed from the context list
+ *	@c: controller to which the context list belong
+ *	returns context id, which could be used in the transaction context
+ *	field.
+ */
+u32 i2o_context_list_remove(void *ptr, struct i2o_controller *c) {
+	struct i2o_context_list_element **entry = &c->context_list;
+	struct i2o_context_list_element *element;
+	u32 context;
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->context_list_lock, flags);
+	while(*entry && ((*entry)->ptr != ptr))
+		entry = &((*entry)->next);
+
+	if(unlikely(!*entry)) {
+		spin_unlock_irqrestore(&c->context_list_lock, flags);
+		printk(KERN_WARNING "i2o_core: could not remove nonexistent ptr %p\n", ptr);
+		return 0;
+	}
+
+	element = *entry;
+
+	context = element->context;
+	element->ptr = NULL;
+	element->flags |= I2O_CONTEXT_LIST_DELETED;
+
+	spin_unlock_irqrestore(&c->context_list_lock, flags);
+	dprintk(KERN_DEBUG "i2o_core: markt as deleted in context list %p -> %d\n", ptr, context);
+	return context;
+}
+
+/**
+ *      i2o_context_list_get -	get a ptr from the context list and remove it
+ *				from the list.
+ *	@context: context id to which the pointer belong
+ *	@c: controller to which the context list belong
+ *	returns pointer to the matching context id
+ */
+void *i2o_context_list_get(u32 context, struct i2o_controller *c) {
+	struct i2o_context_list_element **entry = &c->context_list;
+	struct i2o_context_list_element *element;
+	void *ptr;
+	int count = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->context_list_lock, flags);
+	while(*entry && ((*entry)->context != context)) {
+		entry = &((*entry)->next);
+		count ++;
+	}
+
+	if(unlikely(!*entry)) {
+		spin_unlock_irqrestore(&c->context_list_lock, flags);
+		printk(KERN_WARNING "i2o_core: context id %d not found\n", context);
+		return NULL;
+	}
+
+	element = *entry;
+	ptr = element->ptr;
+	if(count >= I2O_CONTEXT_LIST_MIN_LENGTH) {
+		*entry = (*entry)->next;
+		kfree(element);
+	} else {
+		element->ptr = NULL;
+		element->flags &= !I2O_CONTEXT_LIST_USED;
+	}
+
+	spin_unlock_irqrestore(&c->context_list_lock, flags);
+	dprintk(KERN_DEBUG "i2o_core: get ptr from context list %d -> %p\n", context, ptr);
+	return ptr;
+}
+#endif
+
 /*
  * I2O Core reply handler
  */
@@ -3551,6 +3678,10 @@
 	c->short_req = 0;
 	c->pdev = dev;
 
+#if BITS_PER_LONG == 64
+	c->context_list_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
 	c->irq_mask = mem+0x34;
 	c->post_port = mem+0x40;
 	c->reply_port = mem+0x44;
@@ -3788,3 +3919,6 @@
 EXPORT_SYMBOL(i2o_report_status);
 EXPORT_SYMBOL(i2o_dump_message);
 EXPORT_SYMBOL(i2o_get_class_name);
+EXPORT_SYMBOL(i2o_context_list_add);
+EXPORT_SYMBOL(i2o_context_list_get);
+EXPORT_SYMBOL(i2o_context_list_remove);
--- a/drivers/message/i2o/i2o_scsi.c	2004-04-03 17:37:41.000000000 -1000
+++ b/drivers/message/i2o/i2o_scsi.c	2004-04-25 04:08:44.000000000 -1000
@@ -62,9 +62,6 @@
 #include "../../scsi/scsi.h"
 #include "../../scsi/hosts.h"
 
-#if BITS_PER_LONG == 64
-#error FIXME: driver does not support 64-bit platforms
-#endif
 
 
 #define VERSION_STRING        "Version 0.1.2"
@@ -233,7 +230,10 @@
 		{
 			spin_unlock_irqrestore(&retry_lock, flags);
 			/* Create a scsi error for this */
-			current_command = (Scsi_Cmnd *)m[3];
+			current_command = (Scsi_Cmnd *)i2o_context_list_get(m[3], c);
+			if(!current_command)
+				return;
+
 			lock = current_command->device->host->host_lock;
 			printk("Aborted %ld\n", current_command->serial_number);
 
@@ -276,16 +276,15 @@
 		printk(KERN_INFO "i2o_scsi: bus reset completed.\n");
 		return;
 	}
-	/*
- 	 *	FIXME: 64bit breakage
-	 */
 
-	current_command = (Scsi_Cmnd *)m[3];
+	current_command = (Scsi_Cmnd *)i2o_context_list_get(m[3], c);
 	
 	/*
 	 *	Is this a control request coming back - eg an abort ?
 	 */
 	 
+	atomic_dec(&queue_depth);
+
 	if(current_command==NULL)
 	{
 		if(st)
@@ -296,8 +295,6 @@
 	
 	dprintk(KERN_INFO "Completed %ld\n", current_command->serial_number);
 	
-	atomic_dec(&queue_depth);
-	
 	if(st == 0x06)
 	{
 		if(le32_to_cpu(m[5]) < current_command->underflow)
@@ -647,9 +644,7 @@
 	if(tid == -1)
 	{
 		SCpnt->result = DID_NO_CONNECT << 16;
-		spin_lock_irqsave(host->host_lock, flags);
 		done(SCpnt);
-		spin_unlock_irqrestore(host->host_lock, flags);
 		return 0;
 	}
 	
@@ -699,8 +696,7 @@
 	
 	i2o_raw_writel(I2O_CMD_SCSI_EXEC<<24|HOST_TID<<12|tid, &msg[1]);
 	i2o_raw_writel(scsi_context, &msg[2]);	/* So the I2O layer passes to us */
-	/* Sorry 64bit folks. FIXME */
-	i2o_raw_writel((u32)SCpnt, &msg[3]);	/* We want the SCSI control block back */
+	i2o_raw_writel(i2o_context_list_add(SCpnt, c), &msg[3]);	/* We want the SCSI control block back */
 
 	/* LSI_920_PCI_QUIRK
 	 *
@@ -883,7 +879,7 @@
  *	@SCpnt: command to abort
  *
  *	Ask the I2O controller to abort a command. This is an asynchrnous
- *	process and oru callback handler will see the command complete
+ *	process and our callback handler will see the command complete
  *	with an aborted message if it succeeds. 
  *
  *	Locks: no locks are held or needed
@@ -894,10 +890,9 @@
 	struct i2o_controller *c;
 	struct Scsi_Host *host;
 	struct i2o_scsi_host *hostdata;
-	unsigned long msg;
-	u32 m;
+	u32 msg[5];
 	int tid;
-	unsigned long timeout;
+	int status = FAILED;
 	
 	printk(KERN_WARNING "i2o_scsi: Aborting command block.\n");
 	
@@ -907,37 +902,22 @@
 	if(tid==-1)
 	{
 		printk(KERN_ERR "i2o_scsi: Impossible command to abort!\n");
-		return FAILED;
+		return status;
 	}
 	c = hostdata->controller;
 
 	spin_unlock_irq(host->host_lock);
 		
-	timeout = jiffies+2*HZ;
-	do
-	{
-		m = le32_to_cpu(I2O_POST_READ32(c));
-		if(m != 0xFFFFFFFF)
-			break;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
-		mb();
-	}
-	while(time_before(jiffies, timeout));
-	
-	msg = c->mem_offset + m;
-	
-	i2o_raw_writel(FIVE_WORD_MSG_SIZE, msg);
-	i2o_raw_writel(I2O_CMD_SCSI_ABORT<<24|HOST_TID<<12|tid, msg+4);
-	i2o_raw_writel(scsi_context, msg+8);
-	i2o_raw_writel(0, msg+12);	/* Not needed for an abort */
-	i2o_raw_writel((u32)SCpnt, msg+16);	
-	wmb();
-	i2o_post_message(c,m);
-	wmb();
-	
+	msg[0] = FIVE_WORD_MSG_SIZE;
+	msg[1] = I2O_CMD_SCSI_ABORT<<24|HOST_TID<<12|tid;
+	msg[2] = scsi_context;
+	msg[3] = 0;
+	msg[4] = i2o_context_list_remove(SCpnt, c);
+	if(i2o_post_wait(c, msg, sizeof(msg), 240))
+		status = SUCCESS;
+
 	spin_lock_irq(host->host_lock);
-	return SUCCESS;
+	return status;
 }
 
 /**
--- a/include/linux/i2o.h	2004-04-03 17:36:27.000000000 -1000
+++ b/include/linux/i2o.h	2004-04-25 07:17:21.594623832 -1000
@@ -76,6 +76,16 @@
 };
 
 /*
+ * context queue entry, used for 32-bit context on 64-bit systems
+ */
+struct i2o_context_list_element {
+	struct i2o_context_list_element *next;
+	u32 context;
+	void *ptr;
+	unsigned int flags;
+};
+
+/*
  * Each I2O controller has one of these objects
  */
 struct i2o_controller
@@ -133,6 +143,11 @@
 
 	void *page_frame;			/* Message buffers */
 	dma_addr_t page_frame_map;		/* Cache map */
+#if BITS_PER_LONG == 64
+	spinlock_t context_list_lock;		/* lock for context_list */
+	struct i2o_context_list_element *context_list; /* list of context id's
+						    and pointers */
+#endif
 };
 
 /*
@@ -322,6 +335,27 @@
 extern void i2o_run_queue(struct i2o_controller *);
 extern int i2o_delete_controller(struct i2o_controller *);
 
+#if BITS_PER_LONG == 64
+extern u32 i2o_context_list_add(void *, struct i2o_controller *);
+extern void *i2o_context_list_get(u32, struct i2o_controller *);
+extern u32 i2o_context_list_remove(void *, struct i2o_controller *);
+#else
+static inline u32 i2o_context_list_add(void *ptr, struct i2o_controller *c)
+{
+	return (u32)ptr;
+}
+
+static inline void *i2o_context_list_get(u32 context, struct i2o_controller *c)
+{
+	return (void *)context;
+}
+
+static inline u32 i2o_context_list_remove(void *ptr, struct i2o_controller *c)
+{
+	return (u32)ptr;
+}
+#endif
+
 /*
  *	Cache strategies
  */
@@ -647,5 +683,9 @@
 #define I2O_POST_WAIT_OK	0
 #define I2O_POST_WAIT_TIMEOUT	-ETIMEDOUT
 
+#define I2O_CONTEXT_LIST_MIN_LENGTH	15
+#define I2O_CONTEXT_LIST_USED		0x01
+#define I2O_CONTEXT_LIST_DELETED	0x02
+
 #endif /* __KERNEL__ */
 #endif /* _I2O_H */

--------------020102030501040002060805--
