Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRCZWEJ>; Mon, 26 Mar 2001 17:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRCZWEA>; Mon, 26 Mar 2001 17:04:00 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:39567 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S129436AbRCZWDv>; Mon, 26 Mar 2001 17:03:51 -0500
Date: Mon, 26 Mar 2001 14:03:04 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <mc@CS.Stanford.EDU>
Subject: [CHECKER] Questions about  *_do_scsi & create_proc_entry
Message-ID: <Pine.GSO.4.31.0103261400360.2886-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

   I have a question about *_do_scsi(Scsi_Request *SRpnt, ...). If *SRpnt
is not NULL, *_do_scsi will not return NULL. I'm not quite sure about the
precondition in the following three 'errors' flaged by the NULL checker.
In these cases, can
*_do_scsi return NULL?

   Another question is that by inspecting the NULL checker's result, I
found that *_do_scsi is always used in the following way "SRpnt =
*_do_scsi(SRPnt, ...)" no matther SRPnt is NULL or not. If SRpnt is not
NULL, why don't just use
     *_do_scsi(SRPnt, ...);
The same thing happens to init_etherdev.

   Last question: we found 3 potential errors in arch/i386/kernel. It
seems that create_proc_entry could return NULL. Please help us to verify
if they are bugs or not.

   As usual, please CC us at mc@cs.stanford.edu. Any help will be
appreciated.

-Junfeng


---------------------------------------------------------
[UNKNOWN] osst_do_scsi will never return NULL if argument SRpnt isn't
NULL. But they copy SRpnt back by *aSRpnt, implies it could be NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/osst.c:1145:osst_read_back_buffer_and_rewrite:
ERROR:NULL:1042:1145: Using unknown ptr "SRpnt" illegally! set by
'osst_do_scsi':1042

	for (i = 0, p = buffer; i < frames; i++, p += OS_DATA_SIZE) {

		memset(cmd, 0, MAX_COMMAND_SIZE);
		cmd[0] = 0x3C;		/* Buffer Read           */
		cmd[1] = 6;		/* Retrieve Faulty Block */
		cmd[7] = 32768 >> 8;
		cmd[8] = 32768 & 0xff;
Start --->
		SRpnt = osst_do_scsi(SRpnt, STp, cmd, OS_FRAME_SIZE,
SCSI_DATA_READ,
					    STp->timeout, MAX_RETRIES,
TRUE);

		if ((STp->buffer)->syscall_result) {
			printk(KERN_ERR "osst%d: Failed to read block back
from OnStream buffer\n", dev);
			vfree((void *)buffer);
			*aSRpnt = SRpnt;
			return (-EIO);
		}
		osst_copy_from_buffer(STp->buffer, p);
//		memcpy(p, STp->buffer->b_data, OS_DATA_SIZE);
#if DEBUG
		if (debugging)
			printk(OSST_DEB_MSG "osst%d: Read back logical
block %d, data %x %x %x %x\n",
					  dev, logical_blk_num + i, p[0],
p[1], p[2], p[3]);
#endif
	}

SRpnt is copied back
through *aSRpnt here
------>
	*aSRpnt = SRpnt;
---------------------------------------------------------
[UNKNOWN]
/u2/acc/oses/linux/2.4.1/drivers/scsi/osst.c:1145:osst_read_back_buffer_and_rewrite:
ERROR:NULL:1111:1145: Using unknown ptr "SRpnt" illegally! set by
'osst_do_scsi':1111
---------------------------------------------------------
[UNKNOWN] osst_do_scsi can return NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/osst.c:1243:osst_reposition_and_retry:
ERROR:NULL:1237:1243: Using unknown ptr "SRpnt" illegally! set by
'osst_do_scsi':1237
#if DEBUG
			printk(OSST_DEB_MSG "osst%d: About to write
pending lblk %d at frame %d\n",
					  dev, STp->logical_blk_num-1,
STp->first_frame_position);
#endif

Start--->
			SRpnt = osst_do_scsi(SRpnt, STp, cmd,
OS_FRAME_SIZE, SCSI_DATA_WRITE,
						    STp->timeout,
MAX_WRITE_RETRIES, TRUE);

Copied back here --->
			*aSRpnt = SRpnt;

			if (STp->buffer->syscall_result) {		/*
additional write error */
				if ((SRpnt->sr_sense_buffer[ 2] & 0x0f) ==
13 &&
				     SRpnt->sr_sense_buffer[12]         ==
0 &&
				     SRpnt->sr_sense_buffer[13]         ==
2) {


---------------------------------------------------------
[UNKNOWN] create_proc_entry
/u2/acc/oses/linux/2.4.1/arch/i386/kernel/irq.c:1160:init_irq_proc:
ERROR:NULL:1158:1160: Using unknown ptr "entry" illegally! set by
'create_proc_entry':1158

	root_irq_dir = proc_mkdir("irq", 0);

	/* create /proc/irq/prof_cpu_mask */
Start-->
	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
Error-->
	entry->nlink = 1;
	entry->data = (void *)&prof_cpu_mask;
	entry->read_proc = prof_cpu_mask_read_proc;
	entry->write_proc = prof_cpu_mask_write_proc;


---------------------------------------------------------
[UNKNOWN] create_proc_entry can return NULL
/u2/acc/oses/linux/2.4.1/arch/i386/kernel/irq.c:1139:register_irq_proc:
ERROR:NULL:1137:1139: Using unknown ptr "entry" illegally! set by
'create_proc_entry':1137
	irq_dir[irq] = proc_mkdir(name, root_irq_dir);


	/* create /proc/irq/1234/smp_affinity */
Start-->
	entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
Error-->
	entry->nlink = 1;
	entry->data = (void *)(long)irq;
	entry->read_proc = irq_affinity_read_proc;

---------------------------------------------------------
[UNKNOWN] create_proc_entry
/u2/acc/oses/linux/2.4.1/arch/i386/kernel/mtrr.c:2075:mtrr_init:
ERROR:NULL:2074:2075: Using unknown ptr "proc_root_mtrr" illegally! set by
'create_proc_entry':2074

#ifdef CONFIG_PROC_FS
Start-->
    proc_root_mtrr = create_proc_entry ("mtrr", S_IWUSR | S_IRUGO,
&proc_root);
Error-->
    proc_root_mtrr->owner = THIS_MODULE;
    proc_root_mtrr->proc_fops = &mtrr_fops;
#endif

---------------------------------------------------------



