Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268347AbUKAPbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268347AbUKAPbX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUKAOCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:02:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42250 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262641AbUKAN7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:59:15 -0500
Date: Mon, 1 Nov 2004 14:58:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ben Collins <bcollins@debian.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] ieee1394 cleanup
Message-ID: <20041101135840.GN2495@stusta.de>
References: <20041031213250.GD2495@stusta.de> <20041031212858.GC9684@phunnypharm.org> <20041031232954.GG2495@stusta.de> <20041031220420.GA15424@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031220420.GA15424@phunnypharm.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 05:04:20PM -0500, Ben Collins wrote:
> On Mon, Nov 01, 2004 at 12:29:54AM +0100, Adrian Bunk wrote:
> > On Sun, Oct 31, 2004 at 04:28:58PM -0500, Ben Collins wrote:
> > 
> > > Need to leave the csr1212 files alone. csr1212.[ch] is used for userspace
> > > and kernelspace, and I don't want to have two versions.
> > 
> > But in this case, these functions don't have to be EXPORT_SYMBOL'ed?
> 
> That's true, but the files themselves need to be left intact.
> 
> > And besides this, they are global functions meaning that although they 
> > are never used inside the kernel, they need space for every user of 
> > FireWire.
> > 
> > What about wrapping them inside #ifndef __KERNEL__ ?
> 
> They may be used, and I don't want to worry about someone using the
> function later on in the kernel, and have to trace down that it isn't
> defined in the kernel build. The exports can be killed (since it isn't
> likely to be used outside the scope of the ieee1394.ko module anyway).


I'm still not happy about this unneeded code bloat, but below is a patch 
without the csr1212.{c,h} parts (but with a removal of the exports).


diffstat output:
 drivers/ieee1394/amdtp.c                 |   16 +++----
 drivers/ieee1394/dv1394.c                |    2 
 drivers/ieee1394/highlevel.c             |   32 ---------------
 drivers/ieee1394/ieee1394_core.c         |   30 +-------------
 drivers/ieee1394/ieee1394_core.h         |    1 
 drivers/ieee1394/ieee1394_transactions.c |   28 -------------
 drivers/ieee1394/nodemgr.c               |   47 -----------------------
 drivers/ieee1394/sbp2.c                  |    4 -
 drivers/ieee1394/video1394.c             |   10 ++--
 9 files changed, 21 insertions(+), 149 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/drivers/ieee1394/ieee1394_core.h.old	2004-10-31 20:01:23.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/ieee1394/ieee1394_core.h	2004-10-31 20:03:14.000000000 +0100
@@ -89,7 +89,6 @@
 }
 
 void abort_timedouts(unsigned long __opaque);
-void abort_requests(struct hpsb_host *host);
 
 struct hpsb_packet *hpsb_alloc_packet(size_t data_size);
 void hpsb_free_packet(struct hpsb_packet *packet);
--- linux-2.6.10-rc1-mm2-full/drivers/ieee1394/ieee1394_core.c.old	2004-10-31 19:15:14.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/ieee1394/ieee1394_core.c	2004-10-31 22:15:32.000000000 +0100
@@ -79,6 +79,7 @@
 #define dump_packet(x,y,z)
 #endif
 
+static void abort_requests(struct hpsb_host *host);
 static void queue_packet_complete(struct hpsb_packet *packet);
 
 
@@ -939,7 +940,7 @@
 }
 
 
