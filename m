Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310432AbSCBT7P>; Sat, 2 Mar 2002 14:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310433AbSCBT7G>; Sat, 2 Mar 2002 14:59:06 -0500
Received: from trillium-hollow.org ([209.180.166.89]:38077 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S310432AbSCBT7A>; Sat, 2 Mar 2002 14:59:00 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: ja@ssi.bg (Julian Anastasov), szekeres@lhsystems.hu (Szekeres Bela),
        dang@fprintf.net (Daniel Gryniewicz),
        linux-kernel@vger.kernel.org (linux-kernel)
Subject: Re: Network Security hole (was -> Re: arp bug ) 
In-Reply-To: Your message of "Sat, 02 Mar 2002 19:14:55 GMT."
             <E16hEy7-000875-00@the-village.bc.nu> 
Date: Sat, 02 Mar 2002 11:58:43 -0800
From: erich@uruk.org
Message-Id: <E16hFeV-0000Nj-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Let's say you have a firewall running Linux.  Oops, I can spoof the
> > external interface to accept traffic as if it's the internal one.
> 
> ARP is irrelevant to security. You don't need the ARP layer to do any
> attacks or routing at all. There are a million ways to get the mac
> address of a box.

Oh, agreed.

The security hole is in the complicity of the other layers in this, in
my mind.  The ARP issue is mainly a bug that causes unexpected behavior
given this hole.

For example, in the testing situation that led me to looking into this
more, I was running 2 NICs, one 100Mbit and one Gigabit, in
each of 2 machines.  The 100Mbit NICs were on normal DHCP for my
subnet, and the Gigabit NICs were on the same physical network switch,
and I didn't set up a VLAN because it didn't seem to matter and was
a bit of a pain.  The traffic in one direction of my tests ended up
going into the 100Mbit inteface on the destination machine and being
throttled down to 100Mbit.

More below.


> > I.e. the machine still may be accepting traffic destined for one
> > interface on another, even though it won't *advertise* that fact
> > any more.
> 
> Its supposed to accept any packet for that system.  Thats correct
> behaviour for the system.
> 
> Thats why you can have firewall rules. You'll find the standard Red
> Hat firewall config tool sets up interface based rule sets. In fact,
> in general rules should be interface not address based.

I would argue that this is a work-around to a problem, serves no
useful purpose, and in general this is violating the "principle of
least surprise".

To put it clearly, I am arguing that the two "features":

  --  ARP responding on other interfaces.
  --  IP stack accepting packets destined for one interface on another.

...should at least be disabled by default because:

  1)  It's a security hole as configured by default.  Yet another
      thing that confuses end-users using Linux who wouldn't expect
      this behavior.

  2)  In my example above (and in fact any case of very asymmetric
      bandwidth) it ends up causing weird and highly suboptimal
      misbehavior.

  3)  I tested the idea of it being a "failover" kind of thing, as
      suggested by someone else in the earlier thread, and it
      didn't work because, at least for TCP, the TCP acks and
      such had to go out of the original interface.  I.e. it ends
      up doing asymmetric routing.  The outbound packets go from
      one interface, and the inbound packets come into the other.
      Removing the connection to the "correct" card killed the
      connection.  UDP would still work given no response was
      necessary, admittedly.  But a lot of UDP protocols use at
      least some kind of response, so you're dead there too.

  4)  Given the people who want this consider it a "feature" know
      about it or seek it out because they want something like it,
      why not burden *them* with turning it on rather than burdening
      those who don't know or care with the hill to climb of having
      to discover it's existence and disabling it because it causes
      strange effects/holes?


Can you give me an argument for why these should be present?  (like
some kind of use for it?)

Is this a UNIX semantics legacy thing I'm not familiar with??  but
I'm pretty sure FreeBSD for example doesn't do this...  at least not
the arp thing, because I saw warning messages from my FreeBSD boxen
about these weird arps.

I would think that making the IP stack, for each MAC/interface path
on reception, just check against the exact expected input address,
would actually be a performance improvement on machines with multiple
NICs.

As to the failover concept, Linux already has channel bonding, which
is the right way to do this and actually works when you take one
of them offline/unplug one.  There are a few unusual kind of hacks
you can't do with channel bonding, say like having a card pretend it's
another one in some ways but still think it's part of another IP
interface...  but that doesn't really happen in the current situation
anyway, so I again don't see any kind of argument that this is
actually useful in any way.


--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
