Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267423AbTA1QgY>; Tue, 28 Jan 2003 11:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267417AbTA1QgY>; Tue, 28 Jan 2003 11:36:24 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:29638 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S267423AbTA1QgU>; Tue, 28 Jan 2003 11:36:20 -0500
Date: Tue, 28 Jan 2003 14:44:47 -0200
From: Christian Reis <kiko@async.com.br>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       NFS@lists.sourceforge.net
Subject: Re: NFS client locking hangs for period
Message-ID: <20030128144447.C11078@blackjesus.async.com.br>
References: <20030124184951.A23608@blackjesus.async.com.br> <15922.2657.267195.355147@notabene.cse.unsw.edu.au> <20030126140200.A25438@blackjesus.async.com.br> <200301280801.h0S81Ns10071@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301280801.h0S81Ns10071@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Tue, Jan 28, 2003 at 10:00:05AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 10:00:05AM +0200, Denis Vlasenko wrote:
> > Well, mounting root read-only is a good idea but it sacrifices being
> > able to administer the system from any station, and it also puts a
> > lot of burden on me to fix *all* programs to not write to anywhere on
> > it. This shouldn't be too hard, but we're still just working around
> > the bug, which I would really like to identify and fix.
> 
> It was not really *that* difficult for me. I used devfs and symlinks.
> /etc, /var, /tmp are different directories per client,
> /home, /usr are shared. The rest stays on root fs readonly.
> ssh to NFS server if you want to modify some files on root fs.
> 
> Separate etc/var/tmp files for each client = no concurrent rw access.

I agree it is a lot simpler; however, you have to give up the ability to
install and upgrade system software seamlessly. When Debian reports a
security issue, all I do is apt-get -u upgrade and skim through it - all
boxes are magically updated. No need to update the individual /etc files
for the changes, and no messy links either.

It does require you take care, though. The most important issue is
finding out what files are written to in these directories (in violation
of the LFS/FHS, I must say). The current culprit I am after is a
/sbin/init, who writes to /etc/ioctl.save (why, I wonder). After a lot
of cleanup, I've managed to pair this down to teh minimum, and I'm going
after some of the last culprits now.

> File locking over the network is hard to do reliably.
> I have no experience with that in NFS, but presume there
> can be problems in some situations (statd or portmap
> crashed on a client, client hung/disconnected from the net,
> etc etc etc...)
> 
> Anyway, such corner cases are painful, thank you for
> your efforts to nail it down.

It seems Trond has given us the answer to the problem: the persistence
of /var/lib/nfs seems to be essential to a healthy diskless client. One
of our co-workers who was an expert as triggering the problems is at the
beach this week, so I can't tell for sure, but next Tuesday or so I hope
to post to NFS-list with [SUMMARY] in the Subject line <wink>

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
