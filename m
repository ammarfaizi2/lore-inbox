Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbTAZWiQ>; Sun, 26 Jan 2003 17:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbTAZWiQ>; Sun, 26 Jan 2003 17:38:16 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:61323 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S267029AbTAZWiP>; Sun, 26 Jan 2003 17:38:15 -0500
Date: Sun, 26 Jan 2003 20:47:11 -0200
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       NFS@lists.sourceforge.net
Subject: Re: [NFS] Re: NFS client locking hangs for period
Message-ID: <20030126204711.A25997@blackjesus.async.com.br>
References: <20030124184951.A23608@blackjesus.async.com.br> <15922.2657.267195.355147@notabene.cse.unsw.edu.au> <20030126140200.A25438@blackjesus.async.com.br> <shs8yx7lgyt.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shs8yx7lgyt.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Sun, Jan 26, 2003 at 10:49:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 10:49:14PM +0100, Trond Myklebust wrote:
> >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> 
>      > I wonder why you can't do locking on NFS root (if it's a
>      > current limitation of if it doesn't make sense).
> 
> locking supposes that you are already running a statd daemon, which
> you clearly cannot be doing on an nfsroot system. If you need locking
> on a root partition, then you'll need to set up an initrd from which
> to start all the necessary daemons...

This makes a lot of sense, I just had never thought about it properly.
I'm not sure I *need* locking, so I'll run with nolock till it bites me.

> BTW: Did I understand you and Neil correctly when you appeared to say
> that you were sharing the *same* root partition between several
> clients?

Yes, you did understand correctly. The same root partition is mounted by
around 20 machines. It works, too. The bug that we have manifests itself
very rarely, and only when one of the machines does an unclean shutdown.
I still haven't been able to reproduce it so I still haven't seen a
solution yet.

> If so, then that could easily explain your problem: a directory like
> /var/lib/nfs simply cannot be shared among several different
> machines. Read the 'statd' manpage, and I'm sure you will understand
> why.

Well, none of the machines by default exports anything through NFS, so
none of them explicitly *need* /var/lib/nfs. I've done some careful
study and separated the directories which are written to on a per-host
basis, and used a lot of tmpfs. It works quite well, to be honest. A
breakdown of "special" directories:

- /var/spool and /var/log need to be separate, for obvious reasons.
- /proc/mounts should be linked to /etc/mtab to avoid the need for
  writing there. 
- /tmp, /var/tmp, /dev/shm, /var/lock, /var/run, /var/lib/nfs,
  /var/yp/binding, /var/lib/sendmail are tmpfs.

None of the users have root access so writing to the partition only is
done as the result of servers running. I used a lot of reboots and ls
-lt to find out what needs to be separate, and there are few issues that
need fixing (/etc/ioctl.save being the latest).

One issue I ran into that I only discovered today (well, we all have to
learn someday) was that a shared /dev is not a good idea, because some
programs write to it. Case in point was syslogd, which creates /dev/log
- all but the last machine had logging broken. Since nobody needs logs
on these boxes anyway, it had gone on unnoticed, but I'm now using
devfs, and it works fine.

Everybody seems to find this setup a bit bizarre. It's not. It keeps
maintenence down to zero for everything, and adding a new box means
running a script once.

statd(8) does indicate that /var/lib/nfs is private, so I just mount it
as tmpfs. Should I make it persistent, or is the fact those files
disappear on an unclean reboot a sign of trouble?

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
