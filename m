Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267816AbUHJXcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267816AbUHJXcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267821AbUHJXcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:32:25 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:25083 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267816AbUHJXbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:31:01 -0400
Message-ID: <41195AB1.8090902@acm.org>
Date: Tue, 10 Aug 2004 18:30:57 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: IPMI driver updates
Content-Type: multipart/mixed;
 boundary="------------040708040209070900040400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708040209070900040400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Some people found some bugs and some missing functions in the
IPMI driver, so I have patching things together for the next release.
The attached patch moves to version 33 of the driver and contains:

* SMBIOS table support for specifying register spacing.  This allows
  non-contiguous registers to be specified and some machines do
  this.
* ACPI table updates to support all the possible register sizes and
  bit offsets into the registers for the IPMI information.
* Support for command line parameters to specify register
  spacing, sizes, and bit offsets.
* Support for power control with IPMI.  This allows a halt to
  power down a machine with IPMI.
* A fix for a race condition with interrupts enabled on an
  SMP machine.  A lock was released then reclaimed, but
  there was code later that assumed that had not happened.
* A fix for protecting the driver against bad responses from
  the controller chip.  In the past, the driver had assumed that
  the controller chip would not give it bad data.  This has
  turned out to be a bad assumption
* ACPI interrupt handlers now return a return value, adjust
  accordingly.

This patch is relative to 2.5.8-rc4-mm1.

Thank you to all the people who helped me with this.

Signed-off-by: Corey Minyard <minyard@acm.org>



--------------040708040209070900040400
Content-Type: text/plain;
 name="ipmi-base.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-base.diff"

Index: linux-2.6.8-rc4-mm1/Documentation/IPMI.txt
===================================================================
--- linux-2.6.8-rc4-mm1.orig/Documentation/IPMI.txt	2004-08-10 18:00:33.000000000 -0500
+++ linux-2.6.8-rc4-mm1/Documentation/IPMI.txt	2004-08-10 18:06:43.000000000 -0500
@@ -340,6 +340,8 @@
   modprobe ipmi_si.o type=<type1>,<type2>....
        ports=<port1>,<port2>... addrs=<addr1>,<addr2>...
        irqs=<irq1>,<irq2>... trydefaults=[0|1]
+       regspacings=<sp1>,<sp2>,... regsizes=<size1>,<size2>,...
+       regshifts=<shift1>,<shift2>,...
 
 Each of these except si_trydefaults is a list, the first item for the
 first interface, second item for the second interface, etc.
@@ -361,12 +363,35 @@
 any interfaces specified by ACPE are tried.  By default, the driver
 tries it, set this value to zero to turn this off.
 
+The next three parameters have to do with register layout.  The
+registers used by the interfaces may not appear at successive
+locations and they may not be in 8-bit registers.  These parameters
+allow the layout of the data in the registers to be more precisely
+specified.
+
+The regspacings parameter give the number of bytes between successive
+register start addresses.  For instance, if the regspacing is set to 4
+and the start address is 0xca2, then the address for the second
+register would be 0xca6.  This defaults to 1.
+
+The regsizes parameter gives the size of a register, in bytes.  The
+data used by IPMI is 8-bits wide, but it may be inside a larger
+register.  This parameter allows the read and write type to specified.
+It may be 1, 2, 4, or 8.  The default is 1.
+
+Since the register size may be larger than 32 bits, the IPMI data may not
+be in the lower 8 bits.  The regshifts parameter give the amount to shift
+the data to get to the actual IPMI data.
+
 When compiled into the kernel, the addresses can be specified on the
 kernel command line as:
 
   ipmi_si.type=<type1>,<type2>...
        ipmi_si.ports=<port1>,<port2>... ipmi_si.addrs=<addr1>,<addr2>...
        ipmi_si.irqs=<irq1>,<irq2>... ipmi_si.trydefaults=[0|1]
+       ipmi_si.regspacings=<sp1>,<sp2>,...
+       ipmi_si.regsizes=<size1>,<size2>,...
+       ipmi_si.regshifts=<shift1>,<shift2>,...
 
 It works the same as the module parameters of the same names.
 
Index: linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_bt_sm.c
===================================================================
--- linux-2.6.8-rc4-mm1.orig/drivers/char/ipmi/ipmi_bt_sm.c	2004-08-10 18:00:54.000000000 -0500
+++ linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_bt_sm.c	2004-08-10 18:06:18.000000000 -0500
@@ -31,7 +31,7 @@
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
-#define IPMI_BT_VERSION "v32"
+#define IPMI_BT_VERSION "v33"
 
 static int bt_debug = 0x00;	/* Production value 0, see following flags */
 
Index: linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.8-rc4-mm1.orig/drivers/char/ipmi/ipmi_devintf.c	2004-08-10 18:00:54.000000000 -0500
+++ linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_devintf.c	2004-08-10 18:06:18.000000000 -0500
@@ -45,7 +45,7 @@
 #include <asm/semaphore.h>
 #include <linux/init.h>
 
-#define IPMI_DEVINTF_VERSION "v32"
+#define IPMI_DEVINTF_VERSION "v33"
 
 struct ipmi_file_private
 {
Index: linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_kcs_sm.c
===================================================================
--- linux-2.6.8-rc4-mm1.orig/drivers/char/ipmi/ipmi_kcs_sm.c	2004-08-10 18:00:54.000000000 -0500
+++ linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_kcs_sm.c	2004-08-10 18:06:18.000000000 -0500
@@ -42,7 +42,7 @@
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
-#define IPMI_KCS_VERSION "v32"
+#define IPMI_KCS_VERSION "v33"
 
 /* Set this if you want a printout of why the state machine was hosed
    when it gets hosed. */
Index: linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.8-rc4-mm1.orig/drivers/char/ipmi/ipmi_msghandler.c	2004-08-10 18:00:54.000000000 -0500
+++ linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_msghandler.c	2004-08-10 18:06:46.000000000 -0500
@@ -46,7 +46,8 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 
-#define IPMI_MSGHANDLER_VERSION "v32"
+#define PFX "IPMI message handler: "
+#define IPMI_MSGHANDLER_VERSION "v33"
 
 struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 static int ipmi_init_msghandler(void);
@@ -895,6 +896,12 @@
 	return rv;
 }
 
+void ipmi_user_set_run_to_completion(ipmi_user_t user, int val)
+{
+	user->intf->handlers->set_run_to_completion(user->intf->send_info,
+						    val);
+}
+
 static unsigned char
 ipmb_checksum(unsigned char *data, int size)
 {
@@ -1686,8 +1693,8 @@
 			intf->curr_channel = IPMI_MAX_CHANNELS;
 			wake_up(&intf->waitq);
 
-			printk(KERN_WARNING "ipmi_msghandler: Error sending"
-			       "channel information: %d\n",
+			printk(KERN_WARNING PFX
+			       "Error sending channel information: %d\n",
 			       rv);
 		}
 	}
