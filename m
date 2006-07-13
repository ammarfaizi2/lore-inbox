Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWGMTiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWGMTiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWGMTiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:38:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57545 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030328AbWGMTiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:38:03 -0400
Date: Thu, 13 Jul 2006 21:32:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       arjan@infradead.org
Subject: Re: [patch] lockdep: annotate mm/slab.c
Message-ID: <20060713193228.GA27360@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu> <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu> <20060713004445.cf7d1d96.akpm@osdl.org> <20060713124603.GB18936@elte.hu> <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.0 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50,ITS_LEGAL autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.3 ITS_LEGAL              BODY: Claims to be Legal
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5006]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> On 7/13/06, Ingo Molnar <mingo@elte.hu> wrote:
> >mm/slab.c uses nested locking when dealing with 'off-slab'
> >caches, in that case it allocates the slab header from the
> >(on-slab) kmalloc caches. Teach the lock validator about
> >this by putting all on-slab caches into a separate class.
> 
> What's "nested lock" btw? If I understood from the other patch, you're 
> talking about ac->lock. Surely you can't take the same lock twice but 
> it's perfectly legal to take lock as long as the ac instance is 
> different...

yeah - there's some ambiguity of the term "nested lock". For the lock 
validator it means "holding two instances of the same lock class". A 
"lock class" is something like inode->i_mutex. (standalone static locks 
like cache_chain_mutex form their own singleton lock class. See 
Documentation/lockdep-design.txt for more details.)

"trying to lock the same lock instance twice" we call "recursive 
locking", and that's a bug for everything except read_lock() on rwlocks. 
There is no "recursive locking" in slab.c, but there is "nested 
locking". For the case of "nested locking" the lock validator needs to 
be taught of the relation between instances. Most of the cases the 
relation is "static" and can thus be assigned build-time via the use of 
separate lock-keys that "split up" a class into subclasses. In rare 
cases the relation is dynamic (for example the VFS has such nesting 
rules).

initially i annotated slab.c via dynamic nesting - but as Arjan has 
correctly observed, most of the nested locking in slab.c is of static 
type: we first take the off-slab lock, then the on-slab lock. [or we 
only take an on-slab lock, if the cache is on-slab]

Note: nested locking annotations arent just done to "shut up" lockdep, 
but rather to enable lockdep from now on to enforce this dependency 
rule: if anywhere we take an off-slab lock after an on-slab lock it will 
print a warning. That's why we go the trouble of identifying all the 
nested locking cases instead of going the easy path of "shutting lockdep 
off" (we could trivially ignore nesting within lockdep.c) - there were a 
couple of locking bugs found already that were related to nested 
locking.

btw., there's still one nested locking construct in slab.c that could 
cause problems:

 Call Trace:
  [<ffffffff8020b0b9>] show_trace+0xaa/0x23d
  [<ffffffff8020b261>] dump_stack+0x15/0x17
  [<ffffffff802456c4>] __lock_acquire+0x127/0x9c4
  [<ffffffff8024648b>] lock_acquire+0x4b/0x6a
  [<ffffffff804aead3>] _spin_lock+0x25/0x31
  [<ffffffff8027301a>] __drain_alien_cache+0x34/0x78
  [<ffffffff80272b1f>] __cache_free+0xe8/0x215
  [<ffffffff80272dc4>] slab_destroy+0x9e/0xc2
  [<ffffffff80272ed3>] free_block+0xeb/0x135
  [<ffffffff80273043>] __drain_alien_cache+0x5d/0x78
  [<ffffffff80272b1f>] __cache_free+0xe8/0x215
  [<ffffffff80273203>] kfree+0x8c/0xb0

what guarantees that while we are 'draining' another node's cache, that 
other node does not drain our cache (and thus we'd deadlock)?

	Ingo
