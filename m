Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266771AbUFRTaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266771AbUFRTaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266587AbUFRT0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:26:07 -0400
Received: from crl-mail.crl.dec.com ([192.58.206.9]:39143 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S266570AbUFRTYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:24:14 -0400
Message-ID: <40D340FB.3080309@hp.com>
Date: Fri, 18 Jun 2004 15:22:35 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       greg@kroah.com, tony@atomide.com, david-b@pacbell.net,
       joshua@joshuawise.com
Subject: Re: DMA API issues
References: <1087582845.1752.107.camel@mulgrave> 	<20040618193544.48b88771.spyro@f2s.com> <1087584769.2134.119.camel@mulgrave>
In-Reply-To: <1087584769.2134.119.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>You still haven't explained what you want to do though.  Apart from the
>occasional brush with usbstorage, I don't have a good knowledge of the
>layout of the USB drivers.  I assume you simply want to persuade the
>ohci driver to use your memory area somehow, but what do you actually
>want the ohci driver to do with it?  And how much leeway do you get to
>customise the driver.
>
>  
>
It's really not a question of laziness.  The ASICs we are interested in 
implement OHCI, so I think the core OHCI driver should work unmodified.  
OHCI driver allocates dma_pools for managing endpoint descriptors (ED) 
and transaction descriptors (TD).  I expect that the driver wrapper that 
initializes the OHCI controller driver will create dma_pools drawing 
from the ASIC's private SRAM.  The OHCI driver uses 
dma_{alloc,free}_coherent to manage the space used for the top level 
control structure shared between the driver and the controller 
hardware.  This also needs to be allocated in the SRAM.  Finally, in 
drivers/usb/core/usb.c, the USB drivers call dma_map_single and 
dma_unmap_single given pointers to transfer buffers allocated by the USB 
device drivers.  If the USB device is a network device (as it is on the 
iPAQ), the transfer buffers are allocated via dev_alloc_skb. 

>The reason I'm asking is beause it's still unclear whether this is a DMA
>API issue or an ohci one.  I could solve my Q720 issue simply by
>exporting an interface from the ncr driver to supply alternative memory
>allocation use and descriptors.
>
>  
>
I really think this is a DMA API implementation issue.  The problem 
touches more than the USB drivers.  I say implementation because the DMA 
API already takes struct device, so the public interface would not have 
to change or would not have to change much.  However, we would like to 
be able to provide device-specific implementations of the dma 
operations.  One way to implement this would be a pointer to 
dma_operations from struct device.

Jamey

