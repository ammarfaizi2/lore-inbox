Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262185AbSIZFPD>; Thu, 26 Sep 2002 01:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbSIZFPD>; Thu, 26 Sep 2002 01:15:03 -0400
Received: from dp.samba.org ([66.70.73.150]:37852 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262185AbSIZFPC>;
	Thu, 26 Sep 2002 01:15:02 -0400
Date: Thu, 26 Sep 2002 15:19:33 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: nf@hipac.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification for Netfilter
Message-Id: <20020926151933.2e8cb171.rusty@rustcorp.com.au>
In-Reply-To: <20020925.155246.41632313.davem@redhat.com>
References: <200209260041.56374.nf@hipac.org>
	<20020925.155246.41632313.davem@redhat.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002 15:52:46 -0700 (PDT)
"David S. Miller" <davem@redhat.com> wrote:

> We have to do the route lookup anyways, if it got you to the packet
> filtering tables (or ipsec encap information, or TCP socket, etc etc)
> as a side effect, lots of netfilter becomes superfluous because all it
> is doing is maintaining these lookup tables etc. which is what you are
> optimizing.

Indeed.  Note that netfilter infrastructure had this from the beginning, but
it sits unused (skb->nf_cache), awaiting someone to get enthusiastic.

There are three real issues:
1) You need a way to say "too hard, don't cache this".  We have
   NFC_UNKNOWN (I looked at some packet field you don't have a bit for)
   and NFC_UNCACHABLE (give me every packet dammit!).

2) You need a sane "selective flush" mechanism for timeouts and rule changes
   (eg. connection tracking and nat).

3) If you want to keep counters in the subsystems (eg. iptables keeps packet
   and byte counters at the moment for every rule because it's easy). You
   need to keep this info in your route cache, then call the subsystems when
   you evict something from the cache.

Cheers!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
