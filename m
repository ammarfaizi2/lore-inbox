Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSGGFGa>; Sun, 7 Jul 2002 01:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSGGFG3>; Sun, 7 Jul 2002 01:06:29 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:48062 "EHLO
	pimout3-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S314381AbSGGFG2>; Sun, 7 Jul 2002 01:06:28 -0400
Message-Id: <200207070508.g6758YI198846@pimout3-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [OKS] O(1) scheduler in 2.4
Date: Sat, 6 Jul 2002 19:10:14 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020706002520.12368C-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020706002520.12368C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 July 2002 12:31 am, Bill Davidsen wrote:

> That's not correct... if you set the encryption type to none the
> connection and port forwarding are not encrypted, but the handshake still
> is, using password, host key, or requiring both. You can make a fully
> authenticated non-encrypted connection. I like running the popular "sleep"
> program as the main command, and using port forwarding for what you do,
> since you reject running ppp over ssh.

I'm sending data through the connection to tell the star server who we are 
(which sshd may know but the star server doesn't) which I don't want to have 
snooped.  Box identification keys and such that could be used to forge 
access.  Yes, I could redesign the entire handshaking protocol to be based on 
an md5 sum with a timestamp, and redo the key distribution of all the other 
boxes in my network to try to get ssh to inform us of which box is connecting 
in, but I don't want to.

The star server is a kludge.  Period.  Moving CPU usage won't change that.  
The problem you're trying to solve ONLY affects the star server.  The SIMPLE 
solution is to put rate limiting into netbounce, which I specced out last 
week but thought O(1) would be a better solution.

It's not the load that's the problem (a T1 line, DSL connection, or 10baseT 
can't saturate it).  It's the unfairness, which was found in laboratory 
stress testing with a 100baseT network connection and a 700 mhz processor.  
(If you can afford a 100baseT connection to the internet which you can keep 
saturated for long periods of time, you can usually afford more than a 700 
mhz processor.  Really.)

Moving the limiting factor from CPU time (which is cheap) to network 
bandwidth (which is expensive) makes the unfairness harder to fix anyway.  
The O(1) scheduler gives the behavior we want, randomly dropping packets 
because your network connection is saturated (which is the normal case in the 
field anyway today) does not.  If sheer bandwidth saturation causes a similar 
problem in the second round of stress testing, I may have to put rate 
limiting into netbounce anyway, although I'm hoping a combination of 
processing latency and O(1) will do that for me even when the star server is 
not CPU-limited but bandwidth limited by real-world internet connections.  
(I'm not holding my breath, but dealing with the current problem means I can 
hold off for a while...)

You keep trying to find a way to fix the wrong problem: it's not the 
bandwidth, it's the unfairness.  O(1) is a quick and easy fix that might 
address this (on tuesday), and so far it's only a problem when a kludge I'm 
trying to minimize the use of is stress tested under laboratory conditions.  
I only mentioned it in the first place as a real-world application of O(1) to 
an existing problem, yes one that could be solved in other ways.

I could get this thing to work under DOS if I wanted to, without any 
scheduler at all, I just really don't consider it a good use of time.  I 
would happily have the star server do twice the work if it avoids adding 
complexity and overhead to the nodes that are NOT using the star server.  
Doing otherwise is optimizing the wrong thing: the star server is a bad idea 
requested by management for customers who want to have a VPN without 
configuring their firewalls to work with it.  It -CAN'T- be efficient, it's a 
single bottleneck for the entire network that's sending every packet through 
the same interface twice, the only question is how inefficient will it be.  
I'm not rewriting the way the rest of the nodes work to coddle the star 
server unless I have no choice, and I had about three alternatives lined up 
to try before I decided that O(1) would be a cleaner and easier thing to try.

> I'm running 19-pre10ac2+smp patches, as I recall ac4 or 5 are out, I just
> stopped upgrading when I got stability. If you run uni you should be able
> to drop in the new kernel, push the excryption overhead to the endpoints,
> and have nearly no work on the star server.

What the heck does the new kernel have to do with rewriting my app so that 
ssh is used in a different manner?  I could do that on 2.4.18 just fine, 
and I've repeatedly said I don't want to, and going truly in-depth as to the 
reasons WHY is off-topic here.

I got the O(1) patch for 19-rc1 and will testing it on my laptop in a few 
hours.  I really don't want to continue this thread.

Rob
