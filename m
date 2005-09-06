Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVIFXQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVIFXQM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbVIFXQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:16:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751008AbVIFXQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:16:10 -0400
Date: Tue, 6 Sep 2005 16:13:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [patch 2.6.13 2/2] 3c59x: add option for using memory-mapped
 PCI I/O resources
Message-Id: <20050906161330.0138f5a2.akpm@osdl.org>
In-Reply-To: <20050906225744.GB26003@tuxdriver.com>
References: <20050906204147.GC20145@tuxdriver.com>
	<20050906204400.GD20145@tuxdriver.com>
	<20050906205429.GA19319@infradead.org>
	<20050906140414.40b65253.akpm@osdl.org>
	<20050906220922.GA26003@tuxdriver.com>
	<20050906151546.4d5ed4db.akpm@osdl.org>
	<20050906225744.GB26003@tuxdriver.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John W. Linville" <linville@tuxdriver.com> wrote:
>
> On Tue, Sep 06, 2005 at 03:15:46PM -0700, Andrew Morton wrote:
> > "John W. Linville" <linville@tuxdriver.com> wrote:
> > >
> > > I fully intend to have have a flag in the private data set based on
> > >  the PCI ID when I accumulate some data on which devices support this
> > >  and which don't.  So far I've only got a short list...  Do you think
> > >  such a flag should be based on which ones work, or which ones break?
> > 
> > The ones which are known to work.
> > 
> > Bear in mind that this is an old, messy and relatively stable driver which
> > handles a huge number of different NICs.   Caution is the rule here.
> 
> I definitely agree.  That is another part of why I defaulted to "use_mmio=0".
> 
> I'll post PCI ID based patches as I determine supported cards.
> 

What I'd suggest you do is to look at enabling the feature for, say,
IS_CYCLONE and IS_TORNADO NICs.  Do that as a separate -mm patch, make sure
that an explicit `use_mmio=0' will still turn it off.

So in the style of that driver, something like:

static int use_mmio[MAX_UNITS] = { [ 0 .. MAX_UNITS-1 ] = -1, };

Then:

	if (module parm given)
		use_mmio[unit] = 1 or 0

	...

	/* Determine the default if the user didn't override us */
	if (use_mmio[unit] == -1 && (IS_CYCLONE || IS_TORNADO))
		use_mmio[unit] = 1;

	priv->use_mmio = use_mmio[unit];	(maybe)

	....

	if (priv->use_mmio == 1)
		do mmio stuff


There's a bit to be done here, so I'll drop your initial set of patches.

btw, Donald Becker's 3c59x.c has done mmio for ages.  Suggest you take a
look in there. http://www.scyld.com/vortex.html
