Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbTAZPx1>; Sun, 26 Jan 2003 10:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTAZPx0>; Sun, 26 Jan 2003 10:53:26 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:63106 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S266941AbTAZPxZ>; Sun, 26 Jan 2003 10:53:25 -0500
Date: Sun, 26 Jan 2003 14:02:00 -0200
From: Christian Reis <kiko@async.com.br>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, NFS@lists.sourceforge.net
Subject: Re: NFS client locking hangs for period
Message-ID: <20030126140200.A25438@blackjesus.async.com.br>
References: <20030124184951.A23608@blackjesus.async.com.br> <15922.2657.267195.355147@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15922.2657.267195.355147@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Sat, Jan 25, 2003 at 02:54:09PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 02:54:09PM +1100, Neil Brown wrote:
> Hmmm.  So you have several clients all mounting the same root
> filesystem, and mounting it writable?  That doesn't sound like a plan
> for success.  How do you make sure the clients don't tread over each
> other when using /etc files?

The truth is few (broken wrt the FHS) programs actually write to /etc. I
have set up everything so nothing is written to in /etc, and it actually
works very well (have to use a special init(8) that doesn't write to
/etc/ioctl.save). This setup has been running for almost a year now,
with the locking problem being the only one left to fix.

> I suspect that what you really want is to mount root read-only, or
> mount separate roots for each client, and then in either case to mount
> with the "nolock" flag.

Well, mounting root read-only is a good idea but it sacrifices being
able to administer the system from any station, and it also puts a lot
of burden on me to fix *all* programs to not write to anywhere on it.
This shouldn't be too hard, but we're still just working around the bug,
which I would really like to identify and fix.

> I suspect that your problem is related to the client trying to do
> locking, but no having statd running on the client.

I am 100% positive statd runs on every single client. This problem here
only happens spuriously.  It goes away when I restart nfsd and mountd
(in that order). It really does look like a bug <wink>

> You cannot meaningfully do locking on an NFS mounted root filesystem.
> Infact, I think it would be good if the default mount options for nfs
> root included nolock... and if I read fs/nfs/nfsroot.c:root_nfs_name
> correctly, nolock is the default.  Are you overriding that default
> be explicitly setting "lock"??

Nope. I've just tested and the default (specifying no lock option upon
bootup) really is nolock:

/dev/root on / type nfs (rw,v3,rsize=8192,wsize=8192,hard,udp,nolock,addr=192.168.99.4)

I wonder why you can't do locking on NFS root (if it's a current
limitation of if it doesn't make sense). 

But I also think this problem shouldn't be happening if no locking was
going on. And when I checked using nlm_debug it sure did seem locking
was being used. What do you make of it?

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
