Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUITTzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUITTzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUITTzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:55:38 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:45483 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S267278AbUITTyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:54:18 -0400
Message-ID: <414F2D80.9090909@drdos.com>
Date: Mon, 20 Sep 2004 13:20:32 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: jmerkey@galt.devicelogics.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 bio sickness with large writes
References: <4148D2C7.3050007@drdos.com> <20040916063416.GI2300@suse.de> <4149C176.2020506@drdos.com> <20040917073653.GA2573@suse.de> <20040917201604.GA12974@galt.devicelogics.com> <414F0F87.9040903@drdos.com> <20040920180957.GB7616@suse.de>
In-Reply-To: <20040920180957.GB7616@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>>page and offset sematics in the interface are also somewhat burdensome. 
>>Wouldn't a more reasonable
>>interface for async IO be:
>>
>>address
>>length
>>address
>>length
>>
>>rather than
>>
>>page structure
>>offset in page structure
>>page structure
>>offset in page structure
>>    
>>
>
>No, because { address, length } cannot fully describe all memory in any
>given machine.
>
>  
>
This response I don't understand. How memory is described in a machine 
for DMA addressibility
is pretty standard (with the exception of memory on intel machine in 32 
bit systems above 4GBthat need page tables) --
a physical numerical address. But who is going to DMA into memory not in 
the address space.


>Any chunk of memory has a page associated with it, but it may not have a
>kernel address mapping associated with it. So some identifier was needed
>other than a virtual address, a page is as good as any so making one up
>would be silly.
>
>Once you understand this, it doesn't seem so odd. You need to pass in a
>single page or sg table to map for dma anyways, the sg table holds page
>pointers as well.
>
>  
>
>>I can assume from the interface as designed that if you pass an offset 
>>for a page that is not page aligned,
>>and ask for a 4K write, then you will end up dropping the data on the 
>>floor than spans beyond the end of the page.
>>    
>>
>
>What kind of bogus example is that? Asking for a 4K write from a 4K page
>but asking to start 1K in that page is just stupid and not even remotely
>valid.
>
>  
>
Hardware doesn't care about page boundries. It sees hardware addresses 
and lengths, at
least most SG hardware I've worked with does. For ease of submission, an 
interface that
takes <address,length> would suffice. Why on earth would someone need a 
context
pointer into the kernel's page tables to submit an SG into a device, 
apart from performing
virtual-to-physical translation?

>It's not difficult at all. Apparently you don't understand it so you
>think it's difficult, that's only natural. But you have access to the
>page mapping of any given piece of data always, or if you have the
>virtual address only it's trivial to go to the { page, offset } mapping.
>  
>
No, I do understand, and using page/offset at a low level SG interface 
IS burdensome.
I mean, if this is what I have to support I guess I have to use it, but 
it will be just another
section of code where I have another **FAT** layer to waste more CPU 
cycles calculating
offset/page (oh yeah I have to lookup the struct page * structure also) 
when it would be much
simpler to just submit address/len in i386 systems. With this type of 
interface, If I have for instance
an on-disk structure that starts in the middle of a 4K page due to other 
headers, etc. than spans
a page, I cannot just submit the address and length, I have to break it 
into two bio requests instead
of one with a for () loop from hell and calculate the offsets and rumage 
around in memory looking
up struct page * addresses.

>I can only imagine that you are used to a very different interface on
>some other OS so you think it's difficult to use. Most of your
>complaints seem to be based on false assumptions or because you don't
>understand why certain design decisions were made.
>
>  
>

No. I am used to programming to hardware with SG devices that all OS 
use. Is there somewhere a page based
SG device (other than SCI) for disk drive?. I don't think so, I think 
they operate address/len, address/len, etc.

:-)

Jeff


