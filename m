Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUIPEoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUIPEoG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 00:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUIPEoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 00:44:06 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:32480 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S267378AbUIPEn5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 00:43:57 -0400
Date: Wed, 15 Sep 2004 21:43:01 -0700
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
To: mgreer@mvista.com, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: review MPSC driver
Message-Id: <20040915214301.53a68379.randy.dunlap@verizon.net>
In-Reply-To: <20040915150247.37706f7c.rddunlap@osdl.org>
References: <20040915150247.37706f7c.rddunlap@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [4.5.49.23] at Wed, 15 Sep 2004 23:43:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| http://www.uwsg.iu.edu/hypermail/linux/kernel/0408.3/1549.html

Hi Mark,

1.  Do you realize that a version of the driver is already in the -mm
patchset?

2.  + depends on PPC32 && MV64X60

Where is MV64X60 defined?

3.  + select SERIAL_CORE
    + select SERIAL_CORE_CONSOLE

Please don't use "select".  Use "depends on" instead.

4.  + * Author: Mark A. Greer <mgreer@xxxxxxxxxx>

Put a real email address or remove it.

5.  +#include <asm/mv64x60.h>

Where is this file?  Does this driver build?

6.  style:
+	if (pi->brg_can_tune) {
+		MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 1, 25, 0);
+	}
Has unneeded braces (in several places).

7.  style:
+	return;
+}
Lots of void functions with "return" that is not needed.

8.  Why use 'volatile' here?  Have you read the Linus volatile rant?

+static inline void
+mpsc_sdma_set_tx_ring(struct mpsc_port_info *pi,
+		      volatile struct mpsc_tx_desc *txre_p)
+{

9.  put in mpsc.h:
+	static void mpsc_free_ring_mem(struct mpsc_port_info *pi);
+	static void mpsc_start_rx(struct mpsc_port_info *pi);

10. in the interrupt handler, if rx happened, tx intr not checked.
Is that intentional?

+	if (mpsc_rx_intr(pi, regs) || mpsc_tx_intr(pi))
+		rc = IRQ_HANDLED;

11. In mpsc_verify_port(), if -EINVAL is ever set, the others
are wasted checks.

12. What's the rationale for having both mpsc_console_init() and
mpsc_late_console_init() ?

13. register_serial() and unregister_serial():  names are a bit too
generic -- they sound like serial subsystem functions.
and why are they exported?  what else uses them?

14. mpsc.h:  don't define MIN(), #include <linux/kernel.h> and use
its min() macro.

15. Run it thru sparse for warnings.

--
~Randy
