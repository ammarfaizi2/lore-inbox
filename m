Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267332AbTA1IBD>; Tue, 28 Jan 2003 03:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbTA1IBD>; Tue, 28 Jan 2003 03:01:03 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:58635 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267332AbTA1IBC>; Tue, 28 Jan 2003 03:01:02 -0500
Message-Id: <200301280801.h0S81Ns10071@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Christian Reis <kiko@async.com.br>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: NFS client locking hangs for period
Date: Tue, 28 Jan 2003 10:00:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, NFS@lists.sourceforge.net
References: <20030124184951.A23608@blackjesus.async.com.br> <15922.2657.267195.355147@notabene.cse.unsw.edu.au> <20030126140200.A25438@blackjesus.async.com.br>
In-Reply-To: <20030126140200.A25438@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 January 2003 18:02, Christian Reis wrote:
> On Sat, Jan 25, 2003 at 02:54:09PM +1100, Neil Brown wrote:
> > Hmmm.  So you have several clients all mounting the same root
> > filesystem, and mounting it writable?  That doesn't sound like a
> > plan for success.  How do you make sure the clients don't tread
> > over each other when using /etc files?
>
> The truth is few (broken wrt the FHS) programs actually write to
> /etc. I have set up everything so nothing is written to in /etc, and
> it actually works very well (have to use a special init(8) that
> doesn't write to /etc/ioctl.save). This setup has been running for
> almost a year now, with the locking problem being the only one left
> to fix.

My root fs is RO. Works wonders. Clients simply CANNOT trash their
/bin, /lib etc ;)

> > I suspect that what you really want is to mount root read-only, or
> > mount separate roots for each client, and then in either case to
> > mount with the "nolock" flag.
>
> Well, mounting root read-only is a good idea but it sacrifices being
> able to administer the system from any station, and it also puts a
> lot of burden on me to fix *all* programs to not write to anywhere on
> it. This shouldn't be too hard, but we're still just working around
> the bug, which I would really like to identify and fix.

It was not really *that* difficult for me. I used devfs and symlinks.
/etc, /var, /tmp are different directories per client,
/home, /usr are shared. The rest stays on root fs readonly.
ssh to NFS server if you want to modify some files on root fs.

Separate etc/var/tmp files for each client = no concurrent rw access.

> > I suspect that your problem is related to the client trying to do
> > locking, but no having statd running on the client.
>
> I am 100% positive statd runs on every single client. This problem
> here only happens spuriously.  It goes away when I restart nfsd and
> mountd (in that order). It really does look like a bug <wink>

File locking over the network is hard to do reliably.
I have no experience with that in NFS, but presume there
can be problems in some situations (statd or portmap
crashed on a client, client hung/disconnected from the net,
etc etc etc...)

Anyway, such corner cases are painful, thank you for
your efforts to nail it down.
--
vda
