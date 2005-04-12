Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVDLGY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVDLGY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVDLGVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:21:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:17283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262057AbVDLGUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 02:20:02 -0400
Date: Mon, 11 Apr 2005 23:19:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de,
       Steven Pratt <slpratt@austin.ibm.com>
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050411231941.1b8548bb.akpm@osdl.org>
In-Reply-To: <425B61DD.60700@yahoo.com.au>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<20050411220013.23416d5f.akpm@osdl.org>
	<425B61DD.60700@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> >- The effects of tcq on AS are much less disastrous than I thought they
>  >  were.  Do I have the wrong workload?  Memory fails me.  Or did we fix the
>  >  anticipatory scheduler?
>  >
>  >
> 
>  Yes, we did fix it ;)
>  Quite a long time ago, so maybe you are thinking of something else
>  (I haven't been able to work it out).

Steve Pratt's ols2004 presentation made AS look pretty bad.  However the
numbers in the proceedings
(http://www.finux.org/proceedings/LinuxSymposium2004_V2.pdf) are much less
stark.

Steve, what's up with that?  The slides which you talked to had some awful
numbers.  Was it the same set of tests?

Seems that software RAID might have muddied the waters as well.

That was 2.6.5.  Do you recall if we did significant AS work after that?

>  AS basically does its own TCQ strangulation, which IIRC involves things
>  like completing all reads before issuing new writes, and completing all
>  reads from one process before reads from another. As well as the
>  fundamental way that waiting for a 'dependant read' throttles TCQ.

My (mpt-fusion-based) workstation is still really slow when there's a lot
of writeout happening.  Just from a quick test:

> 2.6.12-rc2, 	as,	tcq depth=2:		7.241 seconds
> 2.6.12-rc2, 	as,	tcq depth=64:		12.172 seconds
> 2.6.12-rc2+patch,as,	tcq depth=64:		7.199 seconds
> 2.6.12-rc2, 	cfq2,	tcq depth=64:		much more than 5 minutes
> 2.6.12-rc2, 	cfq3,	tcq depth=64:		much more than 5 minutes

2.6.11-rc4-mm1, as, mpt-f			39.349 seconds

That was really really slow but had a sudden burst of read I/O at the end
which made the thing look better than it really is.  I wouldn't have a clue
what tag depth it's using, and it's the only mpt-fusion based machine I
have handy...

>  >- as-limit-queue-depth.patch fixes things right up anyway.  Seems to be
>  >  doing the right thing.  
>  >
>  >
> 
>  Well it depends on what we want to do. If we hard limit the AS queue
>  like this, I can remove some of that TCQ throttling logic from AS.
> 
>  OTOH, the throttling was intended to allow us to sanely use a large
>  TCQ depth without getting really bad behaviour. Theoretically a process
>  can make use of TCQ if it is doing a lot of writing, or if it is not
>  determined to be doing dependant reads.

OK, I'll have a bit more of a poke at the LSI53C1030 driver, see if I can
characterise what's going on.
