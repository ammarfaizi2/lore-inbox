Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286363AbRLTTr7>; Thu, 20 Dec 2001 14:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286350AbRLTTrv>; Thu, 20 Dec 2001 14:47:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28683 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286357AbRLTTre>; Thu, 20 Dec 2001 14:47:34 -0500
From: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 20 Dec 2001 11:46:23 -0800
Message-Id: <200112201946.fBKJkNw01262@penguin.transmeta.com>
To: torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 	kern el panic woes
Newsgroups: linux.dev.kernel
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com>
Organization: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com> you write:
>Yes, this does fix the problem.  Thank you very much!
>
>Hopefully something like this will make it into 2.4.18?

This does not seem quite right.

>Tachino Nobuhiro (tachino@open.nm.fujitsu.co.jp) wrote:
>> Hello,
>> 
>> Following patch may fix your problem. 
>> 
>> diff -r -u linux-2.4.17-rc2.org/drivers/block/rd.c 
>> linux-2.4.17-rc2/drivers/block/rd.c
>> --- linux-2.4.17-rc2.org/drivers/block/rd.c	Thu Dec 20 20:30:57 2001
>> +++ linux-2.4.17-rc2/drivers/block/rd.c	Thu Dec 20 20:46:53 2001
>> @@ -194,9 +194,11 @@
>>  static int ramdisk_readpage(struct file *file, struct page * page)
>>  {
>>  	if (!Page_Uptodate(page)) {
>> -		memset(kmap(page), 0, PAGE_CACHE_SIZE);
>> -		kunmap(page);
>> -		flush_dcache_page(page);
>> +		if (!page->buffers) {
>> +			memset(kmap(page), 0, PAGE_CACHE_SIZE);
>> +			kunmap(page);
>> +			flush_dcache_page(page);
>> +		}
>>  		SetPageUptodate(page);
>>  	}
>>  	UnlockPage(page);
>> 
>> 
>>   grow_dev_page() creates not Uptodate page which has valid 
>> buffers, so
>> it is wrong that ramdisk_readpage() clears whole page unconditionally.

The problem is that having buffers doesn't necessarily always mean that
they are valid, nor that _all_ of them are valid.

Also, if the ramdisk "readpage" code is wrong, then so is the
"prepare_write" code.  They share the same logic, which basically says
that "if the page isn't up-to-date, then it is zero".  Which is always
true for normal read/write accesses, but as you found out it's not true
when parts of the page have been accessed by filesystems through the
buffers. 

So the code _should_ use a common helper, something like

	static void ramdisk_updatepage(struct page * page)
	{
		if (!Page_Uptodate(page)) {
			struct buffer_head *bh = page->buffers;
			void * address = page_address(page);
			if (bh) {
				struct buffer_head *tmp = bh;
				do {
					if (!buffer_uptodate(tmp)) {
						memset(address, 0, tmp->b_size);
						 set_buffer_uptodate(tmp);
					}
					address += tmp->b_size;
					tmp = tmp->b_this_page;
				} while (tmp != bh);
			} else
				memset(address, 0, PAGE_SIZE);
			flush_dcache_page(page);
			SetPageUptodate(page);
		}
	}

and then ramdisk_readpage() would just be

	kmap(page);
	ramdisk_updatepage(page);
	UnlockPage(page);
	kunmap(page);
	return 0;

while ramdisk_prepare_write() would be

	ramdisk_updatepage(page);
	SetPageDirty(page);
	return 0;

NOTE NOTE NOTE! This is untested.  Please somebody test it, and in
particular verify that there aren't any stupid highmem bugs, and
resubmit the patch to me and Marcelo, ok?

		Linus
