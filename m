Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUFFQ5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUFFQ5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUFFQ5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:57:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:1963 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263818AbUFFQ5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:57:38 -0400
Date: Sun, 6 Jun 2004 09:57:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Erik Andersen <andersen@codepoet.org>
cc: Kalin KOZHUHAROV <kalin@ThinRope.net>,
       Davide Libenzi <davidel@xmailserver.org>, Robert Love <rml@ximian.com>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <20040606075754.GA10642@codepoet.org>
Message-ID: <Pine.LNX.4.58.0406060937330.7010@ppc970.osdl.org>
References: <40C1E6A9.3010307@elegant-software.com>
 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
 <20040605205547.GD20716@devserv.devel.redhat.com> <20040605215346.GB29525@taniwha.stupidest.org>
 <1086475663.7940.50.camel@localhost> <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0406051610430.7010@ppc970.osdl.org> <40C2A6E4.7020103@ThinRope.net>
 <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org> <20040606075754.GA10642@codepoet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jun 2004, Erik Andersen wrote:
> 
> http://sources.redhat.com/cgi-bin/cvsweb.cgi/~checkout~/libc/sysdeps/posix/tempname.c?rev=1.36&content-type=text/plain&cvsroot=glibc
> 
>     /* Get some more or less random data.  */
>     random_time_bits = ((uint64_t) tv.tv_usec << 16) ^ tv.tv_sec;
>     value += random_time_bits ^ __getpid ();

This one is historically at least a bit understandable: it's quite common 
for various programs to create their lockfiles with the "unique" 
identifier that is the pid of the locker. So the algorithm used to be 
roughly (used by various things, ranging from tty subsystem locking to 
whatever):

	int fd, len;
	int pid = getpid();

	len = sprintf(name, "lockfile.%d", pid);
	fd = open(name, O_EXCL | O_CREAT | O_WRONLY, 0644);
	if (fd < 0) {
		if (errno == EEXIST) {
			fprintf(stderr, "Stale lockfile %s. Remove me\n", name);
			exit(1); /* Or just "unlink + repeat" */
		}
		perror("lockfile");
		exit(1);
	}

	/* Write the pid into the lockfile, fsync it */
	write(fd, name + 9, len - 9);
	fsync(fd);

	/* Try to move it atomically */
	while (rename("lockfile", name) < 0) {
		if (errno != EEXIST) {
			perror("lockfile");
			exit(1);
		}
		/* Try again later */
		sleep(1);
	}

	... We now have an exclusive lock ..

and here "pid" is in fact a good system-wide unique identifier. It's not
random, and it works badly with networked filesystems (which is why you'll
find versions of this algorithm that use the hostname in addition to the
pid too), but it's "obvious".

I think the original "mktemp()" also used to start off with "pid" as a
"unique" identifier. Because while it's not random, it _is_ system-wide
unique, so getpid() actually makes _sense_ in that respect.

In other words: getpid() makes little sense as a random value, but it does
make some sense as a unique value. Maybe less now than it did 20 years ago
due to the prevalence of networking, but history is powerful.

			Linus
