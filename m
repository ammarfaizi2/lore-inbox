Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293190AbSB1Fzp>; Thu, 28 Feb 2002 00:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293187AbSB1Fxv>; Thu, 28 Feb 2002 00:53:51 -0500
Received: from web12304.mail.yahoo.com ([216.136.173.102]:15113 "HELO
	web12304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293184AbSB1Fxl>; Thu, 28 Feb 2002 00:53:41 -0500
Message-ID: <20020228055340.58269.qmail@web12304.mail.yahoo.com>
Date: Wed, 27 Feb 2002 21:53:40 -0800 (PST)
From: Raghu Angadi <raghuangadi@yahoo.com>
Subject: Re: Fw: memory corruption in tcp bind hash buckets on SMP?
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, raghuangadi@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <200202272008.XAA10326@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to bring your attention to 2nd oops posted in the first mail for
this thread (http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.1/1193.html).
Initially I thought both might be same because they were both releated bind
hash lists. But I have to began suspect it. The first oops is because of race
caused by tw structures left out in the list.. for which a patch is being
discussed here. 

The second one seems to be purely because of a corrupted tb
(tcp_bind_hashbucket).. there is no race there.. tb just got pointers into
arbitary place. Also we saw second oops sometimes with relatively less load.
These are two locations it we have seen (with different bad values for
affending pointers each time it occured):

net/ipv4/tcp_ipv4.c:tcp_v4_get_port(): 

                        spin_lock(&head->lock);
                        for (tb = head->chain; tb; tb = tb->next)
1======>                         if (tb->port == rover)
/*tb is a bad pointer, not NULL */        goto next;
                        break;
                next:
                        spin_unlock(&head->lock);
	            /*
			 more stuff removed
                    */
                         struct sock *sk2 = tb->owners; 
                         int sk_reuse = sk->reuse; 
                         for( ; sk2 != NULL; sk2 = sk2->bind_next) { 
                              if (sk != sk2 && 
2======>                           sk->bound_dev_if == sk2->bound_dev_if) { 
/* sk2 (tb->owners) is a bad pointer */

I will think more about if the problem that causes 1st oops can cause this as
well.

Thanks,
Raghu.

--- kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > the deletion from _both_ the lists. 
> 
> No, it is only for insertion to established hash table.
> 
> References from bind hash are not considered as references.
> Look, if socket will sit only in bind table nobody ever will see it.
> Where is the the reference? :-) It just must _not_ stay in bind hash,
> if no other references remained, that's invariant which we should provide
> now. If we will fail, we are in troubles.
> 
> So, its absence in bind hash must be guaranteed to the time of destruction.
> Look at this from another aspect: imagine you increment refcnt when
> adding to binding table. OK. So, what does guarantee that bucket
> will not remain in bind hash forever? And "it will not" is equivalent
> to "refcnt is not useful".
> 
> Anyway, I will think on this at night, I am not ready to tell how to
> do this right.
> 
> 
> > If you want to avoid timewait_kill() getting called twice altogether.
> 
> Sorry, I did not understand what do you mean here. It can be called
> twice or three times or more. This is impossible to avoid without adding
> spinlock to timewait bucket.
> 
> Alexey


__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - Send FREE e-cards for every occasion!
http://greetings.yahoo.com
