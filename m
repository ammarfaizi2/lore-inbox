Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274279AbRISXs7>; Wed, 19 Sep 2001 19:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274277AbRISXsu>; Wed, 19 Sep 2001 19:48:50 -0400
Received: from [208.129.208.52] ([208.129.208.52]:13068 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274297AbRISXsl>;
	Wed, 19 Sep 2001 19:48:41 -0400
Message-ID: <XFMail.20010919165225.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BA92939.60AEE7DA@distributopia.com>
Date: Wed, 19 Sep 2001 16:52:25 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: "Christopher K. St. John" <cks@distributopia.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19-Sep-2001 Christopher K. St. John wrote:
> Davide Libenzi wrote:
>> 
>> 1)      select()/poll();
>> 2)      recv()/send();
>> 
>> vs :
>> 
>> 1)      if (recv()/send() == FAIL)
>> 2)              ioctl(EP_POLL);
>> 
>> When there's no data/tx buffer full these will result in 2 syscalls while
>> if data is available/tx buffer ok the first method will result in 2 syscalls
>> while the second will never call the ioctl().
>> It looks very linear to me, with select()/poll() you're asking for a state while
>> with /dev/epoll you're asking for a state change.
>> 
> 
>  Ok, if we're just disagreeing about the best api,
> then I can live with that. But it appears we're
> talking at cross-purposes, so I want to try this one
> more time. I'll lay my though processes out in detail,
> and you can tell me at which step I'm going wrong:
> 
> 
>  Normally, you'd spend most of your time sitting in
> ioctl(EP_POLL) waiting for something to happen. So
> that's one syscall.
> 
>  If you get an event that indicates you can accept()
> a new connection, then you do an accept(). Assume it
> succeeds. That's two syscalls. Then you register
> interest in the fd with a write to /dev/poll, that's
> three.
> 
>  With the current /dev/epoll, you must try to read()
> the new socket before you go back to ioctl(EP_POLL),
> just in case there is data available. You expect
> there isn't, but you have to try. This is the step
> I'm talking about. That's four.
> 
>  Assume data was not available, so you loop back
> to ioctl(EP_POLL) and wait for an event. That's five
> syscalls. The event comes in, you do another read()
> on the socket, and probably get some data. That's
> six syscalls to finally get your data.
> 
>  ioctl(kpfd, EP_POLL) 1     wait for events
>  s = accept()           2     accept a new socket
>  write(kpfd, s)         3     register interest
>  n = read(s)            4 <-- annoying test-read
>  ioctl(kpfd, EP_POLL)   5     wait for events
>  n = read(s)            6     get some data

You continue to put the state check ( ioctl() ) before the system call,
that require you to use select()/poll()//dev/poll interfaces that are
state inquiry interfaces.
The /dev/epoll is, like i said before, a state change notification interface.
That's how have been designed and that how it completely avoid fds scan.
If you're looking for a state inquiry interface it's better for you to seek /dev/poll.




- Davide

