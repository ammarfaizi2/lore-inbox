Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135607AbRECLsX>; Thu, 3 May 2001 07:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133074AbRECLsO>; Thu, 3 May 2001 07:48:14 -0400
Received: from [32.97.182.101] ([32.97.182.101]:41630 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S135607AbRECLr4>;
	Thu, 3 May 2001 07:47:56 -0400
Message-ID: <3AF14555.8699881B@vnet.ibm.com>
Date: Thu, 03 May 2001 06:47:33 -0500
From: Todd Inglett <tinglett@vnet.ibm.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3.c4eb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP races in proc with thread_struct
In-Reply-To: <Pine.GSO.4.21.0105011236140.9771-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Tue, 1 May 2001, Todd Inglett wrote:
> 
> > Perhaps this is old news...but...
> >
> > I can easily create a race when reading /proc/<pid>/stat
> > (fs/proc/{base.c,array.c}) where a rapidly reading application, such as
> > "top", starts reading stats for a thread which goes away during the
> > read.  This is easily reproduced with a program that rapidly forks and
> > exits while top is running.
> >
> > On inspection, I don't see how the code can expect the thread_struct to
> > stay around since it is not holding any lock for the duration of its
> > use.  The code could hold the thread_struct's lock (after verifying it
> > still exists while holding tasklist_lock I would imagine), but for
> > performance I would think a better solution would be to copy the struct
> > since stale data is probably ok in this case.
> >
> > Dereferencing a non-existent thread_struct is clearly not ok.
> >
> > Would anyone familiar with this code care to comment?
> 
> Code bumps the reference count of couple of pages that hold task_struct
> when it opens the file.

Yes that's right.  [Note that I erroneously wrote thread_struct when I
meant task_struct].

On closer inspection I see it is the *parent* task_struct that is the
problem here.  The task has indeed exited and the memory for the
task_struct is correctly held.  However, the /proc code will grab
tasklist_lock and dereference the parent task_struct to get the parent
pid.  Grabbing tasklist_lock is good, of course, when the task is live
because the parent could be switched at any time.  But in this case the
child is already done.  And so is the parent.  So the child's parent
task_struct is gone, but the stale held task_struct still points to
where it once was.

Does this sound like a possible scenerio?

-- 
-todd
