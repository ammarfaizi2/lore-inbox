Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316995AbSEWTsM>; Thu, 23 May 2002 15:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSEWTsL>; Thu, 23 May 2002 15:48:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42765 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316995AbSEWTsL>; Thu, 23 May 2002 15:48:11 -0400
Date: Thu, 23 May 2002 12:46:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>, <riel@surriel.com>,
        <akpm@zip.com.au>
Subject: Re: Have the 2.4 kernel memory management problems on large machines
 been fixed?
In-Reply-To: <Pine.LNX.3.96.1020523152322.12605A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.33.0205231240030.2815-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 May 2002, Bill Davidsen wrote:
> >
> > And once you go there, you have not just started using different pages,
> > you've changed the _semantics_ of the pages: they are no longer coherent
> > with other processes accessing the same file.
> 
> That's the case with a capability, obviously, it's less clear that if you
> had a flag on the file that could happen, since any processes doing a
> mmap() on the file would get LPS.

Note that in that case mmap() would be coherent with itself, but still
probably not coherent with read/write without _major_ surgery in the VM.

So even the per-file flag doesn't really help.

It also gets really hard to do a sane replacement policy for _any_ backing 
store (in order to cover the whole file). The problem with the replacement 
policy is that we simply cannot unmap the big page sanely, because we 
don't want to force a huge 4MB IO of dirty data, _and_ because the VM 
doesn't know about big pages in the first place.

My suggested interface only does anonymous pages exactly for this reason:
you get a fixed number of big pages, and no more. No replacement policies
to worry about, no fundamental VM changes, and you get what people
actually want to have (then you can teach some well-defined places like
the direct-IO page walking about the big page, so that the database can do
IO directly into a _part_ of the page).

		Linus

