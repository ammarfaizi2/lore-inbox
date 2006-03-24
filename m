Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWCXQ7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWCXQ7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWCXQ7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:59:16 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:20939 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751145AbWCXQ7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:59:15 -0500
In-Reply-To: <200603232233.22422.david-b@pacbell.net>
References: <25E2BA7D-378B-45B0-995C-201A68432D5C@kernel.crashing.org> <200603232233.22422.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <97434D6A-A556-4288-8F13-7048E416E611@kernel.crashing.org>
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       LKML mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] compile error when building multiple EHCI host controllers as modules
Date: Fri, 24 Mar 2006 10:59:10 -0600
To: David Brownell <david-b@pacbell.net>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 24, 2006, at 12:33 AM, David Brownell wrote:

> On Thursday 23 March 2006 2:26 pm, Kumar Gala wrote:
>
>> "ehci-pci.c".  I was wondering if there were an thoughts on how to
>> address this so I can build as a module.
>
> Hmm, there was a patch to fix that for OHCI a while back, I'm not
> sure what happened to it.  Maybe the cleaned up version just never
> got posted as promised.
>
> The problem is that there need to be two different init (and exit)
> section routines for the bus glue:  platform_bus and/or pci_bus.
>
> PCs typically just have PCI; battery-oriented SOCs tend to never
> have PCI; and we're now starting to see some non-battery SOCs that
> include PCI support as well as integrated USB host support.
>
> The *hci-hcd.c file should be converted to have a single module_init()
> and module_exit() routine at the end, looking something like
>
> 	static int __init Xhci_init(void)
> 	{
> 		int status;
>
> 		/* various shared stuff, dump version etc */
>
> 		/* SOCs usually use only this path */
> 		status = Xhci_platform_register();
> 		if (status < 0)
> 			return status;
>
> 		/* PCs, and a few higher powered SOCs, use this */
> 		status = Xhci_pci_register();
> 		if (status < 0)
> 			Xhci_platform_unregister();
> 		return status;
> 	}
> 	module_init(Xhci_init);
>
> Likewise for module_exit.  The #includes for the platform-specific  
> glue
> (including PCI) would define those Xhci_platform_*() routine, and it's
> a simple bit of #ifdeffery to make sure there's always at least some
> NOP default available for those.

The issue I have this is that it makes two (or more) things that were  
independent now dependent.  What about just moving the module_init/ 
exit() functions into files that are built separately.  For the ehci- 
fsl case it was trivial, need to look at ehci-pci case.

- kumar
