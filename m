Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWFVN0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWFVN0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWFVN0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:26:52 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:6032 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1161120AbWFVN0u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:26:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 13/13] Equinox SST driver: miscellaneous routines
Date: Thu, 22 Jun 2006 09:26:49 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B71117@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 13/13] Equinox SST driver: miscellaneous routines
Thread-Index: AcaV/4QABbvbF6tIQ0eaGo4iaD/I/A==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 13: new source file: drivers/char/eqnx/sst_misc.c.  Provides
general
support routines used throughout the driver source.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 sst_misc.c |  758
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 758 insertions(+)

diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/sst_misc.c
linux-2.6.17.eqnx/drivers/char/eqnx/sst_misc.c
--- linux-2.6.17/drivers/char/eqnx/sst_misc.c	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/sst_misc.c	2006-06-20
09:50:17.000000000 -0400
@@ -0,0 +1,758 @@
+/*
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
+ * This driver supports the PCI models of the Equinox / Avocent SST
boards
+ * using SSP-4 and SSP-64 ASIC technology
+ * Boards supported:
+ * SSP-4P
+ * SSP-8P
+ * SSP-16P
+ * SSP-64P
+ * SSP-128P
+ *
+ * Currently maintained by mike straub <michael.straub@avocent.com>
+ */
+
+/*
+ * miscellaneous support routines - used by more than 1 module
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+
+#ifdef CONFIG_MODVERSIONS
+#define MODVERSIONS	1
+#endif
+
+#include <linux/sched.h>
+#include <linux/tty.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+
+#include "icp.h"
+#include "eqnx_def.h"
+#include "eqnx.h"
+
+/**********************************************************************
*****/
+/* module globals and defines
*/
+/**********************************************************************
*****/
+
+/* baud rate table */
+static u32 icpbaud_tbl[] = { 0, 50, 75, 110, 134, 150, 200, 300,
+	600, 1200, 1800, 2400, 4800, 9600, 19200, 38400,
+	57600, 115200, 230400, 460800, 921600
+};
+
+/*
+ * SSP64 table to assign the transmit Q low water mark based on
+ * baud rate. It is based on (#chars per 40 milliseconds/64) plus some
slop.
+ */
+static int ssp64_lowat[] = { 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
2, 4,
+	8, 14, 20, 40, 80
+};
+
+/*
+ * SSP4 table to assign the transmit Q low water mark based on
+ * baud rate. It is based on (#chars per 10 milliseconds/64) plus some
slop.
+ */
+static int ssp4_lowat[] = { 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
2, 2,
+	2, 3, 5, 8, 12
+};
+
+/**********************************************************************
*****/
+/* module function declarations
*/
+/**********************************************************************
*****/
+
+static void megajam(struct mpchan *);
+void eqnx_frame_wait(struct mpchan *, int);
+void eqnx_chnl_sync(struct mpchan *);
+
+/**********************************************************************
*****/
+/* external variable and routines
*/
+/**********************************************************************
*****/
+
+extern struct mpchan *eqnx_chan;
+
+extern int SSTMINOR(unsigned int, unsigned int);
+
+/*
+ * eqnx_modem(d, cmd)
+ *
+ * Set outbound control signals, as device is opened or closed.
+ * Return state of inbound DCD signal.
+ *
+ * d	= device index
+ * cmd	= one of TURNON or TURNOFF
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+int eqnx_modem(int d, int cmd)
+{
+	struct mpchan *mpc = &eqnx_chan[d];
+	volatile struct icp_in_struct *icpi = mpc->mpc_icpi;
+	volatile struct cin_bnk_struct *icpb;
+	u16 cur, mux;
+
+#ifdef	DEBUG_LOCKS
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->pdev, "eqnx_modem: mpd lock !locked\n");
+#endif
+
+	icpb = (icpi->cin_locks & LOCK_A) ? &icpi->cin_bank_b :
+	    &icpi->cin_bank_a;
+	if (!(SSTRD16(icpb->bank_events) & EV_REG_UPDT))
+		/* wait until registers are valid */
+		eqnx_frame_wait(mpc, 2);
+
+	GET_CTRL_SIGS(mpc, cur);
+	mux = TX_TRGT_LMX_MUX;
+
+	switch (cmd) {
+	case TURNON:
+		/* raise outbound signals */
+		mpc->mpc_flags |= MPC_MODEM;
+
+		/* default sigs for HW flow control off */
+		cur |= (TX_DTR | TX_RTS | TX_HFC_DTR | TX_HFC_RTS);
+
+		/*
+		 * if HW flow control enabled, clear overload RTS
signal.
+		 * This causes RTS to be lowered on overload state.
+		 */
+		if (mpc->mpc_param & IOCTRTS)
+			cur &= ~TX_HFC_RTS;
+		if ((mpc->mpc_tty) && (mpc->mpc_tty->termios)) {
+			if (mpc->mpc_tty->termios->c_cflag & CRTSCTS)
+				cur &= ~TX_HFC_RTS;
+		}
+
+		if ((SSTRD16(icpb->bank_signals) & (AMI_CNFG |
LMX_ONLN)) ==
+		    (AMI_CNFG | LMX_ONLN))
+			cur |= mux;
+		else
+			cur &= ~mux;
+
+		/* set control signal ""mux" bits for SST-16 */
+		if (mpc->mpc_mpd->mpd_board_def->number_of_ports == 16)
+			cur |= (TX_HFC_2 | TX_CNT_2);
+
+		cur ^= TX_SND_CTRL_TG;
+		SET_CTRL_SIGS(mpc, cur);
+		break;
+
+	case TURNOFF:
+		/* lower outbound signals */
+		mpc->mpc_flags &= ~MPC_MODEM;
+		cur &= ~(TX_HFC_DTR | TX_HFC_RTS | TX_DTR | TX_RTS);
+		cur ^= TX_SND_CTRL_TG;
+		SET_CTRL_SIGS(mpc, cur);
+		break;
+	}
+
+	/* return current state of DCD */
+	return ((SSTRD16(icpb->bank_signals) & (unsigned int)CIN_DCD) >>
1);
+}
+
+/*
+ * megaparam_sigs(chan, mpc, tiosp)
+ *
+ * Map termio outbound signal parameters into ICP control register
settings.
+ * Helper (inline) routine for megaparam()
+ *
+ * chan	= channel index.
+ * mpc	= pointer to channel structure.
+ * tiosp = pointer to termios structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void inline megaparam_sigs(int chan, struct mpchan *mpc,
+				  volatile struct termios *tiosp)
+{
+	u16 attn;
+
+	/* CLOCAL and carrier detect parameters */
+	attn = SSTRD16(mpc->mpc_icpi->cin_attn_ena);
+	if (tiosp->c_cflag & CLOCAL) {
+		attn &= ~ENA_DCD_CNG;
+		mpc->carr_state = true;
+	} else
+		attn |= ENA_DCD_CNG;
+	SSTWR16(mpc->mpc_icpi->cin_attn_ena, attn);
+
+	/* outbound control signals */
+	if ((tiosp->c_cflag & CBAUD) == 0) {
+		/* B0 */
+		(void)eqnx_modem(chan, TURNOFF);
+		return;
+	} else
+		mpc->carr_state = eqnx_modem(chan, TURNON);
+}
+
+/*
+ * megaparam_hwflow(mpc, tiosp)
+ *
+ * Map termio HW flow parameters into ICP control register settings.
+ * Helper (inline) routine for megaparam()
+ *
+ * mpc	= pointer to channel structure.
+ * tiosp = pointer to termios structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void inline megaparam_hwflow(struct mpchan *mpc,
+				    volatile struct termios *tiosp)
+{
+	volatile struct icp_in_struct *icpi;
+	volatile struct icp_out_struct *icpo;
+	u16 cntrl_sig;
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	icpi = mpc->mpc_icpi;
+	icpo = mpc->mpc_icpo;
+
+	if (mpc->mpc_param & (IOCTCTS | IOCTRTS))
+		tiosp->c_cflag |= CRTSCTS;
+
+	/* set HW flow control settings.  Need to account for rs-422
ports */
+	if ((mpc->mpc_icp->lmx[mpc->mpc_lmxno].lmx_id != LMX_8E_422) &&
+	    (mpc->mpc_icp->lmx[mpc->mpc_lmxno].lmx_id != LMX_PM16_422))
{
+		cntrl_sig = SSTRD16(icpo->cout_cntrl_sig);
+		if (tiosp->c_cflag & CRTSCTS) {
+			icpi->cin_susp_output_lmx |= CTS_OFF;
+			cntrl_sig &= ~TX_HFC_RTS;
+			dev_dbg(mpd->dev, "megaparam: HW flow enabled
for "
+				"device %d\n",
+				SSTMINOR(mpc->mpc_major,
mpc->mpc_minor));
+		} else {
+			icpi->cin_susp_output_lmx &= ~CTS_OFF;
+			cntrl_sig |= TX_HFC_RTS;
+			dev_dbg(mpd->dev, "megaparam: HW flow disabled
for "
+				"device %d\n",
+				SSTMINOR(mpc->mpc_major,
mpc->mpc_minor));
+		}
+		SSTWR16(icpo->cout_cntrl_sig, cntrl_sig);
+	}
+}
+
+/*
+ * megaparam_swflow(mpc, tiosp)
+ *
+ * Map termio SW flow parameters into ICP control register settings.
+ * Helper (inline) routine for megaparam()
+ *
+ * mpc	= pointer to channel structure.
+ * tiosp = pointer to termios structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void inline megaparam_swflow(struct mpchan *mpc,
+				    volatile struct termios *tiosp)
+{
+	volatile struct icp_in_struct *icpi;
+	volatile struct icp_out_struct *icpo;
+	unsigned short char_ctrl;
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	icpi = mpc->mpc_icpi;
+	icpo = mpc->mpc_icpo;
+
+	/* set input inband flow control settings */
+	if ((tiosp->c_iflag & IXON) || (mpc->mpc_param & IXONSET)) {
+		char_ctrl = SSTRD16(icpi->cin_char_cntrl);
+		char_ctrl |= (EN_XON | EN_XOFF);
+		char_ctrl &= ~EN_DBL_FLW;
+		if (mpc->mpc_param & IOCTXON)
+			char_ctrl &= ~EN_DNS_FLW;
+		else
+			char_ctrl |= EN_DNS_FLW;
+		if ((tiosp->c_iflag & IXANY) && (!(mpc->mpc_param &
IXANYIG)))
+			char_ctrl |= EN_IXANY;
+		else
+			char_ctrl &= ~EN_IXANY;
+		eqnx_chnl_sync(mpc);
+		mpc->mpc_stop = tiosp->c_cc[VSTOP];
+		mpc->mpc_start = tiosp->c_cc[VSTART];
+		icpi->cin_xoff_1 = mpc->mpc_stop;
+		icpi->cin_xon_1 = mpc->mpc_start;
+		SSTWR16(icpi->cin_char_cntrl, char_ctrl);
+		/* clear lock bit and enable inband flow control */
+		icpi->cin_locks &= ~DIS_IBAND_FLW;
+		dev_dbg(mpd->dev, "megaparam: IXON enabled for device
%d\n",
+			SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+	} else {
+		SSTWR16(icpi->cin_char_cntrl,
+			(SSTRD16(icpi->cin_char_cntrl) & ~EN_DNS_FLW));
+		icpi->cin_locks |= DIS_IBAND_FLW;
+		eqnx_chnl_sync(mpc);
+		icpi->cin_iband_flow_cntrl = 0;
+		dev_dbg(mpd->dev, "megaparam: IXON disabled for device
%d\n",
+			SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+	}
+
+	/* set output inband flow control settings */
+	if (tiosp->c_iflag & IXOFF) {
+		mpc->mpc_stop = tiosp->c_cc[VSTOP];
+		mpc->mpc_start = tiosp->c_cc[VSTART];
+		icpo->cout_xoff_1 = mpc->mpc_stop;
+		icpo->cout_xon_1 = mpc->mpc_start;
+		icpo->cout_flow_config &= ~TX_XON_DBL;
+		icpo->cout_flow_config |= TX_XON_XOFF_EN;
+		dev_dbg(mpd->dev, "megaparam: IXOFF enabled for device
%d\n",
+			SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+	} else {
+		if ((icpo->cout_flow_config & TX_XON_XOFF_EN) &&
+		    (icpi->cin_intern_flgs & IN_BUF_OVFL))
+			megajam(mpc);
+		icpo->cout_flow_config &= ~(TX_XON_XOFF_EN |
TX_XON_DBL);
+		dev_dbg(mpd->dev, "megaparam: IXOFF disabled for device
%d\n",
+			SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+	}
+}
+
+/*
+ * megaparam_icpbaud(mpc, val)
+ *
+ * Map baud rate parameters into ICP control register settings.
+ * Helper (inline) routine for megaparam()
+ *
+ * mpc	= pointer to channel structure.
+ * val	= termios setting for baud.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static u16 inline megaparam_icpbaud(struct mpchan *mpc, int val)
+{
+	int baud, maxbaud;
+
+	if (val == 0)
+		return 0;
+
+	switch (mpc->mpc_icp->lmx[mpc->mpc_lmxno].lmx_speed) {
+	case 0:
+		maxbaud = 115200;
+		break;
+	case 1:
+		maxbaud = 230400;
+		break;
+	case 2:
+		maxbaud = 460800;
+		break;
+	case 3:
+		maxbaud = 921600;
+		break;
+	default:
+		maxbaud = 115200;
+		break;
+	}
+
+	baud = icpbaud_tbl[val];
+	if (baud == (2 * maxbaud / 3))
+		return (0x7ffe);
+
+	return (~(2 * maxbaud / baud - 2) & 0x7fff) | 1;
+}
+
+/*
+ * megaparam_speed(mpc, tiosp)
+ *
+ * Map termio baud rate parameters into ICP control register settings.
+ * Helper (inline) routine for megaparam()
+ *
+ * mpc	= pointer to channel structure.
+ * tiosp = pointer to termios structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void inline megaparam_speed(struct mpchan *mpc,
+				   volatile struct termios *tiosp)
+{
+	volatile struct icp_in_struct *icpi;
+	volatile struct icp_out_struct *icpo;
+	volatile struct cout_que_struct *icpq;
+	u32 speed;
+	u16 d;
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	icpi = mpc->mpc_icpi;
+	icpo = mpc->mpc_icpo;
+
+	speed = tiosp->c_cflag & CBAUD;
+
+	dev_dbg(mpd->dev, "megaparam: speed for device %d is %d\n",
+		SSTMINOR(mpc->mpc_major, mpc->mpc_minor), speed);
+
+	if (speed & CBAUDEX) {
+		speed &= ~CBAUDEX;
+		if ((speed < 1) || (speed > 4))
+			tiosp->c_cflag &= ~CBAUDEX;
+		else
+			speed += 15;
+	}
+	if ((speed >= 0) && (speed <= (B38400 + 4))) {
+		d = megaparam_icpbaud(mpc, speed);
+		if (d != SSTRD16(icpi->cin_baud))
+			SSTWR16(icpi->cin_baud, d);
+		if (d != SSTRD16(icpo->cout_baud_rate)) {
+			SSTWR16(icpo->cout_baud_rate, d);
+			icpq = &icpo->cout_q0;
+			eqnx_chnl_sync(mpc);
+			if (mpc->mpc_mpd->mpd_board_def->asic == SSP64)
+				/* SSP64 */
+				icpq->q_block_count =
ssp64_lowat[speed];
+			else
+				/* SSP4 */
+				icpq->q_block_count = ssp4_lowat[speed];
+
+			icpo->cout_intnl_baud_ctr = 0;
+			eqnx_chnl_sync(mpc);
+			if (icpo->cout_intnl_baud_ctr)
+				icpo->cout_intnl_baud_ctr = 0;
+		}
+		if (d >= 0x7ffe)
+			icpo->cout_flow_config |= TX_XTRA_DMA;
+		else
+			icpo->cout_flow_config &= ~TX_XTRA_DMA;
+	}
+}
+
+/*
+ * megaparam_databits(mpc, tiosp)
+ *
+ * Map termio datasize parameters into ICP control register settings.
+ * Helper (inline) routine for megaparam()
+ *
+ * mpc	= pointer to channel structure.
+ * tiosp = pointer to termios structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void inline megaparam_databits(struct mpchan *mpc,
+				      volatile struct termios *tiosp)
+{
+	volatile struct icp_in_struct *icpi;
+	volatile struct icp_out_struct *icpo;
+	u16 d, e;
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	icpi = mpc->mpc_icpi;
+	icpo = mpc->mpc_icpo;
+
+	e = SSTRD16(icpi->cin_char_cntrl) & ~EN_ISTRIP;
+	e &= ~CS_MASK;
+	switch (tiosp->c_cflag & CSIZE) {
+	case CS5:
+		d = CS_5;
+		break;
+
+	case CS6:
+		d = CS_6;
+		break;
+
+	case CS7:
+		d = CS_7;
+		break;
+
+	default:
+		/* CS8 */
+		d = CS_8;
+		if (tiosp->c_iflag & ISTRIP)
+			e |= EN_ISTRIP;
+	}
+
+	SSTWR16(icpi->cin_char_cntrl, (d | e));
+	e = icpo->cout_char_fmt;
+	e &= ~TX_CS;
+	icpo->cout_char_fmt = (d | e);
+
+	dev_dbg(mpd->dev, "megaparam: databits for device %d is %d\n",
+		SSTMINOR(mpc->mpc_major, mpc->mpc_minor), d);
+}
+
+/*
+ * megaparam_parity(mpc, tiosp)
+ *
+ * Map termio parity parameters into ICP control register settings.
+ * Helper (inline) routine for megaparam()
+ *
+ * mpc	= pointer to channel structure.
+ * tiosp = pointer to termios structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void inline megaparam_parity(struct mpchan *mpc,
+				    volatile struct termios *tiosp)
+{
+	volatile struct icp_in_struct *icpi;
+	volatile struct icp_out_struct *icpo;
+	unsigned char oldreg;
+	int ii;
+	u16 d = 0, e, char_cntrl, attn_ena;
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	icpi = mpc->mpc_icpi;
+	icpo = mpc->mpc_icpo;
+
+	if (tiosp->c_cflag & PARENB) {
+		d |= PARITY_ON;
+		if (!(tiosp->c_cflag & PARODD))
+			d |= PARITY_EVEN;
+	}
+
+	char_cntrl = SSTRD16(icpi->cin_char_cntrl);
+	char_cntrl &= ~(PARITY_ON | PARITY_MASK);
+	oldreg = icpo->cout_cpu_req;
+	icpo->cout_cpu_req |= TX_SUSP;
+	eqnx_chnl_sync(mpc);
+	char_cntrl |= d;
+	e = icpo->cout_char_fmt;
+	e &= ~(TX_PARENB | TX_PARITY);
+	icpo->cout_char_fmt = (d | e);
+	if (!(oldreg & TX_SUSP))
+		icpo->cout_cpu_req &= ~TX_SUSP;
+
+	/* always ignore breaks - handled in rxint_break */
+	char_cntrl |= IGN_BRK_NULL;
+
+	/* prepare for input break/parity processing */
+	char_cntrl &= ~(IGN_BAD_CHAR | EN_CHAR_LOOKUP | NO_CMP_ERR |
EN_LITNXT);
+	attn_ena = SSTRD16(icpi->cin_attn_ena);
+	attn_ena &= ~(ENA_BREAK_CNG | ENA_PAR_ERR | ENA_FRM_ERR |
+		      ENA_CHAR_LOOKUP);
+
+	/* prepare for break processing */
+	if (!(tiosp->c_iflag & IGNBRK))
+		attn_ena |= (ENA_FRM_ERR | ENA_BREAK_CNG);
+
+	/* clear lookup table */
+	for (ii = 0; ii < 32; ii++)
+		icpi->cin_lookup_tbl[ii] = 0;
+
+	/* input parity processing */
+	if ((tiosp->c_cflag & PARENB) && (tiosp->c_iflag & INPCK)) {
+		dev_dbg(mpd->dev, "megaparam: parity enable for device
%d\n",
+			SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+		if (tiosp->c_iflag & IGNPAR)
+			/* discard chars with parity/framing errors */
+			char_cntrl |= IGN_BAD_CHAR;
+		else {
+			/* hardware must maintain and tag err'd chars */
+			attn_ena |= (ENA_PAR_ERR | ENA_FRM_ERR);
+			if ((tiosp->c_iflag & PARMRK) &&
+			    !(tiosp->c_iflag & ISTRIP)) {
+				/* put 0xff in lookup table */
+				icpi->cin_lookup_tbl[0x1f] |= 0x80;
+				char_cntrl |= EN_CHAR_LOOKUP;
+				attn_ena |= ENA_CHAR_LOOKUP;
+			}
+		}
+	}
+
+	SSTWR16(icpi->cin_char_cntrl, char_cntrl);
+	SSTWR16(icpi->cin_attn_ena, attn_ena);
+
+	/* output stop bits */
+	if (tiosp->c_cflag & CSTOPB)
+		icpo->cout_char_fmt |= TX_2STPB;
+	else
+		icpo->cout_char_fmt &= ~TX_2STPB;
+
+	icpo->cout_ses_cntrl_a = 0;
+
+	if (tiosp->c_cflag & CREAD)
+		/* make sure dma's to dram are enabled */
+		icpi->cin_locks &= ~DIS_DMA_WR;
+	else
+		/* disable unnecessary dma's to dram */
+		icpi->cin_locks |= DIS_DMA_WR;
+}
+
+/*
+ * eqnx_megaparam(chan)
+ *
+ * Map termio parameters into ICP control register settings.
+ *
+ * chan	= device index
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+void eqnx_megaparam(int chan)
+{
+	struct mpchan *mpc;
+	volatile struct termios *tiosp;
+	struct mpdev *mpd;
+
+	mpc = &eqnx_chan[chan];
+	if (mpc->mpc_tty == (struct tty_struct *)NULL)
+		return;
+	tiosp = mpc->mpc_tty->termios;
+	if (tiosp == NULL)
+		return;
+
+	mpd = mpc->mpc_mpd;
+
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "megaparam: mpd lock !locked\n");
+#endif
+
+	if (mpc->mpc_param & IOCTLCK)
+		return;
+
+	megaparam_sigs(chan, mpc, tiosp);
+	megaparam_hwflow(mpc, tiosp);
+	megaparam_swflow(mpc, tiosp);
+	megaparam_speed(mpc, tiosp);
+	megaparam_databits(mpc, tiosp);
+	megaparam_parity(mpc, tiosp);
+}
+
+/*
+ * megajam(mpc)
+ *
+ * Jam an xon character into the output queue.  If the transmitter
+ * is idle, it's easy: just place the character in the output
+ * queue and start output.  In the more difficult case,
+ * we must stop the transmitter, push the character into the
+ * output next byte" register, and then restart normal output.
+ *
+ * mpc	= pointer to channel structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void megajam(struct mpchan *mpc)
+{
+	volatile struct icp_out_struct *icpo = mpc->mpc_icpo;
+	int ii = 0;
+
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpc->mpc_mpd->dev, "megajam: mpd lock
!locked\n");
+#endif
+
+	while (((icpo->cout_flow_config & TX_TGL_XON_XOFF) !=
+		(icpo->cout_intnl_flow_ctrl & IFLOW_TOGGLE)) &&
+	       (++ii < 100000)) ;
+
+	ii = 0;
+	while ((icpo->cout_intnl_flow_ctrl & IFLOW_XOFF) && (++ii <
100000)) ;
+
+	if (icpo->cout_intnl_flow_ctrl & IFLOW_XOFF) {
+		dev_warn(mpc->mpc_mpd->dev, "megajam: send flow char ack
"
+			 "missing.\n");
+		return;
+	}
+
+	icpo->cout_flow_config |= TX_SND_XON;
+	icpo->cout_flow_config ^= TX_TGL_XON_XOFF;
+}
+
+/*
+ * eqnx_chnl_sync(mpc)
+ *
+ * Wait until changes to channel settings have been taken.
+ *
+ * mpc	= pointer to channel structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+void eqnx_chnl_sync(struct mpchan *mpc)
+{
+	volatile union global_regs_u *icpg;
+	int i = 0;
+	volatile unsigned char *chan_ptr;
+	struct icp_struct *icp;
+#ifdef	DEBUG_LOCKS
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "eqnx_chnl_sync: mpd lock !locked\n");
+#endif
+
+	if (mpc->mpc_mpd->mpd_board_def->asic == SSP64) {
+		/* SSP64 */
+		icpg = (volatile union global_regs_u *)mpc->mpc_icpo;
+		chan_ptr = &(icpg->ssp.gicp_chan);
+	} else {
+		/* SSP4 */
+		icp = mpc->mpc_icp;
+		icpg = (volatile union global_regs_u *)
+		    ((unsigned long)icp->icp_regs_start + 0x400);
+		chan_ptr = &(icpg->ssp4.chan_ctr);
+	}
+
+	while (*chan_ptr == mpc->mpc_chan) {
+		if (++i > 9000)
+			break;
+	}
+}
+
+/*
+ * eqnx_frame_wait(mpc, count)
+ *
+ * Wait at least "count" frames to elapse.
+ *
+ * mpc	= pointer to channel structure.
+ * count = number of frames to wait.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+void eqnx_frame_wait(struct mpchan *mpc, int count)
+{
+	volatile union global_regs_u *icpg;
+	volatile struct icp_out_struct *icpo;
+	u16 final, original;
+	volatile u16 *frame_ptr, curval;
+	int x, wrap;
+
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpc->mpc_mpd->dev, "eqnx_frame_wait: mpd lock "
+			"!locked\n");
+#endif
+
+	if (mpc->mpc_mpd->mpd_board_def->asic == SSP64) {
+		/* SSP64 */
+		icpg = (volatile union global_regs_u *)(mpc->mpc_icpo);
+		frame_ptr = &icpg->ssp.gicp_frame_ctr;
+	} else {
+		/* SSP4 */
+		icpg = (volatile union global_regs_u *)
+		    ((unsigned long)(mpc->mpc_icpi) + 0x400);
+		icpo = (volatile struct icp_out_struct *)
+		    ((unsigned long)(mpc->mpc_icp->icp_regs_start) +
0x200);
+		frame_ptr = &(icpo->cout_frame_ctr);
+	}
+
+	original = SSTRD16(*frame_ptr);
+	final = original + count;
+	wrap = (final > original) ? false : true;
+	for (x = 0; x < 0x100000; x++) {
+		curval = SSTRD16(*frame_ptr);
+		if (curval > final) {
+			if (!wrap)
+				break;
+			if (curval < original)
+				break;
+		}
+	}
+
+	if (x > 0x100000)
+		dev_warn(mpc->mpc_mpd->dev, "eqnx_frame_wait:
timeout\n");
+}
