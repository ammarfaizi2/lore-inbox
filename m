Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbUK2Rl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbUK2Rl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 12:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUK2Rl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 12:41:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:63903 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261428AbUK2Rly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 12:41:54 -0500
Date: Mon, 29 Nov 2004 09:41:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Nov 2004, Alexandre Oliva wrote:
>
> > On the bigger question of what to do with kernel headers in general, let's 
> > just make one thing clear: the kernel headers are for the kernel, and big 
> > and painful re-organizations that don't help _existing_ user space are not 
> > going to happen.
> 
> So, of the following two options, which one you think everybody should
> pick?

Ok, that's pretty straightforward:

> - Linux gets to define the ABI between kernel and userland, and
>   userland must duplicate the contents of headers in which the kernel
>   defines the kernel<->userland ABI, tracking changes in them in the
>   hope that nothing falls through the cracks

This is unquestionably true. The kernel obviously _does_ define the ABI, 
and userland just lives with it. At some point you have to track things, 
just because new features etc just can't be sanely handled any other way. 

That said, I think we can make the tracking _easier_. 

> - we move the kernel<->userland to a separate package, where it's
>   maintained such that it can be used by both kernel and userland, and
>   Linux will only build when given a pointer to the location of this
>   package.

No. Quite frankly, I absolutely hate projects that do that. I gave up on
following several interesting projects (mostly media decoding) just
because it was just too damn painful to try to make sure that five
different packages were all in sync, and you couldn't find one site to
just download it all from.

So I want the kernel to be as stand-alone as humanly possible. There are a
few dependencies I can't avoid, notably the compiler, and there the kernel
triest to be as permissive as humanly reasonable, and we've always tried
to keep the required tools down to a manageable level (ie even when people
were clamorign for graphical configurations etc, the kernel always made
that very optional indeed).

  ***

Now, on trying to make the tracking _easier_, I would not mind at all to 
move (well-defined) things around a bit to make it clearer what is 
actually exported to user space. But on the other hand, I don't think it's 
actively wrong either to just "mark" them in the headers some way, and 
have tools to extract it automatically _without_ having to separate them 
into some magic location.

In fact, in many ways I'd prefer to have source-level annotations like 
"this is exported to user space" over trying to gather things in one 
place. It would need to have some automated checking ability (that 
probably most people wouldn't run, and would break every once in a while, 
but hey, that's nothing new. That's how "checkconfig" etc works).

But it doesn't have to be "one or the other". I think we could annotate
some things that are nasty to export (and quite frankly, it's not like
this is something "new"; __KERNEL__ is really nothing but a stupid sort of
an "annotation" already, except it's likely the wrong way around: we
should not annotate the stuff that is kernel-only, we should annotate the
stuff that is user-visible, since that should be the exception rather than
the rule).

But even if we decide to have part of the ABI annotated, part of it could 
be split out better. For example, I think the "posix_types.h" split ended 
up working really quite well, and it cleaned up a _huge_ number of type 
issues that people have probably already forgotten because that split was 
done so long ago.

So we _have_ had great success with the "split out specific things"  
before, and I think we should do it whenever there is an obvious chance,
and something is abstracted out and well-defined enough that we can do so.

But in general, I do kind of like the explicit marking. The same way we 
explicitly mark the functions inside the kernel that we expose to modules, 
we could try to mark the data structures and values that we expose to user 
space. That tends to "work".

		Linus
