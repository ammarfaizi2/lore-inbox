Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262192AbSIZFk7>; Thu, 26 Sep 2002 01:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262193AbSIZFk7>; Thu, 26 Sep 2002 01:40:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39299 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262192AbSIZFk6>;
	Thu, 26 Sep 2002 01:40:58 -0400
Date: Wed, 25 Sep 2002 22:40:01 -0700 (PDT)
Message-Id: <20020925.224001.99456805.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: nf@hipac.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
 for Netfilter
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020926151933.2e8cb171.rusty@rustcorp.com.au>
References: <200209260041.56374.nf@hipac.org>
	<20020925.155246.41632313.davem@redhat.com>
	<20020926151933.2e8cb171.rusty@rustcorp.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Thu, 26 Sep 2002 15:19:33 +1000
   
   3) If you want to keep counters in the subsystems (eg. iptables keeps packet
      and byte counters at the moment for every rule because it's easy). You
      need to keep this info in your route cache, then call the subsystems when
      you evict something from the cache.

The flow cache, routing table, whatever you want to call it, doesn't
care what your info looks like, that will be totally private.

Actually the idea is that skb tagging would not be needed, the
skb->dst would _BE_ the tag.  From it you could get at all the
info you needed.

Draw a picture in your head as you read this.

The private information could be a socket, a fast forwarding path, a
stack of IPSEC decapsulation operations, netfilter connection tracking
info, anything.

So skb->dst could point to something like:

	struct socket_dst {
		struct dst_entry dst;
		enum dst_type dst_type;
		struct sock *sk;
	}

Here dst->input() would be tcp_ipv4_rcv().

It could just as easily be:

	struct nf_conntrack_dst {
		struct dst_entry dst;
		enum dst_type dst_type;
		struct nf_conntrack_info *ct;
	}

And dst->input() would be nf_conntrack_input(), or actually something
more specific.

See?

And when you have the "drop packet" firewall rule, the skb->dst then
points to nf_blackhole() (which perhaps logs the event if you need to
do that).

If you have things that must happen in a sequence to flow through
your path properly, that's where the "stackable" bit comes in.  You
do that one bit, skb->dst = dst_pop(skb->dst), then your caller
will pass the packet on to skb->dst->{output,input}().

Is it clearer now the kind of things you'll be able to do?

Stackable entries also allow encapsulation situations to propagate
precisely calculated PMTU information back to the transports.

Cached entries are created by demand, the level 2 lookup area is
where long term information sits.  The top level lookup engine
carries cached entries of whatever is active at a given moment,
that is why I refer to it as a flow cache sometimes.

All of this was concocted to do IPSEC in a reasonable way, but as a
nice side effect it ends up solving a ton of other problems too.  I
think some guy named Linus once told me that's the indication of a
clean design. :-)

...

Let me give another example of how netfilter could use this.  Consider
FTP nat stuff, you'd start with the "from TCP, any address/anyport, to
any address/ FTP port" DST.  This watches for new FTP connections, so
you can track them properly and do NAT or whatever else.  This
destination would drop anything other only than SYN packets.  It's
dst->input() would point to something like ftp_new_connection_input().

When you get a new connection, you create a destination which handles
the translation of specifically THAT ftp connection (ie. specific
instead of "any" addr/port pairs are used for the key).  Here,
dst->input() would point to ftp_existing_connection_input().
