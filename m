Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292658AbSCDUUn>; Mon, 4 Mar 2002 15:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSCDUUe>; Mon, 4 Mar 2002 15:20:34 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:44852 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S292837AbSCDUUV>; Mon, 4 Mar 2002 15:20:21 -0500
Subject: Re: [PATCH] breaking up the pagemap_lru_lock in rmap
From: peter <peter.zijlstra@chello.nl>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
In-Reply-To: <194860000.1015265091@flay>
In-Reply-To: <194860000.1015265091@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 21:17:54 +0100
Message-Id: <1015273075.21556.95.camel@twins.localnet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 19:04, Martin J. Bligh wrote:
> High contention on the pagemap_lru lock seems to be a major
> scalability problem for rmap at the moment. Based on wli's and
> Rik's suggestions, I've made a first cut at a patch to split up the
> lock into a per-page lock for each pte_chain.
> 
> This isn't ready to go yet - I'm not going to pretend it works. I'm
> looking for feedback on the approach, and any obvious blunders
> I've made in coding. I plan to move the lock in the pages_struct
> into the flags field to save space once it's working reliably.
> 
> If I may steal akpm's favourite disclaimer - "I know diddly squat
> about ......" ;-) Flame away .....
> 
> Thanks,
> 
> Martin.
> 

Hi, knowing less that diddly squat about the code being discussed.
I would like to mention that I usually use some little macro's
to get rid of code like:

  lock( my_lock);
  if ( exp) {
    unlock( my_lock);
    /* do fancy stuph */
  } else
    unlock( my_lock);

and make it look like this:

#define LOCK_EXP_F( exp, lock, f_lock, f_unlock)   \
  ({ typeof( exp) e;                               \
     f_lock( lock);                                \
     e = (exp);                                    \
     f_unlock( lock);                              \
     e; })

#define PAGELOCK_EXP( exp, page)                   \
  LOCK_EXP_F( exp, page, pte_chain_lock, pte_chain_unlock)


  if ( PAGELOCK_EXP( !page->pte_chain && 
                     (!page->buffers || do_flushpage( page, 0)), page))
    lru_cache_del( page);


If this is a not accepted coding style, so be it.

Another little thing I've been wondering about is why keep using
LRU style caches. Has anybody ever thought about using LRU-K
caches? I know, they aren't O(1), but O(log(n)) isn't that bad
agains the advantages:
 - easier to make concurrent (no head contention)
 - better caching properties (takes low frequency
   entries and cache sweeps into account)

just my 2ct.

Regards,

  Peter Zijlstra




