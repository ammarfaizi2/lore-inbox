Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSFJGHI>; Mon, 10 Jun 2002 02:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316679AbSFJGHH>; Mon, 10 Jun 2002 02:07:07 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:31636 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S316678AbSFJGHG>;
	Mon, 10 Jun 2002 02:07:06 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206100607.XAA17282@csl.Stanford.EDU>
Subject: Re: [CHECKER] 54 missing null pointer checks in 2.4.17
To: adilger@clusterfs.com (Andreas Dilger)
Date: Sun, 9 Jun 2002 23:07:05 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <20020610052807.GB20388@turbolinux.com> from "Andreas Dilger" at Jun 09, 2002 11:28:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > /u2/engler/mc/oses/linux/2.4.17/fs/jbd/journal.c
> > 	 * Do we need to do a data copy?
> > 	 */
> > 
> > 	if (need_copy_out && !done_copy_out) {
> > 		char *tmp;
> > Start --->
> > 		tmp = jbd_rep_kmalloc(jh2bh(jh_in)->b_size, GFP_NOFS);
> > 
> > 		jh_in->b_frozen_data = tmp;
> > Error --->
> > 		memcpy (tmp, mapped_data, jh2bh(jh_in)->b_size);
> 
> Note that jbd_rep_kmalloc() is a special case, and will not currently
> return NULL.  This macro calls  __jbd_rep_kmalloc(..., retry=1) which
> means "repeat the allocation until it succeeds" so the code path
> "if (!retry) return NULL" can never actually happen from this caller.
> The logic is somewhat convoluted, so it is not surprising that the
> checker didn't distinguish this case (it would have to have done the
> "constant" evaluation to drop the NULL return path from the code).

Interesting.  The checker infers which functions can plausibly return
null by counting, for each function f:
	1.  how many callsites check f's return value against null
 versus 
	2.how many do not.  
In this case the reason we were checking jbd_rep_kmalloc (actually
__jbd_kmalloc) was because five other callers in jbd checked it:

/u2/engler/mc/oses/linux/2.4.17/fs/jbd/journal.c:695:journal_init_common: NOTE:NULL:692:695:[EXAMPLE=__jbd_kmalloc:692]
/u2/engler/mc/oses/linux/2.4.17/fs/jbd/transaction.c:54:get_transaction: NOTE:NULL:50:54:[EXAMPLE=__jbd_kmalloc:50]
/u2/engler/mc/oses/linux/2.4.17/fs/jbd/transaction.c:233:journal_start: NOTE:NULL:230:233:[EXAMPLE=__jbd_kmalloc:230]
/u2/engler/mc/oses/linux/2.4.17/fs/jbd/transaction.c:339:journal_try_start: NOTE:NULL:336:339:[EXAMPLE=__jbd_kmalloc:336]
/u2/engler/mc/oses/linux/2.4.17/fs/jbd/transaction.c:895:journal_get_undo_access: NOTE:NULL:885:895:[EXAMPLE=__jbd_kmalloc:885]

which means there are indeed bugs in jbd, just not the one we flagged ;-)

Dawson

PS this is the meaning of the rather opaque "[ex=5] [counter=1]" in the
error message:  5 checks of __jbd_kmalloc versus 1 use-without-check of it.

/u2/engler/mc/oses/linux/2.4.17/fs/jbd/journal.c:441:journal_write_metadata_buffer: ERROR:NULL:438:441:Passing unknown ptr "tmp"! as arg 0 to call "memcpy"! set by '__jbd_kmalloc':438 [COUNTER=__jbd_kmalloc:438] [fit=22] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=5] [counter=1] [z = -1.31122013621437] [fn-z = -4.35889894354067]
