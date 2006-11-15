Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966623AbWKOBs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966623AbWKOBs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 20:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966444AbWKOBs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 20:48:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:43499 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S966623AbWKOBs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 20:48:57 -0500
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Hoffmann <chrmhoffmann@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200611150154.39499.chrmhoffmann@gmail.com>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	 <200611142247.55137.chrmhoffmann@gmail.com>
	 <1163542033.5940.156.camel@localhost.localdomain>
	 <200611150154.39499.chrmhoffmann@gmail.com>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 12:48:27 +1100
Message-Id: <1163555308.5940.177.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 01:54 +0100, Christian Hoffmann wrote:
> On Tuesday 14 November 2006 23:07, Benjamin Herrenschmidt wrote:
> > > I tried that patch, but the last message I see over netconsole (using
> > > tg3) is: Suspending console(s)
> > > and then nothing. Nothing on resume at all :(
> > >
> > > Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume
> > > (radeon_pm.c) didn't help: I don't see them. But I am not a kernel
> > > programmer at all, so I might do something wrong or in the wrong place.
> >
> > Does it resume if you make radeon_pci_resume() a nop ?
> >
> > Of course, the fbdev will not come back, but will the machine overall
> > resume ?
> >
> > Ben.
> Yes, if i make radeon_pci_resume a nop, the machine resumes if i do a return 0 
> immediately.
> I think I tracked it down to the call to acquire_console_sem() as the 
> following code makes the machine hang again:
> 
> int radeonfb_pci_resume(struct pci_dev *pdev)
> {
>         struct fb_info *info = pci_get_drvdata(pdev);
>         struct radeonfb_info *rinfo = info->par;
>         int rc = 0;
>         if (pdev->dev.power.power_state.event == PM_EVENT_ON)
>                 return 0;
>         if (rinfo->no_schedule) {
>         /*      if (try_acquire_console_sem())*/
>                         return 0;
>         } else
>                 acquire_console_sem();
> 
>         return 0;
> ...

Well, if you acquire the console sem you need to release it too :-)

Ben.