-void abort_requests(struct hpsb_host *host)
+static void abort_requests(struct hpsb_host *host)
 {
 	struct hpsb_packet *packet;
 	struct sk_buff *skb;
@@ -1002,7 +1003,7 @@
  * the stack. */
 static int khpsbpkt_pid = -1, khpsbpkt_kill;
 static DECLARE_COMPLETION(khpsbpkt_complete);
-struct sk_buff_head hpsbpkt_queue;
+static struct sk_buff_head hpsbpkt_queue;
 static DECLARE_MUTEX_LOCKED(khpsbpkt_sig);
 
 
@@ -1217,8 +1218,6 @@
 EXPORT_SYMBOL(hpsb_read);
 EXPORT_SYMBOL(hpsb_write);
 EXPORT_SYMBOL(hpsb_lock);
-EXPORT_SYMBOL(hpsb_lock64);
-EXPORT_SYMBOL(hpsb_send_gasp);
 EXPORT_SYMBOL(hpsb_packet_success);
 
 /** highlevel.c **/
@@ -1230,28 +1229,18 @@
 EXPORT_SYMBOL(hpsb_listen_channel);
 EXPORT_SYMBOL(hpsb_unlisten_channel);
 EXPORT_SYMBOL(hpsb_get_hostinfo);
-EXPORT_SYMBOL(hpsb_get_host_bykey);
 EXPORT_SYMBOL(hpsb_create_hostinfo);
 EXPORT_SYMBOL(hpsb_destroy_hostinfo);
 EXPORT_SYMBOL(hpsb_set_hostinfo_key);
-EXPORT_SYMBOL(hpsb_get_hostinfo_key);
 EXPORT_SYMBOL(hpsb_get_hostinfo_bykey);
 EXPORT_SYMBOL(hpsb_set_hostinfo);
-EXPORT_SYMBOL(highlevel_read);
-EXPORT_SYMBOL(highlevel_write);
-EXPORT_SYMBOL(highlevel_lock);
-EXPORT_SYMBOL(highlevel_lock64);
 EXPORT_SYMBOL(highlevel_add_host);
 EXPORT_SYMBOL(highlevel_remove_host);
 EXPORT_SYMBOL(highlevel_host_reset);
 
 /** nodemgr.c **/
-EXPORT_SYMBOL(hpsb_guid_get_entry);
-EXPORT_SYMBOL(hpsb_nodeid_get_entry);
 EXPORT_SYMBOL(hpsb_node_fill_packet);
-EXPORT_SYMBOL(hpsb_node_read);
 EXPORT_SYMBOL(hpsb_node_write);
-EXPORT_SYMBOL(hpsb_node_lock);
 EXPORT_SYMBOL(hpsb_register_protocol);
 EXPORT_SYMBOL(hpsb_unregister_protocol);
 EXPORT_SYMBOL(ieee1394_bus_type);
@@ -1295,27 +1284,14 @@
 EXPORT_SYMBOL(csr1212_create_csr);
 EXPORT_SYMBOL(csr1212_init_local_csr);
 EXPORT_SYMBOL(csr1212_new_immediate);
-EXPORT_SYMBOL(csr1212_new_leaf);
-EXPORT_SYMBOL(csr1212_new_csr_offset);
 EXPORT_SYMBOL(csr1212_new_directory);
 EXPORT_SYMBOL(csr1212_associate_keyval);
 EXPORT_SYMBOL(csr1212_attach_keyval_to_directory);
-EXPORT_SYMBOL(csr1212_new_extended_immediate);
-EXPORT_SYMBOL(csr1212_new_extended_leaf);
-EXPORT_SYMBOL(csr1212_new_descriptor_leaf);
-EXPORT_SYMBOL(csr1212_new_textual_descriptor_leaf);
 EXPORT_SYMBOL(csr1212_new_string_descriptor_leaf);
-EXPORT_SYMBOL(csr1212_new_icon_descriptor_leaf);
-EXPORT_SYMBOL(csr1212_new_modifiable_descriptor_leaf);
-EXPORT_SYMBOL(csr1212_new_keyword_leaf);
 EXPORT_SYMBOL(csr1212_detach_keyval_from_directory);
-EXPORT_SYMBOL(csr1212_disassociate_keyval);
 EXPORT_SYMBOL(csr1212_release_keyval);
 EXPORT_SYMBOL(csr1212_destroy_csr);
 EXPORT_SYMBOL(csr1212_read);
-EXPORT_SYMBOL(csr1212_generate_positions);
-EXPORT_SYMBOL(csr1212_generate_layout_order);
-EXPORT_SYMBOL(csr1212_fill_cache);
 EXPORT_SYMBOL(csr1212_generate_csr_image);
 EXPORT_SYMBOL(csr1212_parse_keyval);
 EXPORT_SYMBOL(csr1212_parse_csr);
--- linux-2.6.10-rc1-mm2-full/drivers/ieee1394/ieee1394_transactions.c.old	2004-10-31 19:13:10.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/ieee1394/ieee1394_transactions.c	2004-10-31 22:14:33.000000000 +0100
@@ -566,34 +566,6 @@
         return retval;
 }
 
