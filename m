Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbTIIWxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbTIIWxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:53:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46053 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264966AbTIIWwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:52:40 -0400
Message-ID: <3F5E59AB.60500@pobox.com>
Date: Tue, 09 Sep 2003 18:52:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: long <tlnguyen@snoqualmie.dp.intel.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com, "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       zwane@linuxpower.ca
Subject: Re: MSI fix for buggy PCI/PCI-X hardware
References: <7F740D512C7C1046AB53446D3720017304AF29@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AF29@scsmsx402.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:
> How about the default behavior? I'm not a fan of disable_msi(), because
> we need to update the driver as we find problems, and we cannot predict
> which PCI/PCI-X devices in the world have such a problem, although we
> know some will. The workaround in drivers/pci/quirk.c is much better,
> compared to modifying the driver, but we still need to update the file
> (and rebuild the kernel) as we find problems.

Agreed.

That's the pain of buggy hardware.  The solution is to not produce buggy 
hardware ;-)  Failing that, it is unavoidable that the kernel would need 
to be updated to notice or work around buggy hardware.  That's precisely 
the reason for quirks/dmi_scan existence:  the special cases.  Special 
cases are never easy or enjoyable to maintain ;-)


> In my opinion, we might want to use drivers/pci/quirk.c to blacklist PCI
> Express devices if any (hope not). For PCI/PCI-X devices, we might want
> to enable MSI once verified for it. To that end we can also use
> drivers/pci/quirk.c to whitelist them (or it's abuse?). That way we can
> avoid situations like "it hangs, it does not get interrupts", "disable
> ACPI, oh no, MSI".


Five points here:

1) If we did that with ACPI, you guys would have only recieved a 
_fraction_ of the feedback you received.  IMO we want to turn on MSI 
(where supported), and see what breaks.  It _should_ work, otherwise the 
hardware guys wouldn't have put MSI on their PCI device :)

You'll never get feedback and testing if it's turned off by default.

2) MSI is more optimal than standard (should I start calling them 
legacy?) x86 interrupts.  And I think they're just plain cool.  So of 
course I will push to default MSI to on!  ;-)

3) I think this view is colored by "right now".  The current MSI errata 
may be worrying you, but...   MSI is the future.  If you choose to 
whitelist, then you're creating a maintenance nightmare for the future. 
  You would have to qualify _every_ MSI device!  Think how much it would 
suck if we have to do that with PCI devices today.

Furthermore, a whitelist unfairly punishes working MSI hardware and 
perhaps unfairly highlights a few key vendors at the start ;-)  This is 
why I like blacklists.

Broken hardware is a special case, and not something we should invest a 
whole lot of time worrying about.  _Assume_ the hardware is working, 
then deal with the cases where it isn't.  _That_ is the Linus Torvalds 
model of an optimal system (IMO :))

4) I have a real-life example:  tg3.  The BroadCom 57xx chips are 
MSI-brain-damaged.  So we unconditionally program the hardware in 
non-MSI mode.  No special APIs needed at all.

5) Another option is to enable MSI only for devices which call 
request_msi().  This idea follows the current model of 
pci_enable_device():  PCI resources and interrupts are guaranteed to be 
assigned and set up only after a successful call to pci_enable_device(). 
  Then, later on, the driver will call request_irq(), which will unmask 
the irq (if it's not already shared).  Continuing this model, a driver's 
call to request_msi() would signal that MSI is to be enabled for that 
device....  and ensure that the PCI core does not unconditionally enable 
MSI for any device outside of request_msi() call.

	Jeff



