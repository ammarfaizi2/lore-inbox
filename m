Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbTDCTav 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261304AbTDCTau 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:30:50 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36269 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263511AbTDCTTS 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 14:19:18 -0500
Date: Thu, 3 Apr 2003 14:30:45 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, riel@redhat.com,
       linux-kernel@vger.kernel.org, linux390@de.ibm.com
Subject: Re: gcc-3.2 breaks rmap on s390x
Message-ID: <20030403143045.A1437@devserv.devel.redhat.com>
References: <20030403131054.B25676@devserv.devel.redhat.com> <Pine.LNX.4.44.0304031954480.2237-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0304031954480.2237-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Apr 03, 2003 at 08:01:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 3 Apr 2003 20:01:10 +0100 (BST)
> From: Hugh Dickins <hugh@veritas.com>

> >  	while (test_and_set_bit(PG_chainlock, &page->flags)) {
> > -		while (test_bit(PG_chainlock, &page->flags))
> > +		while (test_bit(PG_chainlock, &page->flags)) {
> >  			cpu_relax();
> > +			barrier();
> > +		}
> >  	}

> Isn't it rather odd that it should fix the problem you describe?
> because the barrier you're adding comes only in the exceptional path,
> when the lock was found already held.

The actual code is not drastically rearranged and fragments
are not replicated. Thus, the code below the while() loop
cannot possibly know if the lock was contested or not
(if the loop was executed at least once or not),
and it has to load the value from memory.

But suppose your worst fears came true and complier decided
to push the beyond the limits of reasonable into the shady
realm of legal. The worst the compiler can do is:

   register word r10;
   r10 = page->pte.direct;
   if (r10!=0) something();
   if (test_and_set_bit(PG_chainlock, &page->flags) == 0) {
      /* No barrier here, mwuahahaha!!! */
   } else {
      do {
        while (test_bit(PG_chainlock, &page->flags)) {
          // This loop can be inverted too. No change to the reasoning.
          cpu_relax();
          barrier();
        }
      } while (test_and_set_bit(PG_chainlock, &page->flags));
      r10 = page->pte.direct;
   }
   foo_using(r10);

Which continues to work, because the value loaded before uncontested
was taken is still valid later. The problem only happens if the
lock was contested.

BTW, Bill Irwin noted that, strictly speaking, the first if statement
with page_mapped should be done under the lock for safety. I think
he got a point. A 2.5 preempt in the wrong moment (between the
first load and test_and_set_bit in the above example) makes
the code invalid after all. Not that it mattered as long as
compiler does not do such exercises as I outlined above.

-- Pete
