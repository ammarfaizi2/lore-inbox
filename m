Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313355AbSDJRh3>; Wed, 10 Apr 2002 13:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313367AbSDJRh2>; Wed, 10 Apr 2002 13:37:28 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:55447 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313355AbSDJRh1>; Wed, 10 Apr 2002 13:37:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Futex Generalization Patch
Date: Wed, 10 Apr 2002 12:37:53 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de, pwaechler@loewe-Komp.de,
        drepper@redhat.com, babt@us.ibm.com
In-Reply-To: <E16vL6l-00083d-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020410173705.B1A7E3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 April 2002 12:37 pm, Rusty Russell wrote:
> In message <20020410152354.169FF3FE06@smtp.linux.ibm.com> you write:
> > Enclosed is an "asynchronous" extension to futexes.
>
> Wow... I never thought of that.  Cool!
>
> My main concern is the DoS of multiple kmallocs.  Alan Cox suggested
> tying it to an fd (ie. naturally limited), and I think this might work
> (I don't know much about async io).  ie. (int)utime is the fd to wake
> up, and then it can be used for async io OR a poll/select interface
> using existing infrastructure.
>
> Probably it has to be a special fd (/dev/futex?).
>
> Thoughts?
> Rusty.

Is the idea to write one's own poll/select routine for the /dev/futex files? 

Dependent on the circumstance:
(A) you want to globally limit the number of outstanding waits !

Why so complicated, (assuming I understand the suggestion above) ?

Simply have a /proc/futex  subsystem that tell's you how many outstanding 
awaits can be active at any time.
kmalloc()   becomes     if (fq_count++ > LIMIT)  return -EAGAIN;   
kfree()       becomes     kfree() ; fq_count--;

(B) 
if you really want per process limits, then ofcourse, you need something 
different than my suggestions under (A) 

We allocate a file structure with private data for opening /dev/futex !
We associate that file descriptor
(a) a counter (reflecting the number of outstanding futex_q)
(b) a notify_queue 

(a) is limited by a per FD limit of outstanding futex_q    (still need a 
global limit here)
(b) solves the __exit_futex() problem. 
We wouldn't need that call, as the pending notifications will be deleted with 
the FD destruction... cool...

Can somebody in the thread world weight in what there preferred mechanism is
regarding limits etc. Do you need to control the issue on how the signal is 
delivered? Is a file descriptor good enough or you want a sys_call interface ?

All this is merely a "clean/usefull interface" issue (other then the DoS). 

One other idea here ...   



Can you sketch out the file design and I code it up. 


We need this async functionality for M:N threads and we need it soon.
-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
