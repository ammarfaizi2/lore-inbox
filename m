Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbVLFWVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbVLFWVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbVLFWVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:21:09 -0500
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:54862 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030282AbVLFWVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:21:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ld2IDbSzHQPF0QX/TDfLPlAAy8rgB1Szh64Dj3jG2wgTUrn1Z+bydaRh45VvHRwSmy0hruUFszzrTPK5w8jVZc1pdzDjCKUp25mrsgmv/E/4JNkrewLNiz1B6EPYCoVg6POzKElhnDHWC6Q+PgBl+vpq/wx+kdf3nQmV+xrMDNo=  ;
Message-ID: <43960EC7.6030904@yahoo.com.au>
Date: Wed, 07 Dec 2005 09:20:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Holloway <Nick.Holloway@pyrites.org.uk>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc4 1/1] cpia: use vm_insert_page() instead of
 remap_pfn_range()
References: <20051205152758.GA29108@pyrites.org.uk> <20051206191012.GA27116@infradead.org> <20051206210445.GB7591@pyrites.org.uk>
In-Reply-To: <20051206210445.GB7591@pyrites.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Holloway wrote:
> On Tue, Dec 06, 2005 at 07:10:12PM +0000, Christoph Hellwig wrote:
> 
>>>    pos = (unsigned long)(cam->frame_buf);
>>>    while (size > 0) {
>>>-           page = vmalloc_to_pfn((void *)pos);
>>>-           if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
>>>+           page = vmalloc_to_page((void *)pos);
>>>+           if (vm_insert_page(vma, start, page)) {
>>
>>it would be nicer to do the arithmetis on pos as pointers rather than unsigned
>>long.  Also you might want to use alloc_pages + vmap instead of vmalloc so that
>>you already have a page array.  Or we should provide a helper that walks over
>>a vmalloc'ed region and calls vmalloc_to_page + vm_insert_page.  Either way
>>this type of code is duplicated far too much and we'd really need some better
>>interface for it.
> 
> 
> As I said in my previous mail, the patch was just switching to use
> vm_insert_page, and not any other cleanups.
> 
> I agree that a helper is a good idea, as the vmalloc, SetPageReserved,
> remap_pfn_range (was remap_page_range in 2.4) pattern has been copied
> and pasted across many video4linux drivers.
> 
> The cpia driver could do with other cleanups.
> 
>         - It doesn't have a sysfs release callback (so says warning printk).
> 	- The colourspace conversion has been disabled, but should be
> 	  ripped out.
> 	- Needs to support V4L2 API
> 

- remove the last traces of rvmalloc (which is an oft repeated code
   sequence in drivers, means something like vmalloc + SetPageReserved)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
