Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271687AbRIOBd7>; Fri, 14 Sep 2001 21:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271711AbRIOBdj>; Fri, 14 Sep 2001 21:33:39 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:45506 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S271687AbRIOBdd>; Fri, 14 Sep 2001 21:33:33 -0400
Message-ID: <3BA2AFFF.C7B8C4DF@kegel.com>
Date: Fri, 14 Sep 2001 18:33:51 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-sig i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitaly Luban <vitaly@luban.org>
Subject: Re: [PATCH][RFC] Signal-per-fd for RT signals
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Luban <vitaly@luban.org> wrote:
> Attached patch is an implementation of "signal-per-fd" 
> enhancement to kernel RT signal mechanism, AFAIK first 
> proposed by A. Chandra and D. Mosberger ...
> which should dramatically increase linux based network 
> servers scalability. 
> [ Patch lives at http://www.luban.org/GPL/gpl.html ]

I have been using variations on this patch while trying
to benchmark an FTP server at a load of 10000 simultaneous
sessions (at 1 kilobyte/sec each), and noticed a few issues:

1. If a SIGINT comes in, t->files may be null, so where
   send_signal() says
         if( (info->si_fd < files->max_fds) &&
   it should say
         if( files && (info->si_fd < files->max_fds) &&
   otherwise there will be a null pointer oops.

2. If a signal has come in, and a reference to it is left
   in filp->f_infoptr, and for some reason the signal is
   removed from the queue without going through collect_signal(),
   a stale pointer may be left in filp->f_infoptr, which could
   cause a wild pointer oops.  There are two places this can happen:
   a. if send_signal() returns -EAGAIN because we're out of memory or queue space
   b. if user sets the signal handler to SIG_IGN, triggering a call 
   to rm_sig_from_queue()

I have seen the above problems in the field in my version of the patch, 
and written and tested fixes for them.  (Ah, the joys of ksymoops.)

3. Any reference to t->files probably needs to be protected by
   acquiring t->files->file_lock, else when the file table is
   expanded, any filp in use will become stale.

I have seen this problem in my version of the patch, but have not yet tackled it.
Is there any good guidance out there for how the various spinlocks
interact?  Documentation/spinlocks.txt and Documentation/DocBook/kernel-locking.tmpl 
are the best I've seen so far, but they don't get into specifics about, say,
files->file_lock and task->sigmask_lock.  Guess I'll just have to read the source.

Also, while I have verified that the patch significantly reduces 
reliable signal queue usage, I have not yet been able to measure
a reduction in CPU time in a real app.  Presumably the benefits
are in response time, which I am not set up to measure yet.

This is my first excursion into the kernel, so please be gentle.
- Dan
