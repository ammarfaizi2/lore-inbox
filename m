Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUCIQrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbUCIQrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:47:25 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:1018 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262049AbUCIQrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:47:21 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: =?CP 1252?q?S=F8ren=20Hansen?= <sh@warma.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UID/GID mapping system
Date: Tue, 9 Mar 2004 10:46:57 -0600
X-Mailer: KMail [version 1.2]
References: <1078775149.23059.25.camel@luke>
In-Reply-To: <1078775149.23059.25.camel@luke>
MIME-Version: 1.0
Message-Id: <04030910465700.32521@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 March 2004 13:45, Søren Hansen wrote:
> Based on recent discussions with Urban Widmark, regarding a patch to
> smbfs, I've come up with a system for mapping "local" and "remote" UID's
> and GID's to each other. "Local" means those in the user database and
> "remote" means those on the filesystem in question, be it networked or
> non-networked. This system enables you to mount a filesystem via NFS or
> Samba (with UNIX extensions) and supply a bunch of mappings between the
> UID's and GID's on the client system and those on the server system.
> Whenever a local user does something on the filesystem, his UID is
> mapped to his corresponding UID on the remote system. This all takes
> place in the VFS system.
> The system can also be used if a user were to mount a samba share that
> has the UNIX extensions enabled. In this case, you'd define a default
> local and a default remote UID/GID so that all files would locally
> appear to be owned by the mounting user, hence allowing him to actually
> access the files that the server would allow him to, without placing any
> additional local restrictions on his access (if this doesn't seem to
> make sense, see my previous post with subject "smbfs patch").
> If you you're moving a disk from one system to another, you could use
> the system to fix up the ownership instead of having to change them all
> on the actual filesystem.
> All in all, I think this could be very helpful.
>
> However, I have two question:
> 1. I'm very new to this kernel stuff, and this might only be a good idea
> inside my head. Does this sound clever or am I fixing these problems at
> the totally wrong level?
> 2. I need a bit of help getting these mappings from the mount command
> into the kernel. I'm thinking about allowing a mount option called
> uidmap and one called gidmap which both take a filename as argument.
> This file could look like so:
> ============================
> # Syntax:
> # local id = remote id
> 1000 = 1005
> 1001 = 1003
> 1002 = 1002
> default = 1000
> 1004 = default
> ============================
> ...or something like that. I just haven't quite figured out how to have
> mount read these options and pass it to the kernel to populate these map
> tables. Any pointers would be greatly appreciated.
> The patches to the VFS system are in place, I just want to test them
> some more before posting them anywhere.

Have you considered the problem of 64 bit uids? and gids?, and unlimited 
number of groups assigned to a single user? How about having to support
multiple maps (one for each remote host that mounts a filesystem)?

I suspect not - you don't have enough memory to handle it.

These tables are going to have to be external to the kernel, and the kernel
only caching those that are known to be active to speed up the search.

This will call for an external daemon to support the dynamic mapping. Second,
you will have to have one map for each exported filesystem for each host that
is allowed to mount it. I grant that frequently there will be one map used
multiple times, but the worst case is one for each host.

To speed the external lookups up I suggest using a radix search (not my
original idea - Cray did it first).

I also suggest making it optional - or being able to specify a 1:1 mapping
be assumed. And be used with an inverse table: UIDs that are NOT to be mapped
(as in, all uids are mapped 1:1 EXCEPT ...)

I have worked at centers that had about 1200 users on each of 5 compute 
servers. Each compute server mounts the same filesystem from a server. IF
and only if all systems are within one security domain (all users are common, 
and have the same uid/gid list for all systems - a frequent case), do
you not need a map.

If each compute server is in a different security domain (unique user list)
then you must have 5 maps (10 if you include group maps) for each filesystem.
That adds up to 6000 entries in uid maps alone. If 64 bit uids are used (8
bytes/uid) that becomes 48K for the example, with only ONE exported
filesystem, and only uids. This might seem a lot, but consider exports to
workstations - 150 workstations, and likely 2-5 uids each (at least
one for admininistration use). That would be 150 maps (just uids), of only 5
entries each - 750 entries, 6K (more reasonable).

With Linux showing up more and more in large clusters, I expect the total
number of users to increase for the worst case result (consider 4 128 node
clusters mounting filesystems from an archive cluster: 512 mounts, with maybe
100 users for each cluster? something like 4MB for maps alone)
