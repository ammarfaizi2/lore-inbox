Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291859AbSBHVkg>; Fri, 8 Feb 2002 16:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291862AbSBHVk0>; Fri, 8 Feb 2002 16:40:26 -0500
Received: from age.cs.columbia.edu ([128.59.22.100]:2822 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S291859AbSBHVkI>; Fri, 8 Feb 2002 16:40:08 -0500
Date: Fri, 8 Feb 2002 16:39:57 -0500 (EST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <20020208161118.GA329@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0202081616110.11655-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Pavel Machek wrote:

> Hi!
> 
> > > > Wrong. man ping. ping -f doesn't do what you apparently think it does.
> > > 
> > > strace ping, you'll see it doing a 
> > > 	setsockopt(7, SOL_SOCKET, SO_SNDTIMEO, [1], 8) = 0
> > > 
> > > on its socket.
> > 
> > Read the ping manual page. Then when you understand what ping -f does 
> > come back and have a useful conversation.
> 
> But I guess it *would* be usefull to have -F option saying "feed data
> as fast as possible", right? And it would be nice if this option did
> not eat 100% cpu when possible, right?
> 
> So what he is asking for is pretty usefull behaviour.

I'm not asking for it. I'm saying this is what we already have. Too bad 
people won't listen -- and yes I know ping -f was a bad example. A 
blocking sendto() *will* block (surprise surprise), even though it *might* 
throw the data away later on.

Indeed, as Davem stated, a UDP socket will lose data under memory
pressure.  In real life this hardly ever happens, however, even with large 
message sizes: I just tested with sizes up to 52000, which is just about 
as large as you'll ever see in real environments.

Also: I'm just dying to be enlightened about how a dumb program like
ttcp -u, doing a totally dumb "while (1) sendto();", can manage to score 
sending rates identical to the raw wire speed, if indeed sendto() never 
blocks and simply throws away the data:

apollo:/# ttcp -utsl 53000 zeus
ttcp-t: buflen=53000, nbuf=2048, align=16384/0, port=5001  udp  -> sybase2
ttcp-t: socket
ttcp-t: 108544000 bytes in 9.02 real seconds = 11745.26 KB/sec +++
ttcp-t: 2054 I/O calls, msec/call = 4.50, calls/sec = 227.59
ttcp-t: 0.0user 0.2sys 0:09real 2% 0i+0d 0maxrss 0+13pf 0+0csw
zeus:/var/lib/pgsql# ttcp -ursl 53000
ttcp-r: buflen=53000, nbuf=2048, align=16384/0, port=5001  udp
ttcp-r: socket
ttcp-r: 108544000 bytes in 9.03 real seconds = 11741.76 KB/sec +++
ttcp-r: 2050 I/O calls, msec/call = 4.51, calls/sec = 227.08
ttcp-r: 0.0user 0.1sys 0:09real 1% 0i+0d 0maxrss 0+12pf 0+0csw

11745KB/sec sounds suspiciously close to the 100Mb/sec wire speed.

and, for reference, just to make sure ttcp wasn't lying to me:

zeus:/var/lib/pgsql# iptables -L -n -v
Chain INPUT (policy ACCEPT 7217K packets, 3137M bytes)
 pkts bytes target     prot opt in     out     source               destination         
 2051  108M            udp  --  *      *       10.2.10.216          0.0.0.0/0          udp dpt:5001 


But no, it's so much easier to incompletely quote a message and then claim 
the other person has no idea about what he's talking about. Yes, Alan, 
that's precisely what you did.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

