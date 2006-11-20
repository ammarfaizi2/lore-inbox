Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934244AbWKTPo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934244AbWKTPo1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934249AbWKTPo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:44:27 -0500
Received: from h155.mvista.com ([63.81.120.155]:6598 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S934244AbWKTPo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:44:26 -0500
Message-ID: <4561CDB8.2030309@ru.mvista.com>
Date: Mon, 20 Nov 2006 18:46:00 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
 type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>	 <1163966437.5826.99.camel@localhost.localdomain>	 <20061119200650.GA22949@elte.hu>	 <1163967590.5826.104.camel@localhost.localdomain>	 <4560BDF5.400@ru.mvista.com>	 <1163968376.5826.110.camel@localhost.localdomain>	 <4560C121.30403@ru.mvista.com>	 <1163968885.5826.116.camel@localhost.localdomain>	 <4560C409.9030709@ru.mvista.com> <1163970524.5826.128.camel@localhost.localdomain>
In-Reply-To: <1163970524.5826.128.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Benjamin Herrenschmidt wrote:
>>    I'm not sure it's feasible. The idea behind level/edge flows is to 
>>eliminate the interrupt priority I think. That's why they EOI ASAP (with the 
>>level handler masking IRQ before that) -- this way the other interrupts may 
>>come thru.

> Well, the idea behind the level/edge flow is not exactly that afaik.
> It's more like having tailored handlers for level/edge on PICs that are
> not intelligent to auto-mask with a priority mecanism (ie. dumb PICs
> which are very common in the embedded field, and for example, on ARM
> where genirq takes its roots).

    That was a conclusion to which I came after looking at the 8259 code (that 
PIC being full capable of the priority masking).

>>    I used to think that fasteoi was intended for SMP PICs which are 
>>intelligent enough to mask off the interrupts pending delivery or handling on 
>>CPUs and unmask them upon receiving EOI -- just like x86 IOAPIC does.

> In general, PICs that are intelligent enough to mask off, wether using
> something as you describe or using priorities. I don't feel the need of
> going through hoops to allow lower or same priority interrupts in.
> First, if you really need an interrupt to be serviced quick, then you
> can just give it a higher priority. In the general case however, I do
> -not- want to allow interrupts to stack up. Imagine a big IBM machine
> with hundreds interrupt lines, what happens to the kernel stack if we
> let them interrupt each other ?

    Well, such machines are SMP usually... :-)

>> This 
>>way, the acceptance of the lower priority interrupts shouldn't be hindered on 
>>the other CPUs. Maybe the scheme is different for OpenPIC (I know it has the 
>>different interrupt distribution scheme from IOAPIC)?

> I don't think there is a real need to let lower priority interrupts in
> on a CPU that is currently handling a higher priority one.

    Nevertheless, 8259 drivers are doing exactly this on UP machines -- and 
they were doing this before and after genirq conversion...

> Ben.

WBR, Sergei
