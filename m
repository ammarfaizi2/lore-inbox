Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbQLFNkB>; Wed, 6 Dec 2000 08:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129944AbQLFNjv>; Wed, 6 Dec 2000 08:39:51 -0500
Received: from Cantor.suse.de ([194.112.123.193]:43012 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129532AbQLFNjf>;
	Wed, 6 Dec 2000 08:39:35 -0500
Date: Wed, 6 Dec 2000 14:09:05 +0100
From: Andi Kleen <ak@suse.de>
To: Olaf Kirch <okir@caldera.de>
Cc: linux-kernel@vger.kernel.org, security-audit@ferret.lmh.ox.ac.uk
Subject: Re: Traceroute without s bit
Message-ID: <20001206140905.A408@gruyere.muc.suse.de>
In-Reply-To: <20001206135019.L9533@monad.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001206135019.L9533@monad.caldera.de>; from okir@caldera.de on Wed, Dec 06, 2000 at 01:50:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 01:50:19PM +0100, Olaf Kirch wrote:
> Hi all,
> 
> I wrote a small traceroute last night that works mostly like the
> LBL one, except it doesn't need an s bit anymore :)

It already existed in Alexey's iputils (tracepath). 


> There are three things that puzzle me, however:
> 
>  1.	When I want to include IP options into an outgoing packet,
> 	I'm expected to include a struct ip_options in the IP_RETOPTS
> 	control message. However, this struct is included in
> 	#ifdef __KERNEL__/#endif in 2.4.0-t10 (on which I'm compiling
> 	right now). Normally this doesn't deter me, but in this case
> 	some of the fields look sort of fishy to me.
> 
> 	My question is, do we really want to allow users to hand
> 	an arbitrary, unchecked struct ip_options to the kernel?
> 	Wouldn't raw options be a better choice?

Raw options are passed. That ip_options ever appeared in glibc/user headers
was a bug, it is strictly kernel internal.


> 
>  2.	There's another issue with ip_cmsg_send in ip_sockglue.c;
> 	it allows any user to specify PKTINFO data in a control
> 	messages. As far as I can tell, by looking at udp.c,
> 	this lets any user set arbitrary IP source addresses
> 	on outgoing UDP packets. Yikes.

IP_PKTINFO does not allow to set source addresses, only destination
addresses. Source address depends on the boundage or the route. 


> 
>  3.	There seems to be a bug somewhere in the handling of poll().
> 	If you observe the traceroute process with strace, you'll
> 	notice that it starts spinning madly after receiving the
> 	first bunch of packets (those with ttl 1).
> 
> 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> 	...
> 
> 	I.e. the poll call returns as if it had timed out, but it
> 	hasn't.

POLLERR is returned until the error queue is empty. I suspect you're
not emptying it properly in all cases. It can contain multiple errors.


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
