Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSETSvX>; Mon, 20 May 2002 14:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316196AbSETSvW>; Mon, 20 May 2002 14:51:22 -0400
Received: from mail.zmailer.org ([62.240.94.4]:161 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S316199AbSETSvV>;
	Mon, 20 May 2002 14:51:21 -0400
Date: Mon, 20 May 2002 21:51:20 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Manik Raina <manik@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: adding counters to count bytes read/written
Message-ID: <20020520215120.P9955@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0205201506240.14394-100000@localhost.localdomain> <20020520131222.K9955@mea-ext.zmailer.org> <3CE8D80C.3A771CB1@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 04:33:40PM +0530, Manik Raina wrote:
> 	Thanks for the comments Matti, Please see inline ...
> 
> Matti Aarnio wrote:
> > On Mon, May 20, 2002 at 03:09:36PM +0530, Manik Raina wrote:
> > > Hi Linus,
> > >       This patch adds 2 counters to the task_struct for
> > >       counting how many bytes were read/written using
> > >       the read()/write() system calls.
> > >
> > >       These counters may be useful in determining how
> > >       many IO requests are made by each process.
> > 
> >   These are defined as UINTegers, are you sure that is appropriate type ?
> >   What to do when they will overflow ?  For short term activity tracking
> >   they may be ok (4GB/200 MB/sec = 20 sec to wrap around), but for accounting
> >   the overflow might not be liked thing..
> 
> 	How about 64 bit counters ? i feel those should go on without
> 	wraparound for a _very_ long time.
> 
> 	Did you have anything else in mind ?

    Considering how few registers ix86 architecture has, and
    them being 32 bit wide ones, regular (once a second ?)
    task scanning and detecting such overflows would be most
    usefull approach.  Less code, and register pressure in
    the fast path.

> >   For short-term IO-activity tracking they may indeed make sense, but I
> >   would add another pair of counters to assist on that tracking.  Namely
> >   "values at the end of previous interval", which are maintained by the
> >   activity tracking code.
> 
> 	Would this still be required if the counters are 64 bit ?

    I don't think so.   E.g. even with 1 GB/sec bandwidth (hmm..
    perhaps that is achievable in next few years..) and 32 bit
    counters it is just a matter of how frequently you scan these
    variables.  To know how much data has been moved since the
    last measurement, you need to keep the value of the previous
    scan time around.  E.g.:

        int intervalread = NN->bytes_read - NN->previous_bytes_read;
        NN->previous_bytes_read = NN->bytes_read;

    Add there code to detect when "bytes_read" has overflowed, and
    external monitoring code can then combine those components into
    64 bit quantity..  (The /proc/ printout code can do it)

> >   Reading one byte at the time won't grow those counters very fast, but will
> >   cause massive amounts of syscalls, and context switches, so tracking data
> >   amount alone isn't good enough.
> 
> 	What else would you suggest i track ?
> 	thanks
> 	Manik

   Number of syscalls,  The more your process makes syscalls, the more
   it makes context switches, but still does not consume its time quanta.
   (Consider: 100 clocks for syscall, 2.5 GHz CPU -> 25 M syscalls/sec ?)

   Use of these counters should be defined.  Mere "it would be nice to
   collect data" is not very good motivation for Linus to include the 
   code.  (Of course I would like to see all BSD facility accounting
   things when a process exits -- knowing number of X/Y/Z might sometimes
   tell me something usefull..)

   Defining some believable theory/algorithm to use these variales
   in e.g. scheduling goodness calculation..  perhaps in a form of
   "scan all processes 10 times a second for IO/syscall activity
    tuner for scheduler"

   Will the analysis truly need real-time calculation in the scheduler's
   fast-path, or can it be based on one computed scalar value which is
   updated one to ten times a second ?


/Matti Aarnio
