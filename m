Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVBAWn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVBAWn7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVBAWn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:43:59 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:11229 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262142AbVBAWd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:33:26 -0500
Message-ID: <420003B3.3010606@acm.org>
Date: Tue, 01 Feb 2005 16:33:23 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Add the IPMI SMBus driver
Content-Type: multipart/mixed;
 boundary="------------090705070807070103070303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090705070807070103070303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The IPMI SMBus driver has long been languishing because I needed some 
changes to the I2C code to make it work right.  I've posted those 
changes.  This driver uses them.

--------------090705070807070103070303
Content-Type: text/plain;
 name="ipmi_smb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_smb.diff"

This patch adds the SMBus interface to the IPMI driver.
It is a rework of the previous driver, which was lacking
functions because it needed an async interface to the I2C
code.  Thus, this depends on the async I2C interface
patches.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc2/drivers/char/ipmi/ipmi_smb.c
===================================================================
--- /dev/null
+++ linux-2.6.11-rc2/drivers/char/ipmi/ipmi_smb.c
@@ -0,0 +1,1572 @@
+/*
+ * ipmi_smb.c
+ *
+ * The interface to the IPMI driver for SMBus access to a SMBus
+ * compliant device.
+ *
+ * Author: Intel Corporation
+ *         Todd Davis <todd.c.davis@intel.com>
+ *
+ * Rewritten by Corey Minyard <minyard@acm.org> to support the
+ * non-blocking I2C interface, add support for multi-part
+ * transactions, add PEC support, and general clenaup.
+ *
+ * Copyright 2003 Intel Corporation
+ * Copyright 2005 MontaVista Software
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
+/*
+ * TODO: Figure out how to use SMB alerts.  This will require a new
+ * interface into the I2C driver, I believe.
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#if defined(MODVERSIONS)
+#include <linux/modversions.h>
+#endif
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
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
+#include <asm/io.h>
+
+
+#define IPMI_SMB_VERSION "v33"
+
+#define IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD	0x57
+
+#define	SMB_IPMI_REQUEST			2
+#define	SMB_IPMI_MULTI_PART_REQUEST_START	6
+#define	SMB_IPMI_MULTI_PART_REQUEST_MIDDLE	7
+#define	SMB_IPMI_RESPONSE			3
+#define	SMB_IPMI_MULTI_PART_RESPONSE_MIDDLE	9
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
+	SMB_GETTING_MESSAGES,
+	/* FIXME - add watchdog stuff. */
+};
+
+#define SMB_IDLE(smb)	 ((smb)->smb_state == SMB_NORMAL \
+			  && (smb)->curr_msg == NULL)
+
+/* How many times to we retry the message. */
+#define	SMB_MSG_RETRIES	24
+
+/* At what retry interval to we try to rewrite the command. */
+#define SMB_MSG_RETRY_WRITE_COUNT 8
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
+	int                 req_events;
+
+	/* If true, run the state machine to completion on every send
+	   call.  Generally used after a panic or shutdown to make
+	   sure stuff goes out. */
+	int                 run_to_completion;
+
+	/* Used for sending/receiving data.  +1 for the length. */
+	unsigned char data[IPMI_MAX_MSG_LENGTH + 1];
+	unsigned int  data_len;
+
+	/* Temp receive buffer, gets copied into data. */
+	unsigned char recv[I2C_SMBUS_BLOCK_MAX];
+
+	struct i2c_client client;
+	struct i2c_op_q_entry i2c_q_entry;
+	unsigned char ipmi_smb_dev_rev;
+	unsigned char ipmi_smb_fw_rev_major;
+	unsigned char ipmi_smb_fw_rev_minor;
+	unsigned char ipmi_version_major;
+	unsigned char ipmi_version_minor;
+
+	/* Is the driver trying to stop? */
+	int stopping;
+
+	/* Is the driver running a command? */
+	int running;
+
+	struct timer_list retry_timer;
+	int retries_left;
+
+	/* Info from SSIF cmd */
+	unsigned char max_xmit_msg_size;
+	unsigned char max_recv_msg_size;
+	unsigned int  multi_support;
+	int           supports_pec;
+
+#define SMB_NO_MULTI		0
+#define SMB_MULTI_2_PART	1
+#define SMB_MULTI_n_PART	2
+	unsigned char *multi_data;
+	unsigned int  multi_len;
+	unsigned int  multi_pos;
+};
+
+static int initialized = 0;
+static int smb_dbg_probe = 0;
+
+static void return_hosed_msg(struct smb_info *smb_info,
+			     struct ipmi_smi_msg *msg);
+static void start_next_msg(struct smb_info *smb_info, unsigned long *flags);
+static int start_send(struct smb_info *smb_info,
+		      unsigned char   *data,
+		      unsigned int    len);
+
+
+static void deliver_recv_msg(struct smb_info *smb_info,
+			     struct ipmi_smi_msg *msg)
+{
+	if (msg->rsp_size < 0) {
+		return_hosed_msg(smb_info, msg);
+		printk(KERN_ERR
+		       "malformed message in deliver_recv_msg:"
+		       " rsp_size = %d\n", msg->rsp_size);
+		ipmi_free_smi_msg(msg);
+	} else {
+		ipmi_smi_msg_received(smb_info->intf, msg);
+	}
+}
+
+static void return_hosed_msg(struct smb_info *smb_info,
+			     struct ipmi_smi_msg *msg)
+{
+	/* Make it a reponse */
+	msg->rsp[0] = msg->data[0] | 4;
+	msg->rsp[1] = msg->data[1];
+	msg->rsp[2] = 0xFF; /* Unknown error. */
+	msg->rsp_size = 3;
+
+	deliver_recv_msg(smb_info, msg);
+}
+
+/*
+ * Must be called with the message lock held.  This will release the
+ * message lock.  Note that the caller will check SMB_IDLE and start a
+ * new operation, so there is no need to check for new messages to
+ * start in here.
+ */
+static void start_clear_flags(struct smb_info *smb_info, unsigned long *flags)
+{
+	unsigned char *msg = smb_info->data;
+
+	smb_info->smb_state = SMB_CLEARING_FLAGS;
+	smb_info->running = 1;
+	spin_unlock_irqrestore(&smb_info->msg_lock, *flags);
+
+	/* Make sure the watchdog pre-timeout flag is not set at startup. */
+	msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
+	msg[1] = IPMI_CLEAR_MSG_FLAGS_CMD;
+	msg[2] = WDT_PRE_TIMEOUT_INT;
+
+	if (start_send(smb_info, msg, 3) != 0) {
+		/* Error, just go to normal state. */
+		smb_info->smb_state = SMB_NORMAL;
+		smb_info->running = 0;
+	}
+}
+
+/*
+ * Must be called with the message lock held.  This will release the
+ * message lock.  Note that the caller will check SMB_IDLE and start a
+ * new operation, so there is no need to check for new messages to
+ * start in here.
+ */
+static void handle_flags(struct smb_info *smb_info, unsigned long *flags)
+{
+	if (smb_info->msg_flags & WDT_PRE_TIMEOUT_INT) {
+		/* Watchdog pre-timeout */
+		smb_info->msg_flags &= ~WDT_PRE_TIMEOUT_INT;
+		start_clear_flags(smb_info, flags);
+		ipmi_smi_watchdog_pretimeout(smb_info->intf);
+	} else if (smb_info->msg_flags & RECEIVE_MSG_AVAIL) {
+		/* Messages available. */
+		struct ipmi_smi_msg *msg;
+
+		msg = ipmi_alloc_smi_msg();
+		if (!msg) {
+			smb_info->smb_state = SMB_NORMAL;
+			smb_info->running = 0;
+			spin_unlock_irqrestore(&smb_info->msg_lock, *flags);
+			return;
+		}
+
+		smb_info->curr_msg = msg;
+		smb_info->smb_state = SMB_GETTING_MESSAGES;
+		smb_info->running = 1;
+		spin_unlock_irqrestore(&smb_info->msg_lock, *flags);
+
+		msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
+		msg->data[1] = IPMI_GET_MSG_CMD;
+		msg->data_size = 2;
+
+		if (start_send(smb_info, msg->data, msg->data_size) != 0) {
+			spin_lock_irqsave(&smb_info->msg_lock, *flags);
+			smb_info->curr_msg = NULL;
+			smb_info->smb_state = SMB_NORMAL;
+			smb_info->running = 0;
+			spin_unlock_irqrestore(&smb_info->msg_lock, *flags);
+			ipmi_free_smi_msg(msg);
+		}
+	} else if (smb_info->msg_flags & EVENT_MSG_BUFFER_FULL) {
+		/* Events available. */
+		struct ipmi_smi_msg *msg = ipmi_alloc_smi_msg();
+		if (!msg) {
+			smb_info->smb_state = SMB_NORMAL;
+			smb_info->running = 0;
+			return;
+		}
+
+		smb_info->curr_msg = msg;
+		smb_info->smb_state = SMB_GETTING_EVENTS;
+		smb_info->running = 1;
+		spin_unlock_irqrestore(&smb_info->msg_lock, *flags);
+
+		msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
+		msg->data[1] = IPMI_READ_EVENT_MSG_BUFFER_CMD;
+		msg->data_size = 2;
+
+		if (start_send(smb_info, msg->data, msg->data_size) != 0) {
+			spin_lock_irqsave(&smb_info->msg_lock, *flags);
+			smb_info->curr_msg = NULL;
+			smb_info->smb_state = SMB_NORMAL;
+			smb_info->running = 0;
+			spin_unlock_irqrestore(&smb_info->msg_lock, *flags);
+			ipmi_free_smi_msg(msg);
+		}
+	} else {
+		smb_info->smb_state = SMB_NORMAL;
+		smb_info->running = 0;
+		spin_unlock_irqrestore(&smb_info->msg_lock, *flags);
+	}
+}
+
+static void msg_done_handler(struct i2c_op_q_entry *i2ce);
+static void retry_timeout(unsigned long data)
+{
+        struct smb_info     *smb_info = (void *) data;
+        struct i2c_op_q_entry *i2ce;
+
+        i2ce = &smb_info->i2c_q_entry;
+        i2ce->xfer_type = I2C_OP_SMBUS;
+        i2ce->handler = msg_done_handler;
+        i2ce->handler_data = smb_info;
+        i2ce->smbus.read_write = I2C_SMBUS_READ;
+        i2ce->smbus.command = SMB_IPMI_RESPONSE;
+        i2ce->smbus.data = (union i2c_smbus_data *) smb_info->recv;
+        i2ce->smbus.size = I2C_SMBUS_BLOCK_DATA;
+
+        if (i2c_non_blocking_op(&smb_info->client, i2ce)) {
+                /* request failed, just return the error. */
+                if (smb_info->smb_debug & SMB_DEBUG_MSG) {
+                        printk(KERN_INFO
+                               "Error from i2c_non_blocking_op(5)\n");
+                }
+                i2ce->result = -EIO;
+                msg_done_handler(i2ce);
+        }
+}
+
+static int start_resend(struct smb_info *smb_info);
+static void msg_done_handler(struct i2c_op_q_entry *i2ce)
+{
+	struct smb_info     *smb_info = i2ce->handler_data;
+	unsigned char       *data = smb_info->recv;
+	int                 len;
+	int                 result = i2ce->result;
+	struct ipmi_smi_msg *msg;
+	unsigned long       flags;
+
+	if (smb_info->stopping) {
+		smb_info->running = 0;
+		return;
+	}
+		
+	/* We are single-threaded here, so no need for a lock until we
+	   start messing with driver states or the queues. */
+
+	if (result < 0) {
+		smb_info->retries_left--;
+		if (smb_info->retries_left > 0) {
+			if ((smb_info->retries_left
+			     % SMB_MSG_RETRY_WRITE_COUNT) == 0)
+			{
+                                /* Every once in a while re-request the
+                                   write. */
+				if (! start_resend(smb_info))
+					return;
+				/* If start_resend fails, just restart
+				   the timer. */
+			}
+			struct timer_list *t = &smb_info->retry_timer;
+			t->expires = jiffies + 10;
+			t->data = (unsigned long) smb_info;
+			t->function = retry_timeout;
+			add_timer(t);
+			return;
+		}
+		if  (smb_info->smb_debug & SMB_DEBUG_MSG)
+			printk(KERN_INFO
+			       "Error in msg_done_handler: %d\n", i2ce->result);
+		len = 0;
+		goto continue_op;
+	}
+
+	len = data[0]; /* Number of bytes *after* data[0]. */
+	data++;
+	if ((len > 1) && (smb_info->multi_pos == 0)
+		 && (data[0] == 0x00) && (data[1] == 0x01))
+	{
+		/* Start of multi-part read.  Start the next transaction. */
+		int i;
+
+		/* Remove the multi-part read marker. */
+		for (i=0; i<len-2; i++)
+			smb_info->data[i] = data[i+2];
+		len -= 2;
+		smb_info->multi_len = len;
+		smb_info->multi_pos = 1;
+
+		i2ce->xfer_type = I2C_OP_SMBUS;
+		i2ce->handler = msg_done_handler;
+		i2ce->handler_data = smb_info;
+		i2ce->smbus.read_write = I2C_SMBUS_READ;
+		i2ce->smbus.command = SMB_IPMI_MULTI_PART_RESPONSE_MIDDLE;
+		i2ce->smbus.data = ((union i2c_smbus_data *) smb_info->recv);
+		i2ce->smbus.size = I2C_SMBUS_BLOCK_DATA;
+		if (i2c_non_blocking_op(&smb_info->client, i2ce)) {
+			if (smb_info->smb_debug & SMB_DEBUG_MSG) {
+				printk(KERN_INFO
+				       "Error from i2c_non_blocking_op(1)\n");
+			}
+			result = -EIO;
+		} else
+			return;
+	} else if (smb_info->multi_pos) {
+		/* Middle of multi-part read.  Start the next transaction. */
+		int i;
+		unsigned char blocknum;
+
+		if (len == 0) {
+			result = -EIO;
+			if (smb_info->smb_debug & SMB_DEBUG_MSG) {
+				printk(KERN_INFO
+				       "Received middle message with no"
+				       " data\n");
+			}
+			goto continue_op;
+		}
+
+		blocknum = data[smb_info->multi_len];
+
+		if (smb_info->multi_len+len-1 > IPMI_MAX_MSG_LENGTH) {
+			/* Received message too big, abort the operation. */
+			result = -E2BIG;
+			if (smb_info->smb_debug & SMB_DEBUG_MSG) {
+				printk(KERN_INFO
+				       "Received message too big\n");
+			}
+			goto continue_op;
+		}
+
+		/* Remove the blocknum from the data. */
+		for (i=0; i<len-1; i++)
+			smb_info->data[i+smb_info->multi_len] = data[i+1];
+		len--;
+		smb_info->multi_len += len;
+		if (blocknum == 0xff) {
+			/* End of read */
+			len = smb_info->multi_len;
+			data = smb_info->data;
+		} else if ((blocknum+1) != smb_info->multi_pos) {
+			/* Out of sequence block, just abort.  Block
+			   numbers start at zero for the second block,
+			   but multi_pos starts at one, so the +1. */
+			result = -EIO;
+		} else {
+			smb_info->multi_pos++;
+			i2ce->xfer_type = I2C_OP_SMBUS;
+			i2ce->handler = msg_done_handler;
+			i2ce->handler_data = smb_info;
+			i2ce->smbus.read_write = I2C_SMBUS_READ;
+			i2ce->smbus.command
+				= SMB_IPMI_MULTI_PART_RESPONSE_MIDDLE;
+			i2ce->smbus.data = ((union i2c_smbus_data *)
+					    smb_info->recv);
+			i2ce->smbus.size = I2C_SMBUS_BLOCK_DATA;
+
+			if (i2c_non_blocking_op(&smb_info->client, i2ce)) {
+				if (smb_info->smb_debug & SMB_DEBUG_MSG) {
+					printk(KERN_INFO
+					       "Error fromo i2c_non_blocking_op(2)\n");
+				}
+				result = -EIO;
+			} else
+				return;
+		}
+	}
+
+ continue_op:
+	if (smb_info->smb_debug & SMB_DEBUG_STATE)
+		printk(KERN_INFO "DONE 1: state = %d, result=%d.\n",
+		       smb_info->smb_state, result);
+
+	spin_lock_irqsave(&(smb_info->msg_lock), flags);
+	msg = smb_info->curr_msg;
+	if (msg) {
+		msg->rsp_size = len;
+		if (msg->rsp_size > IPMI_MAX_MSG_LENGTH)
+			msg->rsp_size = IPMI_MAX_MSG_LENGTH;
+		memcpy(msg->rsp, data, msg->rsp_size);
+		smb_info->curr_msg = NULL;
+	}
+
+	switch (smb_info->smb_state) {
+	case SMB_NORMAL:
+		spin_unlock_irqrestore(&smb_info->msg_lock, flags);
+		if (!msg)
+			break;
+
+		if (result < 0)
+			return_hosed_msg(smb_info, msg);
+		else
+			deliver_recv_msg(smb_info, msg);
+		break;
+
+	case SMB_GETTING_FLAGS:
+		/* We got the flags from the SMB, now handle them. */
+		if ((result < 0) || (len < 4) || (data[2] != 0)) {
+			/* Error fetching flags, or invalid length,
+			   just give up for now. */
+			smb_info->smb_state = SMB_NORMAL;
+			smb_info->running = 0;
+			spin_unlock_irqrestore(&smb_info->msg_lock, flags);
+			printk(KERN_WARNING
+			       "ipmi_smb:Error getting flags: %d %d, %2.2x\n",
+			       result, len, data[2]);
+		} else {
+			smb_info->msg_flags = data[3];
+			handle_flags(smb_info, &flags);
+		}
+		break;
+
+	case SMB_CLEARING_FLAGS:
+		/* We cleared the flags. */
+		if ((result < 0) || (len < 3) || (data[2] != 0)) {
+			/* Error clearing flags */
+			printk(KERN_WARNING
+			       "ipmi_smb:Error clearing flags: %d %d, %2.2x\n",
+			       result, len, data[2]);
+		}
+		smb_info->smb_state = SMB_NORMAL;
+		smb_info->running = 0;
+		spin_unlock_irqrestore(&smb_info->msg_lock, flags);
+		break;
+
+	case SMB_GETTING_EVENTS:
+		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
+			/* Error getting event, probably done. */
+			msg->done(msg);
+
+			/* Take off the event flag. */
+			smb_info->msg_flags &= ~EVENT_MSG_BUFFER_FULL;
+			handle_flags(smb_info, &flags);
+		} else {
+			handle_flags(smb_info, &flags);
+			deliver_recv_msg(smb_info, msg);
+		}
+		break;
+
+	case SMB_GETTING_MESSAGES:
+		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
+			/* Error getting event, probably done. */
+			msg->done(msg);
+
+			/* Take off the msg flag. */
+			smb_info->msg_flags &= ~RECEIVE_MSG_AVAIL;
+			handle_flags(smb_info, &flags);
+		} else {
+			handle_flags(smb_info, &flags);
+			deliver_recv_msg(smb_info, msg);
+		}
+		break;
+	}
+
+	spin_lock_irqsave(&(smb_info->msg_lock), flags);
+	if (SMB_IDLE(smb_info)) {
+		if (smb_info->req_events) {
+			unsigned char mb[2];
+
+			smb_info->req_events = 0;
+			smb_info->smb_state = SMB_GETTING_FLAGS;
+			smb_info->running = 1;
+			spin_unlock_irqrestore(&smb_info->msg_lock, flags);
+
+			mb[0] = (IPMI_NETFN_APP_REQUEST << 2);
+			mb[1] = IPMI_GET_MSG_FLAGS_CMD;
+			if (start_send(smb_info, mb, 2) != 0) {
+				smb_info->smb_state = SMB_NORMAL;
+				smb_info->running = 0;
+			}
+		} else {
+			start_next_msg(smb_info, &flags);
+		}
+	} else 
+		spin_unlock_irqrestore(&smb_info->msg_lock, flags);
+
+	if (smb_info->smb_debug & SMB_DEBUG_STATE)
+		printk(KERN_INFO "DONE 2: state = %d.\n", smb_info->smb_state);
+}
+
+static void msg_written_handler(struct i2c_op_q_entry *i2ce)
+{
+	struct smb_info *smb_info = i2ce->handler_data;
+
+	if (smb_info->stopping) {
+		smb_info->running = 0;
+		return;
+	}
+		
+	/* We are single-threaded here, so no need for a lock. */
+	if (i2ce->result < 0) {
+		smb_info->retries_left--;
+		if (smb_info->retries_left > 0) {
+                        if (! start_resend(smb_info))
+				return;
+			/* request failed, just return the error. */
+			if (smb_info->smb_debug & SMB_DEBUG_MSG) {
+				printk(KERN_INFO
+				       "Error from i2c_non_blocking_op(3)\n");
+			}
+			i2ce->result = -EIO;
+			msg_done_handler(i2ce);
+			return;
+		}
+
+		/* Got an error on transmit, let the done routine
+		   handle it. */
+		if (smb_info->smb_debug & SMB_DEBUG_MSG) {
+			printk(KERN_INFO
+			       "Error in msg_written_handler: %d\n",
+			       i2ce->result);
+		}
+		msg_done_handler(i2ce);
+		return;
+	}
+
+	if (smb_info->multi_data) {
+		/* In the middle of a multi-data write. */
+		int left;
+
+		if (left > 32)
+			left = 32;
+		left = smb_info->multi_len - smb_info->multi_pos;
+		i2ce->xfer_type = I2C_OP_SMBUS;
+		i2ce->handler = msg_written_handler;
+		i2ce->handler_data = smb_info;
+		i2ce->smbus.read_write = I2C_SMBUS_WRITE;
+		i2ce->smbus.data
+			= ((union i2c_smbus_data *)
+			   (smb_info->multi_data + smb_info->multi_pos));
+		/* Length byte. */
+		smb_info->multi_data[smb_info->multi_pos] = left;
+		i2ce->smbus.size = I2C_SMBUS_BLOCK_DATA;
+		smb_info->multi_pos += left;
+		i2ce->smbus.command = SMB_IPMI_MULTI_PART_REQUEST_MIDDLE;
+		if (left < 32)
+			/* Write is finished.  Note that we must end
+			   with a write of less than 32 bytes to
+			   complete the transaction, even if it is
+			   zero bytes. */
+			smb_info->multi_data = NULL;
+	} else {
+		/* Write done, start a read. */
+		i2ce->xfer_type = I2C_OP_SMBUS;
+		i2ce->handler = msg_done_handler;
+		i2ce->handler_data = smb_info;
+		i2ce->smbus.read_write = I2C_SMBUS_READ;
+		i2ce->smbus.command = SMB_IPMI_RESPONSE;
+		i2ce->smbus.data = (union i2c_smbus_data *) smb_info->recv;
+		i2ce->smbus.size = I2C_SMBUS_BLOCK_DATA;
+		smb_info->multi_pos = 0;
+	}
+
+	if (i2c_non_blocking_op(&smb_info->client, i2ce)) {
+		/* request failed, just return the error. */
+		if (smb_info->smb_debug & SMB_DEBUG_MSG) {
+			printk(KERN_INFO
+			       "Error from i2c_non_blocking_op(3)\n");
+		}
+		i2ce->result = -EIO;
+		msg_done_handler(i2ce);
+	}
+}
+
+static int start_resend(struct smb_info *smb_info)
+{
+	struct i2c_op_q_entry *i2ce;
+	int                   rv;
+
+	i2ce = &smb_info->i2c_q_entry;
+	i2ce->xfer_type = I2C_OP_SMBUS;
+	i2ce->handler = msg_written_handler;
+	i2ce->handler_data = smb_info;
+	i2ce->smbus.read_write = I2C_SMBUS_WRITE;
+
+	i2ce->smbus.data = (union i2c_smbus_data *) smb_info->data;
+	i2ce->smbus.size = I2C_SMBUS_BLOCK_DATA;
+
+	if (smb_info->data_len > 32) {
+		i2ce->smbus.command = SMB_IPMI_MULTI_PART_REQUEST_START;
+		smb_info->multi_data = smb_info->data;
+		smb_info->multi_len = smb_info->data_len;
+		/* Subtle thing, this is 32, not 33, because we will
+		   overwrite the thing at position 32 (which was just
+		   transmitted) with the new length. */
+		smb_info->multi_pos = 32;
+		smb_info->data[0] = 32;
+	} else {
+		smb_info->multi_data = NULL;
+		i2ce->smbus.command = SMB_IPMI_REQUEST;
+		smb_info->data[0] = smb_info->data_len;
+	}
+
+	rv = i2c_non_blocking_op(&smb_info->client, i2ce);
+	if (rv && (smb_info->smb_debug & SMB_DEBUG_MSG)) {
+		printk(KERN_INFO
+		       "Error from i2c_non_blocking_op(4)\n");
+	}
+	return rv;
+}
+
+static int start_send(struct smb_info *smb_info,
+		      unsigned char   *data,
+		      unsigned int    len)
+{
+	if (len > IPMI_MAX_MSG_LENGTH)
+		return -E2BIG;
+	if (len > smb_info->max_xmit_msg_size)
+		return -E2BIG;
+
+	smb_info->retries_left = SMB_MSG_RETRIES;
+	memcpy(smb_info->data+1, data, len);
+	smb_info->data_len = len;
+	return start_resend(smb_info);
+}
+
+/* Must be called with the message lock held. */
+static void start_next_msg(struct smb_info *smb_info, unsigned long *flags)
+{
+	struct list_head    *entry = NULL;
+	struct ipmi_smi_msg *msg;
+
+ restart:
+	if (!SMB_IDLE(smb_info)) {
+		spin_unlock_irqrestore(&smb_info->msg_lock, *flags);
+		return;
+	}
+
+	/* Pick the high priority queue first. */
+	if (! list_empty(&(smb_info->hp_xmit_msgs))) {
+		entry = smb_info->hp_xmit_msgs.next;
+	} else if (! list_empty(&(smb_info->xmit_msgs))) {
+		entry = smb_info->xmit_msgs.next;
+	}
+
+	if (!entry) {
+		smb_info->curr_msg = NULL;
+		spin_unlock_irqrestore(&smb_info->msg_lock, *flags);
+	} else {
+		int rv;
+
+		list_del(entry);
+		msg = list_entry(entry, struct ipmi_smi_msg, link);
+		smb_info->curr_msg = msg;
+		spin_unlock_irqrestore(&smb_info->msg_lock, *flags);
+		rv = start_send(smb_info,
+				smb_info->curr_msg->data,
+				smb_info->curr_msg->data_size);
+		if (rv) {
+			smb_info->curr_msg = NULL;
+			return_hosed_msg(smb_info, msg);
+			spin_lock_irqsave(&smb_info->msg_lock, *flags);
+			goto restart;
+		}
+	}
+}
+
+static void sender(void                *send_info,
+		   struct ipmi_smi_msg *msg,
+		   int                 priority)
+{
+	struct smb_info *smb_info = (struct smb_info *) send_info;
+	unsigned long   flags;
+
+	spin_lock_irqsave(&smb_info->msg_lock, flags);
+	if (smb_info->run_to_completion) {
+		/* If we are running to completion, then throw it in
+		   the list and run transactions until everything is
+		   clear.  Priority doesn't matter here. */
+		list_add_tail(&(msg->link), &(smb_info->xmit_msgs));
+		start_next_msg(smb_info, &flags);
+
+		i2c_poll(&smb_info->client, 0);
+		while (! SMB_IDLE(smb_info)) {
+			udelay(500);
+			i2c_poll(&smb_info->client, 500);
+		}
+		return;
+	}
+
+
+	if (priority > 0) {
+		list_add_tail(&(msg->link), &(smb_info->hp_xmit_msgs));
+	} else {
+		list_add_tail(&(msg->link), &(smb_info->xmit_msgs));
+	}
+	start_next_msg(smb_info, &flags);
+
+	if (smb_info->smb_debug & SMB_DEBUG_TIMING) {
+		struct timeval     t;
+		do_gettimeofday(&t);
+		printk(KERN_INFO
+		       "**Enqueue %02x %02x: %ld.%6.6ld\n",
+		       msg->data[0], msg->data[1], t.tv_sec, t.tv_usec);
+	}
+}
+
+/*
+ * Instead of having our own timer to periodically check the message
+ * flags, we let the message handler drive us.
+ */
+static void request_events(void *send_info)
+{
+	struct smb_info *smb_info = (struct smb_info *) send_info;
+	unsigned long   flags;
+
+	spin_lock_irqsave(&smb_info->msg_lock, flags);
+	if (SMB_IDLE(smb_info)) {
+		unsigned char mb[2];
+
+		smb_info->smb_state = SMB_GETTING_FLAGS;
+		smb_info->running = 1;
+		spin_unlock_irqrestore(&smb_info->msg_lock, flags);
+
+		mb[0] = (IPMI_NETFN_APP_REQUEST << 2);
+		mb[1] = IPMI_GET_MSG_FLAGS_CMD;
+		if (start_send(smb_info, mb, 2)) {
+			spin_lock_irqsave(&smb_info->msg_lock, flags);
+			smb_info->smb_state = SMB_NORMAL;
+			smb_info->running = 0;
+			/* Msgs could have been queued while we were
+			 * unlocked. */
+			start_next_msg(smb_info, &flags);
+		}
+	} else {
+		smb_info->req_events = 1;
+		spin_unlock_irqrestore(&smb_info->msg_lock, flags);
+	}
+}
+
+static void set_run_to_completion(void *send_info, int i_run_to_completion)
+{
+	struct smb_info *smb_info = (struct smb_info *) send_info;
+
+	smb_info->run_to_completion = i_run_to_completion;
+	/* Note that if this does not compile, there are some I2C
+	   changes that you need to handle this properly. */
+	if (i_run_to_completion) {
+		i2c_poll(&smb_info->client, 0);
+		while (! SMB_IDLE(smb_info)) {
+			udelay(500);
+			i2c_poll(&smb_info->client, 500);
+		}
+	}
+}
+
+static void poll(void *send_info)
+{
+	struct smb_info *smb_info = send_info;
+	i2c_poll(&smb_info->client, 10);
+}
+
+static struct ipmi_smi_handlers handlers =
+{
+	.owner                 = THIS_MODULE,
+	.sender		       = sender,
+	.request_events        = request_events,
+	.set_run_to_completion = set_run_to_completion,
+	.poll		       = poll,
+};
+
+static int attach_adapter(struct i2c_adapter *adapter);
+static int detach_client(struct i2c_client *client);
+static struct i2c_driver smb_i2c_driver =
+{
+	.owner = THIS_MODULE,
+	.name = "IPMI",
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = attach_adapter,
+	.detach_client = detach_client,
+};
+
+static int ipmi_smb_detect_hardware(struct i2c_adapter *adapter, int addr, 
+				    int debug, struct smb_info **smb_info)
+{
+	unsigned char     msg[3];
+	unsigned char     *resp;
+	s32               ret;
+	struct smb_info   *info;
+	int               rv = 0;
+	struct i2c_client *client;
+	int               retry_cnt;
+
+	resp = kmalloc(IPMI_MAX_MSG_LENGTH, GFP_KERNEL);
+	if (!resp)
+		return -ENOMEM;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		kfree(resp);
+		return -ENOMEM;
+	}
+	memset(info, 0, sizeof(*info));
+
+	client = &info->client;
+	strlcpy(client->name, "IPMI", I2C_NAME_SIZE);
+	client->addr = addr;
+	client->adapter = adapter;
+	client->driver = &smb_i2c_driver;
+
+	/* Do a Get Device ID command, since it comes back with some
+	   useful info. */
+	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
+	msg[1] = IPMI_GET_DEVICE_ID_CMD;
+
+	retry_cnt = SMB_MSG_RETRIES;
+ retry1:
+	ret = i2c_smbus_write_block_data(client, SMB_IPMI_REQUEST, 2, msg);
+	if (ret) {
+		retry_cnt--;
+		if (retry_cnt > 0)
+			goto retry1;
+		rv = -ENODEV;
+		goto out;
+	}
+
+	ret = -ENODEV;
+	while (retry_cnt > 0) {
+		ret = i2c_smbus_read_block_data(client, SMB_IPMI_RESPONSE,
+						resp);
+		if (ret >= 6)
+			break;
+		msleep(10);
+		retry_cnt--;
+		if (retry_cnt <= 0)
+			break;
+		if ((retry_cnt % SMB_MSG_RETRY_WRITE_COUNT) == 0)
+			goto retry1;
+		
+	}
+	if (ret < 6) {
+		/* That's odd, it should be longer. */
+		rv = -ENODEV;
+		goto out;
+	}
+
+	if ((resp[1] != IPMI_GET_DEVICE_ID_CMD) || (resp[2] != 0)) {
+		/* That's odd, it shouldn't be able to fail. */
+		rv = -ENODEV;
+		goto out;
+	}
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
+	/* Now check for system interface capabilities */
+	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
+	msg[1] = IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD;
+	msg[2] = 0; /* SSIF */
+	retry_cnt = SMB_MSG_RETRIES;
+ retry2:
+	ret = i2c_smbus_write_block_data(client, SMB_IPMI_REQUEST, 3, msg);
+	if (ret) {
+		retry_cnt--;
+		if (retry_cnt > 0)
+			goto retry2;
+		rv = -ENODEV;
+		goto out;
+	}
+
+	ret = -ENODEV;
+	while (retry_cnt > 0) {
+		ret = i2c_smbus_read_block_data(client, SMB_IPMI_RESPONSE,
+						resp);
+		if (ret >= 6)
+			break;
+		msleep(10);
+		retry_cnt--;
+		if (retry_cnt <= 0)
+			break;
+		if ((retry_cnt % SMB_MSG_RETRY_WRITE_COUNT) == 0)
+			goto retry2;
+	}
+	if ((ret >= 3) && (resp[2] == 0)) {
+		if (ret < 7) {
+			if (smb_dbg_probe) {
+				printk(KERN_INFO
+				       "ipmi_smb:  SSIF info too short: %d\n",
+				       ret);
+			}
+			goto no_support;
+		}
+
+		/* Got a good SSIF response, handle it. */
+		info->max_xmit_msg_size = resp[5];
+		info->max_recv_msg_size = resp[6];
+		info->multi_support = (resp[4] >> 6) & 0x3;
+		info->supports_pec = (resp[4] >> 3) & 0x1;
+
+		/* Sanitize the data */
+		switch (info->multi_support)
+		{
+		case SMB_NO_MULTI:
+			if (info->max_xmit_msg_size > 32)
+				info->max_xmit_msg_size = 32;
+			if (info->max_recv_msg_size > 32)
+				info->max_recv_msg_size = 32;
+			break;
+
+		case SMB_MULTI_2_PART:
+			if (info->max_xmit_msg_size > 64)
+				info->max_xmit_msg_size = 64;
+			if (info->max_recv_msg_size > 62)
+				info->max_recv_msg_size = 62;
+			break;
+
+		case SMB_MULTI_n_PART:
+			break;
+
+		default:
+			/* Data is not sane, just give up. */
+			goto no_support;
+		}
+	} else {
+	no_support:
+		/* Assume no multi-part or PEC support */
+		info->max_xmit_msg_size = 32;
+		info->max_recv_msg_size = 32;
+		info->multi_support = SMB_NO_MULTI;
+		info->supports_pec = 0;
+	}
+
+	*smb_info = info;
+
+ out:
+	if (rv)
+		kfree(info);
+	kfree(resp);
+	return rv;
+}
+
+#define MAX_SMB_BMCS 4
+/* no expressions allowed in __MODULE_STRING */
+#define MAX_SMB_ADDR_PAIRS	8
+
+/* An array of SMB interfaces. */
+static struct smb_info *smb_infos[MAX_SMB_BMCS];
+
+static unsigned short __initdata addr[MAX_SMB_BMCS*2];
+static int num_addrs = 0;
+
+module_param_array(addr, ushort, &num_addrs, 0);
+MODULE_PARM_DESC(addr, "Sets the addresses to scan for IPMI BMCs on the SMBus."
+		 " By default the driver will scan for anything it finds in"
+		 " DMI or ACPI tables.  Otherwise you have to hand-specify"
+		 " the address.  This is a list of pairs (ie a,b,c,d) where"
+		 " each pair gives an adapter and an address.  In the"
+		 " previous example it will scan address b on adapter a"
+		 " and address d on adapter c."
+		 " The first pair is for the first interface, etc.  If you"
+		 " don't provide this and don't have DMI/ACPI, it probably"
+		 " won't work.");
+
+static int smb_defaultprobe = 0;
+module_param_named(defaultprobe, smb_defaultprobe, int, 0);
+MODULE_PARM_DESC(defaultprobe, "Normally the driver will not scan anything"
+		 " but the specified values and DMI/ACPI values.  If you set"
+		 " this to non-zero it will scan all addresses except for"
+		 " certain dangerous ones.");
+
+static int slave_addrs[MAX_SMB_BMCS];
+static int num_slave_addrs = 0;
+module_param_array(slave_addrs, int, &num_slave_addrs, 0);
+MODULE_PARM_DESC(slave_addrs, "Set the default IPMB slave address for"
+		 " the controller.  Normally this is 0x20, but can be"
+		 " overridden by this parm.  This is an array indexed"
+		 " by interface number.");
+
+static int dbg[MAX_SMB_BMCS];
+static int num_dbg = 0;
+module_param_array(dbg, int, &num_dbg, 0);
+MODULE_PARM_DESC(dbg, "Turn on debugging.  Bit 0 enables message debugging,"
+		 " bit 1 enables state debugging, and bit 2 enables timing"
+		 " debugging.  This is an array indexed by interface number");
+
+module_param_named(dbg_probe, smb_dbg_probe, int, 0);
+MODULE_PARM_DESC(dbg_probe, "Enable debugging of probing of adapters.");
+
+/* force list has 3 entries - 0:bus/adapter no 1: i2c addr 2: unknown/unused */
+#define	FORCE_LIST_ENTRIES	3
+static unsigned short smb_force_list[MAX_SMB_BMCS*FORCE_LIST_ENTRIES + FORCE_LIST_ENTRIES];
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
+	if (addr[pos*2+1] != 0)
+		return (addr[pos*2] << 16) | addr[pos*2+1];
+
+	return 0;
+}
+
+static int smb_found_addr_proc(struct i2c_adapter *adapter, int addr, int kind)
+{
+	int id = i2c_adapter_id(adapter);
+	int debug = dbg[id];
+	int rv;
+	int i;
+	int next_pos;
+	struct smb_info *smb_info;
+
+	if( id >= MAX_SMB_BMCS )
+		return 0;
+	rv = ipmi_smb_detect_hardware(adapter, addr, debug, &smb_info);
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
+	smb_info->req_events = 0;
+	smb_info->run_to_completion = 0;
+	smb_info->smb_state = SMB_NORMAL;
+	smb_info->running = 0;
+	init_timer(&smb_info->retry_timer);
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
+	if (smb_info->supports_pec)
+		smb_info->client.flags |= I2C_CLIENT_PEC;
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
+	rv = ipmi_register_smi(&handlers,
+			       smb_info,
+			       smb_info->ipmi_version_major,
+			       smb_info->ipmi_version_minor,
+			       slave_addrs[next_pos],
+			       &(smb_info->intf));
+	if (rv) {
+		i2c_detach_client(&smb_info->client);
+		smb_infos[next_pos] = NULL;
+		printk(KERN_ERR
+		       "ipmi_smb: Unable to register device: error %d\n",
+		       rv);
+		goto out_err;
+	}
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
+	if (smb_dbg_probe)
+		printk(KERN_INFO "init_one_smb: Checking SMBus adapter %d:"
+		       " %s\n", id, adapter->name);
+
+	if (!(i2c_get_functionality(adapter) & (I2C_FUNC_SMBUS_BLOCK_DATA)))
+		return 0;
+
+	if (smb_dbg_probe)
+		printk(KERN_INFO "init_one_smb: found SMBus adapter:"
+		       " %s\n", adapter->name);
+
+	if (!i2c_non_blocking_capable(adapter)) {
+	    if (smb_dbg_probe)
+		    printk(KERN_INFO
+			   "init_one_smb: SMBus adapter not non_blocking capable: %s\n",
+			   adapter->name);
+	    return 0;
+	}
+
+	i2c_probe(adapter, &smb_address_data, smb_found_addr_proc);
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
+	/* make sure the driver is not doing anything. */
+	to_clean->stopping = 1;
+	while (to_clean->running)
+		msleep(1);
+
+	rv = ipmi_unregister_smi(to_clean->intf);
+	if (rv) {
+		printk(KERN_ERR
+		       "ipmi_smb: Unable to unregister device: errno=%d\n",
+		       rv);
+	}
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
+#ifdef CONFIG_ACPI_INTERPRETER
+
+#include <linux/acpi.h>
+
+/*
+ * Defined in the IPMI 2.0 spec.
+ */
+struct SPMITable {
+	s8	Signature[4];
+	u32	Length;
+	u8	Revision;
+	u8	Checksum;
+	s8	OEMID[6];
+	s8	OEMTableID[8];
+	s8	OEMRevision[4];
+	s8	CreatorID[4];
+	s8	CreatorRevision[4];
+	u8	InterfaceType;
+	u8	IPMIlegacy;
+	s16	SpecificationRevision;
+
+	/*
+	 * Bit 0 - SCI interrupt supported
+	 * Bit 1 - I/O APIC/SAPIC
+	 */
+	u8	InterruptType;
+
+	/* If bit 0 of InterruptType is set, then this is the SCI
+           interrupt in the GPEx_STS register. */
+	u8	GPE;
+
+	s16	Reserved;
+
+	/* If bit 1 of InterruptType is set, then this is the I/O
+           APIC/SAPIC interrupt. */
+	u32	GlobalSystemInterrupt;
+
+	/* The actual register address. */
+	struct acpi_generic_address addr;
+
+	u8	UID[4];
+
+	s8      spmi_id[1]; /* A '\0' terminated array starts here. */
+};
+
+static int decode_acpi(int intf_num)
+{
+	acpi_status      status;
+	struct SPMITable *spmi;
+
+	status = acpi_get_firmware_table("SPMI", intf_num+1,
+					 ACPI_LOGICAL_ADDRESSING,
+					 (struct acpi_table_header **) &spmi);
+	if (status != AE_OK)
+		return -ENODEV;
+
+	if (spmi->IPMIlegacy != 1) {
+	    printk(KERN_WARNING "IPMI: Bad SPMI legacy %d\n",
+		   spmi->IPMIlegacy);
+  	    return -ENODEV;
+	}
+
+	if (spmi->InterfaceType != 4)
+		return -ENODEV;
+
+	if (spmi->addr.address_space_id != 4) {
+		printk(KERN_WARNING
+		       "ipmi_smb: Invalid ACPI SSIF I/O Address type\n");
+		return -EIO;
+	}
+
+	if (addr[intf_num*2+1] == 0) {
+		/* User didn't specify, so use this one. */
+		addr[intf_num*2] = 0; /* Assume adapter 0 */
+		addr[intf_num*2+1] = spmi->addr.address >> 1;
+		printk(KERN_INFO
+		       "ipmi_smb: ACPI/SPMI specifies SSIF @ 0x%x\n",
+		       addr[intf_num*2+1]);
+	}
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_X86
+typedef struct dmi_header
+{
+	u8	type;
+	u8	length;
+	u16	handle;
+} dmi_header_t;
+
+static int decode_dmi(dmi_header_t *dm, int intf_num)
+{
+	u8 *data = (u8 *)dm;
+
+	if (data[0x04] != 4) /* Not SSIF */
+		return -1;
+
+	if (addr[intf_num*2+1] == 0) {
+		/* User didn't specify, so use this one. */
+		addr[intf_num*2] = 0; /* Assume adapter 0 */
+		addr[intf_num*2+1] = data[8] >> 1;
+		printk(KERN_INFO
+		       "ipmi_smb: DMI specifies SSIF @ 0x%x\n", data[8] >> 1);
+	}
+
+	if (slave_addrs[intf_num] == 0) {
+		slave_addrs[intf_num] = data[6];
+		printk(KERN_INFO
+		       "ipmi_smb: DMI specifies slave address at 0x%x\n",
+		       slave_addrs[intf_num]);
+	}
+
+	return -1;
+}
+
+static int dmi_table(u32 base, int len, int num)
+{
+	u8 		  *buf;
+	struct dmi_header *dm;
+	u8 		  *data;
+	int 		  i=1;
+	int		  status=-1;
+	int               intf_num = 0;
+
+	buf = ioremap(base, len);
+	if(buf==NULL)
+		return -1;
+
+	data = buf;
+
+	while(i<num && (data - buf) < len)
+	{
+		dm=(dmi_header_t *)data;
+
+		if((data-buf+dm->length) >= len)
+        		break;
+
+		if (dm->type == 38) {
+			if (decode_dmi(dm, intf_num) == 0) {
+				intf_num++;
+				if (intf_num >= MAX_SMB_BMCS)
+					break;
+			}
+		}
+
+	        data+=dm->length;
+		while((data-buf) < len && (*data || data[1]))
+			data++;
+		data+=2;
+		i++;
+	}
+	iounmap(buf);
+
+	return status;
+}
+
+inline static int dmi_checksum(u8 *buf)
+{
+	u8   sum=0;
+	int  a;
+
+	for(a=0; a<15; a++)
+		sum+=buf[a];
+	return (sum==0);
+}
+
+static int dmi_iterator(void)
+{
+	u8   buf[15];
+	u32  fp=0xF0000;
+
+#ifdef CONFIG_SIMNOW
+	return -1;
+#endif
+
+	while(fp < 0xFFFFF)
+	{
+		isa_memcpy_fromio(buf, fp, 15);
+		if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))
+		{
+			u16 num=buf[13]<<8|buf[12];
+			u16 len=buf[7]<<8|buf[6];
+			u32 base=buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8];
+
+			if(dmi_table(base, len, num) == 0)
+				return 0;
+		}
+		fp+=16;
+	}
+
+	return -1;
+}
+#endif
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
+#ifdef CONFIG_X86
+	dmi_iterator();
+#endif
+#ifdef CONFIG_ACPI_INTERPRETER
+	for (i=0; i<MAX_SMB_BMCS; i++)
+		decode_acpi(i);
+#endif
+
+	/* build force list from addr list */
+	for (i=0; i<MAX_SMB_BMCS; i++) {
+		if (addr[i*2+1] == 0)
+			break;
+		smb_force_list[i*FORCE_LIST_ENTRIES] = addr[i*2];
+		smb_force_list[i*FORCE_LIST_ENTRIES+1] = addr[i*2+1];
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
+
+MODULE_AUTHOR("Todd C Davis <todd.c.davis@intel.com>, "
+	      "Corey Minyard <minyard@acm.org>");
+MODULE_DESCRIPTION("IPMI system interface driver for management controllers on a SMBus");
+MODULE_LICENSE("GPL");
Index: linux-2.6.11-rc2/drivers/char/ipmi/Kconfig
===================================================================
--- linux-2.6.11-rc2.orig/drivers/char/ipmi/Kconfig
+++ linux-2.6.11-rc2/drivers/char/ipmi/Kconfig
@@ -51,6 +51,17 @@
 	 Currently, only KCS and SMIC are supported.  If
 	 you are using IPMI, you should probably say "y" here.
 
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
+
 config IPMI_WATCHDOG
        tristate 'IPMI Watchdog Timer'
        depends on IPMI_HANDLER
Index: linux-2.6.11-rc2/drivers/char/ipmi/Makefile
===================================================================
--- linux-2.6.11-rc2.orig/drivers/char/ipmi/Makefile
+++ linux-2.6.11-rc2/drivers/char/ipmi/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_IPMI_HANDLER) += ipmi_msghandler.o
 obj-$(CONFIG_IPMI_DEVICE_INTERFACE) += ipmi_devintf.o
 obj-$(CONFIG_IPMI_SI) += ipmi_si.o
