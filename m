Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVFTPe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVFTPe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVFTPe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:34:27 -0400
Received: from alog0018.analogic.com ([208.224.220.33]:56753 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261349AbVFTPcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:32:16 -0400
Date: Mon, 20 Jun 2005 11:32:07 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Hugh Dickins <hugh@veritas.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12
In-Reply-To: <Pine.LNX.4.61.0506201530450.3324@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0506201114310.5144@chaos.analogic.com>
References: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
 <Pine.LNX.4.61.0506201443400.2903@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0506201018460.5458@chaos.analogic.com>
 <Pine.LNX.4.61.0506201530450.3324@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Hugh Dickins wrote:

> On Mon, 20 Jun 2005, Richard B. Johnson wrote:
>> On Mon, 20 Jun 2005, Hugh Dickins wrote:
>>>
>>> It's the BUG_ON(!pte_none(*pte)) in remap_pte_range.  Maybe your page
>>> table is corrupt, maybe your driver is trying to remap_pfn_range on
>>> top of something already mapped.
>>
>> But of course it is. There is some memory that is mapped into the
>> driver's address space, used for DMA. It was obtained using
>> ioremap_nocache(). This memory is then mapped into user-space
>> when the user executes mmap(). This is how we DMA directly to
>> user-space. Is this no longer allowed?
>
> Of course that is allowed.  But mapping it into userspace on top of
> an existing populated mapping in userspace is not and has never been
> allowed (well, in 2.4.0 it just generated a printk, from 2.4.10
> onwards it's been a BUG).
>
> Hugh
>

Well there is no existing 'populated mapping' whatever that means.
I think the logic in the header is wrong.

The driver gets contiguous DMA RAM by telling the kernel that
there is less memory than there is. The driver finds out how
much RAM the kernel is using by using variable mum_physpages.

There is a long-time kernel bug that writes something beyond the
number of num_physpages, so the memory that the drivers use for
the first offset is (num_physpages * PAGE_SIZE) + PAGE_SIZE.
I therefore waste a page.

This address is the first location that is mapped using ioremap_nocache().
I map all the writable memory after this point up to some constant,
probably 500 megabytes. These pages will be subsequently mapped into
user-space when the user calls mmap().

Previous to 2.6.12, there was no problem memory-mapping and using
this data-area. Now there is some artificial constraint.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
