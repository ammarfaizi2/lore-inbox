Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWGCXuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWGCXuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWGCXuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:50:20 -0400
Received: from xenotime.net ([66.160.160.81]:47263 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932298AbWGCXuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:50:18 -0400
Date: Mon, 3 Jul 2006 16:53:03 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Straub, Michael" <Michael.Straub@avocent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 9/13] Equinox SST driver: tty interface
Message-Id: <20060703165303.e9fa2f81.rdunlap@xenotime.net>
In-Reply-To: <4821D5B6CD3C1B4880E6E94C6E70913E01B7110E@sun-email.corp.avocent.com>
References: <4821D5B6CD3C1B4880E6E94C6E70913E01B7110E@sun-email.corp.avocent.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:20:28 -0400 Straub, Michael wrote:

> Adds Equinox multi-port serial (SST) driver.
> 
> Part 9: new source file: drivers/char/eqnx/sst_tty.c.  Provides the
> standard
> TTY interface routines for the SST driver.


---
 sst_tty.c | 1961
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 1 files changed, 1961 insertions(+)

Use "diffstat -p1 -w70" please.

diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/sst_tty.c linux-2.6.17.eqnx/drivers/char/eqnx/sst_tty.c
--- linux-2.6.17/drivers/char/eqnx/sst_tty.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/sst_tty.c	2006-06-20 09:50:09.000000000 -0400
@@ -0,0 +1,1961 @@
+/*
+
+#include <linux/config.h>

don't need config.h (autoconf.h is automatically #included)

+#include <linux/version.h>
+
+#ifdef CONFIG_MODVERSIONS
+#define MODVERSIONS	1
+#endif

not used

+/* defer call to write_wakeup */
+int eqnx_write_wakeup_deferred = 0;

static?

+/* external variable and routines */
+/***************************************************************************/

These should be in a header file:

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

Might as well use kernel-doc format since it is almost there.
See Documentation/kernel-doc-nano-HOWTO.txt.
(multiple places)

+int eqnx_open(struct tty_struct *tty, struct file *filp)
+{

static?

+	/* validate channel number */
+	if ((d > (eqnx_nssps * MAXCHNL_BRD)) || (eqnx_nssps == 0) || (d
< 0))
+		return (-ENODEV);

no parens (multiple places)

+	if (tty->termios == NULL) {
+		*tty->termios = *mpc->normaltermios;
+	}

Don't use braces for 1-statement blocks. (multiple places)

+void eqnx_close(struct tty_struct *tty, struct file *filp)

static?

+{
+
+	/* channel validity checks */
+	if (tty == (struct tty_struct *)NULL)

Cast not needed, please drop it.

+		return;
+	mpc = (struct mpchan *)tty->driver_data;
+	if (mpc == (struct mpchan *)NULL)
+		return;

ditto (+ multiple other places)

+	d = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	if (d > (eqnx_nssps * MAXCHNL_BRD))
+		return;
+
+	if ((mpd = mpc->mpc_mpd) == (struct mpdev *)NULL)
+		return;

Drop the cast.  And preferably split the if-test into 2 lines of
assignment + if-test.

+	nchan = MPCHAN(d);
+	if ((mpd >= &eqnx_dev[eqnx_nssps]) || (!(mpd->mpd_alive)) ||
+	    (nchan >= (int)mpd->mpd_nchan))
+		return;
+}
+
+static void eqnx_flush_chars_locked(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	unsigned int d;
+
...
+	if (eqnx_txcooktty == NULL)
+		return;

Don't need this else + braces:

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
+void eqnx_flush_chars(struct tty_struct *tty)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	unsigned int d;
+	unsigned long flags;
+
...
+	if (eqnx_txcooktty == NULL)
+		return;

Drop the else + braces?

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
+void eqnx_throttle(struct tty_struct *tty)

static?

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

About all of these validity checks:  is it actually possible
for all of these functions to be called when they shouldn't be?
There seems to be an over-abundance of these checks.

+	mpd = mpc->mpc_mpd;
+	dev_dbg(mpd->dev, "eqnx_throttle: device %d\n",
+		SSTMINOR(mpc->mpc_major, mpc->mpc_minor));
+	mpc->mpc_block = true;
+}
+
+void eqnx_flush_buffer_locked(struct tty_struct *tty)

static?

+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	volatile struct icp_in_struct *icpi;
+	volatile struct icp_out_struct *icpo;
+	volatile struct cout_que_struct *icpq;
+	volatile struct cin_bnk_struct *icpb;

Use of volatile is highly frowned on.
Please read these volatile emails from Linus:

http://www.x86-64.org/lists/discuss/msg07347.html
http://www.x86-64.org/lists/discuss/msg07358.html

+	u8 cin;
+	u16 nxt_dma;
+	int d;
+
...
+#ifdef	DEBUG_LOCKS
+	if (!(spin_is_locked(&mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "eqnx_flush_buffer_locked: mpd lock not "
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
+	SSTWR16(icpq->q_data_ptr_l, (mpc->mpc_txq.q_begin + mpc->mpc_txbase));
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
+void eqnx_set_termios(struct tty_struct *tty, struct termios *old)
+{

static?  or is it called from other modules?

...
+}
+
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
+	attn_ena &= (ENA_DCD_CNG | ENA_CTS_CNG | ENA_DSR_CNG | ENA_RI_CNG);
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
+	SSTWR16(icpq->q_data_ptr_l, (mpc->mpc_txbase + mpc->mpc_txq.q_begin));
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

This should use some kind of timing/timer, not just a counter.

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
+		dev_warn(mpc->mpc_mpd->dev, "chanoff: cpu_req ack failed.\n");
...
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

No braces on 1-statement blocks.

+}


---
~Randy
