Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272074AbRIOFji>; Sat, 15 Sep 2001 01:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272072AbRIOFj2>; Sat, 15 Sep 2001 01:39:28 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:56042 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S272090AbRIOFjQ>; Sat, 15 Sep 2001 01:39:16 -0400
Message-ID: <3BA2E99A.1134E382@kegel.com>
Date: Fri, 14 Sep 2001 22:39:38 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-dan i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vitaly Luban <vitaly@luban.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Signal-per-fd for RT signals
In-Reply-To: <3BA2AFFF.C7B8C4DF@kegel.com> <3BA2E144.FB0E5D55@luban.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Luban wrote:
> Thanks Dan,
> 
> I'll modify the patch shortly according to your information.
> In fact, 2.4.6 patch is modified already according to (1)

http://www.luban.org/GPL/one-sig-perfd-2.4.6.patch still has the bug.
Perhaps you fixed a different problem?  (cf. my patch below.)
 
> Though I myself have not seen this effects, despite of heavy
> use of modified kernel, this seems logical.

If you like, I can set up a test case.

> For the case of lack queue space, just to prevent it, the
> queue size should always be set equal to max file descriptors
> number in system. Both parameters accessible via /proc, and all
> my tests are done under this setting.

I was aiming at optimizing the normal F_ASYNC, where it is
normal and expected to receive a SIGIO, which is why I ran into
it and you didn't.
 
> Unfortunately, as we are close to release time, I do not have
> enough time to complete long promised testing and patch refinement,
> but, hopefully, this will happen in october.
> 
> I'll try to add changes to deal with cases (2) and (3) shortly.
>
> Thanks again.
> 
> Vitaly.

Here's one possible oops traceback for case 3.  This happened when
testing with about 4500 ftp sessions.  Might not correspond
exactly to your code, since I was doing some Funky Stuff.
(My patch is at http://www.kegel.com/linux/onefd-dank.patch 
 It differs from yours in that I keep poll data, not pointers,
 in struct file, overload an existing struct file field to
 avoid the space penalty, and didn't bother protecting the old
 interface used by phhttpd and x15.  Not for public consumption.)

<send_signal+69/160>      <==== crash on wild pointer here
<deliver_signal+17/80>
<send_sig_info+86/b0>
<send_sigio_to_task+c5/e0>
<ip_queue_xmit+334/470>
<tcp_rcv_established+79e/7e0>
<tcp_v4_send_check+6e/b0>
<send_sigio+58/b0>
<__kill_fasync+59/70>
<sock_wake_async+72/80>
<sock_def_readable+5d/70>
<tcp_rcv_established+399/7e0>
<tcp_v4_do_rcv+3b/120>
<tcp_v4_rcv+3e4/660>
<ip_local_deliver+fa/170>
<ip_rcv+304/380>
<tulip_interrupt+618/7d0>
<net_rx_action+17b/290>
<net_tx_action+62/140>
<do_softirq+7b/e0>
<do_IRQ+dd/f0>
<ret_from_intr+0/7>
<vfs_rename_other+28/2b0>
<expand_fd_array+d6/160>
<get_unused_fd+f2/160>
<sock_map_fd+c/1c0>
<sock_create+f3/120>
<sys_socket+2d/50>
<sys_socketcall+62/200>
<system_call+33/38>

- Dan
 
> Dan Kegel wrote:
> 
> > Vitaly Luban <vitaly@luban.org> wrote:
> > > [ Patch lives at http://www.luban.org/GPL/gpl.html ]
> >
> > I have been using variations on this patch while trying
> > to benchmark an FTP server at a load of 10000 simultaneous
> > sessions (at 1 kilobyte/sec each), and noticed a few issues:
> >
> > 1. If a SIGINT comes in, t->files may be null, so where
> >    send_signal() says
> >          if( (info->si_fd < files->max_fds) &&
> >    it should say
> >          if( files && (info->si_fd < files->max_fds) &&
> >    otherwise there will be a null pointer oops.
> >
> > 2. If a signal has come in, and a reference to it is left
> >    in filp->f_infoptr, and for some reason the signal is
> >    removed from the queue without going through collect_signal(),
> >    a stale pointer may be left in filp->f_infoptr, which could
> >    cause a wild pointer oops.  There are two places this can happen:
> >    a. if send_signal() returns -EAGAIN because we're out of memory or queue space
> >    b. if user sets the signal handler to SIG_IGN, triggering a call
> >    to rm_sig_from_queue()
> >
> > I have seen the above problems in the field in my version of the patch,
> > and written and tested fixes for them.  (Ah, the joys of ksymoops.)
> >
> > 3. Any reference to t->files probably needs to be protected by
> >    acquiring t->files->file_lock, else when the file table is
> >    expanded, any filp in use will become stale.
> >
> > I have seen this problem in my version of the patch, but have not yet tackled it.
> > Is there any good guidance out there for how the various spinlocks
> > interact?  Documentation/spinlocks.txt and Documentation/DocBook/kernel-locking.tmpl
> > are the best I've seen so far, but they don't get into specifics about, say,
> > files->file_lock and task->sigmask_lock.  Guess I'll just have to read the source.
> >
> > Also, while I have verified that the patch significantly reduces
> > reliable signal queue usage, I have not yet been able to measure
> > a reduction in CPU time in a real app.  Presumably the benefits
> > are in response time, which I am not set up to measure yet.
> >
> > This is my first excursion into the kernel, so please be gentle.
> > - Dan