@@ -2351,7 +2358,7 @@
 	} else {
 		/* There's too many things in the queue, discard this
 		   message. */
-		printk(KERN_WARNING "ipmi: Event queue full, discarding an"
+		printk(KERN_WARNING PFX "Event queue full, discarding an"
 		       " incoming event\n");
 	}
 
@@ -2433,10 +2440,34 @@
 #endif
 	if (msg->rsp_size < 2) {
 		/* Message is too small to be correct. */
-		requeue = 0;
-	} else if ((msg->rsp[0] == ((IPMI_NETFN_APP_REQUEST|1) << 2))
-		   && (msg->rsp[1] == IPMI_SEND_MSG_CMD)
-		   && (msg->user_data != NULL))
+		printk(KERN_WARNING PFX "BMC returned to small a message"
+		       " for netfn %x cmd %x, got %d bytes\n",
+		       (msg->data[0] >> 2) | 1, msg->data[1], msg->rsp_size);
+
+		/* Generate an error response for the message. */
+		msg->rsp[0] = msg->data[0] | (1 << 2);
+		msg->rsp[1] = msg->data[1];
+		msg->rsp[2] = IPMI_ERR_UNSPECIFIED;
+		msg->rsp_size = 3;
+	} else if (((msg->rsp[0] >> 2) != ((msg->data[0] >> 2) | 1))/* Netfn */
+		   || (msg->rsp[1] != msg->data[1]))		  /* Command */
+	{
+		/* The response is not even marginally correct. */
+		printk(KERN_WARNING PFX "BMC returned incorrect response,"
+		       " expected netfn %x cmd %x, got netfn %x cmd %x\n",
+		       (msg->data[0] >> 2) | 1, msg->data[1],
+		       msg->rsp[0] >> 2, msg->rsp[1]);
+
+		/* Generate an error response for the message. */
+		msg->rsp[0] = msg->data[0] | (1 << 2);
+		msg->rsp[1] = msg->data[1];
+		msg->rsp[2] = IPMI_ERR_UNSPECIFIED;
+		msg->rsp_size = 3;
+	}
+
+	if ((msg->rsp[0] == ((IPMI_NETFN_APP_REQUEST|1) << 2))
+	    && (msg->rsp[1] == IPMI_SEND_MSG_CMD)
+	    && (msg->user_data != NULL))
 	{
 		/* It's a response to a response we sent.  For this we
 		   deliver a send message response to the user. */
@@ -2502,7 +2533,9 @@
 			requeue = 0;
 		}
 
