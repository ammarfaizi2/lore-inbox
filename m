Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317579AbSHEJus>; Mon, 5 Aug 2002 05:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317581AbSHEJur>; Mon, 5 Aug 2002 05:50:47 -0400
Received: from angband.namesys.com ([212.16.7.85]:53200 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S317579AbSHEJuq>; Mon, 5 Aug 2002 05:50:46 -0400
Date: Mon, 5 Aug 2002 13:54:20 +0400
From: Oleg Drokin <green@namesys.com>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
Message-ID: <20020805135420.A30430@namesys.com>
References: <20020805094429.A5897@namesys.com> <Pine.LNX.4.44.0208051106420.31879-100000@pc40.e18.physik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208051106420.31879-100000@pc40.e18.physik.tu-muenchen.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Aug 05, 2002 at 11:22:49AM +0200, Roland Kuhn wrote:

> BTW: was it directly clear for you for what the do_journal_begin_r() was 
> waiting? I'm not so familiar with fs coding, especially the locking...

I'd say that it's waiting for journal lock that was captured by kupdated
(or something like that) doing periodic write_super() calls, when it thinks
memory is low. Our tests some time ago shown that once memory is lower than
some value, write_super() "method" is called for every superblock that
have "dirty" flag set. In reiserfs that flushes the journal, and while journal
is being flushed, nobody can create new transactions obviously, and since
ls changes directory's atime in normal case, it want to open new transaction.
Unfortunatelly dirty flag for reiserfs gets set way to often than necessary,
we have some patches that should help this (from Chris Mason).
You can try these for yourself too, for example from here:
ftp://ftp.suse.com/pub/people/mason/patches/data-logging/02-commit_super-8-relocation.diff.gz 

> > > this is to use a sync mount, and there I discovered something really 
> > > strange: 2.4.19 gives me about 17MB/s while 2.4.18-3 (RedHat) was creeping 
> > > slow with 10kB/s!
> > 2.4.18-3 is particularly bad know for this exact problem (slow write speed),
> > you should consider upgrading to at least 2.4.18-5 kernel from redhat updates.
> > For me on plain 2.4.18 the problem is not visible that bad as for you.
> > I.e. ls on a directory where I write this big file finishes in under
> > half a second.
> Do you use IDE or SCSI? It seems like the SCSI drivers can have up to 

I tested on IDE.

> > You said 2.4.19 writes stuff faster for you, how about testing ls on that
> > kernel?
> The call trace was from 2.4.19, and the situation actually was much better 

Ah, I thought call trace was from 2.4.18-3.

> than in the 2.4.18-3 case, where it took about 1 minute for ls to come 
> back. 

So you might try the patch I mentioned or you can mount with nodiratime mount
option to prevent updqting of directory atimes, but having atimes still to be
updated on regular files at the same time.

Bye,
    Oleg
