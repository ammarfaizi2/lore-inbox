Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274090AbRISPh4>; Wed, 19 Sep 2001 11:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274092AbRISPhr>; Wed, 19 Sep 2001 11:37:47 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:8684 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S274090AbRISPhc>; Wed, 19 Sep 2001 11:37:32 -0400
Message-ID: <3BA8BBC9.EA1D0636@kegel.com>
Date: Wed, 19 Sep 2001 08:37:45 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Christopher K. St. John" <cks@distributopia.com>
CC: linux-kernel@vger.kernel.org, davidel@xmailserver.org
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <3BA80108.C830D602@kegel.com> <3BA84367.239FA0B4@distributopia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christopher K. St. John" wrote:
>  The Banga, Mogul and Druschel[1] paper (which I understand
> was the inspiration for the Solaris /dev/poll which was the
> inspiration for /dev/epoll?) talks about having the poll
> return the current state of new descriptors. As far as I can
> tell, /dev/epoll only gives you events on state changes. So,
> for example, if you accept() a new socket and add it to the
> interest list, you (probably) won't get a POLLIN. That's
> not fatal, but it's awkward.
>...
>  My vote would be to always report the initial state, but
> that would make the driver a little more complicated.
> 
>  What are the preferred semantics?

Taking an extreme but justifiable position for discussion's sake:

Stevens [UNPV1, in chapter on nonblocking accept] suggests that readiness
notifications from the OS should only be considered hints, and that user
programs should behave properly even if the OS feeds it false readiness
events.  

Thus one possible approach would be for /dev/epoll (or users of /dev/epoll)
to assume that an fd is initially ready for all (normal) events, and just
try handling them all.  That probably involves a single system call
to read() (or possibly a call to both write() and read(), or a call to accept(),
or a call to getsockopt() in the case of nonblocking connect), so the overhead
isn't very high.

(In fact, programs that use select(), poll(), or /dev/epoll would benefit
from having a test mode where false readiness events are injected at random;
the program should continue to behave normally, perhaps with slightly increased
CPU usage.)

That said, the principle of least suprise would suggest that /dev/epoll should
indeed return an accurate initial status.  There are a lot of programmers who
don't agree with Stevens on this issue, and who write code that breaks if you
feed it incorrect readiness events.

- Dan