-	} else if (msg->rsp[1] == IPMI_READ_EVENT_MSG_BUFFER_CMD) {
+	} else if ((msg->rsp[0] == ((IPMI_NETFN_APP_REQUEST|1) << 2))
+		   && (msg->rsp[1] == IPMI_READ_EVENT_MSG_BUFFER_CMD))
+	{
 		/* It's an asyncronous event. */
 		requeue = handle_read_event_rsp(intf, msg);
 	} else {
@@ -3114,7 +3147,7 @@
 
 	proc_ipmi_root = proc_mkdir("ipmi", NULL);
 	if (!proc_ipmi_root) {
-	    printk("Unable to create IPMI proc dir");
+	    printk(KERN_ERR PFX "Unable to create IPMI proc dir");
 	    return -ENOMEM;
 	}
 
@@ -3166,11 +3199,11 @@
 	/* Check for buffer leaks. */
 	count = atomic_read(&smi_msg_inuse_count);
 	if (count != 0)
-		printk("ipmi_msghandler: SMI message count %d at exit\n",
+		printk(KERN_WARNING PFX "SMI message count %d at exit\n",
 		       count);
 	count = atomic_read(&recv_msg_inuse_count);
 	if (count != 0)
-		printk("ipmi_msghandler: recv message count %d at exit\n",
+		printk(KERN_WARNING PFX "recv message count %d at exit\n",
 		       count);
 }
 module_exit(cleanup_ipmi);
@@ -3207,3 +3240,4 @@
 EXPORT_SYMBOL(ipmi_set_my_LUN);
 EXPORT_SYMBOL(ipmi_get_my_LUN);
 EXPORT_SYMBOL(ipmi_smi_add_proc_entry);
+EXPORT_SYMBOL(ipmi_user_set_run_to_completion);
Index: linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.8-rc4-mm1.orig/drivers/char/ipmi/ipmi_poweroff.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_poweroff.c	2004-08-10 18:06:46.000000000 -0500
@@ -0,0 +1,543 @@
+/*
+ * ipmi_poweroff.c
+ *
+ * MontaVista IPMI Poweroff extension to sys_reboot
+ *
+ * Author: MontaVista Software, Inc.
+ *         Steven Dake <sdake@mvista.com>
+ *         Corey Minyard <cminyard@mvista.com>
+ *         source@mvista.com
+ *
+ * Copyright 2002,2004 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <asm/semaphore.h>
+#include <linux/kdev_t.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/ipmi.h>
+#include <linux/ipmi_smi.h>
+
+#define PFX "IPMI poweroff: "
+#define IPMI_POWEROFF_VERSION	"v33"
+
+/* Where to we insert our poweroff function? */
+extern void (*pm_power_off)(void);
+
+/* Stuff from the get device id command. */
+unsigned int mfg_id;
+unsigned int prod_id;
+unsigned char capabilities;
+
+/* We use our own messages for this operation, we don't let the system
+   allocate them, since we may be in a panic situation.  The whole
+   thing is single-threaded, anyway, so multiple messages are not
+   required. */
+static void dummy_smi_free(struct ipmi_smi_msg *msg)
+{
+}
+static void dummy_recv_free(struct ipmi_recv_msg *msg)
+{
+}
+static struct ipmi_smi_msg halt_smi_msg =
+{
+	.done = dummy_smi_free
+};
+static struct ipmi_recv_msg halt_recv_msg =
+{
+	.done = dummy_recv_free
+};
+
+
+/*
+ * Code to send a message and wait for the reponse.
+ */
+
+static void receive_handler(struct ipmi_recv_msg *recv_msg, void *handler_data)
+{
+	struct semaphore *sem = recv_msg->user_msg_data;
+
+	if (sem)
+		up(sem);
+}
+
+static struct ipmi_user_hndl ipmi_poweroff_handler =
+{
+	ipmi_recv_hndl : receive_handler
+};
+
+
+static int ipmi_request_wait_for_response(ipmi_user_t            user,
+					  struct ipmi_addr       *addr,
+					  struct kernel_ipmi_msg *send_msg)
+{
+	int              rv;
+	struct semaphore sem;
+
+	sema_init (&sem, 0);
+
+	rv = ipmi_request_supply_msgs(user, addr, 0, send_msg, &sem,
+				      &halt_smi_msg, &halt_recv_msg, 0);
+	if (rv)
+		return rv;
+
+	down (&sem);
+
+	return halt_recv_msg.msg.data[0];
+}
+
+/* We are in run-to-completion mode, no semaphore is desired. */
+static int ipmi_request_in_rc_mode(ipmi_user_t            user,
+				   struct ipmi_addr       *addr,
+				   struct kernel_ipmi_msg *send_msg)
+{
+	int              rv;
+
+	rv = ipmi_request_supply_msgs(user, addr, 0, send_msg, NULL,
+				      &halt_smi_msg, &halt_recv_msg, 0);
+	if (rv)
+		return rv;
+
+	return halt_recv_msg.msg.data[0];
+}
+
+/*
+ * ATCA Support
+ */
+
+#define IPMI_NETFN_ATCA			0x2c
+#define IPMI_ATCA_SET_POWER_CMD		0x11
+#define IPMI_ATCA_GET_ADDR_INFO_CMD	0x01
+#define IPMI_PICMG_ID			0
+
+static int ipmi_atca_detect (ipmi_user_t user)
+{
+	struct ipmi_system_interface_addr smi_addr;
+	struct kernel_ipmi_msg            send_msg;
+	int                               rv;
+	unsigned char                     data[1];
+
+        /*
+         * Configure IPMI address for local access
+         */
+        smi_addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+        smi_addr.channel = IPMI_BMC_CHANNEL;
+        smi_addr.lun = 0;
+
+	/*
+	 * Use get address info to check and see if we are ATCA
+	 */
+	send_msg.netfn = IPMI_NETFN_ATCA;
+	send_msg.cmd = IPMI_ATCA_GET_ADDR_INFO_CMD;
+	data[0] = IPMI_PICMG_ID;
+	send_msg.data = data;
+	send_msg.data_len = sizeof(data);
+	rv = ipmi_request_wait_for_response(user,
+					    (struct ipmi_addr *) &smi_addr,
+					    &send_msg);
+	return !rv;
+}
+
+static void ipmi_poweroff_atca (ipmi_user_t user)
+{
+	struct ipmi_system_interface_addr smi_addr;
+	struct kernel_ipmi_msg            send_msg;
+	int                               rv;
+	unsigned char                     data[4];
+
+        /*
+         * Configure IPMI address for local access
+         */
+        smi_addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+        smi_addr.channel = IPMI_BMC_CHANNEL;
+        smi_addr.lun = 0;
+
+	printk(KERN_INFO PFX "Powering down via ATCA power command\n");
+
+	/*
+	 * Power down
+	 */
+	send_msg.netfn = IPMI_NETFN_ATCA;
+	send_msg.cmd = IPMI_ATCA_SET_POWER_CMD;
+	data[0] = IPMI_PICMG_ID;
+	data[1] = 0; /* FRU id */
+	data[2] = 0; /* Power Level */
+	data[3] = 0; /* Don't change saved presets */
+	send_msg.data = data;
+	send_msg.data_len = sizeof (data);
+	rv = ipmi_request_in_rc_mode(user,
+				     (struct ipmi_addr *) &smi_addr,
+				     &send_msg);
+	if (rv) {
+		printk(KERN_ERR PFX "Unable to send ATCA powerdown message,"
+		       " IPMI error 0x%x\n", rv);
+		goto out;
+	}
+
+ out:
+	return;
+}
+
+/*
+ * CPI1 Support
+ */
+
+#define IPMI_NETFN_OEM_1				0xf8
+#define OEM_GRP_CMD_SET_RESET_STATE		0x84
+#define OEM_GRP_CMD_SET_POWER_STATE		0x82
+#define IPMI_NETFN_OEM_8				0xf8
+#define OEM_GRP_CMD_REQUEST_HOTSWAP_CTRL	0x80
+#define OEM_GRP_CMD_GET_SLOT_GA			0xa3
+#define IPMI_NETFN_SENSOR_EVT			0x10
+#define IPMI_CMD_GET_EVENT_RECEIVER		0x01
+
+#define IPMI_CPI1_PRODUCT_ID		0x000157
+#define IPMI_CPI1_MANUFACTURER_ID	0x0108
+
+static int ipmi_cpi1_detect (ipmi_user_t user)
+{
+	return ((mfg_id == IPMI_CPI1_MANUFACTURER_ID)
+		&& (prod_id == IPMI_CPI1_PRODUCT_ID));
+}
+
+static void ipmi_poweroff_cpi1 (ipmi_user_t user)
+{
+	struct ipmi_system_interface_addr smi_addr;
+	struct ipmi_ipmb_addr             ipmb_addr;
+	struct kernel_ipmi_msg            send_msg;
+	int                               rv;
+	unsigned char                     data[1];
+	int                               slot;
+	unsigned char                     hotswap_ipmb;
+	unsigned char                     aer_addr;
+	unsigned char                     aer_lun;
+
+        /*
+         * Configure IPMI address for local access
+         */
+        smi_addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+        smi_addr.channel = IPMI_BMC_CHANNEL;
+        smi_addr.lun = 0;
+
+	printk(KERN_INFO PFX "Powering down via CPI1 power command\n");
+
+	/*
+	 * Get IPMI ipmb address
+	 */
+	send_msg.netfn = IPMI_NETFN_OEM_8 >> 2;
+	send_msg.cmd = OEM_GRP_CMD_GET_SLOT_GA;
+	send_msg.data = NULL;
+	send_msg.data_len = 0;
+	rv = ipmi_request_in_rc_mode(user,
+				     (struct ipmi_addr *) &smi_addr,
+				     &send_msg);
+	if (rv)
+		goto out;
+	slot = halt_recv_msg.msg.data[1];
+	hotswap_ipmb = (slot > 9) ? (0xb0 + 2 * slot) : (0xae + 2 * slot);
+
+	/*
+	 * Get active event receiver
+	 */
+	send_msg.netfn = IPMI_NETFN_SENSOR_EVT >> 2;
+	send_msg.cmd = IPMI_CMD_GET_EVENT_RECEIVER;
+	send_msg.data = NULL;
+	send_msg.data_len = 0;
+	rv = ipmi_request_in_rc_mode(user,
+				     (struct ipmi_addr *) &smi_addr,
+				     &send_msg);
+	if (rv)
+		goto out;
+	aer_addr = halt_recv_msg.msg.data[1];
+	aer_lun = halt_recv_msg.msg.data[2];
+
+	/*
+	 * Setup IPMB address target instead of local target
+	 */
+	ipmb_addr.addr_type = IPMI_IPMB_ADDR_TYPE;
+	ipmb_addr.channel = 0;
+	ipmb_addr.slave_addr = aer_addr;
+	ipmb_addr.lun = aer_lun;
+
+	/*
+	 * Send request hotswap control to remove blade from dpv
+	 */
+	send_msg.netfn = IPMI_NETFN_OEM_8 >> 2;
+	send_msg.cmd = OEM_GRP_CMD_REQUEST_HOTSWAP_CTRL;
+	send_msg.data = &hotswap_ipmb;
+	send_msg.data_len = 1;
+	ipmi_request_in_rc_mode(user,
+				(struct ipmi_addr *) &ipmb_addr,
+				&send_msg);
+
+	/*
+	 * Set reset asserted
+	 */
+	send_msg.netfn = IPMI_NETFN_OEM_1 >> 2;
+	send_msg.cmd = OEM_GRP_CMD_SET_RESET_STATE;
+	send_msg.data = data;
+	data[0] = 1; /* Reset asserted state */
+	send_msg.data_len = 1;
+	rv = ipmi_request_in_rc_mode(user,
+				     (struct ipmi_addr *) &smi_addr,
+				     &send_msg);
+	if (rv)
+		goto out;
+
+	/*
+	 * Power down
+	 */
+	send_msg.netfn = IPMI_NETFN_OEM_1 >> 2;
+	send_msg.cmd = OEM_GRP_CMD_SET_POWER_STATE;
+	send_msg.data = data;
+	data[0] = 1; /* Power down state */
+	send_msg.data_len = 1;
+	rv = ipmi_request_in_rc_mode(user,
+				     (struct ipmi_addr *) &smi_addr,
+				     &send_msg);
+	if (rv)
+		goto out;
+
+ out:
+	return;
+}
+
+/*
+ * Standard chassis support
+ */
+
+#define IPMI_NETFN_CHASSIS_REQUEST	0
+#define IPMI_CHASSIS_CONTROL_CMD	0x02
+
+static int ipmi_chassis_detect (ipmi_user_t user)
+{
+	/* Chassis support, use it. */
+	return (capabilities & 0x80);
+}
+
+static void ipmi_poweroff_chassis (ipmi_user_t user)
+{
+	struct ipmi_system_interface_addr smi_addr;
+	struct kernel_ipmi_msg            send_msg;
+	int                               rv;
+	unsigned char                     data[1];
+
+        /*
+         * Configure IPMI address for local access
+         */
+        smi_addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+        smi_addr.channel = IPMI_BMC_CHANNEL;
+        smi_addr.lun = 0;
+
+	printk(KERN_INFO PFX "Powering down via IPMI chassis control command\n");
+
+	/*
+	 * Power down
+	 */
+	send_msg.netfn = IPMI_NETFN_CHASSIS_REQUEST;
+	send_msg.cmd = IPMI_CHASSIS_CONTROL_CMD;
+	data[0] = 0; /* Power down */
+	send_msg.data = data;
+	send_msg.data_len = sizeof(data);
+	rv = ipmi_request_in_rc_mode(user,
+				     (struct ipmi_addr *) &smi_addr,
+				     &send_msg);
+	if (rv) {
+		printk(KERN_ERR PFX "Unable to send chassis powerdown message,"
+		       " IPMI error 0x%x\n", rv);
+		goto out;
+	}
+
+ out:
+	return;
+}
+
+
+/* Table of possible power off functions. */
+struct poweroff_function {
+	char *platform_type;
+	int  (*detect)(ipmi_user_t user);
+	void (*poweroff_func)(ipmi_user_t user);
+};
+
+static struct poweroff_function poweroff_functions[] = {
+	{ "ATCA",    ipmi_atca_detect, ipmi_poweroff_atca },
+	{ "CPI1",    ipmi_cpi1_detect, ipmi_poweroff_cpi1 },
+	/* Chassis should generally be last, other things should override
+	   it. */
+	{ "chassis", ipmi_chassis_detect, ipmi_poweroff_chassis },
+};
+#define NUM_PO_FUNCS (sizeof(poweroff_functions) \
+		      / sizeof(struct poweroff_function))
+
+
+/* Our local state. */
+static int ready = 0;
+static ipmi_user_t ipmi_user;
+static void (*specific_poweroff_func)(ipmi_user_t user) = NULL;
+
+/* Holds the old poweroff function so we can restore it on removal. */
+static void (*old_poweroff_func)(void);
+
+
+/* Called on a powerdown request. */
+static void ipmi_poweroff_function (void)
+{
+	if (!ready)
+		return;
+
+	/* Use run-to-completion mode, since interrupts may be off. */
+	ipmi_user_set_run_to_completion(ipmi_user, 1);
+	specific_poweroff_func(ipmi_user);
+	ipmi_user_set_run_to_completion(ipmi_user, 0);
+}
+
+/* Wait for an IPMI interface to be installed, the first one installed
+   will be grabbed by this code and used to perform the powerdown. */
+static void ipmi_po_new_smi(int if_num)
+{
+	struct ipmi_system_interface_addr smi_addr;
+	struct kernel_ipmi_msg            send_msg;
+	int                               rv;
+	int                               i;
+
+	if (ready)
+		return;
+
+	rv = ipmi_create_user(if_num, &ipmi_poweroff_handler, 0, &ipmi_user);
+	if (rv) {
+		printk(KERN_ERR PFX "could not create IPMI user, error %d\n",
+		       rv);
+		return;
+	}
+
+        /*
+         * Do a get device ide and store some results, since this is
+	 * used by several functions.
+         */
+        smi_addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+        smi_addr.channel = IPMI_BMC_CHANNEL;
+        smi_addr.lun = 0;
+
+	send_msg.netfn = IPMI_NETFN_APP_REQUEST;
+	send_msg.cmd = IPMI_GET_DEVICE_ID_CMD;
+	send_msg.data = NULL;
+	send_msg.data_len = 0;
+	rv = ipmi_request_wait_for_response(ipmi_user,
+					    (struct ipmi_addr *) &smi_addr,
+					    &send_msg);
+	if (rv) {
+		printk(KERN_ERR PFX "Unable to send IPMI get device id info,"
+		       " IPMI error 0x%x\n", rv);
+		goto out_err;
+	}
+
+	if (halt_recv_msg.msg.data_len < 12) {
+		printk(KERN_ERR PFX "(chassis) IPMI get device id info too,"
+		       " short, was %d bytes, needed %d bytes\n",
+		       halt_recv_msg.msg.data_len, 12);
+		goto out_err;
+	}
+
+	mfg_id = (halt_recv_msg.msg.data[7]
+		  | (halt_recv_msg.msg.data[8] << 8)
+		  | (halt_recv_msg.msg.data[9] << 16));
+	prod_id = (halt_recv_msg.msg.data[10]
+		   | (halt_recv_msg.msg.data[11] << 8));
+	capabilities = halt_recv_msg.msg.data[6];
+
+
+	/* Scan for a poweroff method */
+	for (i=0; i<NUM_PO_FUNCS; i++) {
+		if (poweroff_functions[i].detect(ipmi_user))
+			goto found;
+	}
+
+ out_err:
+	printk(KERN_ERR PFX "Unable to find a poweroff function that"
+	       " will work, giving up\n");
+	ipmi_destroy_user(ipmi_user);
+	return;
+
+ found:
+	printk(KERN_INFO PFX "Found a %s style poweroff function\n",
+	       poweroff_functions[i].platform_type);
+	specific_poweroff_func = poweroff_functions[i].poweroff_func;
+	old_poweroff_func = pm_power_off;
+	pm_power_off = ipmi_poweroff_function;
+	ready = 1;
+}
+
+static void ipmi_po_smi_gone(int if_num)
+{
+	/* This can never be called, because once poweroff driver is
+	   registered, the interface can't go away until the power
+	   driver is unregistered. */
+}
+
+static struct ipmi_smi_watcher smi_watcher =
+{
+	.owner    = THIS_MODULE,
+	.new_smi  = ipmi_po_new_smi,
+	.smi_gone = ipmi_po_smi_gone
+};
+
+
+/*
+ * Startup and shutdown functions.
+ */
+static int ipmi_poweroff_init (void)
+{
+	int rv;
+
+	printk ("Copyright (C) 2004 MontaVista Software -"
+		" IPMI Powerdown via sys_reboot version "
+		IPMI_POWEROFF_VERSION ".\n");
+
+	rv = ipmi_smi_watcher_register(&smi_watcher);
+	if (rv)
+		printk(KERN_ERR PFX "Unable to register SMI watcher: %d\n", rv);
+
+	return rv;
+}
+
+#ifdef MODULE
+static __exit void ipmi_poweroff_cleanup(void)
+{
+	int rv;
+
+	ipmi_smi_watcher_unregister(&smi_watcher);
+
+	if (ready) {
+		rv = ipmi_destroy_user(ipmi_user);
+		if (rv)
+			printk(KERN_ERR PFX "could not cleanup the IPMI"
+			       " user: 0x%x\n", rv);
+		pm_power_off = old_poweroff_func;
+	}
+}
+module_exit(ipmi_poweroff_cleanup);
+#endif
+
+module_init(ipmi_poweroff_init);
+MODULE_LICENSE("GPL");
Index: linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.8-rc4-mm1.orig/drivers/char/ipmi/ipmi_si_intf.c	2004-08-10 18:00:54.000000000 -0500
+++ linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_si_intf.c	2004-08-10 18:06:43.000000000 -0500
@@ -76,7 +76,7 @@
 #include "ipmi_si_sm.h"
 #include <linux/init.h>
 
-#define IPMI_SI_VERSION "v32"
+#define IPMI_SI_VERSION "v33"
 
 /* Measure times between events in the driver. */
 #undef DEBUG_TIMING
@@ -146,6 +146,11 @@
 	/* The I/O port of an SI interface. */
 	int                 port;
 
+	/* The space between start addresses of the two ports.  For
+	   instance, if the first port is 0xca2 and the spacing is 4, then
+	   the second port is 0xca6. */
+	unsigned int        spacing;
+
 	/* zero if no irq; */
 	int                 irq;
 
@@ -452,14 +457,20 @@
 
 			/* Take off the event flag. */
 			smi_info->msg_flags &= ~EVENT_MSG_BUFFER_FULL;
+			handle_flags(smi_info);
 		} else {
 			spin_lock(&smi_info->count_lock);
 			smi_info->events++;
 			spin_unlock(&smi_info->count_lock);
 
+			/* Do this before we deliver the message
+			   because delivering the message releases the
+			   lock and something else can mess with the
+			   state. */
+			handle_flags(smi_info);
+
 			deliver_recv_msg(smi_info, msg);
 		}
