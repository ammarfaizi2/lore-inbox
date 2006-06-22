Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbWFVNX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWFVNX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWFVNX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:23:57 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:143 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1161115AbWFVNXy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:23:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 11/13] Equinox SST driver: timer / event handling routines
Date: Thu, 22 Jun 2006 09:23:53 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B71114@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 11/13] Equinox SST driver: timer / event handling routines
Thread-Index: AcaV/xsKE3DBh7wvQdKnJ7b8aLqFLw==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 11: new source file: drivers/char/eqnx/sst_poll.c.  This driver
does not
use interrupts.  Instead, the driver will periodically "poll" the boards
to
determine if any work is required.  This is used to do input processing,

change of status processing, etc.  Global registers indicate what, if
any,
work is required for each channel.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 sst_poll.c | 1941
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1941 insertions(+)

diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/sst_poll.c
linux-2.6.17.eqnx/drivers/char/eqnx/sst_poll.c
--- linux-2.6.17/drivers/char/eqnx/sst_poll.c	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/sst_poll.c	2006-06-20
09:50:13.000000000 -0400
@@ -0,0 +1,1941 @@
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
+ * sst_poll and support routines.  These routines run off the kernel 
+ * timer logic.  The board does not use interrupt, so the timer
routines
+ * are responsible for responding to events, including re-starting the
+ * transmitter and pulling data from the receiver fifo.
+ *
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
+#include <linux/timer.h>
+#include <linux/wait.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
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
+/* used to delay processing in sstpoll */
+static u32 poll_cnt = 0;
+
+/* array used to access fifos */
+static u8 fifo_mask[] = { 0x0, 0x3, 0xf, 0x3f, 0xff, 0x3, 0xf, 0x3f,
0xff };
+
+static struct timer_list lmx_wait_timer;
+
+/* suppress ring config messages when true */
+int eqnx_quiet_mode = 0;
+
+/**********************************************************************
*****/
+/* module function declarations
*/
+/**********************************************************************
*****/
+
+static void txint_event(struct mpchan *);
+static void megainput(struct mpchan *, unsigned long);
+static void rxint_cs_change(struct mpchan *);
+static void rxint_break(struct mpchan *, unsigned long);
+static void mega_rdv_delta_wait(unsigned long);
+static void mega_rdv_delta(struct icp_struct *, struct mpchan *, int);
+static int mega_rng_delta(struct icp_struct *, int, int);
+static int frame_ctr_reliable(struct mpchan *);
+
+/**********************************************************************
*****/
+/* external variable and routines
*/
+/**********************************************************************
*****/
+
+extern int eqnx_nssps;
+extern struct mpchan *eqnx_chan;
+extern struct mpdev eqnx_dev[MAXSSP];
+extern struct datascope eqnx_dscope[2];
+extern int eqnx_write_wakeup_deferred;
+extern struct timer_list eqnx_timer;
+extern int eqnx_quiet_mode;
+
+extern void eqnx_chnl_sync(struct mpchan *);
+extern void eqnx_frame_wait(struct mpchan *, int);
+extern void eqnx_write_SSP4(struct mpchan *, int);
+
+/*
+ * sstpoll_SSP64(mpd, mpc, iindex)
+ *
+ * Board polling routine for SSP64 boards.
+ * Helper (inline) routine for sst_poll() for each ICP
+ *
+ * mpd	= pointer to board structure.
+ * mpc	= pointer to base channel structure.
+ * iindex = ICP index.
+ */
+static void inline sstpoll_SSP64(struct mpdev *mpd, struct mpchan *mpc,
+				 int iindex)
+{
+	volatile union global_regs_u *icpg;
+	volatile struct icp_out_struct *icpo;
+	volatile struct icp_in_struct *icpi;
+	volatile struct cin_bnk_struct *icpb;
+	volatile struct cout_que_struct *icpq;
+	struct icp_struct *icp;
+	u8 g_attn;
+	u32 rbits0, xbits0, rbits1, xbits1, xbits, rbits;
+	unsigned long flags;
+	int port, nports, wakeup;
+	u16 attn_ena, attn_enbl;
+
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+	icp = &mpd->icp[iindex];
+
+	icpg = (volatile union global_regs_u *)
+	    ((unsigned long)mpd->icp[iindex].icp_regs_start + 0x2000);
+	g_attn = icpg->ssp.gicp_attn;
+
+	/* if ring is coming up, give it time to settle (ATMEL fix) */
+	if (icp->icp_rng_state == RNG_WAIT) {
+		/* if we lose ring clock - start over */
+		if (g_attn & RNG_FAIL) {
+			icp->icp_rng_wait = 0;
+			icp->icp_rng_last = 0;
+		} else if (icp->icp_rng_wait++ < 20) {
+			/* else wait 800 milliseconds */
+			spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+			return;
+		}
+		icp->icp_rng_wait = 0;
+	}
+
+	/* if ring check state, verify that its ok (ATMEL fix) */
+	if (icp->icp_rng_state == RNG_CHK) {
+		/* if we lose ring clock, start over */
+		if (g_attn & RNG_FAIL) {
+			icp->icp_rng_wait = 0;
+			icp->icp_rng_last = 0;
+		} else {
+			icp->icp_rng_svcreq = mega_rng_delta(icp,
RNG_CHK,
+
mpd->mpd_nchan);
+			spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+			return;
+		}
+	}
+
+	/* check for ring state change: from ok to down */
+	if ((g_attn & RNG_FAIL) && !icp->icp_rng_last) {
+		icp->icp_rng_svcreq = mega_rng_delta(icp, RNG_BAD,
+						     mpd->mpd_nchan);
+		icp->icp_rng_last = g_attn & RNG_FAIL;
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		return;
+	}
+
+	/* check for ring state change: from down to ok */
+	if (!(g_attn & RNG_FAIL) && icp->icp_rng_last) {
+		/* let ring clock stabilize (ATMTL) */
+		if (icp->icp_rng_state == RNG_BAD) {
+			icp->icp_rng_state = RNG_WAIT;
+			spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+			return;
+		}
+
+		icp->icp_rng_last = g_attn & RNG_FAIL;
+		if (icpg->ssp.gicp_initiate & RNG_CLK_ON)
+			icp->icp_rng_svcreq = mega_rng_delta(icp,
RNG_GOOD,
+
mpd->mpd_nchan);
+
+		if (icp->icp_rng_state == RNG_BAD) {
+			icp->icp_rng_state = RNG_WAIT;
+			icp->icp_rng_wait = 0;
+		}
+
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		return;
+	}
+
+	if (icp->icp_rng_svcreq)
+		icp->icp_rng_svcreq = mega_rng_delta(icp,
icp->icp_rng_svcreq,
+						     mpd->mpd_nchan);
+
+	if (icp->icp_rng_state != RNG_GOOD) {
+		/* block clear when read */
+		icpg->ssp.gicp_initiate |= DISABLE_ATTN_CLR;
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		return;
+	}
+
+	/* all done if attention bits are off */
+	if (!(g_attn & (GATTN_RX | GATTN_TX))) {
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		return;
+	}
+
+	/* allow clear when read */
+	icpg->ssp.gicp_initiate &= ~DISABLE_ATTN_CLR;
+
+	/* collect input attention bits */
+	if (g_attn & GATTN_RX) {
+		rbits0 = SSTRD32(*(u32 *) & icpg->ssp.gicp_rcv_attn[0]);
+		rbits1 = SSTRD32(*(u32 *) & icpg->ssp.gicp_rcv_attn[4]);
+	} else
+		rbits0 = rbits1 = 0;
+
+	/* collect output attention bits */
+	if (g_attn & GATTN_TX) {
+		xbits0 = SSTRD32(*(u32 *) &
icpg->ssp.gicp_xmit_attn[0]);
+		xbits1 = SSTRD32(*(u32 *) &
icpg->ssp.gicp_xmit_attn[4]);
+	} else
+		xbits0 = xbits1 = 0;
+
+	icpg->ssp.gicp_initiate |= DISABLE_ATTN_CLR;
+
+	xbits = xbits0;
+	rbits = rbits0;
+	if (mpd->mpd_nchan < MAXCHNL_ICP)
+		nports = mpd->mpd_nchan;
+	else
+		nports = MAXCHNL_ICP;
+
+	/* loop for each channel */
+	for (port = 0; port < nports; port++, mpc++) {
+		if (xbits & 1) {
+			icpo = mpc->mpc_icpo;
+			icpq = &icpo->cout_q0;
+			TX_EVENTS(mpc->mpc_cout_events, mpc);
+
+			wakeup = 0;
+			if (mpc->mpc_cout_events & EV_TX_EMPTY_Q0) {
+				/* transmit buffer empty */
+				if (SSTRD16(icpq->q_data_count)) {
+					attn_enbl =
+
SSTRD16(icpo->cout_attn_enbl);
+					attn_enbl |= (ENA_TX_EMPTY_Q0);
+					SSTWR16(icpo->cout_attn_enbl,
+						attn_enbl);
+				} else {
+					mpc->mpc_flags &= ~MPC_BUSY;
+					txint_event(mpc);
+					wakeup =
eqnx_write_wakeup_deferred;
+				}
+				mpc->mpc_cout_events &= ~EV_TX_EMPTY_Q0;
+			} else if (mpc->mpc_cout_events & EV_TX_LOW_Q0)
{
+				/* transmit buffer low */
+				if (SSTRD16(icpq->q_data_count) >=
+				    (icpq->q_block_count * 64)) {
+					attn_enbl =
+
SSTRD16(icpo->cout_attn_enbl);
+					attn_enbl |= (ENA_TX_LOW_Q0);
+					SSTWR16(icpo->cout_attn_enbl,
+						attn_enbl);
+				} else {
+					txint_event(mpc);
+					wakeup =
eqnx_write_wakeup_deferred;
+				}
+				mpc->mpc_cout_events &= ~EV_TX_LOW_Q0;
+			}
+
+			if (wakeup) {
+				eqnx_write_wakeup_deferred = 0;
+
mpc->mpc_tty->ldisc.write_wakeup(mpc->mpc_tty);
+			}
+
+			if (mpc->mpc_cout_events & EV_OUT_TMR_EXP)
+				mpc->mpc_cout_events &= ~EV_OUT_TMR_EXP;
+		}
+
+		if (rbits & 1) {
+			icpi = mpc->mpc_icpi;
+			icpb = (icpi->cin_locks & LOCK_A) ?
&icpi->cin_bank_b :
+			    &icpi->cin_bank_a;
+			FREEZ_BANK(mpc);
+
+			if (!(icpg->ssp.gicp_initiate & RNG_CLK_ON))
+				mpc->mpc_cin_events &= ~EV_LMX_CNG;
+			if ((!(SSTRD16(icpb->bank_signals) &
LMX_PRESENT)) &&
+			    (icp->lmx[mpc->mpc_lmxno].lmx_active !=
DEV_GOOD))
+				mpc->mpc_cin_events &= ~EV_LMX_CNG;
+			if (SSTRD16(icpb->bank_signals) & LMX_ONLN)
+				mpc->mpc_cin_events &= ~EV_LMX_CNG;
+			if (!(port % 16) && (mpc->mpc_cin_events &
+					     EV_LMX_CNG) &&
+			    (SSTRD16(icpi->cin_attn_ena) & EV_LMX_CNG))
{
+				/* LMX change */
+				mpc->mpc_cin_events &= ~EV_LMX_CNG;
+				if
(!(icp->lmx[mpc->mpc_lmxno].lmx_bridge)) {
+					/* local panel */
+					icpo = mpc->mpc_icpo;
+					icpo->cout_lmx_command =
TX_LMX_CMD_EN;
+					eqnx_frame_wait(mpc, 6);
+					icpo->cout_lmx_command = 0;
+					mega_rng_delta(icp, RNG_FAIL,
+						       mpd->mpd_nchan);
+				} else {
+					/* bridge */
+					if ((SSTRD16(icpb->bank_signals)
&
+					     0xe0) == LMX_PRESENT) {
+						/* bridge offline */
+						eqnx_frame_wait(mpc, 2);
+						mega_rng_delta(icp,
RNG_FAIL,
+
mpd->mpd_nchan);
+					} else {
+						if (icp->icp_rng_last &
+						    RNG_FAIL)
+
mega_rdv_delta(icp, mpc,
+
RNG_BAD);
+						else
+
mega_rdv_delta(icp, mpc,
+
RNG_GOOD);
+					}
+				}
+			} else
+				mpc->mpc_cin_events &= ~EV_LMX_CNG;
+
+			if (mpc->mpc_cin_events & EV_REG_UPDT) {
+				/* register update */
+				mpc->mpc_cin_events &= ~EV_REG_UPDT;
+				attn_ena = SSTRD16(icpi->cin_attn_ena);
+				attn_ena &= ~ENA_REG_UPDT;
+				SSTWR16(icpi->cin_attn_ena, attn_ena);
+			}
+			if (mpc->mpc_cin_events & (EV_BREAK_CNG)) {
+				/* break event */
+				rxint_break(mpc, flags);
+				mpc->mpc_cin_events &= ~EV_BREAK_CNG;
+			}
+			if (mpc->mpc_cin_events & EV_OVERRUN)
+				/* overrun event */
+				mpc->mpc_cin_events &= ~EV_OVERRUN;
+			if (mpc->mpc_cin_events & EV_VMIN) {
+				/* input data event */
+				megainput(mpc, flags);
+				mpc->mpc_cin_events &= ~EV_VMIN;
+			}
+			if (mpc->mpc_cin_events & EV_VTIME)
+				/* input timeout event */
+				mpc->mpc_cin_events &= ~EV_VTIME;
+			if (mpc->mpc_cin_events & EV_DCD_CNG) {
+				/* DCD signal change event */
+				rxint_cs_change(mpc);
+				mpc->mpc_cin_events &= ~EV_DCD_CNG;
+			}
+		}
+
+		if (!rbits && !xbits) {
+			if (port <= 31) {
+				mpc += (31 - port);
+				port = 31;
+			} else
+				break;
+		}
+		if (port == 31) {
+			rbits = rbits1;
+			xbits = xbits1;
+			if (!rbits && !xbits)
+				break;
+		} else {
+			rbits = rbits >> 1;
+			xbits = xbits >> 1;
+		}
+	}
+
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+	return;
+}
+
+/*
+ * sstpoll_SSP4(mpd, mpc, iindex)
+ *
+ * Board polling routine for SSP4 boards.
+ * Helper (inline) routine for sst_poll() for each ICP
+ *
+ * mpd	= pointer to board structure.
+ * mpc	= pointer to base channel structure.
+ * iindex = ICP index.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void inline sstpoll_SSP4(struct mpdev *mpd, struct mpchan *mpc,
+				int iindex)
+{
+	volatile union global_regs_u *icp_glo;
+	volatile struct icp_out_struct *icpo;
+	volatile struct icp_in_struct *icpi;
+	volatile struct cin_bnk_struct *icpb;
+	volatile struct cout_que_struct *icpq;
+	struct icp_struct *icp;
+	u8 g_attn;
+	u8 rxtx_work;
+	unsigned long flags;
+	int ii, wakeup;
+	u16 attn_ena, attn_enbl;
+
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+	icp = &mpd->icp[iindex];
+
+	icp_glo = (volatile union global_regs_u *)
+	    ((unsigned long)mpd->icp[iindex].icp_regs_start + 0x400);
+
+	g_attn = icp_glo->ssp4.attn_pend;
+	if (g_attn & 0x01 || icp->icp_poll_defer) {
+		icp->icp_poll_defer = 0;
+		/* allow clear when read */
+		icp_glo->ssp4.bus_cntrl &= ~0x10;
+		rxtx_work = icp_glo->ssp4.chan_attn;
+		/* block clear when read */
+		icp_glo->ssp4.bus_cntrl |= 0x10;
+
+		/* loop for all ports */
+		for (ii = 0; ii < 4; ii++, mpc++) {
+			if (rxtx_work & 0x01) {
+				/* TX work */
+				icpo = mpc->mpc_icpo;
+				icpq = &icpo->cout_q0;
+				TX_EVENTS(mpc->mpc_cout_events, mpc);
+
+				wakeup = 0;
+				if (mpc->mpc_cout_events &
EV_TX_EMPTY_Q0) {
+					/* output buffer empty */
+					if (SSTRD16(icpq->q_data_count))
{
+						attn_enbl =
+						    SSTRD16(icpo->
+
cout_attn_enbl);
+						attn_enbl |=
(ENA_TX_EMPTY_Q0);
+
SSTWR16(icpo->cout_attn_enbl,
+							attn_enbl);
+					} else {
+						if (!mpc->xmit_cnt)
+							mpc->mpc_flags
&=
+							    ~MPC_BUSY;
+						txint_event(mpc);
+						wakeup =
+
eqnx_write_wakeup_deferred;
+						mpc->mpc_cout_events &=
+						    ~EV_TX_EMPTY_Q0;
+					}
+				} else if (mpc->mpc_cout_events &
EV_TX_LOW_Q0) {
+					/* output buffer low */
+					if (SSTRD16(icpq->q_data_count)
>=
+					    (icpq->q_block_count * 64))
{
+						attn_enbl =
+						    SSTRD16(icpo->
+
cout_attn_enbl);
+						attn_enbl |=
(ENA_TX_LOW_Q0);
+
SSTWR16(icpo->cout_attn_enbl,
+							attn_enbl);
+					} else {
+						txint_event(mpc);
+						wakeup =
+
eqnx_write_wakeup_deferred;
+						mpc->mpc_cout_events &=
+						    ~EV_TX_LOW_Q0;
+					}
+				}
+				if (eqnx_write_wakeup_deferred) {
+					eqnx_write_wakeup_deferred = 0;
+
mpc->mpc_tty->ldisc.write_wakeup(mpc->
+
mpc_tty);
+				}
+
+				if (mpc->mpc_cout_events &
EV_OUT_TMR_EXP)
+					mpc->mpc_cout_events &=
~EV_OUT_TMR_EXP;
+				attn_enbl =
SSTRD16(icpo->cout_attn_enbl);
+				attn_enbl |= EN_REG_UPDT_EV;
+				SSTWR16(icpo->cout_attn_enbl,
attn_enbl);
+			}
+			rxtx_work = rxtx_work >> 1;
+
+			if ((rxtx_work & 0x08) || (mpc->mpc_flags &
MPC_DEFER)) {
+				/* Defer processing to 40 mills (<=
115Kb) */
+				/* Defer processing to 20 mills (==
230Kb) */
+				if (mpc->mpc_tty != (struct tty_struct
*)NULL) {
+					unsigned int baud =
+					    mpc->mpc_tty->termios->
+					    c_cflag & CBAUD;
+					if ((baud == B230400) &&
(poll_cnt & 1)) {
+						icp->icp_poll_defer = 1;
+						mpc->mpc_flags |=
MPC_DEFER;
+						continue;
+					}
+				}
+			}
+
+			if (poll_cnt & 3) {
+				icp->icp_poll_defer = 1;
+				mpc->mpc_flags |= MPC_DEFER;
+				continue;
+			}
+
+			mpc->mpc_flags &= ~MPC_DEFER;
+			icpi = mpc->mpc_icpi;
+			icpb = (icpi->cin_locks & LOCK_A) ?
&icpi->cin_bank_b :
+			    &icpi->cin_bank_a;
+			FREEZ_BANK(mpc);
+			mpc->mpc_cin_events &= ~EV_LMX_CNG;
+			attn_ena = SSTRD16(icpi->cin_attn_ena);
+			if (mpc->mpc_cin_events & EV_REG_UPDT) {
+				mpc->mpc_cin_events &= ~EV_REG_UPDT;
+				attn_ena &= ~ENA_REG_UPDT;
+			}
+			if (mpc->mpc_cin_events & EV_VMIN) {
+				/* input data event */
+				megainput(mpc, flags);
+				mpc->mpc_cin_events &= ~EV_VMIN;
+			}
+			if (mpc->mpc_cin_events & EV_VTIME)
+				/* input timeout event */
+				mpc->mpc_cin_events &= ~EV_VTIME;
+			if (mpc->mpc_cin_events & (EV_BREAK_CNG |
+						   EV_CHAR_LOOKUP)) {
+				/* break event */
+				rxint_break(mpc, flags);
+				mpc->mpc_cin_events &= ~EV_BREAK_CNG;
+			}
+			if (mpc->mpc_cin_events & EV_DCD_CNG) {
+				/* DCD signal change event */
+				rxint_cs_change(mpc);
+				mpc->mpc_cin_events &= ~EV_DCD_CNG;
+			}
+			attn_ena |= EN_REG_UPDT_EV;
+			SSTWR16(icpi->cin_attn_ena, attn_ena);
+		}
+	}
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+}
+
+/*
+ * sst_poll(arg)
+ *
+ * MEGAPOLL
+ * Board polling routine.  Called once every MPTIMEO
+ * clock ticks (10ms).  Handles input control line transitions,
+ * input buffer handling, output buffer empty conditions, LMX
+ * ring changes and state changes.
+ */
+void sstpoll(unsigned long arg)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	int i, j;
+
+	del_timer(&eqnx_timer);
+
+	poll_cnt++;
+
+	/* loop for each adapter (board) */
+	for (i = 0; i < eqnx_nssps; i++) {
+		mpd = &eqnx_dev[i];
+		/* skip dead board */
+		if (mpd->mpd_alive == 0)
+			continue;
+
+		/* loop for each ICP on the adapter */
+		for (j = 0; j < (int)mpd->mpd_nicps; j++) {
+			mpc = mpd->mpd_mpc + (j * mpd->mpd_sspchan);
+
+			/* validity check */
+			if ((mpc->mpc_icpi == NULL) || (mpc->mpc_icpo ==
NULL))
+				continue;
+
+			if (mpd->mpd_board_def->asic == SSP64) {
+				/* ICP on SSP64 board - every 4 *
MPTIMEO */
+				if (poll_cnt & 3)
+					continue;
+				sstpoll_SSP64(mpd, mpc, j);
+			} else
+				/* ICP on SSP4 board */
+				sstpoll_SSP4(mpd, mpc, j);
+		}
+	}
+
+	eqnx_timer.function = &sstpoll;
+	eqnx_timer.expires = jiffies + MPTIMEO;
+	add_timer(&eqnx_timer);
+}
+
+/*
+ * frame_ctr_reliable(mpc)
+ *
+ * Wait for frame counter counting.
+ *
+ * mpc	= pointer to channel structure.
+ * Return TRUE if ok.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static int frame_ctr_reliable(struct mpchan *mpc)
+{
+	volatile union global_regs_u *icpg;
+	volatile struct icp_out_struct *icpo;
+	int ii = 0;
+	u8 w;
+	u16 x;
+	volatile u16 *frame_ptr, b;
+#ifdef	DEBUG_LOCKS
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "frame_ctr_reliable: mpd lock
!locked\n");
+#endif
+
+	if (mpc->mpc_mpd->mpd_board_def->asic == SSP64) {
+		/* SSP64 */
+		icpg = (volatile union global_regs_u *)(mpc->mpc_icpo);
+		w = icpg->ssp.gicp_chan;
+		x = SSTRD16(icpg->ssp.gicp_frame_ctr);
+		frame_ptr = &(icpg->ssp.gicp_frame_ctr);
+	} else {
+		/* SSP4 */
+		icpg = (volatile union global_regs_u *)
+		    ((unsigned long)(mpc->mpc_icp->icp_regs_start) +
0x400);
+		icpo = (volatile struct icp_out_struct *)
+		    ((unsigned long)(mpc->mpc_icp->icp_regs_start) +
0x200);
+		w = icpg->ssp4.chan_ctr;
+		x = SSTRD16(icpo->cout_frame_ctr);
+		frame_ptr = &(icpo->cout_frame_ctr);
+	}
+
+	/* validate channel number */
+	if (w & 0xc0)
+		return false;
+
+	/* make sure frame counter increments */
+	while ((b = SSTRD16(*frame_ptr)) == x)
+		if (++ii > 0x10000)
+			return false;
+	return true;
+}
+
+/*
+ * mega_rng_delta_GOOD_chk1(icp, mcp, lx)
+ *
+ * Validate an LMX on the ICP - validate queue pointer take test
values.
+ * Helper routine called by mega_rng_delta()
+ *
+ * Return TRUE if ok.
+ *
+ * icp	= pointer to icp struct.
+ * mpc	= pointer to 1st channel struct.
+ * lx	= LMX index.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static inline int mega_rng_delta_GOOD_chk1(struct icp_struct *icp,
+					   struct mpchan *mpc, int lx)
+{
+	int i;
+	u32 bit_test;
+	volatile union global_regs_u *icpg;
+
+	icpg = (volatile union global_regs_u *)mpc->mpc_icpo;
+
+	/* note: this is fix for ATMEL State Maching Problem 4.01 */
+	for (i = 0; i < MAXCHNL_LMX; i++) {
+		bit_test = (0x5a5a ^ ((16 * lx) + i)) & ~0x3;
+		(mpc + i)->mpc_icpi->cin_locks |= LOCK_A;
+		(mpc + i)->mpc_icpi->cin_locks &= ~LOCK_B;
+		eqnx_chnl_sync(mpc);
+		(mpc + i)->mpc_icpi->cin_bank_a.bank_fifo_lvl &= ~0x8f;
+		SSTWR16((mpc + i)->mpc_icpi->cin_bank_a.bank_nxt_dma,
bit_test);
+		(mpc + i)->mpc_icpi->cin_locks |= LOCK_B;
+		(mpc + i)->mpc_icpi->cin_locks &= ~LOCK_A;
+		eqnx_chnl_sync(mpc);
+		(mpc + i)->mpc_icpi->cin_bank_b.bank_fifo_lvl &= ~0x8f;
+		SSTWR16((mpc + i)->mpc_icpi->cin_bank_b.bank_nxt_dma,
bit_test);
+		SSTWR16((mpc + i)->mpc_icpi->cin_tail_ptr_a, bit_test);
+		SSTWR16((mpc + i)->mpc_icpi->cin_tail_ptr_b, bit_test);
+	}
+
+	eqnx_frame_wait(mpc, 1);
+
+	for (i = 0; i < 16; i++) {
+		bit_test = (0x5a5a ^ ((16 * lx) + i)) & ~0x3;
+		if ((SSTRD16((mpc + i)->mpc_icpi->cin_tail_ptr_a) ==
+		     bit_test) &&
+		    (SSTRD16((mpc + i)->mpc_icpi->cin_tail_ptr_b) ==
+		     bit_test) &&
+		    (SSTRD16((mpc +
i)->mpc_icpi->cin_bank_a.bank_nxt_dma) ==
+		     bit_test) &&
+		    (SSTRD16((mpc +
i)->mpc_icpi->cin_bank_b.bank_nxt_dma) ==
+		     bit_test))
+			continue;
+		else {
+			/* failed - reinitialize ICP */
+			icpg->ssp.gicp_initiate = (ICP_PRAM_WR | DMA_EN
|
+						   DISABLE_ATTN_CLR);
+			eqnx_frame_wait(mpc, 1);
+			icpg->ssp.gicp_initiate = (ICP_PRAM_WR | DMA_EN
|
+						   DISABLE_ATTN_CLR |
+						   RNG_CLK_ON);
+			eqnx_frame_wait(mpc, 1);
+			icp->icp_rng_last = RNG_FAIL;
+			icp->icp_rng_state = RNG_BAD;
+			return false;
+		}
+	}
+	return true;
+}
+
+/*
+ * mega_rng_delta_GOOD_chk2(icp, mcp, lx)
+ *
+ * Validate an LMX on the ICP - initialize each channel, verify ring
ok.
+ * Helper routine called by mega_rng_delta()
+ *
+ * Return TRUE if ok.
+ *
+ * icp	= pointer to icp struct.
+ * mpc	= pointer to 1st channel struct.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static inline int mega_rng_delta_GOOD_chk2(struct icp_struct *icp,
+					   struct mpchan *mpc)
+{
+	/* note: this is fix for ATMEL State Maching Problem 4.02 */
+	int i, addr, j;
+	struct mpchan *mpc1;
+	volatile struct icp_in_struct *icpi;
+	volatile union global_regs_u *icpg;
+	volatile struct cin_bnk_struct *icpb;
+	unsigned char *ptr;
+
+	icpg = (volatile union global_regs_u *)mpc->mpc_icpo;
+
+	/* initialize each channel */
+	for (i = 0; i < 16; i++) {
+		mpc1 = mpc + i;
+		icpi = mpc1->mpc_icpi;
+		icpb = (icpi->cin_locks & LOCK_A) ? &icpi->cin_bank_b :
+		    &icpi->cin_bank_a;
+
+		icpg->ssp.gicp_initiate = (DISABLE_ATTN_CLR | DMA_EN |
+					   RNG_CLK_ON);
+		eqnx_frame_wait(mpc1, 1);
+		ptr = (unsigned char *)icpi;
+		for (j = 0x40; j < 0x80; j++)
+			ptr[j] = 0;
+		icpi->cin_bank_a.bank_fifo_lvl &= ~0x8f;
+		icpi->cin_bank_b.bank_fifo_lvl &= ~0x8f;
+		addr = (mpc1->mpc_rxpg * 0x4000) +
mpc1->mpc_rxq.q_begin;
+		mpc1->mpc_rxq.q_ptr = mpc1->mpc_rxq.q_begin;
+		SSTWR16(icpi->cin_bank_a.bank_nxt_dma, (addr & 0xffff));
+		SSTWR16(icpi->cin_bank_b.bank_nxt_dma, (addr & 0xffff));
+		SSTWR16(icpi->cin_tail_ptr_a, (addr & 0xffff));
+		SSTWR16(icpi->cin_tail_ptr_b, (addr & 0xffff));
+		icpi->cin_iband_flow_cntrl = 0;
+		eqnx_chnl_sync(mpc1);
+		icpg->ssp.gicp_initiate = (ICP_PRAM_WR | DMA_EN |
+					   DISABLE_ATTN_CLR |
RNG_CLK_ON);
+		eqnx_frame_wait(mpc1, 1);
+		FREEZ_BANK(mpc1);
+		FREEZ_BANK(mpc1);
+		mpc1->mpc_cin_events = 0;
+	}
+
+	/* verify ring clock is still on */
+	eqnx_frame_wait(mpc, 1);
+	if (icpg->ssp.gicp_attn & RNG_FAIL) {
+		icp->icp_rng_last = RNG_FAIL;
+		icp->icp_rng_state = RNG_BAD;
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * mega_rng_delta_GOOD_initLMX(icp, mcp, lx, lmx)
+ *
+ * Validate an LMX on the ICP - bring LMX online
+ * Helper routine called by mega_rng_delta()
+ *
+ * Return TRUE if ok.
+ *
+ * icp	= pointer to icp struct.
+ * mpc	= pointer to 1st channel struct.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static inline int mega_rng_delta_GOOD_initLMX(struct icp_struct *icp,
+					      struct mpchan *mpc, int
lx,
+					      struct lmx_struct *lmx)
+{
+	int prod_id, lmx_speed, no_lmx, ami_interface, i, j;
+	volatile struct icp_out_struct *icpo;
+	volatile struct icp_in_struct *icpi;
+	volatile struct cin_bnk_struct *icpb;
+	volatile union global_regs_u *icpg;
+	unsigned char *ptr;
+	struct mpchan *mpc1;
+	unsigned int addr;
+	u16 attn_ena, cntrl_sig;
+
+	icpo = mpc->mpc_icpo;
+	icpi = mpc->mpc_icpi;
+	icpb = (icpi->cin_locks & LOCK_A) ? &icpi->cin_bank_b :
+	    &icpi->cin_bank_a;
+	icpg = (volatile union global_regs_u *)icpo;
+
+	prod_id = (unsigned)(SSTRD16((mpc + 1)->mpc_icpi->cin_tdm_early)
&
+			     PRODUCT_ID) >> 1;
+	if (lmx->lmx_active == DEV_BAD && prod_id != lmx->lmx_id) {
+		/* ring configuration has changed */
+		lmx->lmx_id = prod_id;
+		icpo->cout_lmx_command &= ~(TX_BRDG_XPRNT |
TX_TRGT_MUX);
+	}
+
+	/* clear/set scan speed */
+	lmx_speed = (unsigned)(SSTRD16(icpi->cin_tdm_early) & LMX_SPEED)
>> 6;
+	icpg->ssp.gicp_scan_spd &= ~(0x03 << (lx * 2));
+	icpg->ssp.gicp_scan_spd |= lmx_speed << (lx * 2);
+
+	/* put local lmx online */
+	icpo->cout_lmx_command = (TX_INTR_LB | TX_LMX_ONLN |
TX_LMX_CMD_EN);
+	eqnx_frame_wait(mpc, 6);
+	no_lmx = !(SSTRD16(icpb->bank_signals) & LMX_ONLN);
+	icpo->cout_lmx_command &= ~(TX_INTR_LB | TX_LMX_CMD_EN);
+	ami_interface = SSTRD16(icpb->bank_signals) & AMI_CNFG;
+	if (!no_lmx) {
+		/* lmx went online as expected */
+		lmx->lmx_speed = lmx_speed;
+		lmx->lmx_id = prod_id;
+
+		/* if we are the secondary icp, tell the icp to say so
*/
+		if (SSTRD16(icpb->bank_signals) & LMX_OUT_2)
+			icpg->ssp.gicp_initiate |= ICP_2;
+		else
+			icpg->ssp.gicp_initiate &= ~ICP_2;
+
+		/* note: this is fix for ATMEL State Maching Problem
3.48 */
+		for (i = 0; i < 16; i++) {
+			mpc1 = mpc + i;
+			/* Restore Loopback if enabled */
+			if ((mpc1->mpc_flags & MPC_LOOPBACK)) {
+				mpc1->mpc_icpo->cout_lmx_command |=
+				    (TX_INTR_LB | TX_XTRN_LB |
TX_LMX_CMD_EN);
+				eqnx_frame_wait(mpc1, 6);
+				mpc1->mpc_icpo->cout_lmx_command &=
+				    ~TX_LMX_CMD_EN;
+			}
+			icpi = mpc1->mpc_icpi;
+			icpg->ssp.gicp_initiate = (RNG_CLK_ON | DMA_EN |
+						   DISABLE_ATTN_CLR);
+			eqnx_frame_wait(mpc1, 1);
+			ptr = (unsigned char *)icpi;
+			for (j = 0x40; j <= 0x80; j++)
+				ptr[j] = 0;
+
+			icpi->cin_bank_a.bank_fifo_lvl &= ~0x8f;
+			icpi->cin_bank_b.bank_fifo_lvl &= ~0x8f;
+
+			addr = (mpc1->mpc_rxpg * 0x4000) +
+			    mpc1->mpc_rxq.q_begin;
+			mpc1->mpc_rxq.q_ptr = mpc1->mpc_rxq.q_begin;
+			SSTWR16(icpi->cin_bank_a.bank_nxt_dma, (addr &
0xffff));
+			SSTWR16(icpi->cin_bank_b.bank_nxt_dma, (addr &
0xffff));
+			SSTWR16(icpi->cin_tail_ptr_a, (addr & 0xffff));
+			SSTWR16(icpi->cin_tail_ptr_b, (addr & 0xffff));
+
+			icpi->cin_iband_flow_cntrl = 0;
+			eqnx_chnl_sync(mpc1);
+			icpg->ssp.gicp_initiate = (RNG_CLK_ON | DMA_EN |
+						   ICP_PRAM_WR |
+						   DISABLE_ATTN_CLR);
+			eqnx_frame_wait(mpc1, 1);
+			FREEZ_BANK(mpc1);
+			FREEZ_BANK(mpc1);
+			mpc1->mpc_cin_events = 0;
+		}
+
+		if (ami_interface) {
+			/* indicate bridge */
+			lmx->lmx_active = DEV_GOOD;
+			lmx->lmx_bridge = true;
+			icpo->cout_lmx_command = (TX_LMX_ONLN |
TX_BRDG_XPRNT |
+						  TX_LCK_LMX |
TX_LMX_CMD_EN);
+			eqnx_frame_wait(mpc, 6);
+			icpo->cout_lmx_command &= ~TX_LMX_CMD_EN;
+			lmx->lmx_chan = 16;
+			lmx->lmx_rmt_active = DEV_VIRGIN;
+			attn_ena = SSTRD16(icpi->cin_attn_ena);
+			attn_ena |= ENA_LMX_CNG;
+			SSTWR16(icpi->cin_attn_ena, attn_ena);
+		} else {
+			/* no ami_interface - panel present */
+			lmx->lmx_bridge = false;
+
+			switch (lmx->lmx_id) {
+			case 3:
+				/* software selectable speed multiplier
*/
+				switch (mpc->mpc_mpd->mpd_pdev->device &
0xf8) {
+				case 0x18:
+					lmx->lmx_chan = 8;
+					break;
+				case 0x20:
+					lmx->lmx_chan = 4;
+					break;
+				default:
+					lmx->lmx_chan = MAXCHNL_LMX;
+					break;
+				}
+				break;
+			case 4:
+				lmx->lmx_chan = 8;
+				break;
+			case 5:
+				lmx->lmx_chan = 12;
+				break;
+			case 6:
+				lmx->lmx_chan = 8;
+				break;
+			case 7:
+				lmx->lmx_chan = 16;
+				break;
+			case 8:
+				lmx->lmx_chan = 16;
+				break;
+			case 9:
+				lmx->lmx_chan = 8;
+				break;
+			case 0xB:
+				lmx->lmx_chan = 4;
+				break;
+			case 0x10:
+				lmx->lmx_chan = 16;
+				break;
+			default:
+				lmx->lmx_chan = MAXCHNL_LMX;
+				break;
+			}
+
+			if ((lmx->lmx_chan == 8 || lmx->lmx_chan == 4))
{
+				unsigned char cin_lck[16];
+				unsigned char cout_lck[16];
+				volatile unsigned char *chan_ptr,
cur_chan;
+				int i = 0, kk = 0;
+				struct mpchan *mpckk;
+
+				chan_ptr = &icpg->ssp.gicp_chan;
+				cur_chan = *chan_ptr;
+
+				/* change lmx speed for this device */
+				while (true) {
+					cntrl_sig = SSTRD16((icpo +
kk)->
+
cout_cntrl_sig);
+					cntrl_sig |= 0x100;
+					SSTWR16((icpo +
kk)->cout_cntrl_sig,
+						cntrl_sig);
+					cntrl_sig = SSTRD16((icpo + kk +
1)->
+
cout_cntrl_sig);
+					cntrl_sig &= ~0x100;
+					SSTWR16((icpo + kk +
1)->cout_cntrl_sig,
+						cntrl_sig);
+					kk += 2;
+					if (kk >= 16)
+						break;
+				}
+
+				eqnx_frame_wait(mpc, 6);
+				for (kk = 0; kk < 16; kk++) {
+					mpckk = mpc + kk;
+					cin_lck[kk] =
+
(mpckk)->mpc_icpi->cin_locks;
+					(mpckk)->mpc_icpi->cin_locks =
0xff;
+					cout_lck[kk] =
+
(mpckk)->mpc_icpo->cout_lck_cntrl;
+
(mpckk)->mpc_icpo->cout_lck_cntrl =
+					    0xff;
+				}
+
+				while (*chan_ptr == cur_chan) {
+					if (++i > 9000)
+						break;
+				}
+				icpg->ssp.gicp_scan_spd &= ~(0x03 << (lx
* 2));
+				icpg->ssp.gicp_scan_spd |= (1 << (lx *
2));
+				lmx->lmx_speed = 1;
+				cur_chan = *chan_ptr;
+				i = 0;
+				while (*chan_ptr == cur_chan) {
+					if (++i > 9000)
+						break;
+				}
+				for (kk = 0; kk < 16; kk++) {
+					mpckk = mpc + kk;
+					(mpckk)->mpc_icpi->cin_locks =
+					    cin_lck[kk];
+
(mpckk)->mpc_icpo->cout_lck_cntrl =
+					    cout_lck[kk];
+				}
+			}
+
+			/* set alive */
+			lmx->lmx_active = DEV_GOOD;
+
+			/* panel ready for use */
+			if (icp->icp_rng_good_count && !eqnx_quiet_mode)
+				dev_info(mpc->mpc_mpd->dev, "NOTICE:
SST: "
+					 "minor devices %d to %d
available\n",
+					 icp->icp_minor_start + lx *
+					 MAXCHNL_LMX,
+					 icp->icp_minor_start + (lx + 1)
*
+					 MAXCHNL_LMX - 1);
+			FREEZ_BANK(mpc);
+			mpc->mpc_cin_events = 0;
+			attn_ena = SSTRD16(icpi->cin_attn_ena);
+			attn_ena |= ENA_LMX_CNG;
+			SSTWR16(icpi->cin_attn_ena, attn_ena);
+		}
+	} else {
+		/* local lmx not put online as expected */
+		icpo->cout_lmx_command = 0;
+		lmx->lmx_id = -1;
+		if (lmx->lmx_active == DEV_BAD) {
+			lmx->lmx_active = DEV_VIRGIN;
+			lmx->lmx_id = -1;
+		}
+		icp->icp_rng_last = RNG_FAIL;
+		icp->icp_rng_state = RNG_BAD;
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * mega_rng_delta_CHK(icp)
+ *
+ * Validate each channel on the ICP - verify input queue pointers.
+ * Helper routine called by mega_rng_delta()
+ *
+ * Return TRUE if ok.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static inline int mega_rng_delta_CHK(struct icp_struct *icp)
+{
+	struct lmx_struct *lmx;
+	struct mpchan *mpc, *mpc1;
+	volatile struct icp_out_struct *icpo;
+	volatile struct icp_in_struct *icpi;
+	int i, baddr, eaddr;
+
+	lmx = &icp->lmx[0];
+	mpc = lmx->lmx_mpc;
+	icpo = mpc->mpc_icpo;
+
+	for (i = 0; i < MAXCHNL_ICP; i++) {
+		mpc1 = mpc + i;
+		if (mpc1->mpc_icp->lmx[mpc1->mpc_lmxno].lmx_active !=
DEV_GOOD)
+			continue;
+
+		icpi = mpc1->mpc_icpi;
+		baddr = (mpc1->mpc_rxpg * 0x4000) +
mpc1->mpc_rxq.q_begin;
+		eaddr = (mpc1->mpc_rxpg * 0x4000) + mpc1->mpc_rxq.q_end;
+		if ((SSTRD16(icpi->cin_bank_a.bank_nxt_dma) <
+		     (baddr & 0xffff)) ||
+		    (SSTRD16(icpi->cin_bank_a.bank_nxt_dma) > (eaddr &
0xffff)))
+			return false;
+
+		if ((SSTRD16(icpi->cin_bank_b.bank_nxt_dma) <
+		     (baddr & 0xffff)) ||
+		    (SSTRD16(icpi->cin_bank_b.bank_nxt_dma) > (eaddr &
0xffff)))
+			return false;
+
+		if ((SSTRD16(icpi->cin_tail_ptr_a) < (baddr & 0xffff))
||
+		    (SSTRD16(icpi->cin_tail_ptr_a) > (eaddr & 0xffff)))
+			return false;
+
+		if ((SSTRD16(icpi->cin_tail_ptr_b) < (baddr & 0xffff))
||
+		    (SSTRD16(icpi->cin_tail_ptr_b) > (eaddr & 0xffff)))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * mega_rng_delta(icp, reason, nchan)
+ *
+ * Handle a change in the ring pointed to by "icp". "reason" may be
+ *     RNG_BAD		status just went to bad
+ *     RNG_GOOD		status just went to good (includes init
time)
+ *     RNG_WAIT		debounce of RNG_CLK in progress
+ *     RNG_CHK		service of a transistion to RNG_GOOD in progress
+ *     RNG_FAIL		ring clock offline detected
+ *                                
+ * Initialization code relies on this state machine to establish the
+ * ring as well as ring failure detection and re-initialization.
+ * This routine is responsible for "local" lmx's only!!!
+ *        
+ * Return the new value for "rng_reqsvc" to indicate if this routine
+ * should be run next entry of sstpoll() without any change in the
+ * ring status.
+ *
+ * An inherent assumption in ring processing is that ring processing
+ * has precedence over lmx processing.  This implies:
+ *     1) changes in local lmx's will be prompted by loss of ring.
+ *     2) lmx condition change events will be due to mux
+ *        changes (not local lmx changes)
+ * 
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static int mega_rng_delta(struct icp_struct *icp, int reason, int
nchan)
+{
+	volatile struct cin_bnk_struct *icpb;
+	volatile struct icp_in_struct *icpi;
+	volatile struct icp_out_struct *icpo;
+	volatile union global_regs_u *icpg;
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	struct lmx_struct *lmx;
+	int chnl, lx, frames_ok = 1, i;
+
+	lmx = &icp->lmx[0];
+	mpc = lmx->lmx_mpc;
+	mpd = mpc->mpc_mpd;
+
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "mega_rng_delta: mpd lock !locked\n");
+#endif
+
+	switch (reason) {
+	case RNG_FAIL:
+		/* ring clock off line */
+		icp->icp_rng_last = RNG_FAIL;
+
+		/* fall through */
+
+	case RNG_BAD:
+		/* ring clock bad or offline */
+		if (icp->icp_rng_state == RNG_BAD)
+			break;
+		if (!eqnx_quiet_mode)
+			dev_warn(mpd->dev, "WARNING: SST expansion bus "
+				 "failure detected for minor devices %d
to "
+				 "%d\n",
+				 icp->icp_minor_start,
+				 icp->icp_minor_start + MAXCHNL_ICP -
1);
+		/* set state of LMXs to bad */
+		icp->icp_rng_fail_count++;
+		icp->icp_rng_state = RNG_BAD;
+		for (i = 0; i < MAXLMX; i++) {
+			icp->lmx[i].lmx_active = DEV_BAD;
+			icp->lmx[i].lmx_rmt_active = DEV_BAD;
+		}
+		break;
+
+	case RNG_GOOD:
+		/* ring clock online */
+		if (icp->icp_rng_state == RNG_GOOD)
+			break;
+
+		if (icp->icp_rng_good_count && !eqnx_quiet_mode)
+			dev_info(mpd->dev, "NOTICE: SST expansion bus "
+				 "established for minor devices %d to
%d\n",
+				 icp->icp_minor_start,
+				 icp->icp_minor_start + MAXCHNL_ICP -
1);
+
+		/*
+		 * transistion to GOOD state
+		 * loop thru all possible lmx's - check chnls 0, 16, 24,
48
+		 */
+		icp->icp_rng_state = RNG_CHK;
+		lmx = &icp->lmx[0];
+		mpc = lmx->lmx_mpc;
+		icpo = mpc->mpc_icpo;
+
+		if (mpc->mpc_mpd->mpd_board_def->asic != SSP64) {
+			dev_warn(mpd->dev, "mega_rng_delta: called w/
SSP4\n");
+			break;
+		}
+
+		frames_ok = frame_ctr_reliable(mpc);
+
+		/* loop through each LMX */
+		for (chnl = 0, lx = 0; chnl < MIN(MAXCHNL_ICP, nchan);
+		     chnl += 16, lx++) {
+
+			lmx = &icp->lmx[lx];
+			mpc = lmx->lmx_mpc;
+			icpi = mpc->mpc_icpi;
+			icpo = mpc->mpc_icpo;
+
+			icpo->cout_cpu_req |= CPU_PAUSE;
+			eqnx_frame_wait(mpc, 3);
+			/* make sure we are offline */
+			icpo->cout_lmx_command = (TX_LMX_CMD_EN |
TX_TRGT_MUX);
+			eqnx_frame_wait(mpc, 6);
+			icpo->cout_lmx_command = TX_LMX_CMD_EN;
+			eqnx_frame_wait(mpc, 6);
+			icpo->cout_lmx_command &= ~TX_LMX_CMD_EN;
+			icpo->cout_cpu_req &= ~CPU_PAUSE;
+			eqnx_frame_wait(mpc, 3);
+
+			icpb = (icpi->cin_locks & LOCK_A) ?
&icpi->cin_bank_b :
+			    &icpi->cin_bank_a;
+			icpg = (volatile union global_regs_u *)icpo;
+
+			/* SSP/LMX validation */
+			if (!(mega_rng_delta_GOOD_chk1(icp, mpc, lx)))
+				return 0;
+			if (!(mega_rng_delta_GOOD_chk2(icp, mpc)))
+				return 0;
+
+			icpb = (icpi->cin_locks & LOCK_A) ?
&icpi->cin_bank_b :
+			    &icpi->cin_bank_a;
+			/* check for not offline, if so, check next poll
*/
+			if (SSTRD16(icpb->bank_signals) & LMX_ONLN) {
+				icp->icp_rng_last = RNG_FAIL;
+				icp->icp_rng_state = RNG_BAD;
+				break;
+			}
+
+			if ((SSTRD16(icpb->bank_signals) & LMX_PRESENT)
&&
+			    frames_ok) {
+				if (!mega_rng_delta_GOOD_initLMX(icp,
mpc, lx,
+								 lmx))
+					return 0;
+			} else {
+				/* no local lmx present */
+				lmx->lmx_active = DEV_VIRGIN;
+				lmx->lmx_id = -1;
+			}
+		}
+		icp->icp_rng_good_count++;
+		break;
+
+	case RNG_CHK:
+		/* check ring state */
+
+		/*
+		 * state in this state for 800 milliseconds - if the
ring
+		 * and the state of the channels remain valid for the
entire
+		 * period then change state to GOOD.
+		 */
+		if (icp->icp_rng_wait++ > 20) {
+			icp->icp_rng_state = RNG_GOOD;
+			icp->icp_rng_wait = 0;
+		}
+
+		lmx = &icp->lmx[0];
+		mpc = lmx->lmx_mpc;
+		if (mpc->mpc_mpd->mpd_board_def->asic != SSP64) {
+			dev_warn(mpd->dev, "mega_rng_delta: called w/
SSP4\n");
+			break;
+		}
+
+		if (!(mega_rng_delta_CHK(icp))) {
+			/* start over - reinitialize ICP */
+			icpo = mpc->mpc_icpo;
+			icpg = (volatile union global_regs_u *)icpo;
+			icpg->ssp.gicp_initiate = (ICP_PRAM_WR | DMA_EN
|
+						   DISABLE_ATTN_CLR);
+			eqnx_frame_wait(mpc, 1);
+			icpg->ssp.gicp_initiate = (ICP_PRAM_WR | DMA_EN
|
+						   DISABLE_ATTN_CLR |
+						   RNG_CLK_ON);
+			eqnx_frame_wait(mpc, 1);
+			icp->icp_rng_last = RNG_FAIL;
+			icp->icp_rng_state = RNG_BAD;
+			return 0;
+		}
+		break;
+
+	}
+	return 0;
+}
+
+/*
+ * mega_rdv_delta_wait(arg)
+ *
+ * Timer routine for mega_rdvc_delta
+ *
+ * arg	= pointer to channel structure.
+ */
+static void mega_rdv_delta_wait(unsigned long arg)
+{
+	struct mpchan *mpc = (struct mpchan *)arg;
+	volatile struct icp_in_struct *icpi = mpc->mpc_icpi;
+	struct icp_struct *icp = mpc->mpc_icp;
+	u16 attn_ena;
+
+	icp->lmx[mpc->mpc_lmxno].lmx_wait = -1;
+	mpc->mpc_cin_events |= EV_LMX_CNG;
+	attn_ena = SSTRD16(icpi->cin_attn_ena);
+	attn_ena |= (ENA_REG_UPDT | EN_REG_UPDT_EV);
+	SSTWR16(icpi->cin_attn_ena, attn_ena);
+}
+
+/*
+ * mega_rdv_delta(icp, mpc, rng_state)
+ *
+ * Handle a change in the remote lmx pointed to by channel "mp".
+ * This change was indicated by "lmx condition changed" bit
+ * in input events register, now stored in "mpc->mpc_rx_bank".  
+ *
+ * Only channels 0, 16, 32 and 48 arrive here!
+ *
+ * Remote lmx init/failure/recovery is handled by this routine.
+ * Local lmx (ldev) init/failure/recovery is handled by 
+ * "mega_ring_delta" by detecting changes in the ring.  
+ *        
+ * icp	= poiinter to icp structure.
+ * mpc	= pointer to channel structure.
+ * rng_state = one of RNG_BAD or RNG_GOOD
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void mega_rdv_delta(struct icp_struct *icp, struct mpchan *mpc,
+			   int rng_state)
+{
+	volatile struct icp_in_struct *icpi = mpc->mpc_icpi;
+	volatile struct icp_out_struct *icpo = mpc->mpc_icpo;
+	volatile struct cin_bnk_struct *icpb;
+	struct lmx_struct *lmx;
+	int rmt_lmx_found, lmx_online, chnl;
+	u16 attn_ena, tdm_early;
+	struct mpdev *mpd;
+
+	mpd = mpc->mpc_mpd;
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "mega_rdv_delta: mpd lock !locked\n");
+#endif
+
+	if (mpc->mpc_mpd->mpd_board_def->asic != SSP64) {
+		dev_warn(mpd->dev, "mega_rdv_delta: called w/ SSP4\n");
+		return;
+	}
+
+	chnl = mpc->mpc_chan;
+	lmx = &icp->lmx[mpc->mpc_lmxno];
+	/* wait until registers are valid */
+	eqnx_frame_wait(mpc, 2);
+	icpb = (icpi->cin_locks & LOCK_A) ? &icpi->cin_bank_b :
+	    &icpi->cin_bank_a;
+
+	if ((SSTRD16(icpb->bank_signals) & (LMX_ONLN | LMX_RMT)) ==
0x00) {
+		/* bridge not on line */
+		icp->icp_rng_svcreq = RNG_FAIL;
+		return;
+	}
+
+	switch (lmx->lmx_rmt_active) {
+	case DEV_VIRGIN:
+	case DEV_BAD:
+dev_bad:
+		/* bridge currently offline or unknown */
+		rmt_lmx_found = ((SSTRD16(icpi->cin_tdm_early) &
+				  (AMI_CONFIG | TDM_MUX)) ==
+				 (AMI_CONFIG | TDM_MUX));
+		if (rng_state == RNG_GOOD) {
+			if (rmt_lmx_found) {
+				lmx->lmx_active = DEV_GOOD;
+				/* wait for link to settle down */
+				lmx->lmx_rmt_active = DEV_WAITING;
+				if (lmx->lmx_wait == -1) {
+					init_timer(&lmx_wait_timer);
+					lmx_wait_timer.expires = jiffies
+ 100;
+					lmx_wait_timer.data =
+					    (unsigned long)mpc;
+					lmx_wait_timer.function =
+					    &mega_rdv_delta_wait;
+					add_timer(&lmx_wait_timer);
+				}
+			}
+		}
+
+		break;
+
+	case DEV_WAITING:
+		/* bridge currently being initialized */
+		if (lmx->lmx_wait != -1) {
+			/* event occured while waiting */
+			del_timer(&lmx_wait_timer);
+			lmx->lmx_wait = -1;
+			lmx->lmx_rmt_active = DEV_BAD;
+			tdm_early = SSTRD16(icpi->cin_tdm_early) &
+			    (AMI_CONFIG | TDM_MUX);
+			rmt_lmx_found = (tdm_early == (AMI_CONFIG |
TDM_MUX));
+			lmx_online = SSTRD16(icpb->bank_signals) &
LMX_ONLN;
+			if (lmx_online && !rmt_lmx_found)
+				goto dev_bad;
+			else
+				icp->icp_rng_svcreq = RNG_FAIL;
+			break;
+		}
+
+		/* get mux id */
+		lmx->lmx_rmt_id = (unsigned)
+		    (SSTRD16((mpc + 1)->mpc_icpi->cin_tdm_early) &
+		     PRODUCT_ID) >> 1;
+		/* put remote lmx online */
+		icpo->cout_lmx_command = (TX_LMX_ONLN | TX_LCK_LMX |
+					  TX_LMX_CMD_EN | TX_TRGT_MUX);
+		eqnx_frame_wait(mpc, 6);
+		icpo->cout_lmx_command &= ~TX_LMX_CMD_EN;
+
+		rmt_lmx_found = SSTRD16(icpb->bank_signals) &
+		    (LMX_ONLN | LMX_RMT);
+		if (rmt_lmx_found != (LMX_ONLN | LMX_RMT))
+			rmt_lmx_found = false;
+		if (rmt_lmx_found) {
+			lmx->lmx_rmt_active = DEV_GOOD;
+
+			if (mpc->mpc_flags & MPC_LOOPBACK) {
+				mpc->mpc_icpo->cout_lmx_command |=
+				    (TX_INTR_LB | TX_XTRN_LB |
TX_LMX_CMD_EN);
+				eqnx_frame_wait(mpc, 6);
+				mpc->mpc_icpo->cout_lmx_command &=
+				    ~TX_LMX_CMD_EN;
+			}
+
+			if (lmx->lmx_good_count++ && !eqnx_quiet_mode)
+				dev_info(mpd->dev, "NOTICE: SST: minor "
+					 "devices %d to %d available on
"
+					 "remote mux\n",
+					 icp->icp_minor_start + chnl,
+					 icp->icp_minor_start + chnl +
+					 MAXCHNL_LMX - 1);
+			FREEZ_BANK(mpc);
+			mpc->mpc_cin_events = 0;
+			attn_ena = SSTRD16(icpi->cin_attn_ena);
+			attn_ena |= ENA_LMX_CNG;
+			SSTWR16(icpi->cin_attn_ena, attn_ena);
+		} else {
+			/* wait again for link to return */
+			lmx->lmx_rmt_active = DEV_BAD;
+			goto dev_bad;
+		}
+		break;
+
+	case DEV_GOOD:
+		/* bridge currently good */
+		rmt_lmx_found = SSTRD16(icpb->bank_signals) & LMX_RMT;
+		lmx_online = SSTRD16(icpb->bank_signals) & LMX_ONLN;
+		if (rng_state == DEV_GOOD) {
+			if ((!rmt_lmx_found && lmx_online) ||
+			    (rmt_lmx_found && !lmx_online)) {
+				/* remote lmx has disappeared */
+				/* wait for RNG_GOOD and rmt_lmx_found
*/
+				lmx->lmx_rmt_active = DEV_BAD;
+				if (!eqnx_quiet_mode)
+					dev_warn(mpd->dev, "WARNING:
SST: "
+						 "remote mux failure "
+						 "detected for minor
devices "
+						 "%d to %d\n",
+						 icp->icp_minor_start +
chnl,
+						 icp->icp_minor_start +
chnl +
+						 MAXCHNL_LMX - 1);
+				if (rmt_lmx_found && !lmx_online)
+					goto dev_bad;
+			} else {
+				/* ring failed, tear down */
+				icp->icp_rng_svcreq = RNG_FAIL;
+				icpo->cout_lmx_command = (TX_LMX_CMD_EN
|
+							  TX_TRGT_MUX);
+				eqnx_frame_wait(mpc, 6);
+				icpo->cout_lmx_command = 0;
+				lmx->lmx_active = DEV_BAD;
+				icpo->cout_lmx_command = ~TX_LMX_CMD_EN;
+				eqnx_frame_wait(mpc, 6);
+				icpo->cout_lmx_command = 0;
+			}
+		}
+		break;
+	}
+}
+
+/*
+ * txint_event(mpc)
+ *
+ * Transmit empty or low event.  If more data, queue it.
+ *
+ * mpc	= pointer to channel structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void txint_event(struct mpchan *mpc)
+{
+	struct tty_struct *tty = mpc->mpc_tty;
+#ifdef	DEBUG_LOCKS
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "txint_event: mpd lock !locked\n");
+#endif
+
+	if (tty == (struct tty_struct *)NULL)
+		return;
+
+	/* SSP4 may have output data buffered */
+	if (mpc->mpc_mpd->mpd_board_def->asic != SSP64) {
+		if (mpc->xmit_cnt) {
+			eqnx_write_SSP4(mpc, EQNX_TXINT);
+			return;
+		}
+	}
+
+	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+	    tty->ldisc.write_wakeup)
+		(tty->ldisc.write_wakeup) (tty);
+	wake_up_interruptible(&tty->write_wait);
+}
+
+/*
+ * megainput_copy(mpc, cbuf, count)
+ *
+ * Copy data to line discipline buffers.
+ * Helper (inline) routine for megainput.
+ *
+ * mpc	= pointer to channel structure.
+ * cbuf = buffer pointer to copy to.
+ * count = number of bytes to copy.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static inline void megainput_copy(struct mpchan *mpc, u8 * cbuf, int
count)
+{
+	int cp_count, d, room, ds_count;
+	u8 *ubase;
+
+	while (count) {
+		cp_count = MIN(count, mpc->mpc_rxq.q_end -
+			       mpc->mpc_rxq.q_ptr + 1);
+		/* copy data to line discipline */
+		memcpy(cbuf, (mpc->mpc_rxq.q_addr + mpc->mpc_rxq.q_ptr),
+		       cp_count);
+
+		/* datascope */
+		if ((mpc->mpc_flags & MPC_DSCOPER) &&
+		    (eqnx_dscope[0].chan == mpc - eqnx_chan)) {
+			d = 0;
+			ubase = (mpc->mpc_rxq.q_addr +
mpc->mpc_rxq.q_ptr);
+			room = DSQSIZE - ((eqnx_dscope[d].next -
+					   eqnx_dscope[d].q.q_ptr)
+					  & (DSQMASK));
+			if (cp_count > room)
+				eqnx_dscope[d].status |= DSQWRAP;
+			else
+				room = cp_count;
+			while (room > 0) {
+				ds_count = MIN(room,
+					       eqnx_dscope[d].q.q_end -
+					       eqnx_dscope[d].next + 1);
+				memcpy(eqnx_dscope[d].q.q_addr +
+				       eqnx_dscope[d].next, ubase,
ds_count);
+				eqnx_dscope[d].next += ds_count;
+				if (eqnx_dscope[d].next >
+				    eqnx_dscope[d].q.q_end)
+					eqnx_dscope[d].next =
+					    eqnx_dscope[d].q.q_begin;
+				ubase += ds_count;
+				room -= ds_count;
+			}
+			eqnx_dscope[d].scope_wait_wait = 0;
+
wake_up_interruptible(&eqnx_dscope[d].scope_wait);
+		}
+
+		count -= cp_count;
+		cbuf += cp_count;
+		mpc->mpc_input += cp_count;
+		mpc->mpc_rxq.q_ptr += cp_count;
+		if (mpc->mpc_rxq.q_ptr > mpc->mpc_rxq.q_end)
+			mpc->mpc_rxq.q_ptr = mpc->mpc_rxq.q_begin;
+	}
+}
+
+/*
+ * megainput(mpc, flags)
+ *
+ * Low speed input routine.
+ *
+ * mpc	= pointer to channel structure.
+ * flags = lock flags.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ * NOTE - lock is dropped and then re-locked to do input 
+ */
+static void megainput(struct mpchan *mpc, unsigned long flags)
+{
+	struct tty_struct *tp = mpc->mpc_tty;
+	volatile struct icp_in_struct *icpi = mpc->mpc_icpi;
+	volatile struct icp_out_struct *icpo;
+	caddr_t bp, tgp;
+	u8 curtags, tags_l, tags_h;
+	volatile struct cin_bnk_struct *icpb = mpc->mpc_icpb;
+	unsigned int rcv_cnt, tagp;
+	int fifo_cnt, i, ldisc_count = 0;
+	u16 dma_ptr, err;
+	char fifo[0x10];
+	struct termios *tiosp;
+	unsigned char *cbuf;
+	char *fbuf;
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "megainput: mpd lock !locked\n");
+#endif
+
+	if (mpc->mpc_tty == (struct tty_struct *)NULL)
+		return;
+	tiosp = tp->termios;
+	if (tiosp == NULL)
+		return;
+
+	icpo = mpc->mpc_icpo;
+	mpc->mpc_flags &= ~MPC_RXFLUSH;
+
+	if (mpc->mpc_block)
+		return;
+	if ((mpc->mpc_flags & MPC_OPEN) == 0)
+		return;
+
+	rcv_cnt = (SSTRD16(icpb->bank_nxt_dma) + (icpb->bank_fifo_lvl &
0xf) -
+		   mpc->mpc_rxq.q_ptr) & (mpc->mpc_rxq.q_size - 1);
+	rcv_cnt = MIN(rcv_cnt, (2 * TTY_FLIPBUF_SIZE));
+	rcv_cnt = MIN(rcv_cnt, tp->receive_room);
+
+	dev_dbg(mpd->dev, "megainput: device %d receive count = %d\n",
+		SSTMINOR(mpc->mpc_major, mpc->mpc_minor), rcv_cnt);
+	if (rcv_cnt == 0)
+		return;
+
+	rcv_cnt = tty_prepare_flip_string_flags(tp, &cbuf, &fbuf,
rcv_cnt);
+	if (rcv_cnt <= 0)
+		return;
+
+	/* copy fifo's to memory */
+	fifo_cnt = icpb->bank_fifo_lvl & 0xf;
+	if (fifo_cnt) {
+		for (i = 0; i < fifo_cnt; i++)
+			fifo[i] = icpb->bank_fifo[i];
+	}
+	dma_ptr = SSTRD16(icpb->bank_nxt_dma);
+
+	/* check if there was an error char */
+	if ((err = (mpc->mpc_cin_events & EV_PAR_ERR))) {
+		if (tiosp->c_iflag & IGNPAR)
+			err = 0;
+		if (!(tiosp->c_iflag & INPCK))
+			err = 0;
+	}
+	err |= mpc->mpc_cin_events & EV_FRM_ERR;
+	mpc->mpc_cin_events &= ~(EV_PAR_ERR | EV_FRM_ERR);
+
+	/* copy tags if there was an error */
+	if (err && fifo_cnt) {
+		u8 *tagptr;
+		if (mpc->mpc_mpd->mpd_board_def->asic == SSP64)
+			/* SSP64 */
+			tagptr = (u8 *)
mpc->mpc_mpd->icp[0].icp_tags_start;
+		else
+			/* SSP4 */
+			tagptr = (u8 *)
+
mpc->mpc_mpd->icp[mpc->mpc_icpno].icp_tags_start;
+		tags_l = icpb->bank_tags_l;
+		tags_h = icpb->bank_tags_h;
+		if (mpc->mpc_mpd->mpd_board_def->asic == SSP64) {
+			/* SSP64 */
+			tagp = icpi->cin_dma_hi << 16;
+			tagp |= dma_ptr;
+		} else
+			/* SSP4 */
+			tagp = dma_ptr;
+
+		if (fifo_cnt > 4) {
+			int h_tagp = tagp + 4;
+			if (h_tagp > (u16) (mpc->mpc_rxq.q_end - 1))
+				h_tagp = (u16) mpc->mpc_rxq.q_begin;
+			tagptr[h_tagp >> 2] &= ~fifo_mask[fifo_cnt];
+			tagptr[h_tagp >> 2] |= tags_h &
fifo_mask[fifo_cnt];
+			tagptr[tagp >> 2] &= ~fifo_mask[4];
+			tagptr[tagp >> 2] |= tags_l & fifo_mask[4];
+		} else {
+			tagptr[tagp >> 2] &= ~fifo_mask[fifo_cnt];
+			tagptr[tagp >> 2] |= tags_l &
fifo_mask[fifo_cnt];
+		}
+	}
+	if (fifo_cnt) {
+		for (i = 0; i < fifo_cnt; i++) {
+			mpc->mpc_rxq.q_addr[dma_ptr] = fifo[i];
+			if (dma_ptr++ > (u16) (mpc->mpc_rxq.q_end - 1))
+				dma_ptr = (u16) mpc->mpc_rxq.q_begin;
+		}
+	}
+
+	bp = mpc->mpc_rxq.q_addr + mpc->mpc_rxq.q_ptr;
+	while (rcv_cnt) {
+		int val_cnt = 0;
+		int code = 0;
+		int qptrCnt = mpc->mpc_rxq.q_ptr;
+		/* if error, find first invalid character based on tag
bits */
+		if (err) {
+			u8 *tagptr;
+			if (mpc->mpc_mpd->mpd_board_def->asic == SSP64)
+				/* SSP64 */
+				tagptr = (u8 *)
+				    mpc->mpc_mpd->icp[0].icp_tags_start;
+			else
+				/* SSP4 */
+				tagptr = (u8 *)
+				    mpc->mpc_mpd->icp[mpc->mpc_icpno].
+				    icp_tags_start;
+			if (mpc->mpc_mpd->mpd_board_def->asic == SSP64)
{
+				/* SSP64 */
+				tagp = icpi->cin_dma_hi << 16;
+				tagp |= mpc->mpc_rxq.q_ptr;
+			} else
+				/* SSP4 */
+				tagp = mpc->mpc_rxq.q_ptr;
+			while (val_cnt < rcv_cnt) {
+				tgp = tagptr + (tagp >> 2);
+				curtags = *tgp >> ((tagp % 4) * 2);
+				if ((curtags & 3) == 1) {
+					code = 1;
+					break;
+				} else if ((curtags & 3) == 2) {
+					code = 2;
+					break;
+				} else {
+					code = 0;
+				}
+				if (qptrCnt++ > (u16)
(mpc->mpc_rxq.q_end - 1)) {
+					qptrCnt = (u16)
mpc->mpc_rxq.q_begin;
+					if
(mpc->mpc_mpd->mpd_board_def->asic
+					    == SSP64) {
+						/* SSP64 */
+						tagp = icpi->cin_dma_hi
<< 16;
+						tagp |=
+						    (u16)
mpc->mpc_rxq.q_begin;
+					} else
+						/* SSP4 */
+						tagp =
+						    (u16)
mpc->mpc_rxq.q_begin;
+				} else
+					tagp++;
+				val_cnt++;
+			}
+			rcv_cnt -= val_cnt;
+			/* Move as much data as the ld will take */
+			megainput_copy(mpc, cbuf, val_cnt);
+			memset(fbuf, 0, val_cnt);
+			cbuf += val_cnt;
+			fbuf += val_cnt;
+			ldisc_count += val_cnt;
+			val_cnt = 0;
+			if (code) {
+				unsigned char c =
+				    *(mpc->mpc_rxq.q_addr +
mpc->mpc_rxq.q_ptr);
+				/* c is an error character */
+				if (code == 1) {
+					ldisc_count++;
+					*fbuf++ = TTY_PARITY;
+					*cbuf++ = c;
+					mpc->mpc_parity_err_cnt++;
+				} else if (code == 2) {
+					ldisc_count++;
+					*fbuf++ = TTY_FRAME;
+					*cbuf++ = c;
+					mpc->mpc_framing_err_cnt++;
+				} else {
+					ldisc_count++;
+					*fbuf++ = TTY_NORMAL;
+					*cbuf++ = c;
+				}
+				rcv_cnt--;
+				mpc->mpc_input++;
+				if (++mpc->mpc_rxq.q_ptr >
mpc->mpc_rxq.q_end) {
+					mpc->mpc_rxq.q_ptr =
+					    mpc->mpc_rxq.q_begin;
+					bp = mpc->mpc_rxq.q_addr +
+					    mpc->mpc_rxq.q_ptr;
+				}
+				if ((mpc->mpc_flags & MPC_DSCOPER)
+				    && (eqnx_dscope[0].chan ==
+					(mpc - eqnx_chan))) {
+
+					int d = 0;
+
eqnx_dscope[d].buffer[eqnx_dscope[d].
+							      next] = c;
+					if (eqnx_dscope[d].next ==
+					    eqnx_dscope[d].q.q_ptr) {
+
eqnx_dscope[d].scope_wait_wait
+						    = 0;
+						wake_up_interruptible
+						    (&eqnx_dscope[d].
+						     scope_wait);
+					}
+					if (eqnx_dscope[d].next++ ==
+					    eqnx_dscope[d].q.q_ptr)
+						eqnx_dscope[d].status |=
+						    DSQWRAP;
+					if (eqnx_dscope[d].next >
+					    eqnx_dscope[d].q.q_end)
+						eqnx_dscope[d].next =
+
eqnx_dscope[d].q.q_begin;
+				}
+			} else if (rcv_cnt) {
+				dev_warn(mpd->dev, "Unknown error code "
+					 "value %d", code);
+				break;
+			}
+		} else {
+			megainput_copy(mpc, cbuf, rcv_cnt);
+			memset(fbuf, 0, rcv_cnt);
+			ldisc_count += rcv_cnt;
+			rcv_cnt = 0;
+		}
+	}
+	SET_TAIL(mpc->mpc_rxbase + mpc->mpc_rxq.q_ptr);
+
+	dev_dbg(mpd->dev, "megainput: calling n_tty_receive_buf with %d
"
+		"chars for device %d\n",
+		ldisc_count, SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+	tty_flip_buffer_push(tp);
+}
+
+/*
+ * rxint_cs_change(mpc)
+ *
+ * Process an input control signal transition.  In the usual
+ * case, a transition indicates a change in the data carrier
+ * detect.
+ *
+ * mpc	= pointer to channel structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void rxint_cs_change(struct mpchan *mpc)
+{
+	volatile struct cin_bnk_struct *icpb = mpc->mpc_icpb;
+	struct tty_struct *tp;
+	ushort dcd;
+	int old_carr_state;
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "rxint_cs_change: mpd lock
!locked\n");
+#endif
+
+	if (mpc->mpc_tty == (struct tty_struct *)NULL)
+		return;
+	if (!(SSTRD16(mpc->mpc_icpi->cin_attn_ena) & ENA_DCD_CNG))
+		return;
+
+	tp = mpc->mpc_tty;
+	dcd = SSTRD16(icpb->bank_signals) & CIN_DCD;
+	dcd = dcd >> 1;
+
+	old_carr_state = mpc->carr_state;
+	if (dcd && (!mpc->carr_state)) {
+		mpc->carr_state = 1;
+		mpc->open_wait_wait = 0;
+		wake_up_interruptible(&mpc->open_wait);
+		dev_dbg(mpd->dev, "rxint_cs_change: waking up device
%d\n",
+			SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+	}
+
+	if (!dcd)
+		mpc->carr_state = 0;
+
+	if ((!dcd) && (!(mpc->flags & ASYNC_CALLOUT_NOHUP))) {
+
+#ifdef DEBUG
+		dev_dbg(mpd->dev, "rxint_cs_change: hanging up device
%d\n"
+			SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+#endif
+		tty_hangup(tp);
+	}
+}
+
+/*
+ * rxint_break(mpc, flags)
+ *
+ * Process an input break received.
+ *
+ * mpc	= pointer to channel structure.
+ * flags = lock flags.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ * NOTE - lock is dropped and then re-locked to do input 
+ */
+static void rxint_break(struct mpchan *mpc, unsigned long flags)
+{
+	struct tty_struct *tty = mpc->mpc_tty;
+	char fbuf, cbuf;
+#ifdef	DEBUG_LOCKS
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "rxint_break: mpd lock !locked\n");
+#endif
+
+	if (mpc->mpc_tty == (struct tty_struct *)NULL)
+		return;
+
+	if (mpc->mpc_cin_events & EV_BREAK_CNG) {
+		if (tty->receive_room) {
+			fbuf = TTY_BREAK;
+			cbuf = 0;
+			mpc->mpc_break_cnt++;
+			if (mpc->flags & ASYNC_SAK)
+				do_SAK(tty);
+#ifdef DEBUG
+			dev_dbg(mpd->dev, "rxint_break: break for device
%d\n",
+				SSTMINOR(mpc->mpc_major,
mpc->mpc_minor));
+#endif
+			/*
+			 * drop mpdev board lock, reacquire after
receive_buf
+			 */
+			spin_unlock_irqrestore(&mpc->mpc_mpd->mpd_lock,
flags);
+			tty->ldisc.receive_buf(tty, &cbuf, &fbuf, 1);
+			spin_lock_irqsave(&mpc->mpc_mpd->mpd_lock,
flags);
+		}
+	}
+}
