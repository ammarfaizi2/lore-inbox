Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSGELV0>; Fri, 5 Jul 2002 07:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSGELVZ>; Fri, 5 Jul 2002 07:21:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14609 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317005AbSGELVY>; Fri, 5 Jul 2002 07:21:24 -0400
Date: Fri, 5 Jul 2002 07:17:51 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rob Landley <landley@trommello.org>
cc: Ingo Molnar <mingo@elte.hu>, Tom Rini <trini@kernel.crashing.org>,
       "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
In-Reply-To: <200207050045.g650jbA401134@pimout1-int.prodigy.net>
Message-ID: <Pine.LNX.3.96.1020705071221.8344B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, while I'm sure O(1) would help, you have designed this network to
have a high overhead. I'll send you some notes on how to easily reduce the
overhead to max one sshd per machine connected to the bounce machine. And
give you an option to move the crypt overhead to the machines at the end
points.

On Thu, 4 Jul 2002, Rob Landley wrote:
	[...snip...]> 
> The bottleneck is that with thirty big data transfers going through sixty 
> sshd processes (which are real CPU hogs decrypting incoming data and 
> encrypting outgoing data), a 700 mhz athlon goes catatonic.  The existing 
> bulk data shoveling connections have their data shoveled fine, but new 
> incoming connections (even for short lived "fetch me 10k of web data of the 
> remote box" type connections) are Not Happy.  The existing scheduler's 
> getting confused by the fact that the sshd sessions DO sometimes block to 
> get/send their data, and isn't so good at keeping a running average to spot 
> the CPU hogs and the sessions that are more interactive or simply short lived.
> 
> That's why I'm playing with the O(1) scheduler.  I may need to put rate 
> limiting in netbounce anyway, but the problem I'm HITTING is that the 
> existing scheduler is melting down so badly that past a fairly low saturation 
> level, fresh connection attempts through the star server are timing out.  
> (This hardware seems like it should be able to handle around 100 simultaneous 
> connections, and it's currently melting down around 30.)
> 
> Yeah, I'm beating the CPU to death encrypting and decrypting data.  Yeah, I 
> could throw more hardware at the problem (and will).  I could take another 
> stab at redesigning the star server to consolidate all the netbounce 
> processes into a single poll loop (which would require modifying sshd), but 
> netbounce isn't the problem: the two sshd processes per connection are.  (I 
> could merge all the connections to and from each box into a single sshd 
> process per gateway, but that clashes with the way the rest of the VPN works, 
> which is simple and suprisingly reliable, and there would still be at least 
> one per box anyway.  And what that really MEANS is that I'd be bypassing the 
> process scheduler and doing my own manual scheduling.)
> 
> This is a real-world situation of a pure scheduling problem.  The star server 
> has a quarter gigabyte of ram and isn't going anywhere near swap.  The 
> scheduler has plenty of hints about CPU usage, blocking for I/O, and freshly 
> spawned processes needing to start at a higher priority than entrenched 
> saturation level data shovelers.
	[...snip...] 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

