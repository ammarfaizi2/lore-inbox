Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbTEQII3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 04:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTEQII3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 04:08:29 -0400
Received: from dp.samba.org ([66.70.73.150]:56739 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261272AbTEQII1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 04:08:27 -0400
Date: Sat, 17 May 2003 18:21:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ranty@debian.org,
       LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517082120.GE13827@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Oliver Neukum <oliver@neukum.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, ranty@debian.org,
	LKML <linux-kernel@vger.kernel.org>,
	Simon Kelley <simon@thekelleys.org.uk>,
	"Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
	jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
References: <1053101342.5589.5.camel@dhcp22.swansea.linux.org.uk> <200305170013.49808.oliver@neukum.org> <20030517045008.GD13827@zax> <200305170902.58835.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305170902.58835.oliver@neukum.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 09:02:58AM +0200, Oliver Neukum wrote:
> Am Samstag, 17. Mai 2003 06:50 schrieb David Gibson:
> > On Sat, May 17, 2003 at 12:13:49AM +0200, Oliver Neukum wrote:
> > > Am Freitag, 16. Mai 2003 18:09 schrieb Alan Cox:
> > > > On Gwe, 2003-05-16 at 09:07, Oliver Neukum wrote:
> > > > > So, if I understand you correctly, RAM is only saved if a device
> > > > > is hotpluggable and needs firmware only upon intial connection.
> > > > > Which, if you do suspend to disk correctly, is no device.
> > > >
> > > > Thats just because the interface is a little warped not the theory.
> > > > On a resume you need to reload firmware and you already handle
> > > > rediscovery on USB bus for example because the devices can change
> > >
> > > Right. But the order of resumption is fixed by hardware needs.
> > > So during resumption you cannot use block devices and therefore
> > > not start a hotplug script. Or did I miss something?
> >
> > For devices that aren't essentialy to get userspace running
> > (e.g. network on a laptop running from local disk), the firmware
> > request doesn't have to happen during the hairy part of resumption.
> 
> Not true for network cards. Somebody might be running NFS
> over it. The problem is that you cannot tell (or rather shouldn't - it's
> a layering violation).

Potentially, yes, usually no (hence "running from local disk" above).
This is why Manuel wants to make persistence runtime selectable.

It may well be a bit messy in the scripts to make sure all the right
drivers have persistent firmwares, and I'm sure there will be some
funny corner cases, but I don't think it's an insoluble problem.

If you have to be able to reinitialize any device from suspend without
userland running, then clearly there is no way around having all
necessary firmware images RAM resident.  But there are many situations
where that's not necessary - so why should they have to pay for the
worst case.

> Anything that is used for paging needs to be back to life before
> you can think about resurrecting user space.
> Also you need to bring keyboards back to life early to make
> sysreq work.
> 
> Secondly, you need a way to get essential devices to work in
> all cases. If you implement it, why not use it?
> 
> > The device could just mark itself as unusable at suspend time, then at
> > resume it schedule_work()s something to reload the firmware and
> > complete reinitialization.  Shortly after userspace is back in action,
> > the device will come back to life.
> 
> Is supposed to. You cannot put blind trust into that. You need to use
> a pretty arbitrary timeout to deal with this.

So?  Something could go wrong, but things can go wrong in lots of
places, I don't see what's so especially dire about this situation?

> I fail to see technical improvements here.

Improvements over *what*.  There is no existing method for pulling
firmware images into the kernel.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
