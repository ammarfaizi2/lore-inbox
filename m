Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUFARJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUFARJI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 13:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUFARJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 13:09:08 -0400
Received: from apegate.roma1.infn.it ([141.108.7.31]:52614 "EHLO apona.ape")
	by vger.kernel.org with ESMTP id S265127AbUFARI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 13:08:58 -0400
Message-ID: <40BCB821.5050903@roma1.infn.it>
Date: Tue, 01 Jun 2004 19:08:49 +0200
From: Davide Rossetti <davide.rossetti@roma1.infn.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en, it
MIME-Version: 1.0
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com>
In-Reply-To: <40BC9EF7.4060502@shadowconnect.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Lidel wrote:

> Hello,
>
> Jeff Garzik wrote:
>
>>> could someone help me with a ioremap problem. If there are two 
>>> controllers plugged in, the ioremap request for the first controller 
>>> is successfull, but the second returns NULL. Here is the output of 
>>> the driver:
>>> i2o: Checking for PCI I2O controllers...
>>> i2o: I2O controller on bus 0 at 72.
>>> i2o: PCI I2O controller at 0xD0000000 size=134217728
>>> I2O: MTRR workaround for Intel i960 processor
>>> i2o/iop0: Installed at IRQ17
>>> i2o: I2O controller on bus 0 at 96.
>>> i2o: PCI I2O controller at 0xD8000000 size=134217728
>>> i2o: Unable to map controller.
>>
>> If "size=xxxx" indicates the size you are remapping, then that's
>
I saw the same problem on a PCI card with a 128MB BAR. it is triggered 
on an Tyan opteron mobo, while on a old Dell P4 mobo it is ok. I 
followed a bit the source code for ioremap and found two places in which 
it can fail,

    area = get_vm_area(size, VM_IOREMAP);
    if (!area)
        return NULL;
    addr = area->addr;
    if (remap_area_pages(VMALLOC_VMADDR(addr), phys_addr, size, flags)) {
        vfree(addr);
        return NULL;
    }

I had not time to add debug printk and recompila the kernel to check 
which one is faulty...

The strange thing is that the BARs seems to be laid out correctly, so it 
does not look like a bios bug...

>
>> probably too large an area to be remapping.  Try remapping only the
>> memory area needed, and not the entire area.
>
>
> Is there a way, to increase the size, which could be remapped, or is 
> there a way, to find out what is the maximum size which could be 
> remapped?

we tried with half and it was ok, then we moved up a bit and found the 
maximum around 80MB I think...


