Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWEQWEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWEQWEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWEQWEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:04:37 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:59808 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751190AbWEQWEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:04:36 -0400
Date: Wed, 17 May 2006 18:04:35 -0400
From: Brice Goglin <brice@myri.com>
To: netdev@vger.kernel.org
Cc: gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] myri10ge - Driver header files
Message-ID: <20060517220434.GC13411@myri.com>
References: <20060517220218.GA13411@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517220218.GA13411@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2/4] myri10ge - Driver header files

myri10ge driver header files.
myri10ge_mcp.h is the generic header, while myri10ge_mcp_gen_header.h
is automatically generated from our firmware image.

Signed-off-by: Brice Goglin <brice@myri.com>
Signed-off-by: Andrew J. Gallatin <gallatin@myri.com>

 myri10ge_mcp.h            |  205 ++++++++++++++++++++++++++++++++++++++++++++++
 myri10ge_mcp_gen_header.h |   58 +++++++++++++
 2 files changed, 263 insertions(+)

--- /dev/null	2006-05-16 20:08:50.920483500 +0200
+++ linux-tmp//drivers/net/myri10ge/myri10ge_mcp.h	2006-05-17 11:02:48.000000000 +0200
@@ -0,0 +1,205 @@
+#ifndef __MYRI10GE_MCP_H__
+#define __MYRI10GE_MCP_H__
+
+#define MYRI10GE_MCP_VERSION_MAJOR	1
+#define MYRI10GE_MCP_VERSION_MINOR	4
+
+/* 8 Bytes */
+struct mcp_dma_addr {
+	u32 high;
+	u32 low;
+};
+
+/* 16 Bytes */
+struct mcp_slot {
+	u16 checksum;
+	u16 length;
+};
+
+/* 64 Bytes */
+struct mcp_cmd {
+	u32 cmd;
+	u32 data0;		/* will be low portion if data > 32 bits */
+	/* 8 */
+	u32 data1;		/* will be high portion if data > 32 bits */
+	u32 data2;		/* currently unused.. */
+	/* 16 */
+	struct mcp_dma_addr response_addr;
+	/* 24 */
+	u8 pad[40];
+};
+
+/* 8 Bytes */
+struct mcp_cmd_response {
+	u32 data;
+	u32 result;
+};
+
+/* 
+ * flags used in mcp_kreq_ether_send_t:
+ * 
+ * The SMALL flag is only needed in the first segment. It is raised
+ * for packets that are total less or equal 512 bytes.
+ * 
+ * The CKSUM flag must be set in all segments.
+ * 
+ * The PADDED flags is set if the packet needs to be padded, and it
+ * must be set for all segments.
+ * 
+ * The  MYRI10GE_MCP_ETHER_FLAGS_ALIGN_ODD must be set if the cumulative
+ * length of all previous segments was odd.
+ */
+
+#define MYRI10GE_MCP_ETHER_FLAGS_SMALL      0x1
+#define MYRI10GE_MCP_ETHER_FLAGS_TSO_HDR    0x1
+#define MYRI10GE_MCP_ETHER_FLAGS_FIRST      0x2
+#define MYRI10GE_MCP_ETHER_FLAGS_ALIGN_ODD  0x4
+#define MYRI10GE_MCP_ETHER_FLAGS_CKSUM      0x8
+#define MYRI10GE_MCP_ETHER_FLAGS_TSO_LAST   0x8
+#define MYRI10GE_MCP_ETHER_FLAGS_NO_TSO     0x10
+#define MYRI10GE_MCP_ETHER_FLAGS_TSO_CHOP   0x10
+#define MYRI10GE_MCP_ETHER_FLAGS_TSO_PLD    0x20
+
+#define MYRI10GE_MCP_ETHER_SEND_SMALL_SIZE  1520
+#define MYRI10GE_MCP_ETHER_MAX_MTU          9400
+
+union mcp_pso_or_cumlen {
+	u16 pseudo_hdr_offset;
+	u16 cum_len;
+};
+
+#define	MYRI10GE_MCP_ETHER_MAX_SEND_DESC 12
+#define MYRI10GE_MCP_ETHER_PAD	    2
+
+/* 16 Bytes */
+struct mcp_kreq_ether_send {
+	u32 addr_high;
+	u32 addr_low;
+	u16 pseudo_hdr_offset;
+	u16 length;
+	u8 pad;
+	u8 rdma_count;
+	u8 cksum_offset;	/* where to start computing cksum */
+	u8 flags;		/* as defined above */
+};
+
+/* 8 Bytes */
+struct mcp_kreq_ether_recv {
+	u32 addr_high;
+	u32 addr_low;
+};
+
+/* Commands */
+
+#define MYRI10GE_MCP_CMD_OFFSET 0xf80000
+
+enum myri10ge_mcp_cmd_type {
+	MYRI10GE_MCP_CMD_NONE = 0,
+	/* Reset the mcp, it is left in a safe state, waiting
+	 * for the driver to set all its parameters */
+	MYRI10GE_MCP_CMD_RESET,
+
+	/* get the version number of the current firmware..
+	 * (may be available in the eeprom strings..? */
+	MYRI10GE_MCP_GET_MCP_VERSION,
+
+	/* Parameters which must be set by the driver before it can
+	 * issue MYRI10GE_MCP_CMD_ETHERNET_UP. They persist until the next
+	 * MYRI10GE_MCP_CMD_RESET is issued */
+
+	MYRI10GE_MCP_CMD_SET_INTRQ_DMA,
+	MYRI10GE_MCP_CMD_SET_BIG_BUFFER_SIZE,	/* in bytes, power of 2 */
+	MYRI10GE_MCP_CMD_SET_SMALL_BUFFER_SIZE,	/* in bytes */
+
+	/* Parameters which refer to lanai SRAM addresses where the 
+	 * driver must issue PIO writes for various things */
+
+	MYRI10GE_MCP_CMD_GET_SEND_OFFSET,
+	MYRI10GE_MCP_CMD_GET_SMALL_RX_OFFSET,
+	MYRI10GE_MCP_CMD_GET_BIG_RX_OFFSET,
+	MYRI10GE_MCP_CMD_GET_IRQ_ACK_OFFSET,
+	MYRI10GE_MCP_CMD_GET_IRQ_DEASSERT_OFFSET,
+
+	/* Parameters which refer to rings stored on the MCP,
+	 * and whose size is controlled by the mcp */
+
+	MYRI10GE_MCP_CMD_GET_SEND_RING_SIZE,	/* in bytes */
+	MYRI10GE_MCP_CMD_GET_RX_RING_SIZE,	/* in bytes */
+
+	/* Parameters which refer to rings stored in the host,
+	 * and whose size is controlled by the host.  Note that
+	 * all must be physically contiguous and must contain 
+	 * a power of 2 number of entries.  */
+
+	MYRI10GE_MCP_CMD_SET_INTRQ_SIZE,	/* in bytes */
+
+	/* command to bring ethernet interface up.  Above parameters
+	 * (plus mtu & mac address) must have been exchanged prior
+	 * to issuing this command  */
+	MYRI10GE_MCP_CMD_ETHERNET_UP,
+
+	/* command to bring ethernet interface down.  No further sends
+	 * or receives may be processed until an MYRI10GE_MCP_CMD_ETHERNET_UP
+	 * is issued, and all interrupt queues must be flushed prior
+	 * to ack'ing this command */
+
+	MYRI10GE_MCP_CMD_ETHERNET_DOWN,
+
+	/* commands the driver may issue live, without resetting
+	 * the nic.  Note that increasing the mtu "live" should
+	 * only be done if the driver has already supplied buffers
+	 * sufficiently large to handle the new mtu.  Decreasing
+	 * the mtu live is safe */
+
+	MYRI10GE_MCP_CMD_SET_MTU,
+	MYRI10GE_MCP_CMD_GET_INTR_COAL_DELAY_OFFSET,	/* in microseconds */
+	MYRI10GE_MCP_CMD_SET_STATS_INTERVAL,	/* in microseconds */
+	MYRI10GE_MCP_CMD_SET_STATS_DMA,
+
+	MYRI10GE_MCP_ENABLE_PROMISC,
+	MYRI10GE_MCP_DISABLE_PROMISC,
+	MYRI10GE_MCP_SET_MAC_ADDRESS,
+
+	MYRI10GE_MCP_ENABLE_FLOW_CONTROL,
+	MYRI10GE_MCP_DISABLE_FLOW_CONTROL,
+
+	/* do a DMA test
+	 * data0,data1 = DMA address
+	 * data2       = RDMA length (MSH), WDMA length (LSH)
+	 * command return data = repetitions (MSH), 0.5-ms ticks (LSH)
+	 */
+	MYRI10GE_MCP_DMA_TEST
+};
+
+enum myri10ge_mcp_cmd_status {
+	MYRI10GE_MCP_CMD_OK = 0,
+	MYRI10GE_MCP_CMD_UNKNOWN,
+	MYRI10GE_MCP_CMD_ERROR_RANGE,
+	MYRI10GE_MCP_CMD_ERROR_BUSY,
+	MYRI10GE_MCP_CMD_ERROR_EMPTY,
+	MYRI10GE_MCP_CMD_ERROR_CLOSED,
+	MYRI10GE_MCP_CMD_ERROR_HASH_ERROR,
+	MYRI10GE_MCP_CMD_ERROR_BAD_PORT,
+	MYRI10GE_MCP_CMD_ERROR_RESOURCES
+};
+
+/* 40 Bytes */
+struct mcp_irq_data {
+	u32 send_done_count;
+
+	u32 link_up;
+	u32 dropped_link_overflow;
+	u32 dropped_link_error_or_filtered;
+	u32 dropped_runt;
+	u32 dropped_overrun;
+	u32 dropped_no_small_buffer;
+	u32 dropped_no_big_buffer;
+	u32 rdma_tags_available;
+
+	u8 tx_stopped;
+	u8 link_down;
+	u8 stats_updated;
+	u8 valid;
+};
+
+#endif				/* __MYRI10GE_MCP_H__ */
--- /dev/null	2006-05-16 20:08:50.920483500 +0200
+++ linux-tmp//drivers/net/myri10ge/myri10ge_mcp_gen_header.h	2006-05-17 11:02:48.000000000 +0200
@@ -0,0 +1,58 @@
+#ifndef __MYRI10GE_MCP_GEN_HEADER_H__
+#define __MYRI10GE_MCP_GEN_HEADER_H__
+
+/* this file define a standard header used as a first entry point to
+ * exchange information between firmware/driver and driver.  The
+ * header structure can be anywhere in the mcp. It will usually be in
+ * the .data section, because some fields needs to be initialized at
+ * compile time.
+ * The 32bit word at offset MX_HEADER_PTR_OFFSET in the mcp must
+ * contains the location of the header. 
+ * 
+ * Typically a MCP will start with the following:
+ * .text
+ * .space 52    ! to help catch MEMORY_INT errors
+ * bt start     ! jump to real code
+ * nop
+ * .long _gen_mcp_header
+ * 
+ * The source will have a definition like:
+ * 
+ * mcp_gen_header_t gen_mcp_header = {
+ * .header_length = sizeof(mcp_gen_header_t),
+ * .mcp_type = MCP_TYPE_XXX,
+ * .version = "something $Id: mcp_gen_header.h,v 1.2 2006/05/13 10:04:35 bgoglin Exp $",
+ * .mcp_globals = (unsigned)&Globals
+ * };
+ */
+
+#define MCP_HEADER_PTR_OFFSET  0x3c
+
+#define MCP_TYPE_MX 0x4d582020	/* "MX  " */
+#define MCP_TYPE_PCIE 0x70636965	/* "PCIE" pcie-only MCP */
+#define MCP_TYPE_ETH 0x45544820	/* "ETH " */
+#define MCP_TYPE_MCP0 0x4d435030	/* "MCP0" */
+
+struct mcp_gen_header {
+	/* the first 4 fields are filled at compile time */
+	unsigned header_length;
+	unsigned mcp_type;
+	char version[128];
+	unsigned mcp_globals;	/* pointer to mcp-type specific structure */
+
+	/* filled by the MCP at run-time */
+	unsigned sram_size;
+	unsigned string_specs;	/* either the original STRING_SPECS or a superset */
+	unsigned string_specs_len;
+
+	/* Fields above this comment are guaranteed to be present.
+	 * 
+	 * Fields below this comment are extensions added in later versions
+	 * of this struct, drivers should compare the header_length against
+	 * offsetof(field) to check wether a given MCP implements them.
+	 * 
+	 * Never remove any field.  Keep everything naturally align.
+	 */
+};
+
+#endif				/* __MYRI10GE_MCP_GEN_HEADER_H__ */
