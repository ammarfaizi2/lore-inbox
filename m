Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWFVSgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWFVSgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWFVSgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:36:09 -0400
Received: from ns2.suse.de ([195.135.220.15]:52158 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030328AbWFVSaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:30:35 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/14] [PATCH] w1: Userspace communication protocol over connector.
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:07 -0700
Message-Id: <11510008461301-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510008413045-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

There are three types of messages between w1 core and userspace:
1. Events. They are generated each time new master or slave device found
	either due to automatic or requested search.
2. Userspace commands. Includes read/write and search/alarm search comamnds.
3. Replies to userspace commands.

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/w1/w1.netlink   |   98 +++++++++++++++++++
 drivers/w1/Makefile           |    2 
 drivers/w1/slaves/w1_ds2433.c |    1 
 drivers/w1/slaves/w1_smem.c   |    1 
 drivers/w1/slaves/w1_therm.c  |    1 
 drivers/w1/w1.c               |  137 ++++++++++++++++++--------
 drivers/w1/w1.h               |   38 ++++---
 drivers/w1/w1_family.h        |    1 
 drivers/w1/w1_int.c           |   27 +++--
 drivers/w1/w1_io.c            |   18 +--
 drivers/w1/w1_netlink.c       |  215 +++++++++++++++++++++++++++++++++++------
 drivers/w1/w1_netlink.h       |   38 +++++--
 12 files changed, 445 insertions(+), 132 deletions(-)

diff --git a/Documentation/w1/w1.netlink b/Documentation/w1/w1.netlink
new file mode 100644
index 0000000..3640c7c
--- /dev/null
+++ b/Documentation/w1/w1.netlink
@@ -0,0 +1,98 @@
+Userspace communication protocol over connector [1].
+
+
+Message types.
+=============
+
+There are three types of messages between w1 core and userspace:
+1. Events. They are generated each time new master or slave device found
+	either due to automatic or requested search.
+2. Userspace commands. Includes read/write and search/alarm search comamnds.
+3. Replies to userspace commands.
+
+
+Protocol.
+========
+
+[struct cn_msg] - connector header. It's length field is equal to size of the attached data.
+[struct w1_netlink_msg] - w1 netlink header.
+	__u8 type 	- message type.
+			W1_SLAVE_ADD/W1_SLAVE_REMOVE - slave add/remove events.
+			W1_MASTER_ADD/W1_MASTER_REMOVE - master add/remove events.
+			W1_MASTER_CMD - userspace command for bus master device (search/alarm search).
+			W1_SLAVE_CMD - userspace command for slave device (read/write/ search/alarm search
+					for bus master device where given slave device found).
+	__u8 res	- reserved
+	__u16 len	- size of attached to this header data.
+	union {
+		__u8 id;			 - slave unique device id
+		struct w1_mst {
+			__u32		id;	 - master's id.
+			__u32		res;	 - reserved
+		} mst;
+	} id;
+
+[strucrt w1_netlink_cmd] - command for gived master or slave device.
+	__u8 cmd	- command opcode.
+			W1_CMD_READ 	- read command.
+			W1_CMD_WRITE	- write command.
+			W1_CMD_SEARCH	- search command.
+			W1_CMD_ALARM_SEARCH - alarm search command.
+	__u8 res	- reserved
+	__u16 len	- length of data for this command.
+			For read command data must be allocated like for write command.
+	__u8 data[0]	- data for this command.
+
+
+Each connector message can include one or more w1_netlink_msg with zero of more attached w1_netlink_cmd messages.
+
+For event messages there are no w1_netlink_cmd embedded structures, only connector header
+and w1_netlink_msg strucutre with "len" field being zero and filled type (one of event types)
+and id - either 8 bytes of slave unique id in host order, or master's id, which is assigned
+to bus master device when it is added to w1 core.
+
+Currently replies to userspace commands are only generated for read command request.
+One reply is generated exactly for one w1_netlink_cmd read request.
+Replies are not combined when sent - i.e. typical reply messages looks like the following:
+[cn_msg][w1_netlink_msg][w1_netlink_cmd]
+cn_msg.len = sizeof(struct w1_netlink_msg) + sizeof(struct w1_netlink_cmd) + cmd->len;
+w1_netlink_msg.len = sizeof(struct w1_netlink_cmd) + cmd->len;
+w1_netlink_cmd.len = cmd->len;
+
+
+Operation steps in w1 core when new command is received.
+=======================================================
+
+When new message (w1_netlink_msg) is received w1 core detects if it is master of slave request,
+according to w1_netlink_msg.type field.
+Then master or slave device is searched for.
+When found, master device (requested or those one on where slave device is found) is locked.
+If slave command is requested, then reset/select procedure is started to select given device.
+
+Then all requested in w1_netlink_msg operations are performed one by one.
+If command requires reply (like read command) it is sent on command completion.
+
+When all commands (w1_netlink_cmd) are processed muster device is unlocked
+and next w1_netlink_msg header processing started.
+
+
+Connector [1] specific documentation.
+====================================
+
+Each connector message includes two u32 fields as "address".
+w1 uses CN_W1_IDX and CN_W1_VAL defined in include/linux/connector.h header.
+Each message also includes sequence and acknowledge numbers.
+Sequence number for event messages is appropriate bus master sequence number increased with
+each event message sent "through" this master.
+Sequence number for userspace requests is set by userspace application.
+Sequence number for reply is the same as was in request, and
+acknowledge number is set to seq+1.
+
+
+Additional documantion, source code examples.
+============================================
+
+1. Documentation/connector
+2. http://tservice.net.ru/~s0mbre/archive/w1
+This archive includes userspace application w1d.c which
+uses read/write/search commands for all master/slave devices found on the bus.
diff --git a/drivers/w1/Makefile b/drivers/w1/Makefile
index 0c2aa22..f0465c2 100644
--- a/drivers/w1/Makefile
+++ b/drivers/w1/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for the Dallas's 1-wire bus.
 #
 
