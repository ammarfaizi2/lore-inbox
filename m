Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274117AbRISRfj>; Wed, 19 Sep 2001 13:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274119AbRISRf3>; Wed, 19 Sep 2001 13:35:29 -0400
Received: from [208.129.208.52] ([208.129.208.52]:7431 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274118AbRISRfV>;
	Wed, 19 Sep 2001 13:35:21 -0400
Message-ID: <XFMail.20010919103903.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BA8BBC9.EA1D0636@kegel.com>
Date: Wed, 19 Sep 2001 10:39:03 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Dan Kegel <dank@kegel.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Christopher K. St. John" <cks@distributopia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19-Sep-2001 Dan Kegel wrote:
> "Christopher K. St. John" wrote:
>>  The Banga, Mogul and Druschel[1] paper (which I understand
>> was the inspiration for the Solaris /dev/poll which was the
>> inspiration for /dev/epoll?) talks about having the poll
>> return the current state of new descriptors. As far as I can
>> tell, /dev/epoll only gives you events on state changes. So,
>> for example, if you accept() a new socket and add it to the
>> interest list, you (probably) won't get a POLLIN. That's
>> not fatal, but it's awkward.
>>...
>>  My vote would be to always report the initial state, but
>> that would make the driver a little more complicated.
>> 
>>  What are the preferred semantics?
> 
> Taking an extreme but justifiable position for discussion's sake:
> 
> Stevens [UNPV1, in chapter on nonblocking accept] suggests that readiness
> notifications from the OS should only be considered hints, and that user
> programs should behave properly even if the OS feeds it false readiness
> events.  
> 
> Thus one possible approach would be for /dev/epoll (or users of /dev/epoll)
> to assume that an fd is initially ready for all (normal) events, and just
> try handling them all.  That probably involves a single system call
> to read() (or possibly a call to both write() and read(), or a call to accept(),
> or a call to getsockopt() in the case of nonblocking connect), so the overhead
> isn't very high.

I think there's an advantage instead.
With the usual scheme :

        select()/poll();
        recv()/send();

you always issue two system calls each time, while with :

        while (recv()/send() == FAIL) {
                wait_event();
        }

you're going to issue two calls only in certain conditions.




- Davide

