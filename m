Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264808AbSKELzw>; Tue, 5 Nov 2002 06:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264823AbSKELzw>; Tue, 5 Nov 2002 06:55:52 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:49677 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264808AbSKELzv>; Tue, 5 Nov 2002 06:55:51 -0500
Date: Tue, 5 Nov 2002 16:01:42 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, jgarzik@pobox.com,
       jung-ik.lee@intel.com, linux-kernel@vger.kernel.org
Subject: Re: Patch: 2.5.45 PCI Fixups for PCI HotPlug
Message-ID: <20021105160142.A2247@jurassic.park.msu.ru>
References: <200211042029.MAA09749@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200211042029.MAA09749@adam.yggdrasil.com>; from adam@yggdrasil.com on Mon, Nov 04, 2002 at 12:29:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 12:29:37PM -0800, Adam J. Richter wrote:
> 	What are you advocating?  Do you want all quirk routines
> marked __devinit?  Wouldn't you agree at least that if we can
> establish that device *cannot* be hot plugged, that its quirk routine
> can be __init?

You cannot mark individual quirk routines differently as long as they
belong in the same quirk list. If the list is __devinitdata and some
of routines in it are __init, you'll have an oops in the hotplug path.

What we need is an additional quirk list, say, "hotplug_pci_fixups"
and a global flag "init_gone" (probably free_initmem() should set it).
Then we'll have

void pci_fixup_device(int pass, struct pci_dev *dev)
{
-	pci_do_fixups(dev, pass, pcibios_fixups);
-	pci_do_fixups(dev, pass, pci_fixups);
+	if (!init_gone) {
+		pci_do_fixups(dev, pass, pcibios_fixups);
+		pci_do_fixups(dev, pass, pci_fixups);
+	}
+	pci_do_fixups(dev, pass, hotplug_pci_fixups);
}

Perhaps arch specific "hotplug_pcibios_fixups" is also needed, as archs
may work around the same pci bug differently.

What should go into the new list is another story. Obviously the fixups for
host bridges must be __init, as well as some south bridges that look like
pci devices but actually aren't.

Ivan.
