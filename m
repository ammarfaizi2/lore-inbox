Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317605AbSGOTKb>; Mon, 15 Jul 2002 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSGOTKa>; Mon, 15 Jul 2002 15:10:30 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:760 "EHLO egghead.curl.com")
	by vger.kernel.org with ESMTP id <S317605AbSGOTK3>;
	Mon, 15 Jul 2002 15:10:29 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
References: <20020712162306$aa7d@traf.lcs.mit.edu> <s5gsn2lt3ro.fsf@egghead.curl.com> <20020715173337$acad@traf.lcs.mit.edu>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 15 Jul 2002 15:13:24 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/20020715173337$acad@traf.lcs.mit.edu>
Message-ID: <s5gsn2kst2j.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> writes:

> > One other thing.  I think this statement is misleading:
> > 
> >     IF your server is stable and not prone to crashing, and/or you
> >     have the write cache on your hard drives battery backed, you
> >     should strongly consider using the writeback journaling mode of
> >     Ext3 versus ordered.
> > 
> > This makes it sound like data=writeback is somehow unsafe when
> > machines crash.  I do not think this is true.  If your application
> > (e.g., Postfix) is written correctly (which it is), so it calls
> > fsync() when it is supposed to, then data=writeback is *exactly* as
> > safe as any other journalling mode.  
> 
> Almost.  data=writeback makes it possible for the old contents of a
> block to end up in a newly grown file.

Only if the application is already broken.

> There are a few ways this can screw you up:
> 
> 1) that newly grown file is someone's inbox, and the old contents of the
> new block include someone else's private message.
>
> 2) That newly grown file is a control file for the application, and the
> application expects it to contain valid data within (think sendmail).  

In a correctly-written application, neither of these things can
happen.  (See my earlier message today on fsync() and MTAs.)  To get a
file onto disk reliably, the application must 1) flush the data, and
then 2) flush a "validity" indicator.  This could be a sequence like:

  create temp file
  flush data to temp file
  rename temp file
  flush rename operation

In this sequence, the file's existence under a particular name is the
indicator of its validity.

If you skip either of these flush operations, you are not behaving
reliably.  Skipping the first flush means the validity indicator might
hit the disk before the data; so after a crash, you might see invalid
data in an allegedly valid file.  Skipping the second flush means you
do not know that the validity indicator has been set, so you cannot
report success to whoever is waiting for this "reliable write" to
happen.

It is possible to make an application which relies on data=ordered
semantics; for example, skipping the "flush data to temp file" step
above.  But such an application would be broken for every version of
Unix *except* Linux in data=ordered mode.  I would call that an
incorrect application.

> Nope, battery backed caches don't make data=writeback more or less safe
> (with respect to the data anyway).  They do make data=ordered and
> data=journal more safe.

A theorist would say that "more safe" is a sloppy concept.  Either an
operation is safe or it is not.  As I said in my last message,
data=ordered (and data=journal) can reduce the risk for poorly written
apps.  But they cannot eliminate that risk, and for a correctly
written app, data=writeback is 100% as safe.

 - Pat
