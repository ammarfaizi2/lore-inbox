Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVDRPvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVDRPvl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVDRPvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:51:41 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:14978 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262044AbVDRPut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:50:49 -0400
Date: Mon, 18 Apr 2005 10:51:11 -0500
From: mike.miller@hp.com
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com
Subject: [RFC 2 of 9] patches to add diskdump to block layer
Message-ID: <20050418155111.GB25409@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please review this patch and provide comments or feedback.
Patch 2 of 9

Thanks,
mikem
 cciss_diskdump.c |  236 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 236 insertions(+)
--------------------------------------------------------------------------------
Description:
This patch will add the cciss_diskdump.c file to the block subdirectory of
the kernel.  This file contains functions used by the cciss driver to perform
diskdump operations.
--------------------------------------------------------------------------------
diff -burpN old/drivers/block/cciss_diskdump.c new/drivers/block/cciss_diskdump.c
--- old/drivers/block/cciss_diskdump.c	1969-12-31 19:00:00.000000000 -0500
+++ new/drivers/block/cciss_diskdump.c	2005-04-07 20:49:12.000000000 -0400
@@ -0,0 +1,236 @@
+
+#include "cciss_cmd.h"
+
+/* global vars */
+static int quiesce_ok = 0;
+static CommandList_struct *cciss_dump_cmnd;
+static ReadCapdata_struct *size_buff;
+#define BLOCK_SECTOR(s) ((s) << (PAGE_SHIFT - 9))
+
+/* function prototypes */
+void *cciss_probe(kdev_t dev);
+static CommandList_struct * cmd_alloc(ctlr_info_t *h, int get_from_pool);
+static int cciss_dump_sanity_check(void *device);
+static int cciss_sanity_check(int ctlr, int lun);
+static int find_ctlr_lun_ids(int *ctlr, int *lun, __u32 LunID);
+static int cciss_dump_rw_block(void *device, int rw, unsigned long dump_block_nr, void *buf, int len, unsigned long start_sect, unsigned long nr_sects);
+static int cciss_dump_quiesce(void *device);
+static int cciss_dump_shutdown(void *device);
+static unsigned long diskdump_pollcomplete(int ctlr);
+static unsigned int cciss_add_device(void *device);
+static int sendcmd(__u8	cmd,int	ctlr,void *buff,size_t	size, unsigned int use_unit_num, unsigned int log_unit,	__u8	page_code, unsigned char *scsi3addr, int block_nr, int diskdump);
+
+#if (CONFIG_BLOCKDUMP || CONFIG_BLOCKDUMP_MODULE)
+static struct block_dump_ops cciss_dump_device_ops = {
+	.sanity_check	= cciss_dump_sanity_check,
+	.rw_block	= cciss_dump_rw_block,
+	.quiesce	= cciss_dump_quiesce,
+	.shutdown	= cciss_dump_shutdown,
+};
+#endif
+
+/* Start of functions */
+
+/*
+ *   Wait polling for a command to complete.
+ *   The memory mapped FIFO is polled for the completion.
+ *   Used only at dump time, interrupts disabled.
+ */
+static unsigned long diskdump_pollcomplete(int ctlr)
+{
+	unsigned long done;
+
+	while (1){
+		done = hba[ctlr]->access.command_completed(hba[ctlr]);
+		if (done == FIFO_EMPTY){
+			udelay(20);
+			continue;
+		}
+		else
+			return done;
+	}
+}
+
+/*Dummy function.  Nothing to do here. */
+static int cciss_dump_shutdown(void *device) {
+	return 0;
+}
+
+static int cciss_dump_quiesce(void *device) {
+	drive_info_struct *dev = device;
+	int ret, ctlr, lun, temp;
+	char flush_buf[4];
+
+	if(find_ctlr_lun_ids(&ctlr, &lun, dev->LunID)){
+		printk("<1>Could not find controller or LUN.\n");
+		return -1;
+	}
+
+	memset(flush_buf, 0, 4);
+	ret = sendcmd(CCISS_CACHE_FLUSH, ctlr, flush_buf, 4, 0, 0, 0, NULL, 0, 1);
+	if (ret != IO_OK)
+		printk("<1>cciss%d: Error flushing cache\n", ctlr);
+
+	quiesce_ok = 1;
+
+	return 0;
+}
+
+static int cciss_dump_rw_block(void *device, int rw, unsigned long dump_block_nr, void *buf, int len, unsigned long start_sect, unsigned long nr_sects) {
+	drive_info_struct *dev = device;
+	int block_nr = BLOCK_SECTOR(dump_block_nr);
+
+	//this gives the number of bytes to write for len number
+	//of pages of memory.
+	int count = (len * PAGE_SIZE);
+	int ret;
+	int ctlr, lun;
+	__u8 cmd = CCISS_READ;
+
+	if(rw)
+		cmd = CCISS_WRITE;
+
+	if(find_ctlr_lun_ids(&ctlr, &lun, dev->LunID)){
+		printk("<1>Could not find controller or LUN.\n");
+		return -1;
+	}
+
+	if (!quiesce_ok) {
+		printk("<1>quiesce not called\n");
+		return -EIO;
+	}
+
+	/* Calculate start block to be used in the CDB command */
+	block_nr += start_sect;	
+
+
+	if (block_nr + (count/hba[ctlr]->drv[lun].block_size) > nr_sects + start_sect) {
+		printk("<1>block number %d is larger than %lu\n",
+			block_nr + (count/hba[ctlr]->drv[lun].block_size), nr_sects);
+		return -EFBIG;
+	}
+
+	ret = sendcmd(cmd, ctlr, buf, (size_t)count, 1, lun, 0, NULL, block_nr, 1);
+	return ret;
+}
+
+static int cciss_sanity_check(int ctlr, int lun){
+	int block_size;
+	int total_size;
+	int return_code;
+
+	memset(size_buff, 0, sizeof(ReadCapdata_struct));
+
+	return_code = sendcmd(CCISS_READ_CAPACITY, ctlr, size_buff,
+			sizeof(ReadCapdata_struct), 1, lun, 0, NULL, 0, 1);
+
+	if (return_code == IO_OK) {
+		total_size = (0xff & 
+			(unsigned int)(size_buff->total_size[0])) << 24;
+		total_size |= (0xff & 
+			(unsigned int)(size_buff->total_size[1])) << 16;
+		total_size |= (0xff & 
+			(unsigned int)(size_buff->total_size[2])) << 8;
+		total_size |= (0xff & (unsigned int)
+			(size_buff->total_size[3])); 
+		total_size++; 	/* command returns highest */
+				/* block address */
+
+		block_size = (0xff & 
+			(unsigned int)(size_buff->block_size[0])) << 24;
+               	block_size |= (0xff & 
+			(unsigned int)(size_buff->block_size[1])) << 16;
+               	block_size |= (0xff & 
+			(unsigned int)(size_buff->block_size[2])) << 8;
+               	block_size |= (0xff & 
+			(unsigned int)(size_buff->block_size[3]));
+
+	} else {	/* read capacity command failed */ 
+		printk("<1>cciss: read capacity failed\n");
+		return -1;
+	}
+
+	if(hba[ctlr]->drv[lun].nr_blocks != total_size){
+		printk("block_size:%d, blocks:%d, blocks:%d\n", block_size, total_size, hba[ctlr]->drv[lun].nr_blocks );
+		printk("<1>cciss:  blocks read do not match stored value\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*Will set ctlr and lun numbers if found and return 0.  If not found it
+  will return 1 to indicate an error */
+static int find_ctlr_lun_ids(int *ctlr, int *lun, __u32 LunID){
+	int i, j;
+	*ctlr = -1;
+	*lun = -1;
+	for(i=0; i<MAX_CTLR; i++){
+		if(hba[i] != NULL){
+			for(j=0; j<NWD; j++){
+				if(hba[i]->drv[j].LunID == LunID) {
+					*ctlr = i;
+					*lun = j;
+					return 0;
+				}
+			}
+		}
+	}
+
+	return 1;
+}
+
+static int cciss_dump_sanity_check(void *device){
+	drive_info_struct *dev = device;
+	int ctlr, lun;
+	int adapter_sanity = 0;
+	int sanity = 0;
+
+	/* Find the controller and LUN by searching for the LUNID in our list
+           of known devices.  If not found then throw an error */
+	if(find_ctlr_lun_ids(&ctlr, &lun, dev->LunID)){
+		printk("<1>Could not find controller or LUN.\n");
+		sanity=-1;
+		return sanity;
+	}
+
+	/* send a CCISS_READ_CAPACITY command here for the drive.  If the
+	   command succeeds then the drive is online.  Then we will check
+	   that the values we get back match what we have recorded.  That
+           way we can tell if anything has changed */
+	adapter_sanity=cciss_sanity_check(ctlr, lun);
+
+	return sanity + adapter_sanity;
+}
+
+void *cciss_probe(kdev_t dev){
+	static int i=0;
+	int ctlr, target;
+	ctlr_info_t *info_p;
+
+	target = MINOR(dev) >> NWD_SHIFT;
+	ctlr = MAJOR(dev) - MAJOR_NR;
+
+	info_p= hba[ctlr];
+	cciss_dump_cmnd = cmd_alloc(info_p, 0);
+
+	size_buff = kmalloc(sizeof( ReadCapdata_struct), GFP_KERNEL);
+        if (size_buff == NULL) {
+                printk(KERN_ERR "cciss: out of memory\n");
+                return NULL;
+        }
+
+
+	/* If the LUN does not exist on the controller then we must
+	   let diskdump know that this device is not valid */
+	if(hba[ctlr]->drv[target].nr_blocks == 0)
+		return NULL;
+	
+	return (void *)&hba[ctlr]->drv[target];
+}
+
+static unsigned int cciss_add_device(void *device) {
+	drive_info_struct *dev = device;
+	
+	return dev->nr_blocks;
+}
