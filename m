Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTEOPVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264065AbTEOPV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:21:26 -0400
Received: from smtp.slac.stanford.edu ([134.79.18.80]:46554 "EHLO
	smtp.slac.stanford.edu") by vger.kernel.org with ESMTP
	id S264063AbTEOPVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:21:17 -0400
Date: Thu, 15 May 2003 08:34:06 -0700 (PDT)
From: Booker Bense <bbense@SLAC.Stanford.EDU>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
In-reply-to: <Pine.LNX.4.44.0305142142190.1605-100000@home.transmeta.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Russ Allbery <rra@stanford.edu>, Garance A Drosihn <drosih@rpi.edu>,
       Jan Harkes <jaharkes@cs.cmu.edu>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       openafs-devel@openafs.org
Message-id: <Pine.LNX.4.55.0305150815230.26737@telemark.slac.stanford.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0305142142190.1605-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Linus Torvalds wrote:

>
> On Wed, 14 May 2003, Russ Allbery wrote:
> >
> > If a single process is in possession of multiple sets of credentials at
> > the same time, how does the file system code in the kernel know which ones
> > to use for a given operation with a network file system?
>
> The file system code will have to make up its own mind about it.

- How? The only way I can see is by trying them all...

>
> In particular, it's likely the case that only _one_ credential is valid
> for that particular mount anyway. You have to ask yourself: where did
> these keys all _come_ from in the first place? And the answer is: usually
> the filesystem. The key was used and registered at mount-time (encrypted
> filesystem), or by some filesystem-specific key exchange.

- This is definitely not the case with AFS or any other
distributed filesystem that I know about. I think the semantics
of encrypted filesystems vs. distributed ones are different
enough that you are going to have problems supporting both with
the same tool. Even if there is a key exchange/auth at mount, you
will still require additional per user key information in a
multi-user file system.

>
> So I expect that for many filesystems there will never be any confusion.
> Clearly AFS only expects to have one session PAG, for example (since that
> is how the _current_ AFS stuff wants to do it), and that implies that
> whenever that session PAG is instantiated, the code that instantiates it
> will remove any old stale PAGs.
>
> But the fact that you'd have AFS with just one set of credentials doesn't
> mean that the same process might not want to have another PAG for other
> uses. Each use might only fit one way.

- You still don't seem to grok what a PAG is. It's merely a
pointer to WHERE to look for credentials, it says nothing about
how many or what kind you'll find there. You can change
credentials without changing your PAG.

>
> And even when you have multiple PAG's for the same entity, this is not a
> new situation. In fact, UNIX pretty much since day 1 has had it: what do
> you think user/group/other are? They are prioritized credentials. There,
> you have two different credentials (well, groups are multiple ones in
> themselves), with a prioritation scheme ("user matters more, but if user
> doesn't match there is no prioritation in groups _except_ one group entry
> is special in that we'll use that for new ID creation").
>
> Up to the filesystem to decide what it does with the different
> credentials, in other words. Some filesystem may decide to only allow one.

- The question is still "WHICH ONE?" How does it decide? Look at
them all? If you've got two valid ones how does it decide?

- I think you're confusing the current implementation of PAG's
which is admitted a hack a best with the idea of PAG's. It'd be
really nice to have kernel with a sane implementation of
setpag/getpag.

_ Booker C. Bense
