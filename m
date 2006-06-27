Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWF0Gic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWF0Gic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWF0Gic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:38:32 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:61141 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932249AbWF0Gib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:38:31 -0400
Date: Tue, 27 Jun 2006 08:33:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627063339.GA27938@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626200300.GA15424@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5273]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Christoph Hellwig <hch@infradead.org> wrote:
> 
> > The code uses GFP_NOFAIL for slab allocator calls.  It's been 
> > pointed out here numerous times that this can't work.  Andrew, what 
> > about adding a check to slab.c to bail out if someone passes it?
> 
> reiserfs, jbd and NTFS are all using GFP_NOFAIL ...
> 
> i dont think this is a huge issue that should block merging.

oh, and XFS has this little gem in its journalling code:

 fs/xfs/xfs_log.c:

 STATIC void
 xlog_state_ticket_alloc(xlog_t *log)
 {
 [...]
         /*
          * The kmem_zalloc may sleep, so we shouldn't be holding the
          * global lock.  XXXmiken: may want to use zone allocator.
          */
         buf = (xfs_caddr_t) kmem_zalloc(NBPP, KM_SLEEP);

         s = LOG_LOCK(log);

         /* Attach 1st ticket to Q, so we can keep track of allocated memory */
         t_list = (xlog_ticket_t *)buf;
         t_list->t_next = log->l_unmount_free;
 [...]

where kmem_zalloc() may fail!!!

So XFS is apprarently hiding the "journalling allocations must not fail" 
problem by ... crashing? Wow! Most of the other journalling filesystems 
loop on the allocator: the honest ones do it via GFP_NOFAIL, others via 
open-coded infinite retry loops.

Just in case anyone says 'preallocate': that's _hard_ to do in a 
sophisticated filesystem, which has many dynamic (and delayed) decisions 
that make the prediction of resource overhead difficult. That's the 
fundamental reason why basically all journalling filesystems either loop 
(or the really enterprise quality ones: crash ;) on allocation failure.

Btw., i have just taken a 5 minute tour into XFS, and i found at least 5 
other problems with the XFS code that are similar in nature to the ones 
you pointed out. (mostly useless wrappers around Linux functionality) 
Isnt this whole episode highly hypocritic to begin with?

	Ingo
