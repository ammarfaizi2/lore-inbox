Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161278AbWHJOqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161278AbWHJOqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWHJOqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:46:04 -0400
Received: from web25812.mail.ukl.yahoo.com ([217.146.176.245]:52880 "HELO
	web25812.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161278AbWHJOqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:46:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type;
  b=n0xYoNQ0MqwPVWY18bfZpOUmz2Us4DpLU4BNuKf8Udy2D2ryycEbOaZbfa9pS2WWDHwEiAanlIV/8m9SrVWpui63ShG33qck1lS0fUO6s8cO6JcX6yPkuMwmbMtcwK3kaICXby2achnqO33LSj6LK7jaVKbX7bKhDjRetTm+R8Y=  ;
Message-ID: <20060810144601.97257.qmail@web25812.mail.ukl.yahoo.com>
Date: Thu, 10 Aug 2006 14:46:01 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : sparsemem usage
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: apw@shadowen.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> On Thu, 10 Aug 2006 14:40:52 +0200 (CEST)
> moreau francis <francis_moreau2000@yahoo.fr> wrote: 
>>> BTW, ioresouce information (see kernel/resouce.c)
>>>
>>> [kamezawa@aworks Development]$ cat /proc/iomem | grep RAM
>>> 00000000-0009fbff : System RAM
>>> 000a0000-000bffff : Video RAM area
>>> 00100000-2dfeffff : System RAM
>>>
>>> is not enough ?
>>>
>> well actually you show that to get a really simple information, ie does
>> a page exist ?, we need to parse some kernel data structures like 
>> ioresource (which is, IMHO, hackish) or duplicate in each architecture
>> some data to keep track of existing pages.
>>
> 
> becasue memory map from e820(x86) or efi(ia64) are registered to iomem_resource,
> we should avoid duplicates that information. kdump and memory hotplug uses
> this information. (memory hotplug updates this iomem_resource.)
> 
> Implementing "page_is_exist" function based on ioresouce is one of generic
> and rubust way to go, I think.
> (if performance of list walking is problem, enhancing ioresouce code is
>  better.)
>  

Why not implementing page_exist() by simply using mem_map[] ? When
allocating mem_map[], we can just fill it with a special value. And
then when registering memory area, we clear this special value with
the "reserved" value. Hence for flatmem model, we can have:

#define page_exist(pfn)        (mem_map[pfn] != SPECIAL_VALUE)

and it should work for sparsemem too and other models that will use
mem_map[].

Another point, is page_exist() going to replace page_valid() ?
I mean page_exist() is going to be something more accurate than
page_valid(). All tests on page_valid() _only_ will be fine to test
page_exist(). But all tests such:

    if (page_valid(x) && page_is_ram(x))

can be replaced by

    if (page_exist(x))

So, again, why not simply improving page_valid() definition rather
than introduce a new service ?

Francis




