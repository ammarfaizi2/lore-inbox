Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966735AbWKOKME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966735AbWKOKME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966736AbWKOKME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:12:04 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:27372 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S966735AbWKOKMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:12:01 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Wed, 15 Nov 2006 11:09:05 +0100
User-Agent: KMail/1.9.1
Cc: Christian Hoffmann <chrmhoffmann@gmail.com>,
       linux-fbdev-devel@lists.sourceforge.net,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611150154.39499.chrmhoffmann@gmail.com> <1163555308.5940.177.camel@localhost.localdomain>
In-Reply-To: <1163555308.5940.177.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151109.06956.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 15 November 2006 02:48, Benjamin Herrenschmidt wrote:
> On Wed, 2006-11-15 at 01:54 +0100, Christian Hoffmann wrote:
> > On Tuesday 14 November 2006 23:07, Benjamin Herrenschmidt wrote:
> > > > I tried that patch, but the last message I see over netconsole (using
> > > > tg3) is: Suspending console(s)
> > > > and then nothing. Nothing on resume at all :(
> > > >
> > > > Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume
> > > > (radeon_pm.c) didn't help: I don't see them. But I am not a kernel
> > > > programmer at all, so I might do something wrong or in the wrong place.
> > >
> > > Does it resume if you make radeon_pci_resume() a nop ?
> > >
> > > Of course, the fbdev will not come back, but will the machine overall
> > > resume ?
> > >
> > > Ben.
> > Yes, if i make radeon_pci_resume a nop, the machine resumes if i do a return 0 
> > immediately.
> > I think I tracked it down to the call to acquire_console_sem() as the 
> > following code makes the machine hang again:
> > 
> > int radeonfb_pci_resume(struct pci_dev *pdev)
> > {
> >         struct fb_info *info = pci_get_drvdata(pdev);
> >         struct radeonfb_info *rinfo = info->par;
> >         int rc = 0;
> >         if (pdev->dev.power.power_state.event == PM_EVENT_ON)
> >                 return 0;
> >         if (rinfo->no_schedule) {
> >         /*      if (try_acquire_console_sem())*/
> >                         return 0;
> >         } else
> >                 acquire_console_sem();
> > 
> >         return 0;
> > ...
> 
> Well, if you acquire the console sem you need to release it too :-)

Or the console semaphore is acquired too many times.

Christian, could you please add release_console_sem() before 'return 0'
and see if that makes the code work again?  If not, could you add a printk()
in kernel/printk.c/acquire_console_sem() to see how many times it is called?

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
