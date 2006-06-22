Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030636AbWFVNQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030636AbWFVNQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030637AbWFVNQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:16:37 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:7308 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1030636AbWFVNQg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:16:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 6/13] Equinox SST driver:hardware registers
Date: Thu, 22 Jun 2006 09:16:35 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B71109@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 6/13] Equinox SST driver:hardware registers
Thread-Index: AcaV/hXcVdQS+aQ+TxacIA9sLQLdHA==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 6: new header file: drivers/char/eqnx/icp.h.  Defines the layout of
the
registers accessible by the two ICPs - SSP-4 and SSP-64.  The SSP-4
controls 4
channels, the SSP-64 controls 64 channels.  The registers are similar,
but
not identical on the SSP-4 and SSP-64.  Basically, each ICP has a set of

global registers and then a set of input registers and output registers
for
each channel.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 icp.h |  857
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 857 insertions(+)

diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/icp.h
linux-2.6.17.eqnx/drivers/char/eqnx/icp.h
--- linux-2.6.17/drivers/char/eqnx/icp.h	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/icp.h	2006-06-20
09:50:05.000000000 -0400
@@ -0,0 +1,857 @@
+/*
+ * Equinox / Avocent SST (multi-port serial) driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+/*
+ * Register definitions for the SSP4 and SSP64 ICPs (Intelligent
+ * Communications Processor).  The SSP4 controls 4 channels.  The SSP64
+ * controls 64 channels.
+ *
+ * Each ICP provides a set of input and output registers per channel.
+ * Input registers for receiving data and output registers for
trasmitting.
+ * In addition, there are also a set of global registers per board
which are
+ * used for general configuration and also contain the global attention
bits.
+ */
+
+/*
+ * SSP64 global register structure - one set for each SSP64 ASIC
+ */
+struct icp_gbl_struct {
+	u8	filler1[24];
+	u8	gicp_bus_cntrl;		/* 0x18: bus control */
+	u8	gicp_rev;		/* 0x19: icp revision */
+	u8	filler2[2];
+	u8	gicp_initiate;		/* 0x1c: lmx control & icp
enable */
+	u8	gicp_scan_spd;		/* 0x1d: lmx scan speeds */
+	u8	gicp_tmr_size;		/* 0x1e: interval timer scale
preset */
+	u8	gicp_tmr_count;		/* 0x1f: interval timer count
preset */
+	u8	filler3[24];
+	u8	gicp_watchdog;		/* 0x38: watchdog timer */
+	u8	filler4[3];
+	u8	gicp_attn;		/* 0x3c: global status */
+	u8	gicp_chan;		/* 0x3d: current channel number
*/
+	u16	gicp_frame_ctr;		/* 0x3e: frame counter */
+	u8	filler5[24];
+	u8	gicp_rcv_attn[8];	/* 0x58: receive attention bits
*/
+	u8	filler6[24];
+	u8	gicp_xmit_attn[8];	/* 0x78: transmit attention bits
*/
+};
+
+/* gicp_bus_cntrl register (R/W) */
+#define	CPU_BUS		0x3		/* cpu bus width */
+#define	CPU_BUS_8	0x0		/* 8-bit bus */
+#define	CPU_BUS_16	0x1		/* 16-bit bus */
+#define	CPU_BUS_32	0x2		/* 32-bit bus */
+#define	DRAM_40		0x4		/* 40-bit DRAM */
+#define	STERNG		0x8		/* DRAM steer */
+#define	SWAPNG		0x10		/* PRAM swap */
+#define	DMARQ_2		0x20		/* seperate DMA */
+#define	GTIMER_EN	0x40		/* interval timer enable
*/
+
+/* gicp_rev register (RO) */
+#define	REV_SSP		0x1		/* SSP type (0=SSP4,
1=SSP64) */
+#define	REV_NUMBER	0xfe		/* revision number */
+
+/* gicp_initiate register (R/W) */
+#define	ICP_2		0x1		/* secondary ICP */
+#define	RNG_CLK_ON	0x2		/* ring clock on */
+#define	ICP_PRAM_WR	0x4		/* PRAM writeable */
+#define	DMA_EN		0x8		/* DMA enable */
+#define	DISABLE_ATTN_CLR 0x10		/* disable attn byte
clear on read */
+
+/* gicp_scan_spd register (R/W) */
+#define	A_16_PORTS	0x0		/* LMX 0: 16 ports */
+#define	A_8_PORTS	0x1		/* LMX 0: 8 ports */
+#define	A_4_PORTS	0x2		/* LMX 0: 4 ports */
+#define	A_2_PORTS	0x3		/* LMX 0: 2 ports */
+
+#define	B_16_PORTS	0x0		/* LMX 1: 16 ports */
+#define	B_8_PORTS	0x4		/* LMX 1: 8 ports */
+#define	B_4_PORTS	0x8		/* LMX 1: 4 ports */
+#define	B_2_PORTS	0xc		/* LMX 1: 2 ports */
+
+#define	C_16_PORTS	0x0		/* LMX 2: 16 ports */
+#define	C_8_PORTS	0x10		/* LMX 2: 8 ports */
+#define	C_4_PORTS	0x20		/* LMX 2: 4 ports */
+#define	C_2_PORTS	0x30		/* LMX 2: 2 ports */
+
+#define	D_16_PORTS	0x0		/* LMX 3: 16 ports */
+#define	D_8_PORTS	0x40		/* LMX 3: 8 ports */
+#define	D_4_PORTS	0x80		/* LMX 3: 4 ports */
+#define	D_2_PORTS	0xc0		/* LMX 3: 2 ports */
+
+/* gicp_watchdog register (R/W) */
+#define	WDOG_REFRESH	0x1f		/* watchdog refresh key
*/
+#define	WDOG_DIS	0x0		/* watchdog disabled */
+#define	WDOG_1_SEC	0x20		/* 1-sec watchdog
timeout */
+#define	WDOG_2_SEC	0x40		/* 2-sec watchdog
timeout */
+#define	WDOG_4_SEC	0x60		/* 4-sec watchdog
timeout */
+#define	WDOG_8_SEC	0x80		/* 8-sec watchdog
timeout */
+#define	WDOG_16_SEC	0xa0		/* 16-sec watchdog
timeout */
+#define	WDOG_32_SEC	0xc0		/* 32-sec watchdog
timeout */
+
+/* gicp_attn register (RO) */
+#define	GATTN_RX	0x1		/* input attention */
+#define	GATTN_TX	0x2		/* output attention */
+#define	RNG_FAIL	0x4		/* ring clock off */
+#define	WDOG_EXP	0x8		/* watchdog expired */
+
+/* gicp_chan register (RO) */
+#define	CHAN_NUM	0xf		/* channel number */
+#define	LMX_NUM		0x30		/* LMX number */
+
+/*
+ * SSP4 global register structure - one set for each SSP4 ASIC
+ */
+struct ssp4_gbl_struct {
+	u8	bus_cntrl;		/* 0x0: global control register
*/
+	u8	rev;			/* 0x1: revision Level number */
+	u8	on_line;		/* 0x2: on-line */
+	u8	filler1;
+	u8	chan_ctr;		/* 0x4: active channel number */
+	u8	filler2;
+	u8	chan_attn;		/* 0x6: channel attention bits
*/
+	u8	tmr_evnt;		/* 0x7: timer event bits */
+	u8	filler3[17];
+	u8	type;			/* 0x19: board type */
+	u8	filler4[34];
+	u8	attn_pend;		/* 0x3c: channel attention */
+};
+
+/* bus_cntrl register (R/W) */
+#define	BUS_CNTRL_16	0x1		/* 16-bit bus */
+#define	BUS_CNTRL_ATTN	0x2		/* enable attention
interrupt */
+#define	BUS_CNTRL_WR	0x4		/* enable channel writes
*/
+#define	BUS_CNTRL_DMA	0x8		/* enable internal DMA
writes */
+#define	BUS_CNTRL_RRESET 0x10		/* disable read reset -
attn/timer */
+#define	BUS_CNTRL_TIMER	0x20		/* enable global timer
interrupt */
+#define	BUS_CNTRL_SPEED	0xc0		/* speed multiplier */
+#define	BUS_CNTRL_SPEED_115 0x00	/* 115.2 per channel */
+#define	BUS_CNTRL_SPEED_230 0x40	/* 230.4 per channel */
+#define	BUS_CNTRL_SPEED_460 0x80	/* 460.8 per channel */
+#define	BUS_CNTRL_SPEED_920 0xc0	/* 921.6 per channel */
+
+/* rev register (RO) */
+#define	REV_MUX		0x1		/* ports MUX'd */
+#define	REV_NUMBER	0xfe		/* revision number */
+
+/* on-line register (R/W) */
+#define	ONLINE_ON	0x1		/* online */
+#define	ONLINE_EARLY	0x2		/* early ready enable */
+#define	ONLINE_NOMUX	0x4		/* output active w/no
mux */
+#define	ONLINE_TEST	0x8		/* test bit */
+
+/* active channel register (RO) */
+#define	ACTIVE_CHAN	0x3F		/* active channel number
*/
+
+/* channel attention register (RO) */
+#define	ATTN_TX0	0x1		/* output attention
channel 0 */
+#define	ATTN_TX1	0x2		/* output attention
channel 1 */
+#define	ATTN_TX2	0x4		/* output attention
channel 2 */
+#define	ATTN_TX3	0x8		/* output attention
channel 3 */
+#define	ATTN_RX0	0x10		/* input attention
channel 0 */
+#define	ATTN_RX1	0x20		/* input attention
channel 1 */
+#define	ATTN_RX2	0x40		/* input attention
channel 2 */
+#define	ATTN_RX3	0x80		/* input attention
channel 3 */
+
+/* timer event bits register (RO) */
+#define	TIMER_TX0	0x1		/* timer event channel 0
*/
+#define	TIMER_TX1	0x2		/* timer event channel 1
*/
+#define	TIMER_TX2	0x4		/* timer event channel 2
*/
+#define	TIMER_TX3	0x8		/* timer event channel 3
*/
+
+/* type register (RO) */
+#define	REV_SSP		0x1		/* SSP type (0=SSP2/4,
1=SSP64) */
+
+/* attention pending register (RO) */
+#define	ATTN_PEND_ATTN	0x1		/* pending events */
+#define	ATTN_PEND_NOMUX	0x4		/* mux not connected */
+
+/*
+ * Union of SSP64 and SSP4 global register structs
+ */
+union global_regs_u {
+	struct icp_gbl_struct ssp;
+	struct ssp4_gbl_struct ssp4;
+};
+
+/*
+ * banked input register structure - two sets for each channel
+ * note some slight differences between SSP4 and SSP64.
+ */
+struct cin_bnk_struct {
+	u16	bank_nxt_dma;		/* 0x0: offset to next in dma */
+	u8	bank_fifo_lvl;		/* 0x2: char count held in fifo
*/
+	u8	bank_tags_l;		/* 0x3: input tags, low byte */
+	u16	bank_signals;		/* 0x4: channel input signals */
+	u8	filler0;
+	u8	bank_tags_h;		/* 0x7: input tags, high byte */
+	u8	bank_fifo[8];		/* 0x8: input 8 char fifo */
+	u16	bank_num_chars;		/* 0x10: char count received */
+	u16	bank_events;		/* 0x12: input events detected
*/
+};
+
+/* bank_fifo_lvl register (RO) */
+#define	BNK_FIFO_LVL	0xf		/* number of bytes in
fifo */
+#define	BNK_BUF_FULL	0x10		/* buffer full occurred
(SSP4 only) */
+#define	BNK_MIN_EVENT	0x20		/* min char event
enabled */
+#define	BNK_TIMER_TOGGLE 0x40		/* saved char timer
toggle */
+#define	BNK_DMA_PEND	0x80		/* DMA pending */
+
+/* bank_tags_l register (RO) */
+#define	BNK_TAGS0	0x3		/* tags for char 0 */
+#define	BNK_TAGS1	0xc		/* tags for char 1 */
+#define	BNK_TAGS2	0x30		/* tags for char 2 */
+#define	BNK_TAGS3	0xc0		/* tags for char 3 */
+
+/* tag values for bank_tags_l and bank_tags_h */
+#define	BNK_TAGS_VALID	0x0		/* valid character */
+#define	BNK_TAGS_PARITY	0x1		/* parity error */
+#define	BNK_TAGS_FRAME	0x2		/* framing error */
+#define	BNK_TAGS_LOOKUP	0x3		/* lookup character */
+
+/* bank_signals register (RO) */
+#define	CIN_BREAK	0x1		/* inbound break */
+#define	CIN_DCD		0x2		/* inbound DCD signal
asserted */
+#define	CIN_CTS		0x4		/* inbound CTS signal
asserted */
+#define	CIN_DSR		0x8		/* inbound DSR signal
asserted */
+#define	CIN_RI		0x10		/* inbound RI signal
asserted */
+/* remaining bits only present on SSP64 */
+#define	LMX_ONLN	0x20		/* LMX online */
+#define	LMX_RMT		0x40		/* 0: local lmx/bridge
1: mux */
+#define	LMX_PRESENT	0x80		/* LMX present */
+#define	ICP_OUT_2	0x100		/* ICP output from
second */
+#define	LMX_OUT_2	0x200		/* LMX output from
second */
+#define	AMI_LNK_ON	0x400		/* AMI bridge link to
mux */
+#define	XPRNCY_PEND	0x800		/* waiting for link with
mux */
+#define	LMX_LCK		0x1000		/* LMX ring locked */
+#define	AMI_CNFG	0x2000		/* AMI bridge configured
*/
+
+/* bank_tags_h register (RO) */
+#define	BNK_TAGS4	0x3		/* tags for char 4 */
+#define	BNK_TAGS5	0xc		/* tags for char 5 */
+#define	BNK_TAGS6	0x30		/* tags for char 6 */
+#define	BNK_TAGS7	0xc0		/* tags for char 7 */
+
+/* bank_events register (RO) */
+#define	EV_AUTO_BAUD	0x1		/* auto baud complete */
+#define	EV_DCD_CNG	0x2		/* DCD signal changed */
+#define	EV_CTS_CNG	0x4		/* CTS signal changed */
+#define	EV_DSR_CNG	0x8		/* DSR signal changed */
+#define	EV_RI_CNG	0x10		/* RI signal changed */
+#define	EV_BREAK_CNG	0x20		/* start of break event
*/
+#define	EV_LMX_CNG	0x40		/* LMX condition change
(SSP64 only) */
+#define	EV_PAR_ERR	0x80		/* parity error */
+#define	EV_FRM_ERR	0x100		/* framing error */
+#define	EV_CHAR_LOOKUP	0x200		/* character lookup */
+#define	EV_VTIME	0x400		/* character timer
expired */
+#define	EV_VMIN		0x800		/* min. characters
exceeded */
+#define	EV_OVERRUN	0x1000		/* buffer overflow */
+#define	EV_DMA_FAIL	0x2000		/* DMA failed */
+#define	EV_REG_UPDT	0x4000		/* register update */
+#define	CHAN_ATTN_SET	0x8000		/* channel attention bit
set */
+
+/*
+ * input register structure - one set for each SSP4 / SSP64 channel
+ */
+struct icp_in_struct {
+	u16	cin_char_cntrl;		/* 0x0: input char control */
+	u8	cin_locks;		/* 0x2: input locks */
+	u8	cin_dma_hi;		/* 0x3: input dma base (b23 -
b16) */
+	u16	cin_baud;		/* 0x4: input baud */
+	u8	cin_q_cntrl;		/* 0x6: input queue control reg
*/
+	u8	cin_lit_nxt_char;	/* 0x7: literal next char */
+	u8	cin_xon_1;		/* 0x8: xon-1 character */
+	u8	cin_xon_2;		/* 0x9: xon-2 character */
+	u8	cin_xoff_1;		/* 0xa: xoff-1 character */
+	u8	cin_xoff_2;		/* 0xb: xoff-2 character */
+	u8	filler1[4];
+	u8	cin_tmr_preset_sz;	/* 0x10: character timer scale
preset */
+	u8	cin_tmr_preset_count;	/* 0x11: character tick count
preset */
+	u16	cin_attn_ena;		/* 0x12: input attention mask */
+	u16	cin_overload_lvl;	/* 0x14: input queue overload
level */
+	u8	cin_susp_output_lmx;	/* 0x16: enable channel
suspension */
+	u8	cin_susp_output_sig;	/* 0x17: enable channel
suspension */
+	u16	cin_min_char_lvl;	/* 0x18: minimum character level
*/
+	u8	filler2[6];
+	u8	cin_lookup_tbl[32];	/* 0x20: char lookup attn bits
*/
+	u16	cin_tail_ptr_a;		/* 0x40: tail pointer a */
+	u8	filler3[2];
+	struct	cin_bnk_struct cin_bank_a; /* 0x44: bank a registers */
+	u16	cin_tdm_early;		/* 0x58: input tdm early */
+	u8	filler4[2];
+	u16	cin_baud_ctr;		/* 0x5c: autobaud ctr, etc. */
+	u8	cin_input_state;	/* 0x5e: input state */
+	u8	cin_intern_flgs;	/* 0x5f: self-clearing flags */
+	u16	cin_tail_ptr_b;		/* 0x60: tail pointer b */
+	u8	filler5[2];
+	struct cin_bnk_struct cin_bank_b; /* 0x64: bank b registers */
+	u16	cin_tdm_late;		/* 0x78: input tdm late */
+	u8	filler6[2];
+	u8	cin_tmr_size;		/* 0x7c: character timer scale
*/
+	u8	cin_char_tmr_remain;	/* 0x7d: (VTIME) ticks remaining
*/
+	u8	cin_partial_char;	/* 0x7e: partial incoming
character */
+	u8	cin_iband_flow_cntrl;	/* 0x7f: inband flow control */
+};
+
+/* cin_char_cntrl register (R/W) */
+#define	CS_MASK		0x3		/* character size */
+#define	CS_5		0x0
+#define	CS_6		0x1
+#define	CS_7		0x2
+#define	CS_8		0x3
+#define	PARITY_ON	0x4		/* parity bit present */
+#define	PARITY_MASK	0x18		/* parity */
+#define	PARITY_ODD	0x0
+#define	PARITY_EVEN	0x8
+#define	PARITY_MARK	0x10
+#define	PARITY_SPACE	0x18
+#define	IGN_BAD_CHAR	0x20		/* discard error bytes
*/
+#define	IGN_BRK_NULL	0x40		/* discard break NULL */
+#define	EN_CHAR_LOOKUP	0x80		/* enable character
lookup */
+#define	NO_CMP_ERR	0x100		/* treat error
characters as good */
+#define	EN_LITNXT	0x200		/* enable literal next
*/
+#define	EN_IXANY	0x400		/* any character xon */
+#define	EN_DBL_FLW	0x800		/* enable two-character
xon / xoff */
+#define	EN_DNS_FLW	0x1000		/* discard xon / xoff */
+#define	EN_ISTRIP	0x2000		/* discard data bit 7 */
+#define	EN_XOFF		0x4000		/* enable xoff compare
*/
+#define	EN_XON		0x8000		/* enable xon compare */
+
+/* cin_locks register (R/W) */
+#define	DIS_BANK_A	0x1		/* disable bank a writes
*/
+#define	DIS_BANK_B	0x2		/* disable bank b writes
*/
+#define	SEL_BANK_A	0x2
+#define	SEL_BANK_B	0x1
+#define	SEL_NO_BANK	0x3
+#define	DIS_IN_STAT	0x4		/* disable internal stat
writes */
+#define	DIS_IBAND_FLW	0x8		/* disable inband flow
writes */
+#define	DIS_VTIME_WR	0x10		/* disable char timer
writes */
+#define	DIS_AUTOBAUD	0x20		/* disable autobaud
writes */
+#define	DIS_DMA_WR	0x80		/* disable DMA writes */
+
+/* cin_q_cntrl register (R/W) */
+#define	Q_SIZE		0xf		/* input buffer queue
size */
+#define	Q_SIZE_256	0x0
+#define	Q_SIZE_512	0x1
+#define	Q_SIZE_1K	0x2
+#define	Q_SIZE_2K	0x3
+#define	Q_SIZE_4K	0x4
+#define	Q_SIZE_8K	0x5		/* SSP64 only */
+#define	Q_SIZE_16K	0x6		/* SSP64 only */
+#define	Q_SIZE_32K	0x7		/* SSP64 only */
+#define	Q_SIZE_64K	0x8		/* SSP64 only */
+#define	TAIL_PTR_B	0x10		/* set tail ptr b rd/wr
*/
+#define	EN_IXOFF_SVC	0x20		/* enable full buffer
overload */
+#define	ST_IN_TMR	0x40		/* input char timer
toggle */
+#define	CIN_TMR_MODE	0x80		/* input char timer mode
*/
+
+/* cin_attn_ena register (R/W) */
+#define	ENA_AUTO_BAUD	0x1		/* enable auto baud
event */
+#define	ENA_DCD_CNG	0x2		/* enable DCD change
event */
+#define	ENA_CTS_CNG	0x4		/* enable CTS change
event */
+#define	ENA_DSR_CNG	0x8		/* enable DSR change
event */
+#define	ENA_RI_CNG	0x10		/* enable RI change
event */
+#define	ENA_BREAK_CNG	0x20		/* enable start break
event */
+#define	ENA_LMX_CNG	0x40		/* enable LMX change
event (SSP64) */
+#define	ENA_PAR_ERR	0x80		/* enable parity error
event */
+#define	ENA_FRM_ERR	0x100		/* enable framing error
event */
+#define	ENA_CHAR_LOOKUP	0x200		/* enable character
lookup event */
+#define	ENA_VTIME	0x400		/* enable character
timer event */
+#define	ENA_VMIN	0x800		/* enable recv min chars
event */
+#define	ENA_IXOFF_SVS	0x1000		/* enable input overflow
event */
+#define	ENA_DMA_FAIL	0x2000		/* enable DMA fail event
*/
+#define	ENA_REG_UPDT	0x4000		/* enable register
update event */
+#define	EN_REG_UPDT_EV	0x8000		/* force register update
event */
+
+/* cin_susp_output_lmx (R/W) */
+#define	LMX_NOT_CONN	0x1		/* suspend output on lmx
not conn */
+					/* (SSP64 only) */
+#define	DCD_OFF		0x2		/* suspend output on DCD
lowered */
+#define	CTS_OFF		0x4		/* suspend output on CTS
lowered */
+#define	DSR_OFF		0x8		/* suspend output on DSR
lowered */
+#define	RI_OFF		0x10		/* suspend output on RI
lowered */
+#define	MUX_NOT_CONN	0x20		/* suspend output on MUX
not conn */
+					/* (SSP64 only) */
+#define	LMX_OFF_LINE	0x40		/* suspend output on LMX
offline */
+					/* (SSP64 only) */
+#define	CHAN_DAT_LNBK	0x80		/* suspend output on
chan data line */
+					/* non broken */
+
+/* cin_susp_output_sig (R/W) */
+#define	DCD_ON		0x2		/* suspend output on DCD
raised */
+#define	CTS_ON		0x4		/* suspend output on CTS
raised */
+#define	DSR_ON		0x8		/* suspend output on DSR
raised */
+#define	RI_ON		0x10		/* suspend output on RI
raised */
+#define	CHAN_DAT_LBRK	0x80		/* suspend output on
chan data line */
+
+/* cin_tdm_early (RO) */
+/* LMX online */
+#define	LMX_LINK	0x7ff		/* ICP/LMX link data
bits */
+#define	LMX2_CTRL	0x1000
+#define	ICP2_CTRL	0x2000
+#define	IN_TDM_CTRL	0x4000
+#define	SURP_TDM_CTRL	0x8000
+
+/* cin_tdm_early (RO) */
+/* LMX offline - even channels */
+#define	DATA_BIT	0x1		/* data present */
+#define	LMX_REV		0x1e		/* LMX Rev Number */
+#define	AMI_LINK	0x20		/* LMX-AMI link ok */
+#define	LMX_SPEED	0xc0		/* LMX speed multiplier
*/
+#define	LMX_SPEED_16	0x00		/* 16 ports / 115200 */
+#define	LMX_SPEED_8	0x04		/* 8 ports / 230400 */
+#define	LMX_SPEED_4	0x08		/* 4 ports / 460800 */
+#define	LMX_SPEED_2	0x0c		/* 2 ports / 921600 */
+#define	AMI_CONFIG	0x100		/* LMX-AMI config */
+#define	TDM_MUX		0x200		/* tdm from mux lmx */
+#define	LMX_ONLINE	0x400		/* LMX online (0) */
+#define	SECD_LMX	0x1000		/* secondary LMX */
+#define	SECD_ICP	0x2000		/* secondary ICP */
+#define	IN_TDM_CTRL	0x4000
+#define	SURP_TDM_CTRL	0x8000
+
+/* cin_tdm_early (RO) */
+/* LMX offline - odd channels */
+#define	DATA_BIT	0x1		/* data present */
+#define	PRODUCT_ID	0x1fe		/* product identifier */
+#define	TDM_MUX		0x200		/* tdm from mux lmx */
+#define	LMX_ONLINE	0x400		/* LMX online (0) */
+#define	SECD_LMX	0x1000		/* secondary LMX */
+#define	SECD_ICP	0x2000		/* secondary ICP */
+#define	IN_TDM_CTRL	0x4000
+#define	SURP_TDM_CTRL	0x8000
+
+/* cin_intern_flgs (RO) */
+#define	GOD_FRM_RCV	0x1		/* good framing NULL
received */
+#define	XON_1_RCV	0x2		/* xon-1 char received
*/
+#define	XOFF_1_RCV	0x4		/* xoff-1 char received
*/
+#define	PRV_CH_LNXT	0x8		/* next char is literal
*/
+#define	NO_CMP_ON_ERR	0x10		/* don't compare error
chars */
+#define	DAT_OUT_SUSP	0x20		/* data output suspended
*/
+#define	IN_BUF_OVFL	0x40		/* input buffer overflow
*/
+#define	BANK_B_ACT	0x80		/* bank B active */
+
+/* cin_iband_flow_cntrl (RO) */
+#define	XOFF_RCV	0x1		/* xoff received */
+
+/*
+ * output queue structure - two sets for each channel
+ * note some slight differences between SSP64 and SSP4.
+ *
+ *   this structure is "owned" by cpu until a command is given to
+ *   execute commands (after which it is owned by icp)
+ */
+struct cout_que_struct {
+	u16	q_cmnd_ptr_l;		/* 0x0: queue cmd ptr - lower 16
bits */
+					/* must be left-shifted by 2
when */
+					/* written and right-shifted by
2 */
+					/* when read */
+	u8	q_cmnd_ptr_u;		/* 0x2: queue cmd base - bits
23..16 */
+	u8	q_cmd_save;		/* 0x3: queue command save
register */
+	u16	q_data_ptr_l;		/* 0x4: queue data ptr - low 16
bits */
+	u8	q_data_ptr_u;		/* 0x6: queue data base - bits
23..16 */
+	u8	q_data_q_type;		/* 0x7: queue size/wrap
reg(type) */
+	u16	q_data_count;		/* 0x8: queue data count
register */
+	u8	q_block_count;		/* 0xa: queue block count
register */
+	u8	q_out_state;		/* 0xb: queue output state
register */
+};
+
+/* q_data_q_type (R/W) */
+#define	QSZ_QSZ		0x7		/* circular data q size
*/
+#define	QSZ_256		0x0
+#define	QSZ_512		0x1
+#define	QSZ_1K		0x2
+#define	QSZ_2K		0x3
+#define	QSZ_4K		0x4
+#define	QSZ_8K		0x5		/* SSP-64 only */
+#define	QSZ_16K		0x6		/* SSP-64 only */
+#define	QSZ_32K		0x7		/* SSP-64 only */
+#define	EN_CIRC_Q	0x8		/* enable circular queue
*/
+#define	EN_TX_LOW	0x10		/* enable low water
threshold event */
+#define	EN_TX_EMPTY	0x20		/* enable data count
zero event */
+#define	EN_AUTO_SWTCH	0x40		/* enable queue auto
switch (SSP4) */
+
+/* q_out_state (R/W bits 0-2,7, RO bits 3-6) */
+#define	CMDQ_SZ		0x7		/* command queue size
(SSP64 only) */
+#define	CMDQ_64		0x0
+#define	CMDQ_128	0x1
+#define	CMDQ_256	0x2
+#define	CMDQ_512	0x3
+#define	CMDQ_1K		0x4
+#define	CMDQ_2K		0x5
+#define	CMDQ_4K		0x6
+#define	CMDQ_8K		0x7
+#define	CMDQ_HALT	0x8		/* halt state (SSP64
only) */
+#define	CMDQ_SND	0x10		/* send data state */
+#define	CMDQ_EXEC	0x20		/* execute state (SSP64
only) */
+#define	CMDQ_WAIT	0x40		/* wait state (SSP64
only) */
+#define	CMDQ_CONT_SND	0x80		/* preserve data state
(SSP64 only) */
+
+/*
+ * output register structure - one set for each SSP4 / SSP64 channel
+ */
+struct icp_out_struct {
+	struct cout_que_struct cout_q0;	/* 0x0: queue zero */
+	u16	cout_tdm_0;		/* 0xc: output tdm 0 */
+	u16	cout_tdm_1;		/* 0xe: output tdm 1 */
+	u8	cout_tx_fifo0[4];	/* 0x10: next four chars to tx
*/
+	u8	cout_ses_col_a;		/* 0x14: session a column
counter */
+	u8	cout_ses_cntrl_a;	/* 0x15: session a control
register */
+	u16	cout_ses_char_ctr_a;	/* 0x16: session a character
count */
+	u16	cout_frame_ctr;		/* 0x18: frame counter (SSP4
only) */
+	u8	filler1[6];
+	u8	cout_intnl_flow_ctrl;	/* 0x20: internal flow control
state */
+	u8	cout_intnl_opost;	/* 0x21: internal opost/flow
control */
+	u8	cout_intnl_fifo_ptrs;	/* 0x22: internal fifo pointers
*/
+	u8	cout_intnl_svd_toggls;	/* 0x23: internal request/state
mgmt */
+	u16	cout_timer;		/* 0x24: output timer */
+	u16	cout_flow_count;	/* 0x26: output flow control
counter */
+					/* (SSP-64 only) */
+	u16	cout_cmd_dly_timer;	/* 0x28: command delay timer */
+	u16	cout_events_a;		/* 0x2a: output events register
a */
+	u16	cout_status;		/* 0x2c: output status register
*/
+	u16	cout_events_b;		/* 0x2e: output events register
b */
+
+					/* these dma ptrs are copied
from */
+					/* current cout_que_struct */
+	u16	cout_dma_lower;		/* 0x30: dma address - low 16
bits */
+	u8	cout_dma_upper;		/* 0x32: dma base - upper 8 bits
*/
+	u8	cout_dma_stat_save;	/* 0x33: dma status save */
+	u8	cout_ses_col_b;		/* 0x34: session b column
counter */
+	u8	cout_ses_cntrl_b;	/* 0x35: session b control
register */
+	u16	cout_ses_char_ctr_b;	/* 0x36: session b character
count */
+	u8	filler2[8];
+	struct cout_que_struct cout_q1;	/* 0x40: queue one */
+	u16	cout_intnl_baud_ctr;	/* 0x4c: internal baud counter
*/
+	u16	cout_intnl_state;	/* 0x4e: output character state
*/
+	u8	cout_tx_fifo1[4];	/* 0x50: later four chars to tx
*/
+	u8	cout_ses_col_c;		/* 0x54: session c column
counter */
+	u8	cout_ses_cntrl_c;	/* 0x55: session c control
register */
+	u16	cout_ses_char_ctr_c;	/* 0x56: session c character
count */
+	u8	filler3[8];
+	u16	cout_baud_rate;        	/* 0x60: output baud rate
register */
+	u8	cout_char_fmt;		/* 0x62: output char format
register */
+	u8	cout_flow_config;	/* 0x63: cpu flow control
register */
+	u16	cout_cntrl_sig;		/* 0x64: output control signals
*/
+	u8	cout_lmx_command;	/* 0x66: lmx command register */
+	u8	cout_mux_ctrl;		/* 0x67: mux control */
+	u16	cout_flow_timeout;	/* 0x68: flow control timeout */
+	u16	cout_attn_enbl;		/* 0x6a: output attention mask
*/
+	u8	cout_xoff_1;		/* 0x6c: xoff-1 character */
+	u8	cout_xoff_2;		/* 0x6d: xoff-2 character */
+	u8	cout_xon_1;		/* 0x6e: xon-1 character */
+	u8	cout_xon_2;		/* 0x6f: xon-2 character */
+	u8	cout_tim_scale;		/* 0x70: timer scale register */
+	u8	cout_tim_reg;		/* 0x71: timer register */
+	u8	cout_cpu_req;		/* 0x72: cpu request register */
+	u8	cout_lck_cntrl;		/* 0x73: output lock and control
reg */
+	u8	cout_ses_col_d;		/* 0x74: session d column
counter */
+	u8	cout_ses_cntrl_d;	/* 0x75: session d control
register */
+	u16	cout_ses_char_ctr_d;	/* 0x76: session d character
count */
+	u8	filler4[8];
+};
+
+/* cout_ses_cntrl_[a,b,c,d] (R/W) */
+#define	SCR_EN		0x1		/* session register
enable */
+#define	MOPOST		0x1
+#define	SCR_TABX	0x2		/* tab expansion enable
*/
+#define	MTABX		0x2
+#define	SCR_ONLCR	0x4		/* enable ONLCR (LF to
CR/LF) */
+#define	MONLCR		0x4
+#define	SCR_OCRNL	0x8		/* enable OCRNL (CR to
LF) */
+#define	MOCRNL		0x8
+#define	SCR_ONOCR	0x10		/* enable ONOCR (no CR
at col 0) */
+#define	MONOCR		0x10
+#define	SCR_ONLRET	0x20		/* enable ONLRET (no CR)
*/
+#define	MONLRET		0x20
+
+/* cout_intnl_flow_ctrl (RO) */
+#define	IFLOW_STOP	0x1		/* output stopped */
+#define	IFLOW_TEST	0x2
+#define	IFLOW_QOVRLDL	0x4		/* output overload */
+#define	IFLOW_XOFF	0x8		/* pending xon/xoff */
+#define	IFLOW_TOGGLE	0x10		/* last send xon/xoff
toggle */
+#define	IFLOW_QSENTLAST	0x20
+#define	IFLOW_QSND1PND2	0x40
+#define	IFLOW_QSELQON2	0x80
+
+/* cout_intnl_opost (RO) */
+#define	OPOST_NLCR	0x1		/* NL-CR state */
+#define	OPOST_TAB	0x2		/* tab expansion state
*/
+#define	OPOST_TOGGLE	0x8		/* last send ctrl toggle
*/
+/* next four flow control pausing state (SSP64 only) */
+#define	OPOST_OVRLD	0x10
+#define	OPOST_CTR0	0x20
+#define	OPOST_CTR1	0x40
+#define	OPOST_CTR2	0x80
+
+/* cout_intnl_flow_ptrs (RO) */
+#define	FPTRS_PTR0	0x1
+#define	FPTRS_PTR1	0x2
+#define	FPTRS_OVFL	0x4
+#define	FPTRS_DONE	0x8
+
+/* cout_intnl_svd_toggls (RO) */
+#define	TOGGLS_LHALT	0x1		/* last halt request
toggle (SSP64) */
+#define	TOGGLS_LSTART	0x2		/* last start request
toggle (SSP64) */
+#define	TOGGLS_LSEND	0x4		/* last send data toggle
*/
+#define	TOGGLS_LSWTCH	0x8		/* last switch queue
data toggle */
+#define	TOGGLS_PHASE	0x30		/* state phases */
+#define	TOGGLS_SWTCHP	0x40		/* switch queue pending
*/
+#define	TOGGLS_TIMER	0x80		/* last output timer
toggle */
+
+/* cout_events_[a,b] (RO) */
+#define	EV_CPU_REQ_DN	0x1		/* cpu request
completion event */
+#define	EV_Q0_MRKR	0x2		/* q0 marker event
(SSP64) */
+#define	EV_Q0_HLT_CMD	0x4		/* q0 halt command event
(SSP64) */
+#define	EV_Q1_MRKR	0x8		/* q1 marker event
(SSP64) */
+#define	EV_Q1_HLT_CMD	0x10		/* q1 halt command event
(SSP64) */
+#define	EV_FLC_TMO	0x20		/* flow control timeout
evnt (SSP64) */
+#define	EV_CMD_PRC_INH	0x40		/* command inhibited
event (SSP64) */
+#define	EV_OUT_TMR_EXP	0x80		/* output timer expired
event */
+#define	EV_ILG_REQ	0x100		/* illegal request event
*/
+#define	EV_TX_EMPTY_Q0	0x200		/* q0 empty event */
+#define	EV_TX_LOW_Q0	0x400		/* q0 low threshold
event */
+#define	EV_TX_EMPTY_Q1	0x800		/* q1 empty event */
+#define	EV_TX_LOW_Q1	0x1000		/* q1 low threshold
event */
+#define	EV_REG_UPDT	0x4000		/* register update event
*/
+#define	EV_ATTN_SET	0x8000		/* attention bit set */
+
+/* cout_status (RO) */
+#define	TXSR_Q1_ACT	0x1		/* q1 active */
+#define	TXSR_SND_BRK	0x2		/* sending break */
+#define	TXSR_UNBRK_SEQ	0x4		/* unbreakable sequence
*/
+#define	TXSR_OPOST_INH	0x8		/* output processing
inhibited */
+#define	TXSR_EV_B_ACT	0x10		/* event b active */
+#define	TXSR_CMDPRC_INH	0x20		/* command processing
inhibited */
+#define	TXSR_SND_HALT	0x40		/* Transistion to halt
from send data */
+#define	TXSR_SESSION	0xFF00
+
+/* cout_char_fmt (R/W) */
+#define	TX_CS		0x3		/* data size */
+#define	TX_CS5		0x0
+#define	TX_CS6		0x1
+#define	TX_CS7		0x2
+#define	TX_CS8		0x3
+#define	TX_PARENB	0x4		/* parity enable */
+#define	TX_PARITY	0x18		/* parity */
+#define	TX_PAR_ODD	0x0
+#define	TX_PAR_EVEN	0x8
+#define	TX_PAR_MARK	0x10
+#define	TX_PAR_SPACE	0x18
+#define	TX_2STPB	0x20		/* two stop bits */
+
+/* cout_flow_config (R/W) */
+#define	TX_XOFF_RDN	0x1		/* xoff redundant */
+#define	TX_XON_XOFF_EN	0x2		/* xon/xoff enable */
+#define	TX_XON_DBL	0x4		/* 2-character xon/xoff
*/
+#define	TX_SND_XON	0x8		/* send xon */
+#define	TX_TGL_XON_XOFF	0x10		/* send xon/xoff toggle
*/
+#define	TX_BREAK_ON	0x20		/* break on */
+#define	TX_XTRA_DMA     0x40		/* enable extra dma
(SSP64) */
+#define	TX_SUSP         0x80
+
+/* cout_cntrl_sig (R/W) */
+#define	TX_DTR		0x1		/* DTR signal, standard
state */
+#define	TX_RTS		0x2		/* RTS signal, standard
state */
+#define	TX_CNT_2	0x4
+#define	TX_CNT_3	0x8
+#define	TX_HFC_DTR	0x10		/* DTR signal, overload
state */
+#define	TX_HFC_RTS	0x20		/* RTS signal, overload
state */
+#define	TX_HFC_2	0x40
+#define	TX_HFC_3	0x80
+#define	TX_LED		0x100		/* LED (SSP64) */
+#define	TX_SND_CTRL_TG	0x200		/* send control toggle
*/
+#define	TX_TRGT_LMX_MUX	0x8000		/* target is MUX (SSP64)
*/
+
+/* cout_lmx_command (R/W) */
+#define	TX_INTR_LB	0x1		/* internal loopback */
+#define	TX_XTRN_LB	0x2		/* external loopback */
+#define	TX_LMX_ONLN	0x8		/* LMX online (chan 0 /
SSP64) */
+#define	TX_BRDG_XPRNT	0x10		/* transpar. bridge
(chan 0 / SSP64) */
+#define	TX_LCK_LMX	0x20		/* lock LMX (chan 0 /
SSP64) */
+#define	TX_LMX_CMD_EN	0x40		/* command enable (chan
0 / SSP64) */
+#define	TX_TRGT_MUX	0x80		/* target is MUX (chan 0
/ SSP64) */
+
+/* cout_attn_enbl (R/W) */
+#define	ENA_CPU_REQ_DN	0x1		/* enable cpu request
complete attn */
+#define	ENA_Q0_MRKR	0x2		/* enable q0 marker attn
(SSP64) */
+#define	ENA_Q0_HLT_CMD	0x4		/* enable q0 halt/cmd
attn (SSP64) */
+#define	ENA_Q1_MRKR	0x8		/* enable q1 marker attn
(SSP64) */
+#define	ENA_Q1_HLT_CMD	0x10		/* enable q1 halt/cmd
attn (SSP64) */
+#define	ENA_FLC_TMO	0x20		/* enable flow timeout
attn (SSP64) */
+#define	ENA_CMD_PRC_INH	0x40		/* enable cmd inhib attn
(SSP64) */
+#define	ENA_OUT_TMR_EXP	0x80		/* enable output timer
attn */
+#define	ENA_ILG_REQ	0x100		/* enable illegal
request attn */
+#define	ENA_TX_EMPTY_Q0	0x200		/* enable q0 empty attn
*/
+#define	ENA_TX_LOW_Q0	0x400		/* enable q0 low
threshold attn */
+#define	ENA_TX_EMPTY_Q1	0x800		/* enable q1 empty attn
*/
+#define	ENA_TX_LOW_Q1	0x1000		/* enable q1 low
threshold attn */
+#define	ENA_REG_UPDT	0x4000		/* enable register
update attn */
+#define	EN_REG_UPDT_EV	0x8000		/* force register update
event */
+
+/* cout_cpu_req (R/W) */
+#define	CPU_HLT_REQ	0x1		/* halt request toggle
(SSP64) */
+#define	CPU_START_REQ	0x2		/* start request toggle
(SSP64) */
+#define	CPU_SND_REQ	0x4		/* send data toggle */
+#define	CPU_SWTCH_Q	0x8		/* switch q's toggle */
+#define	CPU_TMR_TGL	0x10		/* output timer toggle
*/
+#define	CPU_GTMR_TGL	0x20		/* global timer toggle
*/
+#define	CPU_PAUSE	0x80		/* pause output */
+
+/* cout_lck_cntrl (R/W) */
+#define	LCK_EVT_A	0x1		/* disable event a
writes */
+#define	LCK_EVT_B	0x2		/* disable event b
writes */
+#define	LCK_FLW_TMR	0x4		/* disable flow control
timer writes */
+#define	LCK_MISC_WR	0x8		/* disable misc register
writes */
+#define	LCK_OUT_TMR	0x10		/* disable output timer
writes */
+#define	LCK_STATUS	0x20		/* disable status writes
*/
+#define	LCK_Q_ACT	0x40		/* disable active q
writes */
+#define	DIS_CMD_PROC	0x80		/* disable cmd
processing (SSP64) */
+
+/*
+ * SSP4 address space definition
+ */
+struct  ssp4_addr_space_s  {
+	struct	icp_in_struct in_chan[4];	/* Input Channel area */
+	struct	icp_out_struct out_chan[4];	/* Output Channel area
*/
+	union	global_regs_u global;		/* global registers */
+	u8	empty_0[0x1000 - 0x400 - sizeof(union global_regs_u)];
+	u8	in_buf[0x1000];			/* Input buffer area */
+	u8	out_buf[0x1000];		/* Output buffer area */
+	u8	tags[0x0400];			/* Input tag area */
+	u8	empty_1[0x4000 - 0x3000 - 0x400];
+};
+
+/*
+ * SSP64 address space definition (input/output registers only)
+ */
+typedef struct megaport *mpaddr_t;
+struct megaport {					/* 16KB */
+	volatile struct icp_in_struct mp_icpi[64];	/* 8KB */
+	volatile struct icp_out_struct mp_icpo[64];	/* 8KB */
+};
+
+/*
+ * SSP64 channel queues
+ */
+#define HWQ4SIZE	4096		/* size of queue - each chnl has
two */
+#define HWQ4RXWRAP	0x04		/* 4096 */
+#define HWQ4TXWRAP	0x0c		/* 4096, circular */
+#define HWQ4HIWAT	HWQ4SIZE * 7 / 8
+#define HWQ4LOWAT	HWQ4SIZE / 8
+#define HWQ4CMDSIZE	0x4		/* 1024 = 4096/4 */
+
+/*
+ * SSP4 channel queues
+ */
+#define HWQ1SIZE	1024		/* size of queue - each chnl has
two */
+#define HWQ1RXWRAP	0x02		/* 1024 */
+#define HWQ1TXWRAP	0x0a		/* 1024, circular */
+#define HWQ1HIWAT	960		/* 1024 - 64 */
+#define HWQ1LOWAT	HWQ1SIZE / 4
+#define HWQ1CMDSIZE	0x03		/* 512 = 2048/4 */
+
+/*
+ * useful macros
+ */
+
+/*
+ * SST board accesses must be little-endian
+ */
+
+#define	SSTRD16(x)	(cpu_to_le16(x))
+#define	SSTWR16(x,y)	(x = cpu_to_le16(y))
+#define	SSTRD32(x)	(cpu_to_le32(x))
+#define	SSTWR32(x,y)	(x = cpu_to_le32(y))
+
+/* return active input queue tail pointer */
+#define GET_TAIL() \
+{ \
+	if (icpi->cin_q_cntrl & TAIL_PTR_B) \
+		return (SSTRD16(icpi->cin_tail_ptr_b)); \
+	else \
+		return (SSTRD16(icpi->cin_tail_ptr_a)); \
+}
+
+/* set input queue tail pointer */
+#define SET_TAIL(val) \
+{ \
+        if (icpi->cin_q_cntrl & TAIL_PTR_B) \
+		SSTWR16(icpi->cin_tail_ptr_a, (val)); \
+	else \
+		SSTWR16(icpi->cin_tail_ptr_b, (val)); \
+	icpi->cin_q_cntrl ^= TAIL_PTR_B; \
+}
+
+/* freeze active input register bank */
+#define FREEZ_BANK(mpc) \
+{ \
+	u16 cie = CHAN_ATTN_SET | SSTRD16(icpi->cin_attn_ena); \
+	int frztimeo = 0; \
+	u8 lcks = 0; \
+	SSTWR16(icpi->cin_attn_ena, 0); \
+	if ((icpi->cin_locks & DIS_BANK_A) == DIS_BANK_A) { \
+		/* Bank A is active (locked) */ \
+		icpb = &icpi->cin_bank_b; \
+		lcks = BANK_B_ACT; \
+	} else  \
+		/* Bank B is active (locked) */ \
+		icpb = &icpi->cin_bank_a; \
+	if (!(SSTRD16(icpb->bank_events) & EV_REG_UPDT)) { \
+		while ((icpi->cin_intern_flgs & 0x80) != lcks) \
+			if (++frztimeo > 8000) break; \
+	}  \
+	mpc->mpc_icpb = icpb; \
+	icpi->cin_locks ^= (DIS_BANK_A | DIS_BANK_B); /* flip banks */ \
+	eqnx_chnl_sync(mpc); \
+	mpc->mpc_cin_events |= SSTRD16(icpb->bank_events); \
+	SSTWR16(icpb->bank_events, 0); \
+	SSTWR16(icpi->cin_attn_ena, cie); \
+}
+
+/* get and return output events for the channel */
+#define TX_EVENTS(x, mpc) \
+{ \
+	volatile u16 csr = SSTRD16(icpo->cout_status); \
+	volatile u16 oie = SSTRD16(icpo->cout_attn_enbl); \
+	SSTWR16(icpo->cout_attn_enbl, 0); \
+	if (csr & TXSR_EV_B_ACT) { \
+		icpo->cout_lck_cntrl ^= (LCK_EVT_A | LCK_EVT_B); \
+		eqnx_chnl_sync(mpc); \
+		(x) |= SSTRD16(icpo->cout_events_b); \
+		SSTWR16(icpo->cout_events_b, 0); \
+	} else { \
+		icpo->cout_lck_cntrl ^= (LCK_EVT_A | LCK_EVT_B); \
+		eqnx_chnl_sync(mpc); \
+		(x) |= SSTRD16(icpo->cout_events_a); \
+		SSTWR16(icpo->cout_events_a, 0); \
+	} \
+	if ((x) & EV_TX_EMPTY_Q0) \
+		oie &= ~ENA_TX_EMPTY_Q0;\
+	if ((x) & EV_TX_LOW_Q0) \
+		oie &= ~ENA_TX_LOW_Q0;\
+	SSTWR16(icpo->cout_attn_enbl, oie); \
+}
+
+/* returns outbound control signals for channel */
+#define GET_CTRL_SIGS(mpc,val) val =
SSTRD16(mpc->mpc_icpo->cout_cntrl_sig);
+
+/* sets outbound control signals for channel */
+#define SET_CTRL_SIGS(mpc, val)
SSTWR16((mpc->mpc_icpo)->cout_cntrl_sig, val);
