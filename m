Return-Path: <linux-kernel-owner+w=401wt.eu-S965307AbXAHJxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965307AbXAHJxc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 04:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbXAHJxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 04:53:32 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:18458 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965307AbXAHJxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 04:53:31 -0500
In-Reply-To: <20061231122203.GA11633@osiris.ibm.com>
Subject: Re: [S390] cio: fix stsch_reset.
To: heicars2@linux.vnet.ibm.com
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       mschwid2@linux.vnet.ibm.com
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF1F9F8563.7DAF2D31-ON4125725D.0035EA2F-4125725D.003662B6@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Mon, 8 Jan 2007 10:54:02 +0100
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF882 | September 26, 2006) at
 08/01/2007 10:53:28
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

heicars2@linux.vnet.ibm.com wrote on 12/31/2006 01:22:03 PM:

> On Sun, Dec 31, 2006 at 01:31:43AM -0500, Chuck Ebbert wrote:
> > In-Reply-To: <20061228103925.GB6270@skybase>
> >
> > On Thu, 28 Dec 2006 11:39:25 +0100, Martin Schwidefsky wrote:
> >
> > > @@ -881,10 +880,18 @@ static void cio_reset_pgm_check_handler(
> > >  static int stsch_reset(struct subchannel_id schid, volatile
> struct schib *addr)
> > >  {
> > >       int rc;
> > > +     register struct subchannel_id reg1 asm ("1") = schid;
> > >
> > >       pgm_check_occured = 0;
> > >       s390_reset_pgm_handler = cio_reset_pgm_check_handler;
> > > -     rc = stsch(schid, addr);
> > > +
> > > +     asm volatile(
> > > +             "       stsch   0(%2)\n"
> > > +             "       ipm     %0\n"
> > > +             "       srl     %0,28"
> > > +             : "=d" (rc)
> > > +             : "d" (reg1), "a" (addr), "m" (*addr) : "memory",
"cc");
> > > +
> > >       s390_reset_pgm_handler = NULL;
> > >       if (pgm_check_occured)
> > >               return -EIO;
> >
> >
> > Can't you just put a barrier() before the stsch() call?
>
> Yes, that would work too and would look much nicer.
>
> I think we should change the reset program check handler, so that it
searches
> the exception tables.

I think that this is really overkill, since having program checks in the
reset case will be VERY rare and stsch will probably the only case.
I would do that only, if we have a component, which needs that.

And I assume, that this will never happen!

Michael


