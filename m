Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131116AbRAJPvK>; Wed, 10 Jan 2001 10:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131105AbRAJPvA>; Wed, 10 Jan 2001 10:51:00 -0500
Received: from monza.monza.org ([209.102.105.34]:47369 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S130110AbRAJPut>;
	Wed, 10 Jan 2001 10:50:49 -0500
Date: Wed, 10 Jan 2001 07:50:20 -0800
From: Tim Wright <timw@splhi.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Rohland <cr@sap.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
Message-ID: <20010110075020.A2352@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Christoph Rohland <cr@sap.com>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Rik van Riel <riel@conectiva.com.br>,
	"Sergey E. Volkov" <sve@raiden.bancorp.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <m3vgroe6qo.fsf@linux.local> <Pine.LNX.4.10.10101091447540.2633-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101091447540.2633-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 09, 2001 at 02:59:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Jan 09, 2001 at 02:59:07PM -0800, Linus Torvalds wrote:
> 
> Arguably the new semantics are perfectly valid semantics on their own, but
> I'm not sure they are acceptable.
> 
> In contrast, the PG_realdirty approach would give the old behaviour of
> truly locked-down shm segments, with not significantly different
> complexity behaviour.
> 
> What do other UNIXes do for shm_lock()?
> 

It appears that the fine-detail semantics vary across the board. DYNIX/ptx
supports two forms of SysV shm locking - soft and hard. Soft-locking (the
default) merely makes the pages sticky, so if you fault them in, they stay
in your resident set, but don't count against it. If, however the process
swaps, they're all evicted, and when the process is swapped back in, you
get to fault the back in all over again. Hard locking pins the segment into
physical memory until such time as it's destroyed. It stays there even if
there are currently no attaches. Again, such pages are not counted against
the process RSS.

SVR4 only support one form. It faults all the pages in and locks them into
memory, but doesn't treat the especially wrt rss/paging, which seems none
too clever - if they're locked into memory, you might as well use them :-)

[Details of the differing approches omitted]

> 
> Does anybody have any better pointers, ideas, or opinions?
> 
> 		Linus
> 

I don't know if there are any arguments in favour of making both approaches
available. Gut feel says that's overkill. We ended up with two by historical
accident. The soft-locking was always there (althought semantically different
to SVR4), and the hard-locking stuff was added to boost performance with a
certain six-letter RDBMS that attaches an SGA to each process. They all get
to attach it "for free", and since it doesn't count towards the RSS, it
allowed tuning a fairly small RSS across the system without having the RDMBS
processes spent all their time (soft) faulting SGA pages in and out of their
RSS.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
