Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRIOFGu>; Sat, 15 Sep 2001 01:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271032AbRIOFGl>; Sat, 15 Sep 2001 01:06:41 -0400
Received: from c1890829-a.stcla1.sfba.home.com ([24.5.220.226]:47880 "HELO
	luban.org") by vger.kernel.org with SMTP id <S268926AbRIOFG2>;
	Sat, 15 Sep 2001 01:06:28 -0400
Message-ID: <3BA2E144.FB0E5D55@luban.org>
Date: Fri, 14 Sep 2001 22:04:04 -0700
From: Vitaly Luban <vitaly@luban.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Signal-per-fd for RT signals
In-Reply-To: <3BA2AFFF.C7B8C4DF@kegel.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dan,

I'll modify the patch shortly according to your information.
In fact, 2.4.6 patch is modified already according to (1)

Though I myself have not seen this effects, despite of heavy
use of modified kernel, this seems logical.

For the case of lack queue space, just to prevent it, the
queue size should always be set equal to max file descriptors
number in system. Both parameters accessible via /proc, and all
my tests are done under this setting.

Unfortunately, as we are close to release time, I do not have
enough time to complete long promised testing and patch refinement,
but, hopefully, this will happen in october.

I'll try to add changes to deal with cases (2) and (3) shortly.

Thanks again.

Vitaly.

Dan Kegel wrote:

> Vitaly Luban <vitaly@luban.org> wrote:
> > [ Patch lives at http://www.luban.org/GPL/gpl.html ]
>
> I have been using variations on this patch while trying
> to benchmark an FTP server at a load of 10000 simultaneous
> sessions (at 1 kilobyte/sec each), and noticed a few issues:
>
> 1. If a SIGINT comes in, t->files may be null, so where
>    send_signal() says
>          if( (info->si_fd < files->max_fds) &&
>    it should say
>          if( files && (info->si_fd < files->max_fds) &&
>    otherwise there will be a null pointer oops.
>
> 2. If a signal has come in, and a reference to it is left
>    in filp->f_infoptr, and for some reason the signal is
>    removed from the queue without going through collect_signal(),
>    a stale pointer may be left in filp->f_infoptr, which could
>    cause a wild pointer oops.  There are two places this can happen:
>    a. if send_signal() returns -EAGAIN because we're out of memory or queue space
>    b. if user sets the signal handler to SIG_IGN, triggering a call
>    to rm_sig_from_queue()
>
> I have seen the above problems in the field in my version of the patch,
> and written and tested fixes for them.  (Ah, the joys of ksymoops.)
>
> 3. Any reference to t->files probably needs to be protected by
>    acquiring t->files->file_lock, else when the file table is
>    expanded, any filp in use will become stale.
>
> I have seen this problem in my version of the patch, but have not yet tackled it.
> Is there any good guidance out there for how the various spinlocks
> interact?  Documentation/spinlocks.txt and Documentation/DocBook/kernel-locking.tmpl
> are the best I've seen so far, but they don't get into specifics about, say,
> files->file_lock and task->sigmask_lock.  Guess I'll just have to read the source.
>
> Also, while I have verified that the patch significantly reduces
> reliable signal queue usage, I have not yet been able to measure
> a reduction in CPU time in a real app.  Presumably the benefits
> are in response time, which I am not set up to measure yet.
>
> This is my first excursion into the kernel, so please be gentle.
> - Dan

