Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130620AbQKCRdt>; Fri, 3 Nov 2000 12:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130896AbQKCRdj>; Fri, 3 Nov 2000 12:33:39 -0500
Received: from web5201.mail.yahoo.com ([216.115.106.95]:42769 "HELO
	web5201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130620AbQKCRdY>; Fri, 3 Nov 2000 12:33:24 -0500
Message-ID: <20001103173316.17356.qmail@web5201.mail.yahoo.com>
Date: Fri, 3 Nov 2000 09:33:16 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: 255.255.255.255 won't broadcast to multiple NICs
To: Philippe Troin <phil@fifi.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Philippe Troin <phil@fifi.org> wrote:
> Rob Landley <telomerase@yahoo.com> writes:
> > So the question is, is the stack's behavior right?
>  If
> > not, what's involved in fixing it, and if so, is
> it
> > documented anywhere?
> 
> I think historically, BSD stacks were routing
> 255.255.255.255 to the
> "primary interface" (whatever that means).

Yeah, that maps with what I've seen.

Apparently, the stack is stricly "one packet in, one
packet out", and only concerns itself with where to
send that packet.  So when a packet can go out more
than one interface (as in 255.255.255.255), the
broadcast nature of it doesn't actually cause the
packet to fork in the stack, it's treated like a load
balancing situation instead where one interface is
selected and the one packet is delivered.  (The
multiple delivery aspect is left solely to the
ethernet layer.  Despite being a broadcast packet, the
IP layer doesn't replicate the broadcast on an
interface level.)

I personally did not expect this behavior, I expected
the packet to go out all the interfaces.  And I still
think the behavior I expected makes more sense. 
However, if the behavior that's in the kernel now is
documented and what IP stacks the world over are
expected to do, I can certainly live with it. :)

It's entirely possible that the other platforms I
worked on before never had more than one NIC in a box
I actually used.  The fact I wasn't suprised by the
behavior I saw elsewhere could simply be because I
didn't try stuff on a box where the behavior would be
suprising.

That said, I still think 255.255.255.255 "should" go
out all interfaces (since gateways don't forward
broadcast packets anyway, it's not going to flood the
network or anything).  I suspect the "it works, leave
it alone" principle will apply here, but it'd be nice
to attract the attention of a networking guru like
Alan Cox, David S. Miller, or Donald Becker for a few
seconds to at least get shot down on this issue
decisively. :)

> All the code I've encountered which actually needed
> to perform
> broadcast on all interfaces was sending
> subnet-directed broadcasts by
> hand on all interfaces.

Unfortunately, I literally can't do that in this
instance.  (Yes, I've tried.)  The client and server
I'm writing are in Java.  There's two problems here.

1) It's for a heterogeneous render farm.  Linux boxes,
NT/2000 boxes, and SGI boxes at least.  Maybe someday
macintoshes too, and who knows what else.  (That's why
I'm writing it in Java in the first place.)

2) I'm trying to have it configure itself as much as
possible automatically.  A lot of the people using
render farms went to art college and liked it.  That's
why the broadcast packets (so the clients can find
their server and vice versa when everybody boots up,
without being told).  I don't want them to have to
tell it anything, I want them to throw it on the
machine and run it (quite possibly running all the
nodes from a shared mount) and just have it work. 
I've managed to avoid any node specific configuration
so far, and that makes things MUCH easier for my
expected user base.

3) Java sucks in many ways.  Today's way is that it
never occurred to Sun that a machine might have more
than one IP address assigned to it, so
InetAddress.getLocalHost() returns exactly one
address.  Unfortunately, just about EVERY machine has
two interfaces defined, the other one being loopback
on 127.0.0.1, and natrually the loopback is the one
that getLocalHost() returns.  (Since it's the one that
we pretty much already know the address of anyway, and
querying it is therefore useless, that's the one it
queries.  Thank you Sun.)  There is no way to query
the current machine's interfaces without resorting to
native code.

Bind to a socket to a local port and query that
address you say?  Nope, too easy.  The address
returned when I query a socket (rather than a
connection) is 0.0.0.0 on any machine with multiple
interfaces (even loopback), since the socket is bound
to that port on ALL the interfaces.  Each incoming or
outgoing connection does have a valid "from" IP
address, but I have to wait for a connection to come
in to get that.  (Unless I explicitly specify which IP
to bind to when I create the socket, but if I knew
that I'd already be there.)

Nope, making my own connection to a port on the same
machine just means 127.0.0.1 is talking to 127.0.0.1. 
Tried it.  Didn't work.

Nope, feeding the loopback address to getAllByName()
doesn't help either.  I tried that too, it just
returns a length 1 array containing just the loopback
address.

Now you know why I'm resorting to 255.255.255.255. 
I'm sort of faking things: when the server broadcasts
to clients they know who it is, and when they
broadcast to it, it knows who THEY are (it says in the
UDP datagram header info).  And the way I've written
it, that's all they really need to know (although when
we reply to each other we can each find out the info
we don't know: who WE are.  But by that point, we no
longer need it. :)

I may just document "if you run this on a machine with
more than one network card, you have to specify the
broadcast addresses on the command line".  It's
configuration, but the only machine likely to HAVE
multiple interfaces is the server (which could be
serving multiple subnets in a really BIG render farm),
so I suppose it's tolerable...

> Broadcast is ugly anyways, why don't you use
> multicast ?

I'm only passingly familiar with it, does it map well
to this problem?

The only data I'm trying to transmit is "where is
everybody", or "wake up".  The broadcast packets are
only needed for clients to find the server on bootup
(and vice versa if the server is rebooted).  They're
also used to wake up clients if they go to sleep
because the server has nothing for them to do at the
moment, but that second part's a convenience, really. 
The server could loop through and address them
individually instead since it knows where they are by
that point.

The actual heavy lifting of data is done by TCP/IP
streams.  UDP broadcast is just for figuring out where
to open the TCP/IP connections to.

> Phil.

Rob

__________________________________________________
Do You Yahoo!?
>From homework help to love advice, Yahoo! Experts has your answer.
http://experts.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
