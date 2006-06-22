Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWFVNUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWFVNUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWFVNUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:20:31 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:28813 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1161107AbWFVNU3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:20:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 9/13] Equinox SST driver: tty interface
Date: Thu, 22 Jun 2006 09:20:28 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B7110E@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 9/13] Equinox SST driver: tty interface
Thread-Index: AcaV/qDMC2UBD9aERnyGI5R4B+nsmQ==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 9: new source file: drivers/char/eqnx/sst_tty.c.  Provides the
standard
TTY interface routines for the SST driver.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 sst_tty.c | 1961
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1961 insertions(+)

diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/sst_tty.c
linux-2.6.17.eqnx/drivers/char/eqnx/sst_tty.c
--- linux-2.6.17/drivers/char/eqnx/sst_tty.c	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/sst_tty.c	2006-06-20
09:50:09.000000000 -0400
@@ -0,0 +1,1961 @@
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
+ * standard tty interface routines
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+
+#ifdef CONFIG_MODVERSIONS
+#define MODVERSIONS	1
+#endif
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/wait.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <asm/uaccess.h>
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
+/* defer call to write_wakeup */
+int eqnx_write_wakeup_deferred = 0;
+
+/* local buffer for copying output characters. Used in eqnx_put_char */
+extern char *eqnx_txcookbuf;
+static int eqnx_txcooksize = 0;
+static int eqnx_txcookrealsize = 0;
+static struct tty_struct *eqnx_txcooktty = (struct tty_struct *)NULL;
+
+#define	MY_GROUP()	(process_group(current))
+
+static void chanon(struct mpchan *mpc);
+static void chanoff(struct mpchan *mpc);
+static void eqnx_write_SSP64(struct mpchan *mpc, unsigned char *buf,
int count);
+void eqnx_write_SSP4(struct mpchan *mpc, int func_type);
+void eqnx_flush_chars(struct tty_struct *tty);
+static void eqnx_flush_chars_locked(struct tty_struct *tty);
+void eqnx_flush_buffer_locked(struct tty_struct *tty);
+static void delay_jiffies(int);
+extern int SSTMINOR(unsigned int, unsigned int);
+
+/**********************************************************************
*****/
+/* external variable and routines
*/
+/**********************************************************************
*****/
+
+extern int eqnx_nssps;
+extern struct mpdev eqnx_dev[MAXSSP];
+extern struct mpchan *eqnx_chan;
+extern struct datascope eqnx_dscope[2];
+extern char *eqnx_tmpwritebuf;
+extern struct semaphore eqnx_tmpwritesem;
+
+extern void eqnx_megaparam(int);
+extern int eqnx_modem(int, int);
+extern void eqnx_frame_wait(struct mpchan *, int);
+extern void eqnx_chnl_sync(struct mpchan *);
+extern int SSTMINOR(unsigned int, unsigned int);
+extern u32 eqnx_get_modem_info(struct mpchan *);
+extern void eqnx_set_modem_info(struct mpchan *, unsigned int, unsigned
int,
+				struct tty_struct *);
+
+/*
+ * eqnx_open(tty, filp)
+ *
+ * Open of tty device associated with SST channel.
+ *
+ * tty	= pointer to tty structure being opened.
+ * filp	= file structure.
+ */
+int eqnx_open(struct tty_struct *tty, struct file *filp)
+{
+	struct mpchan *mpc;
+	struct tty_struct *tp;
+	struct mpdev *mpd;
+	int d, minor, major, nchan, rc = 0;
+	unsigned long flags;
+
+	major = tty->driver->major;
+	minor = tty->driver->minor_start + tty->index;
+
+	d = SSTMINOR(major, minor);
+
+	/* validate channel number */
+	if ((d > (eqnx_nssps * MAXCHNL_BRD)) || (eqnx_nssps == 0) || (d
< 0))
+		return (-ENODEV);
+
+	mpc = &eqnx_chan[d];
+	mpd = mpc->mpc_mpd;
+
+	/* validate that the board for this channel is valid and alive
*/
+	if ((mpd == (struct mpdev *)NULL) || (!(mpd->mpd_alive)))
+		return (-ENODEV);
+
+	dev_dbg(mpd->dev, "eqnx_open: device %d\n", d);
+
+	mpc->mpc_major = major;
+	mpc->mpc_minor = minor;
+
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+
+	/* verify that the channel is valid and alive */
+	nchan = MPCHAN(d);
+	if ((mpd >= &eqnx_dev[eqnx_nssps]) || (!(mpd->mpd_alive)) ||
+	    (nchan >= (int)mpd->mpd_nchan) ||
+	    (mpc->mpc_icp->icp_rng_state != RNG_GOOD) ||
+	    (mpc->mpc_icp->lmx[mpc->mpc_lmxno].lmx_active != DEV_GOOD))
{
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		return (-ENODEV);
+	}
+
+	/* if a bridge, check the mux */
+	if (mpc->mpc_icp->lmx[mpc->mpc_lmxno].lmx_bridge)
+		if (mpc->mpc_icp->lmx[mpc->mpc_lmxno].lmx_rmt_active !=
+		    DEV_GOOD) {
+			spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+			return (-ENODEV);
+		}
+
+	/* Do not allow ports to open on SST-16 boards without a panel
*/
+	if (mpd->mpd_board_def->flags & NOPANEL) {
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		return (-ENODEV);
+	}
+
+	/* check for channel number outside valid range, SSP64 only */
+	if (mpd->mpd_board_def->asic == SSP64) {
+		if ((MPCHAN(d) % 16) >=
+		    mpc->mpc_icp->lmx[mpc->mpc_lmxno].lmx_chan) {
+			dev_dbg(mpd->dev, "eqnx_open: mpchan(%d) "
+				"lmx_no(%d) lmx_chan(%d)\n",
+				MPCHAN(d), mpc->mpc_lmxno,
+
mpc->mpc_icp->lmx[mpc->mpc_lmxno].lmx_chan);
+			spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+			return (-ENODEV);
+		}
+	}
+
+	mpc->refcount++;
+
+	/* initialize termios struct if required */
+	mpc->mpc_tty = tty;
+	tp = tty;
+	if (tty->termios == NULL) {
+		*tty->termios = *mpc->normaltermios;
+	}
+
+	if (!(mpc->flags & ASYNC_INITIALIZED)) {
+		tty->driver_data = mpc;
+
+		/* force CLOCAL on for RS422 ports */
+		if ((mpc->mpc_icp->lmx[mpc->mpc_lmxno].lmx_id ==
LMX_8E_422) ||
+		    (mpc->mpc_icp->lmx[mpc->mpc_lmxno].lmx_id ==
LMX_PM16_422))
+			tty->termios->c_cflag |= CLOCAL;
+
+		if ((mpc->mpc_flags & MPC_OPEN) == 0) {
+			dev_dbg(mpd->dev, "eqnx_open: device %d "
+				"calling megaparam\n", d);
+			chanon(mpc);
+			eqnx_megaparam(d);
+		}
+
+		mpc->carr_state = eqnx_modem(d, TURNON);
+		mpc->flags |= ASYNC_INITIALIZED;
+		clear_bit(TTY_IO_ERROR, &tty->flags);
+	}
+
+	/*
+	 * If port is in the middle of closing, then wait. Get error
status
+	 * from flag settings.
+	 */
+	if (mpc->flags & ASYNC_CLOSING) {
+		dev_dbg(mpd->dev, "eqnx_open: sleeping on close_wait "
+			"for device %d\n", d);
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		wait_event_interruptible(mpc->close_wait,
+					 (mpc->flags & ASYNC_CLOSING) ==
0);
+		if (mpc->flags & ASYNC_HUP_NOTIFY)
+			return (-EAGAIN);
+
+		return (-ERESTARTSYS);
+	}
+
+	/* callin device is only one available */
+	if (1) {
+		dev_dbg(mpd->dev, "eqnx_open: opening dialin device
%d\n", d);
+		if (filp->f_flags & O_NONBLOCK) {
+			dev_dbg(mpd->dev, "eqnx_open: opening dialin
device "
+				"%d non_blocking with c_flags = %o\n",
+				d, tp->termios->c_cflags);
+		} else {
+			mpc->openwaitcnt++;
+			if (mpc->refcount)
+				mpc->refcount--;
+
+			while (1) {
+				mpc->carr_state = eqnx_modem(d, TURNON);
+
+				if (tty_hung_up_p(filp) ||
+				    ((mpc->flags & ASYNC_INITIALIZED) ==
0)) {
+					if (mpc->flags &
ASYNC_HUP_NOTIFY)
+						rc = -EBUSY;
+					else
+						rc = -ERESTARTSYS;
+					break;
+				}
+
+				/* if CLOCAL set, allow the open */
+				if (((mpc->flags & ASYNC_CLOSING) == 0)
&&
+				    ((tp->termios->c_cflag & CLOCAL) ||
+				     (mpc->carr_state)))
+					break;
+
+				if (signal_pending(current)) {
+					rc = -ERESTARTSYS;
+					break;
+				}
+
+				dev_dbg(mpd->dev, "eqnx_open: device %d
"
+					"sleeping on open_wait\n", d);
+
+				/* wait while DCD is low */
+				mpc->open_wait_wait++;
+				spin_unlock_irqrestore(&mpd->mpd_lock,
flags);
+				wait_event_interruptible(mpc->open_wait,
+
mpc->open_wait_wait ==
+							 0);
+				spin_lock_irqsave(&mpd->mpd_lock,
flags);
+				if (signal_pending(current)) {
+					rc = -ERESTARTSYS;
+					break;
+				}
+				if (mpc->carr_state)
+					break;
+			}
+			if (!tty_hung_up_p(filp))
+				mpc->refcount++;
+			mpc->openwaitcnt--;
+			if (rc < 0) {
+				spin_unlock_irqrestore(&mpd->mpd_lock,
flags);
+				dev_dbg(mpd->dev, "eqnx_open: device %d
"
+					"open fail w/ c_cflag=%o
carr_stat=%d, "
+					"rc=%d\n",
+					d, tp->termios->c_cflag,
+					mpc->carr_state, rc);
+				return (rc);
+			}
+		}
+		dev_dbg(mpd->dev, "eqnx_open: device %d open fail w/ "
+			"c_cflag=%o, carr_stat=%d, rc=%d\n",
+			d, tp->termios->c_cflag, mpc->carr_state, rc);
+		mpc->flags |= ASYNC_NORMAL_ACTIVE;
+	}
+
+	if ((mpc->refcount == 1) && (mpc->flags & ASYNC_SPLIT_TERMIOS))
{
+		*tp->termios = *mpc->normaltermios;
+	}
+
+	/* SSP4 channel setup */
+	if ((mpd->mpd_board_def->asic != SSP64) && (!mpc->xmit_buf)) {
+		unsigned long page;
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		page = get_zeroed_page(GFP_KERNEL);
+		if (!page)
+			return (-ENOMEM);
+
+		spin_lock_irqsave(&mpd->mpd_lock, flags);
+		mpc->xmit_buf = (unsigned char *)page;
+		mpc->xmit_head = 0;
+	}
+	mpc->pgrp = MY_GROUP();
+
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+
+	return (0);
+}
+
+/*
+ * eqnx_close(tty, filp)
+ *
+ * Close of tty device associated with SST channel.
+ * Called on last close of any device.
+ * Release resources, reset device, and wakeup any sleepers
+ * waiting for channel to become idle.
+ * 
+ * tty	= pointer to tty structure.
+ * filp	= file structure.
+ */
+void eqnx_close(struct tty_struct *tty, struct file *filp)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	int nchan, d;
+	unsigned long flags;
+	u16 attn;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	if ((mpd = mpc->mpc_mpd) == (struct mpdev *)NULL)
+		return;
+	nchan = MPCHAN(d);
+	if ((mpd >= &eqnx_dev[eqnx_nssps]) || (!(mpd->mpd_alive)) ||
+	    (nchan >= (int)mpd->mpd_nchan))
+		return;
+
+	dev_dbg(mpd->dev, "eqnx_close: device %d being closed\n", d);
+
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+	if (tty_hung_up_p(filp)) {
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		return;
+	}
+	dev_dbg(mpd->dev, "eqnx_close: device %d being closed with "
+		"refcount = %d\n", d, mpc->refcount);
+	/* do nothing if not final close */
+	if (mpc->refcount)
+		mpc->refcount -= 1;
+	if (mpc->refcount) {
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		return;
+	}
+
+	mpc->flags |= ASYNC_CLOSING;
+	if (mpc->flags & ASYNC_NORMAL_ACTIVE)
+		*mpc->normaltermios = *tty->termios;
+	if (tty == eqnx_txcooktty)
+		eqnx_flush_chars_locked(tty);
+	tty->closing = true;
+
+	/* wait for all data to be sent if busy */
+	if (mpc->mpc_flags & MPC_BUSY) {
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		tty_wait_until_sent(tty, (unsigned
long)mpc->closing_wait);
+		spin_lock_irqsave(&mpd->mpd_lock, flags);
+	}
+
+	mpc->flags &= ~ASYNC_INITIALIZED;
+	if (tty->termios->c_cflag & HUPCL) {
+		mpc->flags &= ~ASYNC_INITIALIZED;
+		eqnx_modem(d, TURNOFF);
+	}
+
+	mpc->mpc_flags &= ~(MPC_SOFTCAR | MPC_DIALOUT | MPC_MODEM |
+			    MPC_DIALIN | MPC_CTS);
+	attn = SSTRD16(mpc->mpc_icpi->cin_attn_ena);
+	attn &= ~ENA_DCD_CNG;
+	SSTWR16(mpc->mpc_icpi->cin_attn_ena, attn);
+	mpc->mpc_icpo->cout_cpu_req &= ~TX_SUSP;
+	set_bit(TTY_IO_ERROR, &tty->flags);
+	if (tty->ldisc.flush_buffer)
+		(tty->ldisc.flush_buffer) (tty);
+	chanoff(mpc);
+
+	eqnx_flush_buffer_locked(tty);
+	tty->closing = false;
+	tty->driver_data = (void *)NULL;
+	mpc->mpc_tty = (struct tty_struct *)NULL;
+
+	/* wakeup open waiters */
+	if (mpc->openwaitcnt) {
+		if (mpc->close_delay) {
+			spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+			delay_jiffies(mpc->close_delay);
+			spin_lock_irqsave(&mpd->mpd_lock, flags);
+		}
+		dev_dbg(mpd->dev, "eqnx_close: waking up open_waiters
for "
+			"device %d\n", d);
+		mpc->open_wait_wait = 0;
+		wake_up_interruptible(&mpc->open_wait);
+	}
+
+	/* SSP channel cleanup */
+	if ((mpd->mpd_board_def->asic != SSP64) && (mpc->xmit_buf)) {
+		free_page((unsigned long)mpc->xmit_buf);
+		mpc->xmit_buf = NULL;
+	}
+
+	mpc->flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CLOSING);
+	dev_dbg(mpd->dev, "eqnx_close: close complete for device %d\n",
d);
+	wake_up_interruptible(&mpc->close_wait);
+	eqnx_write_wakeup_deferred = 0;
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+	return;
+}
+
+/*
+ * eqnx_write(tty, buf, count)
+ *
+ * Write data bytes to the tty device.  In 2.6 kernel, buffer
+ * is always in kernel space.
+ *
+ * Return with the number of bytes accepted.
+ *
+ * tty	= pointer to tty structure.
+ * buf	= buffer of bytes to write.
+ * count = number of bytes to write.
+ */
+int eqnx_write(struct tty_struct *tty, const unsigned char *buf, int
count)
+{
+	struct mpchan *mpc;
+	int space, nx, d, qsize, written = 0, c = 0, datascope = 0;
+	volatile union global_regs_u *icpg;
+	volatile struct icp_out_struct *icpo;
+	volatile struct cout_que_struct *icpq;
+	unsigned char oldreg, *b;
+	struct mpdev *mpd;
+	unsigned long flags;
+	u16 qcnt, attn_enbl;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return (-ENODEV);
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return (-ENODEV);
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return (-ENODEV);
+
+	mpd = mpc->mpc_mpd;
+	dev_dbg(mpd->dev, "eqnx_write: tty=%d, count=%d\n",
+		(unsigned int)SSTMINOR(mpc->mpc_major, mpc->mpc_minor),
count);
+
+	if (tty == eqnx_txcooktty)
+		eqnx_flush_chars(tty);
+
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+	icpo = mpc->mpc_icpo;
+	icpg = (volatile union global_regs_u *)icpo;
+	icpq = &icpo->cout_q0;
+
+	qsize = mpc->mpc_txq.q_size;
+	space = qsize - (mpc->mpc_count + SSTRD16(icpq->q_data_count)) -
1;
+	if (!tty->stopped && !tty->hw_stopped && space >= (qsize >> 4))
{
+		if ((mpd->mpd_board_def->asic != SSP64) &&
(mpc->xmit_cnt))
+			goto ssp_end;
+		dev_dbg(mpd->dev, "eqnx_write: device = %d, q_size = %d,
"
+			"space = %d\n",
+			SSTMINOR(mpc->mpc_major, mpc->mpc_minor),
+			mpc->mpc_txq.q_size, space);
+		c = MIN(space, count);
+		b = (unsigned char *)buf;
+
+		mpc->mpc_flags |= MPC_BUSY;
+		if ((mpc->mpc_flags & MPC_DSCOPEW) &&
+		    (eqnx_dscope[1].chan == (mpc - eqnx_chan)))
+			datascope = 1;
+
+		while (c > 0) {
+			/* copy data directly from buffer to SSP queue
*/
+			nx = MIN(c, (mpc->mpc_txq.q_end -
+				     mpc->mpc_txq.q_ptr + 1));
+			memcpy((mpc->mpc_txq.q_addr +
mpc->mpc_txq.q_ptr),
+			       b, nx);
+			mpc->mpc_txq.q_ptr += nx;
+			if (mpc->mpc_txq.q_ptr > mpc->mpc_txq.q_end)
+				mpc->mpc_txq.q_ptr =
mpc->mpc_txq.q_begin;
+
+			/* if datascope enabled, copy to datascope
buffers */
+			if (datascope) {
+				int room, move_cnt, d = 1;
+				unsigned char *ubase = b;
+				room = DSQSIZE - ((eqnx_dscope[d].next -
+
eqnx_dscope[d].q.q_ptr) &
+						  (DSQMASK));
+				if (nx > room)
+					eqnx_dscope[d].status |=
DSQWRAP;
+				else
+					room = nx;
+				while (room > 0) {
+					move_cnt = MIN(room,
+
eqnx_dscope[d].q.q_end -
+
eqnx_dscope[d].next + 1);
+					memcpy(eqnx_dscope[d].q.q_addr +
+					       eqnx_dscope[d].next,
ubase,
+					       move_cnt);
+					eqnx_dscope[d].next += move_cnt;
+					if (eqnx_dscope[d].next >
+					    eqnx_dscope[d].q.q_end)
+						eqnx_dscope[d].next =
+
eqnx_dscope[d].q.q_begin;
+					ubase += move_cnt;
+					room -= move_cnt;
+				}
+				eqnx_dscope[d].scope_wait_wait = 0;
+				wake_up_interruptible(&eqnx_dscope[d].
+						      scope_wait);
+			}
+
+			c -= nx;
+			count -= nx;
+			written += nx;
+			buf += nx;
+			b += nx;
+		}
+
+		oldreg = icpo->cout_cpu_req;
+		icpo->cout_cpu_req |= TX_SUSP;
+		eqnx_chnl_sync(mpc);
+
+		/* force the send if required */
+		qcnt = SSTRD16(icpq->q_data_count);
+		if (qcnt < 9) {
+			if ((icpo->cout_intnl_svd_toggls & TOGGLS_LSEND)
==
+			    (icpo->cout_cpu_req & CPU_SND_REQ)) {
+				icpo->cout_cpu_req ^= (CPU_SND_REQ);
+				mpc->mpc_cout_events &= ~EV_CPU_REQ_DN;
+			}
+		}
+		qcnt += written;
+		SSTWR16(icpq->q_data_count, qcnt);
+		space -= written;
+		dev_dbg(mpd->dev, "eqnx_write: wrote %d chars for device
%d\n",
+			written, SSTMINOR(mpc->mpc_major,
mpc->mpc_minor));
+		dev_dbg(mpd->dev, "eqnx_write: q data count %d, space %d
"
+			"for device %d\n",
+			qcnt, space, SSTMINOR(mpc->mpc_major,
mpc->mpc_minor));
+		if (!(oldreg & TX_SUSP))
+			icpo->cout_cpu_req &= ~TX_SUSP;
+		mpc->mpc_output += written;
+		attn_enbl = SSTRD16(icpo->cout_attn_enbl);
+		attn_enbl |= (ENA_TX_EMPTY_Q0 | ENA_TX_LOW_Q0);
+		SSTWR16(icpo->cout_attn_enbl, attn_enbl);
+	}
+
+ssp_end:
+	/* all done if SSP64 */
+	if (mpd->mpd_board_def->asic == SSP64) {
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		dev_dbg(mpd->dev, "eqnx_write: wrote %d bytes for device
%d\n",
+			written, d);
+		return (written);
+	}
+
+	/* now try to fill xmit_buf with the data */
+	while (count) {
+		dev_dbg(mpd->dev, "eqnx_write: fill xmit_buf with %d\n",
count);
+		c = MIN(count, MIN(XMIT_BUF_SIZE - mpc->xmit_cnt - 1,
+				   XMIT_BUF_SIZE - mpc->xmit_head));
+		if (c <= 0)
+			break;
+		b = (unsigned char *)buf;
+
+		if (mpc->xmit_buf == NULL)
+			break;
+		memcpy(mpc->xmit_buf + mpc->xmit_head, b, c);
+		mpc->xmit_head = (mpc->xmit_head + c) & (XMIT_BUF_SIZE -
1);
+		mpc->xmit_cnt += c;
+		buf += c;
+		count -= c;
+		written += c;
+		dev_dbg(mpd->dev, "eqnx_write: filled xmit_buf for
device "
+			"%d count %d\n", d, c);
+	}
+
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+	dev_dbg(mpd->dev, "eqnx_write: wrote %d bytes for device %d\n",
+		written, d);
+
+	return (written);
+}
+
+/*
+ * eqnx_put_char(tty, ch)
+ *
+ * Write single data byte to the tty device.  Note data is queued and
+ * flush call must be done to force to the device.
+ *
+ * tty	= pointer to tty structure.
+ * ch	= byte to write.
+ */
+void eqnx_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	unsigned long flags;
+	int d;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	mpd = mpc->mpc_mpd;
+	if (mpd == (struct mpdev *)NULL)
+		return;
+
+	dev_dbg(mpd->dev, "eqnx_put_char: tty=%d, ch=%x\n", d, (int)ch);
+
+	/* allocate tkcooktty buffer for queueing put_char bytes */
+	if (tty != eqnx_txcooktty) {
+		if (eqnx_txcooktty != (struct tty_struct *)NULL)
+			eqnx_flush_chars(eqnx_txcooktty);
+		eqnx_txcooktty = tty;
+	}
+
+	if (mpd->mpd_board_def->asic != SSP64) {
+		/* SSP4 */
+		spin_lock_irqsave(&mpd->mpd_lock, flags);
+		if (mpc->xmit_head >= (XMIT_BUF_SIZE - 1)) {
+			eqnx_flush_chars_locked(tty);
+			eqnx_txcooktty = tty;
+		}
+		if (mpc->xmit_buf != NULL) {
+			mpc->xmit_buf[mpc->xmit_head++] = ch;
+			mpc->xmit_head &= (XMIT_BUF_SIZE - 1);
+			mpc->xmit_cnt++;
+		}
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+
+		if (eqnx_write_wakeup_deferred) {
+			eqnx_write_wakeup_deferred = 0;
+			tty->ldisc.write_wakeup(tty);
+		}
+	} else {
+		/* SSP64 */
+		if (eqnx_txcooksize >= (XMIT_BUF_SIZE - 1)) {
+			eqnx_flush_chars(eqnx_txcooktty);
+			eqnx_txcooktty = tty;
+		}
+		eqnx_txcookbuf[eqnx_txcooksize++] = ch;
+	}
+}
+
+/*
+ * eqnx_flush_chars_locked(tty)
+ *
+ * Flush (actually drain) data bytes queued by put_char routine.
+ * Helper routine called by eqnx_flush_chars.
+ *
+ * tty	= pointer to tty structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void eqnx_flush_chars_locked(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	unsigned int d;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	mpd = mpc->mpc_mpd;
+	dev_dbg(mpd->dev, "eqnx_flush_chars_locked: tty=%d\n", d);
+
+	if (mpd == (struct mpdev *)NULL)
+		return;
+
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	if (eqnx_txcooktty == NULL)
+		return;
+	else {
+
+#ifdef	DEBUG_LOCKS
+		if (!(spin_is_locked(&mpd->mpd_lock)))
+			dev_dbg(mpd->dev, "eqnx_flush_chars_locked: mpd
"
+				"lock !locked\n");
+#endif
+
+		if (mpd->mpd_board_def->asic == SSP64) {
+			/* SSP64 */
+			unsigned int cooksize = eqnx_txcooksize;
+			eqnx_txcooksize = 0;
+			eqnx_txcookrealsize = 0;
+			eqnx_txcooktty = (struct tty_struct *)NULL;
+			if (cooksize == 0)
+				return;
+			dev_dbg(mpd->dev, "eqnx_flush_chars_locked: "
+				"calling eqnx_write_SSP64\n");
+			eqnx_write_SSP64(mpc, eqnx_txcookbuf, cooksize);
+		} else {
+			/* SSP4 */
+			if (mpc->xmit_cnt == 0)
+				return;
+			dev_dbg(mpd->dev, "eqnx_flush_chars_locked: "
+				"calling eqnx_write_SSP4\n");
+			eqnx_write_SSP4(mpc, EQNX_COOKED);
+		}
+	}
+}
+
+/*
+ * eqnx_flush_chars(tty)
+ *
+ * Flush (actually drain) data bytes queued by put_char routine.
+ *
+ * tty	= pointer to tty structure.
+ *
+ * mpdev (board-level) lock ** MUST NOT ** be held.
+ */
+void eqnx_flush_chars(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	unsigned int d;
+	unsigned long flags;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	mpd = mpc->mpc_mpd;
+	if (mpd == (struct mpdev *)NULL)
+		return;
+
+	if (eqnx_txcooktty == NULL)
+		return;
+	else {
+
+#ifdef	DEBUG_LOCKS
+		if (spin_is_locked(&mpd->mpd_lock))
+			dev_dbg(mpd->dev, "eqnx_flush_chars: mpd lock "
+				"already held\n");
+#endif
+
+		spin_lock_irqsave(&mpd->mpd_lock, flags);
+		eqnx_flush_chars_locked(tty);
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+
+		if (eqnx_write_wakeup_deferred) {
+			eqnx_write_wakeup_deferred = 0;
+			tty->ldisc.write_wakeup(tty);
+		}
+	}
+}
+
+/*
+ * eqnx_write_room(tty)
+ *
+ * Return amount of room available for a write.
+ *
+ * tty = pointer to tty structure.
+ */
+int eqnx_write_room(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	volatile struct cout_que_struct *icpq;
+	volatile struct icp_out_struct *icpo;
+	unsigned int space;
+	int d;
+	unsigned long flags;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return (-ENODEV);
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return (-ENODEV);
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return (-ENODEV);
+
+	mpd = mpc->mpc_mpd;
+	if (mpd == (struct mpdev *)NULL)
+		return (-ENODEV);
+
+	dev_dbg(mpd->dev, "eqnx_write_room: device = %d\n", d);
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+
+	if (mpd->mpd_board_def->asic != SSP64) {
+		/* SSP4 */
+		int ret;
+		ret = (XMIT_BUF_SIZE - mpc->xmit_cnt - 1);
+		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		if (ret < 0)
+			return (0);
+		return (ret);
+	}
+
+	if (tty == eqnx_txcooktty) {
+		if (eqnx_txcookrealsize != 0) {
+			space = (eqnx_txcookrealsize - eqnx_txcooksize);
+			spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+			return (space);
+		}
+	}
+
+	icpo = mpc->mpc_icpo;
+	icpq = &icpo->cout_q0;
+	space = mpc->mpc_txq.q_size - (mpc->mpc_count +
+				       SSTRD16(icpq->q_data_count)) - 1;
+	if (tty == eqnx_txcooktty) {
+		eqnx_txcookrealsize = space;
+		space -= eqnx_txcooksize;
+	}
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+	return (space);
+}
+
+/*
+ * eqnx_chars_in_buffer(tty)
+ *
+ * Return number of data bytes buffered to be output
+ *
+ * tty	= pointer to tty structure.
+ */
+int eqnx_chars_in_buffer(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	unsigned long flags;
+	volatile struct cout_que_struct *icpq;
+	volatile struct icp_out_struct *icpo;
+	unsigned int count;
+	int d;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return (-ENODEV);
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return (-ENODEV);
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return (-ENODEV);
+
+	mpd = mpc->mpc_mpd;
+	if (mpd == (struct mpdev *)NULL)
+		return (-ENODEV);
+
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+	icpo = mpc->mpc_icpo;
+	icpq = &icpo->cout_q0;
+	count = SSTRD16(icpq->q_data_count);
+
+	/*
+	 * for SSP4, include include internal buffer in addition
+	 * to number of data bytes queued to the SSP
+	 */
+	if (mpc->mpc_mpd->mpd_board_def->asic != SSP64)
+		count += mpc->xmit_cnt;
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+	dev_dbg(mpd->dev, "eqnx_chars_in_buffer: count for device %d = "
+		"%d\n", d, count);
+	return (count);
+}
+
+/*
+ * eqnx_throttle(tty)
+ *
+ * Stop queuing input to the line discipline.
+ *
+ * tty	= pointer to tty structure.
+ */
+void eqnx_throttle(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	int d;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	mpd = mpc->mpc_mpd;
+	dev_dbg(mpd->dev, "eqnx_throttle: device %d\n",
+		SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+	mpc->mpc_block = true;
+}
+
+/*
+ * eqnx_unthrottle(tty)
+ *
+ * Resume queuing input to the line discipline.
+ *
+ * tty	= pointer to tty structure.
+ */
+void eqnx_unthrottle(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	int d;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	mpd = mpc->mpc_mpd;
+	dev_dbg(mpd->dev, "eqnx_unthrottle: device %d\n",
+		SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+	mpc->mpc_block = false;
+}
+
+/*
+ * eqnx_flush_buffer_locked(tty)
+ *
+ * Flush all input and output queued data.
+ * Helper routine called by eqnx_flush_buffer.
+ *
+ * tty	= pointer to tty structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held
+ */
+void eqnx_flush_buffer_locked(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	volatile struct icp_in_struct *icpi;
+	volatile struct icp_out_struct *icpo;
+	volatile struct cout_que_struct *icpq;
+	volatile struct cin_bnk_struct *icpb;
+	u8 cin;
+	u16 nxt_dma;
+	int d;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	mpd = mpc->mpc_mpd;
+	if (mpd == (struct mpdev *)NULL)
+		return;
+
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "eqnx_flush_buffer_locked: mpd lock
not "
+			"locked\n");
+#endif
+
+	icpi = mpc->mpc_icpi;
+	icpo = mpc->mpc_icpo;
+	icpq = &icpo->cout_q0;
+
+	dev_dbg(mpd->dev, "eqnx_flush_buffer_locked: device = %d\n", d);
+	if (tty == eqnx_txcooktty) {
+		eqnx_txcooktty = (struct tty_struct *)NULL;
+		eqnx_txcooksize = 0;
+		eqnx_txcookrealsize = 0;
+	}
+
+	/* flush transmit buffers */
+	icpo->cout_lck_cntrl |= LCK_Q_ACT;
+	eqnx_chnl_sync(mpc);
+	icpo->cout_dma_stat_save = 0;
+	icpo->cout_intnl_fifo_ptrs = 0;
+	SSTWR16(icpq->q_data_count, 0);
+	mpc->mpc_count = 0;
+	SSTWR16(icpq->q_data_ptr_l, (mpc->mpc_txq.q_begin +
mpc->mpc_txbase));
+	mpc->mpc_txq.q_ptr = mpc->mpc_txq.q_begin;
+	mpc->xmit_cnt = mpc->xmit_head = mpc->xmit_tail = 0;
+	SSTWR16(icpo->cout_attn_enbl, EN_REG_UPDT_EV);
+	icpo->cout_lck_cntrl &= ~LCK_Q_ACT;
+	mpc->mpc_flags &= ~MPC_BUSY;
+
+	/* flush receiver queue */
+	/* set rx ptr = tail */
+	icpb = (icpi->cin_locks & LOCK_A) ? &icpi->cin_bank_b :
+	    &icpi->cin_bank_a;
+	/* wait for valid registers */
+	if (!(SSTRD16(icpb->bank_events) & EV_REG_UPDT))
+		eqnx_frame_wait(mpc, 2);
+	cin = icpi->cin_locks;
+	icpi->cin_locks = cin | (DIS_BANK_A | DIS_BANK_B);
+	eqnx_chnl_sync(mpc);
+	icpi->cin_bank_a.bank_fifo_lvl &= ~0x8f;
+	icpi->cin_bank_b.bank_fifo_lvl &= ~0x8f;
+	nxt_dma = SSTRD16(icpb->bank_nxt_dma);
+	SSTWR16(icpi->cin_tail_ptr_a, nxt_dma);
+	SSTWR16(icpi->cin_tail_ptr_b, nxt_dma);
+	mpc->mpc_rxq.q_ptr = nxt_dma;
+	icpi->cin_locks = cin;
+	mpc->mpc_flags |= MPC_RXFLUSH;
+	mpc->mpc_block = false;
+	wake_up_interruptible(&tty->write_wait);
+
+	/* signal write wakeup when safe to call ldisc */
+	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+	    tty->ldisc.write_wakeup)
+		eqnx_write_wakeup_deferred++;
+}
+
+/*
+ * eqnx_flush_buffer(tty)
+ *
+ * Flush all input and output queued data.
+ *
+ * tty	= pointer to tty structure.
+ *
+ * mpdev (board-level) lock ** MUST NOT ** be held
+ */
+void eqnx_flush_buffer(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	unsigned long flags;
+	int d;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	mpd = mpc->mpc_mpd;
+	if (mpd == (struct mpdev *)NULL)
+		return;
+
+#ifdef	DEBUG_LOCKS
+	if (spin_is_locked(&mpd->mpd_lock))
+		dev_dbg(mpd->dev, "eqnx_flush_buffer: mpd lock already "
+			"held\n");
+#endif
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+	eqnx_flush_buffer_locked(tty);
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+
+	if (eqnx_write_wakeup_deferred) {
+		eqnx_write_wakeup_deferred = 0;
+		tty->ldisc.write_wakeup(tty);
+	}
+}
+
+/*
+ * eqnx_stop(tty)
+ *
+ * Stop queueing data bytes to be output.
+ *
+ * tty	= pointer to tty structure.
+ */
+void eqnx_stop(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	volatile struct icp_out_struct *icpo;
+	unsigned long flags;
+	int d;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	mpd = mpc->mpc_mpd;
+	if (mpd == (struct mpdev *)NULL)
+		return;
+
+	icpo = mpc->mpc_icpo;
+	dev_dbg(mpd->dev, "eqnx_stop: device %d\n", d);
+
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+
+	/* suspend output */
+	icpo->cout_cpu_req |= CPU_PAUSE;
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+}
+
+/*
+ * eqnx_start(tty)
+ *
+ * Re-start queueing data bytes to be output.
+ *
+ * tty	= pointer to tty structure.
+ */
+void eqnx_start(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	volatile struct icp_out_struct *icpo;
+	unsigned long flags;
+	int d;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	mpd = mpc->mpc_mpd;
+	if (mpd == (struct mpdev *)NULL)
+		return;
+
+	icpo = mpc->mpc_icpo;
+	dev_dbg(mpd->dev, "eqnx_start: device %d\n", d);
+
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+
+	/* resume output */
+	icpo->cout_cpu_req &= ~CPU_PAUSE;
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+}
+
+/*
+ * eqnx_hangup(tty)
+ *
+ * Hangup tty device.
+ * Drop control signals, flush buffer, and close port.
+ *
+ * tty	= pointer to tty structure.
+ */
+void eqnx_hangup(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	unsigned long flags;
+	int d;
+	u16 attn;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	mpd = mpc->mpc_mpd;
+	if (mpd == (struct mpdev *)NULL)
+		return;
+
+	dev_dbg(mpd->dev, "eqnx_hangup: device %d\n", d);
+
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+
+	mpc->flags &= ~ASYNC_INITIALIZED;
+	if (mpc->flags & ASYNC_NORMAL_ACTIVE)
+		*mpc->normaltermios = *tty->termios;
+	if (tty == eqnx_txcooktty)
+		eqnx_flush_chars_locked(tty);
+	if (tty->termios->c_cflag & HUPCL)
+		eqnx_modem(d, TURNOFF);
+
+	mpc->mpc_flags &= ~(MPC_SOFTCAR | MPC_DIALOUT | MPC_MODEM |
+			    MPC_DIALIN | MPC_CTS);
+	attn = SSTRD16(mpc->mpc_icpi->cin_attn_ena);
+	attn &= ~ENA_DCD_CNG;
+	SSTWR16(mpc->mpc_icpi->cin_attn_ena, attn);
+	chanoff(mpc);
+	eqnx_flush_buffer_locked(tty);
+	set_bit(TTY_IO_ERROR, &tty->flags);
+	mpc->flags &= ~ASYNC_NORMAL_ACTIVE;
+	mpc->mpc_tty = (struct tty_struct *)NULL;
+	mpc->refcount = 0;
+
+	/* reset SSP4 xmit buf variables */
+	if ((mpd->mpd_board_def->asic != SSP64) && (mpc->xmit_buf)) {
+		free_page((unsigned long)mpc->xmit_buf);
+		mpc->xmit_buf = NULL;
+		mpc->xmit_cnt = 0;
+		mpc->xmit_head = 0;
+		mpc->xmit_tail = 0;
+	}
+	mpc->open_wait_wait = 0;
+	wake_up_interruptible(&mpc->open_wait);
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+
+	if (eqnx_write_wakeup_deferred) {
+		eqnx_write_wakeup_deferred = 0;
+		tty->ldisc.write_wakeup(tty);
+	}
+}
+
+/*
+ * eqnx_set_termios(tty, old)
+ *
+ * Device termios structure has been modified.
+ *
+ * tty	= pointer to tty structure.
+ * old	= previous termios settings.
+ */
+void eqnx_set_termios(struct tty_struct *tty, struct termios *old)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	int d;
+	struct termios *tiosp;
+	unsigned long flags;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	mpd = mpc->mpc_mpd;
+	if (mpd == (struct mpdev *)NULL)
+		return;
+
+	dev_dbg(mpd->dev, "eqnx_set_termios: device %d\n", d);
+
+	tiosp = tty->termios;
+	if ((tiosp->c_cflag == old->c_cflag) &&
+	    (tiosp->c_iflag == old->c_iflag) &&
+	    (tiosp->c_cc[VSTOP] == old->c_cc[VSTOP]) &&
+	    (tiosp->c_cc[VSTART] == old->c_cc[VSTART]))
+		return;
+
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+	dev_dbg(mpd->dev, "eqnx_set_termios: calling megaparam dev
%d\n", d);
+	eqnx_megaparam(d);
+	if ((old->c_cflag & CRTSCTS) && ((tiosp->c_cflag & CRTSCTS) ==
0))
+		tty->hw_stopped = 0;
+	if (((old->c_cflag & CLOCAL) == 0) && (tiosp->c_cflag & CLOCAL))
{
+		mpc->carr_state = true;
+		mpc->open_wait_wait = 0;
+		wake_up_interruptible(&mpc->open_wait);
+	}
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+}
+
+/*
+ * eqnx_tiocmget(tty, file)
+ *
+ * return state of control signals.
+ *
+ * tty	= pointer to tty structure.
+ * file	= pointer to file structure.
+ */
+int eqnx_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	u32 result = 0;
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	int d;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return -ENODEV;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return -ENODEV;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return -ENODEV;
+
+	mpd = mpc->mpc_mpd;
+	dev_dbg(mpd->dev, "eqnx_tiocmget: device %d\n", d);
+
+	result = eqnx_get_modem_info(mpc);
+	return result;
+}
+
+/*
+ * eqnx_tiocmset(tty, file, set, clear)
+ *
+ * set state of control signals.
+ *
+ * tty	= pointer to tty structure.
+ * file	= pointer to file structure.
+ * set	= control signals to set.
+ * clear = control signals to clear.
+ */
+int eqnx_tiocmset(struct tty_struct *tty, struct file *file,
+		  unsigned int set, unsigned int clear)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	int d;
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)
+		return -ENODEV;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return -ENODEV;
+
+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return -ENODEV;
+
+	mpd = mpc->mpc_mpd;
+	dev_dbg(mpd->dev, "eqnx_tiocmset: device %d, set = %x, clear =
%x\n",
+		d, set, clear);
+
+	eqnx_set_modem_info(mpc, TIOCMBIS, set, tty);
+	eqnx_set_modem_info(mpc, TIOCMBIC, clear, tty);
+	return 0;
+}
+
+/*
+ * chan_alive(index)
+ *
+ * return true if channel alive
+ */
+static inline int chan_alive(int index)
+{
+	int chan;
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	struct icp_struct *icp;
+	volatile struct icp_in_struct *icpi;
+	volatile struct cin_bnk_struct *icpb;
+
+	chan = index % MAXCHNL_BRD;
+	mpc = &eqnx_chan[index];
+	if (mpc == NULL)
+		return false;
+
+	mpd = mpc->mpc_mpd;
+	if ((mpd == NULL) || (chan > mpd->mpd_nchan))
+		return false;
+
+	if (!(mpd->mpd_alive))
+		return false;
+
+	icp = &mpd->icp[chan / mpd->mpd_sspchan];
+	if (icp->icp_rng_state != RNG_GOOD)
+		return false;
+
+	if (mpd->mpd_board_def->asic == SSP64) {
+		icpi = mpc->mpc_icpi;
+		icpb = (icpi->cin_locks & LOCK_A) ? &icpi->cin_bank_b :
+		    &icpi->cin_bank_a;
+		if ((!(SSTRD16(icpb->bank_signals) & LMX_PRESENT)) ||
+		    (icp->lmx[mpc->mpc_lmxno].lmx_active != DEV_GOOD))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * chanon(mpc)
+ *
+ * Turn on a channel.
+ *
+ * mpc	= pointer to channel structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void chanon(struct mpchan *mpc)
+{
+	volatile struct icp_in_struct *icpi = mpc->mpc_icpi;
+	volatile struct icp_out_struct *icpo = mpc->mpc_icpo;
+	volatile union global_regs_u *icpg;
+	volatile struct cout_que_struct *icpq = &icpo->cout_q0;
+	volatile struct cin_bnk_struct *icpb;
+	unsigned short cur;
+	u8 cin;
+	u16 nxt_dma, attn_ena, status, attn_enbl;
+#ifdef	DEBUG_LOCKS
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "chanon: mpd lock !locked\n");
+#endif
+
+	if (mpc->mpc_mpd->mpd_board_def->asic == SSP64)
+		icpg = (volatile union global_regs_u *)icpo;
+	else
+		icpg = (volatile union global_regs_u *)
+		    ((unsigned long)(mpc->mpc_icpi) + 0x400);
+
+	icpb = (icpi->cin_locks & LOCK_A) ? &icpi->cin_bank_b :
+	    &icpi->cin_bank_a;
+	/* make sure registers are valid */
+	if (!(SSTRD16(icpb->bank_events) & EV_REG_UPDT))
+		eqnx_frame_wait(mpc, 2);
+
+	if ((SSTRD16(icpb->bank_signals) & (LMX_ONLN | LMX_PRESENT |
+					    AMI_CNFG)) ==
+	    (LMX_ONLN | LMX_PRESENT | AMI_CNFG)) {
+		/* if bridge, stop output on MUX disconnect */
+		icpi->cin_susp_output_lmx |= MUX_NOT_CONN;
+		icpo->cout_lmx_command |= TX_TRGT_MUX;
+	} else {
+		/* local panel */
+		icpi->cin_susp_output_lmx &= ~MUX_NOT_CONN;
+		icpo->cout_lmx_command &= ~TX_TRGT_MUX;
+	}
+
+	/* lock output */
+	icpo->cout_lck_cntrl |= LCK_Q_ACT;
+
+	/* lock input */
+	cin = icpi->cin_locks;
+	icpi->cin_locks = cin | DIS_BANK_A | DIS_BANK_B;
+	eqnx_chnl_sync(mpc);
+
+	icpi->cin_bank_a.bank_fifo_lvl &= ~0x8f;
+	icpi->cin_bank_b.bank_fifo_lvl &= ~0x8f;
+	nxt_dma = SSTRD16(icpb->bank_nxt_dma);
+	SSTWR16(icpi->cin_tail_ptr_a, nxt_dma);
+	SSTWR16(icpi->cin_tail_ptr_b, nxt_dma);
+	mpc->mpc_rxq.q_ptr = nxt_dma;
+	SSTWR16(icpi->cin_min_char_lvl, 1);
+
+	/* unlock input */
+	attn_ena = SSTRD16(icpi->cin_attn_ena);
+	attn_ena |= (ENA_DMA_FAIL | ENA_IXOFF_SVS | ENA_VMIN);
+	SSTWR16(icpi->cin_attn_ena, attn_ena);
+	icpi->cin_locks = cin;
+	icpo->cout_dma_stat_save = 0;
+	icpo->cout_intnl_fifo_ptrs = 0;
+	SSTWR16(icpq->q_data_count, 0);
+	SSTWR16(icpq->q_data_ptr_l, (mpc->mpc_txbase +
mpc->mpc_txq.q_begin));
+	icpi->cin_iband_flow_cntrl = 0;
+	mpc->mpc_txq.q_ptr = mpc->mpc_txq.q_begin;
+	mpc->mpc_count = 0;
+	status = SSTRD16(icpo->cout_status);
+	status &= ~TXSR_SND_BRK;
+	SSTWR16(icpo->cout_status, status);
+	GET_CTRL_SIGS(mpc, cur);
+	cur |= TX_HFC_DTR | TX_HFC_RTS;
+	SET_CTRL_SIGS(mpc, cur);
+
+	/* unlock output */
+	attn_enbl = SSTRD16(icpo->cout_attn_enbl);
+	attn_enbl |= EN_REG_UPDT_EV;
+	SSTWR16(icpo->cout_attn_enbl, attn_enbl);
+	icpo->cout_lck_cntrl &= ~LCK_Q_ACT;
+
+	/* calibrate invent char count */
+	mpc->mpc_tx_last_invent = SSTRD16(icpo->cout_ses_char_ctr_a);
+
+	/* Calibrate events and control signals in both banks */
+	FREEZ_BANK(mpc);
+	FREEZ_BANK(mpc);
+	mpc->mpc_cin_events = 0;
+	mpc->mpc_flags |= MPC_OPEN;
+}
+
+/*
+ * chanoff(mpc)
+ *
+ * Turn off a channel.
+ *
+ * mpc	= pointer to channel structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void chanoff(struct mpchan *mpc)
+{
+	volatile struct icp_in_struct *icpi;
+	volatile struct icp_out_struct *icpo;
+	volatile struct cout_que_struct *icpq;
+	volatile struct cin_bnk_struct *icpb;
+	int loop, ok;
+	u8 cin;
+	u16 events, nxt_dma, attn_ena;
+
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpc->mpc_mpd->dev, "chanoff: mpd lock
!locked\n");
+#endif
+
+	icpi = mpc->mpc_icpi;
+	icpo = mpc->mpc_icpo;
+	icpq = &icpo->cout_q0;
+	icpb = (icpi->cin_locks & LOCK_A) ? &icpi->cin_bank_b :
+	    &icpi->cin_bank_a;
+	/* make sure registers are valid */
+	if (!(SSTRD16(icpb->bank_events) & EV_REG_UPDT))
+		eqnx_frame_wait(mpc, 2);
+
+	mpc->mpc_param &= (IOCTLLB | IOCTCTS | IOCTLCK | IOCTRTS);
+
+	/* disable events */
+	attn_ena = SSTRD16(icpi->cin_attn_ena);
+	attn_ena &= (ENA_DCD_CNG | ENA_CTS_CNG | ENA_DSR_CNG |
ENA_RI_CNG);
+	if (!(mpc->mpc_chan % 16))
+		attn_ena |= ENA_LMX_CNG;
+	SSTWR16(icpi->cin_attn_ena, attn_ena);
+
+	/* lock output */
+	icpo->cout_lck_cntrl |= LCK_Q_ACT;
+	eqnx_chnl_sync(mpc);
+	icpo->cout_intnl_fifo_ptrs = 0;
+	icpo->cout_dma_stat_save = 0;
+	SSTWR16(icpq->q_data_count, 0);
+	SSTWR16(icpq->q_data_ptr_l, (mpc->mpc_txbase +
mpc->mpc_txq.q_begin));
+	mpc->mpc_txq.q_ptr = mpc->mpc_txq.q_begin;
+	mpc->mpc_count = 0;
+	mpc->carr_state = false;
+
+	/* unlock output and update */
+	icpo->cout_lck_cntrl &= ~LCK_Q_ACT;
+	eqnx_chnl_sync(mpc);
+	if ((icpo->cout_intnl_svd_toggls & TOGGLS_LSEND) ==
+	    (icpo->cout_cpu_req & CPU_SND_REQ))
+		icpo->cout_cpu_req ^= CPU_SND_REQ;
+
+	/* wait for ack */
+	loop = 0;
+	ok = false;
+	while (++loop < 100000) {
+		if (SSTRD16(icpo->cout_status) & TXSR_EV_B_ACT)
+			events = SSTRD16(icpo->cout_events_b);
+		else
+			events = SSTRD16(icpo->cout_events_a);
+		if (events & EV_CPU_REQ_DN) {
+			ok = true;
+			break;
+		}
+	}
+
+	if (!ok)
+		dev_warn(mpc->mpc_mpd->dev, "chanoff: cpu_req ack
failed.\n");
+
+	/* lock input */
+	cin = icpi->cin_locks;
+	icpi->cin_locks = cin | DIS_BANK_A | DIS_BANK_B;
+	eqnx_chnl_sync(mpc);
+	icpi->cin_bank_a.bank_fifo_lvl &= ~0x8f;
+	icpi->cin_bank_b.bank_fifo_lvl &= ~0x8f;
+	nxt_dma = SSTRD16(icpb->bank_nxt_dma);
+	SSTWR16(icpi->cin_tail_ptr_a, nxt_dma);
+	SSTWR16(icpi->cin_tail_ptr_b, nxt_dma);
+	mpc->mpc_rxq.q_ptr = nxt_dma;
+	SSTWR16(icpi->cin_min_char_lvl, 1);
+
+	/* allow overrun check while closed */
+	attn_ena = SSTRD16(icpi->cin_attn_ena);
+	attn_ena |= (ENA_VMIN | ENA_DMA_FAIL);
+	SSTWR16(icpi->cin_attn_ena, attn_ena);
+
+	/* unlock input */
+	icpi->cin_locks = cin;
+	if (icpi->cin_iband_flow_cntrl & XOFF_RCV) {
+		icpi->cin_locks |= DIS_IBAND_FLW;
+		eqnx_chnl_sync(mpc);
+		icpi->cin_iband_flow_cntrl &= ~XOFF_RCV;
+		icpi->cin_locks &= ~DIS_IBAND_FLW;
+	}
+
+	SSTWR16(icpo->cout_attn_enbl, EN_REG_UPDT_EV);
+	mpc->mpc_flags &= ~MPC_OPEN;
+	mpc->mpc_cin_events = 0;
+	mpc->mpc_cout_events = 0;
+}
+
+/**********************************************************************
***
+ *
+ * Output support routines
+ *
+
************************************************************************
*/
+
+/*
+ * eqnx_write_SSP64(mpc, buf, count)
+ * write output data to channel.
+ *
+ * mpc	= pointer to channel structure.
+ * buf	= data buffer.
+ * count= count of bytes to write.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+static void eqnx_write_SSP64(struct mpchan *mpc, unsigned char *buf,
int count)
+{
+	int c, nx, datascope = 0;
+	volatile struct icp_out_struct *icpo;
+	volatile union global_regs_u *icpg;
+	volatile struct cout_que_struct *icpq;
+	unsigned char oldreg;
+	u16 qcnt, attn_enbl;
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "eqnx_write_SSP64: mpd lock
locked\n");
+#endif
+
+	icpo = mpc->mpc_icpo;
+	icpg = (volatile union global_regs_u *)icpo;
+	icpq = &icpo->cout_q0;
+
+	c = count;
+	mpc->mpc_flags |= MPC_BUSY;
+	if ((mpc->mpc_flags & MPC_DSCOPEW) &&
+	    (eqnx_dscope[1].chan == mpc - eqnx_chan))
+		datascope = 1;
+
+	/* direct copy to on-board buffers. */
+	nx = MIN(c, (mpc->mpc_txq.q_end - mpc->mpc_txq.q_ptr + 1));
+	memcpy((mpc->mpc_txq.q_addr + mpc->mpc_txq.q_ptr), buf, nx);
+	mpc->mpc_txq.q_ptr += nx;
+	if (mpc->mpc_txq.q_ptr > mpc->mpc_txq.q_end)
+		mpc->mpc_txq.q_ptr = mpc->mpc_txq.q_begin;
+	if (datascope) {
+		int room, move_cnt;
+		int d = 1;
+		char *ubase = buf;
+		room = DSQSIZE - ((eqnx_dscope[d].next -
+				   eqnx_dscope[d].q.q_ptr) & (DSQMASK));
+		if (nx > room)
+			eqnx_dscope[d].status |= DSQWRAP;
+		else
+			room = nx;
+		while (room > 0) {
+			move_cnt = MIN(room,
+				       eqnx_dscope[d].q.q_end -
+				       eqnx_dscope[d].next + 1);
+			memcpy(eqnx_dscope[d].q.q_addr +
eqnx_dscope[d].next,
+			       ubase, move_cnt);
+			eqnx_dscope[d].next += move_cnt;
+			if (eqnx_dscope[d].next >
eqnx_dscope[d].q.q_end)
+				eqnx_dscope[d].next =
eqnx_dscope[d].q.q_begin;
+			ubase += move_cnt;
+			room -= move_cnt;
+		}
+		eqnx_dscope[d].scope_wait_wait = 0;
+		wake_up_interruptible(&eqnx_dscope[d].scope_wait);
+	}
+
+	buf += nx;
+	count -= nx;
+	c -= nx;
+	if (c) {
+		memcpy(mpc->mpc_txq.q_addr + mpc->mpc_txq.q_ptr, buf,
c);
+		mpc->mpc_txq.q_ptr += c;
+		if (mpc->mpc_txq.q_ptr > mpc->mpc_txq.q_end)
+			mpc->mpc_txq.q_ptr = mpc->mpc_txq.q_begin;
+		if (datascope) {
+			int room, move_cnt;
+			int d = 1;
+			char *ubase = buf;
+			room = DSQSIZE - ((eqnx_dscope[d].next -
+					   eqnx_dscope[d].q.q_ptr) &
(DSQMASK));
+			if (c > room)
+				eqnx_dscope[d].status |= DSQWRAP;
+			else
+				room = c;
+			while (room > 0) {
+				move_cnt = MIN(room,
eqnx_dscope[d].q.q_end -
+					       eqnx_dscope[d].next + 1);
+				memcpy(eqnx_dscope[d].q.q_addr +
+				       eqnx_dscope[d].next, ubase,
move_cnt);
+				eqnx_dscope[d].next += move_cnt;
+				if (eqnx_dscope[d].next >
+				    eqnx_dscope[d].q.q_end)
+					eqnx_dscope[d].next =
+					    eqnx_dscope[d].q.q_begin;
+				ubase += move_cnt;
+				room -= move_cnt;
+			}
+			eqnx_dscope[d].scope_wait_wait = 0;
+
wake_up_interruptible(&eqnx_dscope[d].scope_wait);
+		}
+		buf += c;
+		count -= c;
+	}
+	oldreg = icpo->cout_cpu_req;
+	icpo->cout_cpu_req |= TX_SUSP;
+	eqnx_chnl_sync(mpc);
+	qcnt = SSTRD16(icpq->q_data_count);
+	if (qcnt < 9) {
+		if ((icpo->cout_intnl_svd_toggls & 0x4) ==
+		    (icpo->cout_cpu_req & 0x4)) {
+			icpo->cout_cpu_req ^= (CPU_SND_REQ);
+			mpc->mpc_cout_events &= ~EV_CPU_REQ_DN;
+		}
+	}
+	qcnt += (c + nx);
+	SSTWR16(icpq->q_data_count, qcnt);
+	dev_dbg(mpd->dev, "eqnx_write_SSP64: wrote %d chars for device
%d\n",
+		(c + nx), SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+	if (!(oldreg & TX_SUSP))
+		icpo->cout_cpu_req &= ~TX_SUSP;
+	mpc->mpc_output += (c + nx);
+	attn_enbl = SSTRD16(icpo->cout_attn_enbl);
+	attn_enbl |= (ENA_TX_EMPTY_Q0 | ENA_TX_LOW_Q0);
+	SSTWR16(icpo->cout_attn_enbl, attn_enbl);
+}
+
+/*
+ * eqnx_write_SSP4(mpc, func_type)
+ * write output data to channel.
+ *
+ * mpc	= pointer to channel structure.
+ * func_type: one of EQNX_COOKED or EQNX_TXINT
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+void eqnx_write_SSP4(struct mpchan *mpc, int func_type)
+{
+	struct tty_struct *tty = mpc->mpc_tty;
+	int space, c, nx, datascope = 0, block_count;
+	volatile struct icp_out_struct *icpo;
+	volatile union global_regs_u *icpg;
+	volatile struct cout_que_struct *icpq;
+	unsigned char oldreg;
+	u16 qcnt, attn_enbl;
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "eqnx_write_SSP4: mpd lock
!locked\n");
+#endif
+
+	icpo = mpc->mpc_icpo;
+	icpg = (volatile union global_regs_u *)icpo;
+	icpq = &icpo->cout_q0;
+
+	block_count = icpq->q_block_count * 64;
+	space = mpc->mpc_txq.q_size - (mpc->mpc_count +
+				       SSTRD16(icpq->q_data_count)) - 1;
+	if ((func_type != EQNX_TXINT) &&
+	    ((space < block_count) && (mpc->xmit_cnt >= block_count)))
+		return;
+
+	while (1) {
+		c = MIN(space, MIN(mpc->xmit_cnt,
+				   XMIT_BUF_SIZE - mpc->xmit_tail));
+		if (c <= 0)
+			break;
+		mpc->mpc_flags |= MPC_BUSY;
+		if ((mpc->mpc_flags & MPC_DSCOPEW) &&
+		    (eqnx_dscope[1].chan == mpc - eqnx_chan))
+			datascope = 1;
+
+		/* direct copy to on-board buffers. */
+		if (mpc->xmit_buf == NULL)
+			break;
+
+		nx = MIN(c, (mpc->mpc_txq.q_end - mpc->mpc_txq.q_ptr +
1));
+		memcpy((mpc->mpc_txq.q_addr + mpc->mpc_txq.q_ptr),
+		       mpc->xmit_buf + mpc->xmit_tail, nx);
+		mpc->mpc_txq.q_ptr += nx;
+		if (mpc->mpc_txq.q_ptr > mpc->mpc_txq.q_end)
+			mpc->mpc_txq.q_ptr = mpc->mpc_txq.q_begin;
+		if (datascope) {
+			int room, move_cnt;
+			int d = 1;
+			char *ubase = mpc->xmit_buf + mpc->xmit_tail;
+			room = DSQSIZE - ((eqnx_dscope[d].next -
+					   eqnx_dscope[d].q.q_ptr)
+					  & (DSQMASK));
+			if (nx > room)
+				eqnx_dscope[d].status |= DSQWRAP;
+			else
+				room = nx;
+			while (room > 0) {
+				move_cnt = MIN(room,
+					       eqnx_dscope[d].q.q_end -
+					       eqnx_dscope[d].next + 1);
+				memcpy(eqnx_dscope[d].q.q_addr +
+				       eqnx_dscope[d].next, ubase,
move_cnt);
+				eqnx_dscope[d].next += move_cnt;
+				if (eqnx_dscope[d].next >
+				    eqnx_dscope[d].q.q_end)
+					eqnx_dscope[d].next =
+					    eqnx_dscope[d].q.q_begin;
+				ubase += move_cnt;
+				room -= move_cnt;
+			}
+			eqnx_dscope[d].scope_wait_wait = 0;
+
wake_up_interruptible(&eqnx_dscope[d].scope_wait);
+		}
+		mpc->xmit_tail += nx;
+		mpc->xmit_tail &= XMIT_BUF_SIZE - 1;
+		mpc->xmit_cnt -= nx;
+		c -= nx;
+		if (mpc->xmit_buf == NULL)
+			break;
+
+		if (c) {
+			memcpy(mpc->mpc_txq.q_addr + mpc->mpc_txq.q_ptr,
+			       mpc->xmit_buf + mpc->xmit_tail, c);
+			mpc->mpc_txq.q_ptr += c;
+			if (mpc->mpc_txq.q_ptr > mpc->mpc_txq.q_end)
+				mpc->mpc_txq.q_ptr =
mpc->mpc_txq.q_begin;
+			if (datascope) {
+				int room, move_cnt;
+				int d = 1;
+				char *ubase = mpc->xmit_buf +
mpc->xmit_tail;
+				room = DSQSIZE - ((eqnx_dscope[d].next -
+
eqnx_dscope[d].q.q_ptr) &
+						  (DSQMASK));
+				if (c > room)
+					eqnx_dscope[d].status |=
DSQWRAP;
+				else
+					room = c;
+				while (room > 0) {
+					move_cnt = MIN(room,
+
eqnx_dscope[d].q.q_end -
+
eqnx_dscope[d].next + 1);
+					memcpy(eqnx_dscope[d].q.q_addr +
+					       eqnx_dscope[d].next,
ubase,
+					       move_cnt);
+					eqnx_dscope[d].next += move_cnt;
+					if (eqnx_dscope[d].next >
+					    eqnx_dscope[d].q.q_end)
+						eqnx_dscope[d].next =
+
eqnx_dscope[d].q.q_begin;
+					ubase += move_cnt;
+					room -= move_cnt;
+				}
+				eqnx_dscope[d].scope_wait_wait = 0;
+				wake_up_interruptible(&eqnx_dscope[d].
+						      scope_wait);
+			}
+			mpc->xmit_tail += c;
+			mpc->xmit_tail &= XMIT_BUF_SIZE - 1;
+			mpc->xmit_cnt -= c;
+		}
+		oldreg = icpo->cout_cpu_req;
+		icpo->cout_cpu_req |= TX_SUSP;
+		eqnx_chnl_sync(mpc);
+		qcnt = SSTRD16(icpq->q_data_count);
+		if (qcnt < 9) {
+			if ((icpo->cout_intnl_svd_toggls & 0x4) ==
+			    (icpo->cout_cpu_req & 0x4)) {
+				icpo->cout_cpu_req ^= (CPU_SND_REQ);
+				mpc->mpc_cout_events &= ~EV_CPU_REQ_DN;
+			}
+		}
+		qcnt += (c + nx);
+		SSTWR16(icpq->q_data_count, qcnt);
+		space -= (c + nx);
+		dev_dbg(mpd->dev, "eqnx_write_SSP4: wrote %d chars for "
+			"device %d\n", (c + nx),
+			SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+		if (!(oldreg & TX_SUSP))
+			icpo->cout_cpu_req &= ~TX_SUSP;
+		mpc->mpc_output += (c + nx);
+		attn_enbl = SSTRD16(icpo->cout_attn_enbl);
+		attn_enbl |= (ENA_TX_EMPTY_Q0 | ENA_TX_LOW_Q0);
+		SSTWR16(icpo->cout_attn_enbl, attn_enbl);
+	}
+	if ((mpc->xmit_cnt < block_count) && (func_type == EQNX_TXINT))
{
+		dev_dbg(mpd->dev, "eqnx_write_SSP4: calling write_wakeup
"
+			"for device = %d\n",
+			SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+		/* signal write wakeup when safe to call ldisc */
+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+		    tty->ldisc.write_wakeup)
+			eqnx_write_wakeup_deferred++;
+		wake_up_interruptible(&tty->write_wait);
+	}
+}
+
+/*
+ * delay_jiffies(len)
+ *
+ * Delay by the specified number of jiffies.
+ *
+ * len	= jiffies to delay.
+ */
+static void delay_jiffies(int len)
+{
+	if (len > 0) {
+		msleep(jiffies_to_msecs(len));
+	}
+}
