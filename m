Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVDANJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVDANJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 08:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVDANJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 08:09:26 -0500
Received: from dea.vocord.ru ([217.67.177.50]:34285 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262736AbVDANHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 08:07:31 -0500
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
	based on kenel connector.
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
In-Reply-To: <20050401032023.3d05d42f.akpm@osdl.org>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	 <20050331162758.44aeaf44.akpm@osdl.org> <1112337814.9334.42.camel@uganda>
	 <20050331232625.09057712.akpm@osdl.org> <1112341514.9334.103.camel@uganda>
	 <20050331235927.6d104665.akpm@osdl.org> <1112345400.9334.157.camel@uganda>
	 <20050401012547.68c26523.akpm@osdl.org> <1112350615.9334.194.camel@uganda>
	 <20050401023004.2a83dbe5.akpm@osdl.org> <1112352955.9334.225.camel@uganda>
	 <20050401032023.3d05d42f.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MQcWNfQuGPbFQKlxk7mF"
Organization: MIPT
Date: Fri, 01 Apr 2005 17:12:57 +0400
Message-Id: <1112361177.12969.23.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 17:06:26 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MQcWNfQuGPbFQKlxk7mF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-01 at 03:20 -0800, Andrew Morton wrote:=20
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > On Fri, 2005-04-01 at 02:30 -0800, Andrew Morton wrote:
> > > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > >
> > > > > > keventd does very hard jobs on some of my test machines which=20
> > > > > > for example route big amount of traffic.
> > > > >=20
> > > > > As I said - that's going to cause _your_ kernel thread to be slow=
ed down as
> > > > > well.
> > > >=20
> > > > Yes, but it does not solve peak performance issues - all scheduled
> > > > jobs can run one after another which will decrease insert performan=
ce.
> > >=20
> > > Well the keventd handler would simply process all currently-queued
> > > messages.  It's not as if you'd only process one event per keventd ca=
llout.
> >=20
> > But that will hurt insert performance.
>=20
> Why?  All it involves is one schedule_work() on the insert side.  And tha=
t
> will involve just a single test_bit() in the great majority of cases
> because the work will already be pending.

Here is example:
schedule_work();
keventd->cbus_process(), which has 2 variants:
1. process all pending events.
2. process only number of them.

In the first case we will hurt very noticeble insert performance,
because actual delivery takes some time, so one process will
take time_for_one_delivery * number_of_events_to_be_delivered,=20
since in a peak number_of_events_to_be_delivered may be very high,
it will take too much time to flush the event queue and deliver all=20
messages.

In the second case we finish our work in predictible time,=20
but it can not help us with the keventd, which may [and is] cought
new schedule_work(), and thus will run cbus_process() again
without time window after previous delivering.

That time window is _very_ helpfull for the insert performance
and thus low latencies.

> > Processing all messages without splitting them up into pieces noticebly
> > slows insert operation down.
>=20
> What does "splitting them up into pieces" mean?  They're single messages
> end-to-end.  You've been discussing batching of messages, which is the
> opposite?

There is a queue of single event messages, if we process them all in one
shot,=20
then there is no time to insert new event [each CPU is running keventd
thread]
untill all previous are sent.
So we split that queue into pieces of [currently] 10 messages in each,=20
and send only them, then we sleep for some time, in which new inserts=20
can be completed, then process next 10...

> > > (please remind me why cbus exists, btw.  What functionality does it o=
ffer
> > > which the connector code doesn't?)
> >=20
> > The main goal of CBUS is insert operation performance.
> > Anyone who wants to have maximum delivery speed should use direct
> > connector's
> > methods instead.
>=20
> Delivery speed is not the same thing as insertion speed.  All the inserti=
on
> does is to place the event onto an internal queue.  We still need to do a
> context switch and send the thing.  Provided there's a reasonable amount =
of
> batching, the CPU consumption will be the same in both cases.

Sending is slow [in comparison to insertion], so it can be deferred=20
for better latency.
Context switch and actuall sending will happen after main function(like
fork(),=20
or any other in fast path) is already finished, so we do not hurt it's
performance.

> > > > > Introducing an up-to-ten millisecond latency seems a lot worse th=
an some
> > > > > reduction in peak bandwidth - it's not as if pumping 100000 event=
s/sec is a
> > > > > likely use case.  Using prepare_to_wait/finish_wait will provide =
some
> > > > > speedup in SMP environments due to reduced cacheline transfers.
> > > >=20
> > > > It is a question actually...
> > > > If we allow peak processing, then we _definitely_ will have insert=20
> > > > performance degradation, it was observed in my tests.
> > >=20
> > > I don't understand your terminology.  What is "peak processing" and h=
ow
> > > does it differ from maximum insertion rate?
> > >=20
> > > > The main goal of CBUS was exactly insert speed
> > >=20
> > > Why?
> >=20
> > To allow connector usage in a really fast pathes.
> > If one cares about _delivery_ speed then one should use cn_netlink_send
> > ().
>=20
> We care about both insertion and delivery!  Sure, simply sticking the eve=
nt
> onto a queue is faster than delivering it.  But we still need to deliver =
it
> sometime so there's no aggregate gain.  Still confused.

If one needs low latency events in peaks - use CBUS, it will smooth=20
shapes, since actual delivering will be postponed.

There is no _aggregate_ gain - only immediate low latenciy with work
deferring.

> > > > - so
> > > > it somehow must smooth shape performance peaks, and thus
> > > > above budget was introdyced.
> > >=20
> > > An up-to-ten-millisecond latency between the kernel-side queueing of =
a
> > > message and the delivery of that message to userspace sounds like an
> > > awfully bad restriction to me.  Even one millisecond will have impact=
 in
> > > some scenarios.
> >=20
> > If you care about delivery speed stronger than insertion,=20
> > then you do not need to use CBUS, but cn_netlink_send() instead.
> >=20
> > I will test smaller values, but doubt it will have better insert
> > performance.
>=20
> I fail to see why it is desirable to defer the delivery.  The delivery ha=
s
> to happen some time, and we've now incurred additional context switch
> overhead.

Yes, but if we care about low latencies, so we MUST defer work, even
if later it will cost additional context switch.

> > Concider fork() connector - it is better for userspace
> > to return from system call as soon as possible, while information
> > delivering
> > about that event will be delayed.
>=20
> Why?  The amount of CPU required to deliver the information regarding a
> fork is the same in either case.  Probably more, in the deferred case.

But latency is much smaller.

> > Noone says that queueing is done in much higher rate then delivering,=20
> > it only shapes shart peaks when it is unacceptably to wait untill
> > delivery
> > is finished.
>=20
> Maybe cbus gave better lmbench numbers because the forking was happening =
on
> one CPU and the event delivery was pushed across to the other one.  OK fo=
r
> a microbenchmark, but dubious for the real world.
>=20
> I can see that there might be CPU consumption improvements due to the
> batching of work and hence more effective CPU cache utilisation.  That
> would need to be carefully measured, and you'd get the same effect by
> simply doing a list_add+schedule_work for each insertion.

Andrew, CBUS is not intended to be faster than connector itself,=20
it is just not possible, since it calls connector's methods
with some preparation, which takes time.

CBUS was designed to provide very fast _insert_ operation.
It is needed not only for fork() accounting, but for any
fast path, when we do not want to slow process down just to
send notification about it, instead we can create such a notification,
and deliver it later.
Why do we defer all work from HW IRQ into BH context?
Because while we are in HW IRQ we can not perform other tasks,
so with connector and CBUS we have the same situation.
While we are sending a low priority event, we stops actuall work,
which is not acceptible in many situations.

> > > > > > I did not try that case with the keventd but with one kernel th=
read=20
> > > > > > it was tested and showed worse performance.
> > > > >=20
> > > > > But your current implementation has only one kernel thread?
> > > >=20
> > > > It has a budget and timeout between each bundle processing.
> > > > keventd does not allow to create such a timeout between each bundle
> > > > processing.
> > >=20
> > > Yes, there's batching there.  But I don't understand why the ability =
to
> > > internally queue events at a high rate is so much more important than=
 the
> > > latency which that batching will introduce.
> >=20
> > With such mechanism we may use event notification in a really fast
> > pathes.
> > We always defer actuall work processing out from HW interrupts,=20
> > although for the task running from that interrupt it would be better
> > to steal the whole CPU and run there [in HW irq] until it finishes.
>=20
> I agree that there are advantages to queueing the event and sending it
> later: it allows events to be sent from IRQ context and is more CPU-cache
> friendly.


The main idea is not to speed up message delivering,=20
but to not hurt existing fast pathes, when we insert some
notification delivering into it.

> But the up-to-ten millisecond latency probably makes this thing pretty
> useless for everything except the fork() application.
>=20
> And queueing up arbitrary numbers of objects in this manner is a design
> problem: if the generator is generating events faster than the kernel
> thread can deliver them, we'll kill the machine.

Yes, it is known issue, I introduced queue length in the CBUS for that too,
I think when it exceeds some threshold, CBUS will just directly call
cn_netlink_send(), and thus remove possible DOS.
Or do you have other ideas?

> > > (And keventd _does_ allow such batching.  schedule_delayed_work()).
> >=20
> > And it is still unacceptible, since there may be too many events
> > delayed to the same time, so they all will be processed in the same
> > time,=20
> > which will hurt insert operation performance.
>=20
> Why?  It's equivalent to the msleep(10).

But there will be several works, one will sleep,=20
but others will work without time window.

time [msec]          work
0                    schedule_delayed_work(w1, 10);
0                    schedule_delayed_work(w2, 10);
0                    schedule_delayed_work(w3, 10);
0                    schedule_delayed_work(w4, 10);
0                    schedule_delayed_work(w5, 10);
0                    schedule_delayed_work(w6, 10);
...
10                   cbus_process();
10+time*1                   cbus_process();
10+time*2                   cbus_process();
10+time*3                   cbus_process();
10+time*4                   cbus_process();
10+time*5                   cbus_process();

There will be no sleep between cbus_process() and next call,=20
so there will not be any timewindow for others.


Or do you mean call schedule_delayed_process() only from cbus_process()?
It can be a case, but it will not allow convenient manipulation,
like removing CBUS - it will require flushing all keventd works
just to one cbus_process() call.
And it was prooven that having only one sending thread hurts=20
performance smaller.

I tested it with SMP kernel on 1-way and 2-way systems.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-MQcWNfQuGPbFQKlxk7mF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTUjZIKTPhE+8wY0RArCHAJ4qUjaTxqnY4/3OgO/nMCo7d57VRwCfRpDg
jvz03XGDWHGHzFlUUd0qlvg=
=xN+h
-----END PGP SIGNATURE-----

--=-MQcWNfQuGPbFQKlxk7mF--