-int hpsb_lock64(struct hpsb_host *host, nodeid_t node, unsigned int generation,
-		u64 addr, int extcode, octlet_t *data, octlet_t arg)
-{
-	struct hpsb_packet *packet;
-	int retval = 0;
-
-	BUG_ON(in_interrupt()); // We can't be called in an interrupt, yet
-
-	packet = hpsb_make_lock64packet(host, node, addr, extcode, data, arg);
-	if (!packet)
-		return -ENOMEM;
-
-	packet->generation = generation;
-	retval = hpsb_send_packet_and_wait(packet);
-	if (retval < 0)
-		goto hpsb_lock64_fail;
-
-	retval = hpsb_packet_success(packet);
-
-	if (retval == 0)
-		*data = (u64)packet->data[1] << 32 | packet->data[0];
-
-hpsb_lock64_fail:
-	hpsb_free_tlabel(packet);
-	hpsb_free_packet(packet);
-
-        return retval;
-}
 
 int hpsb_send_gasp(struct hpsb_host *host, int channel, unsigned int generation,
 		   quadlet_t *buffer, size_t length, u32 specifier_id,
--- linux-2.6.10-rc1-mm2-full/drivers/ieee1394/nodemgr.c.old	2004-10-31 18:59:27.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/ieee1394/nodemgr.c	2004-10-31 22:00:39.000000000 +0100
@@ -147,7 +147,7 @@
 	put_device(&container_of((class_dev), struct node_entry, class_dev)->device);
 }
 
