Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318432AbSHKWcP>; Sun, 11 Aug 2002 18:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318433AbSHKWcP>; Sun, 11 Aug 2002 18:32:15 -0400
Received: from dsl-213-023-020-163.arcor-ip.net ([213.23.20.163]:27810 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318432AbSHKWcO>;
	Sun, 11 Aug 2002 18:32:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: large page patch (fwd) (fwd)
Date: Mon, 12 Aug 2002 00:33:29 +0200
X-Mailer: KMail [version 1.3.2]
Cc: frankeh@watson.ibm.com, davidm@hpl.hp.com,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com> <E17dBZN-0001Ng-00@starship> <1029097817.16421.53.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1029097817.16421.53.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17e1H8-0001iE-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 August 2002 22:30, Alan Cox wrote:
> On Fri, 2002-08-09 at 16:20, Daniel Phillips wrote:
> > On Sunday 04 August 2002 19:19, Hubertus Franke wrote:
> > > "General Purpose Operating System Support for Multiple Page Sizes"
> > > htpp://www.usenix.org/publications/library/proceedings/usenix98/full_papers/ganapathy/ganapathy.pdf
> > 
> > This reference describes roughly what I had in mind for active 
> > defragmentation, which depends on reverse mapping.  The main additional
> > wrinkle I'd contemplated is introducing a new ZONE_LARGE, and GPF_LARGE,
> > which means the caller promises not to pin the allocation unit for long
> > periods and does not mind if the underlying physical page changes
> > spontaneously.  Defragmenting in this zone is straightforward.
> 
> Slight problem. This paper is about a patented SGI method for handling
> defragmentation into large pages (6,182,089). They patented it before
> the presentation.

See 'straightforward' above, i.e., obvious to a practitioner of the art.
This is another one-click patent.

Look at claim 16, it covers our buddy allocator quite nicely:

   http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO1&Sect2=HITOFF&d=PALL&p=1&u=/netahtml/srchnum.htm&r=1&f=G&l=50&s1='6182089'.WKU.&OS=PN/6182089&RS=PN/6182089
 
Claim 1 covers the idea of per-size freelist thresholds, below which no
coalescing is done.

Claim 13 covers the idea of having a buddy system on each node of a numa
system.  Bill is going to be somewhat disappointed to find out he can't do
that any more.

It goes on in this vein.  I suggest all vm hackers have a close look at
this.  Yes, it's stupid, but we can't just ignore it.

> They also hold patents on the other stuff that you've recently been
> discussing about not keeping seperate rmap structures until there are
> more than some value 'n' when they switch from direct to indirect lists
> of reverse mappings (6,112,286)

This is interesting.  By setting their 'm' to 1, you get essentially the
scheme implemented by Dave a few weeks ago, and by setting 'm' to 0, the
patent covers pretty much every imaginable reverse mapping scheme.  Gee,
so SGI thought of reverse mapping in 1997 or thereabouts, and nobody ever
did before?

   http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO1&Sect2=HITOFF&d=PALL&p=1&u=/netahtml/srchnum.htm&r=1&f=G&l=50&s1='6112286'.WKU.&OS=PN/6112286&RS=PN/6112286

Claim 2 covers use of their reverse mapping scheme, which as we have seen,
includes all reverse mapping schemes, for migrating the data content of
pages, and updating the page table pointers.

Claim 4 goes on to cover migration of data pages between nodes of a numa
system.  (Got that wli?)

This patent goes on to claim just about everything you can do with a
reverse map.  It's sure lucky for SGI that they were the first to think
of the idea of reverse mapping.

> If you are going read and propose things you find on Usenix at least
> check what the authors policies on patents are.

As always, I developed my ideas from first principles.  I never saw or
heard of the paper until a few days ago.  I don't need their self-serving
paper to figure this stuff out, and if they are going to do blatantly
commercial stuff like that, I'd rather the paper were not published at
all.  Perhaps Usenix needs to establish a policy about that.

> Perhaps someone should first of all ask SGI to give the Linux community
> permission to use it in a GPL'd operating system ?

Yes, we should ask nicely, if we run into something that matters.  Asking
nicely isn't the only option though.

And yes, I'm trying to be polite.  It's just so stupid.

--
Daniel
