Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSDSFwl>; Fri, 19 Apr 2002 01:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293035AbSDSFwk>; Fri, 19 Apr 2002 01:52:40 -0400
Received: from w226.z064000207.nyc-ny.dsl.cnc.net ([64.0.207.226]:15419 "EHLO
	carey-server.stronghold.to") by vger.kernel.org with ESMTP
	id <S290289AbSDSFwj>; Fri, 19 Apr 2002 01:52:39 -0400
Message-Id: <4.3.2.7.2.20020419015142.03a89218@mail.strongholdtech.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 19 Apr 2002 01:57:51 -0400
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
From: "Nicolae P. Costescu" <nick@strongholdtech.com>
Subject: Re: CPU scheduler question: processes created faster than 
  destroyed?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CBF389F.7010807@fugmann.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>So, your clients are contacting the server repeatably...
>
>First there is something in your desctiption that was not entirely clear.
>After the server has received a request and has spawned four processes, 
>does it sleep while
>waiting for data?

The master server always is blocked on accept() waiting for clients to 
connect. When a client connects, he forks() and his child takes over. The 
parent closes his file descriptors to decrease ref. count and then gets 
back to waiting for another client.

>If yes, the server would get a high counter. This means that the "dynamic 
>proirity" of the server
>process would be higher than the spawned processes, and hence be able to 
>starve the child processes
>for a small ammount of time. Therefore it is able to send the answer back 
>to the client and receive a
>new request before any of the first spawned processes has terminated. Also 
>the new spawned children will
>possibly have a higher "dynamic priority" (Really hate to use this term) 
>than the first spawned processes.

That makes sense.

>Try and understand the line:
>     p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
>in kernel/sched.c#624 - 2.4.18, especially when a process is sleeping.

Ok will review it, thanks. Your explanation certainly makes sense, since 
the master server uses only a fraction of its time quantum and then goes 
back to sleep (wake up on accept(), fork, block on accept).

>Well. If my assumptions are correct it is both. The scheduler works in 
>this way, but
>that should not harm your application (it actually speed it up), but you 
>might want
>to redesign your application to avoid too many proccesse being spawned.
>
>I would suggest one of two ways to do this.
>
>1) Let the server wait for the spawned processes to die, before accepting 
>new requests.
>The draw back migh be that it will slow down the server process a bit.

Not possible because we must handle multiple simultaneous clients.

>2) Dont spawn new processes all the time. Spawn the four needed processes 
>once and for all,
>and insted of terminating after proccessing, let them wait for a new 
>command (acting just like your server).

Again need multiple simultaneous processes.

>Hope it helps.
>Anders Fugmann

It did, thank you for taking the time to read & reply! I think our long 
term solution is to use a pool of servers instead of constantly forking. 
Short term we need to keep the client connected while the forked server 
closes his database connections, that way the client can't jump back in and 
cause another set of servers to fork.

Thanks again,
Nick

****************************************************
Nicolae P. Costescu, Ph.D.  / Senior Developer
Stronghold Technologies
46040 Center Oak Plaza, Suite 160 / Sterling, Va 20166
Tel: 571-434-1472 / Fax: 571-434-1478

