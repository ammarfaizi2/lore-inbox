Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbUCJVnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbUCJVnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:43:08 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:3055 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262859AbUCJVly
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:41:54 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: =?CP 1252?q?S=F8ren=20Hansen?= <sh@warma.dk>
Subject: Re: UID/GID mapping system
Date: Wed, 10 Mar 2004 15:41:29 -0600
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1078775149.23059.25.camel@luke> <04031009285900.02381@tabby> <1078941525.1343.19.camel@homer>
In-Reply-To: <1078941525.1343.19.camel@homer>
MIME-Version: 1.0
Message-Id: <04031015412900.03270@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 March 2004 11:58, Søren Hansen wrote:
> ons, 2004-03-10 kl. 16:28 skrev Jesse Pollard:
> > > Er.. no. I just use the uid_t and gid_t. Are they 64bit?
> >
> > 32 bits currently.
>
> Ok.. But those are the data types in use in the v-nodes, right?

uid_t and gid_t eventually map to an int. And on most platforms an
int is 32 bits (even Power). There are some platforms that an int is
64 bits (though Linux doesn't currently run on it). This is a
hardware issue more than a software one. The other case that speaks for
larger potential UID/GID space is when you interface to systems using a
universal uid - which is either 64 bits or 128 (I'm not sure which
is normal).

> > > > and unlimited number of groups assigned to a single user?
> > >
> > > No. That's not my problem, is it? I just provide the mapping system.
> >
> > but the mapping system has to be able to handle it.
>
> How do you figure that?

I should have said "designed to handle it" in a future expansion. I was
wrong in making 64 bits as important as it looks.

> > > The maps are on the client, so that's no issue. The trick is to make it
> > > totally transparent to the filesystem being mounted, be it networked or
> > > non-networked.
> >
> > The server cannot trust the clients to do the right thing.
>
> The server can't trust the client as it is now anyway. The client can do
> whatever it wants already. There is no security impact as I see it.

Ah - but if the server refuses to map the uid then the server is more
protected. And it can detect when mapping is in error or under some forms
of attack (not all).

First, if the server refuses to map uids into what it considers system 
(say, those less than 100... or better, 1000) then the daemons that may be
using those uids/gids on the server (or other hosts even) will be
protected from a simple mapping attack. Any attempt to do so will be detected
by the server, blocked, and reported.

Second, if the various organizations are mapped, then only maps (and 
uids/gids) authorized by those maps can be used. Any hanky panky on the
client host will ONLY involve those accounts/uids already on the client. They
will NOT be able to map to accounts/uids that are assigned to the other
organization. Again, attempts to access improper accounts will be detected
by the server, blocked,  and reported.

This isolates any attacks to only those accounts on the compromised host.

> > The server cannot trust the client.
>
> I know! That's an entirely different issue. The very nanosecond you give
> another machine access to your filesystem, you're up shit creek anyway.
> The only difference between the way things are now and after the system
> I'm suggesting is in place, is that the ownerships will look sane on the
> client. What possible extra security implications could this cause?

It will hide the auditing to a possibly compromised system. This in turn
means that no central audit of the server will be possible.

> > Since different organizations are in charge of the server, how can that
> > server trust the client?
>
> Please explain how you in any way can trust a client mounting an nfs
> export from your server? You can't. All you can do is keep your fingers
> crossed and your hacksaw sharpened (in case you want a more hands-on
> security scheme). Maps or no maps, this is the same issue.

Currently - I can't. At least not on linux. The Cray UNICOS system has
mandatory maps on any NFS export. Any uid/gid from a remote host is mapped to
the correct local uid/gid (and this is one of the systems that has 64 bit
UIDs/GIDs). In fact - if the uid/gid of the nfs map is not correct (to permit
the NFS daemons on the client to access) then all NFS activity will fail for
that host.

> > A violation (even minor) on the client could cause a significant
> > violation of the server.
>
> Yes. Just like it can now.

Which is why UID/GID mapping must be done on the server. At the present time
the only network file system that can be supported is OpenAFS. And there, the
access rights are mediated by Kerberos credentials handled by the server, not
UID/GID.

> > As in a shipping department mounting a server, and a financial client
> > mounting from the same server - a violation on the shipping client COULD
> > expose financial data; and the server not even know. Or worse - the
> > shipping depeartment has been outsourced...
> > The server MUST control access to its resources.
>
> Yes. As always.
>
> If you have an idea for a patch that fixes all these issues, I'll more
> than happy to see it.

We've already outlined most of it. The principle is that the server must
mediate the UID/GID maps.

With this in mind, the kernel NFS processes must have one additional task when
reciving/sending uid/gid lists over the net.

When sending:	lookup the local uid in a reverse map to obtain the remote uid.
		Each gid must also be reverse looked up to obtain the remote
		gid(s). The resulting packet can then be sent to the client.
		Violations in the lookup are to be treated like a network
		error and logged (the system doesn't stop - it just sends an
		error packet to the client, and logs the error. Lots of errors
		may automatically disable the client, but that would be a different
		policy - and should be handled by the external daemon/LSM module).

When recieving: lookup the remote uid to locate the local uid.
		Each gid in the packet must also be looked up to obtain the
		local gid(s). The modified packet can then be processed as
		it currently is. The same type of error handling as for sending.

mountd changes: interpret small uid/gid lists, provide/generate optional
		connections to the daemon instance. hmm.. one daemon for each
		mount? or one daemon for all... one for each mount would be
		simpler to do at first - that way the daemon could be started
		by mountd with a "mapper socket forward.map reverse.map" and
		the maps generated by an external utility, or even just a
		forward.map in ascii, and let the daemon generate binary
		versions of both. This would also be easier to audit, though
		more CPU bound if a bunch of workstations is done. (might not
		be bad... if the UID/GID lists are small enought, no daemon
		would be needed). 

Optimizations:
	The lookup function must be capable of using sparse tables for cached
	lookups for both forward and reverse mapping (radix searching for this
	type of binary data is really fast, though hashing may provide equivalent
	throughput for small data sets).

	The lookup function must also be capable of reaching an external daemon
	for cache misses (perhaps via a sysfs/udev domain socket?).

The default for the lookup function would be to use a 1:1 mapping (determined
from the exports initialization (xtab, and loaded by mountd when the remote 
host does a mount). The lookup function MAY be able to use small lists without
a daemon (say 20-30 uids and gids) and support small exclusion lists (maybe 
ranges for both permitted/excluded lists?).

The daemon would then be usefull for large lists to help keep the cache size 
down. The size of the cache - containing real entries - should be a
configuration parameter.

There is also a possible issue with interfacing to the LSM, since this
touches on some of the structures that it can/should trace (though this
may be delayed until later for implementation, it is something to think
about for audit and security control).

Unfortunately, I'm not in a position to do coding - I've seen the AT&T System
V code (Cray version about 5 years ago)- to the point of debugging some NFS
mapping failures (which had to to with multi-level security options in
additon to UID/GID mapping).

