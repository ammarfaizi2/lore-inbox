Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316968AbSEWRby>; Thu, 23 May 2002 13:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316969AbSEWRby>; Thu, 23 May 2002 13:31:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10245 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316968AbSEWRbx>; Thu, 23 May 2002 13:31:53 -0400
Date: Thu, 23 May 2002 10:18:17 -0700 (PDT)
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
In-Reply-To: <Pine.LNX.3.96.1020523101302.11249C-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0205231009430.1006-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 May 2002, Bill Davidsen wrote:
> On Wed, 22 May 2002, Linus Torvalds wrote:
>
> > Making the _generic_ code jump through hoops because some stupid special
> > case that nobody else is interested in is bad.
>
> Thoughts in no particular order:
>  - set large page size based on file size or mapped section size

No can do. Most hardware out there (by about 99.9%) only has two page
sizes, and the second page size actually depends on a kernel compile
option (2M of 4M).

And the problem with _big_ pages (as opposed to just "slightly bigger"
pages like some architectures have, ranging from 8kB - 64kB) is that they
are _way_ too easy to misuse for VM DoS attacks.

Basically, they aren't just a "gradual improvement" on the VM subsystem.
They have _totally_ different characteristics, and simply do not fit with
the VM.

>  - set LPS based on a capability on the program
>  - set LPS based on a flag of some nature on the file
>  - set LPS based on the number of processes mapping the file
>
> I mention these because it would be nice to get better behaviour from
> programs which aren't optimized for Linux and may never be.

One of the problems with LPS is that it simply _will_not_ be coherent with
read/write and the regular page cache.

If you make the LPS decision on some process capability or other flag, you
have to accept the mixing of small pages and large pages - because other
processes that do _not_ have the capability will not get the LPS.

And once you go there, you have not just started using different pages,
you've changed the _semantics_ of the pages: they are no longer coherent
with other processes accessing the same file.

And that's ignoring the fact that the regular interfaces change in other
ways, ie the alignment restrictions on mmap() etc change _radically_.

In other words, don't do it. It changes semantics, and because it changes
semantics the program _has_ to be aware of it. In other words, the program
has to be compiled for the behaviour.

Now, we can make those semantics _easier_ to use, so that the changes to
existing programs are minimal. But changes there will be.

		Linus

