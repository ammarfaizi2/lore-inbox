Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbTEBGbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 02:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTEBGbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 02:31:06 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:51638 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261860AbTEBGbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 02:31:04 -0400
Date: Thu, 1 May 2003 23:43:22 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mc@cs.stanford.edu
Subject: [CHECKER] 4 potential user-pointer errors
In-Reply-To: <Pine.GSO.4.44.0305011353180.28997-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0305012334140.7454-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Enclosed are 4 more potential bugs where user pointer is dereferenced.
Please note the word "Callstack" in the bug report doesn't always mean a
call. We link functions together if they are assigned to the same struct
field.

Please confirm or clarify. Thanks!

-Junfeng

---------------------------------------------------------
[BUG] at least bad programming practice. file_operations.write ->
cm_write -> trans_ac3. write can take tainted. write can take tainted
inputs. the pointer is vefied in cm_write

/home/junfeng/linux-2.5.63/sound/oss/cmpci.c:593:trans_ac3:
ERROR:TAINTED:593:593: dereferencing tainted ptr 'src' [Callstack:
/home/junfeng/linux-2.5.63/fs/read_write.c:307:vfs_write((tainted
1)(tainted 2)) ->
/home/junfeng/linux-2.5.63/fs/read_write.c:241:cm_write((tainted
1)(tainted 2)) ->
/home/junfeng/linux-2.5.63/sound/oss/cmpci.c:1662:trans_ac3((tainted
2))]

	unsigned long data;
	unsigned long *dst = (unsigned long *) dest;
	unsigned short *src = (unsigned short *)source;

	do {

Error --->
		data = (unsigned long) *src++;
		data <<= 12;			// ok for 16-bit data
		if (s->spdif_counter == 2 || s->spdif_counter == 3)
			data |= 0x40000000;	// indicate AC-3 raw
data
---------------------------------------------------------
[BUG] at least bad programming practice. file_opetations.ioctl ->
aac_cfg_ioctl -> aac_do_ioctl -> close_getadapter_fib ->
aac_close_fib_context. All other functions called by aac_do_ioctl assume
arg is a user pointer. It is unknown what will happen.

/home/junfeng/linux-2.5.63/drivers/scsi/aacraid/commctrl.c:277:aac_close_fib_context:
ERROR:TAINTED:277:277: dereferencing tainted ptr 'fibctx' [Callstack:
/home/junfeng/linux-2.5.63/drivers/scsi/sg.c:1002:aac_cfg_ioctl((tainted
3)) ->
/home/junfeng/linux-2.5.63/drivers/scsi/aacraid/linit.c:671:aac_do_ioctl((tainted
2)) ->
/home/junfeng/linux-2.5.63/drivers/scsi/aacraid/commctrl.c:421:close_getadapter_fib((tainted
1)) ->
/home/junfeng/linux-2.5.63/drivers/scsi/aacraid/commctrl.c:348:aac_close_fib_context((tainted
1))]

	while (!list_empty(&fibctx->fibs)) {
		struct list_head * entry;
		/*
		 *	Pull the next fib from the fibs
		 */

Error --->
		entry = fibctx->fibs.next;
		list_del(entry);
		fib = list_entry(entry, struct hw_fib, header.FibLinks);
		fibctx->count--;
---------------------------------------------------------
[BUG] at least bad programming practice. zoran_read and vbi_read are
both assigned to video_device.read, while zoran_read assumes "buf" is
tainted. The pointer is verified by access_ok

/home/junfeng/linux-2.5.63/drivers/media/video/zr36120.c:1698:vbi_read:
ERROR:TAINTED:1698:1698: dereferencing tainted ptr 'optr' [Callstack:
/home/junfeng/linux-2.5.63/drivers/media/video/zr36120.c:934:vbi_read((tainted
1))]

		{
			/* copy to doubled data to userland */
			for (x=0; optr+1<eptr && x<-done->w; x++)
			{
				unsigned char a = iptr[x*2];

Error --->
				*optr++ = a;
				*optr++ = a;
			}
			/* and clear the rest of the line */
---------------------------------------------------------
[BUG] at least bad programming practice. calls access_ok on
qv.packet_sizes, then passed qv.packet_sizes into
initialize_dma_it_prg_var_packet_queue.

/home/junfeng/linux-2.5.63/drivers/ieee1394/video1394.c:668:initialize_dma_it_prg_var_packet_queue:
ERROR:TAINTED:668:668: dereferencing tainted ptr 'packet_sizes + i * 4'
[Callstack:
/home/junfeng/linux-2.5.63/drivers/ieee1394/video1394.c:1047:initialize_dma_it_prg_var_packet_queue((tainted
2))]

	for (i = 0; i < d->nb_cmd; i++) {
		unsigned int size;
		if (packet_sizes[i] > d->packet_size) {
			size = d->packet_size;
		} else {

Error --->
			size = packet_sizes[i];
		}
		it_prg[i].data[1] = cpu_to_le32(size << 16);
		it_prg[i].end.control = cpu_to_le32(DMA_CTL_OUTPUT_LAST
| DMA_CTL_BRANCH);

