Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161348AbWHJPhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161348AbWHJPhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161352AbWHJPhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:37:33 -0400
Received: from web25808.mail.ukl.yahoo.com ([217.12.10.193]:38323 "HELO
	web25808.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161348AbWHJPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:37:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=OSVxs9KgxRbQBMBRB1lOJHzrW6nZZqP20yw5Sl7WkWbYbTbl9nQdNQFug1ixKxZu8JWcnhuaRfTEBhwO8wD0Js032QQwioqFrmKmqTu34iWzQNlBParXsp7WztgOuBvbA95Rm5V0CuDa/+6e3RShYhKpPZAQsDKGDHkYvzkc2E8=  ;
Message-ID: <20060810153731.22728.qmail@web25808.mail.ukl.yahoo.com>
Date: Thu, 10 Aug 2006 15:37:31 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : sparsemem usage
To: Andy Whitcroft <apw@shadowen.org>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <44DB4F04.7060503@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> moreau francis wrote:
>> KAMEZAWA Hiroyuki wrote:
>>> On Thu, 10 Aug 2006 14:40:52 +0200 (CEST)
>>> moreau francis <francis_moreau2000@yahoo.fr> wrote:
>>>>> BTW, ioresouce information (see kernel/resouce.c)
>>>>>
>>>>> [kamezawa@aworks Development]$ cat /proc/iomem | grep RAM
>>>>> 00000000-0009fbff : System RAM
>>>>> 000a0000-000bffff : Video RAM area
>>>>> 00100000-2dfeffff : System RAM
>>>>>
>>>>> is not enough ?
>>>>>
>>>> well actually you show that to get a really simple information, ie does
>>>> a page exist ?, we need to parse some kernel data structures like
>>>> ioresource (which is, IMHO, hackish) or duplicate in each architecture
>>>> some data to keep track of existing pages.
>>>>
>>> becasue memory map from e820(x86) or efi(ia64) are registered to
>>> iomem_resource,
>>> we should avoid duplicates that information. kdump and memory hotplug
>>> uses
>>> this information. (memory hotplug updates this iomem_resource.)
>>>
>>> Implementing "page_is_exist" function based on ioresouce is one of
>>> generic
>>> and rubust way to go, I think.
>>> (if performance of list walking is problem, enhancing ioresouce code is
>>>  better.)
>>>  
>>
>> Why not implementing page_exist() by simply using mem_map[] ? When
>> allocating mem_map[], we can just fill it with a special value. And
>> then when registering memory area, we clear this special value with
>> the "reserved" value. Hence for flatmem model, we can have:
>>
>> #define page_exist(pfn)        (mem_map[pfn] != SPECIAL_VALUE)
>>
>> and it should work for sparsemem too and other models that will use
>> mem_map[].
> 
> The mem_map isn't a pointer, its a physical structure.  We have a

ok

> special value to tell you if the page is usable within that, thats
> called PG_reserved.  If this page is reserved the kernel can't touch it,
> can't look at it.

can't we introduce a new special value, such as "PG_real" ?

> 
>> Another point, is page_exist() going to replace page_valid() ?
>> I mean page_exist() is going to be something more accurate than
>> page_valid(). All tests on page_valid() _only_ will be fine to test
>> page_exist(). But all tests such:
>>
>>     if (page_valid(x) && page_is_ram(x))
>>
>> can be replaced by
>>
>>     if (page_exist(x))
>>
>> So, again, why not simply improving page_valid() definition rather
>> than introduce a new service ?
> 
> Whilst I can understand that not knowing if a page is real or not is
> perhaps unappealing, I've yet to see any case where we need or care.
> Changing things to make things 'nicer' interlectually is sometimes
> worthwhile.  But what is the user here.
> 
> The only consumer you have shown is show_mem() which is a debug
> function, and that only dumps out the current memory counts.  Its not
> clear it cares to really know if a page is real or not.
> 

I understand your point of view, but even if it's a debug function,
it must exist and report correct information. And my point is that
I think it should be really easy to implement :) that by using
a new "special value". Can you confirm that it's really easy to
implement that ?

thanks

Francis


