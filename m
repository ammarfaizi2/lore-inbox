Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263976AbTEGRBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTEGRBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:01:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6930 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263976AbTEGRBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:01:39 -0400
Date: Wed, 7 May 2003 18:14:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The magical mystical changing ethernet interface order
Message-ID: <20030507181410.A19615@flint.arm.linux.org.uk>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20030507141458.B30005@flint.arm.linux.org.uk> <20030507082416.0996c3df.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030507082416.0996c3df.rddunlap@osdl.org>; from rddunlap@osdl.org on Wed, May 07, 2003 at 08:24:16AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 08:24:16AM -0700, Randy.Dunlap wrote:
> What version of 2.5?

2.5.69.

> There was a patch 17 days ago by Chuck Ebbert (merged by akpm) that
> "fixed" PCI scan order in 2.5 to be same as 2.4.  Comment in changelog
> says "Russell King has acked this change."

Yes, that affects the order of PCI devices on the global list when
you have multiple PCI buses present.  This machine has only one PCI
bus, so is not affected by this issue.

Note that I haven't been running 2.5 kernels on NetWinders until recently,
so I couldn't say when it changed.  A wild stab in the dark, I'd think
maybe the init ordering changed:

2.5.69 (System.map):

c0023ba4 t __initcall_ne2k_pci_init
c0023ba8 t __initcall_pcnet32_init_module
c0023bac t __initcall_eepro100_init_module
c0023bb0 t __initcall_tulip_init

2.4.19 (System.map):

c004ddd4 ? __initcall_tulip_init
c004ddd8 ? __initcall_vortex_init
c004dddc ? __initcall_ne2k_pci_init

2.2.18 (drivers/net/Space.c):

#ifdef CONFIG_NE2K_PCI
        {ne2k_pci_probe, 0},
#endif
#ifdef CONFIG_PCNET32
        {pcnet32_probe, 0},
#endif
#ifdef CONFIG_EEXPRESS_PRO100   /* Intel EtherExpress Pro/100 */
        {eepro100_probe, 0},
#endif
#ifdef CONFIG_LANMEDIA          /* Lanmedia must be before Tulip */
        {lmc_probe_fake, 0},
#endif
#if defined(CONFIG_DEC_ELCP) || defined(CONFIG_DEC_ELCP_OLD)
        {tulip_probe, 0},
#endif

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

