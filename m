Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318079AbSGWOx1>; Tue, 23 Jul 2002 10:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSGWOx1>; Tue, 23 Jul 2002 10:53:27 -0400
Received: from pat.uio.no ([129.240.130.16]:1164 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318079AbSGWOx0>;
	Tue, 23 Jul 2002 10:53:26 -0400
To: Olaf Kirch <okir@suse.de>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Locking patches (generic & nfs)
References: <20020719101950.A15819@suse.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 Jul 2002 16:56:32 +0200
In-Reply-To: <20020719101950.A15819@suse.de>
Message-ID: <shsy9c27asf.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Olaf,

>>>>> " " == Olaf Kirch <okir@suse.de> writes:


     > --- linux/fs/lockd/svclock.c.locks Mon Jun 17 13:32:21 2002
     > +++ linux/fs/lockd/svclock.c Mon Jun 17 13:37:36 2002
     > @@ -62,8 +62,8 @@
     >  		nlmsvc_remove_block(block);
     >  	bp = &nlm_blocked; if (when != NLM_NEVER) {
     > - if ((when += jiffies) == NLM_NEVER)
     > - when ++;
     > + if ((when += jiffies) > NLM_NEVER)
     > + when = NLM_NEVER;
     >  		while ((b = *bp) &&
     >  		time_before_eq(b->b_when,when))
     >  			bp = &b->b_next;
     >  	} else

I disagree. As it stands, NLM_NEVER == (~(unsigned long)0), and "when"
is unsigned long, so the only thing we need to protect against is if
we hit the 'magic value' NLM_NEVER. Note that the time_before_eq()
comparison ensures that we cope well with jiffy wraparound etc, so the
entry should *not* in fact get put at the end of the list as you
claimed.

With the above change (plus your change to set NLM_NEVER=0x7fffffff),
we end up never retrying locks that just happen to have been put on
the list at a time when the value of 'jiffies' happens to be > 0x7fffffff.


-

The other fix for fs/locks.c looks reasonable AFAICS (but perhaps
Matthew wants to take a look?)

-

Concerning the fix implementing GRANTED_RES: I fully agree we need
it. I've just never had the time, and it's the sort of thing that
the Connectathon tests don't keep nagging at you with ;-)...

Patrice Dumas recently did some work on implementing this both for
NLMv1,2,3 and NLM4, so I was planning on integrating his changes into
2.4.20.

Cheers,
  Trond