-		handle_flags(smi_info);
 		break;
 	}
 
@@ -482,14 +493,20 @@
 
 			/* Take off the msg flag. */
 			smi_info->msg_flags &= ~RECEIVE_MSG_AVAIL;
+			handle_flags(smi_info);
 		} else {
 			spin_lock(&smi_info->count_lock);
 			smi_info->incoming_messages++;
 			spin_unlock(&smi_info->count_lock);
 
+			/* Do this before we deliver the message
+			   because delivering the message releases the
+			   lock and something else can mess with the
+			   state. */
+			handle_flags(smi_info);
+
 			deliver_recv_msg(smi_info, msg);
 		}
-		handle_flags(smi_info);
 		break;
 	}
 
@@ -568,6 +585,9 @@
 		smi_info->hosed_count++;
 		spin_unlock(&smi_info->count_lock);
 
+		/* Do the before return_hosed_msg, because that
+		   releases the lock. */
+		smi_info->si_state = SI_NORMAL;
 		if (smi_info->curr_msg != NULL) {
 			/* If we were handling a user message, format
                            a response to send to the upper layer to
@@ -575,7 +595,6 @@
 			return_hosed_msg(smi_info);
 		}
 		si_sm_result = smi_info->handlers->event(smi_info->si_sm, 0);
-		smi_info->si_state = SI_NORMAL;
 	}
 
 	/* We prefer handling attn over new messages. */
@@ -872,9 +891,10 @@
 
 #define DEVICE_NAME "ipmi_si"
 
-#define DEFAULT_KCS_IO_PORT 0xca2
-#define DEFAULT_SMIC_IO_PORT 0xca9
-#define DEFAULT_BT_IO_PORT   0xe4
+#define DEFAULT_KCS_IO_PORT	0xca2
+#define DEFAULT_SMIC_IO_PORT	0xca9
+#define DEFAULT_BT_IO_PORT	0xe4
+#define DEFAULT_REGSPACING	1
 
 static int           si_trydefaults = 1;
 static char          *si_type[SI_MAX_PARMS] = { NULL, NULL, NULL, NULL };
@@ -886,6 +906,12 @@
 static int num_ports = 0;
 static int           irqs[SI_MAX_PARMS] = { 0, 0, 0, 0 };
 static int num_irqs = 0;
+static int           regspacings[SI_MAX_PARMS] = { 0, 0, 0, 0 };
+static int num_regspacings = 0;
+static int           regsizes[SI_MAX_PARMS] = { 0, 0, 0, 0 };
+static int num_regsizes = 0;
+static int           regshifts[SI_MAX_PARMS] = { 0, 0, 0, 0 };
+static int num_regshifts = 0;
 
 
 module_param_named(trydefaults, si_trydefaults, bool, 0);
@@ -912,6 +938,23 @@
 		 " addresses separated by commas.  Only use if an interface"
 		 " has an interrupt.  Otherwise, set it to zero or leave"
 		 " it blank.");
