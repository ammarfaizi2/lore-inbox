Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937652AbWLFV0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937652AbWLFV0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937649AbWLFV0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:26:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49495 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937652AbWLFV0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:26:40 -0500
Message-ID: <4577344B.4020404@redhat.com>
Date: Wed, 06 Dec 2006 16:21:15 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: Alexander Neundorf <a.neundorf-work@gmx.net>, ben.collins@ubuntu.com,
       linux-kernel@vger.kernel.org, adobriyan@gmail.com,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>		<20061205184921.GA5029@martell.zuzino.mipt.ru>		<4575FF08.2030100@redhat.com> <1165383349.7443.78.camel@gullible>  <457685D1.1080501@s5r6.in-berlin.de> <20061206114036.130470@gmx.net> <4576B9CC.5060700@s5r6.in-berlin.de>
In-Reply-To: <4576B9CC.5060700@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
...
> Another question is whether the stack-internal APIs are really fit for
> non-OHCI chips. There is an unfinished low-level driver for GP2Lynx
> which worked to some degree at some point, but other than that I don't
> remember positive or negative reports in this department. Maybe proper
> documentation of the stack-internal APIs would already help embedded
> developers a lot. Furthermore, there may be question marks WRT
> interaction of the FireWire stack with architecture specific kernel code.

I think some of the problems with the current stack come from the fact that it 
was originally written (by Andreas Bombe) for the PCILynx chipset, in other 
words, *not* for the OHCI chipset.  The PCILynx chipset is a much lower level 
chipset, it offloads much more to software.  For example, each self ID is 
received as an individual packet, where the OHCI chipset receives these into a 
special buffer and notifies software when it has received a consistent set of 
packets.  The current stack has a callback for the host controller driver to 
call once the bus reset phase starts, a callback for each received self ID and 
a callback to indicate the end of the bus reset phase.

In the new stack, the controller/core interface is more suited for the OHCI 
controller.  The stack doens't go into a bus reset state, and all self IDs are 
reported as an atomic event.  This makes the upper layers much simpler, suits 
the OHCI controller better, and should only require a few lines extra code in 
a PCILynx driver to buffer up the self IDs.  And it's arguably better to have 
the PCILynx driver do this than have the OHCI controller split up and 
otherwise atomic event.

> But back to the subject matter: Clearly, Kristian concentrates on
> PCI/OHCI-1394 hardware at the moment. If embedded developers have
> specific requirements on the FireWire stack's design, they should IMO
> contribute with a list of requirements or maybe even with patches.

It's true that I'm developing for PCI+OHCI, but I've kept the controller/core 
stack split that the old stack has, nothing outside the OHCI driver depends on 
PCI (I'm using the generic DMA API).  I've shifted the abstraction level up a 
bit for the controller interface, which makes sense in general, but also since 
this is what every desktop or laptop out there has.  That said, I don't think 
anything in the stack design will break for embedded/non-OHCI chipsets.

cheers,
Kristian
