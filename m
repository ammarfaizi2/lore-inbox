Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269765AbRHDC5q>; Fri, 3 Aug 2001 22:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269767AbRHDC52>; Fri, 3 Aug 2001 22:57:28 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:5336 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S269765AbRHDC5X>; Fri, 3 Aug 2001 22:57:23 -0400
Message-ID: <3B6B662F.3E83C22F@kegel.com>
Date: Fri, 03 Aug 2001 20:04:15 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petru Paler <ppetru@ppetru.net>, Christopher Smith <x@xman.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zach Brown <zab@zabbo.net>, Davide Libenzi <davidel@xmailserver.org>
Subject: Could /dev/epoll deliver aio completion notifications? (was: Re: 
 sigopen() vs. /dev/sigtimedwait)
In-Reply-To: <3B6B50C4.D9FBF398@kegel.com> <20010803183853.H1080@ppetru.net> <3B6B59AF.9826F928@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> Petru Paler wrote:
> > And the advantage of this over /dev/epoll would be that you don't have to
> > explicitly add/remove fd's?
> 
> The advantage is that it can be used to collect
> completion notifications for aio.  (It can also be
> used to collect readiness notification via either
> linux's traditional rtsig stuff, or the signal-per-fd stuff,
> so this unifies readiness notification and completion notification,
> in case you happen to want to use both in the same thread.)
> 
> > I ask because yesterday I used /dev/epoll in a project and it behaves *very*
> > well, so I'm wondering what advantages your interface would bring.
> 
> I am a huge fan of /dev/epoll and would like to see it integrated
> into the ac series.  /dev/epoll doesn't address the needs of those
> who are doing aio, though.

On the other hand, if /dev/epoll were flexible enough that it could
deliver AIO completion notifications, then /dev/sigtimedwait
would not be needed.  For instance:

// extend bits/poll.h
#define POLLAIO 0x800   // aio completion event; pollfd.fd contains aiocb *

      // open /dev/epoll and set up map as usual
      kdpfd = open("/dev/epoll", O_RDWR);
      char *map = mmap(NULL, mapsize, PROT_READ | PROT_WRITE, MAP_PRIVATE, kdpfd, 0);

      // tell our /dev/epoll fd that we're interested in events on fd diskfd
      struct pollfd pfd;
      pfd.fd = diskfd;
      pfd.events = AIOEVENT;
      pfd.revents = 0;
      write(kdpfd, &pfd, sizeof(pfd));

      // set up an asynchronous read from 'diskfd'
      struct aiocb *r = malloc(sizeof(*r));
      r->aio_filedes = diskfd;
      r->aio_... = ...
      // when read is finished, have it notify the /dev/epoll device 
      // interested in diskfd rather than sending a signal
      r->aio_sigevent.sigev_notify = SIGEV_NONE;
      aio_read(r);
      ...

      // Pick up events
      for (;;) {
          struct devpoll dvp;
          dvp.dp_nfds = 1000;
          dvp.dp_fds = NULL;      // NULL means "use map instead of buffer"
          dvp.dp_timeout = 1;
          int nevents = ioctl(kdpfd, DS_SIGTIMEDWAIT, &dvp);
          struct pollfd *result = map + dvp.result_offset;

          // use 'em.  Some might be aio completion notifications; 
          // some might be traditional poll notifications
          // (and if this is AIX, some might be sysv message queue notifications!)
          for (i=0; i<nevents; i++)
             if (result[i].revents & POLLAIO)
                  handle_aio_completion((struct aiocb *)result[i].fd);
             else 
                  handle_readiness(&result[i]);
      }

Davide, is that along the lines of what you were thinking of
for /dev/epoll and disk files?   (Plain old polling of disk
files doesn't make much sense unless you're just interested in
them growing, I suppose; aio completion notification is what you 
really want.)

- Dan

-- 
"I have seen the future, and it licks itself clean." -- Bucky Katt
