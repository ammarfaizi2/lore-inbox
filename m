Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314445AbSDRUEs>; Thu, 18 Apr 2002 16:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSDRUEr>; Thu, 18 Apr 2002 16:04:47 -0400
Received: from w226.z064000207.nyc-ny.dsl.cnc.net ([64.0.207.226]:2098 "EHLO
	carey-server.stronghold.to") by vger.kernel.org with ESMTP
	id <S314445AbSDRUEq>; Thu, 18 Apr 2002 16:04:46 -0400
Message-Id: <4.3.2.7.2.20020418153151.019a98e0@mail.qrts.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 18 Apr 2002 16:06:36 -0400
To: linux-kernel@vger.kernel.org
From: "Nicolae P. Costescu" <nick@strongholdtech.com>
Subject: CPU scheduler question: processes created faster than
  destroyed?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, thanks to all for doing a great job with the Linux kernel. We 
appreciate your work!

I've been seeing this behavior on our servers (2.4.2 and 2.4.18 kernel) and 
would like to ask your opinion. I have read the linux internals doc. 
section on the scheduler, and have read through the sched.c source code.

I have a certain # of client processes on various machines that connect to 
a linux server box. A forking server (DAServer.t) waits for client 
connections, then forks a copy to handle the client request. Each forked 
DAServer.t connects to three database server back ends (postgres), all of 
which fork from a postmaster process.

So each client connection causes 4 forks on the server.

The forked server does some work for the client, communicating with the 3 
database backends, then replies to the client, and the client disconnects. 
Now the server does some cleanup and exist.

At the point where the server replied to the client, the client disconnects 
and is ready to send another message to the master server, which will cause 
another 4 forks, etc.

Given a fixed # of clients (say 14) I'd expect the # of processes to have 
some upper bound, but what I see is that sometimes the # of sleeping 
processes will grow unbounded (limited only by the 512 limit on the # of 
database backends).

I've logged load average, # of processes, # of DAServer.t processes, # of 
database server and plotted these at

http://www.strongholdtech.com/plots/

The # of sleeping processes will grow to say 900, and then suddenly 140 or 
them will become ready to run, run for a few seconds (driving load avg to 
around 100) and then disappear. Then shortly the system returns to normal.

Swap is not an issue, we have 1 gig RAM and 2 gig swap, and the swap isn't 
used, we usually only have about 400 meg in use when we hit the 900 process 
mark.

Is this just bad design on our part, or is there something in the CPU 
scheduler that leads to this behavior - where processes are started quicker 
than they die?

This problem is only exacerbated on a dual CPU box (goes unstable quicker).

Any suggestions?

We're going to try throttling the forked DAServer.t when the # of sleeping 
processes is large, making it sleep so that hopefully the other processes 
(some of which hang around in the sleeping state for 30 minutes or longer) 
will be able to run and die.

Thanks for your help,
Nick
****************************************************
Nicolae P. Costescu, Ph.D.  / Senior Developer
Stronghold Technologies
46040 Center Oak Plaza, Suite 160 / Sterling, Va 20166
Tel: 571-434-1472 / Fax: 571-434-1478

