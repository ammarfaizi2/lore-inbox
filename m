Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbVHYO6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVHYO6I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVHYO6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:58:07 -0400
Received: from mail.shareable.org ([81.29.64.88]:56505 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1751074AbVHYO6G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:58:06 -0400
Date: Thu, 25 Aug 2005 15:57:50 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cifs-client@lists.samba.org,
       Asser =?iso-8859-1?Q?Fem=F8?= <asser@diku.dk>
Subject: Re: dnotify/inotify and vfs questions
Message-ID: <20050825145750.GA6658@mail.shareable.org>
References: <20050823130023.GB8305@diku.dk> <20050823152331.GA10486@mail.shareable.org> <1124973618.17190.9.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124973618.17190.9.camel@icampbell-debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell wrote:
> On Tue, 2005-08-23 at 16:23 +0100, Jamie Lokier wrote:
> >     <receive some request>...
> >     if (any_dnotify_or_inotify_events_pending) {
> >         read_dnotify_or_inotify_events();
> >         if (any_events_related_to(file)) {
> >             store_in_userspace_stat_cache(file, stat(file));
> >         }
> >     }
> >     stat_info = lookup_userspace_stat_cache(file);
> > 
> > Now that's a silly way to save one system call in the fast path by itself.
> 
> I'm not that familiar with inotify internals but doesn't
> read_dnotify_or_inotify_events() or
> any_dnotify_or_inotify_events_pending() involve a syscall?

The fast path is just any_dnotify_or_inotify_events_pending: there
aren't any relevant events pending in the fast path.

There's a few methods of doing this for free per individual stat cache check.

1. Signal handler.

    dnotify: Check a variable set by the signal handler.

         [ There's a small time window between dnotify sending the
         signal and the receiving thread noticing on an SMP system due
         to the IPI, during which the sending task might have another
         way to signal the recieving task that it's finished some
         operation, so this method of using dnotify to invalidate a
         stat cache only has the correct ordering properties on UP systems. ]

         This works because dnotify signals are thread-specific,
         so the checking thread will definitely have received the
         signal after the time another process modifies the file.
         
    inotify: Disappointingly inotify doesn't support SIGIO readiness :(

2. If you have to mix the test with a poll/select/epoll/rtsig fd waiting
   for some other purpose.  For example: a file/web/local server, where the
   constraint is only that each stat() to revalidate a cached response
   appears to happen any time after the beginning of receiving the
   network request is known.

    dnotify: It's free if you were using sigtimedwait anyway for I/O events,
             provided you completely read the queue, or get the signal
             priority right.

    inotify: It's free if you were using poll/select/epoll anyway for I/O
             events, provided in the case of epoll that you completely
             read the queue, or use a two-level queue.

3. Amortising the test over many stat cache checks.

   Even if you must use a system call to check for any pending events,
   for revalidating an object which depends on multiple files, only
   one call is needed for all of the stat cache checks.

   More generally (this is more flexible), you can separate the notion
   of "cache time checkpoint" from "cache validation".  It's enough to
   know that a stat result was valid any time between the checkpoint
   time, and the current time.  That's how I'm implementing the
   file/web/local server case described above in step 2.  Then the
   events only need to be checked once during that time interval, no
   matter how many complex objects are being revalidated.

   It gets slightly more efficient when you have multiple, overlapping
   checkpoint->validation time intervals due to multiple outstanding
   requests being processed concurrently.

As I explained in the previous mail, all this is absolutely pointless
to save one system call.  It's a lot of work for negligable gain.

The point is when it saves lots of calls and userspace logic together,
for things like web page templates and compiled programs, which depend
on many files which can be revalidated in a small number of operations.

-- Jamie
