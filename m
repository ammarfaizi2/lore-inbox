Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273724AbRIXAaT>; Sun, 23 Sep 2001 20:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273721AbRIXA37>; Sun, 23 Sep 2001 20:29:59 -0400
Received: from [208.129.208.52] ([208.129.208.52]:21005 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S273720AbRIXA35>;
	Sun, 23 Sep 2001 20:29:57 -0400
Message-ID: <XFMail.20010923173311.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010923171145.A15109@furble>
Date: Sun, 23 Sep 2001 17:33:11 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Gordon Oliver <gordo@pincoya.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24-Sep-2001 Gordon Oliver wrote:
> On 2001.09.20 10:18 Davide Libenzi wrote:
>> If you need to request the current status of a socket you've to
>> f_ops->poll the fd.
>> The cost of the extra read, done only for fds that are not "ready", is
>> nothing
>> compared to the cost of a linear scan with HUGE numbers of fds.
>> You could implement a solution where the low level io functions goes
>> directly to write
>> inside the mmapped fd set where the data buffer is empty or the out
>> buffer is full.
>> This would be a way more intrusive patch whose perf gain won't match the
>> cost.
> 
> But you missed the obvious optimization of doing an f_ops->poll when
> the file is _added_. This means that you'll get an initial event when
> there is data ready. This means you still never do a scan (only check
> when an fd is added), but you don't have to do an empty read every time
> you add an fd.
> 

Why is it so diffucult to understand that /dev/epoll is an "state change" interface.
Even if you add an event at fd insert time this DOES NOT transform /dev/epoll
in a "state monitor" interface.
That means that you can't use code like this :

        if (readable(fd))
                read();

that is common to "state monitor" interfaces.
The code prototype for "state change" interfaces is like :

        while (read() == FAIL)
                wait(READ_EVENT);

Suppose you transform this in a code like this :

int my_smart_read() {
        if (wait(READ_EVENT))
                read();
}

and a packet with 1000 bytes lands onto the terminal.
If you call my_smart_read() and you read 666 bytes the next
time you're going to call my_smart_read() you get stuck.
This coz /dev/epoll catch terminal "state change" events by design.
You could say, "but i want the terminal state to be reported" and
i say "use select()/poll()//dev/poll".


> Before you argue that this does not save a system call, it will in
> the typical case of:
>    <add fd>
>    <fail read>
>    <wait on events>
>    <successful read>
> 
> Note that it has the additional advantage of making the dispatch code
> in the user application easier. You no longer have to do special code
> to handle the speculative read after adding the fd.

You've to use speculative read()/write() coz these are going to change
( rx buffer empty, tx buffer full ) the state of the terminal without
which you'll never receive nexts state change events.
Please look at the code the uses rt signals and if you don't like it
i guess you'll never love /dev/epoll.





- Davide

