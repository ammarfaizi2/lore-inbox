Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVFPU0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVFPU0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVFPUZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:25:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:42717 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261806AbVFPUUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:20:44 -0400
Subject: [patch][4/4] ibmasm driver: fix race in command refcount logic
From: Max Asbock <masbock@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Vernon Mauery <vernux@us.ibm.com>
Content-Type: text/plain
Message-Id: <1118953230.8372.83.camel@w-amax>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 16 Jun 2005 13:20:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a race in the command reference counting logic by putting spinlocks around
kobject_put() in the command_put function.
- Also added debug messages.
- Changed a memcpy to memcpy_fromio since we are reading from io space.

Signed-off-by: Max Asbock <masbock@us.ibm.com>


diff -urN linux-2.6.12-rc6.test/drivers/misc/ibmasm/command.c linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/command.c
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/command.c	2005-06-09 18:02:28.021406968 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/command.c	2005-06-08 17:54:09.512988256 -0700
@@ -23,6 +23,7 @@
  */
 
 #include "ibmasm.h"
+#include "lowlevel.h"
 
 static void exec_next_command(struct service_processor *sp);
 static void free_command(struct kobject *kobj);
@@ -31,8 +32,9 @@
 	.release = free_command,
 };
 
+static atomic_t command_count = ATOMIC_INIT(0);
 
-struct command *ibmasm_new_command(size_t buffer_size)
+struct command *ibmasm_new_command(struct service_processor *sp, size_t buffer_size)
 {
 	struct command *cmd;
 
@@ -55,11 +57,15 @@
 
 	kobject_init(&cmd->kobj);
 	cmd->kobj.ktype = &ibmasm_cmd_kobj_type;
+	cmd->lock = &sp->lock;
 
 	cmd->status = IBMASM_CMD_PENDING;
 	init_waitqueue_head(&cmd->wait);
 	INIT_LIST_HEAD(&cmd->queue_node);
 
+	atomic_inc(&command_count);
+	dbg("command count: %d\n", atomic_read(&command_count));
+
 	return cmd;
 }
 
@@ -68,6 +74,8 @@
 	struct command *cmd = to_command(kobj);
  
 	list_del(&cmd->queue_node);
+	atomic_dec(&command_count);
+	dbg("command count: %d\n", atomic_read(&command_count));
 	kfree(cmd->buffer);
 	kfree(cmd);
 }
@@ -94,8 +102,14 @@
 
 static inline void do_exec_command(struct service_processor *sp)
 {
+	char tsbuf[32];
+
+	dbg("%s:%d at %s\n", __FUNCTION__, __LINE__, get_timestamp(tsbuf));
+
 	if (ibmasm_send_i2o_message(sp)) {
 		sp->current_command->status = IBMASM_CMD_FAILED;
+		wake_up(&sp->current_command->wait);
+		command_put(sp->current_command);
 		exec_next_command(sp);
 	}
 }
