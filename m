Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVCIXFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVCIXFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVCIWgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:36:17 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37328 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262396AbVCIWLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:11:41 -0500
Message-ID: <422F7498.6020007@us.ltcfwd.linux.ibm.com>
Date: Wed, 09 Mar 2005 17:11:36 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Kilau, Scott" <Scott_Kilau@digi.com>, Wen Xiong <wendyx@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9E9@minimail.digi.com> <20050309191230.GA27501@kroah.com>
In-Reply-To: <20050309191230.GA27501@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------040604030308090703010905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040604030308090703010905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>  
>
>>For the JSM driver, its up to you whether you feel its needed or not.
>>
>>However, I would like to mention that the DIGI drivers that currently
>>reside in the kernel sources *do* reserve that ioctl space,
>>and is acknowledged by "Documentation/ioctl-number.txt":
>>    
>>
>>>d'     F0-FF   linux/digi1.h
>>>      
>>>
>>I understand that the list is not a reservation list,
>>but a current list of potential ioctl conflicts...
>>    
>>
>
>It's not a reservation issue, it's the fact that we don't want to allow
>new ioctls, and if we do, they had better work properly (your
>implementation does not.)
>
>
>  
>
Hi Greg,

We understood that you don't want more new ioctls in the driver.  
For DPA tool(it is very good for customers) works, I think first I want 
to make this part code working, then you can decide if you pickup or not.

Old ioctls work with DPA tool. From your comments, looks old 
implementation does not work.
Need I use "register_ioctl32_convension" and 
"unregister_ioctl32_convension"?

Thank you so much!
wendy

--------------040604030308090703010905
Content-Type: text/plain;
 name="patch5.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch5.jasmine"

