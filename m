Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSGHIHm>; Mon, 8 Jul 2002 04:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316825AbSGHIHm>; Mon, 8 Jul 2002 04:07:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:55194 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316824AbSGHIHk>; Mon, 8 Jul 2002 04:07:40 -0400
Date: Mon, 8 Jul 2002 13:40:23 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@zip.com.au,
       davem@redhat.com
Subject: Re: minimal rmap - exit_mmap i_shared_lock/page_table_lock order
Message-ID: <20020708134023.A2232@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sat, 6 Jul 2002, Andrew Morton wrote:
>>
>> That is basically what do_munmap() does.  But I'm quite unfamiliar with
>> the locking in there.
> 
> The only major user of i_shared is really vmtruncate, I think, and it's
> quite ok to unmap the file before removing the mapping from the shared
> list - if vmtruncate finds a unmapped area, it just won't be doing
> anything (zap_page_range, but that won't do anything without any page
> tables).
> 
> Together with the fact that unmap() already does it this way anyway, it
> looks like the obvious fix..

I would tend to agree in principle -- shouldn't be a problem with 
truncate since it can never lead to stale pages anyhow, which 
is why munmap can do it that way without losing correctness today. 

However I recall we had a discussion on this a very long while back
(around end of 2000), when I was trying to solve this i_shared_lock
vs page_table_lock ordering problem by taking a exactly similar 
approach for the case of mmap, mprotect etc as well (taking a cue 
from what munmap did) rather than acquire both locks at the same 
time in those cases. At that time Dave Miller had expressed some
reservations about such assumptions in the view of impact of 
(future) code that might use the shared list differently. He
preferred to solve the problem by always taking the i_shared_lock
before page_table_lock everywhere, and at that was the fix that
got checked in. (Except that this didn't hold for munmap where 
of course this doesn't work, since unmap could cross multiple 
mappings)

Its been a long time since I've looked at that code, and things
have changed quite drastically, so I might be jumping too early,
but if I look at the code now I'm a little confused about whether
the locking order has been audited for other paths either ---  
vma_link seems to acquire page_table_lock before i_shared_lock -- 
the reverse of what vmtruncate does. Are there other things that
save us from races there ?

Regards
Suparna

 
> 
> 		Linus
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in the body
> to majordomo@kvack.org.  For more info on Linux MM, see:
> http://www.linux-mm.org/

