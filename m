Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUIAPkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUIAPkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266925AbUIAPkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:40:10 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:32640 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266914AbUIAPiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:38:09 -0400
Message-ID: <4135EC84.6070407@rtr.ca>
Date: Wed, 01 Sep 2004 11:36:36 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: bzolnier@milosz.na.pl, Lee Revell <rlrevell@joe-job.com>,
       Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <200408272005.08407.bzolnier@elka.pw.edu.pl> <1093630121.837.39.camel@krustophenia.net> <200408272059.51779.bzolnier@elka.pw.edu.pl> <4135CC9E.5060905@rtr.ca> <4135E017.1000901@pobox.com>
In-Reply-To: <4135E017.1000901@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Doing this is either pointless or impossible on newer SATA controllers.
 >  Most are memory-mapped I/O not PIO, where the high-order bits of the
 > ATA taskfile are accessed due to an extended register size, not
 > "double-pumping" a FIFO.
 >
 > Even-newer SATA controllers are FIS-based rather than taskfile-based, so
 > you pass it a FIS (containing all the registers) unconditionally.

PCI accesses are not free, so anything that avoids having to
go over the PCI bus is a worthwhile optimization.

The processor buses run at 200-800Mhz or so, whereas PCI is normally
only clocking at 33Mhz, sometimes at 66Mhz.

With good ADMA or host-queuing controllers that access system
memory directly for their command blocks, then there's not much
(if any) penalty for the extra LBA48 setup.  But for "normal"
controllers (if such a beast even exists), the extra writes across
the PCI bus can be costly.

Hardware write-buffer FIFOs between the CPU and the PCI bus
can reduce the impact of this somewhat, but they are often
only 2-4 entries deep, and will be filled by a normal (S)ATA
command setup sequence.

This is one of those finer points that is very difficult to measure,
since the I/O throughput is pretty much unaffected by it.  But CPU
cycle count per-I/O setup is one way to measure it.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

Jeff Garzik wrote:
> Mark Lord wrote:
> 
>> Bartlomiej Zolnierkiewicz wrote:
>>
>>>
>>>> What determines whether 48 bit addressing will be used then?
>>>
>>>
>>>
>>> Availability of 48-bit addressing feature set and host capabilities
>>> (some don't support LBA48 when DMA is used etc.).
>>
>>
>>
>> I haven't examined the "released" IDE drivers in some time,
>> but one optimisation that can save a LOT of CPU usage
>> is for the driver to only use LBA48 *when necessary*,
>> and use LBA28 I/O otherwise.
>>
>> Each access to an IDE register typically chews up 600+ns,
>> or the equivalent of a couple thousand instruction executions
>> on a modern core.  Avoiding LBA48 when it's not needed will
>> save four such accesses per I/O, or about 2.5us.
> 
> 
> 
> Doing this is either pointless or impossible on newer SATA controllers. 
>  Most are memory-mapped I/O not PIO, where the high-order bits of the 
> ATA taskfile are accessed due to an extended register size, not 
> "double-pumping" a FIFO.
> 
> Even-newer SATA controllers are FIS-based rather than taskfile-based, so 
> you pass it a FIS (containing all the registers) unconditionally.
> 
>     Jeff
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