-struct class nodemgr_ne_class = {
+static struct class nodemgr_ne_class = {
 	.name		= "ieee1394_node",
 	.release	= ne_cls_release,
 };
@@ -159,7 +159,7 @@
 
 /* The name here is only so that unit directory hotplug works with old
  * style hotplug, which only ever did unit directories anyway. */
-struct class nodemgr_ud_class = {
+static struct class nodemgr_ud_class = {
 	.name		= "ieee1394",
 	.release	= ud_cls_release,
 	.hotplug	= nodemgr_hotplug,
@@ -1556,29 +1556,6 @@
 	complete_and_exit(&hi->exited, 0);
 }
 
-struct node_entry *hpsb_guid_get_entry(u64 guid)
-{
-        struct node_entry *ne;
-
-	down(&nodemgr_serialize);
-        ne = find_entry_by_guid(guid);
-	up(&nodemgr_serialize);
-
-        return ne;
-}
-
-struct node_entry *hpsb_nodeid_get_entry(struct hpsb_host *host, nodeid_t nodeid)
-{
-	struct node_entry *ne;
-
-	down(&nodemgr_serialize);
-	ne = find_entry_by_nodeid(host, nodeid);
-	up(&nodemgr_serialize);
-
-	return ne;
-}
-
-
 int nodemgr_for_each_host(void *__data, int (*cb)(struct hpsb_host *, void *))
 {
 	struct class *class = &hpsb_host_class;
@@ -1621,16 +1598,6 @@
         pkt->node_id = ne->nodeid;
 }
 
-int hpsb_node_read(struct node_entry *ne, u64 addr,
-		   quadlet_t *buffer, size_t length)
-{
-	unsigned int generation = ne->generation;
-
-	barrier();
-	return hpsb_read(ne->host, ne->nodeid, generation,
-			 addr, buffer, length);
-}
-
 int hpsb_node_write(struct node_entry *ne, u64 addr,
 		    quadlet_t *buffer, size_t length)
 {
@@ -1641,16 +1608,6 @@
 			  addr, buffer, length);
 }
 
-int hpsb_node_lock(struct node_entry *ne, u64 addr,
-		   int extcode, quadlet_t *data, quadlet_t arg)
-{
-	unsigned int generation = ne->generation;
-
-	barrier();
-	return hpsb_lock(ne->host, ne->nodeid, generation,
-			 addr, extcode, data, arg);
-}
-
 static void nodemgr_add_host(struct hpsb_host *host)
 {
 	struct host_info *hi;
--- linux-2.6.10-rc1-mm2-full/drivers/ieee1394/sbp2.c.old	2004-10-31 19:17:23.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/ieee1394/sbp2.c	2004-10-31 22:00:39.000000000 +0100
@@ -229,7 +229,7 @@
 
 static Scsi_Host_Template scsi_driver_template;
 
-const u8 sbp2_speedto_max_payload[] = { 0x7, 0x8, 0x9, 0xA, 0xB, 0xC };
+static const u8 sbp2_speedto_max_payload[] = { 0x7, 0x8, 0x9, 0xA, 0xB, 0xC };
 
 static void sbp2_host_reset(struct hpsb_host *host);
 
@@ -373,7 +373,7 @@
 /* This is much like hpsb_node_write(), except it ignores the response
  * subaction and returns immediately. Can be used from interrupts.
  */
-int sbp2util_node_write_no_wait(struct node_entry *ne, u64 addr,
+static int sbp2util_node_write_no_wait(struct node_entry *ne, u64 addr,
 				quadlet_t *buffer, size_t length)
 {
 	struct hpsb_packet *packet;
--- linux-2.6.10-rc1-mm2-full/drivers/ieee1394/video1394.c.old	2004-10-31 19:18:04.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/ieee1394/video1394.c	2004-10-31 22:00:39.000000000 +0100
@@ -146,8 +146,8 @@
 #define PRINT(level, card, fmt, args...) \
 printk(level "video1394_%d: " fmt "\n" , card , ## args)
 
-void wakeup_dma_ir_ctx(unsigned long l);
-void wakeup_dma_it_ctx(unsigned long l);
+static void wakeup_dma_ir_ctx(unsigned long l);
+static void wakeup_dma_it_ctx(unsigned long l);
 
 static struct hpsb_highlevel video1394_highlevel;
 
@@ -487,7 +487,7 @@
 	return NULL;
 }
 
-void wakeup_dma_ir_ctx(unsigned long l)
+static void wakeup_dma_ir_ctx(unsigned long l)
 {
 	struct dma_iso_ctx *d = (struct dma_iso_ctx *) l;
 	int i;
@@ -560,7 +560,7 @@
 #endif
 }
 
-void wakeup_dma_it_ctx(unsigned long l)
+static void wakeup_dma_it_ctx(unsigned long l)
 {
 	struct dma_iso_ctx *d = (struct dma_iso_ctx *) l;
 	struct ti_ohci *ohci = d->ohci;
@@ -1161,7 +1161,7 @@
  *    But e.g. pte_alloc() does not work in modules ... :-(
  */
 
-int video1394_mmap(struct file *file, struct vm_area_struct *vma)
+static int video1394_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct file_ctx *ctx = (struct file_ctx *)file->private_data;
 	int res = -EINVAL;
--- linux-2.6.10-rc1-mm2-full/drivers/ieee1394/dv1394.c.old	2004-10-31 19:23:36.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/ieee1394/dv1394.c	2004-10-31 22:00:39.000000000 +0100
@@ -1272,7 +1272,7 @@
 	error-prone code in dv1394.
 */
 
-int dv1394_mmap(struct file *file, struct vm_area_struct *vma)
+static int dv1394_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct video_card *video = file_to_video_card(file);
 	int retval = -EINVAL;
--- linux-2.6.10-rc1-mm2-full/drivers/ieee1394/amdtp.c.old	2004-10-31 19:24:11.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/ieee1394/amdtp.c	2004-10-31 22:00:39.000000000 +0100
@@ -286,7 +286,7 @@
 #define OHCI1394_CONTEXT_DEAD        0x00000800
 #define OHCI1394_CONTEXT_ACTIVE      0x00000400
 
-void ohci1394_start_it_ctx(struct ti_ohci *ohci, int ctx,
+static void ohci1394_start_it_ctx(struct ti_ohci *ohci, int ctx,
 			   dma_addr_t first_cmd, int z, int cycle_match)
 {
 	reg_write(ohci, OHCI1394_IsoXmitIntMaskSet, 1 << ctx);
@@ -298,13 +298,13 @@
 		  OHCI1394_CONTEXT_RUN);
 }
 
-void ohci1394_wake_it_ctx(struct ti_ohci *ohci, int ctx)
+static void ohci1394_wake_it_ctx(struct ti_ohci *ohci, int ctx)
 {
 	reg_write(ohci, OHCI1394_IsoXmitContextControlSet + ctx * 16,
 		  OHCI1394_CONTEXT_WAKE);
 }
 
-void ohci1394_stop_it_ctx(struct ti_ohci *ohci, int ctx, int synchronous)
+static void ohci1394_stop_it_ctx(struct ti_ohci *ohci, int ctx, int synchronous)
 {
 	u32 control;
 	int wait;
@@ -530,7 +530,7 @@
 	return frac->integer + (frac->numerator > 0 ? 1 : 0);
 }
 
-void packet_initialize(struct packet *p, struct packet *next)
+static void packet_initialize(struct packet *p, struct packet *next)
 {
 	/* Here we initialize the dma descriptor block for
 	 * transferring one iso packet.  We use two descriptors per
@@ -559,7 +559,7 @@
 	p->db->payload_desc.status = 0;
 }
 
-struct packet_list *packet_list_alloc(struct stream *s)
+static struct packet_list *packet_list_alloc(struct stream *s)
 {
 	int i;
 	struct packet_list *pl;
@@ -588,7 +588,7 @@
 	return pl;
 }
 
-void packet_list_free(struct packet_list *pl, struct stream *s)
+static void packet_list_free(struct packet_list *pl, struct stream *s)
 {
 	int i;
 
@@ -1010,7 +1010,7 @@
 	return 0;
 }
 
-struct stream *stream_alloc(struct amdtp_host *host)
+static struct stream *stream_alloc(struct amdtp_host *host)
 {
 	struct stream *s;
 	unsigned long flags;
@@ -1062,7 +1062,7 @@
 	return s;
 }
 
-void stream_free(struct stream *s)
+static void stream_free(struct stream *s)
 {
 	unsigned long flags;
 
--- linux-2.6.10-rc1-mm2-full/drivers/ieee1394/highlevel.c.old	2004-10-31 19:34:07.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/ieee1394/highlevel.c	2004-10-31 22:00:39.000000000 +0100
@@ -173,18 +173,6 @@
 }
 
 
-unsigned long hpsb_get_hostinfo_key(struct hpsb_highlevel *hl, struct hpsb_host *host)
-{
-	struct hl_host_info *hi;
-
-	hi = hl_get_hostinfo(hl, host);
-	if (hi)
-		return hi->key;
-
-	return 0;
-}
-
-
 void *hpsb_get_hostinfo_bykey(struct hpsb_highlevel *hl, unsigned long key)
 {
 	struct hl_host_info *hi;
@@ -206,26 +194,6 @@
 }
 
 
-struct hpsb_host *hpsb_get_host_bykey(struct hpsb_highlevel *hl, unsigned long key)
-{
-	struct hl_host_info *hi;
-	struct hpsb_host *host = NULL;
-
-	if (!hl)
-		return NULL;
-
-	read_lock(&hl->host_info_lock);
-	list_for_each_entry(hi, &hl->host_info_list, list) {
-		if (hi->key == key) {
-			host = hi->host;
-			break;
-		}
-	}
-	read_unlock(&hl->host_info_lock);
-
-	return host;
-}
-
 static int highlevel_for_each_host_reg(struct hpsb_host *host, void *__data)
 {
 	struct hpsb_highlevel *hl = __data;



