Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWCHCbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWCHCbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWCHCbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:31:46 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:47584 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932321AbWCHCbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:31:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AZhxF1lSukFLOITSK7Fo1RjeteQ6vtKMBgvwY/dFeoQbAWSeZPhrdyI8uW7kESrgShH0jiWOcheZw9/b1oFogdIF/FKWTQwfQupoJiVqfdOZB0i65i+Meby3wX0zAeBUjtxW8WG2wbtc1opoi9OpMwOGqCtQM+qBkDgyfjirYYs=
Message-ID: <440E4203.7040303@gmail.com>
Date: Wed, 08 Mar 2006 11:31:31 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jeff Garzik <jeff@garzik.org>, Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
References: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org> <4408CEC8.7040507@garzik.org> <20060308020028.GB26028@kroah.com>
In-Reply-To: <20060308020028.GB26028@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Mar 03, 2006 at 06:18:32PM -0500, Jeff Garzik wrote:
> 
>>I have a similar situation:
>>
>>BIOS initializes PCI device to mode A, I need to switch it to mode B. 
>>To do this, I must assign a value to an MMIO PCI BAR that was not 
>>initialized at boot.
>>
>>How to do this?
> 
> 
> I really don't know, what kind of device wants to do this?
> 

Jeff is probably talking about ABAR of ICH controllers. ABAR (AHCI BAR, 
memory mapped IO region covering all AHCI registers) isn't needed for 
IDE mode operation and the BAR register is disabled when the chip is in 
IDE mode. However, ABAR becomes necessary for 1. accessing SCR registers 
(for SATA phy monitor and control) or 2. switching on AHCI mode manually 
(some notebook BIOSes always initalize ICH6/7m's into IDE mode even when 
the controller does support AHCI mode.

So, the problem is that the chip actually disables the PCI BAR if 
certain switches aren't turned on and thus BIOSes are likely not to 
reserve mmio address for the BAR. We can turn on proper switches during 
driver initialization but we don't know how to wiggle the BAR into mmio 
address space.

-- 
tejun
