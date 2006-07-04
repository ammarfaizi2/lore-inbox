Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWGDETK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWGDETK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 00:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWGDETI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 00:19:08 -0400
Received: from xenotime.net ([66.160.160.81]:58030 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750779AbWGDESy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 00:18:54 -0400
Date: Mon, 3 Jul 2006 21:21:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Straub, Michael" <Michael.Straub@avocent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 13/13] Equinox SST driver: miscellaneous routines
Message-Id: <20060703212139.6b4b2e75.rdunlap@xenotime.net>
In-Reply-To: <4821D5B6CD3C1B4880E6E94C6E70913E01B71117@sun-email.corp.avocent.com>
References: <4821D5B6CD3C1B4880E6E94C6E70913E01B71117@sun-email.corp.avocent.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:26:49 -0400 Straub, Michael wrote:

> Adds Equinox multi-port serial (SST) driver.
> 
> Part 13: new source file: drivers/char/eqnx/sst_misc.c.  Provides
> general
> support routines used throughout the driver source.
> 
> Signed-off-by: Mike Straub <michael.straub@avocent.com>
> 
> ---
>  sst_misc.c |  758
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 758 insertions(+)


diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/sst_misc.c linux-2.6.17.eqnx/drivers/char/eqnx/sst_misc.c
--- linux-2.6.17/drivers/char/eqnx/sst_misc.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/sst_misc.c	2006-06-20 09:50:17.000000000 -0400
@@ -0,0 +1,758 @@
+/*
+/*
+#include <linux/config.h>

Drop config.h.

+#include <linux/version.h>
+
+#ifdef CONFIG_MODVERSIONS
+#define MODVERSIONS	1
+#endif

not used.

+/***************************************************************************/
+
+/* external variable and routines
+
+extern struct mpchan *eqnx_chan;
+extern int SSTMINOR(unsigned int, unsigned int);

Put these in a header file.

+int eqnx_modem(int d, int cmd)
+{
+	struct mpchan *mpc = &eqnx_chan[d];
+	volatile struct icp_in_struct *icpi = mpc->mpc_icpi;
+	volatile struct cin_bnk_struct *icpb;
+	u16 cur, mux;
+
+	switch (cmd) {
+	case TURNON:
+		if ((mpc->mpc_tty) && (mpc->mpc_tty->termios)) {
+			if (mpc->mpc_tty->termios->c_cflag & CRTSCTS)
+				cur &= ~TX_HFC_RTS;
+		}

Don't really need those braces.

+}
+
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
+	if ((speed >= 0) && (speed <= (B38400 + 4))) {

speed is always >= 0 since it is a u32.

+		d = megaparam_icpbaud(mpc, speed);
+		if (d != SSTRD16(icpi->cin_baud))
+			SSTWR16(icpi->cin_baud, d);
...
+}
+
+static void inline megaparam_databits(struct mpchan *mpc,
+				      volatile struct termios *tiosp)
+{
+	default:
+		/* CS8 */

Don't use obvious comments like that one.

+		d = CS_8;
+		if (tiosp->c_iflag & ISTRIP)
+			e |= EN_ISTRIP;
+	}
...
+}
+
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
+	/* clear lookup table */
+	for (ii = 0; ii < 32; ii++)
+		icpi->cin_lookup_tbl[ii] = 0;

Can you use
	memset(icpi->cin_lookup_tbl, 0, sizeof(icpi->cin_lookup_tbl));
instead of the for-loop?

...
+}
+
+static void megajam(struct mpchan *mpc)
+{
+	volatile struct icp_out_struct *icpo = mpc->mpc_icpo;
+	int ii = 0;
+
+	while (((icpo->cout_flow_config & TX_TGL_XON_XOFF) !=
+		(icpo->cout_intnl_flow_ctrl & IFLOW_TOGGLE)) &&
+	       (++ii < 100000)) ;
+
+	ii = 0;
+	while ((icpo->cout_intnl_flow_ctrl & IFLOW_XOFF) && (++ii < 100000)) ;

Use something other than counter loops here?

+}
+
+void eqnx_chnl_sync(struct mpchan *mpc)
+{
+	volatile union global_regs_u *icpg;
+	int i = 0;
+	volatile unsigned char *chan_ptr;
+	struct icp_struct *icp;
+
+	if (mpc->mpc_mpd->mpd_board_def->asic == SSP64) {
+		/* SSP64 */

unneeded comment

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

counter "timeout"?

+			break;
+	}
+}
+
+void eqnx_frame_wait(struct mpchan *mpc, int count)
+{
+	volatile union global_regs_u *icpg;
+	volatile struct icp_out_struct *icpo;
+	u16 final, original;
+	volatile u16 *frame_ptr, curval;
+	int x, wrap;
+
+	if (mpc->mpc_mpd->mpd_board_def->asic == SSP64) {
+		/* SSP64 */

drop that comment.

+		icpg = (volatile union global_regs_u *)(mpc->mpc_icpo);
+		frame_ptr = &icpg->ssp.gicp_frame_ctr;
+	} else {
+		/* SSP4 */
+		icpg = (volatile union global_regs_u *)
+		    ((unsigned long)(mpc->mpc_icpi) + 0x400);
+		icpo = (volatile struct icp_out_struct *)
+		    ((unsigned long)(mpc->mpc_icp->icp_regs_start) + 0x200);
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
+		dev_warn(mpc->mpc_mpd->dev, "eqnx_frame_wait: timeout\n");

counter "timeout"?

+}

---
~Randy
