Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133048AbRAJRDj>; Wed, 10 Jan 2001 12:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135573AbRAJRD3>; Wed, 10 Jan 2001 12:03:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16396 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S133048AbRAJRDN>; Wed, 10 Jan 2001 12:03:13 -0500
Date: Wed, 10 Jan 2001 09:03:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Zlatko Calusic <zlatko@iskon.hr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug 
In-Reply-To: <18634.979127163@redhat.com>
Message-ID: <Pine.LNX.4.10.10101100858480.4283-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, David Woodhouse wrote:

> 
> torvalds@transmeta.com said:
> >  The no-swap behaviour shoul dactually be pretty much identical,
> > simply because both 2.2 and 2.4 will do the same thing: just skip
> > dirty pages in the page tables because they cannot do anything about
> > them. 
> 
> So the VM code spends a fair amount of time scanning lists of pages which 
> it really can't do anything about?

It can do _tons_ of stuff.

Remember, on platforms like this, one of the reasons for being low on
memory is things like running X and netscape: maybe you have 64MB of RAM
and you don't think you need a swap device, and you want to have a web
browser.

The fact that we cannot touch _dirty_ pages doesn't mean that there's
nothing to do: instead of running out of memory we can at least make the
machine usable by dropping the text pages and the page cache..

> Would it be possible to put such pages on different list, so that the VM
> code doesn't have to keep skipping them?

If we don't have any swapspace, the dirty pages will not be on any lists:
they will never have exited the page tables, and they will just be dirty
anonymous, unlisted pages.

We'll still scan the page tables (and see them there), but we have to do
that to find the clean and unreferenced pages - we don't have separate
"dirty page tables" and "clean page tables" ;)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
