Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVA2HY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVA2HY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 02:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbVA2HY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 02:24:59 -0500
Received: from science.horizon.com ([192.35.100.1]:37693 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262874AbVA2HYe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 02:24:34 -0500
Date: 29 Jan 2005 07:24:29 -0000
Message-ID: <20050129072429.24845.qmail@science.horizon.com>
From: linux@horizon.com
To: lorenzo@gnu.org
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It adds support for advanced networking-related randomization, in
> concrete it adds support for TCP ISNs randomization

Er... did you read the existing Linux TCP ISN generation code?
Which is quite thoroughly randomized already?

I'm not sure how the OpenBSD code is better in any way.  (Notice that it
uses the same "half_md4_transform" as Linux; you just added another copy.)
Is there a design note on how the design was chosen?


I don't wish to be *too* discouraging to someone who's *trying* to help,
but could you *please* check a little more carefully in future to
make sire it's actually an improvement?

I fear there's some ignorance of what the TCP ISN does, why it's chosen
the way it is, and what the current Linux algorithm is designed to do.
So here's a summary of what's going on.  But even as a summary, it's
pretty long...


First, a little background on the selection of the TCP ISN...

TCP is designed to work in an environment where packets are delayed.
If a packet is delayed enough, TCP will retransmit it.  If one of
the copies floats around the Internet for long enough and then arrives
long after it is expected, this is a "delayed duplicate".

TCP connections are between (host, port, host port) quadruples, and
packets that don't match some "current connection" in all four fields
will have no effect on the current connection.  This is why systems try
to avoid re-using source port numbers when making connections to
well-known destination ports.

However, sometimes the source port number is explicitly specified and
must be reused.  The problem then arises, how do we avoid having any
possible delayed packets from the previous use of this address pair show
up during the current connection and confuse the heck out of things by
acknowledging data that was never received, or shutting down a connection
that's supposed to stay open, or something like that?

First of all, protocols assume a maximum packet lifetime in the Internet.
The "Maximum Segment Lifetime" was originally specified as 120 seconds,
but many implementations optimize this to 60 or 30 seconds.  The longest
time that a response can be delayed is 2*MSL - one delay for the packet
eliciting the response, and another for the response.

In truth, there are few really-hard guarantees on how long a packet can
be delayed.  IP does have a TTL field, and a requirement that a packet's
TTL field be decremented for each hop between routers *or each second of
delay within a router*, but that latter portion isn't widely implemented.
Still, it is an identified design goal, and is pretty reliable in
practice.


