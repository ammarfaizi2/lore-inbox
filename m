Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSELChM>; Sat, 11 May 2002 22:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316297AbSELChL>; Sat, 11 May 2002 22:37:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26124 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315287AbSELChJ>;
	Sat, 11 May 2002 22:37:09 -0400
Message-ID: <3CDDD614.FA8A4AB9@zip.com.au>
Date: Sat, 11 May 2002 19:40:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Lincoln Dale <ltd@cisco.com>, Linus Torvalds <torvalds@transmeta.com>,
        Larry McVoy <lm@bitmover.com>, Gerrit Huizenga <gh@us.ibm.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14 IDE 
 56)
In-Reply-To: <20020511111935.B30126@work.bitmover.com> <Pine.LNX.4.44.0205111130080.879-100000@home.transmeta.com> <5.1.0.14.2.20020512092751.02bcca40@mira-sjcm-3.cisco.com> <20020511183616.A10381@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
> 
> We did some i/o profiling about 6 years ago on a big scientific
>  app that had started in fortran and had been rewritten in c++
> the fortran code used r/w on files and used temp files
> the c++ did memmaps and had big data structures - taking advantage of
> memory management.
> one thing I thought was interesting is that it was easy to see how a smart
> algorithm, not even such a smart one, could adapt i/o to the patterns of
> i/o in the fortran code, but the c++ i/o patters were really complex.
> 
> when everything goes into the page cache, it seems like you will loose
> information.
> 

That is certainly the case.  If the application is seekily writing
to a file then we currently lay the file out on-disk in the order
in which the application seeked.  So reading the file back
linearly is very slow.

Now this is not necessarily a bad thing - if the file was created
seekily then it will probably be _used_ seekily so no big
loss probably.

This problem is pretty unsolvable for filesystems which map blocks
to their disk address at write(2) time.  It can be solved for
allocate-on-flush filesystems via a sort of the dirty page list,
or by maintaining ->dirty_pages in a tree or whatever.

There is one "file" where this problem really does matter - the
blockdev mapping "/dev/hda1".  It is both highly fragmented and
poorly sorted on the dirty_pages list.

It's pretty trivial to perform a sillysort at writeout time:
if we just wrote page N and the next page isn't N+1 then do a
pagecache probe for "N+1".   That's probably sufficient.  If
not, there's a simple little sort routine over at 
http://www.chiark.greenend.org.uk/~sgtatham/algorithms/listsort.html
which is appropriate to our lists.

I'll be taking a look at the sillysort option once I've cleared away
some other I/O scheduling glitches.

-
