Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261657AbSIXMQf>; Tue, 24 Sep 2002 08:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261658AbSIXMQf>; Tue, 24 Sep 2002 08:16:35 -0400
Received: from ns.suse.de ([213.95.15.193]:54287 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261657AbSIXMQe>;
	Tue, 24 Sep 2002 08:16:34 -0400
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nanosecond resolution for stat(2)
References: <20020923214836.GA8449@averell.suse.lists.linux.kernel> <15759.62593.58936.153791@notabene.cse.unsw.edu.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Sep 2002 14:21:47 +0200
In-Reply-To: Neil Brown's message of "24 Sep 2002 07:16:10 +0200"
Message-ID: <p73y99rshlw.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> writes:

> Would it make sense, when loading a time from disk, for the low order,
> non-stored bits of the time to be initialised high rather than low.
> i.e. to 999,999,999 rather than 0.
> This way time stamps would never seem to jump backwards, only
> forwards, which seems less likely to cause confusion and will mean that a
> change is not missed (I'm thinking NFS here where cache correctness
> depends heavily on mtime).

It would be possible, but I would only add it when there are actual
problems with the current solution.
It looks like a bit of a hack.

> 
> Also, would it make sense, for filesystems that don't store the full
> resolution, to make that forward jump appear as early as
> possible. i.e. if the mtime (ctime/atime) is earlier than the current
> time at the resoltion of the filesystem, then make the mtime appear to
> be what it would be if reloaded from storage...  Maybe an example
> would help.

That would require much more callbacks into the filesystem. The VFS changes
the times, but it doesn't know what the resolution of the file system is.

In theory it could help a bit when the rounding is needed, but again
to avoid overengineering early I would like to first see if the current
KISS way works out well enough.

[note that when you want the "only flush once a second" optimization back
you would need some of these callbacks anyways, so when doing it it may
be a good idea to merge it with early increase]

> Thus the only incorrect observation that an application can make is
> that there is an extra change at the end of a second when other
> changes were made.  I think this is better than an apparent change
> suddenly becoming visible many minutes after the time of that apparent
> change, and definately better than a timestamp moving backwards.

Probably yes. But it's also much more intrusive for the kernel code.

It also has the drawback that the application can see times in the future
in stat.
e.g. when someone does

	touch file
	stat(file, &st)
	gettimeofday(&now) 
	tvsub(&diff, &now, &st.st_mtime_ts)

Then diff may actually be negative.  Which could also in theory break stuff.
So you would trade one breakage for another. Let's see if KISS works out
first :-)


-And
