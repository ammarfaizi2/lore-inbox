Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261887AbRESQmh>; Sat, 19 May 2001 12:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261881AbRESQm1>; Sat, 19 May 2001 12:42:27 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50917 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261875AbRESQmP>;
	Sat, 19 May 2001 12:42:15 -0400
Date: Sat, 19 May 2001 18:41:39 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105191641.SAA53411.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH] device arguments from lookup)
Cc: bcrl@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Opening device files often has interesting side effects.

> Too bad. They can be triggered by similar races between attacker
> changing the type of object (file<->symlink) and backup.

Yes. This is a well-known security problem.
Doing
	stat("file", &s);
	if (action desired) {
		action("file");
	}
is no good because there is a race.
But doing
	fd = open("file", flags);
	fstat(fd, &s);
	if (action desired) {
		f_action(fd);
	}
is no good either because the open() has unknown side effects.
It helps to add flags like O_NONBLOCK and perhaps O_NOCTTY,
but that is not quite good enough.

One would like to have a version of the open() call that was
guaranteed free of side effects, and gave a fd only -
perhaps for stat(), perhaps for ioctl().
This guarantee could perhaps be obtained by omitting the
	f->f_op->open(inode,f);
call in dentry_open() when the open call is
	open("file", O_FDONLY);
Of course it may be that we afterwards decide that fd must
be used, and then it needs upgrading:
	fd = f_open(fd, O_RDWR);

Andries

[Such a construction allows various cleanups.
But no doubt it has problems that I have not yet thought of.]