@@ -111,14 +125,16 @@
 void ibmasm_exec_command(struct service_processor *sp, struct command *cmd)
 {
 	unsigned long flags;
+	char tsbuf[32];
+
+	dbg("%s:%d at %s\n", __FUNCTION__, __LINE__, get_timestamp(tsbuf));
 
 	spin_lock_irqsave(&sp->lock, flags);
 
 	if (!sp->current_command) {
-		command_get(cmd);
 		sp->current_command = cmd;
+		command_get(sp->current_command);
 		spin_unlock_irqrestore(&sp->lock, flags);
-
 		do_exec_command(sp);
 	} else {
 		enqueue_command(sp, cmd);
@@ -129,9 +145,9 @@
 static void exec_next_command(struct service_processor *sp)
 {
 	unsigned long flags;
+	char tsbuf[32];
 
-	wake_up(&sp->current_command->wait);
-	command_put(sp->current_command);
+	dbg("%s:%d at %s\n", __FUNCTION__, __LINE__, get_timestamp(tsbuf));
 
 	spin_lock_irqsave(&sp->lock, flags);
 	sp->current_command = dequeue_command(sp);
@@ -169,7 +185,9 @@
 	if (!sp->current_command) 
 		return; 
 
-	memcpy(cmd->buffer, response, min(size, cmd->buffer_size));
+	memcpy_fromio(cmd->buffer, response, min(size, cmd->buffer_size));
 	cmd->status = IBMASM_CMD_COMPLETE;
+	wake_up(&sp->current_command->wait);
+	command_put(sp->current_command);
 	exec_next_command(sp);
 }
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/dot_command.c	2005-06-09 18:02:28.021406968 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/dot_command.c	2005-06-08 17:54:09.517987496 -0700
@@ -33,7 +33,13 @@
 	u32 size;
 	struct dot_command_header *header = (struct dot_command_header *)message;
 
+	if (message_size == 0)
+		return;
+
 	size = get_dot_command_size(message);
+	if (size == 0)
+		return;
+
 	if (size > message_size)
 		size = message_size;
 
@@ -67,7 +73,7 @@
 	u8 *vpd_data;
 	int result = 0;
 
-	command = ibmasm_new_command(INIT_BUFFER_SIZE);
+	command = ibmasm_new_command(sp, INIT_BUFFER_SIZE);
 	if (command == NULL)
 		return -ENOMEM;
 
@@ -121,7 +127,7 @@
 	struct os_state_command *os_state_cmd;
 	int result = 0;
 
-	cmd = ibmasm_new_command(sizeof(struct os_state_command));
+	cmd = ibmasm_new_command(sp, sizeof(struct os_state_command));
 	if (cmd == NULL)
 		return -ENOMEM;
 
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/heartbeat.c	2005-06-09 18:02:28.022406816 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/heartbeat.c	2005-06-08 17:54:09.525986280 -0700
@@ -25,6 +25,7 @@
 #include <linux/notifier.h>
 #include "ibmasm.h"
 #include "dot_command.h"
+#include "lowlevel.h"
 
 static int suspend_heartbeats = 0;
 
@@ -62,7 +63,7 @@
 
 int ibmasm_heartbeat_init(struct service_processor *sp)
 {
-	sp->heartbeat = ibmasm_new_command(HEARTBEAT_BUFFER_SIZE);
+	sp->heartbeat = ibmasm_new_command(sp, HEARTBEAT_BUFFER_SIZE);
 	if (sp->heartbeat == NULL)
 		return -ENOMEM;
 
@@ -71,6 +72,12 @@
 
 void ibmasm_heartbeat_exit(struct service_processor *sp)
 {
+	char tsbuf[32];
+
+	dbg("%s:%d at %s\n", __FUNCTION__, __LINE__, get_timestamp(tsbuf));
+	ibmasm_wait_for_response(sp->heartbeat, IBMASM_CMD_TIMEOUT_NORMAL);
+	dbg("%s:%d at %s\n", __FUNCTION__, __LINE__, get_timestamp(tsbuf));
+	suspend_heartbeats = 1;
 	command_put(sp->heartbeat);
 }
 
@@ -78,14 +85,16 @@
 {
 	struct command *cmd = sp->heartbeat;
 	struct dot_command_header *header = (struct dot_command_header *)cmd->buffer;
+	char tsbuf[32];
 
+	dbg("%s:%d at %s\n", __FUNCTION__, __LINE__, get_timestamp(tsbuf));
 	if (suspend_heartbeats)
 		return;
 
 	/* return the received dot command to sender */
 	cmd->status = IBMASM_CMD_PENDING;
 	size = min(size, cmd->buffer_size);
-	memcpy(cmd->buffer, message, size);
+	memcpy_fromio(cmd->buffer, message, size);
 	header->type = sp_write;
 	ibmasm_exec_command(sp, cmd);
 }
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/ibmasmfs.c	2005-06-09 23:01:41.535058032 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/ibmasmfs.c	2005-06-08 17:54:09.533985064 -0700
@@ -321,7 +321,7 @@
 	if (command_data->command)
 		return -EAGAIN;
 
-	cmd = ibmasm_new_command(count);
+	cmd = ibmasm_new_command(command_data->sp, count);
 	if (!cmd)
 		return -ENOMEM;
 
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/ibmasm.h	2005-06-09 23:01:41.536057880 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/ibmasm.h	2005-06-08 17:54:09.534984912 -0700
@@ -91,12 +91,17 @@
 	size_t			buffer_size;
 	int			status;
 	struct kobject		kobj;
+	spinlock_t		*lock;
 };
 #define to_command(c) container_of(c, struct command, kobj)
 
 static inline void command_put(struct command *cmd)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(cmd->lock, flags);
         kobject_put(&cmd->kobj);
+	spin_unlock_irqrestore(cmd->lock, flags);
 }
 
 static inline void command_get(struct command *cmd)
@@ -155,7 +160,7 @@
 };
 
 /* command processing */
-extern struct command *ibmasm_new_command(size_t buffer_size);
+extern struct command *ibmasm_new_command(struct service_processor *sp, size_t buffer_size);
 extern void ibmasm_exec_command(struct service_processor *sp, struct command *cmd);
 extern void ibmasm_wait_for_response(struct command *cmd, int timeout);
 extern void ibmasm_receive_command_response(struct service_processor *sp, void *response,  size_t size);
diff -urN linux-2.6.12-rc6.test/drivers/misc/ibmasm/r_heartbeat.c linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/r_heartbeat.c
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/r_heartbeat.c	2005-06-09 18:02:28.022406816 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/r_heartbeat.c	2005-06-08 17:54:09.545983240 -0700
@@ -63,7 +63,7 @@
 	int times_failed = 0;
 	int result = 1;
 
-	cmd = ibmasm_new_command(sizeof rhb_dot_cmd);
+	cmd = ibmasm_new_command(sp, sizeof rhb_dot_cmd);
 	if (!cmd)
 		return -ENOMEM;
 


