Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbUJaVeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbUJaVeO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbUJaVeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:34:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57618 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261379AbUJaVdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:33:22 -0500
Date: Sun, 31 Oct 2004 22:32:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: bcollins@debian.org
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RFC: [2.6 patch] ieee1394 cleanup
Message-ID: <20041031213250.GD2495@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some variables and functions under 
drivers/ieee1394/ that were needlessly global static.

Besides this, it removes several functions that weren't used anywhere in 
the kernel.

It also includes the removal of 25 EXPORT_SYMBOL's (mostly due to a 
removal of the corresponding functions).


Please review and comment on this patch.


diffstat output:
 drivers/ieee1394/amdtp.c                 |   16 -
 drivers/ieee1394/csr1212.c               |  194 -----------------------
 drivers/ieee1394/csr1212.h               |   38 ----
 drivers/ieee1394/dv1394.c                |    2 
 drivers/ieee1394/highlevel.c             |   32 ---
 drivers/ieee1394/ieee1394_core.c         |   30 ---
 drivers/ieee1394/ieee1394_core.h         |    1 
 drivers/ieee1394/ieee1394_transactions.c |   28 ---
 drivers/ieee1394/nodemgr.c               |   47 -----
 drivers/ieee1394/sbp2.c                  |    4 
 drivers/ieee1394/video1394.c             |   10 -
 11 files changed, 28 insertions(+), 374 deletions(-)



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
 
--- linux-2.6.10-rc1-mm2-full/drivers/ieee1394/csr1212.h.old	2004-10-31 20:05:26.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/ieee1394/csr1212.h	2004-10-31 20:07:34.000000000 +0100
@@ -556,40 +556,8 @@
  * must release those keyvals with csr1212_release_keyval() when they are no
  * longer needed. */
 extern struct csr1212_keyval *csr1212_new_immediate(u_int8_t key, u_int32_t value);
-extern struct csr1212_keyval *csr1212_new_leaf(u_int8_t key, const void *data,
-					       size_t data_len);
-extern struct csr1212_keyval *csr1212_new_csr_offset(u_int8_t key,
-						     u_int32_t csr_offset);
 extern struct csr1212_keyval *csr1212_new_directory(u_int8_t key);
-extern struct csr1212_keyval *csr1212_new_extended_immediate(u_int32_t spec,
-							     u_int32_t key,
-							     u_int32_t value);
-extern struct csr1212_keyval *csr1212_new_extended_leaf(u_int32_t spec,
-							u_int32_t key,
-							const void *data,
-							size_t data_len);
-extern struct csr1212_keyval *csr1212_new_descriptor_leaf(u_int8_t dtype,
-							  u_int32_t specifier_id,
-							  const void *data,
-							  size_t data_len);
-extern struct csr1212_keyval *csr1212_new_textual_descriptor_leaf(u_int8_t cwidth,
-								  u_int16_t cset,
-								  u_int16_t language,
-								  const void *data,
-								  size_t data_len);
 extern struct csr1212_keyval *csr1212_new_string_descriptor_leaf(const char *s);
-extern struct csr1212_keyval *csr1212_new_icon_descriptor_leaf(u_int32_t version,
-							       u_int8_t palette_depth,
-							       u_int8_t color_space,
-							       u_int16_t language,
-							       u_int16_t hscan,
-							       u_int16_t vscan,
-							       u_int32_t *palette,
-							       u_int32_t *pixels);
-extern struct csr1212_keyval *csr1212_new_modifiable_descriptor_leaf(u_int16_t max_size,
-								     u_int64_t address);
-extern struct csr1212_keyval *csr1212_new_keyword_leaf(int strc,
-						       const char *strv[]);
 
 
 /* The following functions manage association between keyvals.  Typically,
@@ -598,7 +566,6 @@
  * keyval that it is associated with.*/
 extern int csr1212_associate_keyval(struct csr1212_keyval *kv,
 				    struct csr1212_keyval *associate);
