Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268575AbUJKAqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268575AbUJKAqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 20:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268588AbUJKAqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 20:46:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:34234 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268575AbUJKAqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 20:46:43 -0400
Subject: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, David Brownell <david-b@pacbell.net>,
       Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1097455528.25489.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 10:45:28 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any reason why this totally broken code was ever merged upstream ?
We debated that again and again... the result of the below code is
to _REMOVE_ useful information from PCI drivers (suspend to disk vs.
suspend to RAM) for no good reason, making PCI drivers suddently
take a different state than any other driver, breaking radeonfb
suspend code, etc....

I insist again and again (with WORKING code here that does both
suspend-to-RAM & to-disk when not broken by patches like that)
that this is the WRONG thing to do, there is no such generic
correspondance between a suspend state and a PCI D state, this
is under driver or platform control, and this just makes things
more confusing for everybody.

Please, revert that to something sane before 2.6.9... I'll be an
asshole on this one and the bunch of PPC suspend-to-disk patch I'll
submit after 2.6.9 will contain a patch reverting that if not done
and I'll bomb it ever and ever again until some sense gets into
all of this.

Ben.


static int pci_device_suspend(struct device * dev, u32 state)
{
	struct pci_dev * pci_dev = to_pci_dev(dev);
	struct pci_driver * drv = pci_dev->driver;
	u32 dev_state;
	int i = 0;

	/* Translate PM_SUSPEND_xx states to PCI device states */
	static u32 state_conversion[] = {
		[PM_SUSPEND_ON] = 0,
		[PM_SUSPEND_STANDBY] = 1,
		[PM_SUSPEND_MEM] = 3,
		[PM_SUSPEND_DISK] = 3,
	};

	if (state >= sizeof(state_conversion) / sizeof(state_conversion[1]))
		return -EINVAL;

	dev_state = state_conversion[state];
	if (drv && drv->suspend)
		i = drv->suspend(pci_dev, dev_state);
		
	pci_save_state(pci_dev, pci_dev->saved_config_space);
	return i;
}

