Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268998AbUICEEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268998AbUICEEz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 00:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268924AbUICEEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 00:04:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47012 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268998AbUICEEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 00:04:51 -0400
Date: Thu, 2 Sep 2004 19:34:44 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [RFC] Use RCU for tcp_ehash lookup
Message-ID: <20040902140444.GA4808@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040831125941.GA5534@in.ibm.com> <20040901224108.3b2d692d.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901224108.3b2d692d.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:41:08PM -0700, David S. Miller wrote:
> The reason you don't see any improvement is that the ehash table is
> pretty write heavy.

In my simple one-file-transfer-test-at-a-time, it should have been read-mostly.
Probably the fact lookups are not serialized wrt input pakcet processing
may have shadowed the benefits of lock-free lookup. However perhaps
if I have multiple file transfer sessions in progress (one per cpu maybe),
then the benefit of reduced time spent in looking up a socket, could be passed 
on to threads doing network input.

> I'm not totally against your patch, I just don't think that the TCP established
> hash table qualifies as "read heavy" as per what RCU is truly effective for.

IMHO the benefits of lock-free will be seen only in such scenarios, i.e where
read_lock ended up having to spin-wait on a update to finish. In the lock-free 
case, there is no such wait.
 
> That's exactly what I was concerned about when I saw that you had attempted
> this change.  It is incredibly important for state changes and updates to
> be seen as atomic by the packet input processing engine.  It would be illegal
> for a cpu running TCP input to see a socket in two tables at the same time
> (for example, in the main established area and in the second half for TIME_WAIT
> buckets).
> 
> If the visibility of the socket is wrong, sockets could be erroneously
> be reset during the transition from established to TIME_WAIT state.
> Beware!

This is precisely the reason why I changed the order of movement in
__tcp_tw_hashdance. Earlier, it was removing the socket from the
established half and _then_ adding it to time-wait half. This would
have lead to a window where the socket is neither in established-half
not in the time-wait half. A packet arriving in this window (& doing
lock-free lookup) would have been dropped.

Hence I reversed the order of movement to add in time-wait first
before removing from established half.




> >   Note that __tcp_v4_lookup_established should not be affected by the above
> >   movement because I found it scans the established half first and _then_ the
> >   time wait half. So even if the same socket is present in both established half
> >   and time wait half, __tcp_v4_lookup_established will lookup only one of them
> >   (& not both).
> 
> I hope this is true.

AFAICS it is true! If __tcp_v4_lookup_established finds it in the established
half, it does no further lookup in the time-wait half.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
