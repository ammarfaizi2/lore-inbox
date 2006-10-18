Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWJRO5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWJRO5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWJRO5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:57:24 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:38331 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1161084AbWJRO5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:57:23 -0400
Date: Wed, 18 Oct 2006 08:57:22 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Brian King <brking@us.ibm.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, Adam Belay <abelay@MIT.EDU>
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
Message-ID: <20061018145722.GP22289@parisc-linux.org>
References: <20061017145146.GJ22289@parisc-linux.org> <45354A59.3010109@us.ibm.com> <20061018145104.GN22289@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018145104.GN22289@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 08:51:04AM -0600, Matthew Wilcox wrote:
> This reimplementation uses a global wait queue and a bit per device.
> I've open-coded prepare_to_wait() / finish_wait() as I could optimise
> it significantly by knowing that the pci_lock protected us at all points.

I forgot to report how I've tested it.  Using the 'test' patch from
yesterday, I have two processes running lspci in an infinite loop.  When
I write a 1 to /sys/bus/pci/devices/0000\:00\:01.0/block, they both
halt.  When I write a 0, they both resume.

Then I tried doing echo 0 >/sys/bus/pci/devices/0000\:00\:01.0/block a
second time, and I got the WARNing I expected.

animal:~# echo 1 >/sys/bus/pci/devices/0000\:00\:01.0/block                     
animal:~# echo 1 >/sys/bus/pci/devices/0000\:00\:01.0/block                     
animal:~# echo 0 >/sys/bus/pci/devices/0000\:00\:01.0/block                     

They both resumed (as expected; we don't support nesting).

animal:~# echo 1 >/sys/bus/pci/devices/0000\:00\:01.0/block                     
animal:~# echo 1 >/sys/bus/pci/devices/0000\:00\:01.1/block                     
animal:~# echo 0 >/sys/bus/pci/devices/0000\:00\:01.0/block                     
animal:~# echo 0 >/sys/bus/pci/devices/0000\:00\:01.1/block                     

Both resumed only after the second echo 0 (as lspci reads all devices
before printing anything).

It's not exactly rigorous testing, but I couldn't think of any other
cases to try.
