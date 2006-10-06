Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWJFB3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWJFB3O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 21:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWJFB3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 21:29:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47080 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932552AbWJFB3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 21:29:13 -0400
Date: Thu, 5 Oct 2006 18:29:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
In-Reply-To: <4525A9E9.6080301@garzik.org>
Message-ID: <Pine.LNX.4.64.0610051821280.3952@g5.osdl.org>
References: <200610051910.25418.ak@suse.de> <452564B9.4010209@garzik.org>
 <Pine.LNX.4.64.0610051536590.3952@g5.osdl.org> <200610060052.46538.ak@suse.de>
 <Pine.LNX.4.64.0610051600440.3952@g5.osdl.org> <4525A9E9.6080301@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Oct 2006, Jeff Garzik wrote:

> Linus Torvalds wrote:
> > (And we should probably have the "pci=mmiocfg" kernel command line entry
> > that forces MMIOCFG regardless of any e820 issues, even for normal
> > accesses).
> 
> Something like this?

Yes, except I look at the resulting messy conditional:

        if ((type == 1) && (!(pci_probe & PCI_NO_CHECKS)) &&
                !e820_all_mapped(pci_mmcfg_config[0].base_address,
                        pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
                        E820_RESERVED)) {

and it's totally unreadable, so how about making this a helper inline 
function like

	static inline int validate_mmcfg(int type, unsigned long address)
	{
		/*
		 * If type 1 accesses don't work, assume we run on a
		 * Mac and always use MCFG
		 */
		if (type != 1)
			return 1;

		/*
		 * If the user asked us to not check the MMIOCFG base 
		 * address, just trust it.
		 */
		if (pci_probe & PCI_NO_CHECKS)
			return 1;

		/*
		 * Otherwise require that it's marked reserved in 
		 * the e820 tables
		 */
		return e820_all_mapped(address,
			address + MMCONFIG_APER_MIN,
			E820_RESERVED);
	}

and then just saying

	if (!validate_mmcfg(type, pci_mmcfg_config[0].base_address)) {
		.. complain and exit ..

which just seems a hell of a lot prettier to me.

It also means that _if_ we ever figure out other ways to double-check the 
address automatically (or we have some automatic way of saying "that can't 
be valid"), we can do so in that "validate" function, without adding more 
and more horrible code.

What say you? Let's try to keep the code readable (and preferably make it 
more so..)

			Linus
