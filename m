Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWGQONS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWGQONS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWGQONS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:13:18 -0400
Received: from colo.lackof.org ([198.49.126.79]:8378 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1750788AbWGQONR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:13:17 -0400
Date: Mon, 17 Jul 2006 08:13:15 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Julien Cristau <julien.cristau@ens-lyon.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Linux v2.6.17 - PCI Bus hidden behind transparent bridge
Message-ID: <20060717141315.GB2771@colo.lackof.org>
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org> <20060716193452.GA5299@bryan.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060716193452.GA5299@bryan.is-a-geek.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 09:34:53PM +0200, Julien Cristau wrote:
> Hi,
> 
> I have a cardbus wireless adapter which worked until 2.6.16, but doesn't
> on 2.6.17. I use standard Debian kernels, .config and dmesg outputs
> available at:
> http://liafa.jussieu.fr/~jcristau/tmp/dmesg-2.6.16
> http://liafa.jussieu.fr/~jcristau/tmp/dmesg-2.6.17
> http://liafa.jussieu.fr/~jcristau/tmp/config-2.6.16-2-686
> http://liafa.jussieu.fr/~jcristau/tmp/config-2.6.17-1-686

Julien,
thanks for posting this.

I diff'ed the dmesg output and I think this is the chunk
might be more explicit symptom of your problem:
-Loaded prism54 driver, version 1.2

This output comes from drivers/net/wireless/prism54/islpci_hotplug.c:
	printk(KERN_INFO "Loaded %s driver, version %s\n",

You can verify if the driver isn't getting loaded until later (udev?)
or not all by doing "modprobe prism54" and see of that starts
working. If not, then my next guess would be something changed in the
prism54 driver so it doesn't claim your device.

The other thing I noticed is IRQ11 is assigned to a different PCI device:
2.6.16 :
-PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
-ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [PILC] -> GSI 11 (level, low) -> IR
Q 11


vs 2.6.17:
+ACPI: PCI Interrupt Link [PILA] enabled at IRQ 11
+ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [PILA] -> GSI 11 (level, low) -> IR
Q 11

This seems relevant since IRQ11 seems to be have been assigned by
the BIOS to _7_ devices according to the 2.6.16 lspci output.
This seems a bit unusual to me but maybe it's ok.

hth,
grant