+obj-$(CONFIG_IPMI_SMB) += ipmi_smb.o
 obj-$(CONFIG_IPMI_WATCHDOG) += ipmi_watchdog.o
 obj-$(CONFIG_IPMI_POWEROFF) += ipmi_poweroff.o
 
Index: linux-2.6.11-rc2/Documentation/IPMI.txt
===================================================================
--- linux-2.6.11-rc2.orig/Documentation/IPMI.txt
+++ linux-2.6.11-rc2/Documentation/IPMI.txt
@@ -417,14 +417,15 @@
 ----------------
 
 The SMBus driver allows up to 4 SMBus devices to be configured in the
-system.  By default, the driver will register any SMBus interfaces it finds
-in the I2C address range of 0x20 to 0x4f on any adapter.  You can change this
+system.  By default, the driver will only register with something it
+finds in DMI or ACPI tables.  You can change this
 at module load time (for a module) with:
 
   modprobe ipmi_smb.o
 	addr=<adapter1>,<i2caddr1>[,<adapter2>,<i2caddr2>[,...]]
 	dbg=<flags1>,<flags2>...
-	[defaultprobe=0] [dbg_probe=1]
+        slave_addrs=<addr1>,<addr2>,...
+	[defaultprobe=1] [dbg_probe=1]
 
 The addresses are specified in pairs, the first is the adapter ID and the
 second is the I2C address on that adapter.
