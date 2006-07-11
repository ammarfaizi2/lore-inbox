Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWGKI0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWGKI0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWGKI0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:26:12 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:52948 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750743AbWGKI0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:26:11 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Fix a memory leak in the i386 setup code
Date: Tue, 11 Jul 2006 10:26:27 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060710221308.5351.78741.stgit@localhost.localdomain> <200607110025.57812.rjw@sisk.pl> <b0943d9e0607110047x5f494981h1925c950d34459f0@mail.gmail.com>
In-Reply-To: <b0943d9e0607110047x5f494981h1925c950d34459f0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607111026.27821.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 July 2006 09:47, Catalin Marinas wrote:
> On 10/07/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Does x86_64 need a similar fix?
> 
> Doesn't look like it needs this.
> 
> > On Tuesday 11 July 2006 00:13, Catalin Marinas wrote:
> > > --- a/arch/i386/kernel/setup.c
> > > +++ b/arch/i386/kernel/setup.c
> > > @@ -1327,7 +1327,10 @@ #endif
> > >               res->start = e820.map[i].addr;
> > >               res->end = res->start + e820.map[i].size - 1;
> > >               res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> > > -             request_resource(&iomem_resource, res);
> > > +             if (request_resource(&iomem_resource, res)) {
> > > +                     kfree(res);
> > > +                     continue;
> > > +             }
> > >               if (e820.map[i].type == E820_RAM) {
> > >                       /*
> > >                        *  We don't know which RAM region contains kernel data,
> >
> > Evidently res is used if e820.map[i].type == E820_RAM, so it should
> > be freed later on, it seems.
> 
> The "if" block I added has a "continue" and therefore the E820_RAM
> case is skipped. There is no point in requesting a resource with "res"
> as parent when "res" couldn't be successfully acquired.

Ah, right, it's freed when request_resource(&iomem_resource, res) fails.
Sorry for the noise.

Rafael
