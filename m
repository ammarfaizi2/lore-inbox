Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSGOHkz>; Mon, 15 Jul 2002 03:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317367AbSGOHky>; Mon, 15 Jul 2002 03:40:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55227 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317366AbSGOHkx>;
	Mon, 15 Jul 2002 03:40:53 -0400
Date: Mon, 15 Jul 2002 13:19:33 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [RFC] dcache scalability patch (2.4.17)
Message-ID: <20020715131933.C13618@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20020712193935.B13618@in.ibm.com> <Pine.GSO.4.21.0207121021430.11261-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0207121021430.11261-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Jul 12, 2002 at 10:29:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 10:29:53AM -0400, Alexander Viro wrote:
> 
> 
> On Fri, 12 Jul 2002, Maneesh Soni wrote:
> 
> > Here is the dcache scalability patch (cleaned up) as disscussed in 
> > the previous post to lkml by Dipankar. The patch uses RCU for doing fast
> > dcache lookup. It also does lazy updates to lru list of dentries to
> > avoid doing write operations while doing lookup.
> 
> Where is
> 	* version for 2.5.<current>
> 	* analysis of benefits in real-world situations for 2.5 version?
> 
> Patch adds complexity and unless you can show that it gives significant
> benefits outside of pathological situations, it's not going in.
> 
> Note: measurements on 2.4 do not make sense; reduction of cacheline
> bouncing between 2.4 and 2.5 will change the results anyway and
> if any of these patches are going to be applied to 2.4, reduction of
> cacheline bouncing on ->d_count is going to go in before that one.

Hi Viro,

The 2.4 tests we did, also has fastwalk patch ported from 2.5. Though
fastwalk has performed better (throughput improved by 1%) than base 2.4 
but I think because of increased hold and wait times on dcache_lock, results
are not as good as using only dcache_rcu.
	http://marc.theaimsgroup.com/?l=linux-kernel&m=102645767914212&w=2

For 2.5 I tried to merge fastwalk and dcache_rcu but both doesnot seem
to compliment each other. fastwalk takes dcache_lock much earlier than
d_lookup. 

On 2.5 we get better results from dcache_rcu when we reomve
fastwalk and put the dcache code back to 2.5.10ish level of code. Probably
this is not the correct way as it involves lots of code changes and we need
to workout some other way. 

There are some numbers from 2.5.20-base vs dcache_rcu(no fastwalk) done by 
Anton Blanchard with dbench.
	http://samba.org/~anton/linux/2.5.20/

Regards,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html
