Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273176AbRISTLN>; Wed, 19 Sep 2001 15:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274136AbRISTLE>; Wed, 19 Sep 2001 15:11:04 -0400
Received: from c007-h012.c007.snv.cp.net ([209.228.33.219]:58061 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S273176AbRISTKz>;
	Wed, 19 Sep 2001 15:10:55 -0400
X-Sent: 19 Sep 2001 19:11:02 GMT
Message-ID: <3BA8EBF7.1833ACE0@distributopia.com>
Date: Wed, 19 Sep 2001 14:03:19 -0500
From: "Christopher K. St. John" <cks@distributopia.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Davide Libenzi <davidel@xmailserver.org>, Dan Kegel <dank@kegel.com>
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010919102538.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> > /dev/epoll only gives you events on state changes. So,
> > for example, if you accept() a new socket and add it to the
> > interest list, you (probably) won't get a POLLIN. That's
> > not fatal, but it's awkward.
> 
> Being an event change notification you simply can't add the fd
> to the "monitor" after you've issued the accept().
> The skeleton for /dev/epoll usage is :
> 
> while (system_call(...) == FAIL) {
> 
>         wait_event();
> }
> 

 I'm not sure I understand. I'm assuming you can do
something along the lines of:

 // application accepts new socket
 new_socket_fd = accept()

 // application registers interest with epoll
 write(dev_poll_fd, new_socket_fd):
   drivers/char/eventpoll.c:ep_insert():
    - add new_socket_fd to interest list
    - check new_socket_fd for readable, writable, and
      error. if any true, then add new event to 
      event queue, as if the state had changed.

 // application asks for current set of events
 app: ioctl(dev_poll_fd, EP_POLL):
   drivers/char/eventpoll.c:ep_poll():
     - return the current event queue

 In other words, when new fd's are added to the
interest set, you generate synthetic events which
are returned at the next ioctl(EP_POLL).

 Are you saying that isn't possible? It's the
suggested behavior from the BMD paper, so evidently
they got it to work somehow (and I suspect it's how
Solaris /dev/poll works, but I'm not sure)

-- 
Christopher St. John cks@distributopia.com
DistribuTopia http://www.distributopia.com
