Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293108AbSBWHZM>; Sat, 23 Feb 2002 02:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293109AbSBWHZD>; Sat, 23 Feb 2002 02:25:03 -0500
Received: from web12308.mail.yahoo.com ([216.136.173.106]:19205 "HELO
	web12308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293108AbSBWHYs>; Sat, 23 Feb 2002 02:24:48 -0500
Message-ID: <20020223072447.48778.qmail@web12308.mail.yahoo.com>
Date: Fri, 22 Feb 2002 23:24:47 -0800 (PST)
From: Raghu Angadi <raghuangadi@yahoo.com>
Subject: Re: memory corruption in tcp bind hash buckets on SMP? 
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020213.190743.66058963.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a scenario that leaves a tw in bind hash list even after it gets
deallocated: (seems like easy to fix):

There is a fix that went into between 2.4.16 & 17 (this fix made into into
both RH 2.4.9-etc.. _and_ 2.4.7-10). Fix is to do atomic_set(tw->refcnt, 1)
 instead of 0 and do tcp_tw_put(tw) after tcp_tw_schedule() in
tcp_time_wait(). It looks like this may not be complete fix for tw's 
refcnting issues.

Here is how it happens: reference code 2.4.9-21 (applies to 2.4.17 as well):

    Proc 0                                  Proc 1
--------------------------      |  ------------------------

gets ACK for an sk and sk       |  The remote side sent RST immediately
goes into FIN_WAIT2 state.      |  after ACK for our FIN (abortive
So we are in __tcp_hashdance(). |  close). RST was processed on proc 1.
We just did                     |  since this is an RST, we go to
write_unlock(ehead->lock);      |  tcp_timewait_state_process()
                                |  and kill: label in there 
                                | 
                                |  which
                                |  calls tcp_timewait_kill().
                                |  Here, we delete tw from ehash list.
                                |  but "if ((tb = tw->tb) != NULL)" fails
                                |  'cause this has not been inserted 
                                |   on proc 0 yet.
                                |  Now we go ahead and do tcp_tw_put().
                                
So now we schedule_tw() on proc 0 and when the timeout fires, we call
tcp_timewait_kill() again. But now tw->pprev is NULL (because it was deleted
from established hash above by proc 1). So we just return with out deleting
it from the bind hash list!!. A simple fix is to increment refcnt once for
each list addition and decrement it once for each list deletion or decremnt
only only when it is delete from bind hash. of course 'return if tw->pprev ==
NULL' should also be removed. 

we have seen this happening (eg, tw->tb is non null just before kfree(tw)).

Raghu.

--- "David S. Miller" <davem@redhat.com> wrote:
>    From: Raghu Angadi <raghuangadi@yahoo.com>
>    Date: Wed, 13 Feb 2002 16:51:52 -0800 (PST)
>    
>    --- "David S. Miller" <davem@redhat.com> wrote:
>    > 
>    > This bug is fixed in the 2.4.9 Red Hat 7.2 errata kernels.
>    
>    Thanks, Is the following diff the only culprit/fix?
>    
> There are others, seatch for more instances of tcp_tw_get()
> and tcp_tw_put() and things like atomic_set(tw->count, 1);


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
