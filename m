Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966611AbWKTUHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966611AbWKTUHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966622AbWKTUHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:07:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:20141 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S966611AbWKTUHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:07:11 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <20061120100144.GA27812@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	 <1163966437.5826.99.camel@localhost.localdomain>
	 <20061119200650.GA22949@elte.hu>
	 <1163967590.5826.104.camel@localhost.localdomain>
	 <20061119202348.GA27649@elte.hu>
	 <1163985380.5826.139.camel@localhost.localdomain>
	 <20061120100144.GA27812@elte.hu>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 07:07:10 +1100
Message-Id: <1164053230.8073.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 11:01 +0100, Ingo Molnar wrote:

> so the question is not 'is there an ACK' (all non-MSI-type-of IRQ 
> delivery mechanisms have some sort of ACK mechanism), but what is the 
> precise structure of ACK-ing an IRQ that the host recieves.
> 
> on PPC64, 'get the vector' initiates an ACK as well - is that done 
> before handle_irq() is done?

Yes.

> > So by doing a mask followed by an eoi, you essentially mask the 
> > interrupt preventing further delivery of that interrupt and lower the 
> > CPU priority in the PIC thus allowing processing of further 
> > interrupts.
> 
> correct, that's what should happen.
> 
> > Are there other fasteoi controllers than the ones I have on powerpc 
> > anyway ?
> 
> well, if you mean the x86 APICs, there you get the vector 'for free' as 
> part of the IRQ entry call sequence, and there's an EOI register in the 
> local APIC that notifies the IRQ hardware, lowers the CPU priority, etc. 
> We have that as an ->eoi handler right now.

Ok, so that's like me. Which means that what you need is a specific thre
aded_fasteoi flow handler that does mask & eoi, not ack.

Note that I still think it would work in the absence of mask too if the
controller only does edge interrupts, as it is the case for the cell.

Cheers,
Ben.