-ifneq ($(CONFIG_NET), y)
+ifeq ($(CONFIG_CONNECTOR), n)
 EXTRA_CFLAGS	+= -DNETLINK_DISABLED
 endif
 
diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index fb118be..ddd01e6 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -22,7 +22,6 @@ #define CRC16_VALID		0xb001
 #endif
 
 #include "../w1.h"
-#include "../w1_io.h"
 #include "../w1_int.h"
 #include "../w1_family.h"
 
diff --git a/drivers/w1/slaves/w1_smem.c b/drivers/w1/slaves/w1_smem.c
index c6d3be5..cc8c02e 100644
--- a/drivers/w1/slaves/w1_smem.c
+++ b/drivers/w1/slaves/w1_smem.c
@@ -28,7 +28,6 @@ #include <linux/device.h>
 #include <linux/types.h>
 
 #include "../w1.h"
-#include "../w1_io.h"
 #include "../w1_int.h"
 #include "../w1_family.h"
 
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 536d16d..44afdff 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -29,7 +29,6 @@ #include <linux/types.h>
 #include <linux/delay.h>
 
 #include "../w1.h"
-#include "../w1_io.h"
 #include "../w1_int.h"
 #include "../w1_family.h"
 
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index c9486c1..32d8de8 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -35,7 +35,6 @@ #include <linux/kthread.h>
 #include <asm/atomic.h>
 
 #include "w1.h"
-#include "w1_io.h"
 #include "w1_log.h"
 #include "w1_int.h"
 #include "w1_family.h"
