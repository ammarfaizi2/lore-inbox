Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269757AbRHDBkI>; Fri, 3 Aug 2001 21:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269753AbRHDBj6>; Fri, 3 Aug 2001 21:39:58 -0400
Received: from dnai-216-15-62-124.cust.dnai.com ([216.15.62.124]:56301 "HELO
	soni.ppetru.net") by vger.kernel.org with SMTP id <S269750AbRHDBjo>;
	Fri, 3 Aug 2001 21:39:44 -0400
Date: Fri, 3 Aug 2001 18:38:53 -0700
To: Dan Kegel <dank@kegel.com>
Cc: Christopher Smith <x@xman.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Elkins <me@toesinperil.com>, Zach Brown <zab@zabbo.net>
Subject: Re: sigopen() vs. /dev/sigtimedwait
Message-ID: <20010803183853.H1080@ppetru.net>
In-Reply-To: <3B6B50C4.D9FBF398@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B6B50C4.D9FBF398@kegel.com>
User-Agent: Mutt/1.3.20i
From: ppetru@ppetru.net (Petru Paler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 06:32:52PM -0700, Dan Kegel wrote:
> So I'm proposing the following user story:
> 
>   // open a fd linked to signal mysignum
>   int fd = open("/dev/sigtimedwait", O_RDWR);
>   int sigs[1]; sigs[0] = mysignum;
>   write(fd, sigs, sizeof(sigs[0]));
> 
>   // memory map a result buffer
>   struct siginfo_t *map = mmap(NULL, mapsize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> 
>   for (;;) {
>       // grab recent siginfo_t's
>       struct devsiginfo dsi;
>       dsi.dsi_nsis = 1000;
>       dsi.dsi_sis = NULL;      // NULL means "use map instead of buffer"
>       dsi.dsi_timeout = 1;
>       int nsis = ioctl(fd, DS_SIGTIMEDWAIT, &dvp);   
> 
>       // use 'em.  Some might be completion notifications; some might be readiness notifications.
>       for (i=0; i<nsis; i++)
>           handle_siginfo(map+i);
>   }

And the advantage of this over /dev/epoll would be that you don't have to
explicitly add/remove fd's?

I ask because yesterday I used /dev/epoll in a project and it behaves *very*
well, so I'm wondering what advantages your interface would bring.

> Comments?

How do you handle signal queue overflow? signal-per-fd helps, but you still
have to have the queue as big as the maximum number of fds is...

Petru
