Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUC3Voi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUC3Voi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:44:38 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:21382 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261347AbUC3Vo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:44:26 -0500
Date: Tue, 30 Mar 2004 23:44:22 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Hans-Peter Jansen <hpj@urpla.net>, linux-kernel@vger.kernel.org
Subject: Re: VMware-workstation-4.5.1 on linux-2.6.4-x86_64 host fai
Message-ID: <20040330214422.GH22319@vana.vc.cvut.cz>
References: <19772436779@vcnet.vc.cvut.cz> <200403241955.38489.hpj@urpla.net> <20040330123331.GB461@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330123331.GB461@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 02:33:31PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Hmm, it's a SuSE issue then, nice to know (and easily fixable ;-).
> > 
> > > On 2.6.x kernels additionally (problem you are hitting now)
> > > SIO*BRIDGE ioctls were moved from "compatible" to "not so
> > > compatible" group. If you'll just mark them as "compatible", it
> > > will work sufficiently well to get networking in VMware.
> > 
> > I found it. Fixed it with this patch:
> > 
> > --- include/linux/compat_ioctl.h~	2004-03-12 18:37:26.000000000 +0100
> > +++ include/linux/compat_ioctl.h	2004-03-24 12:34:30.000000000 +0100
> > @@ -247,10 +247,10 @@
> >  COMPATIBLE_IOCTL(SIOCSIFENCAP)
> >  COMPATIBLE_IOCTL(SIOCGIFENCAP)
> >  COMPATIBLE_IOCTL(SIOCSIFNAME)
> > -/* FIXME: not compatible
> > +/* FIXME: not compatible */
> >  COMPATIBLE_IOCTL(SIOCSIFBR)
> >  COMPATIBLE_IOCTL(SIOCGIFBR)
> > -*/
> > +/* reactivated for vmware */
> >  COMPATIBLE_IOCTL(SIOCSARP)
> >  COMPATIBLE_IOCTL(SIOCGARP)
> >  COMPATIBLE_IOCTL(SIOCDARP)
> 
> Marking ioctl compatible when it is not is pretty nasty, right? What
> about writing conversion functions?

Well, main problem is that VMware uses SIOCSIFBR and SIOCGIFBR with completely
different semantic than everybody else, and for VMware identical translation
is correct for SIOCSIFBR. SIOCGIFBR (for which identical translation is
not correct) does not appear to be used at all.

I'll fill bugreport with VMware. For existing systems correct solution is:
(1a) Mark SIOCSIFBR as COMPATIBLE_IOCTL.
(1b) No change is needed for SIOCGIFBR.
(2) Your bridge control tools must be 64bit app. As they'll not run when built
    as 32bit app anyway, no big damage is caused here...

							Best regards,
								Petr Vandrovec


