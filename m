Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292740AbSBQGYu>; Sun, 17 Feb 2002 01:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292785AbSBQGYl>; Sun, 17 Feb 2002 01:24:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10766 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292740AbSBQGYc>; Sun, 17 Feb 2002 01:24:32 -0500
Date: Sat, 16 Feb 2002 22:23:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Page table sharing
In-Reply-To: <E16cC3z-0004Kf-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0202162219230.8326-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Feb 2002, Daniel Phillips wrote:
> >
> > 	if (put_page_testzero(pmd_page)) {
> > 		.. free the actual page table entries ..
> > 		__free_pages_ok(pmd_page, 0);
> > 	}
> >
> > instead of using the free_page() logic. Maybe you do that already, I
> > didn't go through the patches _that_ closely.
>
> I do something similar in clear_page_tables->free_one_pmd, after the entries
> are all gone.  I have to do something different in zap_page_range - it wants
> to free the pmd only if the count is *greater* than one, and can't tolerate
> two mms thinking that at the same time.  I think I'd better lock the pmd page
> there.

But that's ok.

If you have the logic that

	if (put_page_testzero(pmd_page)) {
		... do the lower-level free ...
		__free_pages_ok(pmd_page, 0);
	}

then you automatically have exactly the behaviour you want, with no
locking at all (except for the "local" locking inherent in the atomic
decrement-and-test).

What you have is:
 - _if_ the count was > 1, then you do nothing at all (except for
   decrementing your count)
 - for the last user (and for that _only_), where the count was 1 and goes
   to zero, you'll do the inside of the "if ()" statement, and actually
   clean up the page table and free the pmd.

So you not only get the optimization you want, you also quite naturally
get the "exclusive last user" case.

		Linus

