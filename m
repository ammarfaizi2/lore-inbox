Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUGFJJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUGFJJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 05:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUGFJJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 05:09:27 -0400
Received: from av3-1-sn1.fre.skanova.net ([81.228.11.109]:42642 "EHLO
	av3-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S263733AbUGFJJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 05:09:19 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
References: <m2lli36ec9.fsf@telia.com> <20040704130544.GA3825@infradead.org>
	<m2llhz5o4o.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Jul 2004 10:45:27 +0200
In-Reply-To: <m2llhz5o4o.fsf@telia.com>
Message-ID: <m2britikwo.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Christoph Hellwig <hch@infradead.org> writes:
> 
> > > +static int pkt_proc_device(struct pktcdvd_device *pd, char *buf)
> > > +{
> > 
> > seq_file interface please, or even better a one value per file sysfs
> > interface.
> 
> I'll work on this tomorrow too.

I don't know if there's any point converting this to the sysfs
interface, since the proc file only contains a bunch of read-only
values which are mostly only useful for debugging.

Anyway, here is a patch to convert it to seq_file.

-----------------

Convert the /proc code in the pktcdvd driver to use the seq_file
interface.

Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/drivers/block/pktcdvd.c |   97 ++++++++++++++++-------------------
 1 files changed, 47 insertions(+), 50 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-seqfile drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-seqfile	2004-07-06 01:37:31.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-07-06 03:33:44.000000000 +0200
@@ -43,6 +43,7 @@
 #include <linux/spinlock.h>
 #include <linux/file.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
 #include <linux/devfs_fs_kernel.h>
 #include <linux/suspend.h>
@@ -2275,28 +2276,29 @@ static void pkt_init_queue(struct pktcdv
 	q->queuedata = pd;
 }
 
-static int pkt_proc_device(struct pktcdvd_device *pd, char *buf)
+static int pkt_seq_show(struct seq_file *m, void *p)
 {
-	char *b = buf, *msg;
+	struct pktcdvd_device *pd = m->private;
+	char *msg;
 	char bdev_buf[BDEVNAME_SIZE];
 	int states[PACKET_NUM_STATES];
 
-	b += sprintf(b, "\nWriter %s mapped to %s:\n", pd->name,
-		     __bdevname(pd->dev, bdev_buf));
+	seq_printf(m, "Writer %s mapped to %s:\n", pd->name,
+		   __bdevname(pd->dev, bdev_buf));
 
-	b += sprintf(b, "\nSettings:\n");
-	b += sprintf(b, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
+	seq_printf(m, "\nSettings:\n");
+	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
 
 	if (pd->settings.write_type == 0)
 		msg = "Packet";
 	else
 		msg = "Unknown";
-	b += sprintf(b, "\twrite type:\t\t%s\n", msg);
+	seq_printf(m, "\twrite type:\t\t%s\n", msg);
 
-	b += sprintf(b, "\tpacket type:\t\t%s\n", pd->settings.fp ? "Fixed" : "Variable");
-	b += sprintf(b, "\tlink loss:\t\t%d\n", pd->settings.link_loss);
+	seq_printf(m, "\tpacket type:\t\t%s\n", pd->settings.fp ? "Fixed" : "Variable");
+	seq_printf(m, "\tlink loss:\t\t%d\n", pd->settings.link_loss);
 
-	b += sprintf(b, "\ttrack mode:\t\t%d\n", pd->settings.track_mode);
+	seq_printf(m, "\ttrack mode:\t\t%d\n", pd->settings.track_mode);
 
 	if (pd->settings.block_mode == PACKET_BLOCK_MODE1)
 		msg = "Mode 1";
@@ -2304,61 +2306,52 @@ static int pkt_proc_device(struct pktcdv
 		msg = "Mode 2";
 	else
 		msg = "Unknown";
-	b += sprintf(b, "\tblock mode:\t\t%s\n", msg);
+	seq_printf(m, "\tblock mode:\t\t%s\n", msg);
 
-	b += sprintf(b, "\nStatistics:\n");
-	b += sprintf(b, "\tpackets started:\t%lu\n", pd->stats.pkt_started);
-	b += sprintf(b, "\tpackets ended:\t\t%lu\n", pd->stats.pkt_ended);
-	b += sprintf(b, "\twritten:\t\t%lukB\n", pd->stats.secs_w >> 1);
-	b += sprintf(b, "\tread gather:\t\t%lukB\n", pd->stats.secs_rg >> 1);
-	b += sprintf(b, "\tread:\t\t\t%lukB\n", pd->stats.secs_r >> 1);
-
-	b += sprintf(b, "\nMisc:\n");
-	b += sprintf(b, "\treference count:\t%d\n", pd->refcnt);
-	b += sprintf(b, "\tflags:\t\t\t0x%lx\n", pd->flags);
-	b += sprintf(b, "\tread speed:\t\t%ukB/s\n", pd->read_speed * 150);
-	b += sprintf(b, "\twrite speed:\t\t%ukB/s\n", pd->write_speed * 150);
-	b += sprintf(b, "\tstart offset:\t\t%lu\n", pd->offset);
-	b += sprintf(b, "\tmode page offset:\t%u\n", pd->mode_offset);
+	seq_printf(m, "\nStatistics:\n");
+	seq_printf(m, "\tpackets started:\t%lu\n", pd->stats.pkt_started);
+	seq_printf(m, "\tpackets ended:\t\t%lu\n", pd->stats.pkt_ended);
+	seq_printf(m, "\twritten:\t\t%lukB\n", pd->stats.secs_w >> 1);
+	seq_printf(m, "\tread gather:\t\t%lukB\n", pd->stats.secs_rg >> 1);
+	seq_printf(m, "\tread:\t\t\t%lukB\n", pd->stats.secs_r >> 1);
+
+	seq_printf(m, "\nMisc:\n");
+	seq_printf(m, "\treference count:\t%d\n", pd->refcnt);
+	seq_printf(m, "\tflags:\t\t\t0x%lx\n", pd->flags);
+	seq_printf(m, "\tread speed:\t\t%ukB/s\n", pd->read_speed * 150);
+	seq_printf(m, "\twrite speed:\t\t%ukB/s\n", pd->write_speed * 150);
+	seq_printf(m, "\tstart offset:\t\t%lu\n", pd->offset);
+	seq_printf(m, "\tmode page offset:\t%u\n", pd->mode_offset);
 
-	b += sprintf(b, "\nQueue state:\n");
-	b += sprintf(b, "\tbios queued:\t\t%s\n", pd->bio_queue ? "yes" : "no");
+	seq_printf(m, "\nQueue state:\n");
+	seq_printf(m, "\tbios queued:\t\t%s\n", pd->bio_queue ? "yes" : "no");
 
 	pkt_count_states(pd, states);
-	b += sprintf(b, "\tstate:\t\t\ti:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
-		     states[0], states[1], states[2], states[3], states[4], states[5]);
+	seq_printf(m, "\tstate:\t\t\ti:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
+		   states[0], states[1], states[2], states[3], states[4], states[5]);
 
-	return b - buf;
+	return 0;
 }
 
-static int pkt_read_proc(char *page, char **start, off_t off, int count, int *eof, void *data)
+static int pkt_seq_open(struct inode *inode, struct file *file)
 {
-	struct pktcdvd_device *pd = data;
-	char *buf = page;
-	int len;
-
-	len = pkt_proc_device(pd, buf);
-	buf += len;
-
-	if (len <= off + count)
-		*eof = 1;
-
-	*start = page + off;
-	len -= off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
-
-	return len;
+	return single_open(file, pkt_seq_show, PDE(inode)->data);
 }
 
+static struct file_operations pkt_proc_fops = {
+	.open	= pkt_seq_open,
+	.read	= seq_read,
+	.llseek	= seq_lseek,
+	.release = single_release
+};
+
 static int pkt_new_dev(struct pktcdvd_device *pd, struct block_device *bdev)
 {
 	dev_t dev = bdev->bd_dev;
 	int i;
 	int ret = 0;
 	char b[BDEVNAME_SIZE];
+	struct proc_dir_entry *proc;
 
 	for (i = 0; i < MAX_WRITERS; i++) {
 		if (pkt_devs[i].dev == dev) {
@@ -2391,7 +2384,11 @@ static int pkt_new_dev(struct pktcdvd_de
 		goto out_thread;
 	}
 
-	create_proc_read_entry(pd->name, 0, pkt_proc, pkt_read_proc, pd);
+	proc = create_proc_entry(pd->name, 0, pkt_proc);
+	if (proc) {
+		proc->data = pd;
+		proc->proc_fops = &pkt_proc_fops;
+	}
 	DPRINTK("pktcdvd: writer %s mapped to %s\n", pd->name, bdevname(bdev, b));
 	return 0;
 
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
