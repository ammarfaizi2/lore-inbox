Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVCUIQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVCUIQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 03:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVCUIQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 03:16:44 -0500
Received: from relay.rost.ru ([80.254.111.11]:20615 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S261656AbVCUIQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 03:16:40 -0500
Date: Mon, 21 Mar 2005 11:16:38 +0300
From: Andrey Panin <pazke@donpac.ru>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Jacques Goldberg <Jacques.Goldberg@cern.ch>
Subject: Re: Need break driver<-->pci-device automatic association
Message-ID: <20050321081638.GC2703@pazke>
Mail-Followup-To: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	Jacques Goldberg <Jacques.Goldberg@cern.ch>
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain> <20050318165124.GC14952@kroah.com> <Pine.LNX.4.58_heb2.09.0503192021431.11358@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58_heb2.09.0503192021431.11358@localhost.localdomain>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 078, 03 19, 2005 at 08:33:14PM +0200, Jacques Goldberg wrote:
> 
>    Good news!
>    That's really what is needed (mainline).
>    I attach the file which Sasha, author or the lmodem driver, has
> modified and then it works for the chips hard-wired in the routine.
>    To locate the patched area, look for 5457

We can use PCI quirk here. Patch attached.

>    I am an experimental physicist, not a computer expert. If this kind of
> algorithm could be implemented in the mainlin 8250_pci.c , then I would
> dream of looking for an /etc/config file containing such a list, whose
> objects would be skipped by the serial driver.
>    Sorry to repeat myself, but avoiding the need for the users to
> recompile a kernel should be the first worry when implementing a solution.

It's not a reason to fill kernel code with ugly kludges :)

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-quirk-winmodems

diff -urdpNX /usr/share/dontdiff linux-2.6.11.vanilla/drivers/pci/quirks.c linux-2.6.11/drivers/pci/quirks.c
--- linux-2.6.11.vanilla/drivers/pci/quirks.c	2005-03-02 10:37:31.000000000 +0300
+++ linux-2.6.11/drivers/pci/quirks.c	2005-03-21 11:02:53.000000000 +0300
@@ -1241,6 +1241,18 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch );
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch );
 
+/*
+ * Some stupid winmodems try to look as real modems. Fix them.
+ */
+static void __devinit quirk_winmodems(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_COMMUNICATION_OTHER;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5451, quirk_winmodems);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5457, quirk_winmodems);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5459, quirk_winmodems);
+
+
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_fixup *end)
 {
 	while (f < end) {

--n8g4imXOkfNTN/H1--
