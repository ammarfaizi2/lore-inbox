Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269122AbUHaWvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269122AbUHaWvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268568AbUHaWkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:40:33 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:39130 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268538AbUHaWjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:39:23 -0400
Date: Wed, 01 Sep 2004 07:44:32 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] Re: [RFC] buddy allocator without bitmap(2) [0/3]
In-reply-to: <1093969590.26660.4806.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
Message-id: <4134FF50.8000300@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <41345491.1020209@jp.fujitsu.com>
 <1093969590.26660.4806.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Tue, 2004-08-31 at 03:36, Hiroyuki KAMEZAWA wrote:
> 
>>Disadvantage:
>>  - using one more PG_xxx flag.
>>  - If mem_map is not aligned, reserve one page as a victim for buddy allocater.
>>
>>How about this approach ?
> 
> 
> Granted, we have some free wiggle room in page->flags right now, but
> using another bit effectively shifts the entire benefit of your patch. 
> Instead of getting rid of the buddy bitmaps, you simply consume a
> page->flag instead.  While you don't have to allocate anything (because
> of the page->flags use), the number of bits consumed in the operation is
> still the same as before.  And the patch is getting more complex by the
> minute.

Hmm...I understand what you say. Consuming PG_xxx bit in buddy allocator is harmful
because no PG_xxx bit is used in current kernel's one.

What this patch implements is
"How to record shape of the mem_map needed by buddy allocator without using some
 structure which must be resized at memory resizing."

Because I had to record some information about shape of mem_map, I used PG_xxx bit.
1 bit is maybe minimum consumption.
If consumption of 1 bit in a page structure is too harmful,
I have to record information in some structure which needs to be resized
at memory resizing. When I do so, this patch itself is meaningless, I think.

I'll consider more, but...



> Something ate your patch:
> 
>    * Global page accounting.  One instance per CPU.  Only unsigned longs are
> @@ -290,6 +297,9 @@ extern unsigned long __read_page_state(u
>   #define SetPageCompound(page) set_bit(PG_compound, &(page)->flags)
>   #define ClearPageCompound(page)       clear_bit(PG_compound, &(page)->flags)
> 
> +#define PageBuddyend(page)      test_bit(PG_buddyend, &(page)->flags)
> +#define SetPageBuddyend(page)   set_bit(PG_buddyend, &(page)->flags)
> +
>   #ifdef CONFIG_SWAP
>   #define PageSwapCache(page)   test_bit(PG_swapcache, &(page)->flags)
>   #define SetPageSwapCache(page)        set_bit(PG_swapcache, &(page)->flags)
> 
> 
> -- Dave


-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

