Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136656AbREAQvQ>; Tue, 1 May 2001 12:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136657AbREAQvG>; Tue, 1 May 2001 12:51:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:2201 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136656AbREAQu5>;
	Tue, 1 May 2001 12:50:57 -0400
Date: Tue, 1 May 2001 12:50:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Todd Inglett <tinglett@vnet.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP races in proc with thread_struct
In-Reply-To: <3AEEC880.304F4B75@vnet.ibm.com>
Message-ID: <Pine.GSO.4.21.0105011236140.9771-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 May 2001, Todd Inglett wrote:

> Perhaps this is old news...but...
> 
> I can easily create a race when reading /proc/<pid>/stat
> (fs/proc/{base.c,array.c}) where a rapidly reading application, such as
> "top", starts reading stats for a thread which goes away during the
> read.  This is easily reproduced with a program that rapidly forks and
> exits while top is running.
> 
> On inspection, I don't see how the code can expect the thread_struct to
> stay around since it is not holding any lock for the duration of its
> use.  The code could hold the thread_struct's lock (after verifying it
> still exists while holding tasklist_lock I would imagine), but for
> performance I would think a better solution would be to copy the struct
> since stale data is probably ok in this case.
> 
> Dereferencing a non-existent thread_struct is clearly not ok.
> 
> Would anyone familiar with this code care to comment?

Code bumps the reference count of couple of pages that hold task_struct
when it opens the file.

Thus when task exits they won't be freed and won't be reused. Checking
that exit had already happened is trivial (and done).  And for anything
long said lock is held only while we acquire the reference
to task_struct component.

When you finally release the dentry of /proc/<pid> (and thus are guaranteed
that none of its children are used) you drop the reference to these two pages.
If process had exited while you were holding them - well, that's when
they are freed.

I really wonder what you've managed to reproduce - normal behaviour is
that as soon as task exits you can't access /proc/<pid> and any
access to already opened files in it fails with -ENOENT. Had you been
able to get something else?

