Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVG0BhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVG0BhI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 21:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVG0BhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 21:37:08 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:22801 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262346AbVG0Bgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 21:36:49 -0400
Date: Tue, 26 Jul 2005 21:36:02 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Greg KH <greg@kroah.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
       matthew@wil.cx, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from pci_set_power_state for D3hot->D0
Message-ID: <20050727013601.GA13958@tuxdriver.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	"David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
	matthew@wil.cx, grundler@parisc-linux.org,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
	linux-kernel@vger.kernel.org, ambx1@neo.rr.com
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com> <20050726234934.GA6584@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726234934.GA6584@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 04:49:34PM -0700, Greg KH wrote:
> On Fri, Jul 08, 2005 at 02:34:56PM -0400, John W. Linville wrote:
> > @@ -301,6 +335,16 @@ pci_set_power_state(struct pci_dev *dev,
> >  		udelay(200);
> >  	dev->current_state = state;
> >  
> > +	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
> > +	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
> > +	 * from D3hot to D0 _may_ perform an internal reset, thereby
> > +	 * going to "D0 Uninitialized" rather than "D0 Initialized".
> > +	 * In that case, we need to restore at least the BARs so that
> > +	 * the device will be accessible to its driver.
> > +	 */
> > +	if (need_restore)
> > +		pci_restore_bars(dev);
> > +
> 
> This code doesn't even build, as need_restore isn't a global variable.

Hmmm...you must be missing this hunk from the patch posted on July 8?

@@ -239,7 +270,7 @@ pci_find_parent_resource(const struct pc
 int
 pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int pm;
+	int pm, need_restore = 0;
	u16 pmcsr, pmc;

	/* bound the state we're entering */

 
> Care to redo this patch (and merge it with your other one) and resend
> it?

I'll be happy to do so, and include the other comment tweaks that
Grant requested.  I should get to it tomorrow morning.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
