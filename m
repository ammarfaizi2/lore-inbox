Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSGEAno>; Thu, 4 Jul 2002 20:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSGEAnn>; Thu, 4 Jul 2002 20:43:43 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:37338 "EHLO
	pimout1-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S314596AbSGEAnm>; Thu, 4 Jul 2002 20:43:42 -0400
Message-Id: <200207050045.g650jbA401134@pimout1-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Bill Davidsen <davidsen@tmr.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [OKS] O(1) scheduler in 2.4
Date: Thu, 4 Jul 2002 14:08:42 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Tom Rini <trini@kernel.crashing.org>, "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020703232322.2248C-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020703232322.2248C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 July 2002 11:36 pm, Bill Davidsen wrote:

> This is not some neat feature to buy a few percent better this or that,
> this is roughly 50% more users on the server before it falls over, and no
> total bogs when many threads change to hog mode at once.
>
> You will not hear me saying this about preempt, or low-latency, and I bet
> that after I try lock-break this weekend I won't fell that I have to have
> that either. The O(1) scheduler is self defense against badly behaved
> processes, and the reason it should go in mainline is so it won't depend
> on someone finding the time to backport the fun stuff from 2.5 as a patch
> every time.

I've got a similar setup.  At work I'm doing a simple ssh based vpn: 
connections to the vpn address range outside the local subnet are intercepted 
by port forwarding to a tiny daemon (700 lines of C source, mostly comments), 
that shells out to ssh (forwarding stdin and stdout back to the net 
connection) to connect to the appropriate remote gateaway, where it runs 
netcat to complete the connection.

So each tcp/ip stream is individually wrapped in its own ssh process, which 
exits automatically when the connection closes.  No mess, no fuss, and 
scalability is based on active connections rather than the number of systems 
in the VPN.

Unfortunately, some of these VPN gateways are behind existing firewalls 
(cisco, etc).  If I can get a port forwarded to my vpn gateway from that 
firewall, life is good (it's a little more work for the daemon to figure out 
where to ssh to, but that's part of the 700 lines).  But when I can't get 
that, the machine has to dial out to a known public machine (the "star 
server") and have its incoming data bounced off of that machine.  (Evil, but 
only incoming connections to those trapped machines need to use the star 
server.  Everybody else can still dial direct, and the trapped machines can 
still dial out direct.)

The star server tends to be running LOTS of ssh processes (four for each 
connection: one instance of sshd for each incoming connection, plus the 
netbounce processes that sshd instance runs, which talk to one another 
through named pipes.  I could get that down to two processes by modifying 
sshd to integrate the netbounce functionality, but it hasn't been a 
bottleneck.  Netbounce doesn't eat much, sshd is the real cpu hog.  And it's 
not as easy to rewrite netbounce to be one central process with a poll loop 
as you'd think: sshd wants to run SOMETHING.  So far I'm using standard sshd 
code, I'd prefer not to make special purpose modifications to the thing it if 
I can help it.)

The bottleneck is that with thirty big data transfers going through sixty 
sshd processes (which are real CPU hogs decrypting incoming data and 
encrypting outgoing data), a 700 mhz athlon goes catatonic.  The existing 
bulk data shoveling connections have their data shoveled fine, but new 
incoming connections (even for short lived "fetch me 10k of web data of the 
remote box" type connections) are Not Happy.  The existing scheduler's 
getting confused by the fact that the sshd sessions DO sometimes block to 
get/send their data, and isn't so good at keeping a running average to spot 
the CPU hogs and the sessions that are more interactive or simply short lived.

That's why I'm playing with the O(1) scheduler.  I may need to put rate 
limiting in netbounce anyway, but the problem I'm HITTING is that the 
existing scheduler is melting down so badly that past a fairly low saturation 
level, fresh connection attempts through the star server are timing out.  
(This hardware seems like it should be able to handle around 100 simultaneous 
connections, and it's currently melting down around 30.)

Yeah, I'm beating the CPU to death encrypting and decrypting data.  Yeah, I 
could throw more hardware at the problem (and will).  I could take another 
stab at redesigning the star server to consolidate all the netbounce 
processes into a single poll loop (which would require modifying sshd), but 
netbounce isn't the problem: the two sshd processes per connection are.  (I 
could merge all the connections to and from each box into a single sshd 
process per gateway, but that clashes with the way the rest of the VPN works, 
which is simple and suprisingly reliable, and there would still be at least 
one per box anyway.  And what that really MEANS is that I'd be bypassing the 
process scheduler and doing my own manual scheduling.)

This is a real-world situation of a pure scheduling problem.  The star server 
has a quarter gigabyte of ram and isn't going anywhere near swap.  The 
scheduler has plenty of hints about CPU usage, blocking for I/O, and freshly 
spawned processes needing to start at a higher priority than entrenched 
saturation level data shovelers.

Hence putting "play with O(1)" on my to-do list...

Rob

