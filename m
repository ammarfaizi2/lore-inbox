Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTEDVny (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 17:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTEDVny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 17:43:54 -0400
Received: from ee.oulu.fi ([130.231.61.23]:26878 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S261788AbTEDVnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 17:43:53 -0400
Date: Mon, 5 May 2003 00:56:19 +0300 (EEST)
From: Ville Voutilainen <vjv@ee.oulu.fi>
Message-Id: <200305042156.h44LuJYe012089@stekt2.oulu.fi>
To: linux-kernel@vger.kernel.org
Cc: meshko@cs.brandeis.edu
Subject: Re: fcntl file locking and pthreads
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>flock()-based locks work as expected, i.e. only one thread can have an
>exclusive lock at a time.
>What would it take to make fcntl work as flock?

This is because flock locks the inode, not the file descriptor.
fcntl locks the file descriptor. This is why flock does not
work over nfs, I suppose. If you share descriptors, you also
share locks and positions (at least according to the man pages
of fcntl, dup et al). I don't know what exactly is supposed
to happen if you open the file twice in two separate threads
and then lock with fcntl in the first thread. But simply doing

open()
pthread_create()
fcntl()
			(other thread)
			fcntl()
will probably result in both threads acquiring the lock
successfully. It would be reasonable IMHO to assume that
a sequence like

open()
pthread_create()
fcntl()

			(other thread)
			open()
			fnctl() /* lock the newly opened fd */

would give you what you're after. The only problem being that
even user space manuals suggest that fcntl can only detect
that other *processes* hold a file lock. Given the muddy
nature of what is a thread/process in Linux, this requires
someone more familiar with the clone stuff to clarify.

Another issue altogether is why you are trying to sync two
threads with file locks, but I digress.

-VJV-