+module_param_array(regspacings, int, num_regspacings, 0);
+MODULE_PARM_DESC(regspacings, "The number of bytes between the start address"
+		 " and each successive register used by the interface.  For"
+		 " instance, if the start address is 0xca2 and the spacing"
+		 " is 2, then the second address is at 0xca4.  Defaults"
+		 " to 1.");
+module_param_array(regsizes, int, num_regsizes, 0);
+MODULE_PARM_DESC(regsizes, "The size of the specific IPMI register in bytes."
+		 " This should generally be 1, 2, 4, or 8 for an 8-bit,"
+		 " 16-bit, 32-bit, or 64-bit register.  Use this if you"
+		 " the 8-bit IPMI register has to be read from a larger"
+		 " register.");
+module_param_array(regshifts, int, num_regshifts, 0);
+MODULE_PARM_DESC(regshifts, "The amount to shift the data read from the."
+		 " IPMI register, in bits.  For instance, if the data"
+		 " is read from a 32-bit word and the IPMI data is in"
+		 " bit 8-15, then the shift would be 8");
 
 #define IPMI_MEM_ADDR_SPACE 1
 #define IPMI_IO_ADDR_SPACE  2
@@ -977,7 +1020,7 @@
 {
 	unsigned int *addr = io->info;
 
-	return inb((*addr)+offset);
+	return inb((*addr)+(offset*io->regspacing));
 }
 
 static void port_outb(struct si_sm_io *io, unsigned int offset,
@@ -985,30 +1028,97 @@
 {
 	unsigned int *addr = io->info;
 
-	outb(b, (*addr)+offset);
+	outb(b, (*addr)+(offset * io->regspacing));
 }
 
-static int port_setup(struct smi_info *info)
+static unsigned char port_inw(struct si_sm_io *io, unsigned int offset)
 {
-	unsigned int *addr = info->io.info;
+	unsigned int *addr = io->info;
 
-	if (!addr || (!*addr))
-		return -ENODEV;
+	return (inw((*addr)+(offset * io->regspacing)) >> io->regshift) & 0xff;
+}
 
-	if (request_region(*addr, info->io_size, DEVICE_NAME) == NULL)
-		return -EIO;
-	return 0;
+static void port_outw(struct si_sm_io *io, unsigned int offset,
+		      unsigned char b)
+{
+	unsigned int *addr = io->info;
+
+	outw(b << io->regshift, (*addr)+(offset * io->regspacing));
+}
+
+static unsigned char port_inl(struct si_sm_io *io, unsigned int offset)
+{
+	unsigned int *addr = io->info;
+
+	return (inl((*addr)+(offset * io->regspacing)) >> io->regshift) & 0xff;
+}
+
+static void port_outl(struct si_sm_io *io, unsigned int offset,
+		      unsigned char b)
+{
+	unsigned int *addr = io->info;
+
+	outl(b << io->regshift, (*addr)+(offset * io->regspacing));
 }
 
 static void port_cleanup(struct smi_info *info)
 {
 	unsigned int *addr = info->io.info;
+	int           mapsize;
 
-	if (addr && (*addr))
-		release_region (*addr, info->io_size);
+	if (addr && (*addr)) {
+		mapsize = ((info->io_size * info->io.regspacing)
+			   - (info->io.regspacing - info->io.regsize));
+
+		release_region (*addr, mapsize);
+	}
 	kfree(info);
 }
 
+static int port_setup(struct smi_info *info)
+{
+	unsigned int *addr = info->io.info;
+	int           mapsize;
+
+	if (!addr || (!*addr))
+		return -ENODEV;
+
+	info->io_cleanup = port_cleanup;
+
+	/* Figure out the actual inb/inw/inl/etc routine to use based
+	   upon the register size. */
+	switch (info->io.regsize) {
+	case 1:
+		info->io.inputb = port_inb;
+		info->io.outputb = port_outb;
+		break;
+	case 2:
+		info->io.inputb = port_inw;
+		info->io.outputb = port_outw;
+		break;
+	case 4:
+		info->io.inputb = port_inl;
+		info->io.outputb = port_outl;
+		break;
+	default:
+		printk("ipmi_si: Invalid register size: %d\n",
+		       info->io.regsize);
+		return -EINVAL;
+	}
+
+	/* Calculate the total amount of memory to claim.  This is an
+	 * unusual looking calculation, but it avoids claiming any
+	 * more memory than it has to.  It will claim everything
+	 * between the first address to the end of the last full
+	 * register. */
+	mapsize = ((info->io_size * info->io.regspacing)
+		   - (info->io.regspacing - info->io.regsize));
+
+	if (request_region(*addr, mapsize, DEVICE_NAME) == NULL)
+		return -EIO;
+	return 0;
+}
+
 static int try_init_port(int intf_num, struct smi_info **new_info)
 {
 	struct smi_info *info;
@@ -1028,11 +1138,15 @@
 	memset(info, 0, sizeof(*info));
 
 	info->io_setup = port_setup;
-	info->io_cleanup = port_cleanup;
-	info->io.inputb = port_inb;
-	info->io.outputb = port_outb;
 	info->io.info = &(ports[intf_num]);
 	info->io.addr = NULL;
+	info->io.regspacing = regspacings[intf_num];
+	if (!info->io.regspacing)
+		info->io.regspacing = DEFAULT_REGSPACING;
+	info->io.regsize = regsizes[intf_num];
+	if (!info->io.regsize)
+		info->io.regsize = DEFAULT_REGSPACING;
+	info->io.regshift = regshifts[intf_num];
 	info->irq = 0;
 	info->irq_setup = NULL;
 	*new_info = info;
@@ -1047,44 +1161,125 @@
 
 static unsigned char mem_inb(struct si_sm_io *io, unsigned int offset)
 {
-	return readb((io->addr)+offset);
+	return readb((io->addr)+(offset * io->regspacing));
 }
 
 static void mem_outb(struct si_sm_io *io, unsigned int offset,
 		     unsigned char b)
 {
-	writeb(b, (io->addr)+offset);
+	writeb(b, (io->addr)+(offset * io->regspacing));
 }
 
-static int mem_setup(struct smi_info *info)
+static unsigned char mem_inw(struct si_sm_io *io, unsigned int offset)
 {
-	unsigned long *addr = info->io.info;
+	return (readw((io->addr)+(offset * io->regspacing)) >> io->regshift)
+		&& 0xff;
+}
 
-	if (!addr || (!*addr))
-		return -ENODEV;
+static void mem_outw(struct si_sm_io *io, unsigned int offset,
+		     unsigned char b)
+{
+	writeb(b << io->regshift, (io->addr)+(offset * io->regspacing));
+}
 
-	if (request_mem_region(*addr, info->io_size, DEVICE_NAME) == NULL)
-		return -EIO;
+static unsigned char mem_inl(struct si_sm_io *io, unsigned int offset)
+{
+	return (readl((io->addr)+(offset * io->regspacing)) >> io->regshift)
+		&& 0xff;
+}
 
-	info->io.addr = ioremap(*addr, info->io_size);
-	if (info->io.addr == NULL) {
-		release_mem_region(*addr, info->io_size);
-		return -EIO;
-	}
-	return 0;
+static void mem_outl(struct si_sm_io *io, unsigned int offset,
+		     unsigned char b)
+{
+	writel(b << io->regshift, (io->addr)+(offset * io->regspacing));
 }
 
+#ifdef readq
+static unsigned char mem_inq(struct si_sm_io *io, unsigned int offset)
+{
+	return (readq((io->addr)+(offset * io->regspacing)) >> io->regshift)
+		&& 0xff;
+}
+
+static void mem_outq(struct si_sm_io *io, unsigned int offset,
+		     unsigned char b)
+{
+	writeq(b << io->regshift, (io->addr)+(offset * io->regspacing));
+}
+#endif
+
 static void mem_cleanup(struct smi_info *info)
 {
 	unsigned long *addr = info->io.info;
+	int           mapsize;
 
 	if (info->io.addr) {
 		iounmap(info->io.addr);
-		release_mem_region(*addr, info->io_size);
+
+		mapsize = ((info->io_size * info->io.regspacing)
+			   - (info->io.regspacing - info->io.regsize));
+
+		release_mem_region(*addr, mapsize);
 	}
 	kfree(info);
 }
 
+static int mem_setup(struct smi_info *info)
+{
+	unsigned long *addr = info->io.info;
+	int           mapsize;
+
+	if (!addr || (!*addr))
+		return -ENODEV;
+
+	info->io_cleanup = mem_cleanup;
+
+	/* Figure out the actual readb/readw/readl/etc routine to use based
+	   upon the register size. */
+	switch (info->io.regsize) {
+	case 1:
+		info->io.inputb = mem_inb;
+		info->io.outputb = mem_outb;
+		break;
+	case 2:
+		info->io.inputb = mem_inw;
+		info->io.outputb = mem_outw;
+		break;
+	case 4:
+		info->io.inputb = mem_inl;
+		info->io.outputb = mem_outl;
+		break;
+#ifdef readq
+	case 4:
+		info->io.inputb = mem_inq;
+		info->io.outputb = mem_outq;
+		break;
+#endif
+	default:
+		printk("ipmi_si: Invalid register size: %d\n",
+		       info->io.regsize);
+		return -EINVAL;
+	}
+
+	/* Calculate the total amount of memory to claim.  This is an
+	 * unusual looking calculation, but it avoids claiming any
+	 * more memory than it has to.  It will claim everything
+	 * between the first address to the end of the last full
+	 * register. */
+	mapsize = ((info->io_size * info->io.regspacing)
+		   - (info->io.regspacing - info->io.regsize));
+
+	if (request_mem_region(*addr, mapsize, DEVICE_NAME) == NULL)
+		return -EIO;
+
+	info->io.addr = ioremap(*addr, mapsize);
+	if (info->io.addr == NULL) {
+		release_mem_region(*addr, mapsize);
+		return -EIO;
+	}
+	return 0;
+}
+
 static int try_init_mem(int intf_num, struct smi_info **new_info)
 {
 	struct smi_info *info;
@@ -1104,11 +1299,15 @@
 	memset(info, 0, sizeof(*info));
 
 	info->io_setup = mem_setup;
-	info->io_cleanup = mem_cleanup;
-	info->io.inputb = mem_inb;
-	info->io.outputb = mem_outb;
 	info->io.info = (void *) addrs[intf_num];
 	info->io.addr = NULL;
+	info->io.regspacing = regspacings[intf_num];
+	if (!info->io.regspacing)
+		info->io.regspacing = DEFAULT_REGSPACING;
+	info->io.regsize = regsizes[intf_num];
+	if (!info->io.regsize)
+		info->io.regsize = DEFAULT_REGSPACING;
+	info->io.regshift = regshifts[intf_num];
 	info->irq = 0;
 	info->irq_setup = NULL;
 	*new_info = info;
@@ -1132,7 +1331,7 @@
 static int acpi_failure = 0;
 
 /* For GPE-type interrupts. */
-void ipmi_acpi_gpe(void *context)
+u32 ipmi_acpi_gpe(void *context)
 {
 	struct smi_info *smi_info = context;
 	unsigned long   flags;
@@ -1156,6 +1355,8 @@
 	smi_event_handler(smi_info, 0);
  out:
 	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
+
+	return ACPI_INTERRUPT_HANDLED;
 }
 
 static int acpi_gpe_irq_setup(struct smi_info *info)
@@ -1182,7 +1383,6 @@
 		printk("  Using ACPI GPE %d\n", info->irq);
 		return 0;
 	}
-
 }
 
 static void acpi_gpe_irq_cleanup(struct smi_info *info)
@@ -1310,21 +1510,22 @@
 		info->irq_setup = NULL;
 	}
 
