Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVB0X4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVB0X4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 18:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVB0X4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 18:56:40 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:10390 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261209AbVB0Xjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:39:52 -0500
Message-ID: <42225A47.3060206@us.ltcfwd.linux.ibm.com>
Date: Sun, 27 Feb 2005 18:39:51 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [ patch 4/7] drivers/serial/jsm: new serial device driver
Content-Type: multipart/mixed;
 boundary="------------090600040208030502070307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090600040208030502070307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch is for jsm_proc.c and includes the functions relating to 
/proc/jsm entry.

Signed-off-by: Wen Xiong <wendyx@us.ltcfwd.linux.ibm.com>


--------------090600040208030502070307
Content-Type: text/plain;
 name="patch4.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch4.jasmine"

diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_proc.c linux-2.6.9.new/drivers/serial/jsm/jsm_proc.c
--- linux-2.6.9.orig/drivers/serial/jsm/jsm_proc.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/jsm_proc.c	2005-02-27 17:13:14.339983544 -0600
@@ -0,0 +1,951 @@
+/*
+ * Copyright 2003 Digi International (www.digi.com)
+ *	Scott H Kilau <Scott_Kilau at digi dot com>
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
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *	NOTE TO LINUX KERNEL HACKERS:  DO NOT REFORMAT THIS CODE!
+ *
+ *	This is shared code between Digi's CVS archive and the
+ *	Linux Kernel sources.
+ *	Changing the source just for reformatting needlessly breaks
+ *	our CVS diff history.
+ *
+ *	Send any bug fixes/changes to:  Eng.Linux at digi dot com.
+ *	Thank you.
+ *
+ *
+ * $Id: jsm_proc.c,v 1.38 2004/08/30 21:39:40 scottk Exp $
+ */
+#include <linux/kernel.h>
+#include <linux/version.h>
+#include <linux/sched.h>	/* For jiffies, task states */
+#include <linux/interrupt.h>	/* For tasklet and interrupt structs/defines */
+#include <linux/module.h>
+#include <linux/ctype.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/serial_reg.h>
+#include <linux/sched.h>		/* For in_egroup_p() */
+#include <linux/string.h>
+#include <asm/uaccess.h>		/* For copy_from_user/copy_to_user */
+
+#include "jsm_driver.h"
+#include "jsm_mgmt.h"
+
+/* The /proc/jsm directory */
+static struct proc_dir_entry *ProcJSM;
+
+static void *jsm_info_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void *jsm_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void jsm_info_seq_stop(struct seq_file *seq, void *v)
+{
+
+}
+
+static int jsm_info_seq_show(struct seq_file *seq, void *v)
+{
+
+	seq_printf(seq, "Driver:\t\t%s\n", "jsm - 1.1-1-INKERNEL");
+	seq_printf(seq, "\n");
+	seq_printf(seq, "Debug:\t\t0x%x\n", jsm_debug);
+	seq_printf(seq, "Rawreadok:\t0x%x\n", jsm_rawreadok);
+	seq_printf(seq, "Max Boards:\t%d\n", MAXBOARDS);
+	seq_printf(seq, "Total Boards:\t%d\n", jsm_NumBoards);
+	seq_printf(seq, "Poll counter:\t%ld\n", jsm_poll_counter);
+	seq_printf(seq, "State:\t\t%s\n", jsm_driver_state_text[jsm_driver_state]);
+	return 0;
+
+}
+
+static struct seq_operations jsm_info_seq_ops = {
+	.start = jsm_info_seq_start,
+	.next  = jsm_info_seq_next,
+	.stop  = jsm_info_seq_stop,
+	.show  = jsm_info_seq_show,
+};
+
+static int jsm_info_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	struct proc_dir_entry *proc;
+	int res;
+
+	res = seq_open(file, &jsm_info_seq_ops);
+	if (!res) {
+		/* recover the pointer buried in proc_dir_entry data */
+		seq = file->private_data;
+		proc = PDE(inode);
+		seq->private = proc->data;
+	}
+	return res;
+}
+
+
+static void *jsm_mknod_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void *jsm_mknod_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void jsm_mknod_seq_stop(struct seq_file *seq, void *v)
+{
+
+}
+
+static int jsm_mknod_seq_show(struct seq_file *seq, void *v)
+{
+	int i;
+  	seq_printf(seq, "#\tCreate the management devices.\n");
+
+	for (i = 0; i < MAXMGMTDEVICES; i++) {
+		char tmp[100];
+		sprintf(tmp, "/dev/jsm/mgmt%d", i);
+		seq_printf(seq, "%s\t%d\t%d\t%d\n",
+			tmp, jsm_Major, i, 1);
+	}
+	return 0;
+}
+
+static struct seq_operations jsm_mknod_seq_ops = {
+	.start = jsm_mknod_seq_start,
+	.next  = jsm_mknod_seq_next,
+	.stop  = jsm_mknod_seq_stop,
+	.show  = jsm_mknod_seq_show,
+};
+
+static int jsm_mknod_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	struct proc_dir_entry *proc;
+	int res;
+
+	res = seq_open(file, &jsm_mknod_seq_ops);
+	if (!res) {
+		/* recover the pointer buried in proc_dir_entry data */
+		seq = file->private_data;
+		proc = PDE(inode);
+		seq->private = proc->data;
+	}
+	return res;
+}
+
+static void *jsm_board_info_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void *jsm_board_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void jsm_board_info_seq_stop(struct seq_file *seq, void *v)
+{
+
+}
+
+static int jsm_board_info_seq_show(struct seq_file *seq, void *v)
+{
+	struct board_t	*brd = (struct board_t *) seq->private;
+	char *name;
+
+	DPR_PROC(("jsm_proc_brd_info\n"));
+
+	if (!brd || (brd->magic != JSM_BOARD_MAGIC))
+		return 0;
+
+	name = brd->name;
+
+	seq_printf(seq, "Board Name = %s\n", name);
+	seq_printf(seq, "Board Type = %d\n", brd->type);
+	seq_printf(seq, "Number of Ports = %d\n", brd->nasync);
+
+	/*
+	 * report some things about the PCI bus that are important
+	 * to some applications
+	 */
+	seq_printf(seq, "Vendor ID = 0x%x\n", brd->vendor);
+	seq_printf(seq, "Device ID = 0x%x\n", brd->device);
+	seq_printf(seq, "Subvendor ID = 0x%x\n", brd->subvendor);
+	seq_printf(seq, "Subdevice ID = 0x%x\n", brd->subdevice);
+	seq_printf(seq, "Bus = %d\n", brd->pci_bus);
+	seq_printf(seq, "Slot = %d\n", brd->pci_slot);
+
+	/*
+	 * report the physical addresses assigned to us when we got
+	 * registered
+	 */	
+	seq_printf(seq, "Memory Base Address = 0x%lx\n", brd->membase);
+	seq_printf(seq, "Remapped Memory Base Address = 0x%p\n", brd->re_map_membase);
+
+	seq_printf(seq, "Current state of board = %s\n", jsm_state_text[brd->state]);
+	seq_printf(seq, "Interrupt #: %d. Times interrupted: %ld\n",
+		brd->irq, brd->intr_count);
+	seq_printf(seq, "Majors allocated to board = TTY: %d PR: %d\n",
+		brd->SerialDriver.major, brd->PrintDriver.major);
+
+	return 0;
+}
+
+static struct seq_operations jsm_board_info_seq_ops = {
+	.start = jsm_board_info_seq_start,
+	.next  = jsm_board_info_seq_next,
+	.stop  = jsm_board_info_seq_stop,
+	.show  = jsm_board_info_seq_show,
+};
+
+static int jsm_board_info_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	struct proc_dir_entry *proc;
+	int res;
+
+	res = seq_open(file, &jsm_board_info_seq_ops);
+	if (!res) {
+		/* recover the pointer buried in proc_dir_entry data */
+		seq = file->private_data;
+		proc = PDE(inode);
+		seq->private = proc->data;
+	}
+	return res;
+}
+
+
+static void *jsm_board_stats_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void *jsm_board_stats_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void jsm_board_stats_seq_stop(struct seq_file *seq, void *v)
+{
+
+}
+
+static int jsm_board_stats_seq_show(struct seq_file *seq, void *v)
+{
+	struct board_t	*brd = (struct board_t *) seq->private;
+	int i = 0;
+
+
+	if (!brd || (brd->magic != JSM_BOARD_MAGIC))
+		return 0;
+
+	/* Prepare the Header Labels */
+	seq_printf(seq, "%2s %10s %23s %10s %9s\n",
+		"Ch", "Chars Rx", "  Rx Par--Brk--Frm--Ovr",
+		"Chars Tx", "XON XOFF");
+
+	for (i = 0; i < brd->nasync; i++) {
+
+		struct channel_t *ch = brd->channels[i];
+
+		seq_printf(seq, "%2d ", i);
+		seq_printf(seq, "%10ld ", ch->ch_rxcount);
+		seq_printf(seq, "%4ld %4ld %4ld %4ld ", ch->ch_err_parity,
+			ch->ch_err_break, ch->ch_err_frame, ch->ch_err_overrun);
+		seq_printf(seq, "%10ld ", ch->ch_txcount);
+		seq_printf(seq, "%4ld %4ld ", ch->ch_xon_sends, ch->ch_xoff_sends);
+
+		seq_printf(seq, "\n");
+	}
+
+	return 0;
+}
+
+static struct seq_operations jsm_board_stats_seq_ops = {
+	.start = jsm_board_stats_seq_start,
+	.next  = jsm_board_stats_seq_next,
+	.stop  = jsm_board_stats_seq_stop,
+	.show  = jsm_board_stats_seq_show,
+};
+
+static int jsm_board_stats_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	struct proc_dir_entry *proc;
+	int res;
+
+	res = seq_open(file, &jsm_board_stats_seq_ops);
+	if (!res) {
+		/* recover the pointer buried in proc_dir_entry data */
+		seq = file->private_data;
+		proc = PDE(inode);
+		seq->private = proc->data;
+		}
+
+	return res;
+}
+
+
+static void *jsm_board_flags_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void *jsm_board_flags_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void jsm_board_flags_seq_stop(struct seq_file *seq, void *v)
+{
+
+}
+
+static int jsm_board_flags_seq_show(struct seq_file *seq, void *v)
+{
+	struct board_t	*brd = (struct board_t *) seq->private;
+	int i = 0;
+
+	DPR_PROC(("jsm_proc_brd_info\n"));
+
+	if (!brd || (brd->magic != JSM_BOARD_MAGIC))
+		return 0;
+
+	/* Prepare the Header Labels */
+	seq_printf(seq, "%2s %5s %5s %5s %5s %5s %10s  Line Status Flags\n",
+		"Ch", "CFlag", "IFlag", "OFlag", "LFlag", "DFlag", "Baud");
+
+	for (i = 0; i < brd->nasync; i++) {
+
+		struct channel_t *ch = brd->channels[i];
+
+		seq_printf(seq, "%2d ", i);
+		seq_printf(seq, "%5x ", ch->ch_c_cflag);
+		seq_printf(seq, "%5x ", ch->ch_c_iflag);
+		seq_printf(seq, "%5x ", ch->ch_c_oflag);
+		seq_printf(seq, "%5x ", ch->ch_c_lflag);
+		seq_printf(seq, "%10d ", ch->ch_old_baud);
+
+		if (!ch->ch_open_count)
+			seq_printf(seq, " -- -- -- -- -- -- --") ;
+		else {
+			seq_printf(seq, " op %s %s %s %s %s %s",
+				(ch->ch_mostat & UART_MCR_RTS) ? "rs" : "--",
+				(ch->ch_mistat & UART_MSR_CTS) ? "cs" : "--",
+				(ch->ch_mostat & UART_MCR_DTR) ? "tr" : "--",
+				(ch->ch_mistat & UART_MSR_DSR) ? "mr" : "--",
+				(ch->ch_mistat & UART_MSR_DCD) ? "cd" : "--",
+				(ch->ch_mistat & UART_MSR_RI)  ? "ri" : "--");
+		}
+
+		seq_printf(seq, "\n");
+	}
+
+	return 0;
+}
+
+static struct seq_operations jsm_board_flags_seq_ops = {
+	.start = jsm_board_flags_seq_start,
+	.next  = jsm_board_flags_seq_next,
+	.stop  = jsm_board_flags_seq_stop,
+	.show  = jsm_board_flags_seq_show,
+};
+
+static int jsm_board_flags_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	struct proc_dir_entry *proc;
+	int res;
+
+	res = seq_open(file, &jsm_board_flags_seq_ops);
+	if (!res) {
+		/* recover the pointer buried in proc_dir_entry data */
+		seq = file->private_data;
+		proc = PDE(inode);
+		seq->private = proc->data;
+	}
+
+	return res;
+}
+
+
+
+static void *jsm_board_mknod_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void *jsm_board_mknod_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void jsm_board_mknod_seq_stop(struct seq_file *seq, void *v)
+{
+
+}
+
+static int jsm_board_mknod_seq_show(struct seq_file *seq, void *v)
+{
+	struct board_t	*brd = (struct board_t *) seq->private;
+	char str[MAXTTYNAMELEN];
+
+	DPR_PROC(("jsm_proc_brd_info\n"));
+
+	if (!brd || (brd->magic != JSM_BOARD_MAGIC))
+		return 0;
+
+	/*
+	* For each board, output the device information in
+	* a handy table format...
+	*/
+	seq_printf(seq, "# Create the TTY and PR devices\n");
+
+	/* TTY devices */
+	sprintf(str, "ttyn%d%%p", brd->boardnum + 1);
+	seq_printf(seq, "%s\t\t\t%d\t%d\t%d\n", str,
+		brd->jsm_Serial_Major, 0, brd->maxports);
+
+	/* PR devices */
+	sprintf(str, "prn%d%%p", brd->boardnum + 1);
+	seq_printf(seq, "%s\t\t\t%d\t%d\t%d\n", str,
+		brd->jsm_TransparentPrint_Major, 128, brd->maxports);
+
+	return 0;
+}
+
+static struct seq_operations jsm_board_mknod_seq_ops = {
+	.start = jsm_board_mknod_seq_start,
+	.next  = jsm_board_mknod_seq_next,
+	.stop  = jsm_board_mknod_seq_stop,
+	.show  = jsm_board_mknod_seq_show,
+};
+
+static int jsm_board_mknod_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	struct proc_dir_entry *proc;
+	int res;
+
+	res = seq_open(file, &jsm_board_mknod_seq_ops);
+	if (!res) {
+		/* recover the pointer buried in proc_dir_entry data */
+		seq = file->private_data;
+		proc = PDE(inode);
+		seq->private = proc->data;
+	}
+
+	return res;
+}
+
+
+static void *jsm_channel_info_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void *jsm_channel_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void jsm_channel_info_seq_stop(struct seq_file *seq, void *v)
+{
+
+}
+
+static int jsm_channel_info_seq_show(struct seq_file *seq, void *v)
+{
+	struct channel_t	*ch = (struct channel_t *) seq->private;
+
+	DPR_PROC(("jsm_proc_info\n"));
+
+	if (!ch || (ch->magic != JSM_CHANNEL_MAGIC))
+		return 0;
+
+	seq_printf(seq, "Port number:\t\t%d\n", ch->ch_portnum);
+	seq_printf(seq, "\n");
+
+	/* Prepare the Header Labels */ 
+	seq_printf(seq, "%10s %23s %10s %9s\n",
+		"Chars Rx", "  Rx Par--Brk--Frm--Ovr",
+		"Chars Tx", "XON XOFF");
+	seq_printf(seq, "%10ld ", ch->ch_rxcount);
+	seq_printf(seq, "%4ld %4ld %4ld %4ld ", ch->ch_err_parity,
+		ch->ch_err_break, ch->ch_err_frame, ch->ch_err_overrun);
+	seq_printf(seq, "%10ld ", ch->ch_txcount);  
+	seq_printf(seq, "%4ld %4ld ", ch->ch_xon_sends, ch->ch_xoff_sends);
+	seq_printf(seq, "\n\n");
+
+	/* Prepare the Header Labels */
+	seq_printf(seq, "%5s %5s %5s %5s %5s %10s  Line Status Flags\n",
+		"CFlag", "IFlag", "OFlag", "LFlag", "DFlag", "Baud");
+
+	seq_printf(seq, "%5x ", ch->ch_c_cflag);
+	seq_printf(seq, "%5x ", ch->ch_c_iflag);
+	seq_printf(seq, "%5x ", ch->ch_c_oflag);
+	seq_printf(seq, "%5x ", ch->ch_c_lflag);
+	seq_printf(seq, "%10d ", ch->ch_old_baud);
+	if (!ch->ch_open_count)
+		seq_printf(seq, " -- -- -- -- -- -- --") ;
+	else {
+		seq_printf(seq, " op %s %s %s %s %s %s", 
+		(ch->ch_mostat & UART_MCR_RTS) ? "rs" : "--",
+		(ch->ch_mistat & UART_MSR_CTS) ? "cs" : "--",
+		(ch->ch_mostat & UART_MCR_DTR) ? "tr" : "--",
+		(ch->ch_mistat & UART_MSR_DSR) ? "mr" : "--",
+		(ch->ch_mistat & UART_MSR_DCD) ? "cd" : "--",
+		(ch->ch_mistat & UART_MSR_RI)  ? "ri" : "--");
+	} 
+	seq_printf(seq, "\n\n");
+
+	return 0;
+}
+
+static struct seq_operations jsm_channel_info_seq_ops = {
+	.start = jsm_channel_info_seq_start,
+	.next  = jsm_channel_info_seq_next,
+	.stop  = jsm_channel_info_seq_stop,
+	.show  = jsm_channel_info_seq_show,
+};
+
+static int jsm_channel_info_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	struct proc_dir_entry *proc;
+	int res;
+
+	res = seq_open(file, &jsm_channel_info_seq_ops);
+	if (!res) {
+		/* recover the pointer buried in proc_dir_entry data */
+		seq = file->private_data;
+		proc = PDE(inode);
+		seq->private = proc->data;
+	}
+
+	return res;
+}
+
+
+static void *jsm_channel_sniff_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	ulong  lock_flags;
+	struct channel_t	*ch = (struct channel_t *) seq->private;
+
+	if (!ch || (ch->magic != JSM_CHANNEL_MAGIC))
+		return NULL;
+
+	ch->ch_sniff_buf = kmalloc(SNIFF_MAX, GFP_KERNEL);
+	memset(ch->ch_sniff_buf, 0, SNIFF_MAX);
+
+	spin_lock_irqsave(&ch->ch_lock, lock_flags);
+	ch->ch_sniff_flags |= SNIFF_OPEN;
+	spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+
+	return (void *)1;
+}
+
+static void *jsm_channel_sniff_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	if (*pos > 0)
+		return NULL;
+	else
+		return (void *)1;
+}
+
+static void jsm_channel_sniff_seq_stop(struct seq_file *seq, void *v)
+{
+ 	ulong  lock_flags;
+	struct channel_t	*ch = (struct channel_t *) seq->private;
+
+	spin_lock_irqsave(&ch->ch_lock, lock_flags);
+	ch->ch_sniff_flags &= ~(SNIFF_OPEN);
+	kfree(ch->ch_sniff_buf);
+	spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+}
+
+
+static int jsm_channel_sniff_seq_show(struct seq_file *seq, void *v)
+{
+
+	struct channel_t	*ch = (struct channel_t *) seq->private;
+	int n;
+	int r;
+	int offset = 0;
+	int res = 0;
+	ssize_t rtn = 0;
+	ulong  lock_flags;
+	int count;
+	if (!ch || (ch->magic != JSM_CHANNEL_MAGIC)) {
+		rtn = -ENXIO;
+		goto done;
+	}
+
+	/*
+	 *  Wait for some data to appear in the buffer.
+	 */
+	spin_lock_irqsave(&ch->ch_lock, lock_flags);
+
+	for (;;) {
+		n = (ch->ch_sniff_in - ch->ch_sniff_out) & SNIFF_MASK;
+
+		if (n != 0)
+			break;
+
+		ch->ch_sniff_flags |= SNIFF_WAIT_DATA;
+
+		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+
+		/*
+		 * Go to sleep waiting until the condition becomes true.
+		 */
+		rtn = wait_event_interruptible(ch->ch_sniff_wait,
+			((ch->ch_sniff_flags & SNIFF_WAIT_DATA) == 0));
+
+		if (rtn)
+			goto done;
+
+		spin_lock_irqsave(&ch->ch_lock, lock_flags);
+	}
+
+	/*
+	 *  Read whatever is there.
+	 */
+
+	res = n;
+
+	r = SNIFF_MAX - ch->ch_sniff_out;
+
+	if (r <= n) {
+		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+		if (rtn) {
+			rtn = -EFAULT;
+			goto done;
+		}
+
+		spin_lock_irqsave(&ch->ch_lock, lock_flags);
+
+		ch->ch_sniff_out = 0;
+		n -= r;
+		offset = r;
+	}
+
+	spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+	seq_printf(seq, "in =%d out=%d\n",ch->ch_sniff_in,ch->ch_sniff_out);
+	seq_printf(seq, "first=%x\n",ch->ch_sniff_buf[5]);
+	seq_printf(seq, "first=%x\n",ch->ch_sniff_buf[6]);
+	for (count = 0; count < n; count++) {
+		seq_printf(seq, "%x ",ch->ch_sniff_buf[ch->ch_sniff_out++]);
+	}
+	if (rtn) {
+		rtn = -EFAULT;
+		goto done;
+	}
+	spin_lock_irqsave(&ch->ch_lock, lock_flags);
+
+	seq_printf(seq,"\n");
+	seq_printf(seq, "in =%d out=%d\n",ch->ch_sniff_in,ch->ch_sniff_out);
+
+	/*
+	 *  Wakeup any thread waiting for buffer space.
+	 */
+
+	if (ch->ch_sniff_flags & SNIFF_WAIT_SPACE) {
+		ch->ch_sniff_flags &= ~SNIFF_WAIT_SPACE;
+		wake_up_interruptible(&ch->ch_sniff_wait);
+	}
+
+	spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+
+done:
+	return rtn;
+}
+
+static struct seq_operations jsm_channel_sniff_seq_ops = {
+	.start = jsm_channel_sniff_seq_start,
+	.next  = jsm_channel_sniff_seq_next,
+	.stop  = jsm_channel_sniff_seq_stop,
+	.show  = jsm_channel_sniff_seq_show,
+};
+
+static int jsm_channel_sniff_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	struct proc_dir_entry *proc;
+	int res;
+
+	res = seq_open(file, &jsm_channel_sniff_seq_ops);
+	if (!res) {
+		/* recover the pointer buried in proc_dir_entry data */
+		seq = file->private_data;
+		proc = PDE(inode);
+		seq->private = proc->data;
+	}
+
+	return res;
+}
+
+
+static struct file_operations jsm_info_operations = {
+	.open	= jsm_info_open,
+	.read	= seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
+static struct file_operations jsm_mknod_operations = {
+	.open	= jsm_mknod_open,
+	.read	= seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
+static struct file_operations jsm_board_info_operations = {
+	.open	= jsm_board_info_open,
+	.read	= seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
+static struct file_operations jsm_board_stats_operations = {
+	.open	= jsm_board_stats_open,
+	.read	= seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
+static struct file_operations jsm_board_flags_operations = {
+	.open	= jsm_board_flags_open,
+	.read	= seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
+static struct file_operations jsm_board_mknod_operations = {
+	.open	= jsm_board_mknod_open,
+	.read	= seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
+static struct file_operations jsm_channel_info_operations = 
+{
+	.open	= jsm_channel_info_open,
+	.read	= seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
+static struct file_operations jsm_channel_sniff_operations = 
+{
+	.open	= jsm_channel_sniff_open,
+	.read	= seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
+/*
+ * Register the basic /proc/jsm files that appear whenever
+ * the driver is loaded.
+ */
+void jsm_proc_register_basic_prescan(void)
+{
+	/*
+	 *Register /proc/jsm
+	 */
+
+	struct proc_dir_entry *entry;
+
+	ProcJSM = proc_mkdir("jsm",&proc_root);
+	if (ProcJSM)
+		ProcJSM->owner = THIS_MODULE;
+	else
+		printk(KERN_WARNING "cann't create /proc/net/jsm\n");
+
+	entry = create_proc_entry("info", S_IRUGO, ProcJSM);
+	if (entry)
+		entry->proc_fops = &jsm_info_operations;
+
+	entry = create_proc_entry("mknod", S_IRUGO, ProcJSM);
+	if (entry)
+		entry->proc_fops = &jsm_mknod_operations;
+}
+
+
+/*
+ * Register the basic /proc/jsm files that appear whenever
+ * the driver is loaded.
+ */
+int jsm_proc_register_basic_postscan(int board_num)
+{
+	int i;
+	char board[10];
+	struct proc_dir_entry *e, *board_e, *channel_e;
+	sprintf(board, "%d", board_num);
+
+	/* Set proc board entry pointer */
+	board_e = jsm_Board[board_num]->proc_entry_pointer = proc_mkdir(board, ProcJSM);
+
+	e = create_proc_entry("info", S_IRUGO, board_e);
+	if (!e)
+		return -ENOMEM;
+	e->proc_fops = &jsm_board_info_operations;
+	e->data = jsm_Board[board_num];
+
+
+	e = create_proc_entry("stats", S_IRUGO, board_e);
+	if (!e)
+		return -ENOMEM;
+	e->proc_fops = &jsm_board_stats_operations;
+	e->data = jsm_Board[board_num];
+
+	e = create_proc_entry("flags", S_IRUGO, board_e);
+	if (!e)
+		return -ENOMEM;
+	e->proc_fops = &jsm_board_flags_operations;
+	e->data = jsm_Board[board_num];
+
+	e = create_proc_entry("mknod", S_IRUGO, board_e);
+	if (!e)
+		return -ENOMEM;
+	e->proc_fops = &jsm_board_mknod_operations;
+	e->data = jsm_Board[board_num];
+
+	/*
+	 * Add new entries for each port.
+	 */
+	for (i = 0; i < jsm_Board[board_num]->nasync; i++) {
+
+		char channel[10];
+		sprintf(channel, "%d", i);
+
+		channel_e = jsm_Board[board_num]->channels[i]->proc_entry_pointer = proc_mkdir(channel,board_e);
+
+		e = create_proc_entry("info", S_IRUGO, channel_e);
+		if (!e)
+			return -ENOMEM;
+		e->proc_fops = &jsm_channel_info_operations;
+		e->data = jsm_Board[board_num]->channels[i];
+
+		e = create_proc_entry("sniff", S_IRUGO, channel_e);
+		if (!e)
+			return -ENOMEM;
+		e->proc_fops = &jsm_channel_sniff_operations;
+		e->data = jsm_Board[board_num]->channels[i];
+
+	}
+
+	return 0;
+}
+
+
+
+void jsm_proc_unregister_brd(int brd_number)
+{
+	int i = 0, j = 0;
+
+	i = brd_number;
+
+	char board_number[16];
+	sprintf(board_number,"%d",i);
+
+
+	for (j = 0; j < jsm_Board[i]->nasync; j++) {
+
+		char channel_number[16];
+		sprintf(channel_number,"%d",j);
+
+		remove_proc_entry("info",jsm_Board[i]->channels[j]->proc_entry_pointer);
+		remove_proc_entry("sniff",jsm_Board[i]->channels[j]->proc_entry_pointer);
+		remove_proc_entry(channel_number,jsm_Board[i]->proc_entry_pointer);
+
+	}
+
+	remove_proc_entry("info",jsm_Board[i]->proc_entry_pointer);
+	remove_proc_entry("mknod",jsm_Board[i]->proc_entry_pointer);
+	remove_proc_entry("flags",jsm_Board[i]->proc_entry_pointer);
+	remove_proc_entry("stats",jsm_Board[i]->proc_entry_pointer);
+	remove_proc_entry(board_number,ProcJSM);
+
+}
+
+void jsm_proc_unregister_all(void)
+{
+
+	/* Blow away the top proc entry */
+	remove_proc_entry("info",ProcJSM);
+	remove_proc_entry("mknod",ProcJSM);
+	remove_proc_entry("jsm", &proc_root);
+}

--------------090600040208030502070307--

