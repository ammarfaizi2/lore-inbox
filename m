Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVL2Sl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVL2Sl3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 13:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVL2Sl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 13:41:29 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6336 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750800AbVL2Sl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 13:41:29 -0500
Date: Thu, 29 Dec 2005 12:40:13 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PCI DMA burst delay
In-reply-to: <5p7gt-3lu-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: bschoelpen@web.de
Message-id: <43B42D8D.70508@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
References: <5p7gt-3lu-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burkhard Schölpen wrote:
> Hello,
> 
> I'm working on a linux driver for a custom pci card (containing a Xilinx FPGA) which is bus master capable and has to transfer large amounts of data with high bandwidth. I finally succeeded in mmaping the dma buffer residing in ram to user space to avoid unnecessary copying. So actually it seems to work quite well, but sometimes I get some trouble (which seems to occur randomly) concerning dma transfers from ram to the device. When this problem occurs, it leads to the fact, that data arrives too late at the input fifo on the pci card (16kBit).
> 
> Looking at some signals with an oscilloscope shows the following behaviour:
> 1. After preparing the dma buffer in ram and telling the pci card that the dma transfer should begin, the first dma burst is transmitted in a normal way.
> 2. After the first burst, the pci bus grant signal is disabled, so the access to the bus seems to be denied.
> 3. About 400 nanoseconds later, the pci device tries to initiate the next burst, but does not succeed (pci bus access is not granted)
>   => this process is repeated 3 times
> 4. In most cases the next burst starts here after the third trial (and all other following bursts are following well). But in the (rarely) faulty case, the 2nd burst only starts after another delay of about 600ns, which is too late, because meanwhile I get a buffer underrun in the FPGA. After some delayed bursts the transfer continues normally.
> 
> Does anybody have an idea, why the dma bursts could be delayed, although I deactivated all other pci devices that could disturb the transfers? Maybe it is a quite simple issue, because I'm not yet very experienced with dma stuff. Could it be a problem with my driver implementation, because if the problem occurs, it is always after the first burst? The dma buffer in ram I allocated with pci_alloc_consistent() as described in Rubini's book and the DMA-mapping.txt documentation file.

What kind of PCI transaction is the core using to do the reads? I think 
that Memory Read can cause bursts to be interrupted quickly on some 
chipsets. If you can use Memory Read Line or Memory Read Multiple this 
may increase performance.

You may also need more buffering in the FPGA, otherwise you may be 
vulnerable to underruns if there is contention on the PCI bus. The 
device should be able to handle normal arbitration delays.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

