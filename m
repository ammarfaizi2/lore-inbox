Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTHaBjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 21:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbTHaBjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 21:39:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22196
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263600AbTHaBjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 21:39:13 -0400
Date: Sun, 31 Aug 2003 03:39:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831013928.GN24409@dualathlon.random>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 03:05:37AM +0200, Pascal Schmidt wrote:
> On Sat, 30 Aug 2003, Larry McVoy wrote:
> 
> >> All you have to do is drop the incoming packets if they exceed
> >> a certain bandwidth. 
> > If you think we haven't done that, think again.
> 
> > We're at the wrong end of the pipe to do that, I'm pretty sure that what 
> > you are describing simply won't work. 
> 
> In a way, you're on the right end of the pipe because the system
> that does your traffic shaping is part of the general network, viewed
> from the machines behind the shaper.
> 
> Dropping the packets means that the sending side, at least if we're
> talking TCP, will throttle its sending rate. But, depending on the
> distance in hops to the sender, it may take up to a few seconds for
> this to kick in. So I guess that's why it doesn't work for your
> VoIP case - the senders don't notice fast enough that they should
> slow down.

that's because you don't limit the bkbits.net to a fixed rate. If you
want to give priorities, it won't work well because it takes time to be
effective, but if you rate limit hard both ways it has to work, unless
you're under syn-flood ;) The downside is that you will waste bandwith
(i.e. you will hurt the bkbits.net service even when you don't use
voip), but it will work.

This is what I use normally to limit my brother downloads, and it works
fine for me (though I don't often place calls through adsl myself, it's
basically useless since people only uses cellphones here, and last time
I chekced voip wasn't free for cellphones with my isp).

this is the script:

INTERNAL_NET=eth0
EXTERNAL_NET=ppp0

		# External net, prioritize with TOS and low prio traffic in MARK chan 6
		tc qdisc add dev $EXTERNAL_NET root handle 1: prio bands 5
		tc qdisc add dev $EXTERNAL_NET parent 1:1 handle 10: sfq
		tc qdisc add dev $EXTERNAL_NET parent 1:2 handle 20: sfq
		tc qdisc add dev $EXTERNAL_NET parent 1:3 handle 30: sfq
		tc qdisc add dev $EXTERNAL_NET parent 1:4 tbf rate 16kbit buffer 1600 limit 3000
		tc qdisc add dev $EXTERNAL_NET parent 1:5 tbf rate 16kbit buffer 1600 limit 3000

		tc filter add dev $EXTERNAL_NET protocol ip parent 1:0 prio 4 handle 6 fw flowid 1:4
		tc filter add dev $EXTERNAL_NET protocol ip parent 1:0 prio 5 handle 7 fw flowid 1:5

		tc qdisc add dev $INTERNAL_NET root handle 1: prio bands 5
		tc qdisc add dev $INTERNAL_NET parent 1:1 handle 10: sfq
		tc qdisc add dev $INTERNAL_NET parent 1:2 handle 20: sfq
		tc qdisc add dev $INTERNAL_NET parent 1:3 handle 30: sfq
		tc qdisc add dev $INTERNAL_NET parent 1:4 tbf rate 64kbit buffer 1600 limit 3000
		tc qdisc add dev $INTERNAL_NET parent 1:5 tbf rate 64kbit buffer 1600 limit 3000

		tc filter add dev $INTERNAL_NET protocol ip parent 1:0 prio 4 handle 8 fw flowid 1:4
		tc filter add dev $INTERNAL_NET protocol ip parent 1:0 prio 5 handle 9 fw flowid 1:5

		#tc qdisc add dev $EXTERNAL_NET root sfq perturb 30

btw, the sfq is a great idea to have anyways, to provide fariness to
the traffing going out of your network.

then the below scripts will turn it off/on (so he can get full bandwith
while I'm not at my desk or when he's not doing anything very network
intensive ;)

Basically you should run the below with 'start' before placing the call,
and running 'stop' after the call is complete. It may take a few seconds
to rate limit all the connections but it should work fine.

EXTERNAL_NET=ppp0
INTERNAL_NET=eth0

case "$1" in
	start)
		iptables -t mangle -A PREROUTING -t mangle -j MARK -s 192.168.1.9 --set-mark 6 -i $INTERNAL_NET
		iptables -t mangle -A POSTROUTING -t mangle -j MARK -d 192.168.1.9 --set-mark 8
		;;
	stop)
		iptables -t mangle -D PREROUTING -t mangle -j MARK -s 192.168.1.9 --set-mark 6 -i $INTERNAL_NET
		iptables -t mangle -D POSTROUTING -t mangle -j MARK -d 192.168.1.9 --set-mark 8
		;;
	status)
		iptables -t mangle -L -v
		;;
	*)
		echo "Usage: $0 {start|stop}"
		exit 1
		;;
esac

(he's IP 192.168.1.9 of course, you should replace it with bkbits.net
and tweak the 64kbit output/16k input with the input/output bandwith you
want to give to bkbits)

BTW, I still wonder how to rsync the bkcvs coherently? (and I wonder how
can Peter sync it synchronous too if you don't give him a pair of
sequence numbers or a fcntl lock, personally I prefer the sequence
numbers so it works for pure read only too like the rsync on kernel.org)

Andrea
