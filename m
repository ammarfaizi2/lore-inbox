Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422980AbWJFVdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422980AbWJFVdT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWJFVdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:33:19 -0400
Received: from xenotime.net ([66.160.160.81]:60568 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751257AbWJFVdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:33:18 -0400
Date: Fri, 6 Oct 2006 14:34:37 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Judith Lebzelter <judith@osdl.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Kconfig dependency !VT for VIOCONS
Message-Id: <20061006143437.f7338860.rdunlap@xenotime.net>
In-Reply-To: <20061006200007.GD3684@shell0.pdx.osdl.net>
References: <20061006180549.GB3684@shell0.pdx.osdl.net>
	<20061006200007.GD3684@shell0.pdx.osdl.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 13:00:07 -0700 Judith Lebzelter wrote:

> Actually, this gets rid of the CONFIG_VIOCONS from my .config, but 
> then I get another warning when I build:
> 
> Warning! Found recursive dependency: VT VIOCONS VT
> 
> Can anyone suggest something?

I think that your patch is mostly good/correct, but one more line
is needed on the VT side:  a deletion.

This works for me:

From: Randy Dunlap <rdunlap@xenotime.net>

Make allmodconfig .config build successfully by making VIOCONS
available only if VT=n.  VT need not check VIOCONS.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/powerpc/platforms/iseries/Kconfig |    2 +-
 drivers/char/Kconfig                   |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2619-rc1g2.orig/arch/powerpc/platforms/iseries/Kconfig
+++ linux-2619-rc1g2/arch/powerpc/platforms/iseries/Kconfig
@@ -3,7 +3,7 @@ menu "iSeries device drivers"
 	depends on PPC_ISERIES
 
 config VIOCONS
-	tristate "iSeries Virtual Console Support (Obsolete)"
+	tristate "iSeries Virtual Console Support (Obsolete)" if !VT
 	help
 	  This is the old virtual console driver for legacy iSeries.
 	  You should use the iSeries Hypervisor Virtual Console
--- linux-2619-rc1g2.orig/drivers/char/Kconfig
+++ linux-2619-rc1g2/drivers/char/Kconfig
@@ -7,7 +7,6 @@ menu "Character devices"
 config VT
 	bool "Virtual terminal" if EMBEDDED
 	select INPUT
-	default y if !VIOCONS
 	---help---
 	  If you say Y here, you will get support for terminal devices with
 	  display and keyboard devices. These are called "virtual" because you




> Thanks,
> Judith
> 
> On Fri, Oct 06, 2006 at 11:05:49AM -0700, Judith Lebzelter wrote:
> > From: Judith Lebzelter <judith@osdl.org>
> > 
> > Add Kconfig dependency !VT for VIOCONS
> > 
> > I would like to avoid this compile error in 'allmodconfig':
> > drivers/char/viocons.c:52:2: error: #error You must turn off CONFIG_VT to use CONFIG_VIOCONS
> > 
> > Signed-off-by: Judith Lebzelter <judith@osdl.org>
> > ---
> > 
> > Index: linux/arch/powerpc/platforms/iseries/Kconfig
> > ===================================================================
> > --- linux.orig/arch/powerpc/platforms/iseries/Kconfig	2006-10-05 09:35:09.000000000 -0700
> > +++ linux/arch/powerpc/platforms/iseries/Kconfig	2006-10-06 10:30:19.333425703 -0700
> > @@ -4,6 +4,7 @@
> >  
> >  config VIOCONS
> >  	tristate "iSeries Virtual Console Support (Obsolete)"
> > +	depends on !VT
> >  	help
> >  	  This is the old virtual console driver for legacy iSeries.
> >  	  You should use the iSeries Hypervisor Virtual Console


---
~Randy
