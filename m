Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUBWQE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUBWQE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:04:57 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:9157 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261932AbUBWQCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:02:52 -0500
Message-ID: <403A242A.6000802@acm.org>
Date: Mon, 23 Feb 2004 10:02:50 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] IPMI driver updates, part 3
Content-Type: multipart/mixed;
 boundary="------------040908030806040600050803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040908030806040600050803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It has been far too long since the last IPMI driver updates, but now all 
the planets have aligned and all the pieces I needed are in and all seem 
to be working.  This update is coming as four parts that must be applied 
in order, but the later parts do not have to be applied for the former 
parts to work.

This third part adds an SMBus IPMI interface.  Some systems have 
interfaces through the SMBus to the local IPMI controller; this driver 
should support those interfaces.

FYI, IPMI is a standard for monitoring and maintaining a system.  It 
provides interfaces for detecting sensors (voltage, temperature, etc.) 
in the system and monitoring those sensors.  Many systems have extended 
capabilities that allow IPMI to control the system, doing things like 
lighting leds and controlling hot-swap.  This driver allows access to 
the IPMI system.

-Corey

--------------040908030806040600050803
Content-Type: text/plain;
 name="linux-2.6.3-ipmi-part3-smbus.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.3-ipmi-part3-smbus.diff"

diff -urN linux-a2/Documentation/IPMI.txt linux-a3/Documentation/IPMI.txt
--- linux-a2/Documentation/IPMI.txt	2004-02-23 08:35:19.000000000 -0600
+++ linux-a3/Documentation/IPMI.txt	2004-02-23 08:39:51.000000000 -0600
@@ -43,7 +43,11 @@
 The driver interface depends on your hardware.  If you have a board
 with a standard interface (These will generally be either "KCS",
 "SMIC", or "BT", consult your hardware manual), choose the 'IPMI SI
-handler' option.
+handler' option.  A driver also exists for direct I2C access to the
+IPMI management controller.  Some boards support this, but it is
+unknown if it will work on every board.  For this, choose 'IPMI SMBus
+handler', but be ready to try to do some figuring to see if it will
+work.
 
 There is also a KCS-only driver interface supplied, but it is
 depracated in favor of the SI interface.
@@ -97,6 +101,10 @@
 interface for IPMI.  This is deprecated, ipmi_si_drv supports KCS and
 SMIC interfaces.
 
+ipmi_smb_intf - A driver for accessing BMCs on the SMBus. It uses the
+I2C kernel driver's SMBus interfaces to send and receive IPMI messages
+over the SMBus.
+
 
 Much documentation for the interface is in the include files.  The
 IPMI include files are:
@@ -421,6 +429,59 @@
 the KCS interface sucks.
 
 
