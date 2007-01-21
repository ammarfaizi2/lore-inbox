Return-Path: <linux-kernel-owner+w=401wt.eu-S1751469AbXAUUEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbXAUUEb (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 15:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXAUUEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 15:04:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:26159 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbXAUUEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 15:04:30 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=I/8BuJ+WAcT+Kc27nQF8WipedhaFK5sgDa0C5kI1bW8ojwUk+vVayleE7WP+SbnXInBzuvQ36Ou+LjYhop/psRVsSFFNsv6LxrPeB8sUvCa7UIWdlNmq9UhjC05dQpSSf/dHrXrwZQsaAsP8w2Iv/XMg68GKs9Q7k7RNW7G2SkA=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: O_DIRECT question
Date: Sun, 21 Jan 2007 21:02:42 +0100
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <200701210005.36274.vda.linux@googlemail.com> <45B3580F.7040407@tls.msk.ru>
In-Reply-To: <45B3580F.7040407@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701212102.43028.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 January 2007 13:09, Michael Tokarev wrote:
> Denis Vlasenko wrote:
> > On Saturday 20 January 2007 21:55, Michael Tokarev wrote:
> >> Denis Vlasenko wrote:
> >>> On Thursday 11 January 2007 18:13, Michael Tokarev wrote:
> >>>> example, which isn't quite possible now from userspace.  But as long as
> >>>> O_DIRECT actually writes data before returning from write() call (as it
> >>>> seems to be the case at least with a normal filesystem on a real block
> >>>> device - I don't touch corner cases like nfs here), it's pretty much
> >>>> THE ideal solution, at least from the application (developer) standpoint.
> >>> Why do you want to wait while 100 megs of data are being written?
> >>> You _have to_ have threaded db code in order to not waste
> >>> gobs of CPU time on UP + even with that you eat context switch
> >>> penalty anyway.
> >> Usually it's done using aio ;)
> >>
> >> It's not that simple really.
> >>
> >> For reads, you have to wait for the data anyway before doing something
> >> with it.  Omiting reads for now.
> > 
> > Really? All 100 megs _at once_? Linus described fairly simple (conceptually)
> > idea here: http://lkml.org/lkml/2002/5/11/58
> > In short, page-aligned read buffer can be just unmapped,
> > with page fault handler catching accesses to yet-unread data.
> > As data comes from disk, it gets mapped back in process'
> > address space.
> 
> > This way read() returns almost immediately and CPU is free to do
> > something useful.
> 
> And what the application does during that page fault?  Waits for the read
> to actually complete?  How it's different from a regular (direct or not)
> read?

The difference is that you block exactly when you try to access
data which is not there yet, not sooner (potentially much sooner).

If application (e.g. database) needs to know whether data is _really_ there,
it should use aio_read (or something better, something which doesn't use signals.
Do we have this 'something'? I honestly don't know).

In some cases, evne this is not needed because you don't have any other
things to do, so you just do read() (which returns early), and chew on
data. If your CPU is fast enough and processing of data is light enough
so that it outruns disk - big deal, you block in page fault handler
whenever a page is not read for you in time.
If CPU isn't fast enough, your CPU and disk subsystem are nicely working
in parallel.

With O_DIRECT, you alternate:
"CPU is idle, disk is working" / "CPU is working, disk is idle".

> Well, it IS different: now we can't predict *when* exactly we'll sleep waiting
> for the read to complete.  And also, now we're in an unknown-corner-case when
> an I/O error occurs, too (I/O errors iteracts badly with things like mmap, and
> this looks more like mmap than like actual read).
> 
> Yes, this way we'll fix the problems in current O_DIRECT way of doing things -
> all those rases and design stupidity etc.  Yes it may work, provided those
> "corner cases" like I/O errors problems will be fixed.

What do you want to do on I/O error? I guess you cannot do much -
any sensible db will shutdown itself. When your data storage
starts to fail, it's pointless to continue running.

You do not need to know which read() exactly failed due to bad disk.
Filename and offset from the start is enough. Right?

So, SIGIO/SIGBUS can provide that, and if your handler is of
	void (*sa_sigaction)(int, siginfo_t *, void *);
style, you can get fd, memory address of the fault, etc.
Probably kernel can even pass file offset somewhere in siginfo_t...

> And yes, sometimes 
> it's not really that interesting to know when exactly we'll sleep actually
> waiting for the I/O - during read or during some memory access...

It differs from performance perspective, as dicussed above.

> There may be other reasons to "want" those extra context switches.
> I mentioned above that oracle doesn't use threads, but processes.

You can still be multithreaded. The point is, with O_DIRECT
you _are forced_ to_ be_ multithreaded, or else perfomance will suck.

> > Assume that we have "clever writes" like Linus described.
> > 
> > /* something like "caching i/o over this fd is mostly useless" */
> > /* (looks like this API is easier to transition to
> >  * than fadvise etc. - it's "looks like" O_DIRECT) */
> > 	fd = open(..., flags|O_STREAM);
> >         ...
> > /* Starts writeout immediately due to O_STREAM,
> >  * marks buf100meg's pages R/O to catch modifications,
> >  * but doesn't block! */
> > 	write(fd, buf100meg, 100*1024*1024);
> 
> And how do we know when the write completes?
> 
> > /* We are free to do something useful in parallel */
> > 	sort();
> 
> .. which is done in another process, already started.

You think "Oracle". But this application may very well be
not Oracle, but diff, or dd, or KMail. I don't want to care.
I want all big writes to be efficient, not just those done by Oracle.
*Including* single threaded ones.

> > Why we bothered to write Linux at all?
> > There were other Unixes which worked ok.
> 
> Denis, please realize - I'm not an "oracle guy" (or "database guy" or whatever).
> I'm not really a developer even - mostly a sysadmin (but I wrote some software,
> and designed some (fairy small) APIs too - not kernel work, but still).  I have
> some good expirience with running oracle stuff (and by the way, I hate it due to
> many different reasons, but due to other, including historical (there's many code
> which has been written and which works with this damn thing) reasons I'm sorta
> stuck with it for some (more) time).

Well, I too currently work with Oracle.
Apparently people who wrote damn thing have very, eh, Oracle-centric
world-view. "We want direct writes to the disk. Period." Why? Does it
makes sense? Are there better ways? - nothing. They think they know better.

(And let's not even start on why oracle ignores SIGTERM. Apparently Unix
rules aren't for them. They're too big to play by rules.)
--
vda
