Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264692AbSKDOoT>; Mon, 4 Nov 2002 09:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264693AbSKDOoT>; Mon, 4 Nov 2002 09:44:19 -0500
Received: from thunk.org ([140.239.227.29]:3743 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S264692AbSKDOoS>;
	Mon, 4 Nov 2002 09:44:18 -0500
Date: Mon, 4 Nov 2002 09:50:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@transmeta.com>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021104145049.GC9197@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
	Dax Kelson <dax@gurulabs.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	davej@suse.de
References: <87y98bxygd.fsf@goat.bogus.local> <Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com> <20021104024910.GA14849@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104024910.GA14849@ravel.coda.cs.cmu.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 09:49:10PM -0500, Jan Harkes wrote:
> For several years, I have had only one suid root binary on my system.
> All other 'setuid' applications are simply symlinks to this binary.
> 
> $ ls -l /bin/ping*
> lrwxrwxrwx    1 root     root           14 Nov 18  2001 /bin/ping -> /usr/bin/super
> -rwxr-xr-x    1 root     root        15244 Nov 18  2001 /bin/ping.suid
> 
> There is a a nice configuration file that is used to decide whether to
> use suid or setgid, which parts of the environment to drop/keep. And all
> of this based on the user, the time and any other conditions I would
> like to enforce.
> 
> Now super does not (yet) support capabilities. But it shouldn't be too
> hard to modify it so that it forks, drops capabilities, (possibly change
> the euid to the original user?) and exec the actual binary.

This sounds like the right way to go.  I do hope the configuration
file includes an SHA checksum of the secutable.  And to avoid race
conditions, there really ought to be a new system call, fexecve(2)
which takes an open file descriptor instead of a pathname.
(Unfortunately, we're in feature freeze now, so that will have to wait
until 2.7.)

Failing that, though, /usr/bin/super should really check the
permissions starting from the root of the entire pathaname, and fail
the exec if any of the containing directories are writable by a
non-root user.  (And of course, the executable should not be writable
by a non-root users for the same reason.)

With these checks, though, adding support for capabilities in
/usr/bin/super sounds like the right approach.  It doesn't require any
kernel changes (well, fexecve(2) would be nice, but it's not strictly
required).  There is of course a slight performance penalty associated
with the use of the helper program, but the start time of most setuid
root programs probably isn't a performance critical concern.

						- Ted

