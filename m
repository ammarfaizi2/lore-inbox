Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUARVag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 16:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbUARVa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 16:30:28 -0500
Received: from the.earth.li ([193.201.200.66]:64928 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S263895AbUARVaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 16:30:16 -0500
Date: Sun, 18 Jan 2004 21:30:15 +0000
From: Jonathan McDowell <noodles@earth.li>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch for reset in ini9100u [Initio 9100U(W)]
Message-ID: <20040118213015.GV1845@earth.li>
References: <20040106231426.GR1845@earth.li> <1073523364.1883.12.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073523364.1883.12.camel@mulgrave>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 06:56:04PM -0600, James Bottomley wrote:
> On Tue, 2004-01-06 at 17:14, Jonathan McDowell wrote:
> > I have an IWill 2935UW SCSI controller which uses the ini9100u driver.
> > This has been working fine under 2.4 but I've recently built up a box of
> > spare bits including the controller and installed 2.6 on it. The driver
> > is marked broken in 2.6, apparently because of a lack of reset/abort
> > functionality as it compiles and runs ok. So I've taken a stab at
> > getting reset support back. Patch is below and it's received minimal
> > testing - it boots, removes the callback trace and error message and
> > doesn't seem to cause problems (the only disk in the machine is on this
> > card).
> I think it's a good beginning.  However, there are some things that
> could be done to improve it.
> 
> > +int i91u_bus_reset(Scsi_Cmnd * SCpnt)
> > +{
> > +	HCS *pHCB;
> > +
> > +	pHCB = (HCS *) SCpnt->device->host->base;
> > +	tul_reset_scsi_bus(pHCB);
> 
> This won't quite do beacuse tul_reset_scsi_bus() has some really nasty
> properties
> 
> Under the old error handler, the reset routine was responsible for
> resetting the bus, waiting the timeout (which tul_reset_scsi_bus() does
> with a busy wait) and flushing the queue.
> 
> In the new scheme, the eh thread takes care of all of this (including a
> nice thread based wait).
> 
> I think this may all work correctly if you change this call to:
> 
> tul_reset_scsi(pHCB, 0);
> 
> instead.  That should simply reset the bus and not busy wait at all,
> which is really what the error handler is expecting.
 
Ahhh, cunning. I've changed this over and it seems to work ok. I'm not
sure what sort of testing needs done though. As before it compiles and
boots without problems and I haven't seen any issues in basic use.

J.

-- 
 OK, if we can't have a tour, can  |  .''`.  Debian GNU/Linux Developer
  we at least have a look around?  | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA +
                                   |   `-    DSA keys on the keyservers.
