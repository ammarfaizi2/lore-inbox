Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVGMRj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVGMRj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVGMRh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:37:29 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:61970 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261994AbVGMRfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:35:01 -0400
Date: Wed, 13 Jul 2005 13:34:21 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Adam Belay <ambx1@neo.rr.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from pci_set_power_state for D3hot->D0
Message-ID: <20050713173417.GA21547@tuxdriver.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-pm@lists.osdl.org,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
	rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
	"David S. Miller" <davem@davemloft.net>
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com> <20050712022855.GA3689@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712022855.GA3689@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 10:28:55PM -0400, Adam Belay wrote:
> On Fri, Jul 08, 2005 at 02:34:56PM -0400, John W. Linville wrote:

> > Some firmware leaves devices in D3hot after a (re)boot.  Most drivers
> > call pci_enable_device very early, so devices left in D3hot that lose
> > configuration during the D3hot->D0 transition will be inaccessible to
> > their drivers.
> 
> Also, I think there is a possibility of only enabling boot devices for ACPI
> S4.  However, for the reboot case, we're not restoring anything.  Instead new
> resource assignments are being made.  Doesn't the PCI subsystem already
> handle this?

I'm not sure I understand you...the kernel doesn't actually make the
assignments, relying on the BIOS to do so...am I wrong?

So, if the BIOS leaves a device in D3hot, it will loose it's
BIOS-assigned resources when it transitions to D0 in pci_enable_device.
The point of this patch is to restore those BAR assignments so that
the device's registers will be accessible to the driver.  The driver
remains blissfully unaware of the D3hot->D0 issue.

> >   * pci_set_power_state - Set the power state of a PCI device
> >   * @dev: PCI device to be suspended
> >   * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
> > @@ -239,7 +270,7 @@ pci_find_parent_resource(const struct pc
> >  int
> >  pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> >  {
> 
> Couldn't this be in pci_restore_state() instead?  I was thinking it would
> (in part) replace the ugly dword reads we have now.  They include many
> registers we don't need to touch.  I wonder if we'll need pci_save_state()
> at all or if we can derive all the information from the pci_dev.  I'll have
> to look into it further.
 
Currently pci_restore_state is only useful if there is a preceding
pci_save_state.  While this commonly occurs in the ->resume routines,
most drivers don't do any such thing (i.e. either save or restore) in
the ->probe routines.  This is likely because it only makes sense to
do so if you know about the D3hot->D0 issue; in that case, we would
be back to replicating code in any number of drivers.  I think we
agree that should be avoided.

> Also we need a way to restore specific PCI capabilities.

If you are asking for additional patches (or more changes to this one)
then you'll have to be more specific.  I don't know what you want here.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
