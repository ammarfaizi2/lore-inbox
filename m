Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269761AbRHDCEK>; Fri, 3 Aug 2001 22:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269762AbRHDCD7>; Fri, 3 Aug 2001 22:03:59 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:32171 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S269761AbRHDCDs>; Fri, 3 Aug 2001 22:03:48 -0400
Message-ID: <3B6B59AF.9826F928@kegel.com>
Date: Fri, 03 Aug 2001 19:10:55 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petru Paler <ppetru@ppetru.net>
CC: Christopher Smith <x@xman.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zach Brown <zab@zabbo.net>
Subject: Re: sigopen() vs. /dev/sigtimedwait
In-Reply-To: <3B6B50C4.D9FBF398@kegel.com> <20010803183853.H1080@ppetru.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petru Paler wrote:
> 
> On Fri, Aug 03, 2001 at 06:32:52PM -0700, Dan Kegel wrote:
> > So I'm proposing the following user story:
> >
> >   // open a fd linked to signal mysignum
> >   int fd = open("/dev/sigtimedwait", O_RDWR);
> >   int sigs[1]; sigs[0] = mysignum;
> >   write(fd, sigs, sizeof(sigs[0]));
> >
> >   // memory map a result buffer
> >   struct siginfo_t *map = mmap(NULL, mapsize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> >
> >   for (;;) {
> >       // grab recent siginfo_t's
> >       struct devsiginfo dsi;
> >       dsi.dsi_nsis = 1000;
> >       dsi.dsi_sis = NULL;      // NULL means "use map instead of buffer"
> >       dsi.dsi_timeout = 1;
> >       int nsis = ioctl(fd, DS_SIGTIMEDWAIT, &dvp);
> >
> >       // use 'em.  Some might be completion notifications; some might be readiness notifications.
> >       for (i=0; i<nsis; i++)
> >           handle_siginfo(map+i);
> >   }
> 
> And the advantage of this over /dev/epoll would be that you don't have to
> explicitly add/remove fd's?

The advantage is that it can be used to collect
completion notifications for aio.  (It can also be
used to collect readiness notification via either
linux's traditional rtsig stuff, or the signal-per-fd stuff,
so this unifies readiness notification and completion notification,
in case you happen to want to use both in the same thread.)
 
> I ask because yesterday I used /dev/epoll in a project and it behaves *very*
> well, so I'm wondering what advantages your interface would bring.

I am a huge fan of /dev/epoll and would like to see it integrated
into the ac series.  /dev/epoll doesn't address the needs of those
who are doing aio, though.
 
> How do you handle signal queue overflow? signal-per-fd helps, but you still
> have to have the queue as big as the maximum number of fds is...

I am not addressing that issue.  However, when doing aio, the
application can simply avoid issuing more than N I/O operations,
where N is comfortably lower than the current size of the signal queue.

When I get around to reading the kernel source finally, maybe I'll
have a look at what the costs of large signal queues are.

- Dan

-- 
"I have seen the future, and it licks itself clean." -- Bucky Katt