+	regspacings[intf_num] = spmi->addr.register_bit_width / 8;
+	info->io.regspacing = spmi->addr.register_bit_width / 8;
+	regsizes[intf_num] = regspacings[intf_num];
+	info->io.regsize = regsizes[intf_num];
+	regshifts[intf_num] = spmi->addr.register_bit_offset;
+	info->io.regshift = regshifts[intf_num];
+
 	if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 		io_type = "memory";
 		info->io_setup = mem_setup;
-		info->io_cleanup = mem_cleanup;
 		addrs[intf_num] = spmi->addr.address;
-		info->io.inputb = mem_inb;
-		info->io.outputb = mem_outb;
 		info->io.info = &(addrs[intf_num]);
 	} else if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		io_type = "I/O";
 		info->io_setup = port_setup;
-		info->io_cleanup = port_cleanup;
 		ports[intf_num] = spmi->addr.address;
-		info->io.inputb = port_inb;
-		info->io.outputb = port_outb;
 		info->io.info = &(ports[intf_num]);
 	} else {
 		kfree(info);
@@ -1348,6 +1549,7 @@
 	u8   		addr_space;
 	unsigned long	base_addr;
 	u8   		irq;
+	u8              offset;
 }dmi_ipmi_data_t;
 
 typedef struct dmi_header
