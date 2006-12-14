Return-Path: <linux-kernel-owner+w=401wt.eu-S1751968AbWLNGQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbWLNGQ3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 01:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbWLNGQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 01:16:28 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:8716 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbWLNGPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 01:15:08 -0500
X-Greylist: delayed 2050 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 01:14:57 EST
Date: Wed, 13 Dec 2006 21:42:57 -0800
From: divy@chelsio.com
Message-Id: <200612140542.kBE5gvt4005838@localhost.localdomain>
To: jeff@garzik.org
Subject: [PATCH 4/10] cxgb3 - HW access routines - part 2
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+/**
+ *	t3_port_intr_enable - enable port-specific interrupts
+ *	@adapter: associated adapter
+ *	@idx: index of port whose interrupts should be enabled
+ *
+ *	Enable port-specific (i.e., MAC and PHY) interrupts for the given
+ *	adapter port.
+ */
+void t3_port_intr_enable(struct adapter *adapter, int idx)
+{
+	struct cphy *phy = &adap2pinfo(adapter, idx)->phy;
+
+	t3_write_reg(adapter, XGM_REG(A_XGM_INT_ENABLE, idx), XGM_INTR_MASK);
+	phy->ops->intr_enable(phy);
+}
+
+/**
+ *	t3_port_intr_disable - disable port-specific interrupts
+ *	@adapter: associated adapter
+ *	@idx: index of port whose interrupts should be disabled
+ *
+ *	Disable port-specific (i.e., MAC and PHY) interrupts for the given
+ *	adapter port.
+ */
+void t3_port_intr_disable(struct adapter *adapter, int idx)
+{
+	struct cphy *phy = &adap2pinfo(adapter, idx)->phy;
+
+	t3_write_reg(adapter, XGM_REG(A_XGM_INT_ENABLE, idx), 0);
+	phy->ops->intr_disable(phy);
+}
+
+/**
+ *	t3_port_intr_clear - clear port-specific interrupts
+ *	@adapter: associated adapter
+ *	@idx: index of port whose interrupts to clear
+ *
+ *	Clear port-specific (i.e., MAC and PHY) interrupts for the given
+ *	adapter port.
+ */
+void t3_port_intr_clear(struct adapter *adapter, int idx)
+{
+	struct cphy *phy = &adap2pinfo(adapter, idx)->phy;
+
+	t3_write_reg(adapter, XGM_REG(A_XGM_INT_CAUSE, idx), 0xffffffff);
+	phy->ops->intr_clear(phy);
+}
+
+/**
+ * 	t3_sge_write_context - write an SGE context
+ * 	@adapter: the adapter
+ * 	@id: the context id
+ * 	@type: the context type
+ *
+ * 	Program an SGE context with the values already loaded in the
+ * 	CONTEXT_DATA? registers.
+ */
+static int t3_sge_write_context(struct adapter *adapter, unsigned int id,
+				unsigned int type)
+{
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK0, 0xffffffff);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK1, 0xffffffff);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK2, 0xffffffff);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK3, 0xffffffff);
+	t3_write_reg(adapter, A_SG_CONTEXT_CMD,
+		     V_CONTEXT_CMD_OPCODE(1) | type | V_CONTEXT(id));
+	return t3_wait_op_done(adapter, A_SG_CONTEXT_CMD, F_CONTEXT_CMD_BUSY,
+			       0, 5, 1);
+}
+
+/**
+ *	t3_sge_init_ecntxt - initialize an SGE egress context
+ *	@adapter: the adapter to configure
+ *	@id: the context id
+ *	@gts_enable: whether to enable GTS for the context
+ *	@type: the egress context type
+ *	@respq: associated response queue
+ *	@base_addr: base address of queue
+ *	@size: number of queue entries
+ *	@token: uP token
+ *	@gen: initial generation value for the context
+ *	@cidx: consumer pointer
+ *
+ *	Initialize an SGE egress context and make it ready for use.  If the
+ *	platform allows concurrent context operations, the caller is
+ *	responsible for appropriate locking.
+ */
+int t3_sge_init_ecntxt(struct adapter *adapter, unsigned int id, int gts_enable,
+		       enum sge_context_type type, int respq, u64 base_addr,
+		       unsigned int size, unsigned int token, int gen,
+		       unsigned int cidx)
+{
+	unsigned int credits = type == SGE_CNTXT_OFLD ? 0 : FW_WR_NUM;
+
+	if (base_addr & 0xfff)	/* must be 4K aligned */
+		return -EINVAL;
+	if (t3_read_reg(adapter, A_SG_CONTEXT_CMD) & F_CONTEXT_CMD_BUSY)
+		return -EBUSY;
+
+	base_addr >>= 12;
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, V_EC_INDEX(cidx) |
+		     V_EC_CREDITS(credits) | V_EC_GTS(gts_enable));
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA1, V_EC_SIZE(size) |
+		     V_EC_BASE_LO((u32) base_addr & 0xffff));
+	base_addr >>= 16;
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA2, (u32) base_addr);
+	base_addr >>= 32;
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA3,
+		     V_EC_BASE_HI((u32) base_addr & 0xf) | V_EC_RESPQ(respq) |
+		     V_EC_TYPE(type) | V_EC_GEN(gen) | V_EC_UP_TOKEN(token) |
+		     F_EC_VALID);
+	return t3_sge_write_context(adapter, id, F_EGRESS);
+}
+
+/**
+ *	t3_sge_init_flcntxt - initialize an SGE free-buffer list context
+ *	@adapter: the adapter to configure
+ *	@id: the context id
+ *	@gts_enable: whether to enable GTS for the context
+ *	@base_addr: base address of queue
+ *	@size: number of queue entries
+ *	@bsize: size of each buffer for this queue
+ *	@cong_thres: threshold to signal congestion to upstream producers
+ *	@gen: initial generation value for the context
+ *	@cidx: consumer pointer
+ *
+ *	Initialize an SGE free list context and make it ready for use.  The
+ *	caller is responsible for ensuring only one context operation occurs
+ *	at a time.
+ */
+int t3_sge_init_flcntxt(struct adapter *adapter, unsigned int id,
+			int gts_enable, u64 base_addr, unsigned int size,
+			unsigned int bsize, unsigned int cong_thres, int gen,
+			unsigned int cidx)
+{
+	if (base_addr & 0xfff)	/* must be 4K aligned */
+		return -EINVAL;
+	if (t3_read_reg(adapter, A_SG_CONTEXT_CMD) & F_CONTEXT_CMD_BUSY)
+		return -EBUSY;
+
+	base_addr >>= 12;
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, (u32) base_addr);
+	base_addr >>= 32;
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA1,
+		     V_FL_BASE_HI((u32) base_addr) |
+		     V_FL_INDEX_LO(cidx & M_FL_INDEX_LO));
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA2, V_FL_SIZE(size) |
+		     V_FL_GEN(gen) | V_FL_INDEX_HI(cidx >> 12) |
+		     V_FL_ENTRY_SIZE_LO(bsize & M_FL_ENTRY_SIZE_LO));
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA3,
+		     V_FL_ENTRY_SIZE_HI(bsize >> (32 - S_FL_ENTRY_SIZE_LO)) |
+		     V_FL_CONG_THRES(cong_thres) | V_FL_GTS(gts_enable));
+	return t3_sge_write_context(adapter, id, F_FREELIST);
+}
+
+/**
+ *	t3_sge_init_rspcntxt - initialize an SGE response queue context
+ *	@adapter: the adapter to configure
+ *	@id: the context id
+ *	@irq_vec_idx: MSI-X interrupt vector index, 0 if no MSI-X, -1 if no IRQ
+ *	@base_addr: base address of queue
+ *	@size: number of queue entries
+ *	@fl_thres: threshold for selecting the normal or jumbo free list
+ *	@gen: initial generation value for the context
+ *	@cidx: consumer pointer
+ *
+ *	Initialize an SGE response queue context and make it ready for use.
+ *	The caller is responsible for ensuring only one context operation
+ *	occurs at a time.
+ */
+int t3_sge_init_rspcntxt(struct adapter *adapter, unsigned int id,
+			 int irq_vec_idx, u64 base_addr, unsigned int size,
+			 unsigned int fl_thres, int gen, unsigned int cidx)
+{
+	unsigned int intr = 0;
+
+	if (base_addr & 0xfff)	/* must be 4K aligned */
+		return -EINVAL;
+	if (t3_read_reg(adapter, A_SG_CONTEXT_CMD) & F_CONTEXT_CMD_BUSY)
+		return -EBUSY;
+
+	base_addr >>= 12;
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, V_CQ_SIZE(size) |
+		     V_CQ_INDEX(cidx));
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA1, (u32) base_addr);
+	base_addr >>= 32;
+	if (irq_vec_idx >= 0)
+		intr = V_RQ_MSI_VEC(irq_vec_idx) | F_RQ_INTR_EN;
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA2,
+		     V_CQ_BASE_HI((u32) base_addr) | intr | V_RQ_GEN(gen));
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA3, fl_thres);
+	return t3_sge_write_context(adapter, id, F_RESPONSEQ);
+}
+
+/**
+ *	t3_sge_init_cqcntxt - initialize an SGE completion queue context
+ *	@adapter: the adapter to configure
+ *	@id: the context id
+ *	@base_addr: base address of queue
+ *	@size: number of queue entries
+ *	@rspq: response queue for async notifications
+ *	@ovfl_mode: CQ overflow mode
+ *	@credits: completion queue credits
+ *	@credit_thres: the credit threshold
+ *
+ *	Initialize an SGE completion queue context and make it ready for use.
+ *	The caller is responsible for ensuring only one context operation
+ *	occurs at a time.
+ */
+int t3_sge_init_cqcntxt(struct adapter *adapter, unsigned int id, u64 base_addr,
+			unsigned int size, int rspq, int ovfl_mode,
+			unsigned int credits, unsigned int credit_thres)
+{
+	if (base_addr & 0xfff)	/* must be 4K aligned */
+		return -EINVAL;
+	if (t3_read_reg(adapter, A_SG_CONTEXT_CMD) & F_CONTEXT_CMD_BUSY)
+		return -EBUSY;
+
+	base_addr >>= 12;
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, V_CQ_SIZE(size));
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA1, (u32) base_addr);
+	base_addr >>= 32;
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA2,
+		     V_CQ_BASE_HI((u32) base_addr) | V_CQ_RSPQ(rspq) |
+		     V_CQ_GEN(1) | V_CQ_OVERFLOW_MODE(ovfl_mode));
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA3, V_CQ_CREDITS(credits) |
+		     V_CQ_CREDIT_THRES(credit_thres));
+	return t3_sge_write_context(adapter, id, F_CQ);
+}
+
+/**
+ *	t3_sge_enable_ecntxt - enable/disable an SGE egress context
+ *	@adapter: the adapter
+ *	@id: the egress context id
+ *	@enable: enable (1) or disable (0) the context
+ *
+ *	Enable or disable an SGE egress context.  The caller is responsible for
+ *	ensuring only one context operation occurs at a time.
+ */
+int t3_sge_enable_ecntxt(struct adapter *adapter, unsigned int id, int enable)
+{
+	if (t3_read_reg(adapter, A_SG_CONTEXT_CMD) & F_CONTEXT_CMD_BUSY)
+		return -EBUSY;
+
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK0, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK1, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK2, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK3, F_EC_VALID);
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA3, V_EC_VALID(enable));
+	t3_write_reg(adapter, A_SG_CONTEXT_CMD,
+		     V_CONTEXT_CMD_OPCODE(1) | F_EGRESS | V_CONTEXT(id));
+	return t3_wait_op_done(adapter, A_SG_CONTEXT_CMD, F_CONTEXT_CMD_BUSY,
+			       0, 5, 1);
+}
+
+/**
+ *	t3_sge_disable_fl - disable an SGE free-buffer list
+ *	@adapter: the adapter
+ *	@id: the free list context id
+ *
+ *	Disable an SGE free-buffer list.  The caller is responsible for
+ *	ensuring only one context operation occurs at a time.
+ */
+int t3_sge_disable_fl(struct adapter *adapter, unsigned int id)
+{
+	if (t3_read_reg(adapter, A_SG_CONTEXT_CMD) & F_CONTEXT_CMD_BUSY)
+		return -EBUSY;
+
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK0, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK1, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK2, V_FL_SIZE(M_FL_SIZE));
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK3, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA2, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_CMD,
+		     V_CONTEXT_CMD_OPCODE(1) | F_FREELIST | V_CONTEXT(id));
+	return t3_wait_op_done(adapter, A_SG_CONTEXT_CMD, F_CONTEXT_CMD_BUSY,
+			       0, 5, 1);
+}
+
+/**
+ *	t3_sge_disable_rspcntxt - disable an SGE response queue
+ *	@adapter: the adapter
+ *	@id: the response queue context id
+ *
+ *	Disable an SGE response queue.  The caller is responsible for
+ *	ensuring only one context operation occurs at a time.
+ */
+int t3_sge_disable_rspcntxt(struct adapter *adapter, unsigned int id)
+{
+	if (t3_read_reg(adapter, A_SG_CONTEXT_CMD) & F_CONTEXT_CMD_BUSY)
+		return -EBUSY;
+
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK0, V_CQ_SIZE(M_CQ_SIZE));
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK1, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK2, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK3, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_CMD,
+		     V_CONTEXT_CMD_OPCODE(1) | F_RESPONSEQ | V_CONTEXT(id));
+	return t3_wait_op_done(adapter, A_SG_CONTEXT_CMD, F_CONTEXT_CMD_BUSY,
+			       0, 5, 1);
+}
+
+/**
+ *	t3_sge_disable_cqcntxt - disable an SGE completion queue
+ *	@adapter: the adapter
+ *	@id: the completion queue context id
+ *
+ *	Disable an SGE completion queue.  The caller is responsible for
+ *	ensuring only one context operation occurs at a time.
+ */
+int t3_sge_disable_cqcntxt(struct adapter *adapter, unsigned int id)
+{
+	if (t3_read_reg(adapter, A_SG_CONTEXT_CMD) & F_CONTEXT_CMD_BUSY)
+		return -EBUSY;
+
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK0, V_CQ_SIZE(M_CQ_SIZE));
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK1, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK2, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_MASK3, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, 0);
+	t3_write_reg(adapter, A_SG_CONTEXT_CMD,
+		     V_CONTEXT_CMD_OPCODE(1) | F_CQ | V_CONTEXT(id));
+	return t3_wait_op_done(adapter, A_SG_CONTEXT_CMD, F_CONTEXT_CMD_BUSY,
+			       0, 5, 1);
+}
+
+/**
+ *	t3_sge_cqcntxt_op - perform an operation on a completion queue context
+ *	@adapter: the adapter
+ *	@id: the context id
+ *	@op: the operation to perform
+ *
+ *	Perform the selected operation on an SGE completion queue context.
+ *	The caller is responsible for ensuring only one context operation
+ *	occurs at a time.
+ */
+int t3_sge_cqcntxt_op(struct adapter *adapter, unsigned int id, unsigned int op,
+		      unsigned int credits)
+{
+	u32 val;
+
+	if (t3_read_reg(adapter, A_SG_CONTEXT_CMD) & F_CONTEXT_CMD_BUSY)
+		return -EBUSY;
+
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, credits << 16);
+	t3_write_reg(adapter, A_SG_CONTEXT_CMD, V_CONTEXT_CMD_OPCODE(op) |
+		     V_CONTEXT(id) | F_CQ);
+	if (t3_wait_op_done_val(adapter, A_SG_CONTEXT_CMD, F_CONTEXT_CMD_BUSY,
+				0, 5, 1, &val))
+		return -EIO;
+
+	if (op >= 2 && op < 7) {
+		if (adapter->params.rev > 0)
+			return G_CQ_INDEX(val);
+
+		t3_write_reg(adapter, A_SG_CONTEXT_CMD,
+			     V_CONTEXT_CMD_OPCODE(0) | F_CQ | V_CONTEXT(id));
+		if (t3_wait_op_done(adapter, A_SG_CONTEXT_CMD,
+				    F_CONTEXT_CMD_BUSY, 0, 5, 1))
+			return -EIO;
+		return G_CQ_INDEX(t3_read_reg(adapter, A_SG_CONTEXT_DATA0));
+	}
+	return 0;
+}
+
+/**
+ * 	t3_sge_read_context - read an SGE context
+ * 	@type: the context type
+ * 	@adapter: the adapter
+ * 	@id: the context id
+ * 	@data: holds the retrieved context
+ *
+ * 	Read an SGE egress context.  The caller is responsible for ensuring
+ * 	only one context operation occurs at a time.
+ */
+static int t3_sge_read_context(unsigned int type, struct adapter *adapter,
+			       unsigned int id, u32 data[4])
+{
+	if (t3_read_reg(adapter, A_SG_CONTEXT_CMD) & F_CONTEXT_CMD_BUSY)
+		return -EBUSY;
+
+	t3_write_reg(adapter, A_SG_CONTEXT_CMD,
+		     V_CONTEXT_CMD_OPCODE(0) | type | V_CONTEXT(id));
+	if (t3_wait_op_done(adapter, A_SG_CONTEXT_CMD, F_CONTEXT_CMD_BUSY, 0,
+			    5, 1))
+		return -EIO;
+	data[0] = t3_read_reg(adapter, A_SG_CONTEXT_DATA0);
+	data[1] = t3_read_reg(adapter, A_SG_CONTEXT_DATA1);
+	data[2] = t3_read_reg(adapter, A_SG_CONTEXT_DATA2);
+	data[3] = t3_read_reg(adapter, A_SG_CONTEXT_DATA3);
+	return 0;
+}
+
+/**
+ * 	t3_sge_read_ecntxt - read an SGE egress context
+ * 	@adapter: the adapter
+ * 	@id: the context id
+ * 	@data: holds the retrieved context
+ *
+ * 	Read an SGE egress context.  The caller is responsible for ensuring
+ * 	only one context operation occurs at a time.
+ */
+int t3_sge_read_ecntxt(struct adapter *adapter, unsigned int id, u32 data[4])
+{
+	if (id >= 65536)
+		return -EINVAL;
+	return t3_sge_read_context(F_EGRESS, adapter, id, data);
+}
+
+/**
+ * 	t3_sge_read_cq - read an SGE CQ context
+ * 	@adapter: the adapter
+ * 	@id: the context id
+ * 	@data: holds the retrieved context
+ *
+ * 	Read an SGE CQ context.  The caller is responsible for ensuring
+ * 	only one context operation occurs at a time.
+ */
+int t3_sge_read_cq(struct adapter *adapter, unsigned int id, u32 data[4])
+{
+	if (id >= 65536)
+		return -EINVAL;
+	return t3_sge_read_context(F_CQ, adapter, id, data);
+}
+
+/**
+ * 	t3_sge_read_fl - read an SGE free-list context
+ * 	@adapter: the adapter
+ * 	@id: the context id
+ * 	@data: holds the retrieved context
+ *
+ * 	Read an SGE free-list context.  The caller is responsible for ensuring
+ * 	only one context operation occurs at a time.
+ */
+int t3_sge_read_fl(struct adapter *adapter, unsigned int id, u32 data[4])
+{
+	if (id >= SGE_QSETS * 2)
+		return -EINVAL;
+	return t3_sge_read_context(F_FREELIST, adapter, id, data);
+}
+
+/**
+ * 	t3_sge_read_rspq - read an SGE response queue context
+ * 	@adapter: the adapter
+ * 	@id: the context id
+ * 	@data: holds the retrieved context
+ *
+ * 	Read an SGE response queue context.  The caller is responsible for
+ * 	ensuring only one context operation occurs at a time.
+ */
+int t3_sge_read_rspq(struct adapter *adapter, unsigned int id, u32 data[4])
+{
+	if (id >= SGE_QSETS)
+		return -EINVAL;
+	return t3_sge_read_context(F_RESPONSEQ, adapter, id, data);
+}
+
+/**
+ *	t3_config_rss - configure Rx packet steering
+ *	@adapter: the adapter
+ *	@rss_config: RSS settings (written to TP_RSS_CONFIG)
+ *	@cpus: values for the CPU lookup table (0xff terminated)
+ *	@rspq: values for the response queue lookup table (0xffff terminated)
+ *
+ *	Programs the receive packet steering logic.  @cpus and @rspq provide
+ *	the values for the CPU and response queue lookup tables.  If they
+ *	provide fewer values than the size of the tables the supplied values
+ *	are used repeatedly until the tables are fully populated.
+ */
+void t3_config_rss(struct adapter *adapter, unsigned int rss_config,
+		   const u8 * cpus, const u16 *rspq)
+{
+	int i, j, cpu_idx = 0, q_idx = 0;
+
+	if (cpus)
+		for (i = 0; i < RSS_TABLE_SIZE; ++i) {
+			u32 val = i << 16;
+
+			for (j = 0; j < 2; ++j) {
+				val |= (cpus[cpu_idx++] & 0x3f) << (8 * j);
+				if (cpus[cpu_idx] == 0xff)
+					cpu_idx = 0;
+			}
+			t3_write_reg(adapter, A_TP_RSS_LKP_TABLE, val);
+		}
+
+	if (rspq)
+		for (i = 0; i < RSS_TABLE_SIZE; ++i) {
+			t3_write_reg(adapter, A_TP_RSS_MAP_TABLE,
+				     (i << 16) | rspq[q_idx++]);
+			if (rspq[q_idx] == 0xffff)
+				q_idx = 0;
+		}
+
+	t3_write_reg(adapter, A_TP_RSS_CONFIG, rss_config);
+}
+
+/**
+ *	t3_read_rss - read the contents of the RSS tables
+ *	@adapter: the adapter
+ *	@lkup: holds the contents of the RSS lookup table
+ *	@map: holds the contents of the RSS map table
+ *
+ *	Reads the contents of the receive packet steering tables.
+ */
+int t3_read_rss(struct adapter *adapter, u8 * lkup, u16 *map)
+{
+	int i;
+	u32 val;
+
+	if (lkup)
+		for (i = 0; i < RSS_TABLE_SIZE; ++i) {
+			t3_write_reg(adapter, A_TP_RSS_LKP_TABLE,
+				     0xffff0000 | i);
+			val = t3_read_reg(adapter, A_TP_RSS_LKP_TABLE);
+			if (!(val & 0x80000000))
+				return -EAGAIN;
+			*lkup++ = (u8) val;
+			*lkup++ = (u8) (val >> 8);
+		}
+
+	if (map)
+		for (i = 0; i < RSS_TABLE_SIZE; ++i) {
+			t3_write_reg(adapter, A_TP_RSS_MAP_TABLE,
+				     0xffff0000 | i);
+			val = t3_read_reg(adapter, A_TP_RSS_MAP_TABLE);
+			if (!(val & 0x80000000))
+				return -EAGAIN;
+			*map++ = (u16) val;
+		}
+	return 0;
+}
+
+/**
+ *	t3_tp_set_offload_mode - put TP in NIC/offload mode
+ *	@adap: the adapter
+ *	@enable: 1 to select offload mode, 0 for regular NIC
+ *
+ *	Switches TP to NIC/offload mode.
+ */
+void t3_tp_set_offload_mode(struct adapter *adap, int enable)
+{
+	if (is_offload(adap) || !enable)
+		t3_set_reg_field(adap, A_TP_IN_CONFIG, F_NICMODE,
+				 V_NICMODE(!enable));
+}
+
+/**
+ *	pm_num_pages - calculate the number of pages of the payload memory
+ *	@mem_size: the size of the payload memory
+ *	@pg_size: the size of each payload memory page
+ *
+ *	Calculate the number of pages, each of the given size, that fit in a
+ *	memory of the specified size, respecting the HW requirement that the
+ *	number of pages must be a multiple of 24.
+ */
+static inline unsigned int pm_num_pages(unsigned int mem_size,
+					unsigned int pg_size)
+{
+	unsigned int n = mem_size / pg_size;
+
+	return n - n % 24;
+}
+
+#define mem_region(adap, start, size, reg) \
+	t3_write_reg((adap), A_ ## reg, (start)); \
+	start += size
+
+/*
+ *	partition_mem - partition memory and configure TP memory settings
+ *	@adap: the adapter
+ *	@p: the TP parameters
+ *
+ *	Partitions context and payload memory and configures TP's memory
+ *	registers.
+ */
+static void partition_mem(struct adapter *adap, const struct tp_params *p)
+{
+	unsigned int m, pstructs, tids = t3_mc5_size(&adap->mc5);
+	unsigned int timers = 0, timers_shift = 22;
+
+	if (adap->params.rev > 0) {
+		if (tids <= 16 * 1024) {
+			timers = 1;
+			timers_shift = 16;
+		} else if (tids <= 64 * 1024) {
+			timers = 2;
+			timers_shift = 18;
+		} else if (tids <= 256 * 1024) {
+			timers = 3;
+			timers_shift = 20;
+		}
+	}
+
+	t3_write_reg(adap, A_TP_PMM_SIZE,
+		     p->chan_rx_size | (p->chan_tx_size >> 16));
+
+	t3_write_reg(adap, A_TP_PMM_TX_BASE, 0);
+	t3_write_reg(adap, A_TP_PMM_TX_PAGE_SIZE, p->tx_pg_size);
+	t3_write_reg(adap, A_TP_PMM_TX_MAX_PAGE, p->tx_num_pgs);
+	t3_set_reg_field(adap, A_TP_PARA_REG3, V_TXDATAACKIDX(M_TXDATAACKIDX),
+			 V_TXDATAACKIDX(fls(p->tx_pg_size) - 12));
+
+	t3_write_reg(adap, A_TP_PMM_RX_BASE, 0);
+	t3_write_reg(adap, A_TP_PMM_RX_PAGE_SIZE, p->rx_pg_size);
+	t3_write_reg(adap, A_TP_PMM_RX_MAX_PAGE, p->rx_num_pgs);
+
+	pstructs = p->rx_num_pgs + p->tx_num_pgs;
+	/* Add a bit of headroom and make multiple of 24 */
+	pstructs += 48;
+	pstructs -= pstructs % 24;
+	t3_write_reg(adap, A_TP_CMM_MM_MAX_PSTRUCT, pstructs);
+
+	m = tids * TCB_SIZE;
+	mem_region(adap, m, (64 << 10) * 64, SG_EGR_CNTX_BADDR);
+	mem_region(adap, m, (64 << 10) * 64, SG_CQ_CONTEXT_BADDR);
+	t3_write_reg(adap, A_TP_CMM_TIMER_BASE, V_CMTIMERMAXNUM(timers) | m);
+	m += ((p->ntimer_qs - 1) << timers_shift) + (1 << 22);
+	mem_region(adap, m, pstructs * 64, TP_CMM_MM_BASE);
+	mem_region(adap, m, 64 * (pstructs / 24), TP_CMM_MM_PS_FLST_BASE);
+	mem_region(adap, m, 64 * (p->rx_num_pgs / 24), TP_CMM_MM_RX_FLST_BASE);
+	mem_region(adap, m, 64 * (p->tx_num_pgs / 24), TP_CMM_MM_TX_FLST_BASE);
+
+	m = (m + 4095) & ~0xfff;
+	t3_write_reg(adap, A_CIM_SDRAM_BASE_ADDR, m);
+	t3_write_reg(adap, A_CIM_SDRAM_ADDR_SIZE, p->cm_size - m);
+
+	tids = (p->cm_size - m - (3 << 20)) / 3072 - 32;
+	m = t3_mc5_size(&adap->mc5) - adap->params.mc5.nservers -
+	    adap->params.mc5.nfilters - adap->params.mc5.nroutes;
+	if (tids < m)
+		adap->params.mc5.nservers += m - tids;
+}
+
+static inline void tp_wr_indirect(struct adapter *adap, unsigned int addr,
+				  u32 val)
+{
+	t3_write_reg(adap, A_TP_PIO_ADDR, addr);
+	t3_write_reg(adap, A_TP_PIO_DATA, val);
+}
+
+static void tp_config(struct adapter *adap, const struct tp_params *p)
+{
+	unsigned int v;
+
+	t3_write_reg(adap, A_TP_GLOBAL_CONFIG, F_TXPACINGENABLE | F_PATHMTU |
+		     F_IPCHECKSUMOFFLOAD | F_UDPCHECKSUMOFFLOAD |
+		     F_TCPCHECKSUMOFFLOAD | V_IPTTL(64));
+	t3_write_reg(adap, A_TP_TCP_OPTIONS, V_MTUDEFAULT(576) |
+		     F_MTUENABLE | V_WINDOWSCALEMODE(1) |
+		     V_TIMESTAMPSMODE(1) | V_SACKMODE(1) | V_SACKRX(1));
+	t3_write_reg(adap, A_TP_DACK_CONFIG, V_AUTOSTATE3(1) |
+		     V_AUTOSTATE2(1) | V_AUTOSTATE1(0) |
+		     V_BYTETHRESHOLD(16384) | V_MSSTHRESHOLD(2) |
+		     F_AUTOCAREFUL | F_AUTOENABLE | V_DACK_MODE(1));
+	t3_set_reg_field(adap, A_TP_IN_CONFIG, F_IPV6ENABLE | F_NICMODE,
+			 F_IPV6ENABLE | F_NICMODE);
+	t3_write_reg(adap, A_TP_TX_RESOURCE_LIMIT, 0x18141814);
+	t3_write_reg(adap, A_TP_PARA_REG4, 0x5050105);
+	t3_set_reg_field(adap, A_TP_PARA_REG6,
+			 adap->params.rev > 0 ? F_ENABLEESND : F_T3A_ENABLEESND,
+			 0);
+
+	v = t3_read_reg(adap, A_TP_PC_CONFIG);
+	v &= ~(F_ENABLEEPCMDAFULL | F_ENABLEOCSPIFULL);
+	t3_write_reg(adap, A_TP_PC_CONFIG, v | F_TXDEFERENABLE |
+		     F_MODULATEUNIONMODE | F_HEARBEATDACK |
+		     F_TXCONGESTIONMODE | F_RXCONGESTIONMODE);
+
+	v = t3_read_reg(adap, A_TP_PC_CONFIG2);
+	v &= ~F_CHDRAFULL;
+	t3_write_reg(adap, A_TP_PC_CONFIG2, v);
+
+	if (adap->params.rev > 0) {
+		tp_wr_indirect(adap, A_TP_EGRESS_CONFIG, F_REWRITEFORCETOSIZE);
+		t3_set_reg_field(adap, A_TP_PARA_REG3, F_TXPACEAUTO,
+				 F_TXPACEAUTO);
+		t3_set_reg_field(adap, A_TP_PC_CONFIG, F_LOCKTID, F_LOCKTID);
+		t3_set_reg_field(adap, A_TP_PARA_REG3, 0, F_TXPACEAUTOSTRICT);
+	} else
+		t3_set_reg_field(adap, A_TP_PARA_REG3, 0, F_TXPACEFIXED);
+
+	t3_write_reg(adap, A_TP_TX_MOD_QUEUE_WEIGHT1, 0x12121212);
+	t3_write_reg(adap, A_TP_TX_MOD_QUEUE_WEIGHT0, 0x12121212);
+	t3_write_reg(adap, A_TP_MOD_CHANNEL_WEIGHT, 0x1212);
+}
+
+/* Desired TP timer resolution in usec */
+#define TP_TMR_RES 50
+
+/* TCP timer values in ms */
+#define TP_DACK_TIMER 50
+#define TP_RTO_MIN    250
+
+/**
+ *	tp_set_timers - set TP timing parameters
+ *	@adap: the adapter to set
+ *	@core_clk: the core clock frequency in Hz
+ *
+ *	Set TP's timing parameters, such as the various timer resolutions and
+ *	the TCP timer values.
+ */
+static void tp_set_timers(struct adapter *adap, unsigned int core_clk)
+{
+	unsigned int tre = fls(core_clk / (1000000 / TP_TMR_RES)) - 1;
+	unsigned int dack_re = fls(core_clk / 5000) - 1;	/* 200us */
+	unsigned int tstamp_re = fls(core_clk / 1000);	/* 1ms, at least */
+	unsigned int tps = core_clk >> tre;
+
+	t3_write_reg(adap, A_TP_TIMER_RESOLUTION, V_TIMERRESOLUTION(tre) |
+		     V_DELAYEDACKRESOLUTION(dack_re) |
+		     V_TIMESTAMPRESOLUTION(tstamp_re));
+	t3_write_reg(adap, A_TP_DACK_TIMER,
+		     (core_clk >> dack_re) / (1000 / TP_DACK_TIMER));
+	t3_write_reg(adap, A_TP_TCP_BACKOFF_REG0, 0x3020100);
+	t3_write_reg(adap, A_TP_TCP_BACKOFF_REG1, 0x7060504);
+	t3_write_reg(adap, A_TP_TCP_BACKOFF_REG2, 0xb0a0908);
+	t3_write_reg(adap, A_TP_TCP_BACKOFF_REG3, 0xf0e0d0c);
+	t3_write_reg(adap, A_TP_SHIFT_CNT, V_SYNSHIFTMAX(6) |
+		     V_RXTSHIFTMAXR1(4) | V_RXTSHIFTMAXR2(15) |
+		     V_PERSHIFTBACKOFFMAX(8) | V_PERSHIFTMAX(8) |
+		     V_KEEPALIVEMAX(9));
+
+#define SECONDS * tps
+
+	t3_write_reg(adap, A_TP_MSL, adap->params.rev > 0 ? 0 : 2 SECONDS);
+	t3_write_reg(adap, A_TP_RXT_MIN, tps / (1000 / TP_RTO_MIN));
+	t3_write_reg(adap, A_TP_RXT_MAX, 64 SECONDS);
+	t3_write_reg(adap, A_TP_PERS_MIN, 5 SECONDS);
+	t3_write_reg(adap, A_TP_PERS_MAX, 64 SECONDS);
+	t3_write_reg(adap, A_TP_KEEP_IDLE, 7200 SECONDS);
+	t3_write_reg(adap, A_TP_KEEP_INTVL, 75 SECONDS);
+	t3_write_reg(adap, A_TP_INIT_SRTT, 3 SECONDS);
+	t3_write_reg(adap, A_TP_FINWAIT2_TIMER, 600 SECONDS);
+
+#undef SECONDS
+}
+
+/**
+ *	t3_tp_set_coalescing_size - set receive coalescing size
+ *	@adap: the adapter
+ *	@size: the receive coalescing size
+ *	@psh: whether a set PSH bit should deliver coalesced data
+ *
+ *	Set the receive coalescing size and PSH bit handling.
+ */
+int t3_tp_set_coalescing_size(struct adapter *adap, unsigned int size, int psh)
+{
+	u32 val;
+
+	if (size > MAX_RX_COALESCING_LEN)
+		return -EINVAL;
+
+	val = t3_read_reg(adap, A_TP_PARA_REG3);
+	val &= ~(F_RXCOALESCEENABLE | F_RXCOALESCEPSHEN);
+
+	if (size) {
+		val |= F_RXCOALESCEENABLE;
+		if (psh)
+			val |= F_RXCOALESCEPSHEN;
+		t3_write_reg(adap, A_TP_PARA_REG2, V_RXCOALESCESIZE(size) |
+			     V_MAXRXDATA(MAX_RX_COALESCING_LEN));
+	}
+	t3_write_reg(adap, A_TP_PARA_REG3, val);
+	return 0;
+}
+
+/**
+ *	t3_tp_set_max_rxsize - set the max receive size
+ *	@adap: the adapter
+ *	@size: the max receive size
+ *
+ *	Set TP's max receive size.  This is the limit that applies when
+ *	receive coalescing is disabled.
+ */
+void t3_tp_set_max_rxsize(struct adapter *adap, unsigned int size)
+{
+	t3_write_reg(adap, A_TP_PARA_REG7,
+		     V_PMMAXXFERLEN0(size) | V_PMMAXXFERLEN1(size));
+}
+
+static void __devinit init_mtus(unsigned short mtus[])
+{
+	/*
+	 * See draft-mathis-plpmtud-00.txt for the values.  The min is 88 so
+	 * it can accomodate max size TCP/IP headers when SACK and timestamps
+	 * are enabled and still have at least 8 bytes of payload.
+	 */
+	mtus[0] = 88;
+	mtus[1] = 256;
+	mtus[2] = 512;
+	mtus[3] = 576;
+	mtus[4] = 808;
+	mtus[5] = 1024;
+	mtus[6] = 1280;
+	mtus[7] = 1492;
+	mtus[8] = 1500;
+	mtus[9] = 2002;
+	mtus[10] = 2048;
+	mtus[11] = 4096;
+	mtus[12] = 4352;
+	mtus[13] = 8192;
+	mtus[14] = 9000;
+	mtus[15] = 9600;
+}
+
+/*
+ * Initial congestion control parameters.
+ */
+static void __devinit init_cong_ctrl(unsigned short *a, unsigned short *b)
+{
+	a[0] = a[1] = a[2] = a[3] = a[4] = a[5] = a[6] = a[7] = a[8] = 1;
+	a[9] = 2;
+	a[10] = 3;
+	a[11] = 4;
+	a[12] = 5;
+	a[13] = 6;
+	a[14] = 7;
+	a[15] = 8;
+	a[16] = 9;
+	a[17] = 10;
+	a[18] = 14;
+	a[19] = 17;
+	a[20] = 21;
+	a[21] = 25;
+	a[22] = 30;
+	a[23] = 35;
+	a[24] = 45;
+	a[25] = 60;
+	a[26] = 80;
+	a[27] = 100;
+	a[28] = 200;
+	a[29] = 300;
+	a[30] = 400;
+	a[31] = 500;
+
+	b[0] = b[1] = b[2] = b[3] = b[4] = b[5] = b[6] = b[7] = b[8] = 0;
+	b[9] = b[10] = 1;
+	b[11] = b[12] = 2;
+	b[13] = b[14] = b[15] = b[16] = 3;
+	b[17] = b[18] = b[19] = b[20] = b[21] = 4;
+	b[22] = b[23] = b[24] = b[25] = b[26] = b[27] = 5;
+	b[28] = b[29] = 6;
+	b[30] = b[31] = 7;
+}
+
+/* The minimum additive increment value for the congestion control table */
+#define CC_MIN_INCR 2U
+
+/**
+ *	t3_load_mtus - write the MTU and congestion control HW tables
+ *	@adap: the adapter
+ *	@mtus: the unrestricted values for the MTU table
+ *	@alphs: the values for the congestion control alpha parameter
+ *	@beta: the values for the congestion control beta parameter
+ *	@mtu_cap: the maximum permitted effective MTU
+ *
+ *	Write the MTU table with the supplied MTUs capping each at &mtu_cap.
+ *	Update the high-speed congestion control table with the supplied alpha,
+ * 	beta, and MTUs.
+ */
+void t3_load_mtus(struct adapter *adap, unsigned short mtus[NMTUS],
+		  unsigned short alpha[NCCTRL_WIN],
+		  unsigned short beta[NCCTRL_WIN], unsigned short mtu_cap)
+{
+	static unsigned int avg_pkts[NCCTRL_WIN] = {
+		2, 6, 10, 14, 20, 28, 40, 56, 80, 112, 160, 224, 320, 448, 640,
+		896, 1281, 1792, 2560, 3584, 5120, 7168, 10240, 14336, 20480,
+		28672, 40960, 57344, 81920, 114688, 163840, 229376
+	};
+
+	unsigned int i, w;
+
+	for (i = 0; i < NMTUS; ++i) {
+		unsigned int mtu = min(mtus[i], mtu_cap);
+		unsigned int log2 = fls(mtu);
+
+		if (!(mtu & ((1 << log2) >> 2)))	/* round */
+			log2--;
+		t3_write_reg(adap, A_TP_MTU_TABLE,
+			     (i << 24) | (log2 << 16) | mtu);
+
+		for (w = 0; w < NCCTRL_WIN; ++w) {
+			unsigned int inc;
+
+			inc = max(((mtu - 40) * alpha[w]) / avg_pkts[w],
+				  CC_MIN_INCR);
+
+			t3_write_reg(adap, A_TP_CCTRL_TABLE, (i << 21) |
+				     (w << 16) | (beta[w] << 13) | inc);
+		}
+	}
+}
+
+/**
+ *	t3_read_hw_mtus - returns the values in the HW MTU table
+ *	@adap: the adapter
+ *	@mtus: where to store the HW MTU values
+ *
+ *	Reads the HW MTU table.
+ */
+void t3_read_hw_mtus(struct adapter *adap, unsigned short mtus[NMTUS])
+{
+	int i;
+
+	for (i = 0; i < NMTUS; ++i) {
+		unsigned int val;
+
+		t3_write_reg(adap, A_TP_MTU_TABLE, 0xff000000 | i);
+		val = t3_read_reg(adap, A_TP_MTU_TABLE);
+		mtus[i] = val & 0x3fff;
+	}
+}
+
+/**
+ *	t3_get_cong_cntl_tab - reads the congestion control table
+ *	@adap: the adapter
+ *	@incr: where to store the alpha values
+ *
+ *	Reads the additive increments programmed into the HW congestion
+ *	control table.
+ */
+void t3_get_cong_cntl_tab(struct adapter *adap,
+			  unsigned short incr[NMTUS][NCCTRL_WIN])
+{
+	unsigned int mtu, w;
+
+	for (mtu = 0; mtu < NMTUS; ++mtu)
+		for (w = 0; w < NCCTRL_WIN; ++w) {
+			t3_write_reg(adap, A_TP_CCTRL_TABLE,
+				     0xffff0000 | (mtu << 5) | w);
+			incr[mtu][w] = (unsigned short)t3_read_reg(adap,
+								   A_TP_CCTRL_TABLE)
+			    & 0x1fff;
+		}
+}
+
+/**
+ *	t3_tp_get_mib_stats - read TP's MIB counters
+ *	@adap: the adapter
+ *	@tps: holds the returned counter values
+ *
+ *	Returns the values of TP's MIB counters.
+ */
+void t3_tp_get_mib_stats(struct adapter *adap, struct tp_mib_stats *tps)
+{
+	t3_read_indirect(adap, A_TP_MIB_INDEX, A_TP_MIB_RDATA, (u32 *) tps,
+			 sizeof(*tps) / sizeof(u32), 0);
+}
+
+#define ulp_region(adap, name, start, len) \
+	t3_write_reg((adap), A_ULPRX_ ## name ## _LLIMIT, (start)); \
+	t3_write_reg((adap), A_ULPRX_ ## name ## _ULIMIT, \
+		     (start) + (len) - 1); \
+	start += len
+
+#define ulptx_region(adap, name, start, len) \
+	t3_write_reg((adap), A_ULPTX_ ## name ## _LLIMIT, (start)); \
+	t3_write_reg((adap), A_ULPTX_ ## name ## _ULIMIT, \
+		     (start) + (len) - 1)
+
+static void ulp_config(struct adapter *adap, const struct tp_params *p)
+{
+	unsigned int m = p->chan_rx_size;
+
+	ulp_region(adap, ISCSI, m, p->chan_rx_size / 8);
+	ulp_region(adap, TDDP, m, p->chan_rx_size / 8);
+	ulptx_region(adap, TPT, m, p->chan_rx_size / 4);
+	ulp_region(adap, STAG, m, p->chan_rx_size / 4);
+	ulp_region(adap, RQ, m, p->chan_rx_size / 4);
+	ulptx_region(adap, PBL, m, p->chan_rx_size / 4);
+	ulp_region(adap, PBL, m, p->chan_rx_size / 4);
+	t3_write_reg(adap, A_ULPRX_TDDP_TAGMASK, 0xffffffff);
+}
+
+void t3_config_trace_filter(struct adapter *adapter,
+			    const struct trace_params *tp, int filter_index,
+			    int invert, int enable)
+{
+	u32 addr, key[4], mask[4];
+
+	key[0] = tp->sport | (tp->sip << 16);
+	key[1] = (tp->sip >> 16) | (tp->dport << 16);
+	key[2] = tp->dip;
+	key[3] = tp->proto | (tp->vlan << 8) | (tp->intf << 20);
+
+	mask[0] = tp->sport_mask | (tp->sip_mask << 16);
+	mask[1] = (tp->sip_mask >> 16) | (tp->dport_mask << 16);
+	mask[2] = tp->dip_mask;
+	mask[3] = tp->proto_mask | (tp->vlan_mask << 8) | (tp->intf_mask << 20);
+
+	if (invert)
+		key[3] |= (1 << 29);
+	if (enable)
+		key[3] |= (1 << 28);
+
+	addr = filter_index ? A_TP_RX_TRC_KEY0 : A_TP_TX_TRC_KEY0;
+	tp_wr_indirect(adapter, addr++, key[0]);
+	tp_wr_indirect(adapter, addr++, mask[0]);
+	tp_wr_indirect(adapter, addr++, key[1]);
+	tp_wr_indirect(adapter, addr++, mask[1]);
+	tp_wr_indirect(adapter, addr++, key[2]);
+	tp_wr_indirect(adapter, addr++, mask[2]);
+	tp_wr_indirect(adapter, addr++, key[3]);
+	tp_wr_indirect(adapter, addr, mask[3]);
+	(void)t3_read_reg(adapter, A_TP_PIO_DATA);
+}
+
+/**
+ *	t3_config_sched - configure a HW traffic scheduler
+ *	@adap: the adapter
+ *	@kbps: target rate in Kbps
+ *	@sched: the scheduler index
+ *
+ *	Configure a HW scheduler for the target rate
+ */
+int t3_config_sched(struct adapter *adap, unsigned int kbps, int sched)
+{
+	unsigned int v, tps, cpt, bpt, delta, mindelta = ~0;
+	unsigned int clk = adap->params.vpd.cclk * 1000;
+	unsigned int selected_cpt = 0, selected_bpt = 0;
+
+	if (kbps > 0) {
+		kbps *= 125;	/* -> bytes */
+		for (cpt = 1; cpt <= 255; cpt++) {
+			tps = clk / cpt;
+			bpt = (kbps + tps / 2) / tps;
+			if (bpt > 0 && bpt <= 255) {
+				v = bpt * tps;
+				delta = v >= kbps ? v - kbps : kbps - v;
+				if (delta <= mindelta) {
+					mindelta = delta;
+					selected_cpt = cpt;
+					selected_bpt = bpt;
+				}
+			} else if (selected_cpt)
+				break;
+		}
+		if (!selected_cpt)
+			return -EINVAL;
+	}
+	t3_write_reg(adap, A_TP_TM_PIO_ADDR,
+		     A_TP_TX_MOD_Q1_Q0_RATE_LIMIT - sched / 2);
+	v = t3_read_reg(adap, A_TP_TM_PIO_DATA);
+	if (sched & 1)
+		v = (v & 0xffff) | (selected_cpt << 16) | (selected_bpt << 24);
+	else
+		v = (v & 0xffff0000) | selected_cpt | (selected_bpt << 8);
+	t3_write_reg(adap, A_TP_TM_PIO_DATA, v);
+	return 0;
+}
+
+static int tp_init(struct adapter *adap, const struct tp_params *p)
+{
+	int busy = 0;
+
+	tp_config(adap, p);
+	t3_set_vlan_accel(adap, 3, 0);
+
+	if (is_offload(adap)) {
+		tp_set_timers(adap, adap->params.vpd.cclk * 1000);
+		t3_write_reg(adap, A_TP_RESET, F_FLSTINITENABLE);
+		busy = t3_wait_op_done(adap, A_TP_RESET, F_FLSTINITENABLE,
+				       0, 1000, 5);
+		if (busy)
+			CH_ERR(adap, "TP initialization timed out\n");
+	}
+
+	if (!busy)
+		t3_write_reg(adap, A_TP_RESET, F_TPRESET);
+	return busy;
+}
+
+int t3_mps_set_active_ports(struct adapter *adap, unsigned int port_mask)
+{
+	if (port_mask & ~((1 << adap->params.nports) - 1))
+		return -EINVAL;
+	t3_set_reg_field(adap, A_MPS_CFG, F_PORT1ACTIVE | F_PORT0ACTIVE,
+			 port_mask << S_PORT0ACTIVE);
+	return 0;
+}
+
+/*
+ * Perform the bits of HW initialization that are dependent on the number
+ * of available ports.
+ */
+static void init_hw_for_avail_ports(struct adapter *adap, int nports)
+{
+	int i;
+
+	if (nports == 1) {
+		t3_set_reg_field(adap, A_ULPRX_CTL, F_ROUND_ROBIN, 0);
+		t3_set_reg_field(adap, A_ULPTX_CONFIG, F_CFG_RR_ARB, 0);
+		t3_write_reg(adap, A_MPS_CFG, F_TPRXPORTEN | F_TPTXPORT0EN |
+			     F_PORT0ACTIVE | F_ENFORCEPKT);
+		t3_write_reg(adap, A_PM1_TX_CFG, 0xc000c000);
+	} else {
+		t3_set_reg_field(adap, A_ULPRX_CTL, 0, F_ROUND_ROBIN);
+		t3_set_reg_field(adap, A_ULPTX_CONFIG, 0, F_CFG_RR_ARB);
+		t3_write_reg(adap, A_ULPTX_DMA_WEIGHT,
+			     V_D1_WEIGHT(16) | V_D0_WEIGHT(16));
+		t3_write_reg(adap, A_MPS_CFG, F_TPTXPORT0EN | F_TPTXPORT1EN |
+			     F_TPRXPORTEN | F_PORT0ACTIVE | F_PORT1ACTIVE |
+			     F_ENFORCEPKT);
+		t3_write_reg(adap, A_PM1_TX_CFG, 0x80008000);
+		t3_set_reg_field(adap, A_TP_PC_CONFIG, 0, F_TXTOSQUEUEMAPMODE);
+		t3_write_reg(adap, A_TP_TX_MOD_QUEUE_REQ_MAP,
+			     V_TX_MOD_QUEUE_REQ_MAP(0xaa));
+		for (i = 0; i < 16; i++)
+			t3_write_reg(adap, A_TP_TX_MOD_QUE_TABLE,
+				     (i << 16) | 0x1010);
+	}
+}
+
+static int calibrate_xgm(struct adapter *adapter)
+{
+	if (uses_xaui(adapter)) {
+		unsigned int v, i;
+
+		for (i = 0; i < 5; ++i) {
+			t3_write_reg(adapter, A_XGM_XAUI_IMP, 0);
+			(void)t3_read_reg(adapter, A_XGM_XAUI_IMP);
+			msleep(1);
+			v = t3_read_reg(adapter, A_XGM_XAUI_IMP);
+			if (!(v & (F_XGM_CALFAULT | F_CALBUSY))) {
+				t3_write_reg(adapter, A_XGM_XAUI_IMP,
+					     V_XAUIIMP(G_CALIMP(v) >> 2));
+				return 0;
+			}
+		}
+		CH_ERR(adapter, "MAC calibration failed\n");
+		return -1;
+	} else {
+		t3_write_reg(adapter, A_XGM_RGMII_IMP,
+			     V_RGMIIIMPPD(2) | V_RGMIIIMPPU(3));
+		t3_set_reg_field(adapter, A_XGM_RGMII_IMP, F_XGM_IMPSETUPDATE,
+				 F_XGM_IMPSETUPDATE);
+	}
+	return 0;
+}
+
+static void calibrate_xgm_t3b(struct adapter *adapter)
+{
+	if (!uses_xaui(adapter)) {
+		t3_write_reg(adapter, A_XGM_RGMII_IMP, F_CALRESET |
+			     F_CALUPDATE | V_RGMIIIMPPD(2) | V_RGMIIIMPPU(3));
+		t3_set_reg_field(adapter, A_XGM_RGMII_IMP, F_CALRESET, 0);
+		t3_set_reg_field(adapter, A_XGM_RGMII_IMP, 0,
+				 F_XGM_IMPSETUPDATE);
+		t3_set_reg_field(adapter, A_XGM_RGMII_IMP, F_XGM_IMPSETUPDATE,
+				 0);
+		t3_set_reg_field(adapter, A_XGM_RGMII_IMP, F_CALUPDATE, 0);
+		t3_set_reg_field(adapter, A_XGM_RGMII_IMP, 0, F_CALUPDATE);
+	}
+}
+
+struct mc7_timing_params {
+	unsigned char ActToPreDly;
+	unsigned char ActToRdWrDly;
+	unsigned char PreCyc;
+	unsigned char RefCyc[5];
+	unsigned char BkCyc;
+	unsigned char WrToRdDly;
+	unsigned char RdToWrDly;
+};
+
+/*
+ * Write a value to a register and check that the write completed.  These
+ * writes normally complete in a cycle or two, so one read should suffice.
+ * The very first read exists to flush the posted write to the device.
+ */
+static int wrreg_wait(struct adapter *adapter, unsigned int addr, u32 val)
+{
+	t3_write_reg(adapter, addr, val);
+	(void)t3_read_reg(adapter, addr);	/* flush */
+	if (!(t3_read_reg(adapter, addr) & F_BUSY))
+		return 0;
+	CH_ERR(adapter, "write to MC7 register 0x%x timed out\n", addr);
+	return -EIO;
+}
+
+static int mc7_init(struct mc7 *mc7, unsigned int mc7_clock, int mem_type)
+{
+	static unsigned int mc7_mode[] = { 0x632, 0x642, 0x652, 0x432, 0x442 };
+	static const struct mc7_timing_params mc7_timings[] = {
+		{12, 3, 4, {20, 28, 34, 52, 0}, 15, 6, 4},
+		{12, 4, 5, {20, 28, 34, 52, 0}, 16, 7, 4},
+		{12, 5, 6, {20, 28, 34, 52, 0}, 17, 8, 4},
+		{9, 3, 4, {15, 21, 26, 39, 0}, 12, 6, 4},
+		{9, 4, 5, {15, 21, 26, 39, 0}, 13, 7, 4}
+	};
+
+	u32 val;
+	unsigned int width, density, slow, attempts;
+	struct adapter *adapter = mc7->adapter;
+	const struct mc7_timing_params *p = &mc7_timings[mem_type];
+
+	val = t3_read_reg(adapter, mc7->offset + A_MC7_CFG);
+	slow = val & F_SLOW;
+	width = G_WIDTH(val);
+	density = G_DEN(val);
+
+	t3_write_reg(adapter, mc7->offset + A_MC7_CFG, val | F_IFEN);
+	val = t3_read_reg(adapter, mc7->offset + A_MC7_CFG);	/* flush */
+	msleep(1);
+
+	if (!slow) {
+		t3_write_reg(adapter, mc7->offset + A_MC7_CAL, F_SGL_CAL_EN);
+		(void)t3_read_reg(adapter, mc7->offset + A_MC7_CAL);
+		msleep(1);
+		if (t3_read_reg(adapter, mc7->offset + A_MC7_CAL) &
+		    (F_BUSY | F_SGL_CAL_EN | F_CAL_FAULT)) {
+			CH_ERR(adapter, "%s MC7 calibration timed out\n",
+			       mc7->name);
+			goto out_fail;
+		}
+	}
+
+	t3_write_reg(adapter, mc7->offset + A_MC7_PARM,
+		     V_ACTTOPREDLY(p->ActToPreDly) |
+		     V_ACTTORDWRDLY(p->ActToRdWrDly) | V_PRECYC(p->PreCyc) |
+		     V_REFCYC(p->RefCyc[density]) | V_BKCYC(p->BkCyc) |
+		     V_WRTORDDLY(p->WrToRdDly) | V_RDTOWRDLY(p->RdToWrDly));
+
+	t3_write_reg(adapter, mc7->offset + A_MC7_CFG,
+		     val | F_CLKEN | F_TERM150);
+	(void)t3_read_reg(adapter, mc7->offset + A_MC7_CFG);	/* flush */
+
+	if (!slow)
+		t3_set_reg_field(adapter, mc7->offset + A_MC7_DLL, F_DLLENB,
+				 F_DLLENB);
+	udelay(1);
+
+	val = slow ? 3 : 6;
+	if (wrreg_wait(adapter, mc7->offset + A_MC7_PRE, 0) ||
+	    wrreg_wait(adapter, mc7->offset + A_MC7_EXT_MODE2, 0) ||
+	    wrreg_wait(adapter, mc7->offset + A_MC7_EXT_MODE3, 0) ||
+	    wrreg_wait(adapter, mc7->offset + A_MC7_EXT_MODE1, val))
+		goto out_fail;
+
+	if (!slow) {
+		t3_write_reg(adapter, mc7->offset + A_MC7_MODE, 0x100);
+		t3_set_reg_field(adapter, mc7->offset + A_MC7_DLL, F_DLLRST, 0);
+		udelay(5);
+	}
+
+	if (wrreg_wait(adapter, mc7->offset + A_MC7_PRE, 0) ||
+	    wrreg_wait(adapter, mc7->offset + A_MC7_REF, 0) ||
+	    wrreg_wait(adapter, mc7->offset + A_MC7_REF, 0) ||
+	    wrreg_wait(adapter, mc7->offset + A_MC7_MODE,
+		       mc7_mode[mem_type]) ||
+	    wrreg_wait(adapter, mc7->offset + A_MC7_EXT_MODE1, val | 0x380) ||
+	    wrreg_wait(adapter, mc7->offset + A_MC7_EXT_MODE1, val))
+		goto out_fail;
+
+	/* clock value is in KHz */
+	mc7_clock = mc7_clock * 7812 + mc7_clock / 2;	/* ns */
+	mc7_clock /= 1000000;	/* KHz->MHz, ns->us */
+
+	t3_write_reg(adapter, mc7->offset + A_MC7_REF,
+		     F_PERREFEN | V_PREREFDIV(mc7_clock));
+	(void)t3_read_reg(adapter, mc7->offset + A_MC7_REF);	/* flush */
+
+	t3_write_reg(adapter, mc7->offset + A_MC7_ECC, F_ECCGENEN | F_ECCCHKEN);
+	t3_write_reg(adapter, mc7->offset + A_MC7_BIST_DATA, 0);
+	t3_write_reg(adapter, mc7->offset + A_MC7_BIST_ADDR_BEG, 0);
+	t3_write_reg(adapter, mc7->offset + A_MC7_BIST_ADDR_END,
+		     (mc7->size << width) - 1);
+	t3_write_reg(adapter, mc7->offset + A_MC7_BIST_OP, V_OP(1));
+	(void)t3_read_reg(adapter, mc7->offset + A_MC7_BIST_OP);	/* flush */
+
+	attempts = 50;
+	do {
+		msleep(250);
+		val = t3_read_reg(adapter, mc7->offset + A_MC7_BIST_OP);
+	} while ((val & F_BUSY) && --attempts);
+	if (val & F_BUSY) {
+		CH_ERR(adapter, "%s MC7 BIST timed out\n", mc7->name);
+		goto out_fail;
+	}
+
+	/* Enable normal memory accesses. */
+	t3_set_reg_field(adapter, mc7->offset + A_MC7_CFG, 0, F_RDY);
+	return 0;
+
+out_fail:
+	return -1;
+}
+
+static void config_pcie(struct adapter *adap)
+{
+	static u16 ack_lat[4][6] = {
+		{237, 416, 559, 1071, 2095, 4143},
+		{128, 217, 289, 545, 1057, 2081},
+		{73, 118, 154, 282, 538, 1050},
+		{67, 107, 86, 150, 278, 534}
+	};
+	static u16 rpl_tmr[4][6] = {
+		{711, 1248, 1677, 3213, 6285, 12429},
+		{384, 651, 867, 1635, 3171, 6243},
+		{219, 354, 462, 846, 1614, 3150},
+		{201, 321, 258, 450, 834, 1602}
+	};
+
+	u16 val;
+	unsigned int log2_width, pldsize;
+	unsigned int fst_trn_rx, fst_trn_tx, acklat, rpllmt;
+
+	pci_read_config_word(adap->pdev,
+			     adap->params.pci.pcie_cap_addr + PCI_EXP_DEVCTL,
+			     &val);
+	pldsize = (val & PCI_EXP_DEVCTL_PAYLOAD) >> 5;
+	pci_read_config_word(adap->pdev,
+			     adap->params.pci.pcie_cap_addr + PCI_EXP_LNKCTL,
+			     &val);
+
+	fst_trn_tx = G_NUMFSTTRNSEQ(t3_read_reg(adap, A_PCIE_PEX_CTRL0));
+	fst_trn_rx = adap->params.rev == 0 ? fst_trn_tx :
+	    G_NUMFSTTRNSEQRX(t3_read_reg(adap, A_PCIE_MODE));
+	log2_width = fls(adap->params.pci.width) - 1;
+	acklat = ack_lat[log2_width][pldsize];
+	if (val & 1)		/* check LOsEnable */
+		acklat += fst_trn_tx * 4;
+	rpllmt = rpl_tmr[log2_width][pldsize] + fst_trn_rx * 4;
+
+	if (adap->params.rev == 0)
+		t3_set_reg_field(adap, A_PCIE_PEX_CTRL1,
+				 V_T3A_ACKLAT(M_T3A_ACKLAT),
+				 V_T3A_ACKLAT(acklat));
+	else
+		t3_set_reg_field(adap, A_PCIE_PEX_CTRL1, V_ACKLAT(M_ACKLAT),
+				 V_ACKLAT(acklat));
+
+	t3_set_reg_field(adap, A_PCIE_PEX_CTRL0, V_REPLAYLMT(M_REPLAYLMT),
+			 V_REPLAYLMT(rpllmt));
+
+	t3_write_reg(adap, A_PCIE_PEX_ERR, 0xffffffff);
+	t3_set_reg_field(adap, A_PCIE_CFG, F_PCIE_CLIDECEN, F_PCIE_CLIDECEN);
+}
+
+/*
+ * Initialize and configure T3 HW modules.  This performs the
+ * initialization steps that need to be done once after a card is reset.
+ * MAC and PHY initialization is handled separarely whenever a port is enabled.
+ *
+ * fw_params are passed to FW and their value is platform dependent.  Only the
+ * top 8 bits are available for use, the rest must be 0.
+ */
+int t3_init_hw(struct adapter *adapter, u32 fw_params)
+{
+	int err = -EIO, attempts = 100;
+	const struct vpd_params *vpd = &adapter->params.vpd;
+
+	if (adapter->params.rev > 0)
+		calibrate_xgm_t3b(adapter);
+	else if (calibrate_xgm(adapter))
+		goto out_err;
+
+	if (vpd->mclk) {
+		partition_mem(adapter, &adapter->params.tp);
+
+		if (mc7_init(&adapter->pmrx, vpd->mclk, vpd->mem_timing) ||
+		    mc7_init(&adapter->pmtx, vpd->mclk, vpd->mem_timing) ||
+		    mc7_init(&adapter->cm, vpd->mclk, vpd->mem_timing) ||
+		    t3_mc5_init(&adapter->mc5, adapter->params.mc5.nservers,
+				adapter->params.mc5.nfilters,
+				adapter->params.mc5.nroutes))
+			goto out_err;
+	}
+
+	if (tp_init(adapter, &adapter->params.tp))
+		goto out_err;
+
+	t3_tp_set_coalescing_size(adapter,
+				  min(adapter->params.sge.max_pkt_size,
+				      MAX_RX_COALESCING_LEN), 1);
+	t3_tp_set_max_rxsize(adapter,
+			     min(adapter->params.sge.max_pkt_size, 16384U));
+	ulp_config(adapter, &adapter->params.tp);
+
+	if (is_pcie(adapter))
+		config_pcie(adapter);
+	else
+		t3_set_reg_field(adapter, A_PCIX_CFG, 0, F_CLIDECEN);
+
+	t3_write_reg(adapter, A_PM1_RX_CFG, 0xf000f000);
+	init_hw_for_avail_ports(adapter, adapter->params.nports);
+	t3_sge_init(adapter, &adapter->params.sge);
+
+	t3_write_reg(adapter, A_CIM_HOST_ACC_DATA, vpd->uclk | fw_params);
+	t3_write_reg(adapter, A_CIM_BOOT_CFG,
+		     V_BOOTADDR(FW_FLASH_BOOT_ADDR >> 2));
+	(void)t3_read_reg(adapter, A_CIM_BOOT_CFG);	/* flush */
+
+	do {			/* wait for uP to initialize */
+		msleep(20);
+	} while (t3_read_reg(adapter, A_CIM_HOST_ACC_DATA) && --attempts);
+	if (!attempts)
+		goto out_err;
+
+	err = 0;
+out_err:
+	return err;
+}
+
+/**
+ *	get_pci_mode - determine a card's PCI mode
+ *	@adapter: the adapter
+ *	@p: where to store the PCI settings
+ *
+ *	Determines a card's PCI mode and associated parameters, such as speed
+ *	and width.
+ */
+static void __devinit get_pci_mode(struct adapter *adapter,
+				   struct pci_params *p)
+{
+	static unsigned short speed_map[] = { 33, 66, 100, 133 };
+	u32 pci_mode, pcie_cap;
+
+	pcie_cap = pci_find_capability(adapter->pdev, PCI_CAP_ID_EXP);
+	if (pcie_cap) {
+		u16 val;
+
+		p->variant = PCI_VARIANT_PCIE;
+		p->pcie_cap_addr = pcie_cap;
+		pci_read_config_word(adapter->pdev, pcie_cap + PCI_EXP_LNKSTA,
+					&val);
+		p->width = (val >> 4) & 0x3f;
+		return;
+	}
+
+	pci_mode = t3_read_reg(adapter, A_PCIX_MODE);
+	p->speed = speed_map[G_PCLKRANGE(pci_mode)];
+	p->width = (pci_mode & F_64BIT) ? 64 : 32;
+	pci_mode = G_PCIXINITPAT(pci_mode);
+	if (pci_mode == 0)
+		p->variant = PCI_VARIANT_PCI;
+	else if (pci_mode < 4)
+		p->variant = PCI_VARIANT_PCIX_MODE1_PARITY;
+	else if (pci_mode < 8)
+		p->variant = PCI_VARIANT_PCIX_MODE1_ECC;
+	else
+		p->variant = PCI_VARIANT_PCIX_266_MODE2;
+}
+
+/**
+ *	init_link_config - initialize a link's SW state
+ *	@lc: structure holding the link state
+ *	@ai: information about the current card
+ *
+ *	Initializes the SW state maintained for each link, including the link's
+ *	capabilities and default speed/duplex/flow-control/autonegotiation
+ *	settings.
+ */
+static void __devinit init_link_config(struct link_config *lc,
+				       unsigned int caps)
+{
+	lc->supported = caps;
+	lc->requested_speed = lc->speed = SPEED_INVALID;
+	lc->requested_duplex = lc->duplex = DUPLEX_INVALID;
+	lc->requested_fc = lc->fc = PAUSE_RX | PAUSE_TX;
+	if (lc->supported & SUPPORTED_Autoneg) {
+		lc->advertising = lc->supported;
+		lc->autoneg = AUTONEG_ENABLE;
+		lc->requested_fc |= PAUSE_AUTONEG;
+	} else {
+		lc->advertising = 0;
+		lc->autoneg = AUTONEG_DISABLE;
+	}
+}
+
+/**
+ *	mc7_calc_size - calculate MC7 memory size
+ *	@cfg: the MC7 configuration
+ *
+ *	Calculates the size of an MC7 memory in bytes from the value of its
+ *	configuration register.
+ */
+static unsigned int __devinit mc7_calc_size(u32 cfg)
+{
+	unsigned int width = G_WIDTH(cfg);
+	unsigned int banks = !!(cfg & F_BKS) + 1;
+	unsigned int org = !!(cfg & F_ORG) + 1;
+	unsigned int density = G_DEN(cfg);
+	unsigned int MBs = ((256 << density) * banks) / (org << width);
+
+	return MBs << 20;
+}
+
+static void __devinit mc7_prep(struct adapter *adapter, struct mc7 *mc7,
+			       unsigned int base_addr, const char *name)
+{
+	u32 cfg;
+
+	mc7->adapter = adapter;
+	mc7->name = name;
+	mc7->offset = base_addr - MC7_PMRX_BASE_ADDR;
+	cfg = t3_read_reg(adapter, mc7->offset + A_MC7_CFG);
+	mc7->size = mc7_calc_size(cfg);
+	mc7->width = G_WIDTH(cfg);
+}
+
+void mac_prep(struct cmac *mac, struct adapter *adapter, int index)
+{
+	mac->adapter = adapter;
+	mac->offset = (XGMAC0_1_BASE_ADDR - XGMAC0_0_BASE_ADDR) * index;
+	mac->nucast = 1;
+
+	if (adapter->params.rev == 0 && uses_xaui(adapter)) {
+		t3_write_reg(adapter, A_XGM_SERDES_CTRL + mac->offset,
+			     is_10G(adapter) ? 0x2901c04 : 0x2301c04);
+		t3_set_reg_field(adapter, A_XGM_PORT_CFG + mac->offset,
+				 F_ENRGMII, 0);
+	}
+}
+
+void early_hw_init(struct adapter *adapter, const struct adapter_info *ai)
+{
+	u32 val = V_PORTSPEED(is_10G(adapter) ? 3 : 2);
+
+	mi1_init(adapter, ai);
+	t3_write_reg(adapter, A_I2C_CFG,	/* set for 80KHz */
+		     V_I2C_CLKDIV(adapter->params.vpd.cclk / 80 - 1));
+	t3_write_reg(adapter, A_T3DBG_GPIO_EN,
+		     ai->gpio_out | F_GPIO0_OEN | F_GPIO0_OUT_VAL);
+
+	if (adapter->params.rev == 0 || !uses_xaui(adapter))
+		val |= F_ENRGMII;
+
+	/* Enable MAC clocks so we can access the registers */
+	t3_write_reg(adapter, A_XGM_PORT_CFG, val);
+	(void)t3_read_reg(adapter, A_XGM_PORT_CFG);
+
+	val |= F_CLKDIVRESET_;
+	t3_write_reg(adapter, A_XGM_PORT_CFG, val);
+	(void)t3_read_reg(adapter, A_XGM_PORT_CFG);
+	t3_write_reg(adapter, XGM_REG(A_XGM_PORT_CFG, 1), val);
+	(void)t3_read_reg(adapter, A_XGM_PORT_CFG);
+}
+
+/*
+ * Reset the adapter.  PCIe cards lose their config space during reset, PCI-X
+ * ones don't.
+ */
+int t3_reset_adapter(struct adapter *adapter)
+{
+	int i;
+	uint16_t devid = 0;
+
+	if (is_pcie(adapter))
+		pci_save_state(adapter->pdev);
+	t3_write_reg(adapter, A_PL_RST, F_CRSTWRM | F_CRSTWRMMODE);
+
+	/*
+	 * Delay. Give Some time to device to reset fully.
+	 * XXX The delay time should be modified.
+	 */
+	for (i = 0; i < 10; i++) {
+		msleep(50);
+		pci_read_config_word(adapter->pdev, 0x00, &devid);
+		if (devid == 0x1425)
+			break;
+	}
+
+	if (devid != 0x1425)
+		return -1;
+
+	if (is_pcie(adapter))
+		pci_restore_state(adapter->pdev);
+	return 0;
+}
+
+/*
+ * Initialize adapter SW state for the various HW modules, set initial values
+ * for some adapter tunables, take PHYs out of reset, and initialize the MDIO
+ * interface.
+ */
+int __devinit t3_prep_adapter(struct adapter *adapter,
+			      const struct adapter_info *ai, int reset)
+{
+	int ret;
+	unsigned int i, j = 0;
+
+	get_pci_mode(adapter, &adapter->params.pci);
+
+	adapter->params.info = ai;
+	adapter->params.nports = ai->nports;
+	adapter->params.rev = t3_read_reg(adapter, A_PL_REV);
+	adapter->params.linkpoll_period = 0;
+	adapter->params.stats_update_period = is_10G(adapter) ?
+	    MAC_STATS_ACCUM_SECS : (MAC_STATS_ACCUM_SECS * 10);
+	adapter->params.pci.vpd_cap_addr =
+	    pci_find_capability(adapter->pdev, PCI_CAP_ID_VPD);
+	ret = get_vpd_params(adapter, &adapter->params.vpd);
+	if (ret < 0)
+		return ret;
+
+	if (reset && t3_reset_adapter(adapter))
+		return -1;
+
+	t3_sge_prep(adapter, &adapter->params.sge);
+
+	if (adapter->params.vpd.mclk) {
+		struct tp_params *p = &adapter->params.tp;
+
+		mc7_prep(adapter, &adapter->pmrx, MC7_PMRX_BASE_ADDR, "PMRX");
+		mc7_prep(adapter, &adapter->pmtx, MC7_PMTX_BASE_ADDR, "PMTX");
+		mc7_prep(adapter, &adapter->cm, MC7_CM_BASE_ADDR, "CM");
+
+		p->nchan = ai->nports;
+		p->pmrx_size = t3_mc7_size(&adapter->pmrx);
+		p->pmtx_size = t3_mc7_size(&adapter->pmtx);
+		p->cm_size = t3_mc7_size(&adapter->cm);
+		p->chan_rx_size = p->pmrx_size / 2;	/* only 1 Rx channel */
+		p->chan_tx_size = p->pmtx_size / p->nchan;
+		p->rx_pg_size = 64 * 1024;
+		p->tx_pg_size = is_10G(adapter) ? 64 * 1024 : 16 * 1024;
+		p->rx_num_pgs = pm_num_pages(p->chan_rx_size, p->rx_pg_size);
+		p->tx_num_pgs = pm_num_pages(p->chan_tx_size, p->tx_pg_size);
+		p->ntimer_qs = p->cm_size >= (128 << 20) ||
+		    adapter->params.rev > 0 ? 12 : 6;
+
+		adapter->params.mc5.nservers = DEFAULT_NSERVERS;
+		adapter->params.mc5.nfilters = adapter->params.rev > 0 ?
+		    DEFAULT_NFILTERS : 0;
+		adapter->params.mc5.nroutes = 0;
+		t3_mc5_prep(adapter, &adapter->mc5, MC5_MODE_144_BIT);
+
+		init_mtus(adapter->params.mtus);
+		init_cong_ctrl(adapter->params.a_wnd, adapter->params.b_wnd);
+	}
+
+	early_hw_init(adapter, ai);
+
+	for_each_port(adapter, i) {
+		u8 hw_addr[6];
+		struct port_info *p = adap2pinfo(adapter, i);
+
+		while (!adapter->params.vpd.port_type[j])
+			++j;
+
+		p->port_type = &port_types[adapter->params.vpd.port_type[j]];
+		p->port_type->phy_prep(&p->phy, adapter, ai->phy_base_addr + j,
+				       ai->mdio_ops);
+		mac_prep(&p->mac, adapter, j);
+		++j;
+
+		/*
+		 * The VPD EEPROM stores the base Ethernet address for the
+		 * card.  A port's address is derived from the base by adding
+		 * the port's index to the base's low octet.
+		 */
+		memcpy(hw_addr, adapter->params.vpd.eth_base, 5);
+		hw_addr[5] = adapter->params.vpd.eth_base[5] + i;
+
+		memcpy(adapter->port[i]->dev_addr, hw_addr,
+		       ETH_ALEN);
+#ifdef ETHTOOL_GPERMADDR
+		memcpy(adapter->port[i]->perm_addr, hw_addr,
+		       ETH_ALEN);
+#endif
+		init_link_config(&p->link_config, p->port_type->caps);
+		p->phy.ops->power_down(&p->phy, 1);
+		if (!(p->port_type->caps & SUPPORTED_IRQ))
+			adapter->params.linkpoll_period = 10;
+	}
+
+	return 0;
+}
+
+void t3_led_ready(struct adapter *adapter)
+{
+	t3_set_reg_field(adapter, A_T3DBG_GPIO_EN, F_GPIO0_OUT_VAL,
+			 F_GPIO0_OUT_VAL);
+}
