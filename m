Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265845AbUEUMFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbUEUMFG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 08:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265536AbUEUMFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 08:05:06 -0400
Received: from mx-00.sil.at ([62.116.68.196]:56329 "EHLO mx-00.sil.at")
	by vger.kernel.org with ESMTP id S265845AbUEUMEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 08:04:51 -0400
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
From: nf <nf2@scheinwelt.at>
Reply-To: nf2@scheinwelt.at
To: Alexander Larsson <alexl@redhat.com>
Cc: Ross Burton <r.burton@180sw.com>, Nautilus <nautilus-list@gnome.org>,
       kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1085127066.20393.440.camel@localhost.localdomain>
References: <1084152941.22837.21.camel@vertex>
	 <20040510021141.GA10760@taniwha.stupidest.org>
	 <1084227460.28663.8.camel@vertex>
	 <20040511024701.GA19489@taniwha.stupidest.org>
	 <1084276364.4081.63.camel@lilota.lamp.priv>
	 <1084278605.3839.47.camel@carados.180sw.com>
	 <1084885604.4062.48.camel@lilota.lamp.priv>
	 <1085127066.20393.440.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1085141088.4013.113.camel@lilota.lamp.priv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-2mdk 
Date: Fri, 21 May 2004 14:04:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-21 at 10:11, Alexander Larsson wrote:
> On Tue, 2004-05-18 at 15:06, nf wrote:
> > On Tue, 2004-05-11 at 14:30, Ross Burton wrote:
> > > On Tue, 2004-05-11 at 12:52, nf wrote:
> > > > I would even claim, that simple polling ("stat"-ing) the filesystem for
> > > > changes is more efficient in 95% of the cases, than all this dnotify,
> > > > fam, etc... stuff.
> > > 
> > > Do you have any idea how many files GNOME is watching?  Every file in
> > > your open Nautilus windows, plus the desktop, plus every .desktop file
> > > in your panel menu.  Stat-ing that lot would be seriously slow, and
> > > rather intense.
> > > 
> > > Ross
> > 
> > One million stat() calls take less than 2 seconds on my computer (athlon
> > xp2000). - 2 microseconds per call! This seems negligible compared to
> > all the trouble and complexity we get with xinetd, fam, dnotify,...
> > At least on an average workstation...
> 
> Of course. You're stating the same file, and one that is in cache
> already. You're just measuring syscall overhead, not hd seek times and
> rotational delays.

But: If a filemanager or fam regularly stat() the SAME files - and
that's what they do when monitoring directories - the inodes would all
stay cached. So measuring the syscall() overhead seems quite precise.

I just try to conclude my little kernel newbie research. I believe both
models - generating events versus polling - have disadvantages:

1) Generating events (dnotify and inotify): By hooking into sys_write()
functions far too many events, than any GUI can deal with, get
generated. The result: clients need all kind of timers to group events
which doesn't make a lot of difference to polling (I think).

- You also earn the problem of queues in the kernel and how to limit
those queues (inotify).

- sys_write() calls certainly slow down a lot, because of all the things
attached to them.

- dnotify needs files open on the directory, which seems unacceptable
because of the umount problems. Blocking things is not a good practice
for a monitor ;-).

- inotify has to play tricks to keep inodes cached (watcher counters).

- both (inotify and dnotify) event systems only report changes in
directories, but not which files have changes. Here comes massive
stating() again on the client side. In case the client does not group
events with a timer, hundreds of stat() calls might get generated
whenever an application calls sys_write() to a file in a directory.

2) Polling with stat():

- I think the main problem about stat()ing is the big number of files
which need to get stat()ed when monitoring big directories. But: because
of directory caching of the kernel this might not be a big problem.

- The other problem is the delay, changes in directories get realized
plus more "idle" activity.

3) My conclusion:

--> Return to polling for the moment. The advantages of generating
events (dnotify, inotify) don't outweigh the disadvantages. And polling
is simpler.

--> Make sure polling doesn't take over your system by dynamically
expanding the polling-interval depending on the time one polling()ing
loop takes.

--> Make polling more efficient by adding a kernel sys_dirstat() call,
which returns the max() of all timestamps of the inodes in a directory -
which reduces the overhead of sys_stat - (calling user_path_walk() every
time for instance).
sys_dirstat() could also sum up the filesizes and file-count in the
directory for more convenience.

--> Or - even better: write a driver which hooks into sys_write, which
propagates the "modify" timestamps up the directory hierarchy. This
would make polling really efficient, because only a few queries would be
necessary to find out if there were any changes at all/ in a certain
directory...

Just my thoughts as a kernel-newbie. Maybe i'm completely wrong. And i
don't want to put down "inotify". I think it's a lot nicer than
dnotify...

Regards,

Norbert




























