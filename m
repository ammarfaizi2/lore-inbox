Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265292AbUGAODj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265292AbUGAODj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUGAODi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:03:38 -0400
Received: from av9-1-sn1.fre.skanova.net ([81.228.11.115]:14518 "EHLO
	av9-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S265292AbUGANyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 09:54:33 -0400
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] CDRW packet writing support for 2.6.7-bk13
From: Peter Osterlund <petero2@telia.com>
Date: 01 Jul 2004 15:34:30 +0200
Message-ID: <m2lli36ec9.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements CDRW packet writing as a kernel block device.
Usage instructions are in the packet-writing.txt file.

A hint: If you don't want to wait for a complete disc format, you can
format just a part of the disc. For example:

        cdrwtool -d /dev/hdc -m 10240

This will format 10240 blocks, ie 20MB.


Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/Documentation/cdrom/00-INDEX           |    2 
 linux-petero/Documentation/cdrom/packet-writing.txt |   22 
 linux-petero/drivers/block/Kconfig                  |   32 
 linux-petero/drivers/block/Makefile                 |    1 
 linux-petero/drivers/block/pktcdvd.c                | 2654 ++++++++++++++++++++
 linux-petero/drivers/cdrom/Makefile                 |    1 
 linux-petero/drivers/ide/ide-cd.c                   |    6 
 linux-petero/drivers/scsi/sr.c                      |    6 
 linux-petero/include/linux/cdrom.h                  |    1 
 linux-petero/include/linux/major.h                  |    2 
 linux-petero/include/linux/pktcdvd.h                |  261 +
 11 files changed, 2983 insertions(+), 5 deletions(-)

diff -puN Documentation/cdrom/00-INDEX~packet-2.6.7 Documentation/cdrom/00-INDEX
--- linux/Documentation/cdrom/00-INDEX~packet-2.6.7	2004-07-01 13:23:15.000000000 +0200
+++ linux-petero/Documentation/cdrom/00-INDEX	2004-07-01 13:23:15.000000000 +0200
@@ -22,6 +22,8 @@ mcdx
 	- info on improved Mitsumi CD-ROM driver.
 optcd
 	- info on the Optics Storage 8000 AT CD-ROM driver
+packet-writing.txt
+	- Info on the CDRW packet writing module
 sbpcd
 	- info on the SoundBlaster/Panasonic CD-ROM interface driver.
 sjcd
diff -puN /dev/null Documentation/cdrom/packet-writing.txt
--- /dev/null	2004-02-23 22:02:56.000000000 +0100
+++ linux-petero/Documentation/cdrom/packet-writing.txt	2004-07-01 13:23:15.000000000 +0200
@@ -0,0 +1,22 @@
+Getting started quick
+---------------------
+
+- Select packet support in the block device section and UDF support in
+  the file system section.
+
+- Compile and install kernel and modules, reboot.
+
+- You need the udftools package (pktsetup, mkudffs, cdrwtool).
+  Download from http://sourceforge.net/projects/linux-udf/
+
+- Grab a new CD-RW disc and format it (assuming CD-RW is hdc, substitute
+  as appropriate):
+	# cdrwtool -d /dev/hdc -q
+
+- Make sure that /dev/pktcdvd0 exists (mknod /dev/pktcdvd0 b 97 0)
+
+- Setup your writer
+	# pktsetup /dev/pktcdvd0 /dev/hdc
+
+- Now you can mount /dev/pktcdvd0 and copy files to it. Enjoy!
+	# mount /dev/pktcdvd0 /cdrom -t udf -o rw,noatime
diff -puN drivers/block/Kconfig~packet-2.6.7 drivers/block/Kconfig
--- linux/drivers/block/Kconfig~packet-2.6.7	2004-07-01 13:23:15.000000000 +0200
+++ linux-petero/drivers/block/Kconfig	2004-07-01 15:05:02.773199032 +0200
@@ -340,6 +340,38 @@ config LBD
 	  your machine, or if you want to have a raid or loopback device
 	  bigger than 2TB.  Otherwise say N.
 
+config CDROM_PKTCDVD
+	tristate "Packet writing on CD/DVD media"
+	help
+	  If you have a CDROM drive that supports packet writing, say Y to
+	  include preliminary support. It should work with any MMC/Mt Fuji
+	  compliant ATAPI or SCSI drive, which is just about any newer CD
+	  writer.
+
+	  Currently only writing to CD-RW discs is possible.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pktcdvd.
+
+config CDROM_PKTCDVD_BUFFERS
+	int "Free buffers for data gathering"
+	depends on CDROM_PKTCDVD
+	default "8"
+	help
+	  This controls the maximum number of active concurrent packets. More
+	  concurrent packets can increase write performance, but also require
+	  more memory. Each concurrent packet will require approximately 64Kb
+	  of non-swappable kernel memory, memory which will be allocated at
+	  pktsetup time.
+
+config CDROM_PKTCDVD_WCACHE
+	bool "Enable write caching"
+	depends on CDROM_PKTCDVD
+	help
+	  If enabled, write caching will be set for the CD-R/W device. For now
+	  this option is dangerous unless the CD-RW media is known good, as we
+	  don't do deferred write error handling yet.
+
 source "drivers/s390/block/Kconfig"
 
 endmenu
diff -puN drivers/block/Makefile~packet-2.6.7 drivers/block/Makefile
--- linux/drivers/block/Makefile~packet-2.6.7	2004-07-01 13:23:15.000000000 +0200
+++ linux-petero/drivers/block/Makefile	2004-07-01 13:23:15.000000000 +0200
@@ -35,6 +35,7 @@ obj-$(CONFIG_BLK_DEV_XD)	+= xd.o
 obj-$(CONFIG_BLK_CPQ_DA)	+= cpqarray.o
 obj-$(CONFIG_BLK_CPQ_CISS_DA)  += cciss.o
 obj-$(CONFIG_BLK_DEV_DAC960)	+= DAC960.o
+obj-$(CONFIG_CDROM_PKTCDVD)	+= pktcdvd.o
 
 obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
