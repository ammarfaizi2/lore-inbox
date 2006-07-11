Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWGKJFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWGKJFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWGKJFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:05:23 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:18965 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750801AbWGKJFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:05:22 -0400
Message-ID: <44B369BF.6000104@openvz.org>
Date: Tue, 11 Jul 2006 13:05:03 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, devel@openvz.org, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] fdset's leakage
References: <44B258E3.7070708@openvz.org> <20060711010104.16ed5d4b.akpm@osdl.org>
In-Reply-To: <20060711010104.16ed5d4b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

>>Another patch from Alexey Kuznetsov fixing memory leak in alloc_fdtable().
>>
>>[PATCH] fdset's leakage
>>
>>When found, it is obvious. nfds calculated when allocating fdsets
>>is rewritten by calculation of size of fdtable, and when we are
>>unlucky, we try to free fdsets of wrong size.
>>
>>Found due to OpenVZ resource management (User Beancounters).
>>
>>Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
>>Signed-Off-By: Kirill Korotaev <dev@openvz.org>
>>
>>
>>diff -urp linux-2.6-orig/fs/file.c linux-2.6/fs/file.c
>>--- linux-2.6-orig/fs/file.c	2006-07-10 12:10:51.000000000 +0400
>>+++ linux-2.6/fs/file.c	2006-07-10 14:47:01.000000000 +0400
>>@@ -277,11 +277,13 @@ static struct fdtable *alloc_fdtable(int
>> 	} while (nfds <= nr);
>> 	new_fds = alloc_fd_array(nfds);
>> 	if (!new_fds)
>>-		goto out;
>>+		goto out2;
>> 	fdt->fd = new_fds;
>> 	fdt->max_fds = nfds;
>> 	fdt->free_files = NULL;
>> 	return fdt;
>>+out2:
>>+	nfds = fdt->max_fdset;
>> out:
>>   	if (new_openset)
>>   		free_fdset(new_openset, nfds);
> 
> 
> OK, that was a simple fix.  And if we need this fix backported to 2.6.17.x
> then it'd be best to go with the simple fix.
> 
> And I think we do need to backport this to 2.6.17.x because NR_OPEN can be
> really big, and vmalloc() is not immortal.
> 
> But the code in there is really sick.   In all cases we do:
> 
> 	free_fdset(foo->open_fds, foo->max_fdset);
> 	free_fdset(foo->close_on_exec, foo->max_fdset);
> 
> How much neater and more reliable would it be to do:
> 
> 	free_fdsets(foo);
> 
> ?
agree. should I prepare a patch?

> Also,
> 
> 	nfds = NR_OPEN_DEFAULT;
> 	/*
> 	 * Expand to the max in easy steps, and keep expanding it until
> 	 * we have enough for the requested fd array size.
> 	 */
> 	do {
> #if NR_OPEN_DEFAULT < 256
> 		if (nfds < 256)
> 			nfds = 256;
> 		else
> #endif
> 		if (nfds < (PAGE_SIZE / sizeof(struct file *)))
> 			nfds = PAGE_SIZE / sizeof(struct file *);
> 		else {
> 			nfds = nfds * 2;
> 			if (nfds > NR_OPEN)
> 				nfds = NR_OPEN;
>   		}
> 	} while (nfds <= nr);
> 
> 
> That's going to take a long time to compute if nr > NR_OPEN.  I just fixed
> a similar infinite loop in this function.  Methinks this
> 
> 	nfds = max(NR_OPEN_DEFAULT, 256);
> 	nfds = max(nfds, PAGE_SIZE/sizeof(struct file *));
> 	nfds = max(nfds, round_up_pow_of_two(nr + 1));
> 	nfds = min(nfds, NR_OPEN);
> 
> is clearer and less buggy.  I _think_ it's also equivalent (as long as
> NR_OPEN>256).  But please check my logic.
Yeah, I also noticed these nasty loops but was too lazy to bother :)
Too much crap for my nerves :)

Your logic looks fine for me. Do we have already round_up_pow_of_two() function or
should we create it as something like:
unsinged long round_up_pow_of_two(unsigned long x)
{
  unsigned long res = 1 << BITS_PER_LONG;
  while (res > x)
    res >>= 1;
  }
  return res << 1;
}

or maybe using:
n = find_first_bit(x);
return res = 1 << n;
(though it depends on endianness IMHO)
?

Thanks,
Kirill

