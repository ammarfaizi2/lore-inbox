Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVBDXw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVBDXw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVBDXw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:52:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:34275 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261645AbVBDXvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:51:20 -0500
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, Andrew Morton <akpm@osdl.org>,
       Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <200502041336.59892.arnd@arndb.de>
References: <20050204072254.GA17565@austin.ibm.com>
	 <200502041336.59892.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 10:49:49 +1100
Message-Id: <1107560989.2189.119.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 13:36 +0100, Arnd Bergmann wrote:
> On Freedag 04 Februar 2005 08:22, Olof Johansson wrote:
> > It's getting pretty old to have see and type cur_cpu_spec->cpu_features
> > & CPU_FTR_<feature>, when a shorter and less TLA-ridden macro is more
> > readable.
> > 
> > This also takes care of the differences between PPC and PPC64 cpu
> > features for the common code; most places in PPC could be replaced with
> > the macro as well.
> 
> I have a somewhat similar patch that does the same to the
> systemcfg->platform checks. I'm not sure if we should use the same inline
> function for both checks, but I do think that they should be used in a
> similar way, e.g. CPU_HAS_FEATURE(x) and PLATFORM_HAS_FEATURE(x).

Note that I would prefer cpu_has_feature(), it doesn't strictly have to
be a macro and has function semantics anyway.

> My implementation of the platform checks tries to be extra clever by turning
> runtime checks into compile time checks if possible. This reduces code size
> and in some cases execution speed. It can also be used to replace compile
> time checks, i.e. it allows us to write
> 
> static inline unsigned int readl(const volatile void __iomem *addr)
> {
> 	if (platform_is(PLATFORM_PPC_ISERIES))
> 		return iSeries_readl(addr);
> 	if (platform_possible(PLATFORM_PPC_PSERIES))
> 		return eeh_readl(addr);
> 	return in_le32();
> }
> 
> which will always result in the shortest code for any combination of
> CONFIG_PPC_ISERIES, CONFIG_PPC_PSERIES and the other platforms.

That's a good idea !

> The required code for this is roughly
> 
> enum {
> 	PPC64_PLATFORM_POSSIBLE =
> #ifdef CONFIG_PPC_ISERIES
> 		PLATFORM_ISERIES |
> #endif
> #ifdef CONFIG_PPC_PSERIES
> 		PLATFORM_PSERIES |
> #endif
> #ifdef CONFIG_PPC_PSERIES
> 		PLATFORM_PSERIES_LPAR |
> #endif
> #ifdef CONFIG_PPC_POWERMAC
> 		PLATFORM_POWERMAC |
> #endif
> #ifdef CONFIG_PPC_MAPLE
> 		PLATFORM_MAPLE |
> #endif
> 		0,
> 	PPC64_PLATFORM_ONLY =
> #ifdef CONFIG_PPC_ISERIES
> 		PLATFORM_ISERIES &
> #endif
> #ifdef CONFIG_PPC_PSERIES
> 		PLATFORM_PSERIES &
> #endif
> #ifdef CONFIG_PPC_POWERMAC
> 		PLATFORM_POWERMAC &
> #endif
> #ifdef CONFIG_PPC_MAPLE
> 		PLATFORM_MAPLE &
> #endif
> 		-1ul,
> };
> 
> static inline platform_is(unsigned long platform)
> {
> 	return ((PPC64_PLATFORM_ONLY & platform) 
> 	 || (PPC64_PLATFORM_POSSIBLE & platform & systemcfg->platform));
> }
> 
> static inline platform_possible(unsigned long platform)
> {
> 	reutrn !!(PPC64_PLATFORM_POSSIBLE & platform);
> }
> 
> The same stuff is obviously possible for cur_cpu_spec->cpu_features as well.
> Do you think that it will help there?
> 
> 	Arnd <><
> _______________________________________________
> Linuxppc64-dev mailing list
> Linuxppc64-dev@ozlabs.org
> https://ozlabs.org/cgi-bin/mailman/listinfo/linuxppc64-dev
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

