Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWADPXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWADPXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 10:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWADPXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 10:23:02 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:64927 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932150AbWADPXA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 10:23:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pJvwuCSs+B0cVqGFeNXxZZ9kbOGALzo38wKlP8HZqq/zwiDLLbsC4vx+N6qiJuyz10QK3Q2lsuhqvp3/C+V0O4YxbeBdlUdPItBSsJOv8HM9CNn2L7ODqpBPcmp1nR22d7iC24d/OnMhb6FWld2A+oGRcQsKMOYdbYO6QmQnnZw=
Message-ID: <661de9470601040722k425cdeb7ic390d2e02d9c10f3@mail.gmail.com>
Date: Wed, 4 Jan 2006 20:52:59 +0530
From: Balbir Singh <bsingharora@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 4/9] slab: cache_estimate cleanup
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, clameter@sgi.com
In-Reply-To: <1136383899.12468.51.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1136319948.8629.19.camel@localhost>
	 <1136336416.12468.11.camel@localhost.localdomain>
	 <1136339242.12468.17.camel@localhost.localdomain>
	 <1136383899.12468.51.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No while is needed!  slab_mgmt_size(nr_objs, align) will end up being:
>
> (sizeof(struct slab)+nr_objs*sizeof(kmem_bufctl_t)+align-1)&~(align-1)
>
> lets say:
>   S = sizeof(struct slab)
>   K = sizeof(kmem_bufctl_t)
>   n = nr_objs
>   z = slab_size
>   o = objsize
>   a = align
>
>         nr_objs = (slab_size - sizeof(struct slab)) /
>                 (size + sizeof(kmem_bufctl_t));
>
> will be  n = (z - S) / (o + K)
>
> looking at the if:
>
>         if (slab_mgmt_size(nr_objs, align) + nr_objs*size
>                > slab_size)
>
> and slab_mgmt_size:
>
>    static size_t slab_mgmt_size(size_t nr_objs, size_t align)
>    {
>         return ALIGN(sizeof(struct slab)+nr_objs*sizeof(kmem_bufctl_t), align);
>    }
>
> and ALIGN:
>
>    #define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
>
> slab_mgmt_size is the same as:
>
>     ALIGN(S + nK, a)
>
> so this will not be greater than:
>
> S + nK + a - 1
>
>
> add this to the if:
>
> if (S + nK + a-1 + no > z)
>
> proof by contradiction: can the left side be greater than z + o?
>
> S + nK + a-1 + no = z+o+1 ?
>
> S + (o+K)n + a-1 = z+o+1
>
> n = (z - S) / (o + K) so:
>
> S + (o+K)(z-S)/(o+K) + a-1 = z+o+1
>
> S + (z-S) + a-1 = z+o+1
>
> removing the z and S
>
> a-1 = o+1
>
> We know that a can be at most o so:
>
> o-1 = o+1
>
> and thus we get:
>
> -1 = 1
>
> So I believe this is the proof by contradiction.  Might want to check
> this, since I just woke up ;)
>
> -- Steve

Your analysis is very interesting and seems correct. My analysis is
similar, but a bit
different

Best case is S+nK is aligned
Worst case is S+nK is off by +1 byte from an alignment boundary

Taking the worst case, we find a-1 bytes of space eaten up by the
alignment operation.
We need to see if the a-1 bytes that we lost, could have accommodated
another object of
size o and a bufctl of size K. If that is true we need to reduce n.

The equation becomes

If o+K < a-1, reduce n

If a is atmost o, then it leads to (from your analysis assumption)

if K < -1 reduce n, K is certainly positive, hence do not reduce n.

Balbir
