Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278529AbRJSQAZ>; Fri, 19 Oct 2001 12:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278530AbRJSQAM>; Fri, 19 Oct 2001 12:00:12 -0400
Received: from peace.netnation.com ([204.174.223.2]:57868 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S278529AbRJSP7M>; Fri, 19 Oct 2001 11:59:12 -0400
Date: Fri, 19 Oct 2001 08:59:44 -0700
From: Simon Kirby <sim@netnation.com>
To: Andi Kleen <andi@firstfloor.org>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
Message-ID: <20011019085944.A16467@netnation.com>
In-Reply-To: <20011018094222.A31919@netnation.com> <20011019145750.A22193@zero.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20011019145750.A22193@zero.firstfloor.org>; from andi@firstfloor.org on Fri, Oct 19, 2001 at 02:57:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 02:57:50PM +0200, Andi Kleen wrote:

> On Thu, Oct 18, 2001 at 09:42:22AM -0700, Simon Kirby wrote:
> > There is definitely something really broken here.  One of our web servers
> > that was having the problem before has now decided to hit a load average
> > of 50 because identd is taking so long to parse /proc/net/tcp and give
> > back ident information.
> 
> See my last mail. The hash tables are too big. Set a smaller one
> during this patch by using the new tcpehashorder= command line option.
> It sets the hash table size as 2^order*4096 on i386. You can see the
> default order by looking at the dmesg of an machine booted without
> this option set.
> You can find out how much it costs you by looking at 
> /proc/net/sockstat. If the tcp_ehash_buckets value is the same as 
> with the default hash tab size then it didn't cost you anything.
> If the value is very similar it's probably still ok; just if you
> get e.g. average bucket length >5-10 it's probably too small.
> The smaller the hash table the faster should identd work.

Hmm, yeah, on this box with 640 MB I see:

TCP: Hash tables configured (established 262144 bind 65536)

(I'm guessing this means that the hash table has 32k buckets.)

Yes, that's fairly large, but not that huge for machines which will have
tons of sockets open.

Normally we use nothing like that:

sockets: used 133
TCP: inuse 118 orphan 3 tw 171 alloc 119 mem 132
RAW: inuse 0
FRAG: inuse 0 memory 0

...but shrinking the size slightly won't really fix the problem, it will
just make it less obvious.

Direct lookups for identd, service probes, etc., are definitely the
better way to go, but it would be nice if netstat didn't suck as well.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
