Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbTA1IOi>; Tue, 28 Jan 2003 03:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbTA1IOi>; Tue, 28 Jan 2003 03:14:38 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:3084 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264943AbTA1IOg>; Tue, 28 Jan 2003 03:14:36 -0500
Message-Id: <200301280815.h0S8FLs10146@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Christian Reis <kiko@async.com.br>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [NFS] Re: NFS client locking hangs for period
Date: Tue, 28 Jan 2003 10:14:09 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       NFS@lists.sourceforge.net
References: <20030124184951.A23608@blackjesus.async.com.br> <shs8yx7lgyt.fsf@charged.uio.no> <20030126204711.A25997@blackjesus.async.com.br>
In-Reply-To: <20030126204711.A25997@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 January 2003 00:47, Christian Reis wrote:
> On Sun, Jan 26, 2003 at 10:49:14PM +0100, Trond Myklebust wrote:
> > >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> >      > I wonder why you can't do locking on NFS root (if it's a
> >      > current limitation of if it doesn't make sense).
> >
> > locking supposes that you are already running a statd daemon, which
> > you clearly cannot be doing on an nfsroot system. If you need
> > locking on a root partition, then you'll need to set up an initrd
> > from which to start all the necessary daemons...
>
> This makes a lot of sense, I just had never thought about it
> properly. I'm not sure I *need* locking, so I'll run with nolock till
> it bites me.
>
> > BTW: Did I understand you and Neil correctly when you appeared to
> > say that you were sharing the *same* root partition between several
> > clients?
>
> Yes, you did understand correctly. The same root partition is mounted
> by around 20 machines. It works, too. The bug that we have manifests
> itself very rarely, and only when one of the machines does an unclean
> shutdown. I still haven't been able to reproduce it so I still
> haven't seen a solution yet.
>
> > If so, then that could easily explain your problem: a directory
> > like /var/lib/nfs simply cannot be shared among several different
> > machines. Read the 'statd' manpage, and I'm sure you will
> > understand why.
>
> Well, none of the machines by default exports anything through NFS,
> so none of them explicitly *need* /var/lib/nfs. I've done some
> careful study and separated the directories which are written to on a
> per-host basis, and used a lot of tmpfs. It works quite well, to be
> honest. A breakdown of "special" directories:
>
> - /var/spool and /var/log need to be separate, for obvious reasons.
> - /proc/mounts should be linked to /etc/mtab to avoid the need for
>   writing there.
> - /tmp, /var/tmp, /dev/shm, /var/lock, /var/run, /var/lib/nfs,
>   /var/yp/binding, /var/lib/sendmail are tmpfs.

I did the same.
You will end up amending this list. Simplify it:

/var need to be separate, for obvious reasons. ;)
/tmp need to be separate
/etc need to be separate

> None of the users have root access so writing to the partition only
> is done as the result of servers running. I used a lot of reboots and
> ls -lt to find out what needs to be separate, and there are few
> issues that need fixing (/etc/ioctl.save being the latest).

Entire /etc.  How can you have different per-client configs for
e.g. /etc/resolv.conf?  I know you don't usually need that.
Sometimes we need to do unusual things ;)

> One issue I ran into that I only discovered today (well, we all have
> to learn someday) was that a shared /dev is not a good idea, because
> some programs write to it. Case in point was syslogd, which creates
> /dev/log - all but the last machine had logging broken. Since nobody
> needs logs on these boxes anyway, it had gone on unnoticed, but I'm
> now using devfs, and it works fine.

Same here. Devfs is cool ;)
For one, it forces people to think before they got strange ideas of
putting something foreign in /dev. Like abm syslogd.

> Everybody seems to find this setup a bit bizarre. It's not. It keeps
> maintenence down to zero for everything, and adding a new box means
> running a script once.

Yeah! ;)  What a contrast with typical Windows network mess
you can find in random office!
--
vda
