Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971945-18554>; Thu, 9 Jul 1998 21:13:50 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:19642 "EHLO neon.transmeta.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <971944-18554>; Thu, 9 Jul 1998 21:12:48 -0400
Date: Thu, 9 Jul 1998 19:18:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bill Hawes <whawes@star.net>
cc: ganesh.sittampalam@magd.ox.ac.uk, "Stephen C. Tweedie" <sct@redhat.com>, Virtual Memory problem report list <linux-kernel@vger.rutgers.edu>, mingo@valerie.inf.elte.hu, Alan Cox <number6@the-village.bc.nu>, "David S. Miller" <davem@dm.cobaltmicro.com>
Subject: Re: Progress! was: Re: Yet more VM writable swap-cached pages
In-Reply-To: <35A579F3.68F549AF@star.net>
Message-ID: <Pine.LNX.3.96.980709191306.431I-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Thu, 9 Jul 1998, Bill Hawes wrote:
>
> > +extern inline pte_t pte_mkwrite(pte_t pte)     { pte_val(pte) |= _PAGE_RW; return pte; }
>                                                                     ^^^^^^^^
> Did you mean to put in _PAGE_WRITABLE here, or can the pte_mkwrite macro always assume the
> PRESENT bit is already set?

I decided that it cannot matter. If somebody tries to make a PROT_NONE
page writable by using pte_mkwrite(), there is already a bug there, and
I'm happier keeping it PROT_NONE than I am to mark it present. 

Note that this can not happen through a normal page fault, because a
normal page fault would have noticed that we don't actually have write
permission to the page at all. As such, the only way somebody can mark a
PROT_NONE page writable is if we're doing the nasty "bring in all the
pages because somebody did a mlock[all]() on us". 

In which case the above does the right thing, by certainly bringing the
page in, but not actually allowing anybody to read/write to it (actually,
I don't think this can happen even in that case, because if we have
PROT_NONE then the make_pages_present() stuff will not try to bring it
into memory writably, so we won't even try to make it writable). 

In short, the above really only makes sense if PRESENT is already set, and
if it was PROT_NONE from before it is a no-op which is fine.

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
