Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270703AbRHKDDx>; Fri, 10 Aug 2001 23:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270704AbRHKDDd>; Fri, 10 Aug 2001 23:03:33 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:57048 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S270703AbRHKDDb>; Fri, 10 Aug 2001 23:03:31 -0400
Message-ID: <3B74A274.FB34AF2C@kegel.com>
Date: Fri, 10 Aug 2001 20:11:48 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David E. Weekly" <dweekly@legato.com>
Subject: Re: Efficient Event Handling In Linux?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David E. Weekly" <dweekly@legato.com> wrote:
> Hey all. I've been looking at efficient event-handling mechanisms (for I/O
> on sockets, disk, devices) ... As far as I could tell ... the discussion 
> [on linux-kernel] trailed off without any real resolution as to what
> would actually be done to empower Linux with efficient event handling;
> perhaps I missed it, but I couldn't find Linus's get_events/bind_event
> calls, nor could I find /dev/poll or kqueue-styled interfaces integrated
> into the latest kernel.
> I did find what looks to be an excellent patch in the way of /dev/epoll
> (written up here:
> http://www.xmailserver.org/linux-patches/nio-improve.html). According to the
> benchmarks he's got, the patch really spanks /dev/poll and POSIX SIGIO. I'm
> going to begin testing with it soon and was hoping to get some feel for
> whether /dev/epoll might end up in the kernel mainstream at some point in
> the not-too-distant future? 

My impression is that /dev/epoll is the best for sockets at the moment, and 
that several people are using it happily now.  (The interface is
still in flux, I think, so only use it now if you don't mind that.)

However, for disk I/O, IMHO you really want aio instead.
If you need aio now, SGI's kaio patch is available and is said to work well 
(and heck, there's also a userland emulation in glibc, but I 
suspect it doesn't perform well).
For the future, Ben LaHaise's aio may have better performance when it's done
( http://uwsg.iu.edu/hypermail/linux/kernel/0102.0/0459.html );
he's going to do things like async sendfile, and is willing to provide a nonposix
interface for those who don't want signal delivery's overhead
(see http://uwsg.iu.edu/hypermail/linux/kernel/0102.0/0384.html
and http://www.kvack.org/~blah/aio/v2.4.5-ac9-bcrl4-aio.diff )

I suspect both /dev/epoll and LaHaise's aio will end up being integrated 
into the stock 2.5 kernel.  And if we're really lucky, there will be 
a single integrated event stream for both.  I'm quite annoyed
that Posix defines separate polling methods for file descriptors
and aio completions (http://www.opengroup.org/onlinepubs/7908799/xsh/aio_suspend.html);
if one simple interface can handle both, we ought to try to do it.

- Dan "but I play one on TV" Kegel

-- 
"Computers are state machines.
 Threads are for people who can't program state machines."  - Alan Cox
