Return-Path: <linux-kernel-owner+w=401wt.eu-S964955AbXABVBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbXABVBH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbXABVBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:01:06 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:46579 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964955AbXABVBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:01:05 -0500
Message-ID: <459AC808.1030807@pobox.com>
Date: Tue, 02 Jan 2007 16:00:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>
CC: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>	<459973F6.2090201@pobox.com> <20070102115834.1e7644b2@localhost.localdomain>
In-Reply-To: <20070102115834.1e7644b2@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> This is a slight variant on the patch I posted December 16th to fix
> libata combined mode handling. The only real change is that we now
> correctly also reserve BAR1,2,4. That is basically a neatness issue.
> 
> Jeff was unhappy about two things
> 
> 1. That it didn't work in the case of one channel native one channel
> legacy. 

> This is a silly complaint because the SFF layer in libata doesn't handle
> this case yet anyway.

Yes, it's "silly" people people use configurations you find inconvenient.

At least one embedded x86 case cares, that I know of.  They only needed 
to make two minor changes to make it work.


> 2. The case where combined mode is in use and IDE=n. 

> In this case the libata quirk code reserves the resources in question
> correctly already.

Not /all/ the resources.  And YOU were the person harping me about 
acquiring all resources, so that even races no one cares about[1] are 
avoided.


But those two items were just from my five-minute, on-vacation review. 
Obvious bug #3:

The code no long reserves resources for the "extra" PCI BAR that often 
exists on PCI controllers regardless of legacy/native mode.  Previously, 
the code called pci_request_regions() to reserve ALL regions attached to 
the PCI device.

You have suddenly decided that it's OK to --not reserve at all-- these 
additional regions.

Proof:  The AHCI PCI BAR (#5, zero-based) is clearly NOT reserved, even 
though we talk to it, in piix_disable_ahci() of ata_piix.c.

	Jeff



