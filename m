Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWCNFQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWCNFQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 00:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWCNFQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 00:16:10 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:64947 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751817AbWCNFQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 00:16:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vueG5U3UrFIoYytu+L372syLsN+c7YJEkhHnAJ0Iukt1dYFnKt5YJ0gjjoDvjIp9h7He0Y58ENEtxYYCtj6Nbx9WIGKje9CIqKTsVPbbEKWiSwhHv24Q6ioopk9r3Hbj197nC3r5CtsB2/tBEJU+NhA5HDE50m/PmWJuZfIurug=  ;
Message-ID: <44165193.2050302@yahoo.com.au>
Date: Tue, 14 Mar 2006 16:16:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>
CC: Nick Piggin <npiggin@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [patch 1/3] radix tree: RCU lockless read-side
References: <20060207021822.10002.30448.sendpatchset@linux.site>	 <20060207021831.10002.84268.sendpatchset@linux.site>	 <661de9470603110022i25baba63w4a79eb543c5db626@mail.gmail.com>	 <44128EDA.6010105@yahoo.com.au>	 <661de9470603121904h7e83579boe3b26013f771c0f2@mail.gmail.com>	 <4414E2CB.7060604@yahoo.com.au>	 <661de9470603130724mc95405dr6ee32d00d800d37@mail.gmail.com>	 <4415F410.90706@yahoo.com.au> <661de9470603131932h7ff99aacgde3911ae82b77dc8@mail.gmail.com>
In-Reply-To: <661de9470603131932h7ff99aacgde3911ae82b77dc8@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
>>The "slots" member is an array, not an RCU assigned pointer. As such, after
>>doing rcu_dereference(slot), you can access slot->slots[i] without further
>>memory barriers I think?
>>
>>But I agree that code now is a bit inconsistent. I've cleaned things up a
>>bit in my tree now... but perhaps it is easier if you send a patch to show
>>what you mean (because sometimes I'm a bit dense, I'm afraid).
>>
> 
> 
> Fro starters, I do not think your dense at all.
> 

I'm glad you think so ;)

> Hmm... slot/slots is quite confusing name. I was referring to slot and
> ended up calling it slots. The point I am contending is that
> rcu_derefence(slot->slots[i]) should happen.
> 
> <snippet>
> +                       __s = rcu_dereference(slot->slots[i]);
> +                       if (__s != NULL)
>                               break;
> </snippet>
> 
> If we break from the loop because __s != NULL. Then in the snippet below
> 

This is a little confusing, because technically I don't think it needs to
rcu_dereference here, either, only when we actually want to dereference
__s and read the data the other end.

rcu_dereference is perhaps an awkward interface for optimising this case.
#define rcu_make_pointer_safe_to_follow(ptr) smp_read_barrier_depends()
or
#define rcu_follow_pointer(ptr) ({ smp_read_barrier_depends(); *ptr; })
might be better

     __s = slot->slots[i];
     if (__s != NULL) {
         rcu_make_pointer_safe_to_follow(__s);
         ...

Would allow the barrier to be skipped if we're not going to follow the
pointer.

> <snippet>
>        /* Bottom level: grab some items */
>       for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
>               index++;
>               if (slot->slots[i]) {
> -                       results[nr_found++] = slot->slots[i];
> +                       results[nr_found++] = &slot->slots[i];
>                       if (nr_found == max_items)
>                               goto out;
>               }
> </snippet>
> 
> We do not use __s above. "slot->slots[i]" is not rcu_derefenced() in
> this case because we broke out of the loop above with __s being not
> NULL. Another issue is - is it good enough to rcu_derefence() slot
> once? Shouldn't all uses of *slot->* be rcu derefenced?
> 

Yes, slot is a local pointer, the address it points to will not change,
so once we have loaded it and issued the read barrier, we can follow it
from then on and reads will not find stale values.

> <suggestion (WARNING: patch has spaces and its not compiled)>
>        /* Bottom level: grab some items */
>       for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
>               index++;
> -              if (slot->slots[i]) {
> -                       results[nr_found++] = slot->slots[i];
> +             __s = rcu_dereference(slot->slots[i]);
> +             if (__s) {
> +                    /* This is tricky, cannot take the address of __s
> or rcu_derefence() */
> +                    results[nr_found++] = &slot->slots[i];
>                       if (nr_found == max_items)
>                               goto out;
>               }
> </suggestion>
> 
> I hope I am making sense.
> 

In this case I think we do not need a barrier because we are only looking
at the pointer (whether it is NULL or not), rather than following it down.
Paul may be able to jump in at this point.

I'll release a new patchset in the next couple of days and try to be more
consisten with the barriers which will hopefully make things less confusing.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
