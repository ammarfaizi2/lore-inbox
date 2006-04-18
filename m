Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWDRTES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWDRTES (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 15:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWDRTES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 15:04:18 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:40279 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932284AbWDRTER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 15:04:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AmXsgR8Ahd9QM0fPyWFpFclJM8t5XLMKwmsNGmIBo6rKtwBmu+PjIKXqQndq7sBzTcGhx61hYWGuwvISdRcvIyRJ8/EdUOTq4iKmWuuTPPLhZiOJkvjaDgOJuwFqnJcigOfnB4Ch2DnsLSu84tRO2k6vVHXmWGXjkOwl69JdCJU=  ;
Message-ID: <4444D2D1.3010200@yahoo.com.au>
Date: Tue, 18 Apr 2006 21:51:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Brian D. McGrew" <brian@visionpro.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI Device Driver / remap_pfn_range()
References: <14CFC56C96D8554AA0B8969DB825FEA0012B2F38@chicken.machinevisionproducts.com>	 <4443DC09.20606@yahoo.com.au> <1145359275.18736.22.camel@localhost.localdomain>
In-Reply-To: <1145359275.18736.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2006-04-18 at 04:18 +1000, Nick Piggin wrote:
> 
>>I'm pretty sure you can't remap_pfn_range vmalloced memory because
>>it doesn't use contiguous page frames.
> 
> 
> To remap vmalloc memory you need something like this. Note that vmalloc
> memory may not be DMA accessible, vmalloc_32 memory maybe. Alternatively
> you can build your own scatter gather  lists from pages subject to
> hardware limits.
> 
> The following GPL code from various drivers shows how to do vmalloc
> mapping into an application. Having a common helper for this is a
> discussion/todo item when that area of the vm gets future adjustments
> but for now this code should do the trick:

Yep, that would be a good option, thanks Alan.

You can look through the tree at how drivers remap their rvmalloced
memory -- (here's a snippet from drivers/media/video/meye.c):

while (size > 0) {
     page = vmalloc_to_pfn((void *)pos);
     if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
         mutex_unlock(&meye.lock);
         return -EAGAIN;
     }
     start += PAGE_SIZE;
     pos += PAGE_SIZE;
     if (size > PAGE_SIZE)
         size -= PAGE_SIZE;
     else
         size = 0;
}

The trick is to get the underlying pfns and remap one at a time.

You could also tinker with vmalloc_to_page+vm_insert_page, although
that might not yet be the best option for an out of tree driver.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
