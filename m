Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317642AbSGOVWV>; Mon, 15 Jul 2002 17:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317643AbSGOVWV>; Mon, 15 Jul 2002 17:22:21 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:3059 "EHLO
	egghead.curl.com") by vger.kernel.org with ESMTP id <S317642AbSGOVWU>;
	Mon, 15 Jul 2002 17:22:20 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
References: <20020712162306$aa7d@traf.lcs.mit.edu> <s5gsn2lt3ro.fsf@egghead.curl.com> <20020715173337$acad@traf.lcs.mit.edu> <s5gsn2kst2j.fsf@egghead.curl.com> <20020715205505.GC30630@merlin.emma.line.org>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 15 Jul 2002 17:23:53 -0400
In-Reply-To: <20020715205505.GC30630@merlin.emma.line.org>
Message-ID: <s5g7kjwsn12.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

> I assume that most will just call close() or fclose() and exit() right
> away. Does fclose() imply fsync()? 

Not according to my close(2) man page:

       A successful close does not guarantee that  the  data  has
       been  successfully  saved  to  disk,  as the kernel defers
       writes. It is not common for a  filesystem  to  flush  the
       buffers  when the stream is closed. If you need to be sure
       that the data is physically stored use fsync(2).  (It will
       depend on the disk hardware at this point.)

Note that this means writing a truly reliable shell or Perl script is
tricky.  I suppose you can "use POSIX qw(fsync);" in Perl.  But what
do you do for a shell script?  /bin/sync :-) ?

> Some applications will not even check the [f]close() return value...

Such applications are broken, of course.

> > It is possible to make an application which relies on data=ordered
> > semantics; for example, skipping the "flush data to temp file" step
> > above.  But such an application would be broken for every version of
> > Unix *except* Linux in data=ordered mode.  I would call that an
> > incorrect application.
> 
> Or very specific, at least.

Hm.  Does BSD with soft updates guarantee anything about write
ordering on fsync()?  In particular, does it promise to commit the
data before the metadata?

> > A theorist would say that "more safe" is a sloppy concept.  Either an
> > operation is safe or it is not.  As I said in my last message,
> > data=ordered (and data=journal) can reduce the risk for poorly written
> > apps.  But they cannot eliminate that risk, and for a correctly
> > written app, data=writeback is 100% as safe.
> 
> IF that application uses a marker to mark completion. If it does not,
> data=ordered will be the safe bet, regardless of fsync() or not. The
> machine can crash BEFORE the fsync() is called.

Without marking completion, there is no safe bet.  Without calling
fsync(), you *never* know when the data will hit the disk.  It is very
hard to build a reliable system that way...  For an MTA, for example,
you can never safely inform the remote mailer that you have accepted
the message.  But this problem goes beyond MTAs; very few applications
live in a vacuum.

Reliable systems are tricky.  I guess this is why Oracle and Sybase
make all that money.

 - Pat
