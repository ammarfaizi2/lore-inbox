Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274271AbRISXc3>; Wed, 19 Sep 2001 19:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274269AbRISXcU>; Wed, 19 Sep 2001 19:32:20 -0400
Received: from c007-h008.c007.snv.cp.net ([209.228.33.214]:13567 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S274270AbRISXcD>;
	Wed, 19 Sep 2001 19:32:03 -0400
X-Sent: 19 Sep 2001 23:32:21 GMT
Message-ID: <3BA92939.60AEE7DA@distributopia.com>
Date: Wed, 19 Sep 2001 18:24:41 -0500
From: "Christopher K. St. John" <cks@distributopia.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Davide Libenzi <davidel@xmailserver.org>, Dan Kegel <dank@kegel.com>
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010919151147.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> 1)      select()/poll();
> 2)      recv()/send();
> 
> vs :
> 
> 1)      if (recv()/send() == FAIL)
> 2)              ioctl(EP_POLL);
> 
> When there's no data/tx buffer full these will result in 2 syscalls while
> if data is available/tx buffer ok the first method will result in 2 syscalls
> while the second will never call the ioctl().
> It looks very linear to me, with select()/poll() you're asking for a state while
> with /dev/epoll you're asking for a state change.
> 

 Ok, if we're just disagreeing about the best api,
then I can live with that. But it appears we're
talking at cross-purposes, so I want to try this one
more time. I'll lay my though processes out in detail,
and you can tell me at which step I'm going wrong:


 Normally, you'd spend most of your time sitting in
ioctl(EP_POLL) waiting for something to happen. So
that's one syscall.

 If you get an event that indicates you can accept()
a new connection, then you do an accept(). Assume it
succeeds. That's two syscalls. Then you register
interest in the fd with a write to /dev/poll, that's
three.

 With the current /dev/epoll, you must try to read()
the new socket before you go back to ioctl(EP_POLL),
just in case there is data available. You expect
there isn't, but you have to try. This is the step
I'm talking about. That's four.

 Assume data was not available, so you loop back
to ioctl(EP_POLL) and wait for an event. That's five
syscalls. The event comes in, you do another read()
on the socket, and probably get some data. That's
six syscalls to finally get your data.

 ioctl(kpfd, EP_POLL)	1     wait for events
 s = accept()           2     accept a new socket
 write(kpfd, s)         3     register interest
 n = read(s)            4 <-- annoying test-read
 ioctl(kpfd, EP_POLL)   5     wait for events
 n = read(s)            6     get some data

 You have a similiar problem with write's, but I'm
guessing it's safe to assume the first write will
always succeed, so it's awkward but not a big
problem.

 If /dev/epoll tested the initial state of the socket,
then there would be no need for the test read:

 ioctl(kpfd, EP_POLL)	1     wait for events
 s = accept()		2     accept a new socket
 write(kpfd, s)		3     register interest
 ioctl(kpfd, EP_POLL)	4     wait for events
 n = read(s)		5     get some data

 So, we've saved a syscall and, perhaps more importantly,
we don't have to keep a list of to-be-read-just-in-case
fd's sitting around. I wouldrather make this a "clean
api" argument than a performance argument, since it's
unclear that there is really any significant speed
difference in practice.

 Note that the number of unnecessary syscalls is much
greater than 20%, since on a heavily loaded server, you
could be doing 1000's of unecessary reads for every
ioctl(EP_POLL).

 On a fast local network you'd expect the test reads
to mostly return something, so it's no big deal. But
if you've got 10k very slow connections...

 There's a good summary of the problem in the Banga,
Mogul and Druschel[1] paper at:

  http://citeseer.nj.nec.com/banga99scalable.html

 Page 5, right hand column, third paragraph.

 By the way, thanks for the patch. I know I've been
complaining about it, but I wouldn't have bothered
unless I thought it was a good thing. I appreciate
your taking the time to write and release it.


-- 
Christopher St. John cks@distributopia.com
DistribuTopia http://www.distributopia.com