diff -Nuar linux-2.6.11.org/drivers/serial/jsm/jsm_mgmt.c linux-2.6.11.new/drivers/serial/jsm/jsm_mgmt.c
--- linux-2.6.11.org/drivers/serial/jsm/jsm_mgmt.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.new/drivers/serial/jsm/jsm_mgmt.c	2005-03-04 11:28:39.420979504 -0600
@@ -0,0 +1,336 @@
+/************************************************************************
+ * Copyright 2003 Digi International (www.digi.com)
+ *
+ * Copyright (C) 2004 IBM Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the 
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
+ * PURPOSE.  See the GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License 
+ * along with this program; if not, write to the Free Software 
+ * Foundation, Inc., 59 * Temple Place - Suite 330, Boston,
+ * MA  02111-1307, USA.
+ *
+ * Contact Information:
+ * Scott H Kilau <Scott_Kilau@digi.com>
+ * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
+ *
+ ***********************************************************************/
+
+/************************************************************************
+ * 
+ * This file implements the mgmt functionality for the
+ * Neo and ClassicBoard based product lines.
+ * 
+ ************************************************************************
+ */
+#include <linux/ctype.h>
+#include <linux/sched.h>	/* For jiffies, task states */
+#include <linux/interrupt.h>	/* For tasklet and interrupt structs/defines */
+#include <linux/termios.h>
+#include <asm/uaccess.h>	/* For copy_from_user/copy_to_user */
+
+#include "jsm_driver.h"
+
+/* Our "in use" variables, to enforce 1 open only */
+static int jsm_mgmt_in_use[8];
+spinlock_t jsm_global_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * jsm_mgmt_open()  
+ *
+ * Open the mgmt/downld/dpa device
+ */  
+int jsm_mgmt_open(struct inode *inode, struct file *file)
+{
+	unsigned long lock_flags;
+	unsigned int minor = JSM_MINOR(inode);
+
+	DPRINTK(MGMT, INFO, "start.\n");
+
+	spin_lock_irqsave(&jsm_global_lock, lock_flags);
+
+	/* mgmt device */
+	if (minor < 8) {
+		/* Only allow 1 open at a time on mgmt device */
+		if (jsm_mgmt_in_use[minor]) {
+			spin_unlock_irqrestore(&jsm_global_lock, lock_flags);
+			return -EBUSY;
+		}
+		jsm_mgmt_in_use[minor]++;
+	}
+	else {
+		spin_unlock_irqrestore(&jsm_global_lock, lock_flags);
+		return -ENXIO;
+	}
+
+	spin_unlock_irqrestore(&jsm_global_lock, lock_flags);
+
+	DPRINTK(MGMT, INFO, "finish.\n");
+
+	return 0;
+}
+
+/*
+ * jsm_mgmt_close()
+ *
+ * Open the mgmt/dpa device
+ */  
+int jsm_mgmt_close(struct inode *inode, struct file *file)
+{
+	unsigned long lock_flags;
+	unsigned int minor = JSM_MINOR(inode);
+
+	DPRINTK(MGMT, INFO, "start.\n");
+
+	spin_lock_irqsave(&jsm_global_lock, lock_flags);
+
+	/* mgmt device */
+	if (minor < 8) {
+		if (jsm_mgmt_in_use[minor])
+			jsm_mgmt_in_use[minor] = 0;
+	}
+	spin_unlock_irqrestore(&jsm_global_lock, lock_flags);
+
+	DPRINTK(MGMT, INFO, "finish.\n");
+
+	return 0;
+}
+
+/*
+ * jsm_mgmt_ioctl()
+ *
+ * ioctl the mgmt/dpa device
+ */  
+
+int jsm_mgmt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	unsigned long lock_flags;
+	void __user *uarg = (void __user *) arg;
+
+	DPRINTK(MGMT, INFO, "start.\n");
+
+	switch (cmd) {
+
+	case DIGI_GETDD:
+	{
+		/*
+		 * This returns the total number of boards
+		 * in the system, as well as driver version
+		 * and has space for a reserved entry
+		 */
+		struct digi_dinfo *ddi;
+		int adapter_count;
+
+		ddi = (struct digi_dinfo *)kmalloc(sizeof(struct digi_dinfo), GFP_KERNEL);
+		if (!ddi) {
+			DPRINTK(MGMT, WARNING, "memory allocation for board structure failed\n");
+			return -ENOMEM;
+		}
+		memset(ddi, 0, sizeof(struct digi_dinfo));
+
+
+		adapter_count = get_jsm_board_number();
+
+		spin_lock_irqsave(&jsm_global_lock, lock_flags);
+
+		ddi->dinfo_nboards = adapter_count;
+		sprintf(ddi->dinfo_version, "%s", "40002438_A-INKERNEL");
+
+		spin_unlock_irqrestore(&jsm_global_lock, lock_flags);
+
+		DPRINTK(MGMT, INFO, "DIGI_GETDD returning numboards: %d version: %s\n",
+			ddi->dinfo_nboards, ddi->dinfo_version);
+
+		if (copy_to_user(uarg, &ddi, sizeof (struct digi_dinfo)))
+			return -EFAULT;
+
+		kfree(ddi);
+		break;
+	}
+
+	case DIGI_GETBD:
+	{
+		int brd;
+
+		struct digi_info *di;
+		int adapter_count;
+
+		struct list_head *tmp;
+		struct jsm_board *cur_board_entry;
+
+		if (copy_from_user(&brd, uarg, sizeof(int)))
+			return -EFAULT;
+
+		adapter_count = get_jsm_board_number();
+
+		DPRINTK(MGMT, INFO, "DIGI_GETBD asking about board: %d\n", brd);
+
+		if ((brd < 0) || (brd > adapter_count) || (adapter_count == 0))
+			return -ENODEV;
+
+		di = (struct digi_info *)kmalloc(sizeof(struct digi_info), GFP_KERNEL);
+		if (!di) {
+			DPRINTK(MGMT, WARNING, "memory allocation for board structure failed\n");
+			return -ENOMEM;
+		}
+		memset(di, 0, sizeof(struct digi_info));
+
+		di->info_bdnum = brd;
+
+		spin_lock_irqsave(&jsm_board_head_lock, lock_flags);
+		list_for_each(tmp, &jsm_board_head) {
+			cur_board_entry = list_entry(tmp, struct jsm_board,
+						  jsm_board_entry);
+			if (cur_board_entry->boardnum == brd) {
+				break;
+			}
+		}
+		spin_unlock_irqrestore(&jsm_board_head_lock, lock_flags);
+
+
+		spin_lock_irqsave(&cur_board_entry->bd_lock, lock_flags);
+
+		di->info_bdtype = cur_board_entry->dpatype;
+		di->info_bdstate = cur_board_entry->dpastatus;
+		di->info_ioport = 0;
+		di->info_physaddr = (u64) cur_board_entry->membase;
+		di->info_physsize = (u64) cur_board_entry->membase - cur_board_entry->membase_end;
+		if (cur_board_entry->state != BOARD_FAILED)
+			di->info_nports = cur_board_entry->nasync;
+		else
+			di->info_nports = 0;
+
+		spin_unlock_irqrestore(&cur_board_entry->bd_lock, lock_flags);
+
+		DPRINTK(MGMT, INFO, "DIGI_GETBD returning type: %x state: %x ports: %x size: %x\n",
+			di->info_bdtype, di->info_bdstate, di->info_nports, di->info_physsize);
+
+		if (copy_to_user(uarg, &di, sizeof (struct digi_info)))
+			return -EFAULT;
+
+		kfree(di);
+		break;
+	}
+
+	case DIGI_GET_NI_INFO:
+	{
+		struct jsm_channel *ch;
+		struct ni_info *ni;
+		u64 lock_flags;
+		u8 mstat = 0;
+		u32 board = 0;
+		u32 channel = 0;
+		int adapter_count = 0;
+		struct list_head *tmp;
+		struct jsm_board *cur_board_entry;
+
+		adapter_count = get_jsm_board_number();
+		ni = (struct ni_info *)kmalloc(sizeof(struct ni_info), GFP_KERNEL);
+		if (!ni) {
+			DPRINTK(MGMT, WARNING, "memory allocation for board structure failed\n");
+			return -ENOMEM;
+		}
+		memset(ni, 0, sizeof(struct ni_info));
+
+		if (copy_from_user(&ni, uarg, sizeof(struct ni_info)))
+			return -EFAULT;
+
+		DPRINTK(MGMT, INFO, "DIGI_GETBD asking about board: %d channel: %d\n",
+			ni->board, ni->channel);
+
+		board = ni->board;
+		channel = ni->channel;
+
+		/* Verify boundaries on board */
+		if ((board < 0) || (board > adapter_count) || (adapter_count == 0))
+			return -ENODEV;
+
+		spin_lock_irqsave(&jsm_board_head_lock, lock_flags);
+		list_for_each(tmp, &jsm_board_head) {
+			cur_board_entry = list_entry(tmp, struct jsm_board,
+					jsm_board_entry);
+			if (cur_board_entry->boardnum == board) {
+				break;
+			}
+		}
+		spin_unlock_irqrestore(&jsm_board_head_lock, lock_flags);
+
+		/* Verify boundaries on channel */
+		if ((channel < 0) || (channel > cur_board_entry->nasync))
+			return -ENODEV;
+
+		ch = cur_board_entry->channels[channel];
+
+		memset(&ni, 0, sizeof(struct ni_info));
+		ni->board = board;
+		ni->channel = channel;
+
+		spin_lock_irqsave(&ch->ch_lock, lock_flags);
+
+		mstat = (ch->ch_mostat | ch->ch_mistat);
+
+		if (mstat & UART_MCR_DTR) {
+			ni->mstat |= TIOCM_DTR;
+			ni->dtr = TIOCM_DTR;
+		}
+		if (mstat & UART_MCR_RTS) {
+			ni->mstat |= TIOCM_RTS;
+			ni->rts = TIOCM_RTS;
+		}
+		if (mstat & UART_MSR_CTS) {
+			ni->mstat |= TIOCM_CTS;
+			ni->cts = TIOCM_CTS;
+		}
+		if (mstat & UART_MSR_RI) {
+			ni->mstat |= TIOCM_RI;
+			ni->ri = TIOCM_RI;
+		}
+		if (mstat & UART_MSR_DCD) {
+			ni->mstat |= TIOCM_CD;
+			ni->dcd = TIOCM_CD;
+		}
+		if (mstat & UART_MSR_DSR)
+			ni->mstat |= TIOCM_DSR;
+
+		ni->iflag = ch->ch_c_iflag;
+		ni->oflag = ch->ch_c_oflag;
+		ni->cflag = ch->ch_c_cflag;
+		ni->lflag = ch->ch_c_lflag;
+
+		if (ch->ch_flags & CH_STOPI)
+			ni->recv_stopped = 1;
+		else
+			ni->recv_stopped = 0;
+
+		if (ch->ch_flags & CH_STOP)
+			ni->xmit_stopped = 1;
+		else
+			ni->xmit_stopped = 0;
+
+		ni->curtx = ch->ch_txcount;
+		ni->currx = ch->ch_rxcount;
+
+		ni->baud = ch->ch_old_baud;
+
+		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+
+		if (copy_to_user(uarg, &ni, sizeof(ni)))
+			return -EFAULT;
+
+		break;
+	}
+
+	}
+
+	DPRINTK(MGMT, INFO, "finish.\n");
+
+	return 0;
+}

--------------040604030308090703010905--

