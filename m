Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269312AbRHCErP>; Fri, 3 Aug 2001 00:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269313AbRHCErF>; Fri, 3 Aug 2001 00:47:05 -0400
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:55024 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S269312AbRHCEqy>;
	Fri, 3 Aug 2001 00:46:54 -0400
Date: Fri, 3 Aug 2001 00:46:56 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Flynn <Dave@keston.u-net.com>,
        linux kernel mailinglist <linux-kernel@vger.kernel.org>,
        tulip@scyld.com
Subject: Re: [tulip] Re: Tulip Driver, or is it the PCI subsystem ?
In-Reply-To: <E15STO2-0002AC-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10108030028530.850-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Alan Cox wrote:

> > now, all that i want to know, is What on earth has been changed to
> > COMPLETELY retard what i saw as a usefull card and driver, for my (and other
> > people), the card is useless, and even worse, so is the damn server its
> > connected to.
> 
> Well the obvious thing is the pci scanning and hot plug interface means that
> PCI ordering is now a more generic issue. I suspect what you'd need to do
> is to implement a version of 
> 
> 	pcibios_sort()

This doesn't really address the problem.

The (Scyld) tulip driver now back-installs the EEPROM information to
already detected interfaces that didn't have an EEPROM.

The problem is the broken BIOS IRQ settings.
The tulip driver has long had patch-up code, for x86 only, to work
around this problem.

The driver used to only forward-copy the EEPROM info, and used the same
code to forward copy the IRQ setting.  If the probe order was backwards,
the user set reverse_probe=1 because of the obviously bogus media
table.  This fixed up the IRQ (which was never *obviously* broken.)

Reviewing the code, I now understand the crux of your bug report.
While the current driver will back-copy and forward-copy the EEPROM
media information, the IRQ setting is only forward copied.

See the references to "last_irq" in probe1().

Here is a patch that might fix your problem.  The code around line 1106
does the back-copy of the EEPROM media table.  Please try adding the
lines with the "+"

	if (ee_data[19] > 1) {
		struct net_device *prev_dev;
		struct tulip_private *otp;
		/* This is a multiport board.  The probe order may be "backwards", so
		   we patch up already found devices. */
		last_ee_data = ee_data;
		for (prev_dev = tp->next_module; prev_dev; prev_dev = otp->next_module) {
			otp = (struct tulip_private *)prev_dev->priv;
			if (otp->eeprom[0] == 0xff  &&  otp->mtable == 0) {
+#if defined(__i386__)		/* Patch up x86 BIOS bug. */
+				prev_dev->irq = dev->irq;
+#endif
				parse_eeprom(prev_dev);
				start_link(prev_dev);
			} else
				break;
		}
		controller_index = 0;
	}


Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

