Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267570AbSKQTzY>; Sun, 17 Nov 2002 14:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267572AbSKQTzY>; Sun, 17 Nov 2002 14:55:24 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:14058 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267570AbSKQTzQ>;
	Sun, 17 Nov 2002 14:55:16 -0500
Date: Sun, 17 Nov 2002 20:01:54 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
Message-ID: <20021117200154.GA1851@bjl1.asuk.net>
References: <Pine.LNX.4.44.0211171314200.7001-100000@localhost.localdomain> <Pine.LNX.4.44.0211170922020.4425-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211170922020.4425-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> There is no way in _hell_ that the correct way to handle this is by doing 
> magic things at execve() time. Stop that NOW!
> 
> First off, a program had better be correctly startable even if the 
> process that does the execve() is _not_ using the new glibc. If I have an 
> old "bash" binary, and that means that I cannot start up new binaries 
> correctly, that is BROKEN. It's so incredibly broken that it's scary.
> 
> Why not do it the _sane_ way, with a system call in crt0.S instead to set 
> up the user_tid if you want it?

I agree with Linus: a set_tid_address() system call should be enough,
and it's clear and simple.

Not just because of old binaries.  I want to be able to use the new
threading features _without_ using glibc's pthreads, but using the
non-threading portions of glibc if that is still possible.[*] - and
still be able to fork/exec standard glibc-using programs properly.

Btw, when CLONE_VM is clear, SETTID is useful without the CLEARTID
functionality, for the usual reason of preventing races with signal
handlers which need to know the pid.  (It's also useful to use both
flags, of course).  It might be better to keep the two flags.

Btw2, instead of a new system call, you could create a new clone flag:
CLONE_SELF.  This mean "create all the clonable resources, but install
them in _this_ process instead of creating another process".

For example, clone(CLONE_SELF | CLONE_VM, ...) would cause the current
thread to get a new copy of the file descriptor table, new signal
handler table etc., but it would install those in the current process,
not a new one.

This makes it possible to converted a clone()'d thread into a
fork()'d process, for example.

When you have that, set_tid_address() is simply a combination of
flags: CLONE_SETTID | CLONE_VM | CLONE_FS (etc.).  Admittedly, the
list of flags is rather whacky and doesn't work when new sharing flags
are added - and I'm not sure if it's actually useful.  But it's a
curious idea, what do you think?

-- Jamie


[*] Perhaps it isn't any more.  I recently wanted to call Glibc's
shm_open(), but for no apparent reason that forced pthreads to be
linked in which conflicted with the program's own clone() based
threading.  So I ended up using a file in /tmp instead of proper
shared memory.
