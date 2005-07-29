Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVG2RGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVG2RGZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVG2REC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:04:02 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:50915 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262667AbVG2RCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:02:31 -0400
Date: Fri, 29 Jul 2005 10:02:18 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: RFC: 64-bit resources and changes to pci, ioremap, ...
Message-ID: <20050729170218.GA30600@plexity.net>
Reply-To: dsaxena@plexity.net
References: <D72313E7-E2EC-4066-AD2A-02DAFE66B7E6@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D72313E7-E2EC-4066-AD2A-02DAFE66B7E6@freescale.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 29 2005, at 10:53, Kumar Gala was caught saying:
> The main issue that I'm starting to see is that the concept of a  
> physical address from the processors point of view needs to be  
> consistent throughout all subsystems of the kernel.  Currently the  
> major usage of struct resource is with the PCI subsystem and PCI  
> drivers.  The following are some questions that I was hoping to get  
> answers to and discussion around:
>
> * How many 32-bit systems support larger than 32-bit physical  
> addresses (I know newer PPCs do)?

Intel's new XSC3 ARM core supports up to 36-bit addressing and 
they have several CPUs based on this that are already out or will
be released in the next year. I can currently get around 64-bit
resources by playing ugly tricks with the memory map and trapping
ioremap() calls to a certain unused 32-bit physical range and fixing 
it up to 64-bit (like PPC440?? does) but that may not work on future
CPUs that don't have holes in the memmap.

> * How many 32-bit systems support a 64-bit PCI address space?

This is a fairly common thing on some of the Intel XScale I/O and
network processors. Some of the Intel CPUs provide a window in 
32-bit CPU that translates to 64-bit PCI space.

> * Should ioremap and variants start taking 64-bit physical addresses?

If we are to use 64 bit resources, then yes. Or pfns...

Do a google for my real opinion on this. I think ioremap() should take 
a device and resource describing the address of the resources in the
address space of the device (the bus it is one). The whole resource 
and I/O subwystem currently assumes that physical and PCI bus address 
spaces are one and the same, but I have HW that breaks this assumption 
by allowing up to 2 GB of RAM and 3GB of PCI devices. Whenever this
has been brought up though, Linus has shot it down. What we need is
a real concept of per-bus address spaces and resources. But that is
far more complicated change.

> * Do we make this an arch option and wrap start and end in a typedef  
> similar to pte_t and provide accessor macros to ensure proper use?

Probably the best thing to do b/c on really small systems that 
don't have 64-bit needs, we'll just be wasting memory with the
extra data structure size. We need to scale down to PCI systems
with just 8MB of RAM.

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