@@ -1361,6 +1563,7 @@
 {
 	u8		*data = (u8 *)dm;
 	unsigned long  	base_addr;
+	u8		reg_spacing;
 
 	ipmi_data->type = data[0x04];
 
@@ -1375,7 +1578,27 @@
 		ipmi_data->addr_space = IPMI_MEM_ADDR_SPACE;
 	}
 
-	ipmi_data->base_addr = base_addr;
+	/* The top two bits of byte 0x10 hold the register spacing. */
+	reg_spacing = (data[0x10] & 0xC0) >> 6;
+	switch(reg_spacing){
+	case 0x00: /* Byte boundaries */
+		ipmi_data->offset = 1;
+		break;
+	case 0x01: /* 32-bit boundaries */
+		ipmi_data->offset = 4;
+		break;
+	case 0x02: /* 16-bit boundaries */
+		ipmi_data->offset = 2;
+	default:
+		printk("ipmi_si: Unknown SMBIOS IPMI Base Addr"
+		       " Modifier: 0x%x\n", reg_spacing);
+		return -EIO;
+	}
+
+	/* If bit 4 of byte 0x10 is set, then the lsb for the address
+	   is odd. */
+	ipmi_data->base_addr = base_addr | ((data[0x10] & 0x10) >> 4);
+
 	ipmi_data->irq = data[0x11];
 
 	if (is_new_interface(-1, ipmi_data->addr_space,ipmi_data->base_addr))
@@ -1500,18 +1723,12 @@
 	if (ipmi_data.addr_space == 1) {
 		io_type = "memory";
 		info->io_setup = mem_setup;
-		info->io_cleanup = mem_cleanup;
 		addrs[intf_num] = ipmi_data.base_addr;
-		info->io.inputb = mem_inb;
-		info->io.outputb = mem_outb;
 		info->io.info = &(addrs[intf_num]);
 	} else if (ipmi_data.addr_space == 2) {
 		io_type = "I/O";
 		info->io_setup = port_setup;
-		info->io_cleanup = port_cleanup;
 		ports[intf_num] = ipmi_data.base_addr;
-		info->io.inputb = port_inb;
-		info->io.outputb = port_outb;
 		info->io.info = &(ports[intf_num]);
 	} else {
 		kfree(info);
@@ -1519,6 +1736,13 @@
 		return -EIO;
 	}
 
