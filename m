Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274172AbRISUnZ>; Wed, 19 Sep 2001 16:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274180AbRISUnQ>; Wed, 19 Sep 2001 16:43:16 -0400
Received: from [208.129.208.52] ([208.129.208.52]:8203 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274172AbRISUnC>;
	Wed, 19 Sep 2001 16:43:02 -0400
Message-ID: <XFMail.20010919123029.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BA8EBF7.1833ACE0@distributopia.com>
Date: Wed, 19 Sep 2001 12:30:29 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: "Christopher K. St. John" <cks@distributopia.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19-Sep-2001 Christopher K. St. John wrote:
> Davide Libenzi wrote:
>> 
>> > /dev/epoll only gives you events on state changes. So,
>> > for example, if you accept() a new socket and add it to the
>> > interest list, you (probably) won't get a POLLIN. That's
>> > not fatal, but it's awkward.
>> 
>> Being an event change notification you simply can't add the fd
>> to the "monitor" after you've issued the accept().
>> The skeleton for /dev/epoll usage is :
>> 
>> while (system_call(...) == FAIL) {
>> 
>>         wait_event();
>> }
>> 
> 
>  I'm not sure I understand. I'm assuming you can do
> something along the lines of:
> 
>  // application accepts new socket
>  new_socket_fd = accept()
> 
>  // application registers interest with epoll
>  write(dev_poll_fd, new_socket_fd):
>    drivers/char/eventpoll.c:ep_insert():
>     - add new_socket_fd to interest list
>     - check new_socket_fd for readable, writable, and
>       error. if any true, then add new event to 
>       event queue, as if the state had changed.

No it does't check. It's not needed for how it works.


>  // application asks for current set of events
>  app: ioctl(dev_poll_fd, EP_POLL):
>    drivers/char/eventpoll.c:ep_poll():
>      - return the current event queue
> 
>  In other words, when new fd's are added to the
> interest set, you generate synthetic events which
> are returned at the next ioctl(EP_POLL).
> 
>  Are you saying that isn't possible? It's the
> suggested behavior from the BMD paper, so evidently
> they got it to work somehow (and I suspect it's how
> Solaris /dev/poll works, but I'm not sure)

select()/poll() works in a different way :

1)        select()/poll();
2)        recv()/send();

while /dev/epoll works like described above :

1)        if (recv()/send() == FAIL)
2)                wait_event();

I intentionally changed the name to epoll coz it works in a different way.



- Davide

