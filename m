Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSEVSlP>; Wed, 22 May 2002 14:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSEVSlP>; Wed, 22 May 2002 14:41:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51211 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316673AbSEVSlN>; Wed, 22 May 2002 14:41:13 -0400
Date: Wed, 22 May 2002 11:40:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>, <akpm@zip.com.au>
Subject: Re: Have the 2.4 kernel memory management problems on large machines
 been fixed?
In-Reply-To: <Pine.LNX.4.44L.0205221528070.14140-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0205221132420.23621-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 May 2002, Rik van Riel wrote:
> >
> > It's a magic x86-only system call,
> 
> > Making the _generic_ code jump through hoops because some stupid special
> > case that nobody else is interested in is bad.
> 
> Actually, I suspect that MIPS, x86-64 and other
> architectures are also interested ...

Oh, it can certainly have similar semantics on other architectures, the 
point really being not so much the x86'ness, but the fact that this is a 
separate subsystem with very limited scope.

Limiting the scope means, for example, that:

 - no issues about memory coherency of shared mappings with "read/write"

   mmap _has_ to be coherent for good behaviour (yeah, yeah, I know there 
   are systems out there that aren't, but they are clearly inferior and
   cannot run innd with mappings etc). 

   But doing some kind of "file coherent big page" support is just too 
   horrible for words. 

 - no mixups with "get_unmapped_page()" and friends having to be able to 
   find aligned mappings, and more magic paths on mmap/unmap. As far as 
   the rest of the VM, the big pages are basically just not there. Make 
   that explicit by actually making "pmd_present()" return 0 for big 
   pages.

 - you can later, if you want, _extend_ the semantics without breaking 
   stuff, if some future VM actually wants to be natively aware of big 
   pages. I consider that unlikely, but hey..

Is it fairly ugly? Yes. But it gets the job done, and doing it in some
special C file with little impact on the rest of the system means that we
can tweak it for the hardware instead of trying to make it a "good
design".

		Linus

