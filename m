Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317576AbSGEVE5>; Fri, 5 Jul 2002 17:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317577AbSGEVEz>; Fri, 5 Jul 2002 17:04:55 -0400
Received: from pc132.utati.net ([216.143.22.132]:3203 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S317576AbSGEVEq>; Fri, 5 Jul 2002 17:04:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [OKS] O(1) scheduler in 2.4
Date: Fri, 5 Jul 2002 11:09:02 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020705071221.8344B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020705071221.8344B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020705204513.3FF49C57@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 July 2002 07:17 am, Bill Davidsen wrote:
> Rob, while I'm sure O(1) would help, you have designed this network to
> have a high overhead.

The star server design has high overhead.  The direct point to point does 
not.  I'm trying to make the star server work the way the rest of the network 
works, WITHOUT extensively redesigning the parts of the network that don't 
need to use the star server

The star server's inherently a kludge, and I know it, and I'm trying to 
minimize its use.  It's inherently a single point of failure, and a 
bottleneck on an otherwise distributed and scalable system, and it 
potentially doubles bandwidth usage and generally MORE than doubles the 
bandwidth bill because fast connections are expensive and often metered.  No 
redesign will fix those fundamental problems.  The star server really exists 
for political reasons: some people think that having a process behind the 
firewall go out and fetch incoming connections is more secure than forwarding 
a port.  Either way, a way in exists by definition, or you haven't got a VPN. 
 On a technical level, I really do suggest just forwarding the port.

> I'll send you some notes on how to easily reduce the
> overhead to max one sshd per machine connected to the bounce machine. And
> give you an option to move the crypt overhead to the machines at the end
> points.

Thanks for your suggestions.  I mentioned last time that I could redesign my 
existing code in a number of ways to get around the old flawed scheduler, 
yes.  And there are easier ones than you suggested (I REALLY don't want to 
over-complicate what is currently a very simple design).  And redoing it 
probably seems like a much easier problem to tackle when you don't know what 
the full set of design requirements are.  (Among other things, nodes move 
dynamically.  They go down, their IP address changes...)

I did stop and reconsider your suggestion about removing the star server's 
redundant decrypt/re-encrypt step.  It could be done without introducing a 
ppp layer (which has several of the aforementioned design requirements 
problems I won't go into here).  Unfortunately, if I did that, the initial 
handshaking a client box does with the star server (to identify itself and 
the type of connection it wants to make, etc) wouldn't be encrypted or 
cryptographically verified either (unless I did it myself, and right now all 
the encryption is neatly handled by ssh, which I already mentioned not 
wanting to modify).  As I said, if O(1) doesn't work I have options.  (I have 
a long to-do list to get through first but I hope to be able to try it on a 
stress-testable server sometime after the weekend.)

The other thing is that CPU usage should scale with bandwidth shoveled, and 
that should be mostly true whether it's one process or 100.  (Yeah, modulo 
cache flushing, but it's the same process and that data it works on is 
use-once stream no matter how you look at it.)  The star server is hooked up 
to the internet, not a LAN.  If it's got a faster than 10 megabit connection 
somebody's putting a LOT of money behind it, they could definitely afford to 
throw SMP CPU time at the problem, and in that case having multiple processes 
makes scaling easier.  Having CPU usage be a limiting factor was acceptable 
in the initial design, but the behavior under load of the old scheduler is a 
bit...  unexpected at times.

And at THIS point, the question is whether to redesign the app or fix the 
scheduler.  (I expect the multi-threaded people hit this all the time. :)

Rob
