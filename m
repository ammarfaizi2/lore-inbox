Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270984AbTHBCIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 22:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270989AbTHBCIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 22:08:23 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:54973
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S270984AbTHBCIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 22:08:18 -0400
Subject: Re: [SHED][IO-SHED] Are we missing the big picture?
From: Ian Kumlien <pomac@vapor.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F2B18A4.6010407@cyberone.com.au>
References: <1059697921.30747.54.camel@big.pomac.com>
	 <3F2A0863.5070806@cyberone.com.au> <1059740304.5285.60.camel@big.pomac.com>
	 <3F2B18A4.6010407@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KVvXr6zsO91gtvMKkMXd"
Message-Id: <1059790020.5285.104.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 02 Aug 2003 04:07:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KVvXr6zsO91gtvMKkMXd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-08-02 at 03:49, Nick Piggin wrote:
> Ian Kumlien wrote:
>=20
> >On Fri, 2003-08-01 at 08:27, Nick Piggin wrote:
> >
> >>To start with its CFQ. Also could you clarify what you mean by
> >>load and what you mean by CFQ doing nothing, and why AS is overhead
> >>in the no load case. I can't really follow what you are saying.

> >CFQ passes the req's on directly until there is enough load... In the
> >load case it builds queues. Just like SFQ (but sfq can drop packets
> >afair).
> >

> What do you mean? CFQ merges and sorts requests, and it services
> each process in a round robin manner. I don't have the CFQ code
> at hand, but I don't think it does anything different in the
> "load" case.

Yes, i thought it worked in a different manner, as Jens Axboe pointed
out. I was under the impression that it worked differently.

> >This way, we wouldn't have the initial
> >'can-we-merge-this-with-other-data-coming' delay when not needed.

> No that is what queue plugging can be used for.

Queue plugging?

> >If as could be attached to the 'queue build up' then AS would only be
> >doing what it's good at, throughput and minimizing head movements.

> No, AS does only try to do what it is good at. As complex as it
> is, its meant to be almost as simple as possible.

Oh? from what i've gathered from my somewhat on and off readings of lkml
i thought that 1, AS added a delay to gather additional requests prior
to sending the request to the disk. 2, (as i found out now) it also
waits before moving the head.

Thats what i wanted to by pass in the "hey, i'm just loading my 10 bytes
config file, and nothing else is happening" scenario.

> >Also patches that move prioritized data (data for processes with high
> >pri) would fit right in there since you'd only be doing it during actual
> >load.

> I'm sorry but I'm having trouble working out what you are trying to say.
> The disk gets its work in the form of a request. Linux keeps a queue of
> outstanding requests for each disk. The IO schedulers are a layer between
> the disk (driver) and the request queue. They get to choose the next
> request that goes to the disk. AS is only set apart because it sometimes
> chooses not to send a request at all even if there are some available.

Which sounds odd...=20

> Now what do you mean by disk load? And actual load? I can imagine that
> if there are no requests you would say there is no load on the disk. If
> there is 1 request there must be some actual load? Maybe you mean more
> than 1 process with outstanding requests?

Lets say that when the request queue has reached a certain length, the
disk is loaded.

I also have to say that i have no clue of the kernels real inner
workings esp not the io layer. I have only played with QoS, and i
started when it was undocumented.. =3D).

Lets say that we could use a CBQ queue with the right bw limits. Now,
lets say that when 70% of that bw is filled, we use a diff approach to
treating the data... We might drop new syns since we might be paranoid
about getting DoSed (stupid example, i know).

Now, Translate this in to the IO part. When we have a request backlog
for X entries during Y 'timeunits' we use a diff way to access the disk.
And since we know that when this mode is triggered, we have a backlog of
requests that we can just feed AS and thus make as do it's best.
Lower latency on small things and better throughput, what could be wrong
about that?

[Side note: In my understanding of SFQ it does 'nothing' to data that
can be sent directly, but queues when it can't (due to load)]

[Also: load is just a very fuzzy term for something that might be highly
complex. ie, the right value for the job in determining how the request
should be handled.]

--=20
Ian Kumlien <pomac@vapor.com>

--=-KVvXr6zsO91gtvMKkMXd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/KxzE7F3Euyc51N8RAm3uAJoDcgVKr4/DcHRpQPW1ZtPfVsQsvgCfaMut
FFP+7y/zOy2NdROB+Fj6QkU=
=qpZe
-----END PGP SIGNATURE-----

--=-KVvXr6zsO91gtvMKkMXd--

