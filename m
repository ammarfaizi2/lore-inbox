Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314461AbSDRVUv>; Thu, 18 Apr 2002 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314462AbSDRVUu>; Thu, 18 Apr 2002 17:20:50 -0400
Received: from cpe.atm2-0-1071208.0x50c4d862.boanxx10.customer.tele.dk ([80.196.216.98]:63629
	"EHLO fugmann.dhs.org") by vger.kernel.org with ESMTP
	id <S314461AbSDRVUt>; Thu, 18 Apr 2002 17:20:49 -0400
Message-ID: <3CBF389F.7010807@fugmann.dhs.org>
Date: Thu, 18 Apr 2002 23:20:31 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
MIME-Version: 1.0
To: "Nicolae P. Costescu" <nick@strongholdtech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU scheduler question: processes created faster than  destroyed?
In-Reply-To: <4.3.2.7.2.20020418153151.019a98e0@mail.qrts.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolae P. Costescu wrote:
> At the point where the server replied to the client, the client 
> disconnects and is ready to send another message to the master server, 
> which will cause another 4 forks, etc.

So, your clients are contacting the server repeatably...

First there is something in your desctiption that was not entirely clear.
After the server has received a request and has spawned four processes, does it sleep while
waiting for data?

If yes, the server would get a high counter. This means that the "dynamic proirity" of the server
process would be higher than the spawned processes, and hence be able to starve the child processes
for a small ammount of time. Therefore it is able to send the answer back to the client and receive a
new request before any of the first spawned processes has terminated. Also the new spawned children will
possibly have a higher "dynamic priority" (Really hate to use this term) than the first spawned processes.

Try and understand the line:
     p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
in kernel/sched.c#624 - 2.4.18, especially when a process is sleeping.

 > Is this just bad design on our part, or is there something in the CPU scheduler that leads to this
 > behavior - where processes are started quicker than they die?

Well. If my assumptions are correct it is both. The scheduler works in this way, but
that should not harm your application (it actually speed it up), but you might want
to redesign your application to avoid too many proccesse being spawned.

I would suggest one of two ways to do this.

1) Let the server wait for the spawned processes to die, before accepting new requests.
The draw back migh be that it will slow down the server process a bit.

2) Dont spawn new processes all the time. Spawn the four needed processes once and for all,
and insted of terminating after proccessing, let them wait for a new command (acting just like your server).

Hope it helps.
Anders Fugmann









