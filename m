Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbQL2GgJ>; Fri, 29 Dec 2000 01:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbQL2Gf7>; Fri, 29 Dec 2000 01:35:59 -0500
Received: from mail2.mia.bellsouth.net ([205.152.144.14]:3989 "EHLO
	mail2.mia.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129538AbQL2Gfo>; Fri, 29 Dec 2000 01:35:44 -0500
Message-ID: <3A4BE396.8A48A3F4@bellsouth.net>
Date: Fri, 29 Dec 2000 01:06:30 +0000
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Stefan Traby <stefan@hello-penguin.com>, Andi Kleen <ak@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.10.10012281712180.1231-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simply executing
         *p++ = htonl(fl->fl_pid);
before 
         start = loff_t_to_s64(fl->fl_start);
also works.
Later,
Albert

Linus Torvalds wrote:
> 
> On Fri, 29 Dec 2000, Stefan Traby wrote:
> > On Thu, Dec 28, 2000 at 03:37:51PM -0800, Linus Torvalds wrote:
> >
> > > Too bad. Maybe somebody should tell gcc maintainers about programmers that
> > > know more than the compiler again.
> >
> > I know that {p,}gcc-2.95.2{,.1} are not officially supported.
> 
> Hmm, I use gcc-2.95.2 myself on some machines, and while I'm not 100%
> comfortable with it, it does count as "supported" even if it has known
> problems with "long long". pgcc isn't.
> 
> > Did you know that it's impossible to compile nfsv4 because of
> > register allocation problems with long long since (long long) month ?
> 
> lockd v4 (for NFS v3), I assume.
> 
> No, I wasn't aware of this particular bug.
> 
> > The following does not hurt, it's just a fix for a broken
> > compiler:
> 
> Ugh, that's ugly.
> 
> Can you test if it is sufficient to just simplify the math a bit, instead
> of uglyfing that function more? The nlm4_encode_lock() function already
> tests for NLM4_OFFSET_MAX explicitly for both start and end, so it should
> be ok to just re-code the function to not do the extra "loff_t_to_s64()"
> stuff, and simplify it enough that the compile rwill be happy to compile
> the simpler function. Something along the lines of
> 
>         if (.. NLM4_OFFSET_MAX tests ..)
>                 ..
> 
>         *p++ = htonl(fl->fl_pid);
> 
>         start = fl->fl_start;
>         len = fl->fl_end - start;
>         if (fl->fl_end == OFFSET_MAX)
>                 len = 0;
> 
>         p = xdr_encode_hyper(p, start);
>         p = xdr_encode_hyper(p, len);
> 
>         return p;
> 
> Where it tries to minimize the liveness of the 64-bit values, and tries to
> avoid extra complications.
> 
>                 Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
