Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266916AbUFZBin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266916AbUFZBin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 21:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266917AbUFZBin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 21:38:43 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:30733 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266916AbUFZBij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 21:38:39 -0400
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, ak@muc.de, akpm@osdl.org, greg@kroah.com,
       jgazik@pobox.com, tom.l.nguyen@intel.com, zwane@linuxpower.ca
Subject: Re: [PATCH]2.6.7 MSI-X Update
X-Message-Flag: Warning: May contain useful information
References: <200406260121.i5Q1LwK0005068@snoqualmie.dp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 25 Jun 2004 18:38:37 -0700
Message-ID: <52n02r14ki.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Jun 2004 01:38:37.0344 (UTC) FILETIME=[4D12CA00:01C45B1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like this new MSI patch much better since it has pci_disable_msi()
and pci_disable_msix() (as well as using pci_read_config_xxx instead
of bus ops), but I still feel the API is not quite right.  I don't
think the pci_disable_msi() and pci_disable_msix() functions should
only be for error paths; I think that they should always be used to
undo the effect of pci_enable_msi() or pci_enable_msix() when a driver
is unloading, and that request()/free_irq() should not have any effect
on a device's MSI state.

As a concrete example, the e1000 net driver does request_irq() in its
e1000_up() function and free_irq() in its e1000_down() function.
Basically, the driver will do request_irq() when the user does
"ifconfig up" and free_irq() when the user does "ifconfig down".

If I were adding MSI support to the e1000 driver, I would really just
like to do pci_enable_msi() in the e1000_probe() function (along with
any device-specific magic to tell the e1000 chip to use MSI instead of
INTx), unconditionally do pci_disable_msi() in e1000_remove(), and be
able to do any number of request_irq()/free_irq() operations
(including no such operations) in between.

MSI-X support for multiple vectors makes things much harder to deal
with.  If free_irq() releases the associated MSI-X vector, it seems a
driver can't call free_irq() on a vector if it ever expects to use it
again.  I could easily imagine a dual-port network card with a
separate MSI-X vector for each port; with your current patch the
driver for that card could not use the standard network driver model
of request_irq() in the ->open method and free_irq() in the ->stop
method.

Finally, it just seems cleaner and easier to understand if
enabling/disabling MSI is explicit and separate from registering an
ISR.  I would expect many people to be confused by code like the
below, which is what one would write with your current API:

	int open() {
		pci_enable_msi();
		/* continue init... */
		if (err)
			goto out;
	
		request_irq();
		return 0;

	out:
		pci_disable_msi();
		return err;
	}

	void close() {
		free_irq();
		/* why no pci_disable_msi() ?? */
	}

It would be much clearer and easier to audit if every pci_enable_msi()
is balanced by a pci_disable_msi(), just as every request_irq() is
balanced by a free_irq() (and every pci_enable_device() is balanced by
a pci_disable_device(), etc).

To summarize:
   1) free_irq() should not have the function of disabling MSI, since
      drivers probably don't want to disable MSI or free MSI-X vectors
      just because they call free_irq()
   2) removing this overloaded function from free_irq() will also make
      driver code clearer and easier to maintain.

Thanks,
  Roland

PS To throw some good new in with all the nitpicking, even with your
previous patch I have multiple MSI-X vectors working with my driver.
My complaint is just that the MSI-X API makes my driver code a little
messier than I think it should be...

    # cat /proc/interrupts
               CPU0       CPU1       CPU2       CPU3
      0:      70314      50016      60023      54159    IO-APIC-edge  timer
      2:          0          0          0          0          XT-PIC  cascade
      4:        263          0          0         16    IO-APIC-edge  serial
      8:          1          0          0          0    IO-APIC-edge  rtc
     14:       2748       6672       1818          0    IO-APIC-edge  ide0
     15:         35          0          0          0    IO-APIC-edge  ide1
    161:       5629          0          0          0   IO-APIC-level  eth0
    201:        280     219342     162219      60937       PCI-MSI-X  ib_mthca (comp)
    209:          0          0          2          0       PCI-MSI-X  ib_mthca (async)
    217:         79        104       2711         90       PCI-MSI-X  ib_mthca (cmd)
    NMI:     233505     233299     233297     233295
    LOC:     233327     233311     233059     233309
    ERR:          0
    MIS:          0
