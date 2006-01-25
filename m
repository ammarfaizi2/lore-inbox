Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWAYLKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWAYLKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWAYLKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:10:50 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:60842 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751117AbWAYLKu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:10:50 -0500
Message-ID: <43D75CB8.9090101@cosmosbay.com>
Date: Wed, 25 Jan 2006 12:10:48 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [RFC] non-refcounted pages, application to slab?
References: <20060125093909.GE32653@wotan.suse.de> <43D75239.90907@cosmosbay.com> <20060125105737.GB30421@wotan.suse.de>
In-Reply-To: <20060125105737.GB30421@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 25 Jan 2006 12:10:47 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin a écrit :
> On Wed, Jan 25, 2006 at 11:26:01AM +0100, Eric Dumazet wrote:
>> Nick Piggin a écrit :
>>> If an allocator knows exactly the lifetime of its page, then there is no
>>> need to do refcounting or the final put_page_zestzero (atomic op + mem
>>> barriers).
>>>
>>> This is probably not worthwhile for most cases, but slab did strike me
>>> as a potential candidate (however the complication here is that some
>>> code I think uses the refcount of underlying pages of slab allocations
>>> eg nommu code). So it is not a complete patch, but I wonder if anyone
>>> thinks the savings might be worth the complexity?
>>>
>>> Is there any particular code that is really heavy on slab allocations?
>>> That isn't mostly handled by the slab's internal freelists?
>> Hi Nick
>>
>> After reading your patch, I have some crazy idea.
>>
>> The atomic op + mem barrier you want to avoid could be avoided more 
>> generally just by changing atomic_dec_and_test(atomic_t *v).
>>
>> If the current thread is the last referer (refcnt = 1), then it can safely 
>> set the value to 0 because no other CPU can be touching the value (or else 
>> there must be a bug somewhere, as the 'other cpu' could touch the value 
>> just after us and we could free an object still in use by 'other cpu'
>>
> 
> I think that would work for this case, but you change the semantics
> of the function for all users which is bad.

Yes :) I did a test with a patched kernel and I got :

BUG: atomic counter underflow at:
  <c0103a3a> show_trace+0x20/0x22   <c0103b5b> dump_stack+0x1e/0x20
  <c01d6934> _atomic_dec_and_lock+0x78/0x88   <c0177599> dput+0xbf/0x187
  <c016dc96> path_release+0x14/0x30   <c016e540> __link_path_walk+0x36d/0xd5f
  <c016ef84> link_path_walk+0x52/0xd6   <c016f2ec> do_path_lookup+0xfc/0x220
  <c016f467> __path_lookup_intent_open+0x3e/0x73   <c016f4d1> 
path_lookup_open+0x35/0x37
  <c016fc79> open_namei+0x83/0x631   <c015f811> do_filp_open+0x38/0x56
  <c015fb83> do_sys_open+0x5c/0x99   <c015fbe7> sys_open+0x27/0x29
  <c0102bb3> sysenter_past_esp+0x54/0x75


So we cannot change atomic_dec_and_test(atomic_t *v) but introduce a new 
function like :

int atomic_dec_refcount(atomic_t *v)
{
#ifdef CONFIG_SMP
        /* avoid an atomic op if we are the last user of this refcount */
        if (atomic_read(v) == 1) {
                atomic_set(v, 0); /* not a real atomic op on most machines */
                return 1;
        }
#endif
	return atomic_dec_and_test(v);
}

The cost of the extra conditional branch is worth, if it can avoid an atomic op.


> 
> Such a test could be open coded in __free_page, although that does
> add a branch + some icache, but that might also be an option. (and
> my patch does also add to total icache footprint and is much uglier ;))
> 
> Thanks,
> Nick
> 
> 

