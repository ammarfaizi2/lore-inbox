Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132047AbQKDDQJ>; Fri, 3 Nov 2000 22:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132063AbQKDDP7>; Fri, 3 Nov 2000 22:15:59 -0500
Received: from web5205.mail.yahoo.com ([216.115.106.86]:26630 "HELO
	web5205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132047AbQKDDPy>; Fri, 3 Nov 2000 22:15:54 -0500
Message-ID: <20001104031547.13080.qmail@web5205.mail.yahoo.com>
Date: Fri, 3 Nov 2000 19:15:47 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: 255.255.255.255 won't broadcast to multiple NICs
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Philippe Troin <phil@fifi.org> wrote:
> Rob Landley <telomerase@yahoo.com> writes:

> The source IP address (as returned by getsockname())
> is only set when
> the socket is connected... It follows the same
> logic: for a multihomed
> machine, we know which interface will be used only
> when we know who
> we'll be talking to...

I know, it does make sense.  I'm not really blaming
Java for that one.  It's just yet another thing I
tried that didn't work.  The lack of a way to query
what the current addresses are directly is the only
reason I tried that as a potential workaround.  (If
it's going to return 0 unless you told it what the
address was in the first place, why do they have a
query address method on a server socket anyway?  Does
it serve a purpose?  Right...)

This isn't the most egregious oversight in java, by
the way.  The list is pretty long, but my vote goes
for being unable to truncate a file before Java 1.2. 
(There was no API for it.  Couldn't be done.  Period. 
getLength() was there, but setLength() wasn't.  And I
had to email them more than once before they'd admit
it was a bug...)

> You could use SIOGIFCONF (from C) to get the address
> list.

See "avoidance of native code" under the heading
"configuration details I don't want them to have to
deal with".  When I make platform specific installers
(which there will be for both Linux and NT/2000), i'll
throw a shell around it and feed info in on the
command line.  But a better solution is not having to
do it at all, which is the case for machines with one
NIC.

> I'm not sure is java has the equivalent...

It doesn't.

> Or maybe a very small native method...

Querying the system when it first runs and passing the
data onthe command line, maybe.  Running platform
specific native code during execution, no.

> > > Broadcast is ugly anyways, why don't you use
> > > multicast ?

Having looked into this question a bit more, I can now
answer:

Because broadcast is, in this case, a more elegant
solution, which requires less configuration (even NOT
working the way I expected), and (as far as I can
tell) is actually more efficient (in this case) in
terms of utilizing network resources, and has no known
scalability problems as used here, either. 
(Especially for the server, which is the most likely
bottleneck.)

The most common case here is that the server
broadcasts to all clients (either during boot or after
a period of inactivity).  In either case, when this
happens all clients are interested in hearing what the
server has to say.

The only time where this isn't the case is when an
individual client is rebooted and has to look for its
server.  This case is relatively rare (not a
scalability issue from a network traffic standpoint,
anyway, even Google only reboots around a hundred
boxen a day).  Only the server would respond to the
traffic here, so there's no broadcast storm.  (The
initial boot case is closer to that, but the response
is via TCP, not UDP.)  And I fail to see how multicast
improves the client reboot case.  If multicast ISN'T,
underneath it all, doing a broadcast at the MAC level,
then how is it supposed to find the server if it
doesn't know where it is?  So what have we gained?

And in any case, as long as the broadcast mechanism's
already been implemented for the first paragraph,
implementing a gratuitous second mechanism for a
fairly rare case is a gratuitous source of complexity
and potential bugs for no apparent reason.

> Sounds like a good job for multicast... It's fairly
> simple to use,
> but:

I still don't understand why you consider broadcast a
bad solution here.  (Other than aesthetic reasons.) 
If multicast requires configuration and the whole
point of the broadcast packets in the first place was
to AVOID configuration...  I missed something.

>   1) I'm not sure if java gives you access to the
> required ioctls
>      (there's only five of them).

It does (or at least claims to), but you still haven't
explained WHY multicast is a more elegant solution in
this case than broadcast.  Broadcast is actually the
same mechanism as sending targeted UDP packets to
hosts to wake them up, except the list I iterate
through is one address long.  Multicast is a
completely different mechanism.

You want to explain how multicast works to me down at
the MAC layer?  Is the server sending a small number
of broadcast MAC packets, or a large number of
individually MAC addressed packets to each host that
has registered itself as interested in these
broadcasts.  If the former, what's really changed?  If
the latter, how did they register themselves as
interested in the first place?

How about compatability?  Will it work on the various
flavors of windows box?  Will it work on an Irix box? 
Would it conceivably work on a power Mac?  I know
broadcast is at least theoretically present in every
networking stack there is, whereas multicast is an
option that has to be complied into the Linux kernel,
so I can't even count on it being there really.

(Art majors are NOT compliling kernels.  We're not
going there.  Maybe you'll say they'll never use a
distribution that doesn't have it.  Should this be an
undocumented dependency, or a documented dependency
they'll never read until our tech support people point
out that paragraph to them on the phone?)

>   2) You may need to run mrouted on all your
> gateways.

That would shoot it down conclusively right there, if
it weren't for the fact they're all on the same subnet
in the first place anyway.  (I'm NOT going to ask art
majors to reconfigure gateways.  That's not
happening.)

By the way, the broadcast solution I've already
implemented wouldn't WORK if I had gateways in here. 
Gateways don't forward broadcast packets.  (Unless the
server's being run on the gateway between the subnets,
which is where the multiple interface problem came up
in testing in the first place.)

As for explicit configuration bridging subnets (which
is in the design already, although running the server
program on the gateway box was a way of avoiding that
configuration anyway), why not just tell MY program
the extra config info (list of IPs or whatever)
instead of setting up unrelated routing daemons?

I have a goal in mind and am looking for the shortest,
simplest path to it, with the least dependencies and
complications.  I'm not promoting a specific tool
(multicast routing) and trying to see if the job can
be made to use that tool.  I'm actually doing the
opposite, trying to AVOID as many things as I can get
away with.

> Phil.

__________________________________________________
Do You Yahoo!?
Thousands of Stores.  Millions of Products.  All in one Place.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