@@ -432,20 +433,26 @@
 The debug flags are bit flags for each BMC found, they are:
 IPMI messages: 1, driver state: 2, timing: 4, I2C probe: 8
 
-Setting smb_defaultprobe to zero disabled the default probing of SMBus
-interfaces at address range 0x20 to 0x4f.  This means that only the
-BMCs specified on the smb_addr line will be detected.
+Setting defaultprobe to one will enable probing of SMBus interfaces at
+address ranging from 0x20 to 0x4f.  This means any BMCs found in that
+area on any adapter will be detected.  Note that if something else is
+in this address range, the scan operation can clobber it, so be
+careful.
 
-Setting smb_dbg_probe to 1 will enable debugging of the probing and
+Setting dbg_probe to 1 will enable debugging of the probing and
 detection process for BMCs on the SMBusses.
 
-Discovering the IPMI compilant BMC on the SMBus can cause devices
-on the I2C bus to fail. The SMBus driver writes a "Get Device ID" IPMI
+The slave_addrs specifies the IPMI address of the local BMC.  This is
+usually 0x20 and the driver defaults to that, but in case it's not, it
+can be specified when the driver starts up.
+
+Discovering the IPMI compilant BMC on the SMBus can cause devices on
+the I2C bus to fail. The SMBus driver writes a "Get Device ID" IPMI
 message as a block write to the I2C bus and waits for a response.
-This action can be detrimental to some I2C devices. It is highly recommended
-that the known I2c address be given to the SMBus driver in the smb_addr
-parameter. The default adrress range will not be used when a smb_addr
-parameter is provided.
+This action can be detrimental to some I2C devices. It is highly
+recommended that the known I2C address be given to the SMBus driver in
+the smb_addr parameter unless you have DMI or ACPI data to tell the
+driver what to use.
 
 When compiled into the kernel, the addresses can be specified on the
 kernel command line as:
@@ -453,6 +460,7 @@
   ipmb_smb.addr=<adapter1>,<i2caddr1>[,<adapter2>,<i2caddr2>[,...]]
 	ipmi_smb.dbg=<flags1>,<flags2>...
 	ipmi_smb.defaultprobe=0 ipmi_smb.dbg_probe=1
+        ipmi_smb.slave_addrs=<addr1>,<addr2>,...
 
 These are the same options as on the module command line.
 

--------------090705070807070103070303--
