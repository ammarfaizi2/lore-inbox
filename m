Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVDLGtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVDLGtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVDLGtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:49:17 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:39286 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262019AbVDLGtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 02:49:07 -0400
Subject: Re: 2.6.12-rc2-mm3
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Steven Pratt <slpratt@austin.ibm.com>
In-Reply-To: <20050411231941.1b8548bb.akpm@osdl.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
	 <20050411220013.23416d5f.akpm@osdl.org> <425B61DD.60700@yahoo.com.au>
	 <20050411231941.1b8548bb.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 16:49:02 +1000
Message-Id: <1113288543.5090.34.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 23:19 -0700, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > >- The effects of tcq on AS are much less disastrous than I thought they
> >  >  were.  Do I have the wrong workload?  Memory fails me.  Or did we fix the
> >  >  anticipatory scheduler?
> >  >
> >  >
> > 
> >  Yes, we did fix it ;)
> >  Quite a long time ago, so maybe you are thinking of something else
> >  (I haven't been able to work it out).
> 
> Steve Pratt's ols2004 presentation made AS look pretty bad.  However the
> numbers in the proceedings
> (http://www.finux.org/proceedings/LinuxSymposium2004_V2.pdf) are much less
> stark.
> 
> Steve, what's up with that?  The slides which you talked to had some awful
> numbers.  Was it the same set of tests?
> 

Yes, they still do... :P

> Seems that software RAID might have muddied the waters as well.
> 

This may be the big issue, and yes software (and hardware) RAID isn't
very good for AS - mainly because it can't make a good guess as to
where "the head" is.

Probably software RAID should default to using deadline if possible.
I think we can do that easily with Jens' recent ioscheduler work.

> That was 2.6.5.  Do you recall if we did significant AS work after that?
> 

I don't think there was.

> >  AS basically does its own TCQ strangulation, which IIRC involves things
> >  like completing all reads before issuing new writes, and completing all
> >  reads from one process before reads from another. As well as the
> >  fundamental way that waiting for a 'dependant read' throttles TCQ.
> 
> My (mpt-fusion-based) workstation is still really slow when there's a lot
> of writeout happening.  Just from a quick test:
> 
> > 2.6.12-rc2, 	as,	tcq depth=2:		7.241 seconds
> > 2.6.12-rc2, 	as,	tcq depth=64:		12.172 seconds
> > 2.6.12-rc2+patch,as,	tcq depth=64:		7.199 seconds
> > 2.6.12-rc2, 	cfq2,	tcq depth=64:		much more than 5 minutes
> > 2.6.12-rc2, 	cfq3,	tcq depth=64:		much more than 5 minutes
> 
> 2.6.11-rc4-mm1, as, mpt-f			39.349 seconds
> 
> That was really really slow but had a sudden burst of read I/O at the end
> which made the thing look better than it really is.  I wouldn't have a clue
> what tag depth it's using, and it's the only mpt-fusion based machine I
> have handy...
> 

Heh. 

> >  >- as-limit-queue-depth.patch fixes things right up anyway.  Seems to be
> >  >  doing the right thing.  
> >  >
> >  >
> > 
> >  Well it depends on what we want to do. If we hard limit the AS queue
> >  like this, I can remove some of that TCQ throttling logic from AS.
> > 
> >  OTOH, the throttling was intended to allow us to sanely use a large
> >  TCQ depth without getting really bad behaviour. Theoretically a process
> >  can make use of TCQ if it is doing a lot of writing, or if it is not
> >  determined to be doing dependant reads.
> 
> OK, I'll have a bit more of a poke at the LSI53C1030 driver, see if I can
> characterise what's going on.

OK. I'd like to start doing a bit of work on AS again too. Hopefully
after the current CPU scheduler work gets resolved.