@@ -55,7 +54,7 @@ module_param_named(control_timeout, w1_c
 module_param_named(max_slave_count, w1_max_slave_count, int, 0);
 module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
 
-DEFINE_SPINLOCK(w1_mlock);
+DECLARE_MUTEX(w1_mlock);
 LIST_HEAD(w1_masters);
 
 static struct task_struct *w1_control_thread;
@@ -75,8 +74,6 @@ static void w1_master_release(struct dev
 	struct w1_master *md = dev_to_w1_master(dev);
 
 	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
-
-	dev_fini_netlink(md);
 	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
 	kfree(md);
 }
@@ -85,10 +82,10 @@ static void w1_slave_release(struct devi
 {
 	struct w1_slave *sl = dev_to_w1_slave(dev);
 
-	dev_dbg(dev, "%s: Releasing %s.\n", __func__, sl->name);
+	printk("%s: Releasing %s.\n", __func__, sl->name);
 
 	while (atomic_read(&sl->refcnt)) {
-		dev_dbg(dev, "Waiting for %s to become free: refcnt=%d.\n",
+		printk("Waiting for %s to become free: refcnt=%d.\n",
 				sl->name, atomic_read(&sl->refcnt));
 		if (msleep_interruptible(1000))
 			flush_signals(current);
@@ -111,7 +108,6 @@ static ssize_t w1_slave_read_id(struct k
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 
-	atomic_inc(&sl->refcnt);
 	if (off > 8) {
 		count = 0;
 	} else {
@@ -120,7 +116,6 @@ static ssize_t w1_slave_read_id(struct k
 
 		memcpy(buf, (u8 *)&sl->reg_num, count);
 	}
-	atomic_dec(&sl->refcnt);
 
 	return count;
 }
@@ -230,12 +225,11 @@ struct device w1_master_device = {
 	.release = &w1_master_release
 };
 
-static struct device_driver w1_slave_driver = {
+struct device_driver w1_slave_driver = {
 	.name = "w1_slave_driver",
 	.bus = &w1_bus_type,
 };
 
-#if 0
 struct device w1_slave_device = {
 	.parent = NULL,
 	.bus = &w1_bus_type,
@@ -243,7 +237,6 @@ struct device w1_slave_device = {
 	.driver = &w1_slave_driver,
 	.release = &w1_slave_release
 };
-#endif  /*  0  */
 
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -423,7 +416,7 @@ int w1_create_master_attributes(struct w
 	return sysfs_create_group(&master->dev.kobj, &w1_master_defattr_group);
 }
 
-static void w1_destroy_master_attributes(struct w1_master *master)
+void w1_destroy_master_attributes(struct w1_master *master)
 {
 	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
 }
@@ -454,14 +447,11 @@ static int w1_uevent(struct device *dev,
 	if (dev->driver != &w1_slave_driver || !sl)
 		return 0;
 
-	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size,
-			&cur_len, "W1_FID=%02X", sl->reg_num.family);
+	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_FID=%02X", sl->reg_num.family);
 	if (err)
 		return err;
 
-	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size,
-			&cur_len, "W1_SLAVE_ID=%024LX",
-			(unsigned long long)sl->reg_num.id);
+	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_SLAVE_ID=%024LX", (u64)sl->reg_num.id);
 	if (err)
 		return err;
 
@@ -563,6 +553,7 @@ static int w1_attach_slave_device(struct
 	sl->master = dev;
 	set_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
 
+	memset(&msg, 0, sizeof(msg));
 	memcpy(&sl->reg_num, rn, sizeof(sl->reg_num));
 	atomic_set(&sl->refcnt, 0);
 	init_completion(&sl->released);
@@ -593,7 +584,7 @@ static int w1_attach_slave_device(struct
 	sl->ttl = dev->slave_ttl;
 	dev->slave_count++;
 
-	memcpy(&msg.id.id, rn, sizeof(msg.id.id));
+	memcpy(msg.id.id, rn, sizeof(msg.id));
 	msg.type = W1_SLAVE_ADD;
 	w1_netlink_send(dev, &msg);
 
@@ -611,7 +602,8 @@ static void w1_slave_detach(struct w1_sl
 	if (sl->family->fops && sl->family->fops->remove_slave)
 		sl->family->fops->remove_slave(sl);
 
-	memcpy(&msg.id.id, &sl->reg_num, sizeof(msg.id.id));
+	memset(&msg, 0, sizeof(msg));
+	memcpy(msg.id.id, &sl->reg_num, sizeof(msg.id));
 	msg.type = W1_SLAVE_REMOVE;
 	w1_netlink_send(sl->master, &msg);
 
@@ -628,7 +620,7 @@ static struct w1_master *w1_search_maste
 	struct w1_master *dev;
 	int found = 0;
 
-	spin_lock_bh(&w1_mlock);
+	down(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
 		if (dev->bus_master->data == data) {
 			found = 1;
@@ -636,22 +628,69 @@ static struct w1_master *w1_search_maste
 			break;
 		}
 	}
-	spin_unlock_bh(&w1_mlock);
+	up(&w1_mlock);
 
 	return (found)?dev:NULL;
 }
 
+struct w1_master *w1_search_master_id(u32 id)
+{
+	struct w1_master *dev;
+	int found = 0;
+
+	down(&w1_mlock);
+	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
+		if (dev->id == id) {
+			found = 1;
+			atomic_inc(&dev->refcnt);
+			break;
+		}
+	}
+	up(&w1_mlock);
+
+	return (found)?dev:NULL;
+}
+
+struct w1_slave *w1_search_slave(struct w1_reg_num *id)
+{
+	struct w1_master *dev;
+	struct w1_slave *sl = NULL;
+	int found = 0;
+
+	down(&w1_mlock);
+	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
+		down(&dev->mutex);
+		list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
+			if (sl->reg_num.family == id->family &&
+					sl->reg_num.id == id->id &&
+					sl->reg_num.crc == id->crc) {
+				found = 1;
+				atomic_inc(&dev->refcnt);
+				atomic_inc(&sl->refcnt);
+				break;
+			}
+		}
+		up(&dev->mutex);
+
+		if (found)
+			break;
+	}
+	up(&w1_mlock);
+
+	return (found)?sl:NULL;
+}
+
 void w1_reconnect_slaves(struct w1_family *f)
 {
 	struct w1_master *dev;
 
-	spin_lock_bh(&w1_mlock);
+	down(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
 		dev_dbg(&dev->dev, "Reconnecting slaves in %s into new family %02x.\n",
 				dev->name, f->fid);
 		set_bit(W1_MASTER_NEED_RECONNECT, &dev->flags);
 	}
-	spin_unlock_bh(&w1_mlock);
+	up(&w1_mlock);
 }
 
 static void w1_slave_found(void *data, u64 rn)
@@ -713,7 +752,7 @@ static void w1_slave_found(void *data, u
  * @dev        The master device to search
  * @cb         Function to call when a device is found
  */
-void w1_search(struct w1_master *dev, w1_slave_found_callback cb)
+void w1_search(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb)
 {
 	u64 last_rn, rn, tmp64;
 	int i, slave_count = 0;
@@ -744,7 +783,7 @@ void w1_search(struct w1_master *dev, w1
 		}
 
 		/* Start the search */
-		w1_write_8(dev, W1_SEARCH);
+		w1_write_8(dev, search_type);
 		for (i = 0; i < 64; ++i) {
 			/* Determine the direction/search bit */
 			if (i == desc_bit)
@@ -806,9 +845,9 @@ static int w1_control(void *data)
 			if (kthread_should_stop() || test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
 				set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
 
-				spin_lock(&w1_mlock);
+				down(&w1_mlock);
 				list_del(&dev->w1_master_entry);
-				spin_unlock(&w1_mlock);
+				up(&w1_mlock);
 
 				down(&dev->mutex);
 				list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
@@ -843,10 +882,31 @@ static int w1_control(void *data)
 	return 0;
 }
 
+void w1_search_process(struct w1_master *dev, u8 search_type)
+{
+	struct w1_slave *sl, *sln;
+
+	list_for_each_entry(sl, &dev->slist, w1_slave_entry)
+		clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
+
+	w1_search_devices(dev, search_type, w1_slave_found);
+
+	list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
+		if (!test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags) && !--sl->ttl) {
+			w1_slave_detach(sl);
+
+			dev->slave_count--;
+		} else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
+			sl->ttl = dev->slave_ttl;
+	}
+
+	if (dev->search_count > 0)
+		dev->search_count--;
+}
+
 int w1_process(void *data)
 {
 	struct w1_master *dev = (struct w1_master *) data;
-	struct w1_slave *sl, *sln;
 
 	while (!kthread_should_stop() && !test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
 		try_to_freeze();
@@ -864,22 +924,7 @@ int w1_process(void *data)
 		if (down_interruptible(&dev->mutex))
 			continue;
 
-		list_for_each_entry(sl, &dev->slist, w1_slave_entry)
-			clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
-
-		w1_search_devices(dev, w1_slave_found);
-
-		list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
-			if (!test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags) && !--sl->ttl) {
-				w1_slave_detach(sl);
-
-				dev->slave_count--;
-			} else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
-				sl->ttl = dev->slave_ttl;
-		}
-
-		if (dev->search_count > 0)
-			dev->search_count--;
+		w1_search_process(dev, W1_SEARCH);
 
 		up(&dev->mutex);
 	}
@@ -895,6 +940,8 @@ static int w1_init(void)
 
 	printk(KERN_INFO "Driver for 1-wire Dallas network protocol.\n");
 
+	w1_init_netlink();
+
 	retval = bus_register(&w1_bus_type);
 	if (retval) {
 		printk(KERN_ERR "Failed to register bus. err=%d.\n", retval);
@@ -947,6 +994,8 @@ static void w1_fini(void)
 	list_for_each_entry(dev, &w1_masters, w1_master_entry)
 		__w1_remove_master_device(dev);
 
+	w1_fini_netlink();
+
 	kthread_stop(w1_control_thread);
 
 	driver_unregister(&w1_slave_driver);
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index 02e8cad..e8c96e6 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -42,8 +42,6 @@ #ifdef __KERNEL__
 #include <linux/completion.h>
 #include <linux/device.h>
 
-#include <net/sock.h>
-
 #include <asm/semaphore.h>
 
 #include "w1_family.h"
@@ -52,7 +50,7 @@ #define W1_MAXNAMELEN		32
 #define W1_SLAVE_DATA_SIZE	128
 
 #define W1_SEARCH		0xF0
-#define W1_CONDITIONAL_SEARCH	0xEC
+#define W1_ALARM_SEARCH		0xEC
 #define W1_CONVERT_TEMP		0x44
 #define W1_SKIP_ROM		0xCC
 #define W1_READ_SCRATCHPAD	0xBE
@@ -145,8 +143,8 @@ struct w1_bus_master
 	 */
 	u8		(*reset_bus)(void *);
 
-	/** Really nice hardware can handles the ROM searches */
-	void		(*search)(void *, w1_slave_found_callback);
+	/** Really nice hardware can handles the different types of ROM search */
+	void		(*search)(void *, u8, w1_slave_found_callback);
 };
 
 #define W1_MASTER_NEED_EXIT		0
@@ -180,12 +178,26 @@ struct w1_master
 
 	struct w1_bus_master	*bus_master;
 
-	u32			seq, groups;
-	struct sock		*nls;
+	u32			seq;
 };
 
 int w1_create_master_attributes(struct w1_master *);
-void w1_search(struct w1_master *dev, w1_slave_found_callback cb);
+void w1_search(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb);
+void w1_search_devices(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb);
+struct w1_slave *w1_search_slave(struct w1_reg_num *id);
+void w1_search_process(struct w1_master *dev, u8 search_type);
+struct w1_master *w1_search_master_id(u32 id);
+
+void w1_delay(unsigned long);
+u8 w1_touch_bit(struct w1_master *, int);
+u8 w1_triplet(struct w1_master *dev, int bdir);
+void w1_write_8(struct w1_master *, u8);
+u8 w1_read_8(struct w1_master *);
+int w1_reset_bus(struct w1_master *);
+u8 w1_calc_crc8(u8 *, int);
+void w1_write_block(struct w1_master *, const u8 *, int);
+u8 w1_read_block(struct w1_master *, u8 *, int);
+int w1_reset_select_slave(struct w1_slave *sl);
 
 static inline struct w1_slave* dev_to_w1_slave(struct device *dev)
 {
@@ -202,16 +214,6 @@ static inline struct w1_master* dev_to_w
 	return container_of(dev, struct w1_master, dev);
 }
 
-extern int w1_max_slave_count;
-extern int w1_max_slave_ttl;
-extern spinlock_t w1_mlock;
-extern struct list_head w1_masters;
-extern struct device_driver w1_master_driver;
-extern struct device w1_master_device;
-
-int w1_process(void *data);
-void w1_reconnect_slaves(struct w1_family *f);
-
 #endif /* __KERNEL__ */
 
 #endif /* __W1_H */
diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
index 2ca0489..22a9d52 100644
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -64,5 +64,6 @@ void __w1_family_put(struct w1_family *)
 struct w1_family * w1_family_registered(u8);
 void w1_unregister_family(struct w1_family *);
 int w1_register_family(struct w1_family *);
+void w1_reconnect_slaves(struct w1_family *f);
 
 #endif /* __W1_FAMILY_H */
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 68565aa..ae78473 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -27,10 +27,19 @@ #include <linux/kthread.h>
 #include "w1.h"
 #include "w1_log.h"
 #include "w1_netlink.h"
-#include "w1_int.h"
 
 static u32 w1_ids = 1;
 
+extern struct device_driver w1_master_driver;
+extern struct bus_type w1_bus_type;
+extern struct device w1_master_device;
+extern int w1_max_slave_count;
+extern int w1_max_slave_ttl;
+extern struct list_head w1_masters;
+extern struct semaphore w1_mlock;
+
+extern int w1_process(void *);
+
 static struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 				       struct device_driver *driver,
 				       struct device *device)
@@ -74,16 +83,11 @@ static struct w1_master * w1_alloc_dev(u
 
 	dev->driver = driver;
 
-	dev->groups = 1;
 	dev->seq = 1;
-	dev_init_netlink(dev);
 
 	err = device_register(&dev->dev);
 	if (err) {
 		printk(KERN_ERR "Failed to register master device. err=%d\n", err);
-
-		dev_fini_netlink(dev);
-
 		memset(dev, 0, sizeof(struct w1_master));
 		kfree(dev);
 		dev = NULL;
@@ -92,7 +96,7 @@ static struct w1_master * w1_alloc_dev(u
 	return dev;
 }
 
-static void w1_free_dev(struct w1_master *dev)
+void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
 }
@@ -131,12 +135,12 @@ int w1_add_master_device(struct w1_bus_m
 
 	dev->initialized = 1;
 
-	spin_lock(&w1_mlock);
+	down(&w1_mlock);
 	list_add(&dev->w1_master_entry, &w1_masters);
-	spin_unlock(&w1_mlock);
+	up(&w1_mlock);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.id.mst.id = dev->id;
-	msg.id.mst.pid = dev->thread->pid;
 	msg.type = W1_MASTER_ADD;
 	w1_netlink_send(dev, &msg);
 
@@ -153,7 +157,6 @@ err_out_free_dev:
 void __w1_remove_master_device(struct w1_master *dev)
 {
 	struct w1_netlink_msg msg;
-	pid_t pid = dev->thread->pid;
 
 	set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
 	kthread_stop(dev->thread);
@@ -166,8 +169,8 @@ void __w1_remove_master_device(struct w1
 			flush_signals(current);
 	}
 
+	memset(&msg, 0, sizeof(msg));
 	msg.id.mst.id = dev->id;
-	msg.id.mst.pid = pid;
 	msg.type = W1_MASTER_REMOVE;
 	w1_netlink_send(dev, &msg);
 
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index f7f7e8b..a6eb9db 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -26,7 +26,6 @@ #include <linux/moduleparam.h>
 
 #include "w1.h"
 #include "w1_log.h"
-#include "w1_io.h"
 
 static int w1_delay_parm = 1;
 module_param_named(delay_coef, w1_delay_parm, int, 0);
@@ -268,13 +267,13 @@ u8 w1_calc_crc8(u8 * data, int len)
 	return crc;
 }
 
-void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb)
+void w1_search_devices(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb)
 {
 	dev->attempts++;
 	if (dev->bus_master->search)
-		dev->bus_master->search(dev->bus_master->data, cb);
+		dev->bus_master->search(dev->bus_master->data, search_type, cb);
 	else
-		w1_search(dev, cb);
+		w1_search(dev, search_type, cb);
 }
 
 /**
@@ -300,13 +299,4 @@ int w1_reset_select_slave(struct w1_slav
 	return 0;
 }
 
-EXPORT_SYMBOL(w1_touch_bit);
-EXPORT_SYMBOL(w1_write_8);
-EXPORT_SYMBOL(w1_read_8);
-EXPORT_SYMBOL(w1_reset_bus);
-EXPORT_SYMBOL(w1_calc_crc8);
-EXPORT_SYMBOL(w1_delay);
-EXPORT_SYMBOL(w1_read_block);
-EXPORT_SYMBOL(w1_write_block);
-EXPORT_SYMBOL(w1_search_devices);
-EXPORT_SYMBOL(w1_reset_select_slave);
+EXPORT_SYMBOL_GPL(w1_calc_crc8);
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index 328645d..d48f3ac 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -21,6 +21,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <linux/connector.h>
 
 #include "w1.h"
 #include "w1_log.h"
@@ -29,50 +30,204 @@ #include "w1_netlink.h"
 #ifndef NETLINK_DISABLED
 void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
 {
-	unsigned int size;
-	struct sk_buff *skb;
-	struct w1_netlink_msg *data;
-	struct nlmsghdr *nlh;
+	char buf[sizeof(struct cn_msg) + sizeof(struct w1_netlink_msg)];
+	struct cn_msg *m = (struct cn_msg *)buf;
+	struct w1_netlink_msg *w = (struct w1_netlink_msg *)(m+1);
 
-	if (!dev->nls)
-		return;
+	memset(buf, 0, sizeof(buf));
 
-	size = NLMSG_SPACE(sizeof(struct w1_netlink_msg));
+	m->id.idx = CN_W1_IDX;
+	m->id.val = CN_W1_VAL;
 
-	skb = alloc_skb(size, GFP_ATOMIC);
-	if (!skb) {
-		dev_err(&dev->dev, "skb_alloc() failed.\n");
-		return;
-	}
+	m->seq = dev->seq++;
+	m->len = sizeof(struct w1_netlink_msg);
 
-	nlh = NLMSG_PUT(skb, 0, dev->seq++, NLMSG_DONE, size - sizeof(*nlh));
+	memcpy(w, msg, sizeof(struct w1_netlink_msg));
 
-	data = (struct w1_netlink_msg *)NLMSG_DATA(nlh);
+	cn_netlink_send(m, 0, GFP_KERNEL);
+}
 
-	memcpy(data, msg, sizeof(struct w1_netlink_msg));
+static int w1_process_command_master(struct w1_master *dev, struct cn_msg *msg,
+		struct w1_netlink_msg *hdr, struct w1_netlink_cmd *cmd)
+{
+	dev_dbg(&dev->dev, "%s: %s: cmd=%02x, len=%u.\n",
+		__func__, dev->name, cmd->cmd, cmd->len);
 
-	NETLINK_CB(skb).dst_group = dev->groups;
-	netlink_broadcast(dev->nls, skb, 0, dev->groups, GFP_ATOMIC);
+	if (cmd->cmd != W1_CMD_SEARCH && cmd->cmd != W1_CMD_ALARM_SEARCH)
+		return -EINVAL;
 
-nlmsg_failure:
-	return;
+	w1_search_process(dev, (cmd->cmd == W1_CMD_ALARM_SEARCH)?W1_ALARM_SEARCH:W1_SEARCH);
+	return 0;
 }
 
-int dev_init_netlink(struct w1_master *dev)
+static int w1_send_read_reply(struct w1_slave *sl, struct cn_msg *msg,
+		struct w1_netlink_msg *hdr, struct w1_netlink_cmd *cmd)
 {
-	dev->nls = netlink_kernel_create(NETLINK_W1, 1, NULL, THIS_MODULE);
-	if (!dev->nls) {
-		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %s.\n",
-			NETLINK_W1, dev->dev.bus_id);
+	void *data;
+	struct w1_netlink_msg *h;
+	struct w1_netlink_cmd *c;
+	struct cn_msg *cm;
+	int err;
+
+	data = kzalloc(sizeof(struct cn_msg) +
+			sizeof(struct w1_netlink_msg) +
+			sizeof(struct w1_netlink_cmd) +
+			cmd->len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	cm = (struct cn_msg *)(data);
+	h = (struct w1_netlink_msg *)(cm + 1);
+	c = (struct w1_netlink_cmd *)(h + 1);
+
+	memcpy(cm, msg, sizeof(struct cn_msg));
+	memcpy(h, hdr, sizeof(struct w1_netlink_msg));
+	memcpy(c, cmd, sizeof(struct w1_netlink_cmd));
+
+	cm->ack = msg->seq+1;
+	cm->len = sizeof(struct w1_netlink_msg) + sizeof(struct w1_netlink_cmd) + cmd->len;
+
+	h->len = sizeof(struct w1_netlink_cmd) + cmd->len;
+
+	memcpy(c->data, cmd->data, c->len);
+
+	err = cn_netlink_send(cm, 0, GFP_KERNEL);
+
+	kfree(data);
+
+	return err;
+}
+
+static int w1_process_command_slave(struct w1_slave *sl, struct cn_msg *msg,
+		struct w1_netlink_msg *hdr, struct w1_netlink_cmd *cmd)
+{
+	int err = 0;
+
+	dev_dbg(&sl->master->dev, "%s: %02x.%012llx.%02x: cmd=%02x, len=%u.\n",
+		__func__, sl->reg_num.family, (unsigned long long)sl->reg_num.id, sl->reg_num.crc,
+		cmd->cmd, cmd->len);
+
+	switch (cmd->cmd) {
+		case W1_CMD_READ:
+			w1_read_block(sl->master, cmd->data, cmd->len);
+			w1_send_read_reply(sl, msg, hdr, cmd);
+			break;
+		case W1_CMD_WRITE:
+			w1_write_block(sl->master, cmd->data, cmd->len);
+			break;
+		case W1_CMD_SEARCH:
+		case W1_CMD_ALARM_SEARCH:
+			w1_search_process(sl->master,
+					(cmd->cmd == W1_CMD_ALARM_SEARCH)?W1_ALARM_SEARCH:W1_SEARCH);
+			break;
+		default:
+			err = -1;
+			break;
 	}
 
-	return 0;
+	return err;
+}
+
+static void w1_cn_callback(void *data)
+{
+	struct cn_msg *msg = data;
+	struct w1_netlink_msg *m = (struct w1_netlink_msg *)(msg + 1);
+	struct w1_netlink_cmd *cmd;
+	struct w1_slave *sl;
+	struct w1_master *dev;
+	int err = 0;
+
+	while (msg->len && !err) {
+		struct w1_reg_num id;
+		u16 mlen = m->len;
+		u8 *cmd_data = m->data;
+
+		dev = NULL;
+		sl = NULL;
+
+		memcpy(&id, m->id.id, sizeof(id));
+#if 0
+		printk("%s: %02x.%012llx.%02x: type=%02x, len=%u.\n",
+				__func__, id.family, (unsigned long long)id.id, id.crc, m->type, m->len);
+#endif
+		if (m->len + sizeof(struct w1_netlink_msg) > msg->len) {
+			err = -E2BIG;
+			break;
+		}
+
+		if (!mlen)
+			goto out_cont;
+
+		if (m->type == W1_MASTER_CMD) {
+			dev = w1_search_master_id(m->id.mst.id);
+		} else if (m->type == W1_SLAVE_CMD) {
+			sl = w1_search_slave(&id);
+			if (sl)
+				dev = sl->master;
+		}
+
+		if (!dev) {
+			err = -ENODEV;
+			goto out_cont;
+		}
+
+		down(&dev->mutex);
+
+		if (sl && w1_reset_select_slave(sl)) {
+			err = -ENODEV;
+			goto out_up;
+		}
+
+		while (mlen) {
+			cmd = (struct w1_netlink_cmd *)cmd_data;
+
+			if (cmd->len + sizeof(struct w1_netlink_cmd) > mlen) {
+				err = -E2BIG;
+				break;
+			}
+
+			if (sl)
+				w1_process_command_slave(sl, msg, m, cmd);
+			else
+				w1_process_command_master(dev, msg, m, cmd);
+
+			cmd_data += cmd->len + sizeof(struct w1_netlink_cmd);
+			mlen -= cmd->len + sizeof(struct w1_netlink_cmd);
+		}
+out_up:
+		atomic_dec(&dev->refcnt);
+		if (sl)
+			atomic_dec(&sl->refcnt);
+		up(&dev->mutex);
+out_cont:
+		msg->len -= sizeof(struct w1_netlink_msg) + m->len;
+		m = (struct w1_netlink_msg *)(((u8 *)m) + sizeof(struct w1_netlink_msg) + m->len);
+
+		/*
+		 * Let's allow requests for nonexisting devices.
+		 */
+		if (err == -ENODEV)
+			err = 0;
+	}
+#if 0
+	if (err) {
+		printk("%s: malformed message. Dropping.\n", __func__);
+	}
+#endif
 }
 
-void dev_fini_netlink(struct w1_master *dev)
+int w1_init_netlink(void)
 {
-	if (dev->nls && dev->nls->sk_socket)
-		sock_release(dev->nls->sk_socket);
+	struct cb_id w1_id = {.idx = CN_W1_IDX, .val = CN_W1_VAL};
+
+	return cn_add_callback(&w1_id, "w1", &w1_cn_callback);
+}
+
+void w1_fini_netlink(void)
+{
+	struct cb_id w1_id = {.idx = CN_W1_IDX, .val = CN_W1_VAL};
+
+	cn_del_callback(&w1_id);
 }
 #else
 #warning Netlink support is disabled. Please compile with NET support enabled.
@@ -81,12 +236,12 @@ void w1_netlink_send(struct w1_master *d
 {
 }
 
-int dev_init_netlink(struct w1_master *dev)
+int w1_init_netlink(void)
 {
 	return 0;
 }
 
-void dev_fini_netlink(struct w1_master *dev)
+void w1_fini_netlink(void)
 {
 }
 #endif
diff --git a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
index eb0c8b3..5644221 100644
--- a/drivers/w1/w1_netlink.h
+++ b/drivers/w1/w1_netlink.h
@@ -23,37 +23,55 @@ #ifndef __W1_NETLINK_H
 #define __W1_NETLINK_H
 
 #include <asm/types.h>
+#include <linux/connector.h>
 
 #include "w1.h"
 
+#define CN_W1_IDX	3
+#define CN_W1_VAL	1
+
 enum w1_netlink_message_types {
 	W1_SLAVE_ADD = 0,
 	W1_SLAVE_REMOVE,
 	W1_MASTER_ADD,
 	W1_MASTER_REMOVE,
+	W1_MASTER_CMD,
+	W1_SLAVE_CMD,
 };
 
 struct w1_netlink_msg
 {
 	__u8				type;
-	__u8				reserved[3];
-	union
-	{
-		struct w1_reg_num	id;
-		__u64			w1_id;
-		struct
-		{
+	__u8				reserved;
+	__u16				len;
+	union {
+		__u8			id[8];
+		struct w1_mst {
 			__u32		id;
-			__u32		pid;
+			__u32		res;
 		} mst;
 	} id;
+	__u8				data[0];
+};
+
+#define W1_CMD_READ		0x0
+#define W1_CMD_WRITE		0x1
+#define W1_CMD_SEARCH		0x2
+#define W1_CMD_ALARM_SEARCH	0x3
+
+struct w1_netlink_cmd
+{
+	__u8				cmd;
+	__u8				res;
+	__u16				len;
+	__u8				data[0];
 };
 
 #ifdef __KERNEL__
 
 void w1_netlink_send(struct w1_master *, struct w1_netlink_msg *);
-int dev_init_netlink(struct w1_master *dev);
-void dev_fini_netlink(struct w1_master *dev);
+int w1_init_netlink(void);
+void w1_fini_netlink(void);
 
 #endif /* __KERNEL__ */
 #endif /* __W1_NETLINK_H */
-- 
1.4.0

