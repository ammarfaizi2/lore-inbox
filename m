Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbREBKyx>; Wed, 2 May 2001 06:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbREBKyh>; Wed, 2 May 2001 06:54:37 -0400
Received: from 13dyn198.delft.casema.net ([212.64.76.198]:55053 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132577AbREBKyY>; Wed, 2 May 2001 06:54:24 -0400
Message-Id: <200105021054.MAA07283@cave.bitwizard.nl>
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <20010501173558.U26638@redhat.com> from "Stephen C. Tweedie" at
 "May 1, 2001 05:35:58 pm"
To: "Stephen C. Tweedie" <sct@redhat.com>
Date: Wed, 2 May 2001 12:54:15 +0200 (MEST)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, May 01, 2001 at 06:14:54PM +0200, Rogier Wolff wrote:
> 
> > Shouldn't the algorithm be: 
> > 
> > - If (current_access == write )
> > 	free (swap_page);
> >   else
> >  	map (page, READONLY)
> > 
> > and 
> >   when a write access happens, we fault again, and map free the 
> >   swap-page as it is now dirty anyway. 
> 
> That's what 2.2 did.  2.4 doesn't have to. 
> 
> The trouble is, you really want contiguous virtual memory to remain
> contiguous on swap.  Freeing individual pages like this on fault can
> cause a great deal of fragmentation in swap.  We'd far rather keep the
> swap page reserved for future use by the same page so that the VM
> region remains contiguous on disk.
> 
> That's fine as far as it goes, but the problem happens if you _never_
> free up such pages.  We should reap the unused swap page if we run out
> of swap.  We don't, and _that_ is the problem --- not the fact that
> the page is left allocated in the first place, but the fact that we
> don't do anything about it once we are short on disk.

first: Thanks for clearing this up for me. 

So, there are in fact some more "states" a swap-page can be in:

	-(0) free
	-(1) allocated, not in mem. 
	-(2) on swap, valid copy of memory. 
	-(3) on swap: invalid copy, allocated for fragmentation, can 
		be freed on demand if we are close to running out of swap.

If we running low on (0) swap-pages we can first start to reap the (3)
pages, and if that runs out, we can start reaping the (2)
pages. Right?


		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
