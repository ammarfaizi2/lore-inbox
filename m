Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266475AbUFRSwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266475AbUFRSwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUFRSwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:52:46 -0400
Received: from crl-mail.crl.dec.com ([192.58.206.9]:3044 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S266722AbUFRSfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:35:06 -0400
Message-ID: <40D3356E.8040800@hp.com>
Date: Fri, 18 Jun 2004 14:33:18 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
CC: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org, greg@kroah.com,
       tony@atomide.com, david-b@pacbell.net, joshua@joshuawise.com
Subject: Re: DMA API issues
References: <20040618175902.778e616a.spyro@f2s.com> <20040618110721.B3851@home.com>
In-Reply-To: <20040618110721.B3851@home.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter wrote:

>On Fri, Jun 18, 2004 at 05:59:02PM +0100, Ian Molton wrote:
>  
>
>>I have a System On Chip device which, among other functions, contains an
>>OHCI controller and 32K of SRAM.
>>
>>heres the catch:- The OHCI controller has a different address space than
>>the host bus, and worse, can *only* DMA data from its internal SRAM.
>>
>>The architecture is not broken, merely unusual.
>>
>>This causes the following problems:
>>
>>1) The DMA API provides no methods to set up a mapping between the host
>>   memory map and the devices view of the space
>>        example:
>>           the OHCI controller above would see its 32K of SRAM as
>>           mapped from 0x10000 - 0x1ffff and not 0xXXX10000 - 0xXXX1ffff
>>           which is the address the CPU sees.
>>2) The DMA API assumes the device can access SDRAM
>>        example:
>>           the OHCI controller base is mapped at 0x10000000 on my platform.
>>           this is NOT is SDRAM, its in IO space.
>>    
>>
>
>Can't you just implement an arch-specific allocator for your 32KB
>SRAM, then implement the DMA API streaming and dma_alloc/free APIs
>on top of that?  Since this architecture is obviously not designed
>for performance, it doesn't seem to be a big deal to have the streaming
>APIs copy to/from the kmalloced (or whatever) buffer to/from the SRAM
>allocated memory and then have those APIs return the proper dma_addr_t
>for the embedded OHCI's address space view of the SRAM. Same thing
>goes for implementing dma_alloc/free (used by dma_pool*). I don't
>have the knowledge of USB subsystem buffer usage to know how quickly
>that little 32KB of SRAM is going to run out. But at a DMA API level,
>this seems doable, albeit with the greater possibility of negative
>retvals from these calls.
>
>  
>
Your analysis of what is needed is correct.  However, we would prefer to 
fit this into the DMA API in a generic way, rather than having a 
specialized API that is not acceptable upstream.  I'm more concerned 
with finding the best way to address this problem than with whether this 
is a 2.6 or 2.7 issue.

We do need a memory allocator for the pool of SRAM.  If we're not going 
to have to build customized versions of the OHCI driver, we need that 
pool hooked into the dma_pool and dma_alloc_coherent interfaces.  We 
could do that with a platform specific implementation of 
dma_alloc_coherent, but a pointer to dma_{alloc,free} from struct device 
seems like a cleaner solution.  We also will need bounce buffers, as you 
described, but there is already a good start towards that support in 
2.6.  The other thing that might be needed is passing device to 
page_to_dma so that device specific dma addresses can be constructed.

Deepak Saxena wrote a pretty good summary as part if the discussion 
about this issue on the linux-arm-kernel mailing list:

  
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-June/022796.html

I think I'm looking for something like the PARISC hppa_dma_ops but more 
generic:
  
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-June/022813.html


Jamey Hicks



