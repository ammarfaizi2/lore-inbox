Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbRCQLuB>; Sat, 17 Mar 2001 06:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbRCQLtv>; Sat, 17 Mar 2001 06:49:51 -0500
Received: from ns1.samba.org ([203.17.0.92]:65073 "HELO au2.samba.org")
	by vger.kernel.org with SMTP id <S131626AbRCQLtn>;
	Sat, 17 Mar 2001 06:49:43 -0500
From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15027.20462.682109.679714@argo.linuxcare.com.au>
Date: Sat, 17 Mar 2001 22:52:14 +1100 (EST)
To: buhr@stat.wisc.edu (Kevin Buhr)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: PATCH against 2.4.2: TTY hangup on PPP channel corrupts kernel memory
In-Reply-To: <vbaofv1nyza.fsf@mozart.stat.wisc.edu>
In-Reply-To: <vbaofv1nyza.fsf@mozart.stat.wisc.edu>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@linuxcare.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Buhr writes:

> If there's a hangup in the TTY layer on an async PPP channel,
> do_tty_hangup shuts down the PPP line discipline, and, in ppp_async.c,
> the function ppp_asynctty_close unregisteres the channel.  In
> ppp_generic.c, ppp_unregister_channel merrily wakes up the rwait
> queue, then proceeds to destroy the channel, freeing the "struct
> channel" which contains the "struct ppp_file" that contains the
> "wait_queue_head_t rwait".  When the waiting process wakes up, it
> removes itself from the wait queue, modifying freed memory.

But the waiting process must have had an instance of /dev/ppp open and
attached to the channel in order to be doing anything with rwait,
within either ppp_file_read or ppp_poll.  The process of attaching to
the channel increases its refcnt, meaning that the channel shouldn't
be destroyed until the instance of /dev/ppp is closed and ppp_release
is called.

Note that pppd will not be blocking inside ppp_file_read since it sets
the file descriptor non-blocking.  Most of the time pppd would be
inside a select, so rwait would be in use by the poll/select code.

I presume that the generic file descriptor code ensures that the file
release function doesn't get called while any task is inside the read
or write function for that file, or while the file descriptor is in
use in a select or poll.  If that assumption is wrong then it would
indeed be possible for the channel to be destroyed while some process
is waiting on rwait.  But in any case it shouldn't be a problem in
practice since it would only be pppd that would have the channel open
and pppd is single-threaded, i.e. it couldn't be closing the file
descriptor while it is blocked inside read or select.

So, to put it in other words, this is the sequence (simplified):

	fd = open("/dev/ppp", O_RDWR);
	ioctl(fd, PPPIOCATTCHAN, &channel_number);
	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_NONBLOCK);

	select(...);	/* fd_sets including fd */
	read(fd, ...);
	...
	close(fd);

I believe the channel structure is guaranteed to exist from the ioctl
to the close, and all the selects and reads (i.e. all the uses of
rwait) have to happen within that time interval.

> A patch against 2.4.2 follows.  I've overloaded the "refcnt" in
> "struct ppp_file" to also keep track of rwaiters.  The last refcnt
> user destroys the channel and decreases the module use count.  I've
> tested this with printks in all the right places, and it seems to fix
> the problem correctly.

I'm not sure this is the right fix, this sounds to me like the
refcounts are going awry somehow or there is an SMP race that I
haven't considered, and I am concerned that this patch will just cover
over the real problem.  Actually, given that you've seen it 4 times in
6 months it's more likely that it is an SMP race IMHO.

In any case I don't think your patch does the right thing with
ppp_poll, because poll_wait doesn't actually wait, it just adds rwait
to a list of things to watch for wakeups.  In other words, rwait will
be in use from the time poll_wait is called until the time that the
poll/select logic (in fs/select.c) decides that it's time to return to
the user.  So increasing the refcount around just the poll_wait call
won't help much.

Do you have a way to reproduce the problem at will?  Have you seen it
happen on a UP box (i.e. could it be an SMP race)?  How sure are you
that your patch really fixes the problem?

Regards,
Paul.

-- 
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Putting Open Source to work.
