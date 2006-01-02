Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWABUPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWABUPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWABUPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:15:50 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:62332 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751013AbWABUPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:15:50 -0500
Date: Mon, 02 Jan 2006 14:15:40 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: X86_64 + VIA + 4g problems
In-reply-to: <200601022053.31534.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43B989EC.2050704@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5qvTv-8f-17@gated-at.bofh.it> <5qAKf-7n4-19@gated-at.bofh.it>
 <43B97C6D.7010902@shaw.ca> <200601022053.31534.ak@suse.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>This brings up something I've been wondering. It's possible to run most 
>>64-bit capable PCI devices in a 32-bit slot (i.e. with the 64-bit part 
>>hanging out of the slot). In this configuration the device will not be 
>>able to use 64-bit DMA (unless it supports dual address cycle). However, 
>>who is supposed to detect this and know to not try to use DMA addresses 
>>above 4GB on that device? 
> 
> 
> 64bit PCI-X bus has nothing to do with the addressing capability. It
> just gives you more bandwidth.

Indeed, I misunderstood how this worked.. Accesses to addresses >4GB 
must always use DAC addressing, the address can just be decoded faster 
if the extra 64-bit data lines are connected.

I think there could still be an issue if the PCI bus does not support 
DAC and the device tries to use PCI DAC addressing causing the bus to 
choke or the wrong RAM to get accessed. Apparently this is a real 
problem according to MS:

http://www.microsoft.com/whdc/system/platform/server/PAE/PAEdrv.mspx

"Unfortunately, Microsoft is finding that not all PCI buses on a system 
board support DAC, which is required for a 32-bit PCI adapter to address 
more than 4 GB of memory. Furthermore, there is no way for a DAC-capable 
PCI device (or its associated driver) to know that it is running on a 
non-DAC-capable bus."

Microsoft's solution is to disable all memory above 4GB if 
non-DAC-capable buses are present - largely due to their API limitations 
and the number of broken drivers that don't call proper DMA functions. 
Haha to them, I guess..

I'm not sure if this would be an issue with Linux. I would suspect that 
it could be, if there are indeed such buses that can't support DAC.. In 
this case the right thing to do would be to reject requests for DMA 
masks larger than 4GB for devices located on such a bus.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
