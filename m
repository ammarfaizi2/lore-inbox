Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318915AbSHMC73>; Mon, 12 Aug 2002 22:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318916AbSHMC72>; Mon, 12 Aug 2002 22:59:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42763 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318915AbSHMC71>;
	Mon, 12 Aug 2002 22:59:27 -0400
Message-ID: <3D587955.B0FEB77C@zip.com.au>
Date: Mon, 12 Aug 2002 20:13:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: pte_chain leak in rmap code (2.5.31)
References: <Pine.LNX.4.44.0208121942371.25611-100000@dad.molina> <Pine.LNX.4.44L.0208122208510.23404-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Mon, 12 Aug 2002, Thomas Molina wrote:
> > On Mon, 12 Aug 2002, Rik van Riel wrote:
> > > On Mon, 12 Aug 2002, Christian Ehrhardt wrote:
> > >
> > > > Note the strange use of continue and break which both achieve the same!
> > > > What was meant to happen (judging from rmap-13c) is that we break
> > > Excellent hunting!   Thank you!
> > Any chance this is the cause of the following?
> 
> Yes, quite possible.
> 

Well Adam reported it against the patched version, in which
is appears that I accidentally fixed that bug.  So we may
yet have a problem:

	for (pc = start; pc; pc = next_pc) {
		int i;

		next_pc = pc->next;
		if (next_pc)
			prefetch(next_pc);
		for (i = 0; i < NRPTE; i++) {
			pte_t *p = pc->ptes[i];

			if (!p)
				continue;
			if (victim_i == -1) 
				victim_i = i;

			switch (try_to_unmap_one(page, p)) {
			case SWAP_SUCCESS:
				/*
				 * Release a slot.  If we're releasing the
				 * first pte in the first pte_chain then
				 * pc->ptes[i] and start->ptes[victim_i] both
				 * refer to the same thing.  It works out.
				 */
				pc->ptes[i] = start->ptes[victim_i];
				start->ptes[victim_i] = NULL;
				dec_page_state(nr_reverse_maps);
				victim_i++;
				if (victim_i == NRPTE) {
					page->pte.chain = start->next;
					pte_chain_free(start);
					start = page->pte.chain;
					victim_i = 0;
				}
				break;
			case SWAP_AGAIN:
				/* Skip this pte, remembering status. */
				ret = SWAP_AGAIN;
				continue;
			case SWAP_FAIL:
				ret = SWAP_FAIL;
				goto out;
			case SWAP_ERROR:
				ret = SWAP_ERROR;
				goto out;
			}
		}
	}
out:
	return ret;
}
