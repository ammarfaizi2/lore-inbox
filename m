Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSFJGhr>; Mon, 10 Jun 2002 02:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSFJGhq>; Mon, 10 Jun 2002 02:37:46 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:25077 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316683AbSFJGhp>; Mon, 10 Jun 2002 02:37:45 -0400
Date: Mon, 10 Jun 2002 00:35:10 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 54 missing null pointer checks in 2.4.17
Message-ID: <20020610063510.GG20388@turbolinux.com>
Mail-Followup-To: Dawson Engler <engler@csl.Stanford.EDU>,
	linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <20020610052807.GB20388@turbolinux.com> <200206100607.XAA17282@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2002  23:07 -0700, Dawson Engler wrote:
> > > /u2/engler/mc/oses/linux/2.4.17/fs/jbd/journal.c
> > > 	 * Do we need to do a data copy?
> > > 	 */
> > > 
> > > 	if (need_copy_out && !done_copy_out) {
> > > 		char *tmp;
> > > Start --->
> > > 		tmp = jbd_rep_kmalloc(jh2bh(jh_in)->b_size, GFP_NOFS);
> > > 
> > > 		jh_in->b_frozen_data = tmp;
> > > Error --->
> > > 		memcpy (tmp, mapped_data, jh2bh(jh_in)->b_size);
> > 
> > Note that jbd_rep_kmalloc() is a special case, and will not currently
> > return NULL.  This macro calls  __jbd_rep_kmalloc(..., retry=1) which
> > means "repeat the allocation until it succeeds" so the code path
> > "if (!retry) return NULL" can never actually happen from this caller.
> > The logic is somewhat convoluted, so it is not surprising that the
> > checker didn't distinguish this case (it would have to have done the
> > "constant" evaluation to drop the NULL return path from the code).
> 
> Interesting.  The checker infers which functions can plausibly return
> null by counting, for each function f:
> 	1.  how many callsites check f's return value against null
>  versus 
> 	2.how many do not.  
> In this case the reason we were checking jbd_rep_kmalloc (actually
> __jbd_kmalloc) was because five other callers in jbd checked it:
> 
> linux/2.4.17/fs/jbd/journal.c:695:journal_init_common: NOTE:NULL:692:695:[EXAMPLE=__jbd_kmalloc:692]
> linux/2.4.17/fs/jbd/transaction.c:54:get_transaction: NOTE:NULL:50:54:[EXAMPLE=__jbd_kmalloc:50]
> linux/2.4.17/fs/jbd/transaction.c:233:journal_start: NOTE:NULL:230:233:[EXAMPLE=__jbd_kmalloc:230]
> linux/2.4.17/fs/jbd/transaction.c:339:journal_try_start: NOTE:NULL:336:339:[EXAMPLE=__jbd_kmalloc:336]
> linux/2.4.17/fs/jbd/transaction.c:895:journal_get_undo_access: NOTE:NULL:885:895:[EXAMPLE=__jbd_kmalloc:885]
> 
> which means there are indeed bugs in jbd, just not the one we flagged ;-)

Ah, but the checker is still (subtly) wrong in this case.  The difference
is that "jbd_kmalloc()" (a macro calling __jbd_kmalloc in the 5 functions
which check the return code) depends on the "journal_oom_retry" variable
to determine whether or not it is "allowed" to return NULL.  In contrast,
the one call to "jbd_rep_kmalloc()" flagged above is a macro which
calls __jbd_kmalloc() with "retry = 1" so it is never allowed to fail
and return NULL.

I can agree that this is really tricky to spot via the checker,
because the function itself is allowed to return NULL (depending on
the "retry" parameter), but in the flagged case it will never return
NULL (which is the whole point of the retries inside __jbd_kmalloc()
because it is not allowed to fail the allocation at this point).  So,
while the 5 other callers are correct in checking the return value
(because journal_oom_retry might be 0 and the allocations could fail),
the lone caller which does not check the return value is also correct
because retry is always 1 in this case.

Needless to say, I still think the checker tool is the best thing since
sliced bread and I don't mind getting false positives like this because
in most cases the checker is correct.  Have you thought about supporting
"checker meta comments" (like lint did) to allow one to flag a piece of
code as being "correct" for a certain check so that it doesn't always
show up on your test runs?

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

