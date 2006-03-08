Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWCHIW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWCHIW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 03:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWCHIW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 03:22:57 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:34974 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932509AbWCHIW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 03:22:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iVgCBrrkFi6mrhar6PUcAg7h99JoSUxedge3/Sq0iuLGvdIF07f0qMu45Qe2G+hA88EIYNmoMb0J5SCdiWOFow48thIq7BRsO3T/ohG0YjSM8yCs5pfWbF1x+GGiHOVE9X2OYHEhPiEc+/HpYe9ymtOUPiSrbzUp/k42DTLPqWw=  ;
Message-ID: <440E945A.1050404@yahoo.com.au>
Date: Wed, 08 Mar 2006 19:22:50 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Optimise d_find_alias() [try #6]
References: <440D76A4.8050703@yahoo.com.au>  <20060307113352.23330.80913.stgit@warthog.cambridge.redhat.com> <20060307113404.23330.71158.stgit@warthog.cambridge.redhat.com> <25795.1141737864@warthog.cambridge.redhat.com>
In-Reply-To: <25795.1141737864@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Having the smp_rmb() here implies there is some sort of memory barrier
>>based synchronisation protocol at a higher level (than this function),
>>because you don't actually do anything before them smp_rmb() here.
>>
>>So can you comment what that is?
> 
> 
> Hmmm... That probably shouldn't be there. I don't think Andrew Morton and I
> actually came to an agreement as to whether it's necessary. I don't think it
> is, he thought that it was, though he may have changed his mind.
> 

I think this is easy to argue that the optimisation is OK _if_ the condition
being moved outside the locks is atomic.

The reasoning: if there is _no_ higher synchronisation which guarantees the
condition may be flipped one way or the other, then it is equally uncertain
of whether the spinlock will be taken before or after any critical sections
that modify the value. If there _is_ some higher synchronisation, then the
value is going to be correct anyway -- *unless* you are using some consistency
based lockless synchronisation (ie. if this value is 10 then that must be
false), which is what an rmb could be covering.

Now in this case, the condition isn't exactly atomic but I think that's still
OK, because it shouldn't be able to get a false negative or positive during
some transient operation (ie. if the list was _never_ empty within our known
synchronisation, it will return false, if it was _always_ empty, true).

So I guess the only question is whether some code relies on another value to
"know" the result ( if (inode->nr_aliases > 0) {d_find_alias(inode);} ), in
which case I _think_ an rmb there can get you out of trouble. But you'd need
a comment.

Also: I might be talking complete crap here, so anyone feel free to ridicule
me if I'm wrong.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