-extern void csr1212_disassociate_keyval(struct csr1212_keyval *kv);
 
 
 /* The following functions manage the association of a keyval and directories.
@@ -614,11 +581,6 @@
  * the list of caches available via csr->cache_head.  The other functions are
  * provided should there be a need to create a flat image without restrictions
  * placed by IEEE 1212. */
-extern struct csr1212_keyval *csr1212_generate_positions(struct csr1212_csr_rom_cache *cache,
-							 struct csr1212_keyval *start_kv,
-							 int start_pos);
-extern size_t csr1212_generate_layout_order(struct csr1212_keyval *kv);
-extern void csr1212_fill_cache(struct csr1212_csr_rom_cache *cache);
 extern int csr1212_generate_csr_image(struct csr1212_csr *csr);
 
 
--- linux-2.6.10-rc1-mm2-full/drivers/ieee1394/csr1212.c.old	2004-10-31 19:27:44.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/ieee1394/csr1212.c	2004-10-31 22:00:39.000000000 +0100
@@ -249,7 +249,7 @@
 	return kv;
 }
 
-struct csr1212_keyval *csr1212_new_leaf(u_int8_t key, const void *data, size_t data_len)
+static struct csr1212_keyval *csr1212_new_leaf(u_int8_t key, const void *data, size_t data_len)
 {
 	struct csr1212_keyval *kv = csr1212_new_keyval(CSR1212_KV_TYPE_LEAF, key);
 
@@ -276,7 +276,7 @@
 	return kv;
 }
 
-struct csr1212_keyval *csr1212_new_csr_offset(u_int8_t key, u_int32_t csr_offset)
+static struct csr1212_keyval *csr1212_new_csr_offset(u_int8_t key, u_int32_t csr_offset)
 {
 	struct csr1212_keyval *kv = csr1212_new_keyval(CSR1212_KV_TYPE_CSR_OFFSET, key);
 
@@ -373,65 +373,7 @@
 	return CSR1212_SUCCESS;
 }
 
