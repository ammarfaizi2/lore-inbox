Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269748AbRHDB02>; Fri, 3 Aug 2001 21:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269745AbRHDB0S>; Fri, 3 Aug 2001 21:26:18 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:64908 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S269747AbRHDB0G>; Fri, 3 Aug 2001 21:26:06 -0400
Message-ID: <3B6B50C4.D9FBF398@kegel.com>
Date: Fri, 03 Aug 2001 18:32:52 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Smith <x@xman.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michael Elkins <me@toesinperil.com>, Zach Brown <zab@zabbo.net>
Subject: sigopen() vs. /dev/sigtimedwait
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I've been thinking about the sigopen() system call I proposed.
(To recap: sigopen() would let you use read() instead of sigwaitinfo()
 to retrieve lots of realtime signals at one go, AND would
 protect your signal from being swiped by hostile code elsewhere
 in the application, a la Sun's JDK.)

Upon further consideration, maybe I should model it after
/dev/epoll.  That would get rid of nagging questions like
"but read() can't leave holes like sigtimedwait could",
and would be even higher performance than read()
(see graphs at http://www.xmailserver.org/linux-patches/nio-improve.html )

So I'm proposing the following user story:

  // open a fd linked to signal mysignum
  int fd = open("/dev/sigtimedwait", O_RDWR);
  int sigs[1]; sigs[0] = mysignum;
  write(fd, sigs, sizeof(sigs[0]));

  // memory map a result buffer
  struct siginfo_t *map = mmap(NULL, mapsize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);

  for (;;) {
      // grab recent siginfo_t's
      struct devsiginfo dsi;
      dsi.dsi_nsis = 1000;
      dsi.dsi_sis = NULL;      // NULL means "use map instead of buffer"
      dsi.dsi_timeout = 1;
      int nsis = ioctl(fd, DS_SIGTIMEDWAIT, &dvp);   

      // use 'em.  Some might be completion notifications; some might be readiness notifications.
      for (i=0; i<nsis; i++)
          handle_siginfo(map+i);
  }

Sure, the interface is crap, but it's fast, and at least it doesn't
add any syscalls (the sigopen() proposal required two new syscalls: sigopen()
and timedread()).

Comments?

BTW I'm halfway thru "Understanding the Linux Kernel" and it's
a very good read (modulo some strange lingo, e.g. "cycle" for "loop"
and "table" for "record" or "struct").
So since I only halfway understand the linux kernel, the above proposal
may be half baked.
- Dan

-- 
"I have seen the future, and it licks itself clean." -- Bucky Katt
