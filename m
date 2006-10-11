Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030591AbWJKEdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030591AbWJKEdr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 00:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030597AbWJKEdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 00:33:46 -0400
Received: from xenotime.net ([66.160.160.81]:60369 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030591AbWJKEdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 00:33:46 -0400
Date: Tue, 10 Oct 2006 21:35:10 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: Judith Lebzelter <judith@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Kconfig dependency !VT for VIOCONS
Message-Id: <20061010213510.c095cf2e.rdunlap@xenotime.net>
In-Reply-To: <20061011043006.GF721@stusta.de>
References: <20061006180549.GB3684@shell0.pdx.osdl.net>
	<20061006200007.GD3684@shell0.pdx.osdl.net>
	<20061006143437.f7338860.rdunlap@xenotime.net>
	<20061010045534.GA3650@stusta.de>
	<20061010091004.d6d91f8d.rdunlap@xenotime.net>
	<20061011035629.GC721@stusta.de>
	<20061010210858.f8c85692.rdunlap@xenotime.net>
	<20061011043006.GF721@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 06:30:06 +0200 Adrian Bunk wrote:

> On Tue, Oct 10, 2006 at 09:08:58PM -0700, Randy Dunlap wrote:
> > On Wed, 11 Oct 2006 05:56:29 +0200 Adrian Bunk wrote:
> > 
> > > On Tue, Oct 10, 2006 at 09:10:04AM -0700, Randy Dunlap wrote:
> > > > On Tue, 10 Oct 2006 06:55:34 +0200 Adrian Bunk wrote:
> > > > 
> > > > > On Fri, Oct 06, 2006 at 02:34:37PM -0700, Randy Dunlap wrote:
> > > > > > On Fri, 6 Oct 2006 13:00:07 -0700 Judith Lebzelter wrote:
> > > > > > 
> > > > > > > Actually, this gets rid of the CONFIG_VIOCONS from my .config, but 
> > > > > > > then I get another warning when I build:
> > > > > > > 
> > > > > > > Warning! Found recursive dependency: VT VIOCONS VT
> > > > > > > 
> > > > > > > Can anyone suggest something?
> > > > > > 
> > > > > > I think that your patch is mostly good/correct, but one more line
> > > > > > is needed on the VT side:  a deletion.
> > > > > > 
> > > > > > This works for me:
> > > > > > 
> > > > > > From: Randy Dunlap <rdunlap@xenotime.net>
> > > > > > 
> > > > > > Make allmodconfig .config build successfully by making VIOCONS
> > > > > > available only if VT=n.  VT need not check VIOCONS.
> > > > > > 
> > > > > > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > > > > > ---
> > > > > >  arch/powerpc/platforms/iseries/Kconfig |    2 +-
> > > > > >  drivers/char/Kconfig                   |    1 -
> > > > > >  2 files changed, 1 insertion(+), 2 deletions(-)
> > > > > > 
> > > > > > --- linux-2619-rc1g2.orig/arch/powerpc/platforms/iseries/Kconfig
> > > > > > +++ linux-2619-rc1g2/arch/powerpc/platforms/iseries/Kconfig
> > > > > > @@ -3,7 +3,7 @@ menu "iSeries device drivers"
> > > > > >  	depends on PPC_ISERIES
> > > > > >  
> > > > > >  config VIOCONS
> > > > > > -	tristate "iSeries Virtual Console Support (Obsolete)"
> > > > > > +	tristate "iSeries Virtual Console Support (Obsolete)" if !VT
> > > > > >  	help
> > > > > >...
> > > > > >  config VT
> > > > > >  	bool "Virtual terminal" if EMBEDDED
> > > > > 
> > > > > With this dependency on EMBEDDED, you could as well simply remove 
> > > > > VIOCONS...
> > > > > 
> > > > > >  	select INPUT
> > > > > > -	default y if !VIOCONS
> > > > > 
> > > > > Removing the "default y" is wrong.
> > > > 
> > > > Oops, yes, agreed.
> > > > 
> > > > I don't see a way (using: make ARCH=powerpc iseries_defconfig,
> > > > which wants to enable VIOCONS) to prevent VT from being enabled
> > > > so that VIOCONS can be enabled.
> > > 
> > > With iseries_defconfig, CONFIG_VT is not enabled.
> > > 
> > > > However, since VIOCONS is marked (Obsolete) and since the powerpc
> > > > people don't comment on this patch & problem, maybe Judith is the
> > > > only person who cares.
> > > 
> > > allmodconfig turns on CONFIG_EMBEDDED.
> > 
> > So am I doing this incorrectly?
> > 
> > $ make ARCH=powerpc iseries_defconfig
> > 
> > $editor .config
> > 
> > CONFIG_VT=y
> > ...
> > #
> > # iSeries device drivers
> > #
> > CONFIG_VIODASD=y
> > CONFIG_VIOCD=m
> > CONFIG_VIOTAPE=m
> > CONFIG_VIOPATH=y
> 
> CONFIG_VIOCONS is not enabled.

Yep.  That was with my patch.
But I see what you mean.  Thanks.

---
~Randy
