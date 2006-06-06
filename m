Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWFFX5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWFFX5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWFFX5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:57:13 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:49626
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750933AbWFFX5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:57:13 -0400
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
From: Paul Fulghum <paulkf@microgate.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
In-Reply-To: <m3ejy1c0uw.fsf@defiant.localdomain>
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
Content-Type: text/plain
Date: Tue, 06 Jun 2006 18:56:51 -0500
Message-Id: <1149638211.2633.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 01:37 +0200, Krzysztof Halasa wrote:
> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> 
> > I'm on x86-64 if it matters.
> > My .config is attached.
> 
> Ok, reproduced.
> 
> The problem is that CONFIG_WAN is not set, the make system doesn't
> read drivers/net/wan/Makefile at all, and nothing in drivers/net/wan
> is being built.
> 
> Just another argument against random SELECTs.

OK, I thought he was building with the latest patch (attached here),
which adds the 'select WAN' reverse dependency.
I tested his .config with the patch (minus the Makefile portion) and
it builds just fine.

There is nothing random about these select statements.
They are chosen specifically to fix the dependencies.
You may feel they are ugly, but 'select' is the only tool
I know of that fixes these errors without losing flexibility.


--- linux-2.6.17-rc5-mm3/drivers/char/Kconfig	2006-06-06 14:03:58.000000000 -0500
+++ b/drivers/char/Kconfig	2006-06-06 14:08:53.000000000 -0500
@@ -197,6 +197,7 @@ config ISI
 config SYNCLINK
 	tristate "SyncLink PCI/ISA support"
 	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
+	select WAN if SYNCLINK_HDLC
 	select HDLC if SYNCLINK_HDLC
 	help
 	  Driver for SyncLink ISA and PCI synchronous serial adapters.
@@ -214,6 +215,7 @@ config SYNCLINK_HDLC
 config SYNCLINKMP
 	tristate "SyncLink Multiport support"
 	depends on SERIAL_NONSTANDARD && PCI
+	select WAN if SYNCLINKMP_HDLC
 	select HDLC if SYNCLINKMP_HDLC
 	help
 	  Driver for SyncLink Multiport (2 or 4 ports) PCI synchronous serial adapter.
@@ -231,6 +233,7 @@ config SYNCLINKMP_HDLC
 config SYNCLINK_GT
 	tristate "SyncLink GT/AC support"
 	depends on SERIAL_NONSTANDARD && PCI
+	select WAN if SYNCLINK_GT_HDLC
 	select HDLC if SYNCLINK_GT_HDLC
 	help
 	  Support for SyncLink GT and SyncLink AC families of
--- linux-2.6.17-rc5-mm3/drivers/char/pcmcia/Kconfig	2006-06-06 14:03:58.000000000 -0500
+++ b/drivers/char/pcmcia/Kconfig	2006-06-06 14:09:25.000000000 -0500
@@ -8,6 +8,7 @@ menu "PCMCIA character devices"
 config SYNCLINK_CS
 	tristate "SyncLink PC Card support"
 	depends on PCMCIA
+	select WAN if SYNCLINK_CS_HDLC
 	select HDLC if SYNCLINK_CS_HDLC
 	help
 	  Driver for SyncLink PC Card synchronous serial adapter.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


