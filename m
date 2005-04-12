Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVDLHvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVDLHvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 03:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVDLHvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 03:51:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:16790 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262036AbVDLHvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 03:51:03 -0400
Date: Tue, 12 Apr 2005 00:50:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de,
       Steven Pratt <slpratt@austin.ibm.com>
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050412005045.5dc05310.akpm@osdl.org>
In-Reply-To: <1113288543.5090.34.camel@npiggin-nld.site>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<20050411220013.23416d5f.akpm@osdl.org>
	<425B61DD.60700@yahoo.com.au>
	<20050411231941.1b8548bb.akpm@osdl.org>
	<1113288543.5090.34.camel@npiggin-nld.site>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> > >  AS basically does its own TCQ strangulation, which IIRC involves things
>  > >  like completing all reads before issuing new writes, and completing all
>  > >  reads from one process before reads from another. As well as the
>  > >  fundamental way that waiting for a 'dependant read' throttles TCQ.
>  > 
>  > My (mpt-fusion-based) workstation is still really slow when there's a lot
>  > of writeout happening.  Just from a quick test:
>  > 
>  > > 2.6.12-rc2, 	as,	tcq depth=2:		7.241 seconds
>  > > 2.6.12-rc2, 	as,	tcq depth=64:		12.172 seconds
>  > > 2.6.12-rc2+patch,as,	tcq depth=64:		7.199 seconds
>  > > 2.6.12-rc2, 	cfq2,	tcq depth=64:		much more than 5 minutes
>  > > 2.6.12-rc2, 	cfq3,	tcq depth=64:		much more than 5 minutes
>  > 
>  > 2.6.11-rc4-mm1, as, mpt-f			39.349 seconds
>  > 
>  > That was really really slow but had a sudden burst of read I/O at the end
>  > which made the thing look better than it really is.  I wouldn't have a clue
>  > what tag depth it's using, and it's the only mpt-fusion based machine I
>  > have handy...
>  > 
> 
>  Heh. 

Well with my current lineup on the mpt-fusion driver and no
as-limit-queue-depth.patch that test takes 17 seconds.  With
as-limit-queue-depth.patch it's down to 10 seconds.  Which is pretty darn
good btw.  I assume from this:

scsi0 : ioc0: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=222, IRQ=25
scsi1 : ioc1: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=222, IRQ=26

that it's using a tag depth of 222.

	int			 req_depth;	/* Number of request frames */

I wonder if that's true...


One thing which changed is that this kernel now has the fixed-up mpt-fusion
chipset tuning.  That doubles the IO bandwidth, which would pretty well
account for that difference.  I'll wait and see how irritating things get
under writeout load.

Yes, we'll need to decide if we want to retain as-limit-queue-depth.patch
and toss out some of the older AS logic which was designed to address the
TCQ problem.

Steve, could you help to identify a not-too-hard-to-set-up workload at
which AS was particularly poor?  Thanks.

