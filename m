Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265304AbRF0IcM>; Wed, 27 Jun 2001 04:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbRF0IcC>; Wed, 27 Jun 2001 04:32:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18323 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265304AbRF0Ib6>;
	Wed, 27 Jun 2001 04:31:58 -0400
Date: Wed, 27 Jun 2001 04:31:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Magnus Naeslund(f)" <mag@fbab.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Maximum mountpoints + chrooted login
In-Reply-To: <002b01c0fee0$6429bc00$020a0a0a@totalmef>
Message-ID: <Pine.GSO.4.21.0106270422400.19655-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jun 2001, Magnus Naeslund(f) wrote:

> I was thinking of doing a chrooted login for some ssh accounts.
> The plan is this:

[snip CLONE_NAMESPACE-by-hands]
 
> Does this seem like a bad idea?
> (then please tell me why :))

Mostly because there's a better way to do that. Yes, such scheme would
work (that + massive pending fs/super.c cleanups was the main reason why
I didn't go for proper solution in 2.4.0-test*). However, instead of
crufting up kinda-sorta namespaces one could use the real thing. Relevant
cleanups of superblock handling will go in in 2.5.very_early and the
rest of patch (namespace proper) takes about 10Kb.

You can simply say clone(CLONE_NAMESPACE,NULL) and you get an independent
set of mounts to play with. mount/umount whatever you want before dropping
the root priveleges. All children of that process will share its namespace.
When the last one goes away everything will be garbage-collected - no
need to umount anything on logout.

> One problem could be the _massive_ mounts, 3*online_users.
> Are there any limits/drawbacks doing it like this?

With the mntcache in - not really. It fixes the main performance problem.
Memory cost is sizeof(struct vfsmount)*total amount of mountpoints. I.e.
about 100 bytes per mountpoint. That's it.