diff -puN /dev/null drivers/block/pktcdvd.c
--- /dev/null	2004-02-23 22:02:56.000000000 +0100
+++ linux-petero/drivers/block/pktcdvd.c	2004-07-01 15:09:19.447178656 +0200
@@ -0,0 +1,2654 @@
+/*
+ * Copyright (C) 2000 Jens Axboe <axboe@suse.de>
+ * Copyright (C) 2001-2004 Peter Osterlund <petero2@telia.com>
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License.  See linux/COPYING for more information.
+ *
+ * Packet writing layer for ATAPI and SCSI CD-R, CD-RW, DVD-R, and
+ * DVD-RW devices (aka an exercise in block layer masturbation)
+ *
+ *
+ * TODO: (circa order of when I will fix it)
+ * - Only able to write on CD-RW media right now.
+ * - check host application code on media and set it in write page
+ * - Generic interface for UDF to submit large packets for variable length
+ *   packet writing
+ * - interface for UDF <-> packet to negotiate a new location when a write
+ *   fails.
+ * - handle OPC, especially for -RW media
+ *
+ * Theory of operation:
+ *
+ * We use a custom make_request_fn function that forwards reads directly to
+ * the underlying CD device. Write requests are either attached directly to
+ * a live packet_data object, or simply stored sequentially in a list for
+ * later processing by the kcdrwd kernel thread. This driver doesn't use
+ * any elevator functionally as defined by the elevator_s struct, but the
+ * underlying CD device uses a standard elevator.
+ *
+ * This strategy makes it possible to do very late merging of IO requests.
+ * A new bio sent to pkt_make_request can be merged with a live packet_data
+ * object even if the object is in the data gathering state.
+ *
+ *************************************************************************/
+
+#define VERSION_CODE	"v0.1.6a 2004-07-01 Jens Axboe (axboe@suse.de) and petero2@telia.com"
+
+#include <linux/pktcdvd.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/file.h>
+#include <linux/proc_fs.h>
+#include <linux/buffer_head.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/suspend.h>
+#include <scsi/scsi_cmnd.h>
+
+#include <asm/uaccess.h>
+
+#define SCSI_IOCTL_SEND_COMMAND	1
+
+#define ZONE(sector, pd) (((sector) + (pd)->offset) & ~((pd)->settings.size - 1))
+
+static struct pktcdvd_device *pkt_devs;
+static struct proc_dir_entry *pkt_proc;
+static struct gendisk *disks[MAX_WRITERS];
+
+static struct pktcdvd_device *pkt_find_dev(request_queue_t *q)
+{
+	int i;
+
+	for (i = 0; i < MAX_WRITERS; i++)
+		if (pkt_devs[i].bdev && bdev_get_queue(pkt_devs[i].bdev) == q)
+			return &pkt_devs[i];
+
+	return NULL;
+}
+
+/*
+ * The underlying block device is not allowed to merge write requests. Some
+ * CDRW drives can not handle writes larger than one packet, even if the size
+ * is a multiple of the packet size.
+ */
+static int pkt_lowlevel_elv_merge_fn(request_queue_t *q, struct request **req, struct bio *bio)
+{
+	struct pktcdvd_device *pd = pkt_find_dev(q);
+	BUG_ON(!pd);
+
+	if (bio_data_dir(bio) == WRITE)
+		return ELEVATOR_NO_MERGE;
+
+	if (pd->cdrw.elv_merge_fn)
+		return pd->cdrw.elv_merge_fn(q, req, bio);
+
+	return ELEVATOR_NO_MERGE;
+}
+
+static void pkt_lowlevel_elv_completed_req_fn(request_queue_t *q, struct request *req)
+{
+	struct pktcdvd_device *pd = pkt_find_dev(q);
+	BUG_ON(!pd);
+
+	if (elv_queue_empty(q)) {
+		VPRINTK("pktcdvd: queue empty\n");
+		atomic_set(&pd->iosched.attention, 1);
+		wake_up(&pd->wqueue);
+	}
+
+	if (pd->cdrw.elv_completed_req_fn)
+		pd->cdrw.elv_completed_req_fn(q, req);
+}
+
+static int pkt_lowlevel_merge_requests_fn(request_queue_t *q, struct request *rq, struct request *next)
+{
+	struct pktcdvd_device *pd = pkt_find_dev(q);
+	BUG_ON(!pd);
+
+	if (rq_data_dir(rq) == WRITE)
+		return 0;
+
+	return pd->cdrw.merge_requests_fn(q, rq, next);
+}
+
+static void pkt_bio_init(struct bio *bio)
+{
+	bio->bi_next = NULL;
+	bio->bi_flags = 1 << BIO_UPTODATE;
+	bio->bi_rw = 0;
+	bio->bi_vcnt = 0;
+	bio->bi_idx = 0;
+	bio->bi_phys_segments = 0;
+	bio->bi_hw_segments = 0;
+	bio->bi_size = 0;
+	bio->bi_max_vecs = 0;
+	bio->bi_end_io = NULL;
+	atomic_set(&bio->bi_cnt, 1);
+	bio->bi_private = NULL;
+}
+
+static void pkt_bio_destructor(struct bio *bio)
+{
+	kfree(bio->bi_io_vec);
+	kfree(bio);
+}
+
+static struct bio *pkt_bio_alloc(int nr_iovecs)
+{
+	struct bio_vec *bvl = NULL;
+	struct bio *bio;
+
+	bio = kmalloc(sizeof(struct bio), GFP_KERNEL);
+	if (!bio)
+		goto no_bio;
+	pkt_bio_init(bio);
+
+	bvl = kmalloc(nr_iovecs * sizeof(struct bio_vec), GFP_KERNEL);
+	if (!bvl)
+		goto no_bvl;
+	memset(bvl, 0, nr_iovecs * sizeof(struct bio_vec));
+
+	bio->bi_max_vecs = nr_iovecs;
+	bio->bi_io_vec = bvl;
+	bio->bi_destructor = pkt_bio_destructor;
+
+	return bio;
+
+ no_bvl:
+	kfree(bio);
+ no_bio:
+	return NULL;
+}
+
+/*
+ * Allocate a packet_data struct
+ */
+static struct packet_data *pkt_alloc_packet_data(void)
+{
+	int i;
+	struct packet_data *pkt;
+
+	pkt = kmalloc(sizeof(struct packet_data), GFP_KERNEL);
+	if (!pkt)
+		goto no_pkt;
+	memset(pkt, 0, sizeof(struct packet_data));
+
+	pkt->w_bio = pkt_bio_alloc(PACKET_MAX_SIZE);
+	if (!pkt->w_bio)
+		goto no_bio;
+
+	for (i = 0; i < PAGES_PER_PACKET; i++) {
+		pkt->pages[i] = alloc_page(GFP_KERNEL);
+		if (!pkt->pages[i])
+			goto no_page;
+	}
+	for (i = 0; i < PAGES_PER_PACKET; i++)
+		clear_page(page_address(pkt->pages[i]));
+
+	spin_lock_init(&pkt->lock);
+
+	for (i = 0; i < PACKET_MAX_SIZE; i++) {
+		struct bio *bio = pkt_bio_alloc(1);
+		if (!bio)
+			goto no_rd_bio;
+		pkt->r_bios[i] = bio;
+	}
+
+	return pkt;
+
+no_rd_bio:
+	for (i = 0; i < PACKET_MAX_SIZE; i++) {
+		struct bio *bio = pkt->r_bios[i];
+		if (bio)
+			bio_put(bio);
+	}
+
+no_page:
+	for (i = 0; i < PAGES_PER_PACKET; i++)
+		if (pkt->pages[i])
+			__free_page(pkt->pages[i]);
+	bio_put(pkt->w_bio);
+no_bio:
+	kfree(pkt);
+no_pkt:
+	return NULL;
+}
+
+/*
+ * Free a packet_data struct
+ */
+static void pkt_free_packet_data(struct packet_data *pkt)
+{
+	int i;
+
+	for (i = 0; i < PACKET_MAX_SIZE; i++) {
+		struct bio *bio = pkt->r_bios[i];
+		if (bio)
+			bio_put(bio);
+	}
+	for (i = 0; i < PAGES_PER_PACKET; i++)
+		__free_page(pkt->pages[i]);
+	bio_put(pkt->w_bio);
+	kfree(pkt);
+}
+
+static void pkt_shrink_pktlist(struct pktcdvd_device *pd)
+{
+	struct packet_data *pkt, *next;
+
+	BUG_ON(!list_empty(&pd->cdrw.pkt_active_list));
+
+	list_for_each_entry_safe(pkt, next, &pd->cdrw.pkt_free_list, list) {
+		pkt_free_packet_data(pkt);
+	}
+}
+
+static int pkt_grow_pktlist(struct pktcdvd_device *pd, int nr_packets)
+{
+	struct packet_data *pkt;
+
+	INIT_LIST_HEAD(&pd->cdrw.pkt_free_list);
+	INIT_LIST_HEAD(&pd->cdrw.pkt_active_list);
+	spin_lock_init(&pd->cdrw.active_list_lock);
+	while (nr_packets > 0) {
+		pkt = pkt_alloc_packet_data();
+		if (!pkt) {
+			pkt_shrink_pktlist(pd);
+			return 0;
+		}
+		pkt->id = nr_packets;
+		pkt->pd = pd;
+		list_add(&pkt->list, &pd->cdrw.pkt_free_list);
+		nr_packets--;
+	}
+	return 1;
+}
+
+/*
+ * Add a bio to a single linked list defined by its head and tail pointers.
+ */
+static inline void pkt_add_list_last(struct bio *bio, struct bio **list_head, struct bio **list_tail)
+{
+	bio->bi_next = NULL;
+	if (*list_tail) {
+		BUG_ON((*list_head) == NULL);
+		(*list_tail)->bi_next = bio;
+		(*list_tail) = bio;
+	} else {
+		BUG_ON((*list_head) != NULL);
+		(*list_head) = bio;
+		(*list_tail) = bio;
+	}
+}
+
+/*
+ * Remove and return the first bio from a single linked list defined by its
+ * head and tail pointers.
+ */
+static inline struct bio *pkt_get_list_first(struct bio **list_head, struct bio **list_tail)
+{
+	struct bio *bio;
+
+	if (*list_head == NULL)
+		return NULL;
+
+	bio = *list_head;
+	*list_head = bio->bi_next;
+	if (*list_head == NULL)
+		*list_tail = NULL;
+
+	bio->bi_next = NULL;
+	return bio;
+}
+
+/*
+ * Send a packet_command to the underlying block device and
+ * wait for completion.
+ */
+static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *cgc)
+{
+	char sense[SCSI_SENSE_BUFFERSIZE];
+	request_queue_t *q;
+	struct request *rq;
+	DECLARE_COMPLETION(wait);
+	int err = 0;
+
+	if (!pd->bdev) {
+		printk("pkt_generic_packet: no bdev\n");
+		return -ENXIO;
+	}
+
+	q = bdev_get_queue(pd->bdev);
+
+	rq = blk_get_request(q, (cgc->data_direction == CGC_DATA_WRITE) ? WRITE : READ,
+			     __GFP_WAIT);
+	rq->errors = 0;
+	rq->rq_disk = pd->bdev->bd_disk;
+	rq->bio = NULL;
+	rq->buffer = NULL;
+	rq->timeout = 60*HZ;
+	rq->data = cgc->buffer;
+	rq->data_len = cgc->buflen;
+	rq->sense = sense;
+	memset(sense, 0, sizeof(sense));
+	rq->sense_len = 0;
+	rq->flags |= REQ_BLOCK_PC | REQ_HARDBARRIER;
+	if (cgc->quiet)
+		rq->flags |= REQ_QUIET;
+	memcpy(rq->cmd, cgc->cmd, CDROM_PACKET_SIZE);
+	if (sizeof(rq->cmd) > CDROM_PACKET_SIZE)
+		memset(rq->cmd + CDROM_PACKET_SIZE, 0, sizeof(rq->cmd) - CDROM_PACKET_SIZE);
+
+	rq->ref_count++;
+	rq->flags |= REQ_NOMERGE;
+	rq->waiting = &wait;
+	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
+	generic_unplug_device(q);
+	wait_for_completion(&wait);
+
+	if (rq->errors)
+		err = -EIO;
+
+	blk_put_request(rq);
+	return err;
+}
+
+/*
+ * A generic sense dump / resolve mechanism should be implemented across
+ * all ATAPI + SCSI devices.
+ */
+static void pkt_dump_sense(struct packet_command *cgc)
+{
+	static char *info[9] = { "No sense", "Recovered error", "Not ready",
+				 "Medium error", "Hardware error", "Illegal request",
+				 "Unit attention", "Data protect", "Blank check" };
+	int i;
+	struct request_sense *sense = cgc->sense;
+
+	printk("pktcdvd:");
+	for (i = 0; i < CDROM_PACKET_SIZE; i++)
+		printk(" %02x", cgc->cmd[i]);
+	printk(" - ");
+
+	if (sense == NULL) {
+		printk("no sense\n");
+		return;
+	}
+
+	printk("sense %02x.%02x.%02x", sense->sense_key, sense->asc, sense->ascq);
+
+	if (sense->sense_key > 8) {
+		printk(" (INVALID)\n");
+		return;
+	}
+
+	printk(" (%s)\n", info[sense->sense_key]);
+}
+
+/*
+ * flush the drive cache to media
+ */
+static int pkt_flush_cache(struct pktcdvd_device *pd)
+{
+	struct packet_command cgc;
+
+	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
+	cgc.cmd[0] = GPCMD_FLUSH_CACHE;
+	cgc.quiet = 1;
+
+	/*
+	 * the IMMED bit -- we default to not setting it, although that
+	 * would allow a much faster close, this is safer
+	 */
+#if 0
+	cgc.cmd[1] = 1 << 1;
+#endif
+	return pkt_generic_packet(pd, &cgc);
+}
+
+/*
+ * speed is given as the normal factor, e.g. 4 for 4x
+ */
+static int pkt_set_speed(struct pktcdvd_device *pd, unsigned write_speed, unsigned read_speed)
+{
+	struct packet_command cgc;
+	struct request_sense sense;
+	int ret;
+
+	write_speed = write_speed * 177; /* should be 176.4, but CD-RWs rounds down */
+	write_speed = min_t(unsigned, write_speed, 0xffff);
+	read_speed = read_speed * 177;
+	read_speed = min_t(unsigned, read_speed, 0xffff);
+
+	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
+	cgc.sense = &sense;
+	cgc.cmd[0] = GPCMD_SET_SPEED;
+	cgc.cmd[2] = (read_speed >> 8) & 0xff;
+	cgc.cmd[3] = read_speed & 0xff;
+	cgc.cmd[4] = (write_speed >> 8) & 0xff;
+	cgc.cmd[5] = write_speed & 0xff;
+
+	if ((ret = pkt_generic_packet(pd, &cgc)))
+		pkt_dump_sense(&cgc);
+
+	return ret;
+}
+
+/*
+ * Queue a bio for processing by the low-level CD device. Must be called
+ * from process context.
+ */
+static void pkt_queue_bio(struct pktcdvd_device *pd, struct bio *bio, int high_prio_read)
+{
+	spin_lock(&pd->iosched.lock);
+	if (bio_data_dir(bio) == READ) {
+		pkt_add_list_last(bio, &pd->iosched.read_queue,
+				  &pd->iosched.read_queue_tail);
+		if (high_prio_read)
+			pd->iosched.high_prio_read = 1;
+	} else {
+		pkt_add_list_last(bio, &pd->iosched.write_queue,
+				  &pd->iosched.write_queue_tail);
+	}
+	spin_unlock(&pd->iosched.lock);
+
+	atomic_set(&pd->iosched.attention, 1);
+	wake_up(&pd->wqueue);
+}
+
+/*
+ * Process the queued read/write requests. This function handles special
+ * requirements for CDRW drives:
+ * - A cache flush command must be inserted before a read request if the
+ *   previous request was a write.
+ * - Switching between reading and writing is slow, so don't it more often
+ *   than necessary.
+ * - Set the read speed according to current usage pattern. When only reading
+ *   from the device, it's best to use the highest possible read speed, but
+ *   when switching often between reading and writing, it's better to have the
+ *   same read and write speeds.
+ * - Reads originating from user space should have higher priority than reads
+ *   originating from pkt_gather_data, because some process is usually waiting
+ *   on reads of the first kind.
+ */
+static void pkt_iosched_process_queue(struct pktcdvd_device *pd)
+{
+	request_queue_t *q;
+
+	if (atomic_read(&pd->iosched.attention) == 0)
+		return;
+	atomic_set(&pd->iosched.attention, 0);
+
+	if (!pd->bdev)
+		return;
+	q = bdev_get_queue(pd->bdev);
+
+	for (;;) {
+		struct bio *bio;
+		int reads_queued, writes_queued, high_prio_read;
+
+		spin_lock(&pd->iosched.lock);
+		reads_queued = (pd->iosched.read_queue != NULL);
+		writes_queued = (pd->iosched.write_queue != NULL);
+		if (!reads_queued)
+			pd->iosched.high_prio_read = 0;
+		high_prio_read = pd->iosched.high_prio_read;
+		spin_unlock(&pd->iosched.lock);
+
+		if (!reads_queued && !writes_queued)
+			break;
+
+		if (pd->iosched.writing) {
+			if (high_prio_read || (!writes_queued && reads_queued)) {
+				if (!elv_queue_empty(q)) {
+					VPRINTK("pktcdvd: write, waiting\n");
+					break;
+				}
+				pkt_flush_cache(pd);
+				pd->iosched.writing = 0;
+			}
+		} else {
+			if (!reads_queued && writes_queued) {
+				if (!elv_queue_empty(q)) {
+					VPRINTK("pktcdvd: read, waiting\n");
+					break;
+				}
+				pd->iosched.writing = 1;
+			}
+		}
+
+		spin_lock(&pd->iosched.lock);
+		if (pd->iosched.writing) {
+			bio = pkt_get_list_first(&pd->iosched.write_queue,
+						 &pd->iosched.write_queue_tail);
+		} else {
+			bio = pkt_get_list_first(&pd->iosched.read_queue,
+						 &pd->iosched.read_queue_tail);
+		}
+		spin_unlock(&pd->iosched.lock);
+
+		if (!bio)
+			continue;
+
+		if (bio_data_dir(bio) == READ)
+			pd->iosched.successive_reads += bio->bi_size >> 10;
+		else
+			pd->iosched.successive_reads = 0;
+		if (pd->iosched.successive_reads >= HI_SPEED_SWITCH) {
+			if (pd->read_speed == pd->write_speed) {
+				pd->read_speed = 0xff;
+				pkt_set_speed(pd, pd->write_speed, pd->read_speed);
+			}
+		} else {
+			if (pd->read_speed != pd->write_speed) {
+				pd->read_speed = pd->write_speed;
+				pkt_set_speed(pd, pd->write_speed, pd->read_speed);
+			}
+		}
+
+		generic_make_request(bio);
+	}
+}
+
+/*
+ * Special care is needed if the underlying block device has a small
+ * max_phys_segments value.
+ */
+static int pkt_set_segment_merging(struct pktcdvd_device *pd, request_queue_t *q)
+{
+	if ((pd->settings.size << 9) / CD_FRAMESIZE <= q->max_phys_segments) {
+		/*
+		 * The cdrom device can handle one segment/frame
+		 */
+		clear_bit(PACKET_MERGE_SEGS, &pd->flags);
+		return 0;
+	} else if ((pd->settings.size << 9) / PAGE_SIZE <= q->max_phys_segments) {
+		/*
+		 * We can handle this case at the expense of some extra memory
+		 * copies during write operations
+		 */
+		set_bit(PACKET_MERGE_SEGS, &pd->flags);
+		return 0;
+	} else {
+		printk("pktcdvd: cdrom max_phys_segments too small\n");
+		return -EIO;
+	}
+}
+
+/*
+ * Copy CD_FRAMESIZE bytes from src_bio into a destination page
+ */
+static void pkt_copy_bio_data(struct bio *src_bio, int seg, int offs,
+			      struct page *dst_page, int dst_offs)
+{
+	unsigned int copy_size = CD_FRAMESIZE;
+
+	while (copy_size > 0) {
+		struct bio_vec *src_bvl = bio_iovec_idx(src_bio, seg);
+		void *vfrom = kmap_atomic(src_bvl->bv_page, KM_USER0) +
+			src_bvl->bv_offset + offs;
+		void *vto = page_address(dst_page) + dst_offs;
+		int len = min_t(int, copy_size, src_bvl->bv_len - offs);
+
+		BUG_ON(len < 0);
+		memcpy(vto, vfrom, len);
+		kunmap_atomic(src_bvl->bv_page, KM_USER0);
+
+		seg++;
+		offs = 0;
+		dst_offs += len;
+		copy_size -= len;
+	}
+}
+
+/*
+ * Copy all data for this packet to pkt->pages[], so that
+ * a) The number of required segments for the write bio is minimized, which
+ *    is necessary for some scsi controllers.
+ * b) The data can be used as cache to avoid read requests if we receive a
+ *    new write request for the same zone.
+ */
+static void pkt_make_local_copy(struct packet_data *pkt, struct page **pages, int *offsets)
+{
+	int f, p, offs;
+
+	/* Copy all data to pkt->pages[] */
+	p = 0;
+	offs = 0;
+	for (f = 0; f < pkt->frames; f++) {
+		if (pages[f] != pkt->pages[p]) {
+			void *vfrom = kmap_atomic(pages[f], KM_USER0) + offsets[f];
+			void *vto = page_address(pkt->pages[p]) + offs;
+			memcpy(vto, vfrom, CD_FRAMESIZE);
+			kunmap_atomic(pages[f], KM_USER0);
+			pages[f] = pkt->pages[p];
+			offsets[f] = offs;
+		} else {
+			BUG_ON(offsets[f] != offs);
+		}
+		offs += CD_FRAMESIZE;
+		if (offs >= PAGE_SIZE) {
+			BUG_ON(offs > PAGE_SIZE);
+			offs = 0;
+			p++;
+		}
+	}
+}
+
+static int pkt_end_io_read(struct bio *bio, unsigned int bytes_done, int err)
+{
+	struct packet_data *pkt = bio->bi_private;
+	struct pktcdvd_device *pd = pkt->pd;
+	BUG_ON(!pd);
+
+	if (bio->bi_size)
+		return 1;
+
+	VPRINTK("pkt_end_io_read: bio=%p sec0=%llx sec=%llx err=%d\n", bio,
+		(unsigned long long)pkt->sector, (unsigned long long)bio->bi_sector, err);
+
+	if (err)
+		atomic_inc(&pkt->io_errors);
+	if (atomic_dec_and_test(&pkt->io_wait)) {
+		atomic_inc(&pkt->run_sm);
+		wake_up(&pd->wqueue);
+	}
+
+	return 0;
+}
+
+static int pkt_end_io_packet_write(struct bio *bio, unsigned int bytes_done, int err)
+{
+	struct packet_data *pkt = bio->bi_private;
+	struct pktcdvd_device *pd = pkt->pd;
+	BUG_ON(!pd);
+
+	if (bio->bi_size)
+		return 1;
+
+	VPRINTK("pkt_end_io_packet_write: id=%d, err=%d\n", pkt->id, err);
+
+	pd->stats.pkt_ended++;
+
+	atomic_dec(&pkt->io_wait);
+	atomic_inc(&pkt->run_sm);
+	wake_up(&pd->wqueue);
+	return 0;
+}
+
+/*
+ * Schedule reads for the holes in a packet
+ */
+static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
+{
+	int frames_read = 0;
+	struct bio *bio;
+	int f;
+	char written[PACKET_MAX_SIZE];
+
+	BUG_ON(!pkt->orig_bios);
+
+	atomic_set(&pkt->io_wait, 0);
+	atomic_set(&pkt->io_errors, 0);
+
+	if (pkt->cache_valid) {
+		VPRINTK("pkt_gather_data: zone %llx cached\n",
+			(unsigned long long)pkt->sector);
+		goto out_account;
+	}
+
+	/*
+	 * Figure out which frames we need to read before we can write.
+	 */
+	memset(written, 0, sizeof(written));
+	spin_lock(&pkt->lock);
+	for (bio = pkt->orig_bios; bio; bio = bio->bi_next) {
+		int first_frame = (bio->bi_sector - pkt->sector) / (CD_FRAMESIZE >> 9);
+		int num_frames = bio->bi_size / CD_FRAMESIZE;
+		BUG_ON(first_frame < 0);
+		BUG_ON(first_frame + num_frames > pkt->frames);
+		for (f = first_frame; f < first_frame + num_frames; f++)
+			written[f] = 1;
+	}
+	spin_unlock(&pkt->lock);
+
+	/*
+	 * Schedule reads for missing parts of the packet.
+	 */
+	for (f = 0; f < pkt->frames; f++) {
+		int p, offset;
+		if (written[f])
+			continue;
+		bio = pkt->r_bios[f];
+		pkt_bio_init(bio);
+		bio->bi_max_vecs = 1;
+		bio->bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
+		bio->bi_bdev = pd->bdev;
+		bio->bi_end_io = pkt_end_io_read;
+		bio->bi_private = pkt;
+
+		p = (f * CD_FRAMESIZE) / PAGE_SIZE;
+		offset = (f * CD_FRAMESIZE) % PAGE_SIZE;
+		VPRINTK("pkt_gather_data: Adding frame %d, page:%p offs:%d\n",
+			f, pkt->pages[p], offset);
+		if (!bio_add_page(bio, pkt->pages[p], CD_FRAMESIZE, offset))
+			BUG();
+
+		atomic_inc(&pkt->io_wait);
+		bio->bi_rw = READ;
+		pkt_queue_bio(pd, bio, 0);
+		frames_read++;
+	}
+
+out_account:
+	VPRINTK("pkt_gather_data: need %d frames for zone %llx\n",
+		frames_read, (unsigned long long)pkt->sector);
+	pd->stats.pkt_started++;
+	pd->stats.secs_rg += frames_read * (CD_FRAMESIZE >> 9);
+	pd->stats.secs_w += pd->settings.size;
+}
+
+/*
+ * Find a packet matching zone, or the least recently used packet if
+ * there is no match.
+ */
+static struct packet_data *pkt_get_packet_data(struct pktcdvd_device *pd, int zone)
+{
+	struct packet_data *pkt;
+
+	list_for_each_entry(pkt, &pd->cdrw.pkt_free_list, list) {
+		if (pkt->sector == zone || pkt->list.next == &pd->cdrw.pkt_free_list) {
+			list_del_init(&pkt->list);
+			if (pkt->sector != zone)
+				pkt->cache_valid = 0;
+			break;
+		}
+	}
+	return pkt;
+}
+
+static void pkt_put_packet_data(struct pktcdvd_device *pd, struct packet_data *pkt)
+{
+	if (pkt->cache_valid) {
+		list_add(&pkt->list, &pd->cdrw.pkt_free_list);
+	} else {
+		list_add_tail(&pkt->list, &pd->cdrw.pkt_free_list);
+	}
+}
+
+/*
+ * recover a failed write, query for relocation if possible
+ *
+ * returns 1 if recovery is possible, or 0 if not
+ *
+ */
+static int pkt_start_recovery(struct packet_data *pkt)
+{
+	/*
+	 * FIXME. We need help from the file system to implement
+	 * recovery handling.
+	 */
+	return 0;
+#if 0
+	struct request *rq = pkt->rq;
+	struct pktcdvd_device *pd = rq->rq_disk->private_data;
+	struct block_device *pkt_bdev;
+	struct super_block *sb = NULL;
+	unsigned long old_block, new_block;
+	sector_t new_sector;
+
+	pkt_bdev = bdget(kdev_t_to_nr(pd->pkt_dev));
+	if (pkt_bdev) {
+		sb = get_super(pkt_bdev);
+		bdput(pkt_bdev);
+	}
+
+	if (!sb)
+		return 0;
+
+	if (!sb->s_op || !sb->s_op->relocate_blocks)
+		goto out;
+
+	old_block = pkt->sector / (CD_FRAMESIZE >> 9);
+	if (sb->s_op->relocate_blocks(sb, old_block, &new_block))
+		goto out;
+
+	new_sector = new_block * (CD_FRAMESIZE >> 9);
+	pkt->sector = new_sector;
+
+	pkt->bio->bi_sector = new_sector;
+	pkt->bio->bi_next = NULL;
+	pkt->bio->bi_flags = 1 << BIO_UPTODATE;
+	pkt->bio->bi_idx = 0;
+
+	BUG_ON(pkt->bio->bi_rw != (1 << BIO_RW));
+	BUG_ON(pkt->bio->bi_vcnt != pkt->frames);
+	BUG_ON(pkt->bio->bi_size != pkt->frames * CD_FRAMESIZE);
+	BUG_ON(pkt->bio->bi_end_io != pkt_end_io_packet_write);
+	BUG_ON(pkt->bio->bi_private != pkt);
+
+	drop_super(sb);
+	return 1;
+
+out:
+	drop_super(sb);
+	return 0;
+#endif
+}
+
+static inline void pkt_set_state(struct packet_data *pkt, enum packet_data_state state)
+{
+#if PACKET_DEBUG > 1
+	static const char *state_name[] = {
+		"IDLE", "WAITING", "READ_WAIT", "WRITE_WAIT", "RECOVERY", "FINISHED"
+	};
+	enum packet_data_state old_state = pkt->state;
+	VPRINTK("pkt %2d : s=%6llx %s -> %s\n", pkt->id, (unsigned long long)pkt->sector,
+		state_name[old_state], state_name[state]);
+#endif
+	pkt->state = state;
+}
+
+/*
+ * Scan the work queue to see if we can start a new packet.
+ * returns non-zero if any work was done.
+ */
+static int pkt_handle_queue(struct pktcdvd_device *pd)
+{
+	struct packet_data *pkt, *p;
+	struct bio *bio, *prev, *next;
+	sector_t zone = 0; /* Suppress gcc warning */
+
+	VPRINTK("handle_queue\n");
+
+	atomic_set(&pd->scan_queue, 0);
+
+	if (list_empty(&pd->cdrw.pkt_free_list)) {
+		VPRINTK("handle_queue: no pkt\n");
+		return 0;
+	}
+
+	/*
+	 * Try to find a zone we are not already working on.
+	 */
+	spin_lock(&pd->lock);
+	for (bio = pd->bio_queue; bio; bio = bio->bi_next) {
+		zone = ZONE(bio->bi_sector, pd);
+		list_for_each_entry(p, &pd->cdrw.pkt_active_list, list) {
+			if (p->sector == zone)
+				goto try_next_bio;
+		}
+		break;
+try_next_bio: ;
+	}
+	spin_unlock(&pd->lock);
+	if (!bio) {
+		VPRINTK("handle_queue: no bio\n");
+		return 0;
+	}
+
+	pkt = pkt_get_packet_data(pd, zone);
+	BUG_ON(!pkt);
+
+	pkt->sector = zone;
+	pkt->frames = pd->settings.size >> 2;
+	BUG_ON(pkt->frames > PACKET_MAX_SIZE);
+	pkt->write_size = 0;
+
+	/*
+	 * Scan work queue for bios in the same zone and link them
+	 * to this packet.
+	 */
+	spin_lock(&pd->lock);
+	prev = NULL;
+	VPRINTK("pkt_handle_queue: looking for zone %llx\n", (unsigned long long)zone);
+	bio = pd->bio_queue;
+	while (bio) {
+		VPRINTK("pkt_handle_queue: found zone=%llx\n",
+			(unsigned long long)ZONE(bio->bi_sector, pd));
+		if (ZONE(bio->bi_sector, pd) == zone) {
+			if (prev) {
+				prev->bi_next = bio->bi_next;
+			} else {
+				pd->bio_queue = bio->bi_next;
+			}
+			if (bio == pd->bio_queue_tail)
+				pd->bio_queue_tail = prev;
+			next = bio->bi_next;
+			spin_lock(&pkt->lock);
+			pkt_add_list_last(bio, &pkt->orig_bios,
+					  &pkt->orig_bios_tail);
+			pkt->write_size += bio->bi_size / CD_FRAMESIZE;
+			if (pkt->write_size >= pkt->frames) {
+				VPRINTK("pkt_handle_queue: pkt is full\n");
+				next = NULL; /* Stop searching if the packet is full */
+			}
+			spin_unlock(&pkt->lock);
+			bio = next;
+		} else {
+			prev = bio;
+			bio = bio->bi_next;
+		}
+	}
+	spin_unlock(&pd->lock);
+
+	pkt->sleep_time = max(PACKET_WAIT_TIME, 1);
+	pkt_set_state(pkt, PACKET_WAITING_STATE);
+	atomic_set(&pkt->run_sm, 1);
+
+	spin_lock(&pd->cdrw.active_list_lock);
+	list_add(&pkt->list, &pd->cdrw.pkt_active_list);
+	spin_unlock(&pd->cdrw.active_list_lock);
+
+	return 1;
+}
+
+/*
+ * Assemble a bio to write one packet and queue the bio for processing
+ * by the underlying block device.
+ */
+static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
+{
+	struct bio *bio;
+	struct page *pages[PACKET_MAX_SIZE];
+	int offsets[PACKET_MAX_SIZE];
+	int f;
+	int frames_write;
+
+	for (f = 0; f < pkt->frames; f++) {
+		pages[f] = pkt->pages[(f * CD_FRAMESIZE) / PAGE_SIZE];
+		offsets[f] = (f * CD_FRAMESIZE) % PAGE_SIZE;
+	}
+
+	/*
+	 * Fill-in pages[] and offsets[] with data from orig_bios.
+	 */
+	frames_write = 0;
+	spin_lock(&pkt->lock);
+	for (bio = pkt->orig_bios; bio; bio = bio->bi_next) {
+		int segment = bio->bi_idx;
+		int src_offs = 0;
+		int first_frame = (bio->bi_sector - pkt->sector) / (CD_FRAMESIZE >> 9);
+		int num_frames = bio->bi_size / CD_FRAMESIZE;
+		BUG_ON(first_frame < 0);
+		BUG_ON(first_frame + num_frames > pkt->frames);
+		for (f = first_frame; f < first_frame + num_frames; f++) {
+			struct bio_vec *src_bvl = bio_iovec_idx(bio, segment);
+
+			while (src_offs >= src_bvl->bv_len) {
+				src_offs -= src_bvl->bv_len;
+				segment++;
+				BUG_ON(segment >= bio->bi_vcnt);
+				src_bvl = bio_iovec_idx(bio, segment);
+			}
+
+			if (src_bvl->bv_len - src_offs >= CD_FRAMESIZE) {
+				pages[f] = src_bvl->bv_page;
+				offsets[f] = src_bvl->bv_offset + src_offs;
+			} else {
+				pkt_copy_bio_data(bio, segment, src_offs,
+						  pages[f], offsets[f]);
+			}
+			src_offs += CD_FRAMESIZE;
+			frames_write++;
+		}
+	}
+	pkt_set_state(pkt, PACKET_WRITE_WAIT_STATE);
+	spin_unlock(&pkt->lock);
+
+	VPRINTK("pkt_start_write: Writing %d frames for zone %llx\n",
+		frames_write, (unsigned long long)pkt->sector);
+	BUG_ON(frames_write != pkt->write_size);
+
+	if (test_bit(PACKET_MERGE_SEGS, &pd->flags) || (pkt->write_size < pkt->frames)) {
+		pkt_make_local_copy(pkt, pages, offsets);
+		pkt->cache_valid = 1;
+	} else {
+		pkt->cache_valid = 0;
+	}
+
+	/* Start the write request */
+	pkt_bio_init(pkt->w_bio);
+	pkt->w_bio->bi_max_vecs = PACKET_MAX_SIZE;
+	pkt->w_bio->bi_sector = pkt->sector;
+	pkt->w_bio->bi_bdev = pd->bdev;
+	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
+	pkt->w_bio->bi_private = pkt;
+	for (f = 0; f < pkt->frames; f++) {
+		if ((f + 1 < pkt->frames) && (pages[f + 1] == pages[f]) &&
+		    (offsets[f + 1] = offsets[f] + CD_FRAMESIZE)) {
+			if (!bio_add_page(pkt->w_bio, pages[f], CD_FRAMESIZE * 2, offsets[f]))
+				BUG();
+			f++;
+		} else {
+			if (!bio_add_page(pkt->w_bio, pages[f], CD_FRAMESIZE, offsets[f]))
+				BUG();
+		}
+	}
+	VPRINTK("pktcdvd: vcnt=%d\n", pkt->w_bio->bi_vcnt);
+
+	atomic_set(&pkt->io_wait, 1);
+	pkt->w_bio->bi_rw = WRITE;
+	pkt_queue_bio(pd, pkt->w_bio, 0);
+}
+
+static void pkt_finish_packet(struct packet_data *pkt, int uptodate)
+{
+	struct bio *bio, *next;
+
+	if (!uptodate)
+		pkt->cache_valid = 0;
+
+	/* Finish all bios corresponding to this packet */
+	bio = pkt->orig_bios;
+	while (bio) {
+		next = bio->bi_next;
+		bio->bi_next = NULL;
+		bio_endio(bio, bio->bi_size, uptodate ? 0 : -EIO);
+		bio = next;
+	}
+	pkt->orig_bios = pkt->orig_bios_tail = NULL;
+}
+
+static void pkt_run_state_machine(struct pktcdvd_device *pd, struct packet_data *pkt)
+{
+	int uptodate;
+
+	VPRINTK("run_state_machine: pkt %d\n", pkt->id);
+
+	for (;;) {
+		switch (pkt->state) {
+		case PACKET_WAITING_STATE:
+			if ((pkt->write_size < pkt->frames) && (pkt->sleep_time > 0))
+				return;
+
+			pkt->sleep_time = 0;
+			pkt_gather_data(pd, pkt);
+			pkt_set_state(pkt, PACKET_READ_WAIT_STATE);
+			break;
+
+		case PACKET_READ_WAIT_STATE:
+			if (atomic_read(&pkt->io_wait) > 0)
+				return;
+
+			if (atomic_read(&pkt->io_errors) > 0) {
+				pkt_set_state(pkt, PACKET_RECOVERY_STATE);
+			} else {
+				pkt_start_write(pd, pkt);
+			}
+			break;
+
+		case PACKET_WRITE_WAIT_STATE:
+			if (atomic_read(&pkt->io_wait) > 0)
+				return;
+
+			if (test_bit(BIO_UPTODATE, &pkt->w_bio->bi_flags)) {
+				pkt_set_state(pkt, PACKET_FINISHED_STATE);
+			} else {
+				pkt_set_state(pkt, PACKET_RECOVERY_STATE);
+			}
+			break;
+
+		case PACKET_RECOVERY_STATE:
+			if (pkt_start_recovery(pkt)) {
+				pkt_start_write(pd, pkt);
+			} else {
+				VPRINTK("No recovery possible\n");
+				pkt_set_state(pkt, PACKET_FINISHED_STATE);
+			}
+			break;
+
+		case PACKET_FINISHED_STATE:
+			uptodate = test_bit(BIO_UPTODATE, &pkt->w_bio->bi_flags);
+			pkt_finish_packet(pkt, uptodate);
+			return;
+
+		default:
+			BUG();
+			break;
+		}
+	}
+}
+
+static void pkt_handle_packets(struct pktcdvd_device *pd)
+{
+	struct packet_data *pkt, *next;
+
+	VPRINTK("pkt_handle_packets\n");
+
+	/*
+	 * Run state machine for active packets
+	 */
+	list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
+		if (atomic_read(&pkt->run_sm) > 0) {
+			atomic_set(&pkt->run_sm, 0);
+			pkt_run_state_machine(pd, pkt);
+		}
+	}
+
+	/*
+	 * Move no longer active packets to the free list
+	 */
+	spin_lock(&pd->cdrw.active_list_lock);
+	list_for_each_entry_safe(pkt, next, &pd->cdrw.pkt_active_list, list) {
+		if (pkt->state == PACKET_FINISHED_STATE) {
+			list_del(&pkt->list);
+			pkt_put_packet_data(pd, pkt);
+			pkt_set_state(pkt, PACKET_IDLE_STATE);
+			atomic_set(&pd->scan_queue, 1);
+		}
+	}
+	spin_unlock(&pd->cdrw.active_list_lock);
+}
+
+static void pkt_count_states(struct pktcdvd_device *pd, int *states)
+{
+	struct packet_data *pkt;
+	int i;
+
+	for (i = 0; i <= PACKET_NUM_STATES; i++)
+		states[i] = 0;
+
+	spin_lock(&pd->cdrw.active_list_lock);
+	list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
+		states[pkt->state]++;
+	}
+	spin_unlock(&pd->cdrw.active_list_lock);
+}
+
+/*
+ * kcdrwd is woken up when writes have been queued for one of our
+ * registered devices
+ */
+static int kcdrwd(void *foobar)
+{
+	struct pktcdvd_device *pd = foobar;
+	struct packet_data *pkt;
+	long min_sleep_time, residue;
+
+	/*
+	 * exit_files, mm (move to lazy-tlb, so context switches are come
+	 * extremely cheap) etc
+	 */
+	daemonize(pd->name);
+
+	set_user_nice(current, -20);
+	sprintf(current->comm, pd->name);
+
+	siginitsetinv(&current->blocked, sigmask(SIGKILL));
+	flush_signals(current);
+
+	for (;;) {
+		DECLARE_WAITQUEUE(wait, current);
+
+		/*
+		 * Wait until there is something to do
+		 */
+		add_wait_queue(&pd->wqueue, &wait);
+		for (;;) {
+			set_current_state(TASK_INTERRUPTIBLE);
+
+			/* Check if we need to run pkt_handle_queue */
+			if (atomic_read(&pd->scan_queue) > 0)
+				goto work_to_do;
+
+			/* Check if we need to run the state machine for some packet */
+			list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
+				if (atomic_read(&pkt->run_sm) > 0)
+					goto work_to_do;
+			}
+
+			/* Check if we need to process the iosched queues */
+			if (atomic_read(&pd->iosched.attention) != 0)
+				goto work_to_do;
+
+			/* Otherwise, go to sleep */
+			if (PACKET_DEBUG > 1) {
+				int states[PACKET_NUM_STATES];
+				pkt_count_states(pd, states);
+				VPRINTK("kcdrwd: i:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
+					states[0], states[1], states[2], states[3],
+					states[4], states[5]);
+			}
+
+			min_sleep_time = MAX_SCHEDULE_TIMEOUT;
+			list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
+				if (pkt->sleep_time && pkt->sleep_time < min_sleep_time)
+					min_sleep_time = pkt->sleep_time;
+			}
+
+			if (pd->bdev) {
+				request_queue_t *q;
+				q = bdev_get_queue(pd->bdev);
+				generic_unplug_device(q);
+			}
+
+			VPRINTK("kcdrwd: sleeping\n");
+			residue = schedule_timeout(min_sleep_time);
+			VPRINTK("kcdrwd: wake up\n");
+
+			/* make swsusp happy with our thread */
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_FREEZE);
+
+			list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
+				if (!pkt->sleep_time)
+					continue;
+				pkt->sleep_time -= min_sleep_time - residue;
+				if (pkt->sleep_time <= 0) {
+					pkt->sleep_time = 0;
+					atomic_inc(&pkt->run_sm);
+				}
+			}
+
+			if (signal_pending(current)) {
+				flush_signals(current);
+			}
+			if (pd->cdrw.time_to_die)
+				break;
+		}
+work_to_do:
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&pd->wqueue, &wait);
+
+		if (pd->cdrw.time_to_die)
+			break;
+
+		/*
+		 * if pkt_handle_queue returns true, we can queue
+		 * another request.
+		 */
+		while (pkt_handle_queue(pd))
+			;
+
+		/*
+		 * Handle packet state machine
+		 */
+		pkt_handle_packets(pd);
+
+		/*
+		 * Handle iosched queues
+		 */
+		pkt_iosched_process_queue(pd);
+	}
+
+	complete_and_exit(&pd->cdrw.thr_compl, 0);
+	return 0;
+}
+
+static void pkt_print_settings(struct pktcdvd_device *pd)
+{
+	printk("pktcdvd: %s packets, ", pd->settings.fp ? "Fixed" : "Variable");
+	printk("%u blocks, ", pd->settings.size >> 2);
+	printk("Mode-%c disc\n", pd->settings.block_mode == 8 ? '1' : '2');
+}
+
+static int pkt_mode_sense(struct pktcdvd_device *pd, struct packet_command *cgc,
+			  int page_code, int page_control)
+{
+	memset(cgc->cmd, 0, sizeof(cgc->cmd));
+
+	cgc->cmd[0] = GPCMD_MODE_SENSE_10;
+	cgc->cmd[2] = page_code | (page_control << 6);
+	cgc->cmd[7] = cgc->buflen >> 8;
+	cgc->cmd[8] = cgc->buflen & 0xff;
+	cgc->data_direction = CGC_DATA_READ;
+	return pkt_generic_packet(pd, cgc);
+}
+
+static int pkt_mode_select(struct pktcdvd_device *pd, struct packet_command *cgc)
+{
+	memset(cgc->cmd, 0, sizeof(cgc->cmd));
+	memset(cgc->buffer, 0, 2);
+	cgc->cmd[0] = GPCMD_MODE_SELECT_10;
+	cgc->cmd[1] = 0x10;		/* PF */
+	cgc->cmd[7] = cgc->buflen >> 8;
+	cgc->cmd[8] = cgc->buflen & 0xff;
+	cgc->data_direction = CGC_DATA_WRITE;
+	return pkt_generic_packet(pd, cgc);
+}
+
+static int pkt_get_disc_info(struct pktcdvd_device *pd, disc_information *di)
+{
+	struct packet_command cgc;
+	int ret;
+
+	/* set up command and get the disc info */
+	init_cdrom_command(&cgc, di, sizeof(*di), CGC_DATA_READ);
+	cgc.cmd[0] = GPCMD_READ_DISC_INFO;
+	cgc.cmd[8] = cgc.buflen = 2;
+	cgc.quiet = 1;
+
+	if ((ret = pkt_generic_packet(pd, &cgc)))
+		return ret;
+
+	/* not all drives have the same disc_info length, so requeue
+	 * packet with the length the drive tells us it can supply
+	 */
+	cgc.buflen = be16_to_cpu(di->disc_information_length) +
+		     sizeof(di->disc_information_length);
+
+	if (cgc.buflen > sizeof(disc_information))
+		cgc.buflen = sizeof(disc_information);
+
+	cgc.cmd[8] = cgc.buflen;
+	return pkt_generic_packet(pd, &cgc);
+}
+
+static int pkt_get_track_info(struct pktcdvd_device *pd, __u16 track, __u8 type, track_information *ti)
+{
+	struct packet_command cgc;
+	int ret;
+
+	init_cdrom_command(&cgc, ti, 8, CGC_DATA_READ);
+	cgc.cmd[0] = GPCMD_READ_TRACK_RZONE_INFO;
+	cgc.cmd[1] = type & 3;
+	cgc.cmd[4] = (track & 0xff00) >> 8;
+	cgc.cmd[5] = track & 0xff;
+	cgc.cmd[8] = 8;
+	cgc.quiet = 1;
+
+	if ((ret = pkt_generic_packet(pd, &cgc)))
+		return ret;
+
+	cgc.buflen = be16_to_cpu(ti->track_information_length) +
+		     sizeof(ti->track_information_length);
+
+	if (cgc.buflen > sizeof(track_information))
+		cgc.buflen = sizeof(track_information);
+
+	cgc.cmd[8] = cgc.buflen;
+	return pkt_generic_packet(pd, &cgc);
+}
+
+static int pkt_get_last_written(struct pktcdvd_device *pd, long *last_written)
+{
+	disc_information di;
+	track_information ti;
+	__u32 last_track;
+	int ret = -1;
+
+	if ((ret = pkt_get_disc_info(pd, &di)))
+		return ret;
+
+	last_track = (di.last_track_msb << 8) | di.last_track_lsb;
+	if ((ret = pkt_get_track_info(pd, last_track, 1, &ti)))
+		return ret;
+
+	/* if this track is blank, try the previous. */
+	if (ti.blank) {
+		last_track--;
+		if ((ret = pkt_get_track_info(pd, last_track, 1, &ti)))
+			return ret;
+	}
+
+	/* if last recorded field is valid, return it. */
+	if (ti.lra_v) {
+		*last_written = be32_to_cpu(ti.last_rec_address);
+	} else {
+		/* make it up instead */
+		*last_written = be32_to_cpu(ti.track_start) +
+				be32_to_cpu(ti.track_size);
+		if (ti.free_blocks)
+			*last_written -= (be32_to_cpu(ti.free_blocks) + 7);
+	}
+	return 0;
+}
+
+/*
+ * write mode select package based on pd->settings
+ */
+static int pkt_set_write_settings(struct pktcdvd_device *pd)
+{
+	struct packet_command cgc;
+	struct request_sense sense;
+	write_param_page *wp;
+	char buffer[128];
+	int ret, size;
+
+	memset(buffer, 0, sizeof(buffer));
+	init_cdrom_command(&cgc, buffer, sizeof(*wp), CGC_DATA_READ);
+	cgc.sense = &sense;
+	if ((ret = pkt_mode_sense(pd, &cgc, GPMODE_WRITE_PARMS_PAGE, 0))) {
+		pkt_dump_sense(&cgc);
+		return ret;
+	}
+
+	size = 2 + ((buffer[0] << 8) | (buffer[1] & 0xff));
+	pd->mode_offset = (buffer[6] << 8) | (buffer[7] & 0xff);
+	if (size > sizeof(buffer))
+		size = sizeof(buffer);
+
+	/*
+	 * now get it all
+	 */
+	init_cdrom_command(&cgc, buffer, size, CGC_DATA_READ);
+	cgc.sense = &sense;
+	if ((ret = pkt_mode_sense(pd, &cgc, GPMODE_WRITE_PARMS_PAGE, 0))) {
+		pkt_dump_sense(&cgc);
+		return ret;
+	}
+
+	/*
+	 * write page is offset header + block descriptor length
+	 */
+	wp = (write_param_page *) &buffer[sizeof(struct mode_page_header) + pd->mode_offset];
+
+	wp->fp = pd->settings.fp;
+	wp->track_mode = pd->settings.track_mode;
+	wp->write_type = pd->settings.write_type;
+	wp->data_block_type = pd->settings.block_mode;
+
+	wp->multi_session = 0;
+
+#ifdef PACKET_USE_LS
+	wp->link_size = 7;
+	wp->ls_v = 1;
+#endif
+
+	if (wp->data_block_type == PACKET_BLOCK_MODE1) {
+		wp->session_format = 0;
+		wp->subhdr2 = 0x20;
+	} else if (wp->data_block_type == PACKET_BLOCK_MODE2) {
+		wp->session_format = 0x20;
+		wp->subhdr2 = 8;
+#if 0
+		wp->mcn[0] = 0x80;
+		memcpy(&wp->mcn[1], PACKET_MCN, sizeof(wp->mcn) - 1);
+#endif
+	} else {
+		/*
+		 * paranoia
+		 */
+		printk("pktcdvd: write mode wrong %d\n", wp->data_block_type);
+		return 1;
+	}
+	wp->packet_size = cpu_to_be32(pd->settings.size >> 2);
+
+	cgc.buflen = cgc.cmd[8] = size;
+	if ((ret = pkt_mode_select(pd, &cgc))) {
+		pkt_dump_sense(&cgc);
+		return ret;
+	}
+
+	pkt_print_settings(pd);
+	return 0;
+}
+
+/*
+ * 0 -- we can write to this track, 1 -- we can't
+ */
+static int pkt_good_track(track_information *ti)
+{
+	/*
+	 * only good for CD-RW at the moment, not DVD-RW
+	 */
+
+	/*
+	 * FIXME: only for FP
+	 */
+	if (ti->fp == 0)
+		return 0;
+
+	/*
+	 * "good" settings as per Mt Fuji.
+	 */
+	if (ti->rt == 0 && ti->blank == 0 && ti->packet == 1)
+		return 0;
+
+	if (ti->rt == 0 && ti->blank == 1 && ti->packet == 1)
+		return 0;
+
+	if (ti->rt == 1 && ti->blank == 0 && ti->packet == 1)
+		return 0;
+
+	printk("pktcdvd: bad state %d-%d-%d\n", ti->rt, ti->blank, ti->packet);
+	return 1;
+}
+
+/*
+ * 0 -- we can write to this disc, 1 -- we can't
+ */
+static int pkt_good_disc(struct pktcdvd_device *pd, disc_information *di)
+{
+	/*
+	 * for disc type 0xff we should probably reserve a new track.
+	 * but i'm not sure, should we leave this to user apps? probably.
+	 */
+	if (di->disc_type == 0xff) {
+		printk("pktcdvd: Unknown disc. No track?\n");
+		return 1;
+	}
+
+	if (di->disc_type != 0x20 && di->disc_type != 0) {
+		printk("pktcdvd: Wrong disc type (%x)\n", di->disc_type);
+		return 1;
+	}
+
+	if (di->erasable == 0) {
+		printk("pktcdvd: Disc not erasable\n");
+		return 1;
+	}
+
+	if (di->border_status == PACKET_SESSION_RESERVED) {
+		printk("pktcdvd: Can't write to last track (reserved)\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static int pkt_probe_settings(struct pktcdvd_device *pd)
+{
+	disc_information di;
+	track_information ti;
+	int ret, track;
+
+	memset(&di, 0, sizeof(disc_information));
+	memset(&ti, 0, sizeof(track_information));
+
+	if ((ret = pkt_get_disc_info(pd, &di))) {
+		printk("failed get_disc\n");
+		return ret;
+	}
+
+	if (pkt_good_disc(pd, &di))
+		return -ENXIO;
+
+	printk("pktcdvd: inserted media is CD-R%s\n", di.erasable ? "W" : "");
+	pd->type = di.erasable ? PACKET_CDRW : PACKET_CDR;
+
+	track = 1; /* (di.last_track_msb << 8) | di.last_track_lsb; */
+	if ((ret = pkt_get_track_info(pd, track, 1, &ti))) {
+		printk("pktcdvd: failed get_track\n");
+		return ret;
+	}
+
+	if (pkt_good_track(&ti)) {
+		printk("pktcdvd: can't write to this track\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * we keep packet size in 512 byte units, makes it easier to
+	 * deal with request calculations.
+	 */
+	pd->settings.size = be32_to_cpu(ti.fixed_packet_size) << 2;
+	if (pd->settings.size == 0) {
+		printk("pktcdvd: detected zero packet size!\n");
+		pd->settings.size = 128;
+	}
+	pd->settings.fp = ti.fp;
+	pd->offset = (be32_to_cpu(ti.track_start) << 2) & (pd->settings.size - 1);
+
+	if (ti.nwa_v) {
+		pd->nwa = be32_to_cpu(ti.next_writable);
+		set_bit(PACKET_NWA_VALID, &pd->flags);
+	}
+
+	/*
+	 * in theory we could use lra on -RW media as well and just zero
+	 * blocks that haven't been written yet, but in practice that
+	 * is just a no-go. we'll use that for -R, naturally.
+	 */
+	if (ti.lra_v) {
+		pd->lra = be32_to_cpu(ti.last_rec_address);
+		set_bit(PACKET_LRA_VALID, &pd->flags);
+	} else {
+		pd->lra = 0xffffffff;
+		set_bit(PACKET_LRA_VALID, &pd->flags);
+	}
+
+	/*
+	 * fine for now
+	 */
+	pd->settings.link_loss = 7;
+	pd->settings.write_type = 0;	/* packet */
+	pd->settings.track_mode = ti.track_mode;
+
+	/*
+	 * mode1 or mode2 disc
+	 */
+	switch (ti.data_mode) {
+		case PACKET_MODE1:
+			pd->settings.block_mode = PACKET_BLOCK_MODE1;
+			break;
+		case PACKET_MODE2:
+			pd->settings.block_mode = PACKET_BLOCK_MODE2;
+			break;
+		default:
+			printk("pktcdvd: unknown data mode\n");
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * enable/disable write caching on drive
+ */
+static int pkt_write_caching(struct pktcdvd_device *pd, int set)
+{
+	struct packet_command cgc;
+	struct request_sense sense;
+	unsigned char buf[64];
+	int ret;
+
+	memset(buf, 0, sizeof(buf));
+	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
+	cgc.sense = &sense;
+	cgc.buflen = pd->mode_offset + 12;
+
+	/*
+	 * caching mode page might not be there, so quiet this command
+	 */
+	cgc.quiet = 1;
+
+	if ((ret = pkt_mode_sense(pd, &cgc, GPMODE_WCACHING_PAGE, 0)))
+		return ret;
+
+	buf[pd->mode_offset + 10] |= (!!set << 2);
+
+	cgc.buflen = cgc.cmd[8] = 2 + ((buf[0] << 8) | (buf[1] & 0xff));
+	ret = pkt_mode_select(pd, &cgc);
+	if (ret) {
+		printk("pktcdvd: write caching control failed\n");
+		pkt_dump_sense(&cgc);
+	} else if (!ret && set)
+		printk("pktcdvd: enabled write caching on %s\n", pd->name);
+	return ret;
+}
+
+static int pkt_lock_door(struct pktcdvd_device *pd, int lockflag)
+{
+	struct packet_command cgc;
+
+	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
+	cgc.cmd[0] = GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
+	cgc.cmd[4] = lockflag ? 1 : 0;
+	return pkt_generic_packet(pd, &cgc);
+}
+
+/*
+ * Returns drive maximum write speed
+ */
+static int pkt_get_max_speed(struct pktcdvd_device *pd, unsigned *write_speed)
+{
+	struct packet_command cgc;
+	struct request_sense sense;
+	unsigned char buf[256+18];
+	unsigned char *cap_buf;
+	int ret, offset;
+
+	memset(buf, 0, sizeof(buf));
+	cap_buf = &buf[sizeof(struct mode_page_header) + pd->mode_offset];
+	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_UNKNOWN);
+	cgc.sense = &sense;
+
+	ret = pkt_mode_sense(pd, &cgc, GPMODE_CAPABILITIES_PAGE, 0);
+	if (ret) {
+		cgc.buflen = pd->mode_offset + cap_buf[1] + 2 +
+			     sizeof(struct mode_page_header);
+		ret = pkt_mode_sense(pd, &cgc, GPMODE_CAPABILITIES_PAGE, 0);
+		if (ret) {
+			pkt_dump_sense(&cgc);
+			return ret;
+		}
+	}
+
+	offset = 20;			    /* Obsoleted field, used by older drives */
+	if (cap_buf[1] >= 28)
+		offset = 28;		    /* Current write speed selected */
+	if (cap_buf[1] >= 30) {
+		/* If the drive reports at least one "Logical Unit Write
+		 * Speed Performance Descriptor Block", use the information
+		 * in the first block. (contains the highest speed)
+		 */
+		int num_spdb = (cap_buf[30] << 8) + cap_buf[31];
+		if (num_spdb > 0)
+			offset = 34;
+	}
+
+	*write_speed = ((cap_buf[offset] << 8) | cap_buf[offset + 1]) / 0xb0;
+	return 0;
+}
+
+/* These tables from cdrecord - I don't have orange book */
+/* standard speed CD-RW (1-4x) */
+static char clv_to_speed[16] = {
+	/* 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 */
+	   0, 2, 4, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+};
+/* high speed CD-RW (-10x) */
+static char hs_clv_to_speed[16] = {
+	/* 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 */
+	   0, 2, 4, 6, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+};
+/* ultra high speed CD-RW */
+static char us_clv_to_speed[16] = {
+	/* 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 */
+	   0, 2, 4, 8, 0, 0,16, 0,24,32,40,48, 0, 0, 0, 0
+};
+
+/*
+ * reads the maximum media speed from ATIP
+ */
+static int pkt_media_speed(struct pktcdvd_device *pd, unsigned *speed)
+{
+	struct packet_command cgc;
+	struct request_sense sense;
+	unsigned char buf[64];
+	unsigned int size, st, sp;
+	int ret;
+
+	init_cdrom_command(&cgc, buf, 2, CGC_DATA_READ);
+	cgc.sense = &sense;
+	cgc.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
+	cgc.cmd[1] = 2;
+	cgc.cmd[2] = 4; /* READ ATIP */
+	cgc.cmd[8] = 2;
+	ret = pkt_generic_packet(pd, &cgc);
+	if (ret) {
+		pkt_dump_sense(&cgc);
+		return ret;
+	}
+	size = ((unsigned int) buf[0]<<8) + buf[1] + 2;
+	if (size > sizeof(buf))
+		size = sizeof(buf);
+
+	init_cdrom_command(&cgc, buf, size, CGC_DATA_READ);
+	cgc.sense = &sense;
+	cgc.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
+	cgc.cmd[1] = 2;
+	cgc.cmd[2] = 4;
+	cgc.cmd[8] = size;
+	ret = pkt_generic_packet(pd, &cgc);
+	if (ret) {
+		pkt_dump_sense(&cgc);
+		return ret;
+	}
+
+	if (!buf[6] & 0x40) {
+		printk("pktcdvd: Disc type is not CD-RW\n");
+		return 1;
+	}
+	if (!buf[6] & 0x4) {
+		printk("pktcdvd: A1 values on media are not valid, maybe not CDRW?\n");
+		return 1;
+	}
+
+	st = (buf[6] >> 3) & 0x7; /* disc sub-type */
+
+	sp = buf[16] & 0xf; /* max speed from ATIP A1 field */
+
+	/* Info from cdrecord */
+	switch (st) {
+		case 0: /* standard speed */
+			*speed = clv_to_speed[sp];
+			break;
+		case 1: /* high speed */
+			*speed = hs_clv_to_speed[sp];
+			break;
+		case 2: /* ultra high speed */
+			*speed = us_clv_to_speed[sp];
+			break;
+		default:
+			printk("pktcdvd: Unknown disc sub-type %d\n",st);
+			return 1;
+	}
+	if (*speed) {
+		printk("pktcdvd: Max. media speed: %d\n",*speed);
+		return 0;
+	} else {
+		printk("pktcdvd: Unknown speed %d for sub-type %d\n",sp,st);
+		return 1;
+	}
+}
+
+static int pkt_perform_opc(struct pktcdvd_device *pd)
+{
+	struct packet_command cgc;
+	struct request_sense sense;
+	int ret;
+
+	VPRINTK("pktcdvd: Performing OPC\n");
+
+	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
+	cgc.sense = &sense;
+	cgc.timeout = 60*HZ;
+	cgc.cmd[0] = GPCMD_SEND_OPC;
+	cgc.cmd[1] = 1;
+	if ((ret = pkt_generic_packet(pd, &cgc)))
+		pkt_dump_sense(&cgc);
+	return ret;
+}
+
+static int pkt_open_write(struct pktcdvd_device *pd)
+{
+	int ret;
+	unsigned int write_speed, media_write_speed, read_speed;
+
+	if ((ret = pkt_probe_settings(pd))) {
+		DPRINTK("pktcdvd: %s failed probe\n", pd->name);
+		return -EIO;
+	}
+
+	if ((ret = pkt_set_write_settings(pd))) {
+		DPRINTK("pktcdvd: %s failed saving write settings\n", pd->name);
+		return -EIO;
+	}
+
+	pkt_write_caching(pd, USE_WCACHING);
+
+	if ((ret = pkt_get_max_speed(pd, &write_speed)))
+		write_speed = 16;
+	if ((ret = pkt_media_speed(pd, &media_write_speed)))
+		media_write_speed = 16;
+	write_speed = min(write_speed, media_write_speed);
+	read_speed = write_speed;
+
+	if ((ret = pkt_set_speed(pd, write_speed, read_speed))) {
+		DPRINTK("pktcdvd: %s couldn't set write speed\n", pd->name);
+		return -EIO;
+	}
+	DPRINTK("pktcdvd: write speed %u\n", write_speed);
+	pd->write_speed = write_speed;
+	pd->read_speed = read_speed;
+
+	if ((ret = pkt_perform_opc(pd))) {
+		DPRINTK("pktcdvd: %s Optimum Power Calibration failed\n", pd->name);
+	}
+
+	return 0;
+}
+
+static int pkt_get_minor(struct pktcdvd_device *pd)
+{
+	int minor;
+	for (minor = 0; minor < MAX_WRITERS; minor++)
+		if (pd == &pkt_devs[minor])
+			break;
+	BUG_ON(minor == MAX_WRITERS);
+	return minor;
+}
+
+/*
+ * called at open time.
+ */
+static int pkt_open_dev(struct pktcdvd_device *pd, int write)
+{
+	int ret;
+	long lba;
+	request_queue_t *q;
+	int i;
+	char b[BDEVNAME_SIZE];
+
+	if (!pd->dev)
+		return -ENXIO;
+
+	pd->bdev = bdget(pd->dev);
+	if (!pd->bdev) {
+		printk("pktcdvd: can't find cdrom block device\n");
+		return -ENXIO;
+	}
+
+	if ((ret = blkdev_get(pd->bdev, FMODE_READ, 0))) {
+		pd->bdev = NULL;
+		return ret;
+	}
+
+	if ((ret = pkt_get_last_written(pd, &lba))) {
+		printk("pktcdvd: pkt_get_last_written failed\n");
+		return ret;
+	}
+
+	set_capacity(disks[pkt_get_minor(pd)], lba << 2);
+
+	/*
+	 * The underlying block device needs to have its merge logic
+	 * modified, so that it doesn't try to merge write requests.
+	 * First make sure the queue isn't already in use by another
+	 * pktcdvd_device.
+	 */
+	q = bdev_get_queue(pd->bdev);
+	for (i = 0; i < MAX_WRITERS; i++) {
+		if (pd == &pkt_devs[i])
+			continue;
+		if (pkt_devs[i].bdev && bdev_get_queue(pkt_devs[i].bdev) == q) {
+			printk("pktcdvd: %s request queue busy\n", bdevname(pd->bdev, b));
+			return -EBUSY;
+		}
+	}
+	spin_lock_irq(q->queue_lock);
+	pd->cdrw.elv_merge_fn = q->elevator.elevator_merge_fn;
+	pd->cdrw.elv_completed_req_fn = q->elevator.elevator_completed_req_fn;
+	pd->cdrw.merge_requests_fn = q->merge_requests_fn;
+	q->elevator.elevator_merge_fn = pkt_lowlevel_elv_merge_fn;
+	q->elevator.elevator_completed_req_fn = pkt_lowlevel_elv_completed_req_fn;
+	q->merge_requests_fn = pkt_lowlevel_merge_requests_fn;
+	spin_unlock_irq(q->queue_lock);
+
+	if (write) {
+		if ((ret = pkt_open_write(pd)))
+			goto restore_queue;
+		set_bit(PACKET_WRITABLE, &pd->flags);
+	} else {
+		pkt_set_speed(pd, 0xffff, 0xffff);
+		clear_bit(PACKET_WRITABLE, &pd->flags);
+	}
+
+	if ((ret = pkt_set_segment_merging(pd, q)))
+		goto restore_queue;
+
+	if (write)
+		printk("pktcdvd: %lukB available on disc\n", lba << 1);
+
+	return 0;
+
+restore_queue:
+	spin_lock_irq(q->queue_lock);
+	q->elevator.elevator_merge_fn = pd->cdrw.elv_merge_fn;
+	q->elevator.elevator_completed_req_fn = pd->cdrw.elv_completed_req_fn;
+	q->merge_requests_fn = pd->cdrw.merge_requests_fn;
+	spin_unlock_irq(q->queue_lock);
+	return ret;
+}
+
+/*
+ * called when the device is closed. makes sure that the device flushes
+ * the internal cache before we close.
+ */
+static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
+{
+	struct block_device *bdev;
+
+	atomic_dec(&pd->refcnt);
+	if (atomic_read(&pd->refcnt) > 0)
+		return;
+
+	bdev = bdget(pd->pkt_dev);
+	if (bdev) {
+		fsync_bdev(bdev);
+		bdput(bdev);
+	}
+
+	if (flush && pkt_flush_cache(pd))
+		DPRINTK("pktcdvd: %s not flushing cache\n", pd->name);
+
+	if (pd->bdev) {
+		request_queue_t *q = bdev_get_queue(pd->bdev);
+		pkt_set_speed(pd, 0xffff, 0xffff);
+		spin_lock_irq(q->queue_lock);
+		q->elevator.elevator_merge_fn = pd->cdrw.elv_merge_fn;
+		q->elevator.elevator_completed_req_fn = pd->cdrw.elv_completed_req_fn;
+		q->merge_requests_fn = pd->cdrw.merge_requests_fn;
+		spin_unlock_irq(q->queue_lock);
+		blkdev_put(pd->bdev);
+		pd->bdev = NULL;
+	}
+}
+
+static int pkt_open(struct inode *inode, struct file *file)
+{
+	struct pktcdvd_device *pd = NULL;
+	struct block_device *pkt_bdev;
+	int ret;
+
+	VPRINTK("pktcdvd: entering open\n");
+
+	if (iminor(inode) >= MAX_WRITERS) {
+		printk("pktcdvd: max %d writers supported\n", MAX_WRITERS);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/*
+	 * either device is not configured, or pktsetup is old and doesn't
+	 * use O_CREAT to create device
+	 */
+	pd = &pkt_devs[iminor(inode)];
+	if (!pd->dev && !(file->f_flags & O_CREAT)) {
+		VPRINTK("pktcdvd: not configured and O_CREAT not set\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	atomic_inc(&pd->refcnt);
+	if (atomic_read(&pd->refcnt) > 1) {
+		if (file->f_mode & FMODE_WRITE) {
+			VPRINTK("pktcdvd: busy open for write\n");
+			ret = -EBUSY;
+			goto out_dec;
+		}
+
+		/*
+		 * Not first open, everything is already set up
+		 */
+		return 0;
+	}
+
+	if (((file->f_flags & O_ACCMODE) != O_RDONLY) || !(file->f_flags & O_CREAT)) {
+		if (pkt_open_dev(pd, file->f_mode & FMODE_WRITE)) {
+			ret = -EIO;
+			goto out_dec;
+		}
+	}
+
+	/*
+	 * needed here as well, since ext2 (among others) may change
+	 * the blocksize at mount time
+	 */
+	pkt_bdev = bdget(inode->i_rdev);
+	if (pkt_bdev) {
+		set_blocksize(pkt_bdev, CD_FRAMESIZE);
+		bdput(pkt_bdev);
+	}
+	return 0;
+
+out_dec:
+	atomic_dec(&pd->refcnt);
+	if (atomic_read(&pd->refcnt) == 0) {
+		if (pd->bdev) {
+			blkdev_put(pd->bdev);
+			pd->bdev = NULL;
+		}
+	}
+out:
+	VPRINTK("pktcdvd: failed open (%d)\n", ret);
+	return ret;
+}
+
+static int pkt_close(struct inode *inode, struct file *file)
+{
+	struct pktcdvd_device *pd = &pkt_devs[iminor(inode)];
+	int ret = 0;
+
+	if (pd->dev) {
+		int flush = test_bit(PACKET_WRITABLE, &pd->flags);
+		pkt_release_dev(pd, flush);
+	}
+
+	return ret;
+}
+
+static int pkt_make_request(request_queue_t *q, struct bio *bio)
+{
+	struct pktcdvd_device *pd;
+	char b[BDEVNAME_SIZE];
+	sector_t zone;
+	struct packet_data *pkt;
+	int was_empty, blocked_bio;
+
+	pd = q->queuedata;
+	if (!pd) {
+		printk("pktcdvd: %s incorrect request queue\n", bdevname(bio->bi_bdev, b));
+		goto end_io;
+	}
+
+	if (!pd->dev) {
+		printk("pktcdvd: request received for non-active pd\n");
+		goto end_io;
+	}
+
+	/*
+	 * quick remap a READ
+	 */
+	if (bio_data_dir(bio) == READ) {
+		bio->bi_bdev = pd->bdev;
+		pd->stats.secs_r += bio->bi_size >> 9;
+		pkt_queue_bio(pd, bio, 1);
+		return 0;
+	}
+
+	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
+		printk("pktcdvd: WRITE for ro device %s (%llu)\n",
+			pd->name, (unsigned long long)bio->bi_sector);
+		goto end_io;
+	}
+
+	if (!bio->bi_size || (bio->bi_size % CD_FRAMESIZE)) {
+		printk("pktcdvd: wrong bio size\n");
+		goto end_io;
+	}
+
+	blk_queue_bounce(q, &bio);
+
+	zone = ZONE(bio->bi_sector, pd);
+	VPRINTK("pkt_make_request: start = %6llx stop = %6llx\n",
+		(unsigned long long)bio->bi_sector,
+		(unsigned long long)(bio->bi_sector + bio_sectors(bio)));
+
+	/* Check if we have to split the bio */
+	{
+		struct bio_pair *bp;
+		sector_t last_zone;
+		int first_sectors;
+
+		last_zone = ZONE(bio->bi_sector + bio_sectors(bio) - 1, pd);
+		if (last_zone != zone) {
+			BUG_ON(last_zone != zone + pd->settings.size);
+			first_sectors = last_zone - bio->bi_sector;
+			bp = bio_split(bio, bio_split_pool, first_sectors);
+			BUG_ON(!bp);
+			pkt_make_request(q, &bp->bio1);
+			pkt_make_request(q, &bp->bio2);
+			bio_pair_release(bp);
+			return 0;
+		}
+	}
+
+	/*
+	 * If we find a matching packet in state WAITING or READ_WAIT, we can
+	 * just append this bio to that packet.
+	 */
+	spin_lock(&pd->cdrw.active_list_lock);
+	blocked_bio = 0;
+	list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
+		if (pkt->sector == zone) {
+			spin_lock(&pkt->lock);
+			if ((pkt->state == PACKET_WAITING_STATE) ||
+			    (pkt->state == PACKET_READ_WAIT_STATE)) {
+				pkt_add_list_last(bio, &pkt->orig_bios,
+						  &pkt->orig_bios_tail);
+				pkt->write_size += bio->bi_size / CD_FRAMESIZE;
+				if ((pkt->write_size >= pkt->frames) &&
+				    (pkt->state == PACKET_WAITING_STATE)) {
+					atomic_inc(&pkt->run_sm);
+					wake_up(&pd->wqueue);
+				}
+				spin_unlock(&pkt->lock);
+				spin_unlock(&pd->cdrw.active_list_lock);
+				return 0;
+			} else {
+				blocked_bio = 1;
+			}
+			spin_unlock(&pkt->lock);
+		}
+	}
+	spin_unlock(&pd->cdrw.active_list_lock);
+
+	/*
+	 * No matching packet found. Store the bio in the work queue.
+	 */
+	spin_lock(&pd->lock);
+	if (pd->bio_queue == NULL) {
+		was_empty = 1;
+		bio->bi_next = NULL;
+		pd->bio_queue = bio;
+		pd->bio_queue_tail = bio;
+	} else {
+		struct bio *bio2, *insert_after;
+		int distance, z, cnt;
+
+		was_empty = 0;
+		z = ZONE(pd->bio_queue_tail->bi_sector, pd);
+		distance = (zone >= z ? zone - z : INT_MAX);
+		insert_after = pd->bio_queue_tail;
+		if (distance > pd->settings.size) {
+			for (bio2 = pd->bio_queue, cnt = 0; bio2 && (cnt < 10000);
+			     bio2 = bio2->bi_next, cnt++) {
+				int d2;
+				z = ZONE(bio2->bi_sector, pd);
+				d2 = (zone >= z ? zone - z : INT_MAX);
+				if (d2 < distance) {
+					distance = d2;
+					insert_after = bio2;
+					if (distance == 0)
+						break;
+				}
+			}
+		}
+		bio->bi_next = insert_after->bi_next;
+		insert_after->bi_next = bio;
+		if (insert_after == pd->bio_queue_tail)
+			pd->bio_queue_tail = bio;
+	}
+	spin_unlock(&pd->lock);
+
+	/*
+	 * Wake up the worker thread.
+	 */
+	atomic_set(&pd->scan_queue, 1);
+	if (was_empty) {
+		/* This wake_up is required for correct operation */
+		wake_up(&pd->wqueue);
+	} else if (!list_empty(&pd->cdrw.pkt_free_list) && !blocked_bio) {
+		/*
+		 * This wake up is not required for correct operation,
+		 * but improves performance in some cases.
+		 */
+		wake_up(&pd->wqueue);
+	}
+	return 0;
+end_io:
+	bio_io_error(bio, bio->bi_size);
+	return 0;
+}
+
+
+
+static int pkt_merge_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *bvec)
+{
+	struct pktcdvd_device *pd = &pkt_devs[MINOR(bio->bi_bdev->bd_dev)];
+	sector_t zone = ZONE(bio->bi_sector, pd);
+	int used = ((bio->bi_sector - zone) << 9) + bio->bi_size;
+	int remaining = (pd->settings.size << 9) - used;
+	int remaining2;
+
+	/*
+	 * A bio <= PAGE_SIZE must be allowed. If it crosses a packet
+	 * boundary, pkt_make_request() will split the bio.
+	 */
+	remaining2 = PAGE_SIZE - bio->bi_size;
+	remaining = max(remaining, remaining2);
+
+	BUG_ON(remaining < 0);
+	return remaining;
+}
+
+static void pkt_init_queue(struct pktcdvd_device *pd)
+{
+	request_queue_t *q = disks[pkt_get_minor(pd)]->queue;
+
+	blk_queue_make_request(q, pkt_make_request);
+	blk_queue_hardsect_size(q, CD_FRAMESIZE);
+	blk_queue_max_sectors(q, PACKET_MAX_SECTORS);
+	blk_queue_merge_bvec(q, pkt_merge_bvec);
+	q->queuedata = pd;
+}
+
+static int pkt_proc_device(struct pktcdvd_device *pd, char *buf)
+{
+	char *b = buf, *msg;
+	char bdev_buf[BDEVNAME_SIZE];
+	int states[PACKET_NUM_STATES];
+
+	b += sprintf(b, "\nWriter %s mapped to %s:\n", pd->name,
+		     __bdevname(pd->dev, bdev_buf));
+
+	b += sprintf(b, "\nSettings:\n");
+	b += sprintf(b, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
+
+	if (pd->settings.write_type == 0)
+		msg = "Packet";
+	else
+		msg = "Unknown";
+	b += sprintf(b, "\twrite type:\t\t%s\n", msg);
+
+	b += sprintf(b, "\tpacket type:\t\t%s\n", pd->settings.fp ? "Fixed" : "Variable");
+	b += sprintf(b, "\tlink loss:\t\t%d\n", pd->settings.link_loss);
+
+	b += sprintf(b, "\ttrack mode:\t\t%d\n", pd->settings.track_mode);
+
+	if (pd->settings.block_mode == PACKET_BLOCK_MODE1)
+		msg = "Mode 1";
+	else if (pd->settings.block_mode == PACKET_BLOCK_MODE2)
+		msg = "Mode 2";
+	else
+		msg = "Unknown";
+	b += sprintf(b, "\tblock mode:\t\t%s\n", msg);
+
+	b += sprintf(b, "\nStatistics:\n");
+	b += sprintf(b, "\tpackets started:\t%lu\n", pd->stats.pkt_started);
+	b += sprintf(b, "\tpackets ended:\t\t%lu\n", pd->stats.pkt_ended);
+	b += sprintf(b, "\twritten:\t\t%lukB\n", pd->stats.secs_w >> 1);
+	b += sprintf(b, "\tread gather:\t\t%lukB\n", pd->stats.secs_rg >> 1);
+	b += sprintf(b, "\tread:\t\t\t%lukB\n", pd->stats.secs_r >> 1);
+
+	b += sprintf(b, "\nMisc:\n");
+	b += sprintf(b, "\treference count:\t%d\n", atomic_read(&pd->refcnt));
+	b += sprintf(b, "\tflags:\t\t\t0x%lx\n", pd->flags);
+	b += sprintf(b, "\tread speed:\t\t%ukB/s\n", pd->read_speed * 150);
+	b += sprintf(b, "\twrite speed:\t\t%ukB/s\n", pd->write_speed * 150);
+	b += sprintf(b, "\tstart offset:\t\t%lu\n", pd->offset);
+	b += sprintf(b, "\tmode page offset:\t%u\n", pd->mode_offset);
+
+	b += sprintf(b, "\nQueue state:\n");
+	b += sprintf(b, "\tbios queued:\t\t%s\n", pd->bio_queue ? "yes" : "no");
+
+	pkt_count_states(pd, states);
+	b += sprintf(b, "\tstate:\t\t\ti:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
+		     states[0], states[1], states[2], states[3], states[4], states[5]);
+
+	return b - buf;
+}
+
+static int pkt_read_proc(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	struct pktcdvd_device *pd = data;
+	char *buf = page;
+	int len;
+
+	len = pkt_proc_device(pd, buf);
+	buf += len;
+
+	if (len <= off + count)
+		*eof = 1;
+
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+
+extern struct block_device_operations pktcdvd_ops;
+
+static int pkt_new_dev(struct pktcdvd_device *pd, struct block_device *bdev)
+{
+	dev_t dev = bdev->bd_dev;
+	int minor;
+	int ret = 0;
+	char b[BDEVNAME_SIZE];
+
+	for (minor = 0; minor < MAX_WRITERS; minor++) {
+		if (pkt_devs[minor].dev == dev) {
+			printk("pktcdvd: %s already setup\n", bdevname(bdev, b));
+			return -EBUSY;
+		}
+	}
+
+	minor = pkt_get_minor(pd);
+
+	/* This is safe, since we have a reference from open(). */
+	__module_get(THIS_MODULE);
+
+	memset(pd, 0, sizeof(struct pktcdvd_device));
+
+	spin_lock_init(&pd->lock);
+	spin_lock_init(&pd->iosched.lock);
+	if (!pkt_grow_pktlist(pd, CONFIG_CDROM_PKTCDVD_BUFFERS)) {
+		printk("pktcdvd: not enough memory for buffers\n");
+		ret = -ENOMEM;
+		goto out_mem;
+	}
+
+	set_blocksize(bdev, CD_FRAMESIZE);
+	pd->dev = dev;
+	pd->bdev = NULL;
+	pd->pkt_dev = MKDEV(PACKET_MAJOR, minor);
+	sprintf(pd->name, "pktcdvd%d", minor);
+	atomic_set(&pd->refcnt, 0);
+	init_waitqueue_head(&pd->wqueue);
+	init_completion(&pd->cdrw.thr_compl);
+
+	pkt_init_queue(pd);
+
+	pd->cdrw.time_to_die = 0;
+	pd->cdrw.pid = kernel_thread(kcdrwd, pd, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
+	if (pd->cdrw.pid < 0) {
+		printk("pktcdvd: can't start kernel thread\n");
+		ret = -EBUSY;
+		goto out_thread;
+	}
+
+	create_proc_read_entry(pd->name, 0, pkt_proc, pkt_read_proc, pd);
+	DPRINTK("pktcdvd: writer %d mapped to %s\n", minor, bdevname(bdev, b));
+	return 0;
+
+out_thread:
+	pkt_shrink_pktlist(pd);
+	memset(pd, 0, sizeof(*pd));
+out_mem:
+	/* This is safe: open() is still holding a reference. */
+	module_put(THIS_MODULE);
+	return ret;
+}
+
+/*
+ * arg contains file descriptor of CD-ROM device.
+ */
+static int pkt_setup_dev(struct pktcdvd_device *pd, unsigned int arg)
+{
+	struct inode *inode;
+	struct file *file;
+	int ret;
+
+	if ((file = fget(arg)) == NULL) {
+		printk("pktcdvd: bad file descriptor passed\n");
+		return -EBADF;
+	}
+
+	ret = -EINVAL;
+	if ((inode = file->f_dentry->d_inode) == NULL) {
+		printk("pktcdvd: huh? file descriptor contains no inode?\n");
+		goto out;
+	}
+	ret = -ENOTBLK;
+	if (!S_ISBLK(inode->i_mode)) {
+		printk("pktcdvd: device is not a block device (duh)\n");
+		goto out;
+	}
+	ret = -EROFS;
+	if (IS_RDONLY(inode)) {
+		printk("pktcdvd: Can't write to read-only dev\n");
+		goto out;
+	}
+	if ((ret = pkt_new_dev(pd, inode->i_bdev)))
+		goto out;
+
+	atomic_inc(&pd->refcnt);
+
+out:
+	fput(file);
+	return ret;
+}
+
+static int pkt_remove_dev(struct pktcdvd_device *pd)
+{
+	struct block_device *bdev;
+	int ret;
+
+	if (pd->cdrw.pid >= 0) {
+		pd->cdrw.time_to_die = 1;
+		wmb();
+		ret = kill_proc(pd->cdrw.pid, SIGKILL, 1);
+		if (ret) {
+			printk("pkt_remove_dev: can't kill kernel thread\n");
+			return ret;
+		}
+		wait_for_completion(&pd->cdrw.thr_compl);
+	}
+
+	/*
+	 * will also invalidate buffers for CD-ROM
+	 */
+	bdev = bdget(pd->pkt_dev);
+	if (bdev) {
+		invalidate_bdev(bdev, 1);
+		bdput(bdev);
+	}
+
+	pkt_shrink_pktlist(pd);
+
+	remove_proc_entry(pd->name, pkt_proc);
+	DPRINTK("pktcdvd: writer %d unmapped\n", pkt_get_minor(pd));
+	memset(pd, 0, sizeof(struct pktcdvd_device));
+	/* This is safe: open() is still holding a reference. */
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+static int pkt_media_changed(struct gendisk *disk)
+{
+	struct pktcdvd_device *pd = disk->private_data;
+	struct gendisk *attached_disk;
+
+	if (!pd)
+		return 0;
+	if (!pd->bdev)
+		return 0;
+	attached_disk = pd->bdev->bd_disk;
+	if (!attached_disk)
+		return 0;
+	return attached_disk->fops->media_changed(attached_disk);
+}
+
+static int pkt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pktcdvd_device *pd = &pkt_devs[iminor(inode)];
+
+	VPRINTK("pkt_ioctl: cmd %x, dev %d:%d\n", cmd, imajor(inode), iminor(inode));
+
+	if ((cmd != PACKET_SETUP_DEV) && !pd->dev) {
+		DPRINTK("pktcdvd: dev not setup\n");
+		return -ENXIO;
+	}
+
+	switch (cmd) {
+	case PACKET_GET_STATS:
+		if (copy_to_user(&arg, &pd->stats, sizeof(struct packet_stats)))
+			return -EFAULT;
+		break;
+
+	case PACKET_SETUP_DEV:
+		if (pd->dev) {
+			printk("pktcdvd: dev already setup\n");
+			return -EBUSY;
+		}
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		return pkt_setup_dev(pd, arg);
+
+	case PACKET_TEARDOWN_DEV:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (atomic_read(&pd->refcnt) != 1)
+			return -EBUSY;
+		return pkt_remove_dev(pd);
+
+	case BLKROSET:
+		if (capable(CAP_SYS_ADMIN))
+			clear_bit(PACKET_WRITABLE, &pd->flags);
+	case BLKROGET:
+	case BLKSSZGET:
+	case BLKFLSBUF:
+		if (!pd->bdev)
+			return -ENXIO;
+		return -EINVAL;		    /* Handled by blkdev layer */
+
+	/*
+	 * forward selected CDROM ioctls to CD-ROM, for UDF
+	 */
+	case CDROMMULTISESSION:
+	case CDROMREADTOCENTRY:
+	case CDROM_LAST_WRITTEN:
+	case CDROM_SEND_PACKET:
+	case SCSI_IOCTL_SEND_COMMAND:
+		if (!pd->bdev)
+			return -ENXIO;
+		return ioctl_by_bdev(pd->bdev, cmd, arg);
+
+	case CDROMEJECT:
+		if (!pd->bdev)
+			return -ENXIO;
+		/*
+		 * The door gets locked when the device is opened, so we
+		 * have to unlock it or else the eject command fails.
+		 */
+		pkt_lock_door(pd, 0);
+		return ioctl_by_bdev(pd->bdev, cmd, arg);
+
+	default:
+		printk("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static struct block_device_operations pktcdvd_ops = {
+	.owner =		THIS_MODULE,
+	.open =			pkt_open,
+	.release =		pkt_close,
+	.ioctl =		pkt_ioctl,
+	.media_changed =	pkt_media_changed,
+};
+
+int pkt_init(void)
+{
+	int i;
+
+	devfs_mk_dir("pktcdvd");
+	if (register_blkdev(PACKET_MAJOR, "pktcdvd")) {
+		printk("unable to register pktcdvd device\n");
+		return -EIO;
+	}
+
+	pkt_devs = kmalloc(MAX_WRITERS * sizeof(struct pktcdvd_device), GFP_KERNEL);
+	if (pkt_devs == NULL)
+		goto out_mem;
+	memset(pkt_devs, 0, MAX_WRITERS * sizeof(struct pktcdvd_device));
+
+	for (i = 0; i < MAX_WRITERS; i++) {
+		disks[i] = alloc_disk(1);
+		if (!disks[i])
+			goto out_mem2;
+	}
+
+	for (i = 0; i < MAX_WRITERS; i++) {
+		struct pktcdvd_device *pd = &pkt_devs[i];
+		struct gendisk *disk = disks[i];
+		disk->major = PACKET_MAJOR;
+		disk->first_minor = i;
+		disk->fops = &pktcdvd_ops;
+		disk->flags = GENHD_FL_REMOVABLE;
+		sprintf(disk->disk_name, "pktcdvd%d", i);
+		sprintf(disk->devfs_name, "pktcdvd/%d", i);
+		disk->private_data = pd;
+		disk->queue = blk_alloc_queue(GFP_KERNEL);
+		if (!disk->queue)
+			goto out_mem3;
+		add_disk(disk);
+	}
+
+	pkt_proc = proc_mkdir("pktcdvd", proc_root_driver);
+
+	DPRINTK("pktcdvd: %s\n", VERSION_CODE);
+	return 0;
+
+out_mem3:
+	while (i--)
+		blk_put_queue(disks[i]->queue);
+	i = MAX_WRITERS;
+out_mem2:
+	while (i--)
+		put_disk(disks[i]);
+	kfree(pkt_devs);
+out_mem:
+	printk("pktcdvd: out of memory\n");
+	devfs_remove("pktcdvd");
+	unregister_blkdev(PACKET_MAJOR, "pktcdvd");
+	return -ENOMEM;
+}
+
+void pkt_exit(void)
+{
+	int i;
+	for (i = 0; i < MAX_WRITERS; i++) {
+		del_gendisk(disks[i]);
+		blk_put_queue(disks[i]->queue);
+		put_disk(disks[i]);
+	}
+
+	devfs_remove("pktcdvd");
+	unregister_blkdev(PACKET_MAJOR, "pktcdvd");
+
+	remove_proc_entry("pktcdvd", proc_root_driver);
+	kfree(pkt_devs);
+}
+
+MODULE_DESCRIPTION("Packet writing layer for CD/DVD drives");
+MODULE_AUTHOR("Jens Axboe <axboe@suse.de>");
+MODULE_LICENSE("GPL");
+
+module_init(pkt_init);
+module_exit(pkt_exit);
+
+MODULE_ALIAS_BLOCKDEV_MAJOR(PACKET_MAJOR);
diff -puN drivers/cdrom/Makefile~packet-2.6.7 drivers/cdrom/Makefile
--- linux/drivers/cdrom/Makefile~packet-2.6.7	2004-07-01 13:23:15.000000000 +0200
+++ linux-petero/drivers/cdrom/Makefile	2004-07-01 13:23:15.000000000 +0200
@@ -8,6 +8,7 @@
 obj-$(CONFIG_BLK_DEV_IDECD)	+=              cdrom.o
 obj-$(CONFIG_BLK_DEV_SR)	+=              cdrom.o
 obj-$(CONFIG_PARIDE_PCD)	+=		cdrom.o
+obj-$(CONFIG_CDROM_PKTCDVD)	+=		cdrom.o
 
 obj-$(CONFIG_AZTCD)		+= aztcd.o
 obj-$(CONFIG_CDU31A)		+= cdu31a.o     cdrom.o
diff -puN drivers/ide/ide-cd.c~packet-2.6.7 drivers/ide/ide-cd.c
--- linux/drivers/ide/ide-cd.c~packet-2.6.7	2004-07-01 13:23:15.000000000 +0200
+++ linux-petero/drivers/ide/ide-cd.c	2004-07-01 15:05:03.298119232 +0200
@@ -2003,7 +2003,7 @@ ide_do_rw_cdrom (ide_drive_t *drive, str
 			}
 			CDROM_CONFIG_FLAGS(drive)->seeking = 0;
 		}
-		if (IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap) {
+		if ((rq_data_dir(rq) == READ) && IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap) {
 			action = cdrom_start_seek(drive, block);
 		} else {
 			if (rq_data_dir(rq) == READ)
@@ -2960,8 +2960,10 @@ int ide_cdrom_probe_capabilities (ide_dr
 		CDROM_CONFIG_FLAGS(drive)->no_eject = 0;
 	if (cap.cd_r_write)
 		CDROM_CONFIG_FLAGS(drive)->cd_r = 1;
-	if (cap.cd_rw_write)
+	if (cap.cd_rw_write) {
 		CDROM_CONFIG_FLAGS(drive)->cd_rw = 1;
+		CDROM_CONFIG_FLAGS(drive)->ram = 1;
+	}
 	if (cap.test_write)
 		CDROM_CONFIG_FLAGS(drive)->test_write = 1;
 	if (cap.dvd_ram_read || cap.dvd_r_read || cap.dvd_rom)
diff -puN drivers/scsi/sr.c~packet-2.6.7 drivers/scsi/sr.c
--- linux/drivers/scsi/sr.c~packet-2.6.7	2004-07-01 13:23:15.000000000 +0200
+++ linux-petero/drivers/scsi/sr.c	2004-07-01 15:05:03.274122880 +0200
@@ -880,10 +880,10 @@ static void get_capabilities(struct scsi
 		cd->cdi.mask |= CDC_CLOSE_TRAY; */
 
 	/*
-	 * if DVD-RAM of MRW-W, we are randomly writeable
+	 * if DVD-RAM, MRW-W or CD-RW, we are randomly writable
 	 */
-	if ((cd->cdi.mask & (CDC_DVD_RAM | CDC_MRW_W | CDC_RAM)) !=
-			(CDC_DVD_RAM | CDC_MRW_W | CDC_RAM)) {
+	if ((cd->cdi.mask & (CDC_DVD_RAM | CDC_MRW_W | CDC_RAM | CDC_CD_RW)) !=
+			(CDC_DVD_RAM | CDC_MRW_W | CDC_RAM | CDC_CD_RW)) {
 		cd->device->writeable = 1;
 		set_disk_ro(cd->disk, 0);
 	}
diff -puN include/linux/cdrom.h~packet-2.6.7 include/linux/cdrom.h
--- linux/include/linux/cdrom.h~packet-2.6.7	2004-07-01 13:23:15.000000000 +0200
+++ linux-petero/include/linux/cdrom.h	2004-07-01 15:05:03.299119080 +0200
@@ -498,6 +498,7 @@ struct cdrom_generic_command
 #define GPMODE_VENDOR_PAGE		0x00
 #define GPMODE_R_W_ERROR_PAGE		0x01
 #define GPMODE_WRITE_PARMS_PAGE		0x05
+#define GPMODE_WCACHING_PAGE		0x08
 #define GPMODE_AUDIO_CTL_PAGE		0x0e
 #define GPMODE_POWER_PAGE		0x1a
 #define GPMODE_FAULT_FAIL_PAGE		0x1c
diff -puN include/linux/major.h~packet-2.6.7 include/linux/major.h
--- linux/include/linux/major.h~packet-2.6.7	2004-07-01 13:23:15.000000000 +0200
+++ linux-petero/include/linux/major.h	2004-07-01 13:23:15.000000000 +0200
@@ -111,6 +111,8 @@
 
 #define MDISK_MAJOR		95
 
+#define PACKET_MAJOR		97
+
 #define UBD_MAJOR		98
 
 #define JSFD_MAJOR		99
diff -puN /dev/null include/linux/pktcdvd.h
--- /dev/null	2004-02-23 22:02:56.000000000 +0100
+++ linux-petero/include/linux/pktcdvd.h	2004-07-01 15:05:02.776198576 +0200
@@ -0,0 +1,261 @@
+/*
+ * Copyright (C) 2000 Jens Axboe <axboe@suse.de>
+ * Copyright (C) 2001-2004 Peter Osterlund <petero2@telia.com>
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License.  See linux/COPYING for more information.
+ *
+ * Packet writing layer for ATAPI and SCSI CD-R, CD-RW, DVD-R, and
+ * DVD-RW devices.
+ *
+ */
+#ifndef __PKTCDVD_H
+#define __PKTCDVD_H
+
+/*
+ * 1 for normal debug messages, 2 is very verbose. 0 to turn it off.
+ */
+#define PACKET_DEBUG		1
+
+#define	MAX_WRITERS		8
+
+/*
+ * How long we should hold a non-full packet before starting data gathering.
+ */
+#define PACKET_WAIT_TIME	(HZ * 5 / 1000)
+
+/*
+ * use drive write caching -- we need deferred error handling to be
+ * able to sucessfully recover with this option (drive will return good
+ * status as soon as the cdb is validated).
+ */
+#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
+#warning Enabling write caching, use at your own risk
+#define USE_WCACHING		1
+#else
+#define USE_WCACHING		0
+#endif
+
+/*
+ * No user-servicable parts beyond this point ->
+ */
+
+#if PACKET_DEBUG
+#define DPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+#if PACKET_DEBUG > 1
+#define VPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
+#else
+#define VPRINTK(fmt, args...)
+#endif
+
+/*
+ * device types
+ */
+#define PACKET_CDR		1
+#define	PACKET_CDRW		2
+#define PACKET_DVDR		3
+#define PACKET_DVDRW		4
+
+/*
+ * flags
+ */
+#define PACKET_WRITABLE		1	/* pd is writable */
+#define PACKET_NWA_VALID	2	/* next writable address valid */
+#define PACKET_LRA_VALID	3	/* last recorded address valid */
+#define PACKET_MERGE_SEGS	4	/* perform segment merging to keep */
+					/* underlying cdrom device happy */
+
+/*
+ * Disc status -- from READ_DISC_INFO
+ */
+#define PACKET_DISC_EMPTY	0
+#define PACKET_DISC_INCOMPLETE	1
+#define PACKET_DISC_COMPLETE	2
+#define PACKET_DISC_OTHER	3
+
+/*
+ * write type, and corresponding data block type
+ */
+#define PACKET_MODE1		1
+#define PACKET_MODE2		2
+#define PACKET_BLOCK_MODE1	8
+#define PACKET_BLOCK_MODE2	10
+
+/*
+ * Last session/border status
+ */
+#define PACKET_SESSION_EMPTY		0
+#define PACKET_SESSION_INCOMPLETE	1
+#define PACKET_SESSION_RESERVED		2
+#define PACKET_SESSION_COMPLETE		3
+
+#define PACKET_MCN			"4a656e734178626f65323030300000"
+
+#undef PACKET_USE_LS
+
+/*
+ * Very crude stats for now
+ */
+struct packet_stats
+{
+	unsigned long		pkt_started;
+	unsigned long		pkt_ended;
+	unsigned long		secs_w;
+	unsigned long		secs_rg;
+	unsigned long		secs_r;
+};
+
+/*
+ * packet ioctls
+ */
+#define PACKET_IOCTL_MAGIC	('X')
+#define PACKET_GET_STATS	_IOR(PACKET_IOCTL_MAGIC, 0, struct packet_stats)
+#define PACKET_SETUP_DEV	_IOW(PACKET_IOCTL_MAGIC, 1, unsigned int)
+#define PACKET_TEARDOWN_DEV	_IOW(PACKET_IOCTL_MAGIC, 2, unsigned int)
+
+#ifdef __KERNEL__
+#include <linux/blkdev.h>
+#include <linux/completion.h>
+#include <linux/cdrom.h>
+
+struct packet_settings
+{
+	__u8			size;		/* packet size in (512 byte) sectors */
+	__u8			fp;		/* fixed packets */
+	__u8			link_loss;	/* the rest is specified
+						 * as per Mt Fuji */
+	__u8			write_type;
+	__u8			track_mode;
+	__u8			block_mode;
+};
+
+struct packet_cdrw
+{
+	struct list_head	pkt_free_list;
+	struct list_head	pkt_active_list;
+	spinlock_t		active_list_lock; /* Serialize access to pkt_active_list */
+	pid_t			pid;
+	int			time_to_die;
+	struct completion	thr_compl;
+	elevator_merge_fn	*elv_merge_fn;
+	elevator_completed_req_fn *elv_completed_req_fn;
+	merge_requests_fn	*merge_requests_fn;
+};
+
+/*
+ * Switch to high speed reading after reading this many kilobytes
+ * with no interspersed writes.
+ */
+#define HI_SPEED_SWITCH 512
+
+struct packet_iosched
+{
+	atomic_t		attention;	/* Set to non-zero when queue processing is needed */
+	int			writing;	/* Non-zero when writing, zero when reading */
+	spinlock_t		lock;		/* Protecting read/write queue manipulations */
+	struct bio		*read_queue;
+	struct bio		*read_queue_tail;
+	struct bio		*write_queue;
+	struct bio		*write_queue_tail;
+	int			high_prio_read;	/* An important read request has been queued */
+	int			successive_reads;
+};
+
+/*
+ * 32 buffers of 2048 bytes
+ */
+#define PACKET_MAX_SIZE		32
+#define PAGES_PER_PACKET	(PACKET_MAX_SIZE * CD_FRAMESIZE / PAGE_SIZE)
+#define PACKET_MAX_SECTORS	(PACKET_MAX_SIZE * CD_FRAMESIZE >> 9)
+
+enum packet_data_state {
+	PACKET_IDLE_STATE,			/* Not used at the moment */
+	PACKET_WAITING_STATE,			/* Waiting for more bios to arrive, so */
+						/* we don't have to do as much */
+						/* data gathering */
+	PACKET_READ_WAIT_STATE,			/* Waiting for reads to fill in holes */
+	PACKET_WRITE_WAIT_STATE,		/* Waiting for the write to complete */
+	PACKET_RECOVERY_STATE,			/* Recover after read/write errors */
+	PACKET_FINISHED_STATE,			/* After write has finished */
+
+	PACKET_NUM_STATES			/* Number of possible states */
+};
+
+/*
+ * Information needed for writing a single packet
+ */
+struct pktcdvd_device;
+
+struct packet_data
+{
+	struct list_head	list;
+
+	spinlock_t		lock;		/* Lock protecting state transitions and */
+						/* orig_bios list */
+
+	struct bio		*orig_bios;	/* Original bios passed to pkt_make_request */
+	struct bio		*orig_bios_tail;/* that will be handled by this packet */
+	int			write_size;	/* Total size of all bios in the orig_bios */
+						/* list, measured in number of frames */
+
+	struct bio		*w_bio;		/* The bio we will send to the real CD */
+						/* device once we have all data for the */
+						/* packet we are going to write */
+	sector_t		sector;		/* First sector in this packet */
+	int			frames;		/* Number of frames in this packet */
+
+	enum packet_data_state	state;		/* Current state */
+	atomic_t		run_sm;		/* Incremented whenever the state */
+						/* machine needs to be run */
+	long			sleep_time;	/* Set this to non-zero to make the state */
+						/* machine run after this many jiffies. */
+
+	atomic_t		io_wait;	/* Number of pending IO operations */
+	atomic_t		io_errors;	/* Number of read/write errors during IO */
+
+	struct bio		*r_bios[PACKET_MAX_SIZE]; /* bios to use during data gathering */
+	struct page		*pages[PAGES_PER_PACKET];
+
+	int			cache_valid;	/* If non-zero, the data for the zone defined */
+						/* by the sector variable is completely cached */
+						/* in the pages[] vector. */
+
+	int			id;		/* ID number for debugging */
+	struct pktcdvd_device	*pd;
+};
+
+struct pktcdvd_device
+{
+	struct block_device	*bdev;		/* dev attached */
+	dev_t			dev;		/* dev attached */
+	dev_t			pkt_dev;	/* our dev */
+	char			name[20];
+	struct packet_settings	settings;
+	struct packet_stats	stats;
+	atomic_t		refcnt;
+	__u8			write_speed;	/* current write speed */
+	__u8			read_speed;	/* current read speed */
+	unsigned long		offset;		/* start offset */
+	__u8			mode_offset;	/* 0 / 8 */
+	__u8			type;
+	unsigned long		flags;
+	__u32			nwa;		/* next writable address */
+	__u32			lra;		/* last recorded address */
+	struct packet_cdrw	cdrw;
+	wait_queue_head_t	wqueue;
+
+	spinlock_t		lock;		/* Serialize access to bio_queue */
+	struct bio		*bio_queue;	/* Work queue of bios we need to handle */
+	struct bio		*bio_queue_tail;
+	atomic_t		scan_queue;	/* Set to non-zero when pkt_handle_queue */
+						/* needs to be run. */
+	struct packet_iosched   iosched;
+};
+
+#endif /* __KERNEL__ */
+
+#endif /* __PKTCDVD_H */
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
