Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSHBRSQ>; Fri, 2 Aug 2002 13:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSHBRSQ>; Fri, 2 Aug 2002 13:18:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43784 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316569AbSHBRSP>; Fri, 2 Aug 2002 13:18:15 -0400
Date: Fri, 2 Aug 2002 10:22:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave McCracken <dmccr@us.ibm.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Bill Abt <babt@us.ibm.com>
Subject: Re: [PATCH 2.5.30] Allow tasks to share credentials
In-Reply-To: <44230000.1028304881@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0208021016580.914-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Dave McCracken wrote:
>
> This patch provides the ability to share credentials (uid, gid,
> capabilities) between tasks, using a clone() flag.

I worry about the lack of locking here.

Maybe it's the right thing to do, I don't really know.

But I _know_, for example, that this is just a horrid security hole the
way it is now - the execve() path doesn't create a unique "cred"
structure, so if you execve() a suid binary from a CLONE_CRED thread, the
other threads get the suid'ness and can do whatever they want.

At the very least, it should disallow suid exec's when

	atomic_read(&current->cred->count) > 1

which is the same approach we do wrt other shared state (ie disallow a
CLONE_FILES thing from doing a suid execve etc).

The alternative is to just allocate a new cred structure on execve.

As-is this patch is way way too dangerous. You can trivially create a root
hole by doing

	if (!clone(CLONE_CRED)) {
		execve("su");
		exit(1);
	}

	..this thread now also got root..

> There is no lock around the credential accesses, but from my analysis none
> is needed.

You may be right. I don't see any huge reason for it, but see above on
other fundamental problems.

		Linus

