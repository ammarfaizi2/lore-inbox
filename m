Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318357AbSH0DjD>; Mon, 26 Aug 2002 23:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318358AbSH0DjD>; Mon, 26 Aug 2002 23:39:03 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:44811 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318357AbSH0DjB>; Mon, 26 Aug 2002 23:39:01 -0400
Date: Mon, 26 Aug 2002 20:43:12 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Cc: Aleksandar Kacanski <kacanski@yahoo.com>
Subject: Re: Memory leak
Message-ID: <20020827034312.GA5196@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org,
	Aleksandar Kacanski <kacanski@yahoo.com>
References: <20020826190106.42208.qmail@web12706.mail.yahoo.com> <Pine.LNX.3.95.1020826152100.6296B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020826152100.6296B-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 03:29:17PM -0400, Richard B. Johnson wrote:
> On Mon, 26 Aug 2002, Aleksandar Kacanski wrote:
> 
> > Hello,
> > I am running 2.4.18-3 version of the kernel on smp dual
> > processor and 1GB of RAM. My memory usage is increasing and
> > I can't find what exactly is eating memory. Top and proc
> > are reporting increases, but I would like to know of a
> > better way of tracing usage of memory and possible leak in
> > application(s).
> > 
> > Please reply to kacanski@yahoo.com
> > thanks                Sasha
> > 
> > 
> 
> Applications that use malloc() and friends, get more memory from
> the kernel by resetting the break address. It's called "morecore()".
> You can put a procedure, perhaps off SIGALRM, that periodically
> checks the break address and writes it to a log. Applications
> that end up with an ever-increasing break address have memory
> leaks. Note that the break address is almost never set back.
> This is not an error; malloc() assumes that if you used a lot
> of memory once, you'll probably use it again. Check out sbrk()
> and brk() in the man pages.

brk() isn't the only way applications get memory.  A
commonly used method of getting process memory is to mmap()
anonymous regions.  Some implementations of malloc() will
use mmap() for larger allocations.  If you use realloc() a
lot this can be particularly useful.

Releasing memory that has been allocated via brk() is
dependent on allocation order so it is seldom done.
Realloc() and co. used poorly can produce lots of
fragmentation exacerbating things.  Allocations done via
mmap() tend to be independent of one another so they can
released more readily.

If an application or library is using mmap() just watching
brk won't do much good.  Actually detecting leakage is very
difficult especially from outside the code.  It requires
tracking the modifications of all the pointers to allocated
memory.

The thing to keep in mind for the common case is that
applications that leak memory will release it on exit.
Most of the time any sizable amount of application memory is 
in disuse it will be in sizable chunks so under memory
pressure will be paged out until exit so will have minimal
impact on the system.

Having said all that i'll now echo Linus et al and tell you
that you want the system to use all of your memory.  Unused
memory is wasted memory and wasted money.  That is why
otherwise free memory is used as cache and disused memory
will be paged out so that it too can be used as cache to
speed up the system as a whole.

And much thanks to all the good, and heartless bastard,
developers who have and continue to work on improving the
paging algorithms and VM system as a whole.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
