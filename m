Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSJ3CQQ>; Tue, 29 Oct 2002 21:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263310AbSJ3CQQ>; Tue, 29 Oct 2002 21:16:16 -0500
Received: from mtao-m02.ehs.aol.com ([64.12.52.8]:5765 "EHLO
	mtao-m02.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S263291AbSJ3CQP>; Tue, 29 Oct 2002 21:16:15 -0500
Date: Tue, 29 Oct 2002 18:22:35 -0800
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-reply-to: <Pine.LNX.4.44.0210291237240.1457-100000@blue1.dev.mcafeelabs.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Message-id: <3DBF426B.6050208@netscape.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b)
 Gecko/20021016
References: <Pine.LNX.4.44.0210291237240.1457-100000@blue1.dev.mcafeelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>You're in the computer science by many many years and still you're not able to
>understand how edge triggered events works.
>
Failure to agree does not imply failure to understand.  I understand the 
model you want to apply to this problem, I do not agree that it is the 
best model to apply to this problem.

>Why the heck ( and this for the 100th time ) do you want to go to wait for
>an event on the newly born fd if :
>
>1) On connect() you have the _full_ write I/O space available
>2) On accept() it's very likely the you'll find something more than a SYN
>	in the first packet
>
>Besides, the first code is even more cleaner and simmetric, while adopting
>your half *ss solution might suggest the user that he can go waiting for
>events any time he wants.
>
The first code is hardly cleaner and is definitely not symmetric--the 
way the accept code has to set up to fall through the do_use_fd() code 
is subtle.  In the first code, the accept segment cannot be cleanly 
pulled into a callback:

for (;;) {
        nfds = sys_epoll_wait(kdpfd, &pfds, -1);
        for(n = 0; n < nfds; ++n) {
                (cb[pfds[n].fd])(pfds[n].fd);
        }
}


Also, your first code does not fit your "edge triggered" model--the code 
for handling 's' does not drain its input.  By the time you call 
accept(), there could be multiple connections ready to be accepted.

Your connect() argument is not applicable to "server sends first" 
protocols.  I suspect you are being overly optimistic about the 
likelihood of getting data with SYN, but whatever.  The argument is 
basically that not delivering an event upon registration (and thus 
having the event be implicit) improves performance because the socket is 
going to be ready with sufficiently high probability.  I would counter 
that the cost of explicitly delivering such an event is miniscule 
compared to the rest of the cost of connection setup and teardown--the 
optimization is not worthwhile.

>Like going to sleep the the wait queue of IDE
>disk w/out having issued any command.
>
The key difference between this interface and wait queues is that with 
wait queues it is not technically feasible to both register interest and 
test the condition in a single, atomic operation.  epoll does not have 
this technical limitation, so it can provide a better interface.

>PS: since my time is not infinite, and since I'm working on the changes we
>agreed with Andrew I would suggest you either to take another look at the
>code suggesting us new changes ( like you did yesterday ) or to go
>shopping for books.
>
I am uncomfortable with the way the epoll code adds its own set of 
notification hooks into the socket and pipe code.  Much better would be 
to extend the existing set of notification hooks, like the aio poll code 
does.  That would reduce the risk of kernel bugs where some subsystem 
fails to deliver an event to one but not all types of poll notification 
hooks and it would minimize the cost of the epoll patch when epoll is 
not being used.

>  
>


