Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTE3SlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 14:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263912AbTE3SlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 14:41:22 -0400
Received: from cs.rice.edu ([128.42.1.30]:16535 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id S263902AbTE3SlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 14:41:21 -0400
To: Timothy Miller <miller@techsource.com>
Cc: Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
References: <Pine.LNX.4.44.0305300627140.4176-100000@localhost.localdomain>
	<3ED79FE9.7090405@techsource.com>
From: Scott A Crosby <scrosby@cs.rice.edu>
Organization: Rice University
Date: 30 May 2003 13:53:47 -0500
In-Reply-To: <3ED79FE9.7090405@techsource.com>
Message-ID: <oyd1xygb70k.fsf@bert.cs.rice.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-DCC--Metrics: cs.rice.edu 1066; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 14:16:09 -0400, Timothy Miller <miller@techsource.com> writes:

> Ingo Molnar wrote:
> 
> > i'd suggest to use the jhash for the following additional kernel
> > entities:  pagecache hash, inode hash, vcache hash.
> 
> > the buffer-cache hash and the pidhash should be hard (impossible?) to
> 
> > attack locally.
> >
> 
> 
> 
> Maybe this is what someone is saying, and I just missed it, but...
> 
> Coming late into this discussion (once again), I am making some
> assumptions here.  A while back, someone came up with a method for
> breaking encryption (narrowing the brute force computations) by
> determining how long it took a given host to compute encryption keys
> or hashes or something.

Yes. Thats also being presented at Usenix Security 2003:

     Remote Timing Attacks Are Practical
     David Brumley and Dan Boneh, Stanford University 

Available at:
     http://crypto.stanford.edu/~dabo/papers/ssl-timing.pdf

However, that paper was dealing with public key operations, not
hash-collisions. Thus, the temporal dependence on the key, the 'hidden
channel' will probably be orders of magnitude smaller. At that, the
paper only works well on a local network, and the result of the attack
is far more interesting, the server's private key.


In *theory* such an attack is possible and could be used to determine
the secret key used in the Jenkin's hash in the networking stack,
dcache, or other places in the kernel. Assuming that collision versus
non-collision could be uniquely distinguished with $k$ trials, and the
hash table has $n$ buckets, the attack would require about 5*k*n or so
queries. The idea is to determine if inputs $i$ and $j$ collide. This
has a chance of $1/n$ of occuring. If I can uniquely distinguish this,
which requires $k$ trials. then on average after $k*n$ trials I'll
have one collision. I repeat this $32/log_2 (n)$, say, 5 times, and I
have 5 such pairs of known collisions $i,j$. I then enumerate all 2^32
keys, and see which one of them is consistent with the collision
evidence observed. This will usually result in only a few possible
keys.

All of this is in theory of course.  In practice, for the bits of the
kernel we're discussing, this sort of attack is completely irrelevant.
I also note that universal hashing is also not immune to these
attacks.  To defend, we'd have to go to cryptographic techniques.

Scott
