Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVJOIBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVJOIBU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 04:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVJOIBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 04:01:20 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:50449 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751131AbVJOIBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 04:01:19 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Subject: Re: Possible memory ordering bug in page reclaim?
Cc: hugh@veritas.com, paulus@samba.org, anton@samba.org,
       nickpiggin@yahoo.com.au, torvalds@osdl.org, akpm@osdl.org,
       andrea@suse.de, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <1129362196.7620.8.camel@gaston>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EQgxs-00061G-00@gondolin.me.apana.org.au>
Date: Sat, 15 Oct 2005 18:00:24 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> > 1                                2
>> > find_get_page();
>> > write to page                    write_lock(tree_lock);
>> > SetPageDirty();                  if (page_count != 2
>> > put_page();                          || PageDirty())
>> > 
>> > Now I'm worried that 2 might see PageDirty *before* SetPageDirty in
>>                                   page->flags
>> > 1, and page_count *after* put_page in 1.
> 
> yup, now the question is wether PG_Dirty will be visible to CPU 2 before
> the page count is decremented right ? That depends on put_page, I
> suppose. If it's doing a simple atomic, there is an issue. But atomics
> with return has been so often abused as locks that they may have been
> implemented with a barrier... (On ppc64, it will do an eieio, thus I
> think it should be ok).

Yes atomic_add_negative should always be a barrier.

> There is also a problem the other way around. Write to page, then set
> page dirty... those writes may be visible to CPU 2 (that is the page
> content be dirty) before find_get_page even increased the page count,
> unless there is a barrier in there too.

find_get_page does a read_unlock_irq after the increment which also
serves as a barrier.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
