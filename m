Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWINHMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWINHMg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWINHMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:12:36 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:15227 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751381AbWINHMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:12:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TkVj8HsAfSdxoIQFzV7S2CraxFIsWgZkZ/xrQhhJI5DXAfHnb4ReSuzTPOV96HuyXnhs9WlgDCL/PzRW8L0W+B+ogGnClvKRX73nJIwhrSAFV992KEBIXBSJHwzcGDzplRDR/t/A+RFhki9hHxc/FlhAlZ4Ro9miMiS1g97IJ8I=
Message-ID: <450900FF.7000603@gmail.com>
Date: Thu, 14 Sep 2006 01:13:03 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jim Cromie <jim.cromie@gmail.com>
CC: Sergey Vlasov <vsu@altlinux.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Samuel Tardieu <sam@rfc1149.net>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [RFC-patch 1/3] SuperIO locks coordinator
References: <87fyf5jnkj.fsf@willow.rfc1149.net>	<1157815525.6877.43.camel@localhost.localdomain> <20060909220256.d4486a4f.vsu@altlinux.ru> <4508FF2F.5020504@gmail.com>
In-Reply-To: <4508FF2F.5020504@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1/3   adds superio_locks, into newly created drivers/isa
>    Its a bit chatty, which I presume is ok for now..
>    the number of reservations is settable via modparam: max_locks
>
signoff later..


