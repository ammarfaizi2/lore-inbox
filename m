Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbTK0LiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 06:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbTK0LiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 06:38:09 -0500
Received: from zero.aec.at ([193.170.194.10]:24326 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264482AbTK0LiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 06:38:06 -0500
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] How drivers notice a HW error?
From: Andi Kleen <ak@muc.de>
Date: Thu, 27 Nov 2003 12:37:47 +0100
In-Reply-To: <WpR1.1LG.3@gated-at.bofh.it> (Hidetoshi Seto's message of
 "Thu, 27 Nov 2003 09:40:11 +0100")
Message-ID: <m3n0aim48k.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <WpR1.1LG.3@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> writes:

> On some platform, for example IA64, the chipset detects an error caused by
> driver's operation such as I/O read, and reports it to kernel. Linux kernel
> analyzes the error and decides to kill the driver or reboot at worst.
> I want to convey the error information to the offending driver, and want to
> enable the driver to recover the failed operation.
>A
> So, just a plan, I think about a readb_check function that has checking ability
> enable it to return error value if error is occurred on read. Drivers could use
> readb_check instead of usual readb, and could diagnosis whether a retry be
> required or not, by the return value of readb_check.

I don't think that's an good portable API. On many architectures it is hard to 
associate an MCE with an specific instruction because the MCE 
happnes asynchronously. All the MCE handler gets is an address. Also
adding error checks to every read* would make the driver source quite 
unreadable.

Also I think most drivers would not attempt to specially handle every
access but just implement a generic handler that shutdowns the device
(otherwise it would be a testing nightmare). 

So better would be:

Add a callback to the pci_dev/device. When an error occurs in a mmio
area associated with a driver call that callback.

Add another function to register other memory areas (in case a driver
does mmio not visible in PCI config)  for error handling.

-Andi

