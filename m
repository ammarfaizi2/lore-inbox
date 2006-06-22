Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbWFVNVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWFVNVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWFVNVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:21:47 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:55949 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1161099AbWFVNVq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:21:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 10/13] Equinox SST driver:ioctl support
Date: Thu, 22 Jun 2006 09:21:46 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B71110@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 10/13] Equinox SST driver:ioctl support
Thread-Index: AcaV/s7jdgCV9W+HSgm8sEnkVpGHlA==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 10: new source file: drivers/char/eqnx/sst_ioctl.c.  Provides
support for
the standard TTY ioctl routines.  

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 sst_ioctl.c |  440
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 440 insertions(+)

diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/sst_ioctl.c
linux-2.6.17.eqnx/drivers/char/eqnx/sst_ioctl.c
--- linux-2.6.17/drivers/char/eqnx/sst_ioctl.c	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/sst_ioctl.c	2006-06-20
09:50:11.000000000 -0400
@@ -0,0 +1,440 @@
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
+ * standard tty ioctl interface and support routines
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
+#include <linux/errno.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
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
+/* module function declarations
*/
+/**********************************************************************
*****/
+
+u32 eqnx_get_modem_info(struct mpchan *);
+static void getserial(struct mpchan *, unsigned int __user *);
+static int setserial(struct mpchan *, unsigned int __user *);
+void eqnx_set_modem_info(struct mpchan *, unsigned int, unsigned int,
+			 struct tty_struct *);
+u8 eqnx_get_signal_state(struct mpchan *);
+static void delay_jiffies(int);
+
+/**********************************************************************
*****/
+/* external variable and routines
*/
+/**********************************************************************
*****/
+
+extern int eqnx_nssps;
+
+extern int SSTMINOR(unsigned int, unsigned int);
+extern void eqnx_megaparam(int);
+extern void eqnx_frame_wait(struct mpchan *, int);
+
+/*
+ * eqnx_ioctl(tty, file, cmd, arg)
+ *
+ * Process device specific ioctl requests.
+ *
+ * tty	= pointer to tty structure.
+ * file	= pointer to file structure.
+ * cmd	= ioctl cmd.
+ * arg	= ioctl parameter.
+ */
+int eqnx_ioctl(struct tty_struct *tty, struct file *file,
+	       unsigned int cmd, unsigned long arg)
+{
+	struct mpchan *mpc;
+	struct mpdev *mpd;
+	volatile struct icp_in_struct *icpi;
+	volatile struct icp_out_struct *icpo;
+	volatile struct cout_que_struct *icpq;
+	unsigned int arg_int;
+	int d, rc = 0;
+	unsigned long flags;
+	u32 result;
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
+	if (!(mpd->mpd_alive))
+		return (-ENODEV);
+
+	if (!tty->driver_data)
+		return (-ENXIO);
+
+	spin_lock_irqsave(&mpd->mpd_lock, flags);
+	icpi = mpc->mpc_icpi;
+	icpo = mpc->mpc_icpo;
+	icpq = &icpo->cout_q0;
+	spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+	dev_dbg(mpd->dev, "eqnx_ioctl: cmd %x for device %d\n", cmd, d);
+
+	switch (cmd) {
+	case TCSBRK:
+		/*
+		 * send break, SVID version: if arg == 0, 1/4 sec break
+		 * if non-zero arg, no break
+		 */
+		if ((rc = tty_check_change(tty)) == 0) {
+			tty_wait_until_sent(tty, 0);
+			if (!(arg)) {
+				/* send break */
+				spin_lock_irqsave(&mpd->mpd_lock,
flags);
+				icpo->cout_flow_config |= TX_BREAK_ON;
+				spin_unlock_irqrestore(&mpd->mpd_lock,
flags);
+				delay_jiffies(HZ / 4);
+
+				/* stop break */
+				spin_lock_irqsave(&mpd->mpd_lock,
flags);
+				icpo->cout_flow_config &= ~TX_BREAK_ON;
+				spin_unlock_irqrestore(&mpd->mpd_lock,
flags);
+			}
+		}
+		break;
+
+	case TCSBRKP:
+		/* send break, delay according to arg */
+		if ((rc = tty_check_change(tty)) == 0) {
+			tty_wait_until_sent(tty, 0);
+			/* send break */
+			spin_lock_irqsave(&mpd->mpd_lock, flags);
+			icpo->cout_flow_config |= TX_BREAK_ON;
+			spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+			delay_jiffies(arg ? arg * (HZ / 10) : HZ / 4);
+
+			/* stop break */
+			spin_lock_irqsave(&mpd->mpd_lock, flags);
+			icpo->cout_flow_config &= ~TX_BREAK_ON;
+			spin_unlock_irqrestore(&mpd->mpd_lock, flags);
+		}
+		break;
+
+	case TIOCGSOFTCAR:
+		/* get soft carrier (CLOCAL) */
+		put_user(((tty->termios->c_cflag & CLOCAL) ? 1 : 0),
+			 (unsigned int __user *)arg);
+		break;
+
+	case TIOCSSOFTCAR:
+		/* set soft carrier (CLOCAL) */
+		get_user(arg_int, (unsigned int __user *)arg);
+		tty->termios->c_cflag = (tty->termios->c_cflag &
~CLOCAL) |
+		    (arg_int ? CLOCAL : 0);
+		break;
+
+	case TIOCMGET:
+		/* get control signals */
+		result = eqnx_get_modem_info(mpc);
+		put_user(result, (unsigned int __user *)arg);
+		break;
+
+	case TIOCMBIS:
+	case TIOCMBIC:
+	case TIOCMSET:
+		/* set or clear control signals */
+		get_user(arg_int, (unsigned int __user *)arg);
+		eqnx_set_modem_info(mpc, cmd, arg_int, tty);
+		break;
+
+	case TIOCGSERIAL:
+		/* return serial struct */
+		getserial(mpc, (unsigned int __user *)arg);
+		break;
+
+	case TIOCSSERIAL:
+		/* set serial struct */
+		rc = setserial(mpc, (unsigned int __user *)arg);
+		break;
+	default:
+		rc = -ENOIOCTLCMD;
+		break;
+	}
+	return (rc);
+}
+
+/*
+ * eqnx_get_modem_info(mpc)
+ *
+ * Return state of control signals (inbound and outbound)
+ *
+ * mpc	= pointer to channel structure.
+ */
+u32 eqnx_get_modem_info(struct mpchan * mpc)
+{
+	unsigned char status;
+	unsigned int result = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpc->mpc_mpd->mpd_lock, flags);
+	status = eqnx_get_signal_state(mpc);
+	spin_unlock_irqrestore(&mpc->mpc_mpd->mpd_lock, flags);
+
+	result = (((status & 0x20) ? TIOCM_RTS : 0) |
+		  ((status & 0x10) ? TIOCM_DTR : 0) |
+		  ((status & 0x1) ? TIOCM_CAR : 0) |
+		  ((status & 0x8) ? TIOCM_RI : 0) |
+		  ((status & 0x4) ? TIOCM_DSR : 0) |
+		  ((status & 0x2) ? TIOCM_CTS : 0));
+
+	return (result);
+}
+
+/*
+ * eqnx_set_modem_info(mpc, cmd, value, tty)
+ *
+ * Set outbound control signals
+ *
+ * mpc	= pointer to channel structure.
+ * cmd	= cmd type, one of MBIS, MBIC or MSET
+ * value = value to set/clear control signals.
+ * tty	= pointer to tty structure.
+ */
+void eqnx_set_modem_info(struct mpchan *mpc, unsigned int cmd,
+			 unsigned int value, struct tty_struct *tty)
+{
+	unsigned int temp;
+	volatile struct icp_out_struct *icpo = mpc->mpc_icpo;
+	unsigned long flags;
+	struct termios *term = tty->termios;
+
+	spin_lock_irqsave(&mpc->mpc_mpd->mpd_lock, flags);
+	GET_CTRL_SIGS(mpc, temp);
+	switch (cmd) {
+	case TIOCMBIS:
+		/* set control signals */
+		if (value & TIOCM_DTR)
+			temp |= (TX_DTR | TX_HFC_DTR);
+		/* do not change RTS if CRTSCTS is on */
+		if ((value & TIOCM_RTS) && (term) &&
+		    ((term->c_cflag & CRTSCTS) == 0))
+			temp |= (TX_RTS | TX_HFC_RTS);
+		break;
+
+	case TIOCMBIC:
+		/* clear control signals */
+		if (value & TIOCM_DTR)
+			temp &= ~(TX_DTR | TX_HFC_DTR);
+		/* do not change RTS if CRTSCTS is on */
+		if ((value & TIOCM_RTS) && (term) &&
+		    ((term->c_cflag & CRTSCTS) == 0))
+			temp &= ~(TX_RTS | TX_HFC_RTS);
+		break;
+
+	case TIOCMSET:
+		/* change control signals */
+		if (value & TIOCM_DTR)
+			temp |= (TX_DTR | TX_HFC_DTR);
+		else
+			temp &= ~(TX_DTR | TX_HFC_DTR);
+		/* do not change RTS if CRTSCTS is on */
+		if ((term) && ((term->c_cflag & CRTSCTS) == 0)) {
+			if (value & TIOCM_RTS)
+				temp |= (TX_RTS | TX_HFC_RTS);
+			else
+				temp &= ~(TX_RTS | TX_HFC_RTS);
+		}
+		break;
+	}
+	if (((icpo->cout_intnl_opost & OPOST_TOGGLE) &&
+	     (temp & TX_SND_CTRL_TG)) ||
+	    (!(icpo->cout_intnl_opost & OPOST_TOGGLE) &&
+	     (!(temp & TX_SND_CTRL_TG))))
+		temp ^= TX_SND_CTRL_TG;
+	SET_CTRL_SIGS(mpc, temp);
+	spin_unlock_irqrestore(&mpc->mpc_mpd->mpd_lock, flags);
+	return;
+}
+
+/*
+ * getserial(mpc, sp)
+ *
+ * Generate the serial struct info.
+ *
+ * mpc	= pointer to channel struct
+ * sp	= pointer to serial struct (in user space)
+ */
+static void getserial(struct mpchan *mpc, unsigned int __user *sp)
+{
+	struct serial_struct sio;
+
+	memset(&sio, 0, sizeof(struct serial_struct));
+	sio.type = PORT_UNKNOWN;
+	sio.line = SSTMINOR(mpc->mpc_major, mpc->mpc_minor);
+	sio.flags = mpc->flags;
+	sio.baud_base = mpc->baud_base;
+	sio.close_delay = mpc->close_delay;
+	sio.closing_wait = mpc->closing_wait;
+	sio.custom_divisor = mpc->custom_divisor;
+	if (copy_to_user(sp, &sio, sizeof(struct serial_struct)))
+		dev_warn(mpc->mpc_mpd->dev, "getserial failed copy
out\n");
+}
+
+/*
+ * setserial(mpc, sp)
+ *
+ * Set characteristics according to serial struct info.
+ *
+ * mpc	= pointer to channel struct
+ * sp	= pointer to serial struct (in user space)
+ */
+static int setserial(struct mpchan *mpc, unsigned int __user *sp)
+{
+	struct serial_struct sio;
+	unsigned long flags;
+
+	if (copy_from_user(&sio, sp, sizeof(struct serial_struct)))
+		return (-EFAULT);
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		if ((sio.baud_base != mpc->baud_base) ||
+		    (sio.close_delay != mpc->close_delay) ||
+		    ((sio.flags & ~ASYNC_USR_MASK) !=
+		     (mpc->flags & ~ASYNC_USR_MASK)))
+			return (-EPERM);
+	}
+
+	spin_lock_irqsave(&mpc->mpc_mpd->mpd_lock, flags);
+
+	mpc->flags = (mpc->flags & ~ASYNC_USR_MASK) |
+	    (sio.flags & ASYNC_USR_MASK);
+	mpc->baud_base = sio.baud_base;
+	mpc->close_delay = sio.close_delay;
+	mpc->closing_wait = sio.closing_wait;
+	mpc->custom_divisor = sio.custom_divisor;
+
+	if (mpc->mpc_tty != (struct tty_struct *)NULL)
+		eqnx_megaparam(SSTMINOR(mpc->mpc_major,
mpc->mpc_minor));
+	spin_unlock_irqrestore(&mpc->mpc_mpd->mpd_lock, flags);
+	return (0);
+}
+
+/*
+ * eqnx_get_signal_state(mpc)
+ *
+ * Return the current set of input and output control signals.
+ *
+ * The value returned is "native" icp bit positions regardless of the 
+ * origin of the signals.  Namely,
+ *
+ *     b0      dcd
+ *     b1      cts
+ *     b2      dsr
+ *     b3      ri
+ *     -----------
+ *     b4      dtr
+ *     b5      rts
+ *     b6      0
+ *     b7      0
+ *
+ * The returned bits are POSITIVE logic... 1 means signal is on.
+ *
+ * mpc	= pointer to channel structure.
+ *
+ * mpdev (board-level) lock ** MUST ** be held.
+ */
+u8 eqnx_get_signal_state(struct mpchan * mpc)
+{
+	u8 ret_val = 0;
+	volatile struct icp_in_struct *icpi;
+	volatile struct cin_bnk_struct *bank;
+	u16 rawcs;
+#ifdef	DEBUG_LOCKS
+	struct mpdev *mpd = mpc->mpc_mpd;
+
+	if (!(spin_is_locked(&mpc->mpc_mpd->mpd_lock)))
+		dev_dbg(mpd->dev, "eqnx_get_signal_state: mpd lock
!locked\n");
+#endif
+
+	icpi = mpc->mpc_icpi;
+	bank = (icpi->cin_locks & LOCK_A) ? &icpi->cin_bank_b :
+	    &icpi->cin_bank_a;
+	/* wait until registers are valid */
+	if (!(SSTRD16(bank->bank_events) & EV_REG_UPDT))
+		eqnx_frame_wait(mpc, 2);
+
+	/* get inbound control signals */
+	rawcs = (SSTRD16(bank->bank_signals) >> 1) & 0x0f;
+	ret_val = rawcs & 0xff;
+
+	/*
+	 * get outbound control signals
+	 * Note that there are two sets of signals: normal and overload
+	 * if output overload state, return with overload signals
+	 */
+	GET_CTRL_SIGS(mpc, rawcs);
+	if (mpc->mpc_icpo->cout_intnl_flow_ctrl & IFLOW_QOVRLDL)
+		rawcs = rawcs >> 4;
+
+	/* combine inbound signals and outbound signals */
+	ret_val |= ((rawcs & 0x0f) << 4);
+	return ret_val;
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
