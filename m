Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131108AbRAQEje>; Tue, 16 Jan 2001 23:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132216AbRAQEjY>; Tue, 16 Jan 2001 23:39:24 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:59408 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S131108AbRAQEjF>; Tue, 16 Jan 2001 23:39:05 -0500
Date: Tue, 16 Jan 2001 20:39:04 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: 'native files', 'object fingerprints' [was: sendpath()]
In-Reply-To: <Pine.LNX.4.30.0101161020200.673-100000@elte.hu>
Message-ID: <Pine.LNX.4.30.0101162036040.12389-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Ingo Molnar wrote:

> But even user-space code could use 'native files', via the following, safe
> mechanizm:

so here's an alternative to ingo's proposal which i think solves some of
the other objections raised.  it's something i've proposed in the past
under the name "extended file handles".

struct extended_file_permission {
	int refcount;
	some form of mutex to protect refcount;
        some list structure head;
};

struct extended_file {
	struct file *file;
	struct extended_file_permission *perm;
        whatever list foo is needed to link with extended_file_perm above;
};

if you allocate a few huge arrays of struct extended_file, then you can
verify if a pointer passed from user space fits into one of those arrays
pretty quickly.

struct task has a struct extended_file_permission * added to it to
indicate which perm struct that task is associated with.

so you just compare the f->perm to current->extended_file_perm and you
know if the task is allowed to use it or not.

clone() allows you to create tasks sharing the same
extended_file_permissions.

fork()/exec() would create new extended_file_perms -- which implicitly
causes all those files to be closed.  this gives you pretty light cgi
fork()/exec() off a main "process" which is handling thousands of sockets.

i also proposed various methods of doing O_foo flag inheritance... but the
above is more interesting.

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
