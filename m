Return-Path: <linux-kernel-owner+w=401wt.eu-S933148AbWLaMHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933148AbWLaMHl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 07:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933147AbWLaMHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 07:07:41 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:61949 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933149AbWLaMHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 07:07:40 -0500
Subject: Re: [S390] cio: fix stsch_reset.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Michael Holzheu <holzheu@de.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200612310135_MC3-1-D6D0-A862@compuserve.com>
References: <200612310135_MC3-1-D6D0-A862@compuserve.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Sun, 31 Dec 2006 13:07:25 +0100
Message-Id: <1167566845.27664.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-31 at 01:31 -0500, Chuck Ebbert wrote:
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

You mean after. We have to prevent the sequence
1) load pgm_check_occured,
2) stsch and the execution of cio_reset_pgm_check_handler
3) use of the the value loaded in 1)
A barrier before 2) forces a reload of pgm_check_occured but it does not
force the reload to be before the stsch call.

But the basic idea is valid. The standard stsch() inline followed by a
barrier() is equivalent to the new inline assembly.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


