Return-Path: <linux-kernel-owner+w=401wt.eu-S932582AbWLSHlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWLSHlI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWLSHlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:41:08 -0500
Received: from shards.monkeyblade.net ([192.83.249.58]:33910 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616AbWLSHlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:41:07 -0500
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
From: "J.H." <warthog9@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
In-Reply-To: <20061219064646.GJ24090@1wt.eu>
References: <20061214223718.GA3816@elf.ucw.cz>
	 <20061216094421.416a271e.randy.dunlap@oracle.com>
	 <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
	 <1166297434.26330.34.camel@localhost.localdomain>
	 <45858B3A.5050804@oracle.com> <20061217223730.GW10054@mea-ext.zmailer.org>
	 <1166402576.26330.81.camel@localhost.localdomain>
	 <20061219064646.GJ24090@1wt.eu>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 23:39:51 -0800
Message-Id: <1166513991.26330.136.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 07:46 +0100, Willy Tarreau wrote:
> On Sun, Dec 17, 2006 at 04:42:56PM -0800, J.H. wrote:
> > On Mon, 2006-12-18 at 00:37 +0200, Matti Aarnio wrote:
> > > On Sun, Dec 17, 2006 at 10:23:54AM -0800, Randy Dunlap wrote:
> > > > J.H. wrote:
> > > ...
> > > > >The root cause boils down to with git, gitweb and the normal mirroring
> > > > >on the frontend machines our basic working set no longer stays resident
> > > > >in memory, which is forcing more and more to actively go to disk causing
> > > > >a much higher I/O load.  You have the added problem that one of the
> > > > >frontend machines is getting hit harder than the other due to several
> > > > >factors: various DNS servers not round robining, people explicitly
> > > > >hitting [git|mirrors|www|etc]1 instead of 2 for whatever reason and
> > > > >probably several other factors we aren't aware of.  This has caused the
> > > > >average load on that machine to hover around 150-200 and if for whatever
> > > > >reason we have to take one of the machines down the load on the
> > > > >remaining machine will skyrocket to 2000+.  
> > > 
> > > Relaying on DNS and clients doing round-robin load-balancing is doomed.
> > > 
> > > You really, REALLY, need external L4 load-balancer switches.
> > > (And installation help from somebody who really knows how to do this
> > > kind of services on a cluster.)
> > 
> > While this is a really good idea when you have systems that are all in a
> > single location, with a single uplink and what not - this isn't the case
> > with kernel.org.  Our machines are currently in three separate
> > facilities in the US (spanning two different states), with us working on
> > a fourth in Europe.
> 
> On multi-site setups, you have to rely on DNS, but the DNS should not
> announce the servers themselves, but the local load balancers, each of
> which knows other sites.
> 
> While people often find it dirty, there's no problem forwarding a
> request from one site to another via the internet as long as there
> are big pipes. Generally, I play with weights to slightly smooth
> the load and reduce the bandwidth usage on the pipe (eg: 2/3 local,
> 1/3 remote).
> 
> With LVS, you can even use the tunneling mode, with which the request
> comes to LB on site A, is forwarded to site B via the net, but the data
> returns from site B to the client.
> 
> If the frontend machines are not taken off-line too often, it should
> be no big deal for them to handle something such as LVS, and would
> help spreding the load.

I'll have to look into it - but by and large the round robining tends to
work.  Specifically as I am writing this the machines are both pushing
right around 150mbps, however the load on zeus1 is 170 vs. zeus2's 4.
Also when we peak the bandwidth we do use every last kb we can get our
hands on, so doing any tunneling takes just that much bandwidth away
from the total.

	Number of Processes running
process		#1	#2
------------------------------------
rsync		162	69
http		734	642
ftp		353	190

as a quick snapshot.  I would agree with HPA's recent statement - that
people who are mirroring against kernel.org have probably hard coded the
first machine into their scripts, combine that with a few dns servers
that don't honor or deal with round robining and you have the extra load
on the first machine vs. the second.

> 
> > > > >Since it's apparent not everyone is aware of what we are doing, I'll
> > > > >mention briefly some of the bigger points.
> > > ...
> > > > >- We've cut back on the number of ftp and rsync users to the machines.
> > > > >Basically we are cutting back where we can in an attempt to keep the
> > > > >load from spiraling out of control, this helped a bit when we recently
> > > > >had to take one of the machines down and instead of loads spiking into
> > > > >the 2000+ range we peaked at about 500-600 I believe.
> > > 
> > > How about having filesystems mounted with "noatime" ?
> > > Or do you already do that ?
> > 
> > We've been doing that for over a year.
> 
> Couldn't we temporarily *cut* the services one after the other on www1
> to find which ones are the most I/O consumming, and see which ones can
> coexist without bad interaction ?
> 
> Also, I see that keepalive is still enabled on apache, I guess there
> are thousands of processes and that apache is eating gigs of RAM by
> itself. I strongly suggest disabling keepalive there.
> 
> > - John
> 
> Just my 2 cents,
> Willy

