Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267520AbUIBGFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbUIBGFJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 02:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUIBGFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 02:05:09 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:44230 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S267520AbUIBGDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 02:03:20 -0400
Subject: Re: [Linux-cluster] New virtual synchrony API for the kernel: was
	Re: [Openais] New API in openais
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Daniel Phillips <phillips@redhat.com>
Cc: linux-cluster@redhat.com, John Cherry <cherry@osdl.org>,
       openais@lists.osdl.org, linux-kernel@vger.kernel.org,
       linux-ha-dev@new.community.tummy.com
In-Reply-To: <200409011115.45780.phillips@redhat.com>
References: <1093941076.3613.14.camel@persist.az.mvista.com>
	 <1093973757.5933.56.camel@cherrybomb.pdx.osdl.net>
	 <1093981842.3613.42.camel@persist.az.mvista.com>
	 <200409011115.45780.phillips@redhat.com>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1094104992.5515.47.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 23:03:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 08:15, Daniel Phillips wrote:
> Hi Steven,
> 
> (here's the rest of that message)
> 
> On Tuesday 31 August 2004 15:50, Steven Dake wrote:
> > It would be useful for linux cluster developers for a common low
> > level group communication API to be agreed upon by relevant clusters
> > projects.  Without this approach, we may end up with several systems
> > all using different cluster communication & membership mechanisms
> > that are incompatible.
> 
> To be honest, this does look interesting, however could you help me on a 
> few points:
> 
>   - Is there any evil IP we have to worry about with this?
> 

I have not done any patent search, however, I am not aware of any
patents that apply.

The evs API is not an SA Forum API, but rather an API that projects
could use to implement cluster services or applications (one of those
being AIS).

The EVS api is developed by the openais project which licenses all code
under the Revised BSD license.  I would also be happy to license the API
header files, code, etc under a dual license, where the two licenses are
Revised BSD and GPL.

openais group messaging uses crypto code provided by the libtomcrypt
project under a fully public domain license.  These crypto libraries
provide encryption and authentication, but the code could work without
them (insecurely).

>   - Can I get a formal interface spec from AIS for this, without
>     signing a license?
> 

The EVS interface, as all code in openais, is available under Revised
BSD and hence, it does require living up to the requirements of the
Revised BSD license.  But this is a commonly accepted open source
license so this shouldn't be too much problem.

The EVS API has little to do with SA Forum itself, other then it is
implemented in a project which also aims to implement the SA Forum
APIs.  The copyright and license requirements of the SA Forum do not
apply to the EVS api.

I think we still need some work to hammer out the last details of the
EVS API, but if we work together we can probably come to some agreement
about what else is needed by the API.  The current api is very simple. 
I am working on man pages now and should have them posted in a few days.

I'm happy to change the API if we can still come to some agreement that
virtual synchrony is a requirement of the API..

>   - Have you got benchmarks available for control and normal messaging?
> 

there is a tool called evsbench in the openais distribution which can be
used to print out various benchmarks for various loads.  I modified some
of the parameters of the benchmark to start at 100 bytes and increase
writes by 100 bytes per run.

In a two processor cluster, made of 1.6GHZ Xeon with 1 GB ram using a
Netgear 100 mbit switch, I get the following performance at 70% cpu
usage as measured with top (80% of this is encryption/authentication):

100000 Writes   100 bytes per write  12.788 Seconds runtime  7820.022
TP/s   0.782 MB/s.
90000 Writes   200 bytes per write  11.012 Seconds runtime  8172.742
TP/s   1.635 MB/s.
81000 Writes   300 bytes per write  10.139 Seconds runtime  7989.066
TP/s   2.397 MB/s.
72900 Writes   400 bytes per write   9.685 Seconds runtime  7527.315
TP/s   3.011 MB/s.
65610 Writes   500 bytes per write  10.583 Seconds runtime  6199.683
TP/s   3.100 MB/s.
59049 Writes   600 bytes per write   9.309 Seconds runtime  6343.239
TP/s   3.806 MB/s.
53144 Writes   700 bytes per write   7.333 Seconds runtime  7247.023
TP/s   5.073 MB/s.
47829 Writes   800 bytes per write   6.743 Seconds runtime  7092.640
TP/s   5.674 MB/s.
43046 Writes   900 bytes per write   5.713 Seconds runtime  7534.503
TP/s   6.781 MB/s.
38741 Writes  1000 bytes per write   5.253 Seconds runtime  7374.890
TP/s   7.375 MB/s.
34866 Writes  1100 bytes per write   4.731 Seconds runtime  7369.611
TP/s   8.107 MB/s.
31379 Writes  1200 bytes per write   4.471 Seconds runtime  7018.992
TP/s   8.423 MB/s.
28241 Writes  1300 bytes per write   4.236 Seconds runtime  6667.422
TP/s   8.668 MB/s.

Your results may be different depending on the quality of your network. 
The EVS api is designed to work in networks that are extremely lossy
(99.9+% packet loss), but optimizes for networks that lose very few
packets (1 in 10^10 packets loss rate expected).

Without encryption or authentication, I've measured 10 MB/sec for
maximum packet size which is about 1306 bytes in the current
implementation.

Performance in more processor clusters is not affected too negatively,
perhaps less then .1% in throughput.  I have measured 12 node clusters
of various speeds at 8.4mb/sec total available throughput.  The maximum
throughput of one node does decrease, however, as nodes are added.  I've
measured a very long time ago something like 5-6mb/sec for one node, but
its been a long time, so I suggest testing this yourself if your
interested in that number.

>   - Have you looked at the barrier subsystem in sources.redhat.com/dlm?
>     Could this be used as a primitive in implementing Virtual Synchrony?

Virtual synchrony can be iplemented in atleast 4 ways that I am aware
of.  The method used in openais is called the ring protocol.  It may be
possible to implement VS/EVS in a different fashion, however, the ring
protocol in the research has the best performance and reliability.

>   - Why would we need to worry about the AIS spec, in-kernel?  What
>     would stop you from providing an interface that presented some
>     kernel functionality to userspace, with the interface of your
>     choice, presumably AIS?
> 
Yes this is the proposal on the table.  Implement EVS API in the kernel,
and then AIS could be implemented on top of this EVS API in userland. 
Also, this would allow other applications such as redhat's GFS to use
the EVS API in kernel.  This way everyone wins with a common messaging
API.

I also believe it would be possible to support multiple communication
mechanisms with a protocol driver per protocol.  Of these, TIPC and
openais's gmi would be prime candidates if someone does the work.

>   - Why isn't Virtual Synchrony overkill, since we don't attempt to
>     deal with netsplits by allowing subclusters to continue to operate?
> 
Any distributed system must absolutely deal with partitions and merges. 
Think of the most common partition, where 1 processor dies.  This is a
very common case that must be handled correctly.  But EVS provides many
other benefits beyond partitions and merges (although this is the main
benefit).

>   - In what way would GFS benefit from using Virtual Synchrony in place
>     of its current messaging algorithms?
> 

Performance, security, and most important reliability.  Even though its
a little long, I'll cut and paste from the openais
(developer.osdl.org/dev/openais) README.devmap.  There is an interesting
peice that describes how easily a lock service could be implemented in a
virtual syncrhony system because of the agreed ordering property.

processor: a system responsible for executing the virtual synchrony
model
configuration: the list of processors under which messages are delivered
partition: one or more processors leave the configuration
merge: one or more processors join the configuration
group messaging: sending a message from one sender to many receivers

Virtual synchrony is a model for group messaging.  This is often
confused with particular implementations of virtual synchrony.  Try to
focus on what virtual syncrhony provides, not how it provides it, unless
interested in working on the group messaging interface of openais.

Virtual synchrony provides several advantages:

 * integrated membership
 * strong membership guarantees
 * agreed ordering of delivered messages
 * same delivery of configuration changes and messages on every node
 * self-delivery
 * reliable communication in the face of unreliable networks
 * recovery of messages sent within a configuration where possible
 * use of network multicast using standard UDP/IP

Integrated membership allows the group messaging interface to give
configuration change events to the API services.  This is obviously
beneficial to the cluster membership service (and its respective API0,
but is helpful to other services as described later.

Strong membership guarantees allow a distributed application to make
decisions based upon the configuration (membership).  Every service in
openais registers a configuration change function.  This function is
called whenever a configuration change occurs.  The information passed
is the current processors, the processors that have left the
configuration, and the processors that have joined the configuration. 
This information is then used to make decisions within a distributed
state machine.  One example usage is that an AMF component
running a specific processor has left the configuration, so failover
actions must now be taken with the new configuration (and known
components).  

Virtual synchrony requires that messages may be delivered in agreed
order.  FIFO order indicates that one sender and one receiver agree on
the order of messages sent.  Agreed ordering takes this requirement to
groups, requiring that one sender and all receivers agree on the order
of messages sent.

Consider a lock service.  The service is responsible for arbitrating
locks between multiple processors in the system.  With fifo ordering,
this is very difficult because a request at about the same time for a
lock from two seperate processors may arrive at all the receivers in
different order.  Agreed ordering ensures that all the processors are
delivered the message in the same order.  

In this case the first lock message will always be from processor X,
while the second lock message will always be from processor Y.   Hence
the first request is always honored by all processors, and the second
request is rejected (since the lock is taken).  This is how race
conditions are avoided in distributed systems.

Every processor is delivered a configuration change and messages within
a configuration in the same order.  This ensures that any distributed
state machine will make the same decisions on every processor within the
configuration.  This also allows the configuration and the messages to
be considered when making decisions.

Virtual synchrony requires that every node is delivered messages that it
sends.  This enables the logic to be placed in one location (the handler
for the delivery of the group message) instead of two seperate places. 
This also allows messages that are sent to be ordered in the stream of
other messages within the configuration.

Certain guarantees are required of virtually synchronous systems.  If
a message is sent, it must be delivered by every processor unless that
processor fails.  If a particular processor fails, a configuration
change occurs creating a new configuration under which a new set of
decisions may be made.  This implies that even unreliable networks must
reliably deliver messages.   The implementation in openais works on
unreliable as well as reliable networks.

Every message sent must be delivered, unless a configuration change
occurs.  In the case of a configuration change, every message that can
be recovered must be recovered before the new configuration is
installed.  Some systems during partition won't continue to recover
messages within the old configuration even though those messages can be
recovered.  Virtual synchrony makes that impossible, except for those
members that are no longer part of a configuration.

Finally virtual syncrhony takes advantage of hardware multicast to avoid
duplicated packets and scale to large transmit rates.  On 100mbit
network, openais can approach wire speeds depending on the number of
messages queued for a particular processor.

What does all of this mean for the developer?

 * messages are delivered reliably
 * messages and configuration changes are delivered in the same order to
all processors
 * configuration and messages can both be used to make decisions


Thanks
-steve

> Regards,
> 
> Daniel

