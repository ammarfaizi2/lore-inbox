Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131588AbREBLHz>; Wed, 2 May 2001 07:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbREBLHp>; Wed, 2 May 2001 07:07:45 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:17980 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131588AbREBLHZ>; Wed, 2 May 2001 07:07:25 -0400
Date: Wed, 2 May 2001 12:04:03 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010502120403.G26638@redhat.com>
In-Reply-To: <20010501173558.U26638@redhat.com> <200105021054.MAA07283@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200105021054.MAA07283@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Wed, May 02, 2001 at 12:54:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 02, 2001 at 12:54:15PM +0200, Rogier Wolff wrote:
> 
> first: Thanks for clearing this up for me. 
> 
> So, there are in fact some more "states" a swap-page can be in:
> 
> 	-(0) free
> 	-(1) allocated, not in mem. 
> 	-(2) on swap, valid copy of memory. 
> 	-(3) on swap: invalid copy, allocated for fragmentation, can 
> 		be freed on demand if we are close to running out of swap.
> 
> If we running low on (0) swap-pages we can first start to reap the (3)
> pages, and if that runs out, we can start reaping the (2)
> pages. Right?

Yes.  However, there is other state to worry about too.  Anonymous
pages are referenced from process page tables.  As long as the page
tables are referring to the copy in memory, you can free up the copy
on disk.  However, if any ptes point to the copy on disk, you cannot
(and remember, process forks can result in multiple process mm's
pointing to the same anonymous page, and some of those mm's may point
to swap while others point to the in-core page).

So the aim is more complex.  Basically, once we are short on VM, we
want to eliminate redundant copies of swap data.  That implies two
possible actions, not one --- we can either remove the swap page for
data which is already in memory, or we can remove the in-memory copy
of data which is already on swap.  Which one is appropriate will
depend on whether the ptes in the system point to the swap entry or
the memory entry.  If we have ptes pointing to both, then we cannot
free either.

Cheers,
 Stephen