+The SMBus Driver
+----------------
+
+The SMBus driver allows up to 4 SMBus devices to be configured in the
+system.  By default, the driver will register any SMBus interfaces it finds
+in the I2C address range of 0x20 to 0x4f on any adapter.  You can change this
+at module load time (for a module) with:
+
+  insmod ipmi_smb_intf.o
+	smb_addr=<adapter1>,<i2caddr1>[,<adapter2>,<i2caddr2>[,...]]
+	smb_dbg=<flags1>,<flags2>...
+	[smb_defaultprobe=0] [smb_dbg_probe=1]
+
+The addresses are specified in pairs, the first is the adapter ID and the
+second is the I2C address on that adapter.
+
+The debug flags are bit flags for each BMC found, they are:
+IPMI messages: 1, driver state: 2, timing: 4, I2C probe: 8
+
+Setting smb_defaultprobe to zero disabled the default probing of SMBus
+interfaces at address range 0x20 to 0x4f.  This means that only the
+BMCs specified on the smb_addr line will be detected.
+
+Setting smb_dbg_probe to 1 will enable debugging of the probing and
+detection process for BMCs on the SMBusses.
+
+Discovering the IPMI compilant BMC on the SMBus can cause devices
+on the I2C bus to fail. The SMBus driver writes a "Get Device ID" IPMI
+message as a block write to the I2C bus and waits for a response.
+This action can be detrimental to some I2C devices. It is highly recommended
+that the known I2c address be given to the SMBus driver in the smb_addr
+parameter. The default adrress range will not be used when a smb_addr
+parameter is provided.
+
+When compiled into the kernel, the addresses can be specified on the
+kernel command line as:
+
+  ipmi_smb=[<adapter1>.]<addr1>[:<debug1>],[<adapter2>.<addr2>[:<debug1>]....
+
+The [<adapterx>.]<addrx>[:<debugx>] I2C address-debug flag are value
+set for each BMC.  If the adapter is not given, then it defaults to
+zero.  The debug flag is the same as the smb_dbg flag given above.
+
+You may also specify "nodefaults" and "debug_probe", separated by
+commas, on the ipmi_smb line.  These will disable the default SMB
+probe and enable debugging of the BMC probing and detection process,
+respectively.
+
+Note that you might need some I2C changes if CONFIG_IPMI_PANIC_EVENT
+is enabled along with this, so the I2C driver knows to run to
+completion during sending a panic event.
+
+
 Other Pieces
 ------------
 
diff -urN linux-a2/drivers/char/ipmi/ipmi_smb_intf.c linux-a3/drivers/char/ipmi/ipmi_smb_intf.c
--- linux-a2/drivers/char/ipmi/ipmi_smb_intf.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-a3/drivers/char/ipmi/ipmi_smb_intf.c	2004-02-23 08:29:22.000000000 -0600
@@ -0,0 +1,1314 @@
+/*
+ * ipmi_smb_intf.c
+ *
+ * The interface to the IPMI driver for SMBus access to a SMBus compliant device.
+ *
+ * Author: Intel Corporation
+ *         Todd Davis <todd.c.davis@intel.com>
+  *
+ * Copyright 2003 Intel Corporation
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
+
+/*
+ * This file holds the "policy" for the interface to the SMB state
+ * machine.  It does the configuration, handles timers and interrupts,
+ * and drives the real SMB state machine.
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#if defined(MODVERSIONS)
+#include <linux/modversions.h>
+#endif
+
+#include <linux/module.h>
+#include <asm/system.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/list.h>
+#include <linux/i2c.h>
+#include <linux/ipmi_smi.h>
+#include <linux/init.h>
+
+
+#define IPMI_SMB_VERSION "v30"
+
+/* module feature switches */
+#define	REGISTER_SMI	1
+#define	SMB_KTHREAD	1
+
+#ifdef SMB_KTHREAD
+#include <linux/kernel.h>
+#include <linux/smp_lock.h>
+
+/* a structure to store all information we need
+   for our thread */
+typedef struct kthread_struct
+{
+        /* Linux task structure of thread */
+        struct task_struct *thread;
+
+       /* semaphore needed on start and creation of thread. */
+        struct semaphore startstop_sem;
+
+        /* queue thread is waiting on. Gets initialized by
+           init_kthread, can be used by thread itself.
+        */
+        wait_queue_head_t queue;
+        /* flag to tell thread whether to die or not.
+           When the thread receives a signal, it must check
+           the value of terminate and call exit_kthread and terminate
+           if set.
+        */
+	int terminate;
+} kthread_t;	/* the variable that contains the thread data */
+#endif
+
+#define	SMB_IPMI_REQUEST	2
+#define	SMB_IPMI_RESPONSE	3
+
+/* smb_debug is a bit-field
+ *	SMB_DEBUG_MSG -	commands and their responses
+ *	SMB_DEBUG_STATES -	message states
+ *	SMB_DEBUG_TIMING -	 Measure times between events in the driver
+ */
+#define SMB_DEBUG_TIMING	4
+#define SMB_DEBUG_STATE		2
+#define SMB_DEBUG_MSG		1
+#define SMB_NODEBUG		0
+#define SMB_DEFAULT_DEBUG	(SMB_NODEBUG)
+
+#ifdef CONFIG_IPMI_SMB
+/* This forces a dependency to the config file for this option. */
+#endif
+
+enum smb_intf_state {
+	SMB_NORMAL,
+	SMB_GETTING_FLAGS,
+	SMB_GETTING_EVENTS,
+	SMB_CLEARING_FLAGS,
+	SMB_CLEARING_FLAGS_THEN_SET_IRQ,
+	SMB_GETTING_MESSAGES,
+	SMB_ENABLE_INTERRUPTS1,
+	SMB_ENABLE_INTERRUPTS2
+	/* FIXME - add watchdog stuff. */
+};
+
+#define SMB_IDLE(smb)	 ((smb)->smb_state == SMB_NORMAL \
+			  && (smb)->curr_msg == NULL \
+			  && ! atomic_read(&(smb)->req_events))
+
+#define	SMB_MSG_RETRIES	10
+
+struct smb_info
+{
+	int                 pos;
+	ipmi_smi_t          intf;
+	spinlock_t          msg_lock;
+	struct list_head    xmit_msgs;
+	struct list_head    hp_xmit_msgs;
+	struct ipmi_smi_msg *curr_msg;
+	enum smb_intf_state smb_state;
+	unsigned long       smb_debug;
+
+	/* Flags from the last GET_MSG_FLAGS command, used when an ATTN
+	   is set to hold the flags until we are done handling everything
+	   from the flags. */
+#define RECEIVE_MSG_AVAIL	0x01
+#define EVENT_MSG_BUFFER_FULL	0x02
+#define WDT_PRE_TIMEOUT_INT	0x08
+	unsigned char       msg_flags;
+
+	/* If set to true, this will request events the next time the
+	   state machine is idle. */
+	atomic_t            req_events;
+
+#ifdef CONFIG_IPMI_PANIC_EVENT
+	/* If true, run the state machine to completion on every send
+	   call.  Generally used after a panic or shutdown to make
+	   sure stuff goes out. */
+	int                 run_to_completion;
+#endif
+
+#ifdef SMB_KTHREAD
+	kthread_t smb_thread;
+#endif
+	struct i2c_client client;
+	unsigned char ipmi_smb_dev_rev;
+	unsigned char ipmi_smb_fw_rev_major;
+	unsigned char ipmi_smb_fw_rev_minor;
+	unsigned char ipmi_version_major;
+	unsigned char ipmi_version_minor;
+};
+
+static int initialized = 0;
+static void return_hosed_msg(struct smb_info *smb_info);
+
+static void deliver_recv_msg(struct smb_info *smb_info,
+			     struct ipmi_smi_msg *msg)
+{
+	if (msg->rsp_size < 0) {
+		if (smb_info->curr_msg == NULL) {
+			smb_info->curr_msg = msg;
+			return_hosed_msg(smb_info);
+		} else {
+			printk(KERN_ERR
+			       "malformed message in deliver_recv_msg:"
+			       " rsp_size = %d\n", msg->rsp_size);
+			ipmi_free_smi_msg(msg);
+		}
+	} else {
+		ipmi_smi_msg_received(smb_info->intf, msg);
+	}
+}
+
+static void return_hosed_msg(struct smb_info *smb_info)
+{
+	struct ipmi_smi_msg *msg = smb_info->curr_msg;
+
+	/* Make it a reponse */
+	msg->rsp[0] = msg->data[0] | 4;
+	msg->rsp[1] = msg->data[1];
+	msg->rsp[2] = 0xFF; /* Unknown error. */
+	msg->rsp_size = 3;
+
+	smb_info->curr_msg = NULL;
+	deliver_recv_msg(smb_info, msg);
+}
+
+static s32 smbus_client_read_block_data(struct i2c_client *client, int debug,
+					u8 *values)
+{
+	s32 resp_len;
+	int retries = 0;
+
+	/* FIXME - is there a way to limit the read size?  This culd
+	 * be an overrun situation otherwise. */
+	while ((resp_len = i2c_smbus_read_block_data (client,
+						      SMB_IPMI_RESPONSE,
+						      values)) < 0)
+	{
+		if ((retries += 1) >= SMB_MSG_RETRIES) {
+			printk(KERN_ERR
+			       "smb_smbus_read_block_data failed: %d\n",
+			       resp_len);
+			break;
+#ifdef CONFIG_IPMI_PANIC_EVENT
+		} else if (retries >= SMB_MSG_RETRIES/2 && signal_pending(current)) {
+			i2c_set_spin_delay(1); // shutting down
+#endif
+		} else if (debug & (SMB_DEBUG_MSG|SMB_DEBUG_TIMING)) {
+			printk(KERN_WARNING
+			       "smb_smbus_read_block_data: retry %d\n",
+			       retries);
+		}
+	}
+
+	if (debug & SMB_DEBUG_TIMING) {
+		struct timeval t;
+		do_gettimeofday(&t);
+		printk(KERN_INFO "**Response %02x %02x %02x: %ld.%6.6ld\n",
+		       values[0], values[1], values[2], t.tv_sec, t.tv_usec);
+	}
+
+	if (debug & SMB_DEBUG_MSG) {
+		int i;
+		printk(KERN_INFO "ipmi response:");
+		for (i = 0; i < resp_len; i ++) {
+			printk (" %02x", (unsigned char) (values[i]));
+		}
+		printk ("\n");
+	}
+
+	return resp_len;
+}
+
+static s32 smb_smbus_read_block_data(struct smb_info *smb_info, u8 *values)
+{
+	return smbus_client_read_block_data(&smb_info->client,
+					    smb_info->smb_debug, values);
+}
+
+static s32 smbus_client_write_block_data(struct i2c_client *client, int debug,
+					 u8 length, u8 *values)
+{
+	s32 ret;
+	int retries = 0;
+
+	if (debug & SMB_DEBUG_MSG) {
+		int i ;
+
+		printk(KERN_INFO "ipmi request:");
+		for (i = 0; i < length; i ++) {
+			printk (" %02x", (unsigned char) (values [i]));
+		}
+		printk ("\n");
+	}
+
+	if (debug & SMB_DEBUG_TIMING) {
+		struct timeval t;
+		do_gettimeofday(&t);
+		printk(KERN_INFO "**Request %02x %02x: %ld.%6.6ld\n",
+		       values [0],values [1], t.tv_sec, t.tv_usec);
+	}
+
+	while ((ret = i2c_smbus_write_block_data (client,
+						  SMB_IPMI_REQUEST,
+						  length, values)) < 0)
+	{
+		if ((retries += 1) >= SMB_MSG_RETRIES) {
+			printk(KERN_ERR
+			       "smb_smbus_write_block_data failed: %d\n", ret);
+			break;
+#ifdef CONFIG_IPMI_PANIC_EVENT
+		} else if (retries >= SMB_MSG_RETRIES/2 && signal_pending(current)) {
+			i2c_set_spin_delay(1); // shutting down
+#endif
+		} else if (debug & (SMB_DEBUG_MSG|SMB_DEBUG_TIMING)) {
+			printk(KERN_WARNING
+			       "smb_smbus_write_block_data: retry %d\n",
+			       retries);
+		}
+	}
+	return ret;
+}
+
+static s32 smb_smbus_write_block_data(struct smb_info *smb_info,
+                                      u8 length,  u8 *values)
+{
+	return smbus_client_write_block_data(&smb_info->client,
+					     smb_info->smb_debug,
+					     length,
+					     values);
+}
+
+static int send_next_msg(struct smb_info *smb_info)
+{
+	s32              rv;
+	struct list_head *entry = NULL;
+
+	spin_lock(&(smb_info->msg_lock));
+
+	/* Pick the high priority queue first. */
+	if (! list_empty(&(smb_info->hp_xmit_msgs))) {
+		entry = smb_info->hp_xmit_msgs.next;
+	} else if (! list_empty(&(smb_info->xmit_msgs))) {
+		entry = smb_info->xmit_msgs.next;
+	}
+
+	if (!entry) {
+		spin_unlock(&(smb_info->msg_lock));
+		smb_info->curr_msg = NULL;
+		return 0;
+	}
+	list_del(entry);
+	smb_info->curr_msg = list_entry(entry,
+					struct ipmi_smi_msg,
+					link);
+	spin_unlock(&(smb_info->msg_lock));
+	rv = smb_smbus_write_block_data(
+	    smb_info,
+	    smb_info->curr_msg->data_size,
+	    smb_info->curr_msg->data);
+	if (rv) {
+		return_hosed_msg(smb_info);
+	}
+	return 1;
+}
+
+static void start_enable_irq(struct smb_info *smb_info)
+{
+	unsigned char msg[2];
+
+	/* If we are enabling interrupts, we have to tell the
+	   IPMI device to use them. */
+	msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
+	msg[1] = IPMI_GET_BMC_GLOBAL_ENABLES_CMD;
+
+	if (smb_smbus_write_block_data(smb_info, 2, msg) == 0) {
+		smb_info->smb_state = SMB_ENABLE_INTERRUPTS1;
+	} else {
+		smb_info->smb_state = SMB_NORMAL;
+	}
+}
+
+static void start_clear_flags(struct smb_info *smb_info)
+{
+	unsigned char msg[3];
+
+	/* Make sure the watchdog pre-timeout flag is not set at startup. */
+	msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
+	msg[1] = IPMI_CLEAR_MSG_FLAGS_CMD;
+	msg[2] = WDT_PRE_TIMEOUT_INT;
+
+	if (smb_smbus_write_block_data(smb_info, 3, msg) == 0) {
+		smb_info->smb_state = SMB_CLEARING_FLAGS;
+	} else {
+		smb_info->smb_state = SMB_NORMAL;
+	}
+}
+
+static void handle_flags(struct smb_info *smb_info)
+{
+	if (smb_info->msg_flags & WDT_PRE_TIMEOUT_INT) {
+		/* Watchdog pre-timeout */
+		start_clear_flags(smb_info);
+		smb_info->msg_flags &= ~WDT_PRE_TIMEOUT_INT;
+		ipmi_smi_watchdog_pretimeout(smb_info->intf);
+	} else if (smb_info->msg_flags & RECEIVE_MSG_AVAIL) {
+		/* Messages available. */
+		smb_info->curr_msg = ipmi_alloc_smi_msg();
+		if (!smb_info->curr_msg) {
+			smb_info->smb_state = SMB_NORMAL;
+			return;
+		}
+
+		smb_info->curr_msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
+		smb_info->curr_msg->data[1] = IPMI_GET_MSG_CMD;
+		smb_info->curr_msg->data_size = 2;
+
+		if (smb_smbus_write_block_data(
+		    smb_info,
+		    smb_info->curr_msg->data_size,
+		    smb_info->curr_msg->data) == 0) {
+			smb_info->smb_state = SMB_GETTING_MESSAGES;
+		} else {
+			ipmi_free_smi_msg(smb_info->curr_msg);
+			smb_info->curr_msg = NULL;
+			smb_info->smb_state = SMB_NORMAL;
+			return;
+		}
+	} else if (smb_info->msg_flags & EVENT_MSG_BUFFER_FULL) {
+		/* Events available. */
+		smb_info->curr_msg = ipmi_alloc_smi_msg();
+		if (!smb_info->curr_msg) {
+			smb_info->smb_state = SMB_NORMAL;
+			return;
+		}
+
+		smb_info->curr_msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
+		smb_info->curr_msg->data[1] = IPMI_READ_EVENT_MSG_BUFFER_CMD;
+		smb_info->curr_msg->data_size = 2;
+
+		if (smb_smbus_write_block_data(
+		    smb_info,
+		    smb_info->curr_msg->data_size,
+		    smb_info->curr_msg->data) == 0) {
+			smb_info->smb_state = SMB_GETTING_EVENTS;
+		} else {
+			ipmi_free_smi_msg(smb_info->curr_msg);
+			smb_info->curr_msg = NULL;
+			smb_info->smb_state = SMB_NORMAL;
+			return;
+		}
+	} else {
+		smb_info->smb_state = SMB_NORMAL;
+	}
+}
+
+static void handle_transaction_done(struct smb_info *smb_info)
+{
+	struct ipmi_smi_msg *msg;
+	unsigned int  len;
+
+	if (smb_info->smb_debug & SMB_DEBUG_STATE) {
+		printk(KERN_INFO "DONE 1: state = %d.\n", smb_info->smb_state);
+	}
+	switch (smb_info->smb_state) {
+	case SMB_NORMAL:
+		if (!smb_info->curr_msg)
+			break;
+
+		smb_info->curr_msg->rsp_size
+			= smb_smbus_read_block_data(
+			    smb_info,
+			    smb_info->curr_msg->rsp);
+
+		msg = smb_info->curr_msg;
+		smb_info->curr_msg = NULL;
+		deliver_recv_msg(smb_info, msg);
+		break;
+
+	case SMB_GETTING_FLAGS:
+	{
+		unsigned char msg[4];
+
+		/* We got the flags from the SMB, now handle them. */
+		len = smb_smbus_read_block_data(smb_info, msg);
+		if (len < 0) {
+			/* Error fetching flags, just give up for  now. */
+			smb_info->smb_state = SMB_NORMAL;
+		} else if (msg[2] != 0) {
+			/* Error fetching flags, just give up for  now. */
+			smb_info->smb_state = SMB_NORMAL;
+		} else if (len < 3) {
+			/* Hmm, no flags.  That's technically illegal, but
+			   don't use uninitialized data. */
+			smb_info->smb_state = SMB_NORMAL;
+		} else {
+			smb_info->msg_flags = msg[3];
+			handle_flags(smb_info);
+		}
+		break;
+	}
+
+	case SMB_CLEARING_FLAGS:
+	case SMB_CLEARING_FLAGS_THEN_SET_IRQ:
+	{
+		unsigned char msg[3];
+
+		/* We cleared the flags. */
+		len = smb_smbus_read_block_data(smb_info, msg);
+		if (len < 0 || msg[2] != 0) {
+			/* Error clearing flags */
+			printk(KERN_WARNING
+			       "ipmi_smb: Error clearing flags: %2.2x\n",
+			       msg[2]);
+		}
+		if (smb_info->smb_state == SMB_CLEARING_FLAGS_THEN_SET_IRQ)
+			start_enable_irq(smb_info);
+		else
+			smb_info->smb_state = SMB_NORMAL;
+		break;
+	}
+
+	case SMB_GETTING_EVENTS:
+	{
+		smb_info->curr_msg->rsp_size
+			= smb_smbus_read_block_data(smb_info,
+						    smb_info->curr_msg->rsp);
+
+		msg = smb_info->curr_msg;
+		smb_info->curr_msg = NULL;
+		if (msg->rsp_size < 0 || msg->rsp[2] != 0) {
+			/* Error getting event, probably done. */
+			msg->done(msg);
+
+			/* Take off the event flag. */
+			smb_info->msg_flags &= ~EVENT_MSG_BUFFER_FULL;
+		} else {
+			deliver_recv_msg(smb_info, msg);
+		}
+		handle_flags(smb_info);
+		break;
+	}
+
+	case SMB_GETTING_MESSAGES:
+	{
+		smb_info->curr_msg->rsp_size
+			= smb_smbus_read_block_data(smb_info,
+						      smb_info->curr_msg->rsp);
+
+		msg = smb_info->curr_msg;
+		smb_info->curr_msg = NULL;
+		if (msg->rsp_size < 0 || msg->rsp[2] != 0) {
+			/* Error getting event, probably done. */
+			msg->done(msg);
+
+			/* Take off the msg flag. */
+			smb_info->msg_flags &= ~RECEIVE_MSG_AVAIL;
+		} else {
+			deliver_recv_msg(smb_info, msg);
+		}
+		handle_flags(smb_info);
+		break;
+	}
+
+	case SMB_ENABLE_INTERRUPTS1:
+	{
+		unsigned char msg[4];
+
+		/* We got the flags from the SMB, now handle them. */
+		len = smb_smbus_read_block_data(smb_info, msg);
+		if (len < 0 || msg[2] != 0) {
+			printk(KERN_WARNING
+			       "ipmi_smb: Could not enable interrupts"
+			       ", failed get, using polled mode.\n");
+			smb_info->smb_state = SMB_NORMAL;
+		} else {
+			msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
+			msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
+			msg[2] = msg[3] | 1; /* enable msg queue int */
+			if (smb_smbus_write_block_data(
+			    smb_info,3, msg) == 0) {
+				smb_info->smb_state = SMB_ENABLE_INTERRUPTS2;
+			} else
+				smb_info->smb_state = SMB_NORMAL;
+		}
+		break;
+	}
+
+	case SMB_ENABLE_INTERRUPTS2:
+	{
+		unsigned char msg[4];
+
+		/* We got the flags from the SMB, now handle them. */
+		len = smb_smbus_read_block_data(smb_info, msg);
+		if (len < 0 || msg[2] != 0) {
+			printk(KERN_WARNING
+			       "ipmi_smb: Could not enable interrupts"
+			       ", failed set, using polled mode.\n");
+		}
+		smb_info->smb_state = SMB_NORMAL;
+		break;
+	}
+	}
+	if (smb_info->smb_debug & SMB_DEBUG_STATE) {
+		printk(KERN_INFO "DONE 2: state = %d.\n", smb_info->smb_state);
+	}
+}
+
+/*
+ * smb_event_handler must have a user context for calls to lm_sensors'
+ * SMBus interface
+ */
+static void smb_event_handler(struct smb_info *smb_info)
+{
+	s32 rv;
+	if (smb_info->smb_debug & SMB_DEBUG_STATE) {
+		printk(KERN_INFO "smb_event_handler: state = %d.\n",
+		       smb_info->smb_state);
+	}
+	if (smb_info->smb_state == SMB_NORMAL) {
+		if (smb_info->curr_msg != NULL)
+		{
+			handle_transaction_done(smb_info);
+		} else {
+			/* If we are currently idle, try to start the
+			 * next message. */
+			send_next_msg(smb_info);
+		}
+	} else {
+		handle_transaction_done(smb_info);
+	}
+
+	if (smb_info->smb_state == SMB_NORMAL &&
+	    smb_info->curr_msg == NULL &&
+	     atomic_read(&smb_info->req_events))
+	{
+		/* We are idle and the upper layer requested that I fetch
+		   events, so do so. */
+		unsigned char msg[2];
+
+		atomic_set(&smb_info->req_events, 0);
+		msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
+		msg[1] = IPMI_GET_MSG_FLAGS_CMD;
+
+		rv = smb_smbus_write_block_data(smb_info, 2, msg);
+		if(rv == 0) {
+			smb_info->smb_state = SMB_GETTING_FLAGS;
+		}
+	}
+}
+
+#ifdef REGISTER_SMI
+static void sender(void                *send_info,
+		   struct ipmi_smi_msg *msg,
+		   int                 priority)
+{
+	struct smb_info *smb_info = (struct smb_info *) send_info;
+
+#ifdef CONFIG_IPMI_PANIC_EVENT
+	if (smb_info->run_to_completion) {
+		/* If we are running to completion, then throw it in
+		   the list and run transactions until everything is
+		   clear.  Priority doesn't matter here. */
+		list_add_tail(&(msg->link), &(smb_info->xmit_msgs));
+
+		smb_event_handler(smb_info);
+		while  (! SMB_IDLE(smb_info)) {
+			smb_event_handler(smb_info);
+		}
+		return;
+	}
+#endif
+	if (smb_info->smb_debug & SMB_DEBUG_TIMING) {
+		struct timeval     t;
+		do_gettimeofday(&t);
+		printk(KERN_INFO
+		       "**Enqueue %02x %02x: %ld.%6.6ld\n",
+		       msg->data[0], msg->data[1], t.tv_sec, t.tv_usec);
+	}
+
+	spin_lock(&(smb_info->msg_lock));
+	if (priority > 0) {
+		list_add_tail(&(msg->link), &(smb_info->hp_xmit_msgs));
+	} else {
+		list_add_tail(&(msg->link), &(smb_info->xmit_msgs));
+	}
+	spin_unlock(&(smb_info->msg_lock));
+
+#ifdef SMB_KTHREAD
+	wake_up_interruptible(&smb_info->smb_thread.queue);
+#endif
+}
+
+static void request_events(void *send_info)
+{
+	struct smb_info *smb_info = (struct smb_info *) send_info;
+
+	atomic_set(&smb_info->req_events, 1);
+#ifdef SMB_KTHREAD
+	wake_up_interruptible(&smb_info->smb_thread.queue);
+#endif
+}
+
+static void set_run_to_completion(void *send_info, int i_run_to_completion)
+{
+#ifdef CONFIG_IPMI_PANIC_EVENT
+	struct smb_info *smb_info = (struct smb_info *) send_info;
+
+	smb_info->run_to_completion = i_run_to_completion;
+	/* Note that if this does not compile, there are some I2C
+	   changes that you need to handle this properly. */
+	i2c_set_spin_delay(i_run_to_completion);
+	if (i_run_to_completion) {
+		smb_event_handler(smb_info);
+		while  (! SMB_IDLE(smb_info)) {
+			smb_event_handler(smb_info);
+		}
+	}
+#endif
+}
+
+static struct ipmi_smi_handlers handlers =
+{
+	.owner                 = THIS_MODULE,
+	.sender		       = sender,
+	.request_events        = request_events,
+	.set_run_to_completion = set_run_to_completion
+};
+#endif	/* REGISTER_SMI */
+
+#ifdef SMB_KTHREAD
+/* initialize new created thread. Called by the new thread. */
+static void init_kthread(kthread_t *kthread, char *name)
+{
+        /* lock the kernel. A new kernel thread starts without
+           the big kernel lock, regardless of the lock state
+           of the creator (the lock level is *not* inheritated)
+        */
+        lock_kernel();
+
+        /* fill in thread structure */
+        kthread->thread = current;
+
+        /* set signal mask to what we want to respond */
+        siginitsetinv(&current->blocked,
+		      sigmask(SIGKILL)|sigmask(SIGINT)|sigmask(SIGTERM));
+
+        /* initialise wait queue */
+        init_waitqueue_head(&kthread->queue);
+
+        /* initialise termination flag */
+        kthread->terminate = 0;
+
+        /* set name of this process (max 15 chars + 0 !) */
+        sprintf(current->comm, name);
+
+        /* let others run */
+        unlock_kernel();
+
+        /* tell the creator that we are ready and let him continue */
+        up(&kthread->startstop_sem);
+
+}
+
+/* cleanup of thread. Called by the exiting thread. */
+static void exit_kthread(kthread_t *kthread)
+{
+        /* we are terminating */
+
+	/* lock the kernel, the exit will unlock it */
+        lock_kernel();
+        kthread->thread = NULL;
+        mb();
+
+        /* notify the stop_kthread() routine that we are terminating. */
+	up(&kthread->startstop_sem);
+	/* the kernel_thread that called clone() does a do_exit here. */
+
+	/* there is no race here between execution of the "killer" and
+	   real termination of the thread (race window between up and
+	   do_exit), since both the thread and the "killer" function
+	   are running with the kernel lock held.  The kernel lock
+	   will be freed after the thread exited, so the code is
+	   really not executed anymore as soon as the unload functions
+	   gets the kernel lock back.  The init process may not have
+	   made the cleanup of the process here, but the cleanup can
+	   be done safely with the module unloaded.
+ 	*/
+
+}
+
+/* this is the thread function for making SMBus function calls into
+ * the lm_sensors' i2c-core module */
+static int smb_thread(void *data)
+{
+	struct smb_info *smb_info = data;
+        kthread_t *kthread = &smb_info->smb_thread;
+	/* setup the thread environment */
+        init_kthread(kthread, "IPMI SMBus thread");
+
+        /* an endless loop in which we are doing our work */
+        for(;;)
+        {
+ 		smb_event_handler(smb_info);
+		while  (! SMB_IDLE(smb_info)) {
+			smb_event_handler(smb_info);
+		}
+
+                interruptible_sleep_on(&kthread->queue);
+		if (! send_next_msg(smb_info)) {
+			interruptible_sleep_on(&kthread->queue);
+		}
+
+                /* We need to do a memory barrier here to be sure that
+                   the flags are visible on all CPUs.
+                */
+                 mb();
+
+                /* here we are back from sleep, either due to the timeout
+                   (one second), or because we caught a signal.
+                */
+                if (kthread->terminate)
+                {
+                        /* we received a request to terminate ourself */
+                        break;
+                }
+         }
+
+        /* cleanup the thread, leave */
+        exit_kthread(kthread);
+
+	/* returning from the thread here calls the exit functions */
+	return 0;
+}
+
+/* create a new kernel thread. Called by the creator. */
+static void start_kthread(struct smb_info *smb_info)
+{
+       kthread_t *kthread = &smb_info->smb_thread;
+        /* initialize the semaphore:
+           we start with the semaphore locked. The new kernel
+           thread will setup its stuff and unlock it. This
+           control flow (the one that creates the thread) blocks
+           in the down operation below until the thread has reached
+           the up() operation.
+         */
+        init_MUTEX_LOCKED(&kthread->startstop_sem);
+
+        kernel_thread(smb_thread, smb_info, 0);
+
+        /* wait till it has reached the setup_thread routine */
+        down(&kthread->startstop_sem);
+
+}
+
+/* stop a kernel thread. Called by the removing instance */
+static void stop_kthread(kthread_t *kthread)
+{
+        if (kthread->thread == NULL)
+        {
+                printk(KERN_WARNING
+		       "stop_kthread: killing non existing thread!\n");
+                return;
+        }
+
+        /* this function needs to be protected with the big
+	   kernel lock (lock_kernel()). The lock must be
+           grabbed before changing the terminate
+	   flag and released after the down() call. */
+        lock_kernel();
+
+        /* initialize the semaphore. We lock it here, the
+           leave_thread call of the thread to be terminated
+           will unlock it. As soon as we see the semaphore
+           unlocked, we know that the thread has exited.
+	*/
+        init_MUTEX_LOCKED(&kthread->startstop_sem);
+
+        /* We need to do a memory barrier here to be sure that
+           the flags are visible on all CPUs.
+        */
+        mb();
+
+        /* set flag to request thread termination */
+        kthread->terminate = 1;
+	wake_up_interruptible(&kthread->queue);
+
+        /* We need to do a memory barrier here to be sure that
+           the flags are visible on all CPUs.
+        */
+        mb();
+        kill_proc(kthread->thread->pid, SIGKILL, 1);
+
+        /* block till thread terminated */
+        down(&kthread->startstop_sem);
+
+        /* release the big kernel lock */
+        unlock_kernel();
+
+        /* now we are sure the thread is in zombie state. We
+           notify keventd to clean the process up.
+        */
+        kill_proc(2, SIGCHLD, 1);
+
+}
+#endif
+
+static int ipmi_smb_detect_hardware(struct i2c_client *client, int debug,
+				    struct smb_info **smb_info)
+{
+	unsigned char   msg[2];
+	unsigned char   resp[IPMI_MAX_MSG_LENGTH];
+	unsigned long   resp_len;
+	s32             ret;
+	struct smb_info *info;
+
+	/* Do a Get Device ID command, since it comes back with some
+	   useful info. */
+	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
+	msg[1] = IPMI_GET_DEVICE_ID_CMD;
+
+	ret = smbus_client_write_block_data(client, debug, 2, msg);
+	if (ret)
+		return -ENODEV;
+
+	/* Otherwise, we got some data. */
+	resp_len = smbus_client_read_block_data(client, debug, resp);
+	if (resp_len < 6)
+		/* That's odd, it should be longer. */
+		return -EINVAL;
+
+	if ((resp[1] != IPMI_GET_DEVICE_ID_CMD) || (resp[2] != 0))
+		/* That's odd, it shouldn't be able to fail. */
+		return -EINVAL;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	memset(info, 0, sizeof(*info));
+
+	info->ipmi_smb_dev_rev = resp[4] & 0xf;
+	info->ipmi_smb_fw_rev_major = resp[5] & 0x7f;
+	info->ipmi_smb_fw_rev_minor = resp[6];
+	info->ipmi_version_major = resp[7] & 0xf;
+	info->ipmi_version_minor = resp[7] >> 4;
+	info->client = *client;
+	i2c_set_clientdata(&info->client, info);
+	info->smb_debug = debug;
+
+	*smb_info = info;
+
+	return 0;
+}
+
+#define MAX_SMB_BMCS 4
+/* no expressions allowed in __MODULE_STRING */
+#define MAX_SMB_ADDR_PAIRS	8
+
+/* An array of SMB interfaces. */
+static struct smb_info *smb_infos[MAX_SMB_BMCS];
+
+/*
+ * An array of pairs of numbers to specify where specific BMCs exist.
+ * Each pair specifies the adapter number and address on the adapter.
+ * A BMC will be forced at that position.
+ *
+ * Always provide the i2c address if it is known.
+ */
+/* force list has 3 entries - 0:bus/adapter no 1: i2c addr 2: unknown/unused */
+#define	FORCE_LIST_ENTRIES	3
+static unsigned short __initdata smb_addr[MAX_SMB_BMCS*2];
+static unsigned short smb_force_list[MAX_SMB_BMCS*FORCE_LIST_ENTRIES + FORCE_LIST_ENTRIES];
+
+MODULE_PARM(smb_addr, "1-"__MODULE_STRING(MAX_SMB_ADDR_PAIRS)"h");
+
+/*
+ * If this is sent, don't probe for adapters anywhere but where the
+ * smb_addr array gives.
+ */
+static int smb_defaultprobe = 1;
+MODULE_PARM(smb_defaultprobe, "i");
+
+/*
+ * Turn debugging on for specific BMCs.  This array is indexed by
+ * BMC number.
+ *
+ * Debug bit flags: IPMI messages: 1, driver state: 2, msg timing: 4
+ */
+static int smb_dbg[MAX_SMB_BMCS];
+MODULE_PARM(smb_dbg, "1-"__MODULE_STRING(MAX_SMB_BMCS)"i");
+
+/*
+ * Debug the probing of adapters.
+ */
+static int smb_dbg_probe = 0;
+MODULE_PARM(smb_dbg_probe, "i");
+
+#define SMB_I2C_START_ADDR	0x20
+#define SMB_I2C_END_ADDR	0x4f
+static unsigned short normal_i2c[] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { SMB_I2C_START_ADDR,
+					     SMB_I2C_END_ADDR,
+					     I2C_CLIENT_END };
+/*
+static unsigned int normal_isa[] = { SENSORS_ISA_END };
+static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+*/
+static unsigned short reserved[] =
+{
+/* As defined by SMBus Spec. Appendix C */
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x28,
+	0x37,
+/* As defined by SMBus Spec. Sect. 5.2 */
+	0x01, 0x02, 0x03, 0x04, 0x05,
+	0x06, 0x07, 0x78, 0x79, 0x7a, 0x7b,
+	0x7c, 0x7d, 0x7e, 0x7f,
+/* Common PC addresses (bad idea) */
+	0x2d, 0x48, 0x49, /* sensors */
+	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* eeproms */
+	0x69, /* clock chips */
+
+	I2C_CLIENT_END
+};
+
+static unsigned short smb_empty_list[] = { I2C_CLIENT_END, I2C_CLIENT_END };
+
+static struct i2c_client_address_data smb_address_data = {
+	.normal_i2c 		= normal_i2c,
+	.normal_i2c_range	= normal_i2c_range,
+	.probe			= smb_empty_list,
+	.probe_range		= smb_empty_list,
+	.ignore			= reserved,
+	.ignore_range		= smb_empty_list,
+	.force			= smb_force_list,
+};
+
+static unsigned int pos_reserved_as(int pos)
+{
+	if (smb_addr[pos*2+1] != 0)
+		return (smb_addr[pos*2] << 16) | smb_addr[pos*2+1];
+
+	return 0;
+}
+
+static int smb_found_addr_proc(struct i2c_adapter *adapter, int addr, int kind)
+{
+	int id = i2c_adapter_id(adapter);
+	int debug = smb_dbg[id];
+	int rv;
+	int i;
+	int next_pos;
+	struct i2c_client client;
+	struct smb_info *smb_info;
+
+	if( id >= MAX_SMB_BMCS )
+		return 0;
+	memset(&client, 0, sizeof(&client));
+	strcpy(client.name, "IPMI");
+	client.addr = addr;
+	client.adapter = adapter;
+
+	rv = ipmi_smb_detect_hardware(&client, debug, &smb_info);
+	if (rv) {
+		if (smb_dbg_probe) {
+			printk(KERN_INFO
+			       "smb_found_addr_proc:No IPMI client 0x%x: %d\n",
+			       addr, rv);
+		}
+		return 0;
+	}
+
+	if (smb_dbg_probe) {
+		printk(KERN_INFO
+		       "smb_found_addr_proc: i2c_probe found device at"
+		       " i2c address %x\n", addr);
+	}
+
+	spin_lock_init(&(smb_info->msg_lock));
+	INIT_LIST_HEAD(&(smb_info->xmit_msgs));
+	INIT_LIST_HEAD(&(smb_info->hp_xmit_msgs));
+	smb_info->curr_msg = NULL;
+	atomic_set(&smb_info->req_events, 0);
+#ifdef CONFIG_IPMI_PANIC_EVENT
+	smb_info->run_to_completion = 0;
+#endif
+	smb_info->smb_state = SMB_NORMAL;
+
+	next_pos = -1;
+	for (i=0; i < MAX_SMB_BMCS; i++) {
+		unsigned int res = pos_reserved_as(i);
+
+		if (res == ((id << 16) | addr)) {
+			/* We have a reserved position, use it. */
+			next_pos = i;
+			break;
+		}
+
+		/* Claim the first unused position */
+		if (!res && (next_pos == -1) && (smb_infos[next_pos] == NULL))
+			next_pos = i;
+	}
+	if (next_pos == -1) {
+		rv = -EBUSY;
+		goto out_err;
+	}
+
+	rv = i2c_attach_client(&smb_info->client);
+	if (rv) {
+		printk(KERN_ERR
+		       "smb_found_one_addr_proc:"
+		       " Unable to attach i2c client: error %d\n",
+		       rv);
+		goto out_err;
+	}
+
+	smb_info->pos = next_pos;
+	smb_infos[next_pos] = smb_info;
+
+#ifdef SMB_KTHREAD
+	start_kthread(smb_info);
+#endif
+
+#ifdef REGISTER_SMI
+	rv = ipmi_register_smi(&handlers,
+			       smb_info,
+			       smb_info->ipmi_version_major,
+			       smb_info->ipmi_version_minor,
+			       &(smb_info->intf));
+	if (rv) {
+		i2c_detach_client(&smb_info->client);
+		smb_infos[next_pos] = NULL;
+		printk(KERN_ERR
+		       "ipmi_smb: Unable to register device: error %d\n",
+		       rv);
+		goto out_err;
+	}
+#endif
+
+	start_clear_flags(smb_info);
+	smb_event_handler(smb_info);
+
+	return addr;
+
+ out_err:
+	kfree(smb_info);
+	return 0;
+}
+
+static int attach_adapter(struct i2c_adapter *adapter)
+{
+	int id = i2c_adapter_id(adapter);
+
+	if (smb_dbg_probe) {
+		printk(KERN_INFO "init_one_smb: Checking SMBus adapter %d:"
+		       " %s\n", id, adapter->name);
+	}
+	if ((i2c_get_functionality(adapter) & (I2C_FUNC_SMBUS_BLOCK_DATA))
+	    == (I2C_FUNC_SMBUS_BLOCK_DATA))
+	{
+		if (smb_dbg_probe) {
+			printk(KERN_INFO "init_one_smb: found SMBus adapter:"
+			       " %s\n", adapter->name);
+		}
+		i2c_probe(adapter, &smb_address_data, smb_found_addr_proc);
+	}
+
+	return 0;
+}
+
+void cleanup_one_smb(struct smb_info *to_clean)
+{
+	int rv;
+
+	if (! to_clean)
+		return;
+
+#ifdef SMB_KTHREAD
+	stop_kthread(&to_clean->smb_thread);
+#endif
+
+#ifdef REGISTER_SMI
+	rv = ipmi_unregister_smi(to_clean->intf);
+	if (rv) {
+		printk(KERN_ERR
+		       "ipmi_smb: Unable to unregister device: errno=%d\n",
+		       rv);
+	}
+#endif
+
+	rv = i2c_detach_client(&to_clean->client);
+	if (rv) {
+		printk(KERN_ERR
+		       "ipmi_smb: Unable to detach SMBUS client: errno=%d\n",
+		       rv);
+	}
+
+	smb_infos[to_clean->pos] = NULL;
+	kfree(to_clean);
+}
+
+static int detach_client(struct i2c_client *client)
+{
+	struct smb_info *smb_info = i2c_get_clientdata(client);
+
+	cleanup_one_smb(smb_info);
+
+	return(0);
+}
+
+static struct i2c_driver smb_i2c_driver =
+{
+	.name = "IPMI",
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = attach_adapter,
+	.detach_client = detach_client,
+	.command = NULL,
+};
+
+static __init int init_ipmi_smb(void)
+{
+	int i;
+	int rv;
+
+	if (initialized)
+		return 0;
+
+	printk(KERN_INFO "IPMI SMB Interface driver version "
+	       IPMI_SMB_VERSION "\n");
+
+	/* build force list from smb_addr list */
+	for (i=0; i<MAX_SMB_BMCS; i++) {
+		if (smb_addr[i*2+1] == 0)
+			break;
+		smb_force_list[i*FORCE_LIST_ENTRIES] = smb_addr[i*2];
+		smb_force_list[i*FORCE_LIST_ENTRIES+1] = smb_addr[i*2+1];
+	}
+	smb_force_list[i*FORCE_LIST_ENTRIES] = I2C_CLIENT_END;
+	smb_force_list[i*FORCE_LIST_ENTRIES+1] = I2C_CLIENT_END;
+
+	/* If the default probing is turned off, then disable the
+	 * range scanning. */
+	if (!smb_defaultprobe)
+		normal_i2c_range[0] = I2C_CLIENT_END;
+
+	rv = i2c_add_driver(&smb_i2c_driver);
+	if (!rv)
+		initialized = 1;
+
+	return rv;
+}
+module_init(init_ipmi_smb);
+
+#ifdef MODULE
+static __exit void cleanup_ipmi_smb(void)
+{
+	int i;
+	int rv;
+
+	if (!initialized)
+		return;
+
+	for (i=0; i<MAX_SMB_BMCS; i++) {
+		cleanup_one_smb(smb_infos[i]);
+	}
+
+	initialized = 0;
+
+	rv = i2c_del_driver(&smb_i2c_driver);
+	if (!rv)
+		initialized = 0;
+}
+module_exit(cleanup_ipmi_smb);
+#else
+
+/* [<adapter>.]addr[:debug]  Force a BMC at the given address on the
+			given adapter (or adapter 0 if not given).  If
+			the debug portion is given, this this is the
+			debug bits as explained in the definition of
+			smb_dbg above.
+   nodefaults		Suppress trying the default address range
+   debug_probe		Debug probing of adapters
+
+   For example, to pass one IO port with an IRQ, one address, and
+   suppress the use of the default IO port and ACPI address,
+   use this option string: ipmi_kcs=p0xCA2:5,m0xFF5B0022,nodefaults
+
+   Remember, ipmi_smb_setup() is passed the string after the equal sign. */
+
+static int __init ipmi_smb_setup(char *str)
+{
+	unsigned long val;
+	char *cur, *sep;
+	int pos;
+
+	pos = 0;
+
+	cur = strsep(&str, ",");
+	while ((cur) && (*cur) && (pos < MAX_SMB_BMCS)) {
+		if (strcmp(cur, "nodefaults") == 0) {
+			smb_defaultprobe = 0;
+			goto next_parm;
+		}
+		if (strcmp(cur, "debug_probe") == 0) {
+			smb_dbg_probe = 1;
+			goto next_parm;
+		}
+		val = simple_strtoul(cur,
+				     &sep,
+				     0);
+		if (*sep == '.') {
+			smb_addr[pos*2] = val;
+			val = simple_strtoul(sep + 1,
+					     &sep,
+					     0);
+		} else
+			smb_addr[pos*2] = 0;
+
+		smb_addr[pos*2+1] = val;
+
+		if (*sep == ':') {
+			val = simple_strtoul(sep + 1,
+					     &sep,
+					     0);
+			smb_dbg[pos] = val;
+		}
+		pos++;
+	next_parm:
+		cur = strsep(&str, ",");
+	}
+	return 1;
+}
+__setup("ipmi_smb=", ipmi_smb_setup);
+#endif
+
+MODULE_AUTHOR("Todd C Davis <todd.c.davis@intel.com>");
+MODULE_DESCRIPTION("IPMI system interface driver for management controllers on a SMBus");
+MODULE_LICENSE("GPL");
diff -urN linux-a2/drivers/char/ipmi/Kconfig linux-a3/drivers/char/ipmi/Kconfig
--- linux-a2/drivers/char/ipmi/Kconfig	2004-02-23 08:27:14.000000000 -0600
+++ linux-a3/drivers/char/ipmi/Kconfig	2004-02-23 08:29:22.000000000 -0600
@@ -58,6 +58,17 @@
          Provides a driver for a KCS-style interface to a BMC.  This
          is deprecated, please use the IPMI System Interface handler
 	 instead.
