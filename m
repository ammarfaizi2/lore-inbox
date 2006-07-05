Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWGEOKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWGEOKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWGEOKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:10:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:5791 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964875AbWGEOKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:10:34 -0400
Message-ID: <44ABC81F.6060405@watson.ibm.com>
Date: Wed, 05 Jul 2006 10:09:35 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hadi@cyberus.ca
CC: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	 <44A01A50.1050403@sgi.com>	 <20060626105548.edef4c64.akpm@osdl.org> <44A020CD.30903@watson.ibm.com>	 <20060626111249.7aece36e.akpm@osdl.org> <44A026ED.8080903@sgi.com>	 <20060626113959.839d72bc.akpm@osdl.org> <44A2F50D.8030306@engr.sgi.com>	 <20060628145341.529a61ab.akpm@osdl.org> <44A2FC72.9090407@engr.sgi.com>	 <20060629014050.d3bf0be4.pj@sgi.com>	 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	 <20060629094408.360ac157.pj@sgi.com>	 <20060629110107.2e56310b.akpm@osdl.org> <44A57310.3010208@watson.ibm.com>	 <44A5770F.3080206@watson.ibm.com> <20060630155030.5ea1faba.akpm@osdl.org>	 <44A5DBE7.2020704@watson.ibm.com> <44A5EDE6.3010605@watson.ibm.com>	 <20060630205148.4f66b125.akpm@osdl.org> <44A9881F.7030103@watson.ibm.com>	 <44A9BC4D.7030803@watson.ibm.com> <20060703180151.56f61b31.akpm@osdl.org>	 <1152018353.5214.14.camel@jzny2> <44AA86BF.3090600@watson.ibm.com>	 <44AA9951.1060804@watson.ibm.com> <1152041070.5276.29.camel!
 @jzny2>
In-Reply-To: <1152041070.5276.29.camel@jzny2>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> Shailabh,
> 
> On Tue, 2006-04-07 at 12:37 -0400, Shailabh Nagar wrote:
> [..]
> 
>>Here's a strawman for the problem we're trying to solve: get
>>notification of the close of a NETLINK_GENERIC socket that had
>>been used to register interest for some cpus within taskstats.
>>
>> From looking at the netlink code, the way to go seems to be
>>
>>- it maintains a pidhash of nl_pids that are currently
>>registered to listen to atleast one cpu. It also stores the
>>cpumask used.
>>- taskstats registers a notifier block within netlink_chain
>>and receives a callback on the NETLINK_URELEASE event, similar
>>to drivers/scsci/scsi_transport_iscsi.c: iscsi_rcv_nl_event()
>>
>>- the callback checks to see that the protocol is NETLINK_GENERIC
>>and that the nl_pid for the socket is in taskstat's pidhash. If so, it
>>does a cleanup using the stored cpumask and releases the nl_pid
>>from the pidhash.
>>
> 
> 
> Sound quiet reasonable.  I am beginning to wonder whether we should do 
> do the NETLINK_URELEASE in general for NETLINK_GENERIC

I'd initially thought that might be useful but since NETLINK_GENERIC
is only "virtually" multiplexing the sockfd amongst each of its users,
I don't know what benefits a generic notifier at NETLINK_GENERIC layer
would bring (as opposed to each NETLINK_GENERIC user directly registering
its callback with netlink). Perhaps simplicity ?


>>We can even do away with the deregister command altogether and
>>simply rely on this autocleanup.
> 
> 
> I think if you may still need the register if you are going to allow
> multiple sockets per listener process, no?

The register command, yes. But an explicit deregister, as opposed to
auto cleanup on fd close, may not be used all that much :-)

> The other question is how do you correlate pid -> fd?

For the notifier callback, I thought netlink_release will
provide the nl_pid correspoding to the fd being closed ?
I can just do a search for that nl_pid in the taskstats-private pidhash.

The nl_pid gets into the pidhash using the genl_info->pid field
when the listener issues the register command.

Will that be correct ?

So here's the sequence of pids being used/hashed etc. Please let
me know if my assumptions are correct ?

1. Same listener thread opens 2 sockets

On sockfd1, does a bind() using
	sockaddr_nl.nl_pid = my_pid1
On sockfd2, does a bind() using
	sockaddr_nl.nl_pid = my_pid2

(one of my_pid1's could by its process pid but doesn't have to be)

2. Listener supplies cpumasks on each of the sockets through a
register command sent on sockfd1.

In the kernel, when the command is received,
the genl_info->pid field contains my_pid1

my_pid1 is stored in a pidhash alongwith the corresponding cpumask.

cpumask is used to store the my_pid1 into per-cpu lists for each
cpu in the mask.

3. When an exit event happens on one of those cpus in the mask,
it is sent to this listener using
	genlmsg_unicast(...., my_pid1)


4. When the listener closes sockfd1, netlink_release() gets called
and that calls a taskstats notifier callback (say taskstats_cb) with
	struct netlink_notify n =
	{ .protocol =  NETLINK_GENERIC, .pid = my_pid1 }

and using the .pid within, taskstats_cb can do a lookup within its
pidhash. If its present, use the cpumask stored alongside to go
clean up my_pid1 stored in the listener list of each cpu in the mask.


--Shailabh

	


