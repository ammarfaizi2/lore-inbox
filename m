Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423186AbWCXGd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423186AbWCXGd1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWCXGd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:33:27 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:24985 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423186AbWCXGd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:33:26 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] compile error when building multiple EHCI host controllers as modules
Date: Thu, 23 Mar 2006 22:33:21 -0800
User-Agent: KMail/1.7.1
Cc: Kumar Gala <galak@kernel.crashing.org>, Greg KH <gregkh@suse.de>,
       LKML mailing list <linux-kernel@vger.kernel.org>
References: <25E2BA7D-378B-45B0-995C-201A68432D5C@kernel.crashing.org>
In-Reply-To: <25E2BA7D-378B-45B0-995C-201A68432D5C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603232233.22422.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 2:26 pm, Kumar Gala wrote:

> "ehci-pci.c".  I was wondering if there were an thoughts on how to  
> address this so I can build as a module.

Hmm, there was a patch to fix that for OHCI a while back, I'm not
sure what happened to it.  Maybe the cleaned up version just never
got posted as promised.

The problem is that there need to be two different init (and exit)
section routines for the bus glue:  platform_bus and/or pci_bus.

PCs typically just have PCI; battery-oriented SOCs tend to never
have PCI; and we're now starting to see some non-battery SOCs that
include PCI support as well as integrated USB host support.

The *hci-hcd.c file should be converted to have a single module_init()
and module_exit() routine at the end, looking something like

	static int __init Xhci_init(void)
	{
		int status;

		/* various shared stuff, dump version etc */

		/* SOCs usually use only this path */
		status = Xhci_platform_register();
		if (status < 0)
			return status;

		/* PCs, and a few higher powered SOCs, use this */
		status = Xhci_pci_register();
		if (status < 0)
			Xhci_platform_unregister();
		return status;
	}
	module_init(Xhci_init);

Likewise for module_exit.  The #includes for the platform-specific glue
(including PCI) would define those Xhci_platform_*() routine, and it's
a simple bit of #ifdeffery to make sure there's always at least some
NOP default available for those.

- Dave
