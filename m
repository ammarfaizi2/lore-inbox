Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWFGAJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWFGAJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWFGAJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:09:23 -0400
Received: from xenotime.net ([66.160.160.81]:964 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751389AbWFGAJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:09:22 -0400
Date: Tue, 6 Jun 2006 17:12:09 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Paul Fulghum <paulkf@microgate.com>
Cc: khc@pm.waw.pl, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
Message-Id: <20060606171209.2b21dbb4.rdunlap@xenotime.net>
In-Reply-To: <1149638211.2633.21.camel@localhost.localdomain>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<1149622813.11929.3.camel@amdx2.microgate.com>
	<m3u06yc9mr.fsf@defiant.localdomain>
	<20060606134816.363cbeca.rdunlap@xenotime.net>
	<20060606140822.c6f4ef37.rdunlap@xenotime.net>
	<m3zmgpc3ba.fsf@defiant.localdomain>
	<20060606160745.2f88ff9c.rdunlap@xenotime.net>
	<m3ejy1c0uw.fsf@defiant.localdomain>
	<1149638211.2633.21.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2006 18:56:51 -0500 Paul Fulghum wrote:

> On Wed, 2006-06-07 at 01:37 +0200, Krzysztof Halasa wrote:
> > "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> > 
> > > I'm on x86-64 if it matters.
> > > My .config is attached.
> > 
> > Ok, reproduced.
> > 
> > The problem is that CONFIG_WAN is not set, the make system doesn't
> > read drivers/net/wan/Makefile at all, and nothing in drivers/net/wan
> > is being built.
> > 
> > Just another argument against random SELECTs.
> 
> OK, I thought he was building with the latest patch (attached here),
> which adds the 'select WAN' reverse dependency.
> I tested his .config with the patch (minus the Makefile portion) and
> it builds just fine.

No, I wasn't using any patches...

> There is nothing random about these select statements.
> They are chosen specifically to fix the dependencies.
> You may feel they are ugly, but 'select' is the only tool
> I know of that fixes these errors without losing flexibility.

They are random in the sense that HDLC depends on WAN but only
HDLC was being selected.  In theory I would have expected
config (software) to automatically enable higher-level config
symbols in this case (select HDLC to cause select WAN),
but that doesn't happen, so we got some "random" config
which isn't supported (or even valid) ("random" being "invalid"
in this case).


> --- linux-2.6.17-rc5-mm3/drivers/char/Kconfig	2006-06-06 14:03:58.000000000 -0500
> +++ b/drivers/char/Kconfig	2006-06-06 14:08:53.000000000 -0500
> @@ -197,6 +197,7 @@ config ISI
>  config SYNCLINK
>  	tristate "SyncLink PCI/ISA support"
>  	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
> +	select WAN if SYNCLINK_HDLC
>  	select HDLC if SYNCLINK_HDLC
>  	help
>  	  Driver for SyncLink ISA and PCI synchronous serial adapters.
> @@ -214,6 +215,7 @@ config SYNCLINK_HDLC
>  config SYNCLINKMP
>  	tristate "SyncLink Multiport support"
>  	depends on SERIAL_NONSTANDARD && PCI
> +	select WAN if SYNCLINKMP_HDLC
>  	select HDLC if SYNCLINKMP_HDLC
>  	help
>  	  Driver for SyncLink Multiport (2 or 4 ports) PCI synchronous serial adapter.
> @@ -231,6 +233,7 @@ config SYNCLINKMP_HDLC
>  config SYNCLINK_GT
>  	tristate "SyncLink GT/AC support"
>  	depends on SERIAL_NONSTANDARD && PCI
> +	select WAN if SYNCLINK_GT_HDLC
>  	select HDLC if SYNCLINK_GT_HDLC
>  	help
>  	  Support for SyncLink GT and SyncLink AC families of
> --- linux-2.6.17-rc5-mm3/drivers/char/pcmcia/Kconfig	2006-06-06 14:03:58.000000000 -0500
> +++ b/drivers/char/pcmcia/Kconfig	2006-06-06 14:09:25.000000000 -0500
> @@ -8,6 +8,7 @@ menu "PCMCIA character devices"
>  config SYNCLINK_CS
>  	tristate "SyncLink PC Card support"
>  	depends on PCMCIA
> +	select WAN if SYNCLINK_CS_HDLC
>  	select HDLC if SYNCLINK_CS_HDLC
>  	help
>  	  Driver for SyncLink PC Card synchronous serial adapter.


---
~Randy
