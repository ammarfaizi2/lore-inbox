Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314991AbSDWAtn>; Mon, 22 Apr 2002 20:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314994AbSDWAtm>; Mon, 22 Apr 2002 20:49:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:640 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314991AbSDWAtm>;
	Mon, 22 Apr 2002 20:49:42 -0400
Date: Mon, 22 Apr 2002 20:49:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: [RFC] race in request_module()
Message-ID: <Pine.GSO.4.21.0204222027360.5686-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Looks like request_module() has quite a few problems:

* there is no way to distinguish between failing modprobe and successful
  one followed by rmmod -a (e.g. called by cron).  For one thing, we
  don't pass exit value of modprobe to caller of request_module().

* even if we would pass it, obvious attempt to cope with rmmod -a races
  fails.  I.e. something like

	while (object doesn't exist) {
		if (request_module(module_name) < 0)
			break;
	}

  would screw up for something like

mount -t floppy <whatever>

  since we would happily load floppy.o and look for fs type called "floppy".
  And keep doing that forever, since floppy.o doesn't define any fs.

* we could try to protect against rmmod -a by changing semantics of module
  syscalls and modprobe(8).  Namely, let modprobe called by request_module()
  pin the module(s) down and make request_module() (actually its caller)
  decrement refcounts.  That would solve the problem, but we get another one:
  how to find all modules pulled in by modprobe(8) and its children.
  Notice that argument of request_module() doesn't help at all - it can have
  nothing to name of module we load (block-major-2 -> floppy) and we could have
  other modules grabbed by the same modprobe.

* we might try to pull the following trick: in sys_create_module() follow
  ->parent until we step on request_module()-spawned task.  Then put the new
  module on a list for that instance of request_module().  That would solve
  the problem, but I'm not too happy about such solution - IMO it's ugly.
  However, I don't see anything else...

Comments?

  

