Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136641AbREAQPn>; Tue, 1 May 2001 12:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136645AbREAQPc>; Tue, 1 May 2001 12:15:32 -0400
Received: from 13dyn14.delft.casema.net ([212.64.76.14]:4358 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S136641AbREAQPY>; Tue, 1 May 2001 12:15:24 -0400
Message-Id: <200105011614.SAA03338@cave.bitwizard.nl>
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <20010501140003.A28747@redhat.com> from "Stephen C. Tweedie" at
 "May 1, 2001 02:00:03 pm"
To: "Stephen C. Tweedie" <sct@redhat.com>
Date: Tue, 1 May 2001 18:14:54 +0200 (MEST)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
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
> On Mon, Apr 30, 2001 at 07:12:12PM +0100, Alan Cox wrote:
> > > paging in just released 2.4.4, but in previuos kernel, a page that was
> > > paged-out, reserves its place in swap even if it is paged-in again, so
> > > once you have paged-out all your ram at least once, you can't get any
> > > more memory, even if swap is 'empty'.
> > 
> > This is a bug in the 2.4 VM, nothing more or less. It and the horrible bounce
> > buffer bugs are forcing large machines to remain on 2.2. So it has to get 
> > fixed
> 
> Umm, 2.2 can behave in the same way.  The only difference in the 2.4
> behaviour is that 2.4 can maintain the swap cache effect for dirty
> pages as well as clean ones.  An application which creates a large
> in-core data set and then does not modify it will show exactly the
> same behaviour on 2.2.
> 
> To call it a "bug" is to imply that "fixing it" is the right thing to
> do.  It might be in some cases, but discarding the swap entry has a
> cost --- you fragment swap, and if the page in memory is clean, you
> end up increasing the amount of swap IO.  

Shouldn't the algorithm be: 

- If (current_access == write )
	free (swap_page);
  else
 	map (page, READONLY)

and 
  when a write access happens, we fault again, and map free the 
  swap-page as it is now dirty anyway. 

The extra fault when the first access is a read (e.g. in a
read-modify-write case) will seem like a lot of overhead, but if you
save an IO in 1% of the cases, it will be worth it...

Is swap allocated "congruently"? I didn't think so. That would mean
that if one page of a process has to be paged out, you allocate an
area on the swap that maps directly on the whole adressing space of
that process. That way prefetching stuff from swap can actually help a
lot.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