+       
+config IPMI_SMB
+       tristate 'IPMI SMBus handler'
+       depends on IPMI_HANDLER && I2C
+       help
+         Provides a driver for a SMBus interface to a BMC, meaning that you
+	 have a driver that must be accessed over an I2C bus instead of a
+	 standard interface.  This module requires I2C support.  Note that
+	 you might need some I2C changes if CONFIG_IPMI_PANIC_EVENT is
+	 enabled along with this, so the I2C driver knows to run to
+	 completion during sending a panic event.
 
 config IPMI_WATCHDOG
        tristate 'IPMI Watchdog Timer'
diff -urN linux-a2/drivers/char/ipmi/Makefile linux-a3/drivers/char/ipmi/Makefile
--- linux-a2/drivers/char/ipmi/Makefile	2004-02-23 08:27:14.000000000 -0600
+++ linux-a3/drivers/char/ipmi/Makefile	2004-02-23 08:29:22.000000000 -0600
@@ -9,6 +9,7 @@
 obj-$(CONFIG_IPMI_DEVICE_INTERFACE) += ipmi_devintf.o
 obj-$(CONFIG_IPMI_SI) += ipmi_si_drv.o
 obj-$(CONFIG_IPMI_KCS) += ipmi_kcs_drv.o
+obj-$(CONFIG_IPMI_SMB) += ipmi_smb_intf.o
 obj-$(CONFIG_IPMI_WATCHDOG) += ipmi_watchdog.o
 
 ipmi_kcs_drv.o:	$(ipmi_kcs_drv-objs)

--------------040908030806040600050803--

