Return-Path: <linux-kernel-owner+w=401wt.eu-S932727AbWLPXJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbWLPXJG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 18:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbWLPXJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 18:09:06 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:59957 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727AbWLPXJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 18:09:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:subject:message-id:mime-version:content-type:con
	tent-disposition:in-reply-to:user-agent;
	b=JUbb8qWMfUMDW/NkaVq7H307ESh7srxXuv+fRkIJLzel5j4R3eTwwHULE7kck
	CAdyHnVkoC7DATNKcbqC7+CoA==
Date: Sun, 17 Dec 2006 00:09:01 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Francois Romieu <romieu@fr.zoreil.com>, Martin Michlmayr <tbm@cyrius.com>,
       Riku Voipio <riku.voipio@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061216230901.GA23143@xi.wantstofly.org>
References: <20061109221338.GA17722@electric-eye.fr.zoreil.com> <20061109231408.GB6611@xi.wantstofly.org> <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com> <20061121204527.GA13549@electric-eye.fr.zoreil.com> <20061122231656.GA9991@electric-eye.fr.zoreil.com> <20061215132740.GD11579@xi.wantstofly.org> <20061215201522.GA11288@electric-eye.fr.zoreil.com> <20061215210329.GB14860@xi.wantstofly.org> <20061215211435.GB10367@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215211435.GB10367@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 09:14:35PM +0000, Russell King wrote:

> > > > Is there a way we can have this done by default on the n2100?  I guess
> > > > that since it's a PCI device, there isn't much hope for that..?
> > > 
> > > Do you mean an automagically tuned default value based on CONFIG_ARM ?
> > 
> > No, that wouldn't make sense, that's like making a workaround depend on
> > arch == i386.
> > 
> > I'm thinking that we should somehow enable this option on the n2100
> > built-in r8169 ports by default only.  Since the n2100 also has a mini-PCI
> > slot, and it is in theory possible to put an r8169 on a mini-PCI card,
> > the workaround probably shouldn't apply to those, so testing for
> > CONFIG_MACH_N2100 also isn't the right thing to do.
> 
> There is dev->broken_parity_status ... although exactly what the sematics
> of that flag actually are seems to be rather vague - there's code which
> sets it for the Mellanox Tavor device, but it seems to only be exposed
> via sysfs - no code in drivers/pci seems to take any action based upon
> this flag being set.

Sounds good.  How about something like the patch below plus the
corresponding r8169 diff?


Index: linux-2.6.19/arch/arm/mach-iop32x/n2100.c
===================================================================
--- linux-2.6.19.orig/arch/arm/mach-iop32x/n2100.c
+++ linux-2.6.19/arch/arm/mach-iop32x/n2100.c
@@ -123,9 +123,13 @@ static struct hw_pci n2100_pci __initdat
 
 static int __init n2100_pci_init(void)
 {
-	if (machine_is_n2100())
+	if (machine_is_n2100()) {
 		pci_common_init(&n2100_pci);
 
+		pci_get_bus_and_slot(0, 0x08)->broken_parity_status = 1;
+		pci_get_bus_and_slot(0, 0x10)->broken_parity_status = 1;
+	}
+
 	return 0;
 }