diff -ruNp -X dontdiff -X exclude-diffs 6locks-1/drivers/isa/Kconfig 6locks-2/drivers/isa/Kconfig
--- 6locks-1/drivers/isa/Kconfig	1969-12-31 17:00:00.000000000 -0700
+++ 6locks-2/drivers/isa/Kconfig	2006-09-13 09:54:18.000000000 -0600
@@ -0,0 +1,7 @@
+
+config SUPERIO_LOCKS
+	tristate "Super-IO port sharing"
+	help
+	  this module provides locks for use by drivers which need to
+	  share access to a multi-function device via its superio port, 
+	  and which register that port.
diff -ruNp -X dontdiff -X exclude-diffs 6locks-1/drivers/isa/Makefile 6locks-2/drivers/isa/Makefile
--- 6locks-1/drivers/isa/Makefile	1969-12-31 17:00:00.000000000 -0700
+++ 6locks-2/drivers/isa/Makefile	2006-09-13 09:54:18.000000000 -0600
@@ -0,0 +1 @@
+obj-$(CONFIG_SUPERIO_LOCKS)	+= superio_locks.o
diff -ruNp -X dontdiff -X exclude-diffs 6locks-1/drivers/isa/superio_locks.c 6locks-2/drivers/isa/superio_locks.c
--- 6locks-1/drivers/isa/superio_locks.c	1969-12-31 17:00:00.000000000 -0700
+++ 6locks-2/drivers/isa/superio_locks.c	2006-09-13 14:56:32.000000000 -0600
@@ -0,0 +1,169 @@
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <asm/io.h>
+#include <linux/superio-locks.h>
+
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/i2c-isa.h>
+#include <linux/err.h>
+
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com");
+MODULE_LICENSE("GPL");
+
+/**
+   module provides a means for modules to register their use of a
+   Super-IO port, and provides an access-lock for the registering
+   modules to use to coordinate with each other.  Consider it a
+   parking-attendant's key-board.  Design is perhaps ISA centric,
+   maybe formalize this, with (platform|isa)_driver.
+*/
+
+static int max_locks = 3;	/* 1 is enough for 90% uses */
+module_param(max_locks, int, 0);
+MODULE_PARM_DESC(max_locks,
+		 " Number of sio-lock clients to serve (default=3)");
+
+static struct superio *sio_locks;
+static int num_locks;
+static struct mutex reservation_lock;
+
+
+/* TB-Replaced by something better: platform_driver ? */
+#define dprintk(...)	printk(KERN_NOTICE "superio: " __VA_ARGS__)
+
+/* superio_get() checks whether the expected SuperIO device is
+   present at a specific cmd-addr.  Use in loop to scan.
+*/
+
+struct superio* superio_get(u16 cmd_addr, u8 dev_id_addr,
+			    u8 want_devid)
+{
+	int slot, rc, mydevid;
+
+	mutex_lock(&reservation_lock);
+
+	/* share any already allocated lock for this cmd_addr, device-id */
+	for (slot = 0; slot < max_locks; slot++) {
+		if (sio_locks[slot].users 
+		    && cmd_addr == sio_locks[slot].sioaddr
+		    && want_devid == sio_locks[slot].devid) {
+
+			if (sio_locks[slot].users == 255) {
+				dprintk("too many drivers sharing port %x\n", cmd_addr);
+				mutex_unlock(&reservation_lock);
+				return 0;
+			}
+			sio_locks[slot].users++;
+			dprintk("sharing port:%x dev:%x users:%d\n",
+				cmd_addr, want_devid, sio_locks[slot].users);
+			mutex_unlock(&reservation_lock);
+			return &sio_locks[slot];
+		}
+	}
+	/* read the device-id-address */
+	outb(dev_id_addr, cmd_addr);
+	mydevid = inb(cmd_addr+1);
+
+	/* but 1st, check that the cmd register remembers the val just written */
+	rc = inb(cmd_addr);
+	if (rc != dev_id_addr) {
+		dprintk("superio_cmdaddr %x absent %d\n", cmd_addr, rc);
+		mutex_unlock(&reservation_lock);
+		return NULL;
+	}
+	/* test for the desired device id value */
+	if (mydevid != want_devid) {
+		mutex_unlock(&reservation_lock);
+		return NULL;
+	}
+	/* find 1st unused slot */
+	for (slot = 0; slot < max_locks; slot++)
+		if (!sio_locks[slot].users)
+			break;
+
+	if (slot >= max_locks) {
+		printk(KERN_ERR "No superio-locks left. increase max_locks\n");
+		mutex_unlock(&reservation_lock);
+		return NULL;
+	}
+	dprintk("allocating slot %d, addr %x for device %x\n",
+		slot, cmd_addr, want_devid);
+
+	sio_locks[slot].sioaddr = cmd_addr;
+	sio_locks[slot].devid = want_devid;
+	sio_locks[slot].users = 1;
+	num_locks++;
+
+	mutex_unlock(&reservation_lock);
+	return &sio_locks[slot];
+}
+EXPORT_SYMBOL_GPL(superio_get);
+
+/* array args must be null terminated */
+struct superio* superio_find(u16 cmd_addrs[], u8 devid_addr,
+			     u8 want_devids[])
+{
+	int i, j;
+	struct superio* gate;
+
+	for (i = 0; cmd_addrs[i]; i++) {
+		for (j = 0; want_devids[j]; j++) {
+			gate = superio_get(cmd_addrs[i], devid_addr,
+					   want_devids[j]);
+			if (gate) {
+				dprintk("found devid:%x port:%x\n",
+					want_devids[j], cmd_addrs[i]);
+				return gate;
+			} else
+				dprintk("no devid:%x at port:%x\n",
+					want_devids[j], cmd_addrs[i]);
+		}
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(superio_find);
+
+void superio_release(struct superio* const gate)
+{
+	if (gate < &sio_locks[0] || gate >= &sio_locks[max_locks]) {
+		printk(KERN_ERR
+		       " superio: attempt to release corrupted superio-lock"
+		       " %p vs %p\n", gate, &sio_locks);
+		return;
+	}
+	if (!(--gate->users))
+		dprintk("releasing last user of superio-port %x\n", gate->sioaddr);
+	return;
+}
+EXPORT_SYMBOL_GPL(superio_release);
+
+static int superio_locks_init_module(void)
+{
+	int i;
+
+	dprintk("initializing with %d reservation slots\n", max_locks);
+	sio_locks = kzalloc(max_locks*sizeof(struct superio), GFP_KERNEL);
+	if (!sio_locks) {
+		printk(KERN_ERR "superio: no memory\n");
+		return -ENOMEM;
+	}
+	for (i = 0; i < max_locks; i++)
+		mutex_init(&sio_locks[i].lock);
+
+	mutex_init(&reservation_lock);
+	return 0;
+}
+
+static void superio_locks_cleanup_module(void)
+{
+	dprintk("releasing %d superio reservation slots\n", max_locks);
+	kfree(sio_locks);
+}
+
+module_init(superio_locks_init_module);
+module_exit(superio_locks_cleanup_module);
diff -ruNp -X dontdiff -X exclude-diffs 6locks-1/drivers/Kconfig 6locks-2/drivers/Kconfig
--- 6locks-1/drivers/Kconfig	2006-09-07 16:11:30.000000000 -0600
+++ 6locks-2/drivers/Kconfig	2006-09-13 09:54:18.000000000 -0600
@@ -74,4 +74,6 @@ source "drivers/rtc/Kconfig"
 
 source "drivers/dma/Kconfig"
 
+source "drivers/isa/Kconfig"
+
 endmenu
diff -ruNp -X dontdiff -X exclude-diffs 6locks-1/drivers/Makefile 6locks-2/drivers/Makefile
--- 6locks-1/drivers/Makefile	2006-09-07 16:11:30.000000000 -0600
+++ 6locks-2/drivers/Makefile	2006-09-13 09:54:18.000000000 -0600
@@ -76,3 +76,4 @@ obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
 obj-$(CONFIG_DMA_ENGINE)	+= dma/
+obj-$(CONFIG_ISA)		+= isa/
diff -ruNp -X dontdiff -X exclude-diffs 6locks-1/include/linux/superio-locks.h 6locks-2/include/linux/superio-locks.h
--- 6locks-1/include/linux/superio-locks.h	1969-12-31 17:00:00.000000000 -0700
+++ 6locks-2/include/linux/superio-locks.h	2006-09-13 14:21:08.000000000 -0600
@@ -0,0 +1,55 @@
+#include <linux/mutex.h>
+#include <asm/io.h>
+
+/* Super-IO ports are found in low-pin-count hardware (typically ISA,
+   any others ?).  They usually provide access to many functional
+   units, so many drivers must share the superio port.  This struct
+   provides a lock that allows the drivers to coordinate access to that
+   port.
+*/
+struct superio {
+	struct mutex lock;	/* lock shared amongst user drivers */
+	u16 sioaddr;		/* port's tested cmd-address */
+	u8 devid;		/* devid found by the registering driver */
+	u8 users;		/* I cant imagine >256 user drivers */
+};
+
+/* array args must be null terminated */
+struct superio* superio_find(u16 sioaddrs[], u8 devid_addr, u8 devid_vals[]);
+struct superio* superio_get(u16 sioaddr, u8 devid_addr, u8 devid_val);
+void superio_release(struct superio* const gate);
+
+/* these locking ops do not address the idling & activation of some
+   superio devices, which will, once 'locked', ignore accesses until
+   the 'unlock' sequence is done 1st.  Unfortunately these sequences
+   vary by device, and in any case don't protect 2 drivers from
+   stepping on each other's operations.
+
+   Callbacks are a possible approach, but every driver using a device
+   would have to provide them, and only the 1st loaded module would
+   actually succeed in registering them.  Furthermore, if any driver
+   accessing a port uses the idle/activate sequences, they all must.
+   On the whole, this is complexity w/o benefit.
+*/
+static inline void superio_enter(struct superio * const sio_port)
+{
+	mutex_lock(&sio_port->lock);
+}
+
+static inline void superio_exit(struct superio * const sio_port)
+{
+	mutex_unlock(&sio_port->lock);
+}
+
+static inline void superio_outb(struct superio * const sio_port, u8 reg, u8 val)
+{
+	outb(reg, sio_port->sioaddr);
+	outb(val, sio_port->sioaddr+1);
+}
+
+static inline int superio_inb(struct superio * const sio_port, u8 reg)
+{
+	outb(reg, sio_port->sioaddr);
+	return inb(sio_port->sioaddr+1);
+}
+


