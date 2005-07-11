Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVGKUnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVGKUnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVGKUmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:42:25 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:32717 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262594AbVGKUkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:40:40 -0400
Subject: [PATCH 18/29v2] Introduce RMPP APIs
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110345.4389.5020.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 16:32:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce RMPP APIs 

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 17/29.

--
 core/mad.c       |    4 +
 core/sa_query.c  |   20 --
 include/ib_mad.h |  132 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 include/ib_sa.h  |    4 -
 4 files changed, 125 insertions(+), 35 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-17/drivers/infiniband/core/mad.c linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/mad.c
-- linux-2.6.13-rc2-mm1-17/drivers/infiniband/core/mad.c	2005-07-11 13:39:42.000000000 -0400
+++ linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/mad.c	2005-07-11 13:39:53.000000000 -0400
@@ -777,7 +777,7 @@ static int get_buf_length(int hdr_len, i
 
 struct ib_mad_send_buf * ib_create_send_mad(struct ib_mad_agent *mad_agent,
 					    u32 remote_qpn, u16 pkey_index,
-					    struct ib_ah *ah,
+					    struct ib_ah *ah, int rmpp_active,
 					    int hdr_len, int data_len,
 					    unsigned int __nocast gfp_mask)
 {
@@ -786,6 +786,8 @@ struct ib_mad_send_buf * ib_create_send_
 	int buf_size;
 	void *buf;
 
+	if (rmpp_active)
+		return ERR_PTR(-EINVAL);	/* until RMPP implemented */
 	mad_agent_priv = container_of(mad_agent,
 				      struct ib_mad_agent_private, agent);
 	buf_size = get_buf_length(hdr_len, data_len);
diff -uprN linux-2.6.13-rc2-mm1-17/drivers/infiniband/core/sa_query.c linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/sa_query.c
-- linux-2.6.13-rc2-mm1-17/drivers/infiniband/core/sa_query.c	2005-07-10 16:22:13.000000000 -0400
+++ linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/sa_query.c	2005-07-10 16:22:18.000000000 -0400
@@ -50,26 +50,6 @@ MODULE_AUTHOR("Roland Dreier");
 MODULE_DESCRIPTION("InfiniBand subnet administration query support");
 MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * These two structures must be packed because they have 64-bit fields
- * that are only 32-bit aligned.  64-bit architectures will lay them
- * out wrong otherwise.  (And unfortunately they are sent on the wire
- * so we can't change the layout)
- */
-struct ib_sa_hdr {
-	u64			sm_key;
-	u16			attr_offset;
-	u16			reserved;
-	ib_sa_comp_mask		comp_mask;
-} __attribute__ ((packed));
-
-struct ib_sa_mad {
-	struct ib_mad_hdr	mad_hdr;
-	struct ib_rmpp_hdr	rmpp_hdr;
-	struct ib_sa_hdr	sa_hdr;
-	u8			data[200];
-} __attribute__ ((packed));
-
 struct ib_sa_sm_ah {
 	struct ib_ah        *ah;
 	struct kref          ref;
diff -uprN linux-2.6.13-rc2-mm1-17/drivers/infiniband/include/ib_mad.h linux-2.6.13-rc2-mm1-18/drivers/infiniband/include/ib_mad.h
-- linux-2.6.13-rc2-mm1-17/drivers/infiniband/include/ib_mad.h	2005-07-11 13:39:40.000000000 -0400
+++ linux-2.6.13-rc2-mm1-18/drivers/infiniband/include/ib_mad.h	2005-07-11 13:39:52.000000000 -0400
@@ -33,7 +33,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: ib_mad.h 1389 2004-12-27 22:56:47Z roland $
+ * $Id: ib_mad.h 2775 2005-07-02 13:42:12Z halr $
  */
 
 #if !defined( IB_MAD_H )
@@ -58,6 +58,8 @@
 #define IB_MGMT_CLASS_VENDOR_RANGE2_START	0x30
 #define IB_MGMT_CLASS_VENDOR_RANGE2_END		0x4F
 
+#define	IB_OPENIB_OUI				(0x001405)
+
 /* Management methods */
 #define IB_MGMT_METHOD_GET			0x01
 #define IB_MGMT_METHOD_SET			0x02
@@ -72,6 +74,33 @@
 
 #define IB_MGMT_MAX_METHODS			128
 
+/* RMPP information */
+#define IB_MGMT_RMPP_VERSION			1
+
+#define IB_MGMT_RMPP_TYPE_DATA			1
+#define IB_MGMT_RMPP_TYPE_ACK			2
+#define IB_MGMT_RMPP_TYPE_STOP			3
+#define IB_MGMT_RMPP_TYPE_ABORT			4
+
+#define IB_MGMT_RMPP_FLAG_ACTIVE		1
+#define IB_MGMT_RMPP_FLAG_FIRST			(1<<1)
+#define IB_MGMT_RMPP_FLAG_LAST			(1<<2)
+
+#define IB_MGMT_RMPP_NO_RESPTIME		0x1F
+
+#define	IB_MGMT_RMPP_STATUS_SUCCESS		0
+#define	IB_MGMT_RMPP_STATUS_RESX		1
+#define	IB_MGMT_RMPP_STATUS_T2L			118
+#define	IB_MGMT_RMPP_STATUS_BAD_LEN		119
+#define	IB_MGMT_RMPP_STATUS_BAD_SEG		120
+#define	IB_MGMT_RMPP_STATUS_BADT		121
+#define	IB_MGMT_RMPP_STATUS_W2S			122
+#define	IB_MGMT_RMPP_STATUS_S2B			123
+#define	IB_MGMT_RMPP_STATUS_BAD_STATUS		124
+#define	IB_MGMT_RMPP_STATUS_UNV			125
+#define	IB_MGMT_RMPP_STATUS_TMR			126
+#define	IB_MGMT_RMPP_STATUS_UNSPEC		127
+
 #define IB_QP0		0
 #define IB_QP1		__constant_htonl(1)
 #define IB_QP1_QKEY	0x80010000
@@ -88,7 +117,7 @@ struct ib_mad_hdr {
 	u16	attr_id;
 	u16	resv;
 	u32	attr_mod;
-} __attribute__ ((packed));
+};
 
 struct ib_rmpp_hdr {
 	u8	rmpp_version;
@@ -97,17 +126,41 @@ struct ib_rmpp_hdr {
 	u8	rmpp_status;
 	u32	seg_num;
 	u32	paylen_newwin;
+};
+
+typedef u64 __bitwise ib_sa_comp_mask;
+
+#define IB_SA_COMP_MASK(n) ((__force ib_sa_comp_mask) cpu_to_be64(1ull << n))
+
+/*
+ * ib_sa_hdr and ib_sa_mad structures must be packed because they have 
+ * 64-bit fields that are only 32-bit aligned. 64-bit architectures will
+ * lay them out wrong otherwise.  (And unfortunately they are sent on 
+ * the wire so we can't change the layout)
+ */
+struct ib_sa_hdr {
+	u64			sm_key;
+	u16			attr_offset;
+	u16			reserved;
+	ib_sa_comp_mask		comp_mask;
 } __attribute__ ((packed));
 
 struct ib_mad {
 	struct ib_mad_hdr	mad_hdr;
 	u8			data[232];
-} __attribute__ ((packed));
+};
 
 struct ib_rmpp_mad {
 	struct ib_mad_hdr	mad_hdr;
 	struct ib_rmpp_hdr	rmpp_hdr;
 	u8			data[220];
+};
+
+struct ib_sa_mad {
+	struct ib_mad_hdr	mad_hdr;
+	struct ib_rmpp_hdr	rmpp_hdr;
+	struct ib_sa_hdr	sa_hdr;
+	u8			data[200];
 } __attribute__ ((packed));
 
 struct ib_vendor_mad {
@@ -116,7 +169,7 @@ struct ib_vendor_mad {
 	u8			reserved;
 	u8			oui[3];
 	u8			data[216];
-} __attribute__ ((packed));
+};
 
 /**
  * ib_mad_send_buf - MAD data buffer and work request for sends.
@@ -142,6 +195,45 @@ struct ib_mad_send_buf {
 	struct ib_sge		sge;
 };
 
+/**
+ * ib_get_rmpp_resptime - Returns the RMPP response time.
+ * @rmpp_hdr: An RMPP header.
+ */
+static inline u8 ib_get_rmpp_resptime(struct ib_rmpp_hdr *rmpp_hdr)
+{
+	return rmpp_hdr->rmpp_rtime_flags >> 3;
+}
+
+/**
+ * ib_get_rmpp_flags - Returns the RMPP flags.
+ * @rmpp_hdr: An RMPP header.
+ */
+static inline u8 ib_get_rmpp_flags(struct ib_rmpp_hdr *rmpp_hdr)
+{
+	return rmpp_hdr->rmpp_rtime_flags & 0x7;
+}
+
+/**
+ * ib_set_rmpp_resptime - Sets the response time in an RMPP header.
+ * @rmpp_hdr: An RMPP header.
+ * @rtime: The response time to set.
+ */
+static inline void ib_set_rmpp_resptime(struct ib_rmpp_hdr *rmpp_hdr, u8 rtime)
+{
+	rmpp_hdr->rmpp_rtime_flags = ib_get_rmpp_flags(rmpp_hdr) | (rtime << 3);
+}
+
+/**
+ * ib_set_rmpp_flags - Sets the flags in an RMPP header.
+ * @rmpp_hdr: An RMPP header.
+ * @flags: The flags to set.
+ */
+static inline void ib_set_rmpp_flags(struct ib_rmpp_hdr *rmpp_hdr, u8 flags)
+{
+	rmpp_hdr->rmpp_rtime_flags = (rmpp_hdr->rmpp_rtime_flags & 0xF1) |
+				     (flags & 0x7);
+}
+
 struct ib_mad_agent;
 struct ib_mad_send_wc;
 struct ib_mad_recv_wc;
@@ -186,6 +278,7 @@ typedef void (*ib_mad_recv_handler)(stru
  * ib_mad_agent - Used to track MAD registration with the access layer.
  * @device: Reference to device registration is on.
  * @qp: Reference to QP used for sending and receiving MADs.
+ * @mr: Memory region for system memory usable for DMA.
  * @recv_handler: Callback handler for a received MAD.
  * @send_handler: Callback handler for a sent MAD.
  * @snoop_handler: Callback handler for snooped sent MADs.
@@ -194,6 +287,7 @@ typedef void (*ib_mad_recv_handler)(stru
  *   Unsolicited MADs sent by this client will have the upper 32-bits
  *   of their TID set to this value.
  * @port_num: Port number on which QP is registered
+ * @rmpp_version: If set, indicates the RMPP version used by this agent.
  */
 struct ib_mad_agent {
 	struct ib_device	*device;
@@ -205,6 +299,7 @@ struct ib_mad_agent {
 	void			*context;
 	u32			hi_tid;
 	u8			port_num;
+	u8			rmpp_version;
 };
 
 /**
@@ -238,6 +333,7 @@ struct ib_mad_recv_buf {
  * ib_mad_recv_wc - received MAD information.
  * @wc: Completion information for the received data.
  * @recv_buf: Specifies the location of the received data buffer(s).
+ * @rmpp_list: Specifies a list of RMPP reassembled received MAD buffers.
  * @mad_len: The length of the received MAD, without duplicated headers.
  *
  * For received response, the wr_id field of the wc is set to the wr_id
@@ -246,6 +342,7 @@ struct ib_mad_recv_buf {
 struct ib_mad_recv_wc {
 	struct ib_wc		*wc;
 	struct ib_mad_recv_buf	recv_buf;
+	struct list_head	rmpp_list;
 	int			mad_len;
 };
 
@@ -341,6 +438,16 @@ int ib_unregister_mad_agent(struct ib_ma
  * @bad_send_wr: Specifies the MAD on which an error was encountered.
  *
  * Sent MADs are not guaranteed to complete in the order that they were posted.
+ *
+ * If the MAD requires RMPP, the data buffer should contain a single copy
+ * of the common MAD, RMPP, and class specific headers, followed by the class
+ * defined data.  If the class defined data would not divide evenly into
+ * RMPP segments, then space must be allocated at the end of the referenced
+ * buffer for any required padding.  To indicate the amount of class defined
+ * data being transferred, the paylen_newwin field in the RMPP header should
+ * be set to the size of the class specific header plus the amount of class
+ * defined data being transferred.  The paylen_newwin field should be
+ * specified in network-byte order.
  */
 int ib_post_send_mad(struct ib_mad_agent *mad_agent,
 		     struct ib_send_wr *send_wr,
@@ -353,14 +460,13 @@ int ib_post_send_mad(struct ib_mad_agent
  *   referenced buffer should be at least the size of the mad_len specified
  *   by @mad_recv_wc.
  *
- * This call copies a chain of received RMPP MADs into a single data buffer,
+ * This call copies a chain of received MAD segments into a single data buffer,
  * removing duplicated headers.
  */
 void ib_coalesce_recv_mad(struct ib_mad_recv_wc *mad_recv_wc, void *buf);
 
 /**
- * ib_free_recv_mad - Returns data buffers used to receive a MAD to the
- *   access layer.
+ * ib_free_recv_mad - Returns data buffers used to receive a MAD.
  * @mad_recv_wc: Work completion information for a received MAD.
  *
  * Clients receiving MADs through their ib_mad_recv_handler must call this
@@ -437,10 +543,11 @@ int ib_process_mad_wc(struct ib_mad_agen
  * @pkey_index: Specifies which PKey the MAD will be sent using.  This field
  *   is valid only if the remote_qpn is QP 1.
  * @ah: References the address handle used to transfer to the remote node.
+ * @rmpp_active: Indicates if the send will enable RMPP.
  * @hdr_len: Indicates the size of the data header of the MAD.  This length
  *   should include the common MAD header, RMPP header, plus any class
  *   specific header.
- * @data_len: Indicates the size of any user-transfered data.  The call will
+ * @data_len: Indicates the size of any user-transferred data.  The call will
  *   automatically adjust the allocated buffer size to account for any
  *   additional padding that may be necessary.
  * @gfp_mask: GFP mask used for the memory allocation.
@@ -448,11 +555,16 @@ int ib_process_mad_wc(struct ib_mad_agen
  * This is a helper routine that may be used to allocate a MAD.  Users are
  * not required to allocate outbound MADs using this call.  The returned
  * MAD send buffer will reference a data buffer usable for sending a MAD, along
- * with an intialized work request structure.
+ * with an initialized work request structure.  Users may modify the returned
+ * MAD data buffer or work request before posting the send.
+ *
+ * The returned data buffer will be cleared.  Users are responsible for
+ * initializing the common MAD and any class specific headers.  If @rmpp_active
+ * is set, the RMPP header will be initialized for sending.
  */
 struct ib_mad_send_buf * ib_create_send_mad(struct ib_mad_agent *mad_agent,
 					    u32 remote_qpn, u16 pkey_index,
-					    struct ib_ah *ah,
+					    struct ib_ah *ah, int rmpp_active,
 					    int hdr_len, int data_len,
 					    unsigned int __nocast gfp_mask);
 
diff -uprN linux-2.6.13-rc2-mm1-17/drivers/infiniband/include/ib_sa.h linux-2.6.13-rc2-mm1-18/drivers/infiniband/include/ib_sa.h
-- linux-2.6.13-rc2-mm1-17/drivers/infiniband/include/ib_sa.h	2005-06-29 19:00:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1-18/drivers/infiniband/include/ib_sa.h	2005-07-10 12:07:41.000000000 -0400
@@ -87,10 +87,6 @@ static inline int ib_sa_rate_enum_to_int
 	}
 }
 
-typedef u64 __bitwise ib_sa_comp_mask;
-
-#define IB_SA_COMP_MASK(n)	((__force ib_sa_comp_mask) cpu_to_be64(1ull << n))
-
 /*
  * Structures for SA records are named "struct ib_sa_xxx_rec."  No
  * attempt is made to pack structures to match the physical layout of