+	regspacings[intf_num] = ipmi_data.offset;
+	info->io.regspacing = regspacings[intf_num];
+	if (!info->io.regspacing)
+		info->io.regspacing = DEFAULT_REGSPACING;
+	info->io.regsize = DEFAULT_REGSPACING;
+	info->io.regshift = regshifts[intf_num];
+
 	irqs[intf_num] = ipmi_data.irq;
 
 	*new_info = info;
@@ -1596,11 +1820,13 @@
 	memset(info, 0, sizeof(*info));
 
 	info->io_setup = port_setup;
-	info->io_cleanup = port_cleanup;
 	ports[intf_num] = base_addr;
-	info->io.inputb = port_inb;
-	info->io.outputb = port_outb;
 	info->io.info = &(ports[intf_num]);
+	info->io.regspacing = regspacings[intf_num];
+	if (!info->io.regspacing)
+		info->io.regspacing = DEFAULT_REGSPACING;
+	info->io.regsize = DEFAULT_REGSPACING;
+	info->io.regshift = regshifts[intf_num];
 
 	*new_info = info;
 
@@ -1860,6 +2086,13 @@
 	new_smi->timer_stopped = 0;
 	new_smi->stop_operation = 0;
 
+	/* Start clearing the flags before we enable interrupts or the
+	   timer to avoid racing with the timer. */
+	start_clear_flags(new_smi);
+	/* IRQ is defined to be set when non-zero. */
+	if (new_smi->irq)
+		new_smi->si_state = SI_CLEARING_FLAGS_THEN_SET_IRQ;
+
 	/* The ipmi_register_smi() code does some operations to
 	   determine the channel information, so we must be ready to
 	   handle operations before it is called.  This means we have
@@ -1903,12 +2136,6 @@
 		goto out_err_stop_timer;
 	}
 
-	start_clear_flags(new_smi);
-
-	/* IRQ is defined to be set when non-zero. */
-	if (new_smi->irq)
-		new_smi->si_state = SI_CLEARING_FLAGS_THEN_SET_IRQ;
-
 	*smi = new_smi;
 
 	printk(" IPMI %s interface initialized\n", si_type[intf_num]);
@@ -2052,6 +2279,13 @@
 		schedule_timeout(1);
 	}
 
+	/* Interrupts and timeouts are stopped, now make sure the
+	   interface is in a clean state. */
+	while ((to_clean->curr_msg) || (to_clean->si_state != SI_NORMAL)) {
+		poll(to_clean);
+		schedule_timeout(1);
+	}
+
 	rv = ipmi_unregister_smi(to_clean->intf);
 	if (rv) {
 		printk(KERN_ERR
Index: linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_si_sm.h
===================================================================
--- linux-2.6.8-rc4-mm1.orig/drivers/char/ipmi/ipmi_si_sm.h	2004-08-10 18:00:33.000000000 -0500
+++ linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_si_sm.h	2004-08-10 18:06:43.000000000 -0500
@@ -52,6 +52,9 @@
            state machine shouldn't touch these. */
 	void *info;
 	void *addr;
+	int  regspacing;
+	int  regsize;
+	int  regshift;
 };
 
 /* Results of SMI events. */
Index: linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_smic_sm.c
===================================================================
--- linux-2.6.8-rc4-mm1.orig/drivers/char/ipmi/ipmi_smic_sm.c	2004-08-10 18:00:54.000000000 -0500
+++ linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_smic_sm.c	2004-08-10 18:06:18.000000000 -0500
@@ -46,7 +46,7 @@
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
-#define IPMI_SMIC_VERSION "v32"
+#define IPMI_SMIC_VERSION "v33"
 
 /* smic_debug is a bit-field
  *	SMIC_DEBUG_ENABLE -	turned on for now
Index: linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.8-rc4-mm1.orig/drivers/char/ipmi/ipmi_watchdog.c	2004-08-10 18:00:54.000000000 -0500
+++ linux-2.6.8-rc4-mm1/drivers/char/ipmi/ipmi_watchdog.c	2004-08-10 18:06:18.000000000 -0500
@@ -53,7 +53,7 @@
 
 #define	PFX "IPMI Watchdog: "
 
-#define IPMI_WATCHDOG_VERSION "v32"
+#define IPMI_WATCHDOG_VERSION "v33"
 
 /*
  * The IPMI command/response information for the watchdog timer.
Index: linux-2.6.8-rc4-mm1/drivers/char/ipmi/Kconfig
===================================================================
--- linux-2.6.8-rc4-mm1.orig/drivers/char/ipmi/Kconfig	2004-08-10 18:00:22.000000000 -0500
+++ linux-2.6.8-rc4-mm1/drivers/char/ipmi/Kconfig	2004-08-10 18:06:46.000000000 -0500
@@ -57,4 +57,11 @@
        help
          This enables the IPMI watchdog timer.
 
+config IPMI_POWEROFF
+       tristate 'IPMI Poweroff'
+       depends on IPMI_HANDLER
+       help
+         This enables a function to power off the system with IPMI if
+	 the IPMI management controller is capable of this.
+
 endmenu
Index: linux-2.6.8-rc4-mm1/drivers/char/ipmi/Makefile
===================================================================
--- linux-2.6.8-rc4-mm1.orig/drivers/char/ipmi/Makefile	2004-08-10 18:00:22.000000000 -0500
+++ linux-2.6.8-rc4-mm1/drivers/char/ipmi/Makefile	2004-08-10 18:06:46.000000000 -0500
@@ -8,6 +8,7 @@
 obj-$(CONFIG_IPMI_DEVICE_INTERFACE) += ipmi_devintf.o
 obj-$(CONFIG_IPMI_SI) += ipmi_si.o
 obj-$(CONFIG_IPMI_WATCHDOG) += ipmi_watchdog.o
+obj-$(CONFIG_IPMI_POWEROFF) += ipmi_poweroff.o
 
 ipmi_si.o:	$(ipmi_si-objs)
 	$(LD) -r -o $@ $(ipmi_si-objs)
Index: linux-2.6.8-rc4-mm1/include/linux/ipmi.h
===================================================================
--- linux-2.6.8-rc4-mm1.orig/include/linux/ipmi.h	2004-08-10 18:00:22.000000000 -0500
+++ linux-2.6.8-rc4-mm1/include/linux/ipmi.h	2004-08-10 18:06:46.000000000 -0500
@@ -406,6 +406,12 @@
 			    unsigned char cmd);
 
 /*
+ * Allow run-to-completion mode to be set for the interface of
+ * a specific user.
+ */
+void ipmi_user_set_run_to_completion(ipmi_user_t user, int val);
+
+/*
  * When the user is created, it will not receive IPMI events by
  * default.  The user must set this to TRUE to get incoming events.
  * The first user that sets this to TRUE will receive all events that

--------------040708040209070900040400--