-struct csr1212_keyval *csr1212_new_extended_immediate(u_int32_t spec, u_int32_t key,
-						      u_int32_t value)
-{
-	struct csr1212_keyval *kvs, *kvk, *kvv;
-
-	kvs = csr1212_new_immediate(CSR1212_KV_ID_EXTENDED_KEY_SPECIFIER_ID, spec);
-	kvk = csr1212_new_immediate(CSR1212_KV_ID_EXTENDED_KEY, key);
-	kvv = csr1212_new_immediate(CSR1212_KV_ID_EXTENDED_DATA, value);
-
-	if (!kvs || !kvk || !kvv) {
-		if (kvs)
-			free_keyval(kvs);
-		if (kvk)
-			free_keyval(kvk);
-		if (kvv)
-			free_keyval(kvv);
-		return NULL;
-	}
-
-	/* Don't keep a local reference to the extended key or value. */
-	kvk->refcnt = 0;
-	kvv->refcnt = 0;
-
-	csr1212_associate_keyval(kvk, kvv);
-	csr1212_associate_keyval(kvs, kvk);
-
-	return kvs;
-}
-
-struct csr1212_keyval *csr1212_new_extended_leaf(u_int32_t spec, u_int32_t key,
-						 const void *data, size_t data_len)
-{
-	struct csr1212_keyval *kvs, *kvk, *kvv;
-
-	kvs = csr1212_new_immediate(CSR1212_KV_ID_EXTENDED_KEY_SPECIFIER_ID, spec);
-	kvk = csr1212_new_immediate(CSR1212_KV_ID_EXTENDED_KEY, key);
-	kvv = csr1212_new_leaf(CSR1212_KV_ID_EXTENDED_DATA, data, data_len);
-
-	if (!kvs || !kvk || !kvv) {
-		if (kvs)
-			free_keyval(kvs);
-		if (kvk)
-			free_keyval(kvk);
-		if (kvv)
-			free_keyval(kvv);
-		return NULL;
-	}
-
-	/* Don't keep a local reference to the extended key or value. */
-	kvk->refcnt = 0;
-	kvv->refcnt = 0;
-
-	csr1212_associate_keyval(kvk, kvv);
-	csr1212_associate_keyval(kvs, kvk);
-
-	return kvs;
-}
-
-struct csr1212_keyval *csr1212_new_descriptor_leaf(u_int8_t dtype, u_int32_t specifier_id,
+static struct csr1212_keyval *csr1212_new_descriptor_leaf(u_int8_t dtype, u_int32_t specifier_id,
 						   const void *data, size_t data_len)
 {
 	struct csr1212_keyval *kv;
@@ -452,7 +394,7 @@
 }
 
 
-struct csr1212_keyval *csr1212_new_textual_descriptor_leaf(u_int8_t cwidth,
+static struct csr1212_keyval *csr1212_new_textual_descriptor_leaf(u_int8_t cwidth,
 							   u_int16_t cset,
 							   u_int16_t language,
 							   const void *data,
@@ -520,118 +462,6 @@
 	return csr1212_new_textual_descriptor_leaf(0, 0, 0, s, strlen(s));
 }
 
-struct csr1212_keyval *csr1212_new_icon_descriptor_leaf(u_int32_t version,
-							u_int8_t palette_depth,
-							u_int8_t color_space,
-							u_int16_t language,
-							u_int16_t hscan,
-							u_int16_t vscan,
-							u_int32_t *palette,
-							u_int32_t *pixels)
-{
-	static const int pd[4] = { 0, 4, 16, 256 };
-	static const int cs[16] = { 4, 2 };
-	struct csr1212_keyval *kv;
-	int palette_size = pd[palette_depth] * cs[color_space];
-	int pixel_size = (hscan * vscan + 3) & ~0x3;
-
-	if ((palette_depth && !palette) || !pixels)
-		return NULL;
-
-	kv = csr1212_new_descriptor_leaf(1, 0, NULL,
-					 palette_size + pixel_size +
-					 CSR1212_ICON_DESCRIPTOR_LEAF_OVERHEAD);
-	if (!kv)
-		return NULL;
-
-	CSR1212_ICON_DESCRIPTOR_LEAF_SET_VERSION(kv, version);
-	CSR1212_ICON_DESCRIPTOR_LEAF_SET_PALETTE_DEPTH(kv, palette_depth);
-	CSR1212_ICON_DESCRIPTOR_LEAF_SET_COLOR_SPACE(kv, color_space);
-	CSR1212_ICON_DESCRIPTOR_LEAF_SET_LANGUAGE(kv, language);
-	CSR1212_ICON_DESCRIPTOR_LEAF_SET_HSCAN(kv, hscan);
-	CSR1212_ICON_DESCRIPTOR_LEAF_SET_VSCAN(kv, vscan);
-
-	if (palette_size)
-		memcpy(CSR1212_ICON_DESCRIPTOR_LEAF_PALETTE(kv), palette,
-		       palette_size);
-
-	memcpy(CSR1212_ICON_DESCRIPTOR_LEAF_PIXELS(kv), pixels, pixel_size);
-
-	return kv;
-}
-
-struct csr1212_keyval *csr1212_new_modifiable_descriptor_leaf(u_int16_t max_size,
-							      u_int64_t address)
-{
-	struct csr1212_keyval *kv;
-
-	/* IEEE 1212, par. 7.5.4.3  Modifiable descriptors */
-	kv = csr1212_new_leaf(CSR1212_KV_ID_MODIFIABLE_DESCRIPTOR, NULL, sizeof(u_int64_t));
-	if(!kv)
-		return NULL;
-
-	CSR1212_MODIFIABLE_DESCRIPTOR_SET_MAX_SIZE(kv, max_size);
-	CSR1212_MODIFIABLE_DESCRIPTOR_SET_ADDRESS_HI(kv, address);
-	CSR1212_MODIFIABLE_DESCRIPTOR_SET_ADDRESS_LO(kv, address);
-
-	return kv;
-}
-
-static int csr1212_check_keyword(const char *s)
-{
-	for (; *s; s++) {
-
-		if (('A' <= *s) && (*s <= 'Z'))
-			continue;
-		if (('0' <= *s) && (*s <= '9'))
-			continue;
-		if (*s == '-')
-			continue;
-
-		return -1; /* failed */
-	}
-	/* String conforms to keyword, as specified by IEEE 1212,
-	 * par. 7.6.5 */
-	return CSR1212_SUCCESS;
-}
-
-struct csr1212_keyval *csr1212_new_keyword_leaf(int strc, const char *strv[])
-{
-	struct csr1212_keyval *kv;
-	char *buffer;
-	int i, data_len = 0;
-
-	/* Check all keywords to see if they conform to restrictions:
-	 * Only the following characters is allowed ['A'..'Z','0'..'9','-']
-	 * Each word is zero-terminated.
-	 * Also calculate the total length of the keywords.
-	 */
-	for (i = 0; i < strc; i++) {
-		if (!strv[i] || csr1212_check_keyword(strv[i])) {
-			return NULL;
-		}
-		data_len += strlen(strv[i]) + 1; /* Add zero-termination char. */
-	}
-
-	/* IEEE 1212, par. 7.6.5 Keyword leaves */
-	kv = csr1212_new_leaf(CSR1212_KV_ID_KEYWORD, NULL, data_len);
-	if (!kv)
-		return NULL;
-
-	buffer = (char *)kv->value.leaf.data;
-
-	/* make sure last quadlet is zeroed out */
-	*((u_int32_t*)&(buffer[(data_len - 1) & ~0x3])) = 0;
-
-	/* Copy keyword(s) into leaf data buffer */
-	for (i = 0; i < strc; i++) {
-		int len = strlen(strv[i]) + 1;
-		memcpy(buffer, strv[i], len);
-		buffer += len;
-	}
-	return kv;
-}
-
 
 /* Destruction Routines */
 
@@ -663,16 +493,6 @@
 }
 
 
-void csr1212_disassociate_keyval(struct csr1212_keyval *kv)
-{
-	if (kv->associate) {
-		csr1212_release_keyval(kv->associate);
-	}
-
-	kv->associate = NULL;
-}
-
-
 /* This function is used to free the memory taken by a keyval.  If the given
  * keyval is a directory type, then any keyvals contained in that directory
  * will be destroyed as well if their respective refcnts are 0.  By means of
@@ -895,7 +715,7 @@
 	return num_entries;
 }
 
-size_t csr1212_generate_layout_order(struct csr1212_keyval *kv)
+static size_t csr1212_generate_layout_order(struct csr1212_keyval *kv)
 {
 	struct csr1212_keyval *ltail = kv;
 	size_t agg_size = 0;
@@ -918,7 +738,7 @@
 	return quads_to_bytes(agg_size);
 }
 
-struct csr1212_keyval *csr1212_generate_positions(struct csr1212_csr_rom_cache *cache,
+static struct csr1212_keyval *csr1212_generate_positions(struct csr1212_csr_rom_cache *cache,
                                                   struct csr1212_keyval *start_kv,
                                                   int start_pos)
 {
@@ -1026,7 +846,7 @@
 	}
 }
 
-void csr1212_fill_cache(struct csr1212_csr_rom_cache *cache)
+static void csr1212_fill_cache(struct csr1212_csr_rom_cache *cache)
 {
 	struct csr1212_keyval *kv, *nkv;
 	struct csr1212_keyval_img *kvi;
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


