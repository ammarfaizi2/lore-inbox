Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292581AbSB0Trw>; Wed, 27 Feb 2002 14:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292918AbSB0TrR>; Wed, 27 Feb 2002 14:47:17 -0500
Received: from web12308.mail.yahoo.com ([216.136.173.106]:12 "HELO
	web12308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292579AbSB0Tq0>; Wed, 27 Feb 2002 14:46:26 -0500
Message-ID: <20020227194620.69620.qmail@web12308.mail.yahoo.com>
Date: Wed, 27 Feb 2002 11:46:20 -0800 (PST)
From: Raghu Angadi <raghuangadi@yahoo.com>
Subject: Re: Fw: memory corruption in tcp bind hash buckets on SMP?
To: kuznet@ms2.inr.ac.ru, "David S. Miller" <davem@redhat.com>
Cc: raghuangadi@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <200202271904.WAA09439@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > I think his analysis is alright but he patch is questionable.
> 
> Yes. "if (tb) tcp_tw_put(tw)" cannot be right, no doubts.

In timewait_kill(), tb is set only _after_ it has been removed from the
established (if it exist there). In _hashdance() tw is inserted into
established _before_ it is inserted into bindhash. So the above is one way of
saying do tw_put() when it has been deleted from _both_ the lists.
Also note that patch removes "if (!tw->pprev) return;" thingy. Infact this
return sort of implied you never thought tw could be deleted from ehash and
not from bind hash.

> Seems, it is enough to remove from bind hash _before_ established.
> 
> The idea was that bind hash is pure slave of another state, so that
> it need not refcounting at all. Note that adding the second increment
> does not help: when we verify that leakage (the situation, when
> bucket is in bind hash, but has no timer running) is impossible
> we immediately arrive to elimination of the refcount.
> 
> Raghu, could you check the variant with inverted order of removal?
> Do you see holes? From my side... I need to think more. :-)

Just the inteverted order of removal will fix _this_ perticular case.
But we still end up doing tw_put() in timewait_kill() even though tw is still
in the bind list (just got inserted on the other processor). This seems
conceptually incorrect or confusing. The refcnt increment in tw_hashdance()
is for these two lists and tw_put() in timewait_kill() should correspond to
the deletion from _both_ the lists. 
 
If you want to avoid timewait_kill() getting called twice altogether.. then
its a different issue.

Raghu.

> Alexey


__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - Send FREE e-cards for every occasion!
http://greetings.yahoo.com
