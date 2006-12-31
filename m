Return-Path: <linux-kernel-owner+w=401wt.eu-S933153AbWLaMWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933153AbWLaMWR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 07:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933154AbWLaMWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 07:22:17 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:21790 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933153AbWLaMWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 07:22:16 -0500
Date: Sun, 31 Dec 2006 13:22:03 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Michael Holzheu <holzheu@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [S390] cio: fix stsch_reset.
Message-ID: <20061231122203.GA11633@osiris.ibm.com>
References: <200612310135_MC3-1-D6D0-A862@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612310135_MC3-1-D6D0-A862@compuserve.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 01:31:43AM -0500, Chuck Ebbert wrote:
> In-Reply-To: <20061228103925.GB6270@skybase>
> 
> On Thu, 28 Dec 2006 11:39:25 +0100, Martin Schwidefsky wrote:
> 
> > @@ -881,10 +880,18 @@ static void cio_reset_pgm_check_handler(
> >  static int stsch_reset(struct subchannel_id schid, volatile struct schib *addr)
> >  {
> >       int rc;
> > +     register struct subchannel_id reg1 asm ("1") = schid;
> >
> >       pgm_check_occured = 0;
> >       s390_reset_pgm_handler = cio_reset_pgm_check_handler;
> > -     rc = stsch(schid, addr);
> > +
> > +     asm volatile(
> > +             "       stsch   0(%2)\n"
> > +             "       ipm     %0\n"
> > +             "       srl     %0,28"
> > +             : "=d" (rc)
> > +             : "d" (reg1), "a" (addr), "m" (*addr) : "memory", "cc");
> > +
> >       s390_reset_pgm_handler = NULL;
> >       if (pgm_check_occured)
> >               return -EIO;
> 
> 
> Can't you just put a barrier() before the stsch() call?

Yes, that would work too and would look much nicer.

I think we should change the reset program check handler, so that it searches
the exception tables. At least for in-kernel addresses that should work.
For addresses within modules this might cause deadlocks, since the module
code takes spinlocks and we are in a context where we just killed all cpus
not knowing what they executed... Hmm..