The solution is twofold: First, refuse to accept packets whose
acks aren't in the current transmission window.  That is, if the
last ack I got was for byte 1000, and I have sent 1100 bytes
(numbers 0 through 1099), then if the incoming packet's ack isn't
somewhere between 1000 and 1100, it's not relevant.  If it's
950, it might be an old ack from the current connection (which
doesn't include anything interesting), but in any case it can be
safely ignored, and should be.

The only remaining issue is, how to choose the first sequence number
to use in a connection, the Initial Sequence Number (ISN)?

If you start every connection at zero, then you have the risk that
packets from an old connection between the same endpoints will
show up at a bad time, with in-range sequence numbers, and confuse
the current connection.

So what you do is, start at a sequence number higher than the
last one used in the old connection.  Then there can't be any
confusion.  But this requires remembering the last sequence number
used on every connection ever.  And there are at least 2^48 addresses
allowed to connect to each port on the local machine.  At 4 bytes
per sequence number, that's a Petabyte of storage...

Well, first of all, after 2*MSL, you can forget about it and use
whatever sequence number you like, because you know that there won't
be any old packets floating around to crash the party.

But still, it can be quite a burden on a busy web server.  And you might
crash and lose all your notes.  Do you want to have to wait 2*MSL before
rebooting?


So the TCP designers (I'm not on page 27 of RFC 793, if you want to follow
along) specified a time of day based ISN.  If you use a clock to generate
an ISN which counts up faster than your network connection can send
data (and thus crank up its sequence numbers), you can be sure that your
ISN is always higher than the last one used by an old connection without
having to remember it explicitly.

RFC 793 specifies a 250,000 bytes/second counting rate.  Most
implementations since Ethernet used a 1,000,000 byte/second counting
rate, which matches the capabilities of 10base5 and 10base2 quite well,
and is easy to get from the gettimeofday() call.

Note that there are two risks with this.  First, if the connection actually
manages to go faster than the ISN clock, the next connection's ISN will
be in the middle of the space the earlier connection used.  Fortunately,
the kind of links where significant routing delay appear are generally
slower ones where 1 Mbyte/sec is a not too unreasonable limit.  Your
gigabit LAN isn't going to be delaying packets by seconds.

The second is that a connection will be made and do nothing for 4294
seconds until the ISN clock is about to wrap around and then start
doing packets "ahead of" the ISN clock.  If it then closes the connection
and a new one opens, once again you have sequence number overlap.

If you read old networking papers, there were a bunch of proposals for
occasional sequence number renegotiation to solve this problem, but in the
end people decided to not worry about it, and it hasn't been a problem
in practice.



Anyway... fast forward out of the peace and love decade and welcome to
the modern Internet, with people *trying* to mess up TCP connections.
This kind of attack from within was, unfortunately, not one of the
scenarios that the initial Internet designers considered, and it's
been a bit of a problem since.

All this careful worry about packets left over from an old connection
randomly showing up and messing things up, when we have people *creating*
packets deliberately crafted to mess things up!  A whole separate problem.
In particular, using the simple timer-based algorithm, I can connect to
a server, look at the ISN it offers me, and know that thats the same
ISN it's offering to other people connecting at the same time.  So I
can create packets with a forged source address and approximately-valid
sequence numbers and bombard the connection with them, cutting off that
server's connection to some third party.  Even if I can't see any of
the traffic on the connection.

So people sat down and did some thinking.  How to deal with this?
Harder yet, how to deal with this without redesigning TCP from scratch?

Well, if a person wants to mess up their *own* connections, we can't
stop them.  The fundamental problem is that an attacker A can figure
out the sequence numbers that machines B and C are using to talk to
each other.  So we'd like to make the sequence numbers for every
connection unique and not related to the sequence numbers used on any
other connections.  So A can talk to B and A can talk to C and still not
be able to figure out the sequence numbers that B and C are using between
themselves.


Fortunately, it is entirely possible to combine this with the clock-based
algorithm and get the best of both worlds!  All we need is a random offset,
unique for every (address, port, address, port) quadruple, to add to
the clock value, and we have all of the clock-based guarantees preserved
within every pair of endpoints, but unrelated endpoints have their ISNs
at some unpredictable offset relative to each other.

And for generating such a random offset, we can use cryptography.
Keep a single secret key, and hash together the endpoint addresses,
and you can generate a random 32-bit ISN offset.  Add that to the
current time, and everything is golden.  A can connect to B and
see and ISN, but would need to do some serious cryptanalysis to
figure out what ISN B is using to talk to C.


Linux actually adds one refinement.  For speed, it uses a very
stripped-down cryptographic hash function.  To guard against that
being broken, it generates a new secret every 5 minutes.  So an
attacker only has 5 minutes to break it.

The cryptographic offset is divided into 2 parts.  The high 8 bits are
a sequence number, incremented every time the secret is regenerated.
The low 24 bits are produced by the hash.  So 5 minutes after booting,
the secret offset changes from 0x00yyyyyy to 0x01zzzzzz.  This is at
least +1, and at most +0x1ffffff.  On average, the count is going up
by 2^24 = 16 million every 300 seconds.  Which just adds a bit to the
basic "1 million per second" ISN timer.

The cost is that the per-connection part of the ISN offset is limited
to 24 and not 32 bits, but a cryptanalytic attack is pretty much
precluded by the every-5-minutes thing.  The rekey time and the number of
really-unpredictable bits have to add up to not wrapping the ISN space
too fast.  (Although the 24 bits could be increased to 28 bits without
quite doubling the ISN counting speed.  Or 27 bits if you want plenty
of margin.  Could I suggest that as an improvement?)

--- drivers/char/random.c	2004-12-04 09:24:19.000000000 +0000
+++ drivers/char/random.c	2005-01-29 07:20:37.000000000 +0000
@@ -2183,26 +2183,26 @@
 #define REKEY_INTERVAL	(300*HZ)
 /*
  * Bit layout of the tcp sequence numbers (before adding current time):
- * bit 24-31: increased after every key exchange
- * bit 0-23: hash(source,dest)
+ * bit 27-31: increased after every key exchange
+ * bit 0-26: hash(source,dest)
  *
  * The implementation is similar to the algorithm described
  * in the Appendix of RFC 1185, except that
  * - it uses a 1 MHz clock instead of a 250 kHz clock
  * - it performs a rekey every 5 minutes, which is equivalent
- * 	to a (source,dest) tulple dependent forward jump of the
+ * 	to a (source,dest) tuple dependent forward jump of the
  * 	clock by 0..2^(HASH_BITS+1)
  *
- * Thus the average ISN wraparound time is 68 minutes instead of
- * 4.55 hours.
+ * Thus the average ISN wraparound time is 49 minutes instead of
+ * 4.77 hours.
  *
  * SMP cleanup and lock avoidance with poor man's RCU.
  * 			Manfred Spraul <manfred@colorfullife.com>
  * 		
  */
-#define COUNT_BITS	8
+#define COUNT_BITS	5
 #define COUNT_MASK	( (1<<COUNT_BITS)-1)
-#define HASH_BITS	24
+#define HASH_BITS	27
 #define HASH_MASK	( (1<<HASH_BITS)-1 )
 
 static struct keydata {


Anyway, in comparison, the algorithm in your patch (and presumably
OpenBSD, although I haven't personally compared it) uses a clock
offset generated fresh for each connection.  There's a global counter
(tcp_rndiss_cnt; I notice you don't have any SMP locking on it) which
is incremented every time an ISN is needed.  It's rekeyed periodically,
and the high bit (tcp_rndiss_msb) of the delta is used like the COUNT_BITS
in the Linux algorithm.

The ISN is generated as the high sequence bit, then 15 bits of encrypted
count (with some homebrew cipher I don't recognize), then a constant
zero bit (am I reading that right), then the 15 low-order bits are
purely random.


It's a slightly different algorithm, but it does a very similar function.
The main downsides are that the sequence number can easily go backwards
(there's no guarantee that consecutive calls will return increasing
numbers since tcp_rndiss_encrypt scrambles the high 15 bits), and
that it's not SMP-safe.  Two processors could read and use the same
tcp_rndiss_cnt value at the same time, or (more likely) both call
tcp_rndiss_init at the same time and end up toggling tcp_rndiss_msb twice,
thereby destroying the no-rollback property it's trying to achieve.

Oh, and the single sequence bit in the offsets means that the
TCP ISN will wrap around very fast.  Every 10 minutes, or every
60000 TCP connections, whichever comes first.

Regarding the first issue, it's possible that the OpenBSD network stack
takes care to remember all connections for 2*MSL and continues the
sequence number if the endpoints are reused, thereby avoiding a call to
ip_randomisn entirely.

But the second deserves some attention.  The Linux code takes some care
to avoid having to lock anything in the common case.  The global count
makes that difficult.
