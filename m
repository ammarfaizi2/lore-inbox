Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285325AbRLSP1G>; Wed, 19 Dec 2001 10:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285323AbRLSP05>; Wed, 19 Dec 2001 10:26:57 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:37131 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S285326AbRLSP0t>; Wed, 19 Dec 2001 10:26:49 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: wait() and strace -f
In-Reply-To: <20011218021407.A1595@ping.be>
	<877krlc60x.fsf@devron.myhome.or.jp> <20011218211839.A4447@ping.be>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 20 Dec 2001 00:26:38 +0900
In-Reply-To: <20011218211839.A4447@ping.be>
Message-ID: <87zo4f1b9t.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Roeckx <Q@ping.be> writes:

> > Probably, it's feature (or bug) of strace. I'm seems, if strace has
                                                             ^^^^^^
Sorry, s/strace/the trace process/

> > child, trace of a child is started before wait() of parent.  Then,
> > exit() of child continue wait() of parent.
> 
> If I understand what you're saying, sleep(1) in child1, and
> sleep(2) in the parent should fix the problem, which it doesn't.
> 
> And it still doesn't explain why it only happens with 2 childs.

As far as I read the source, it seems strace is not counting the
zombie. And strace wait exit() of child2 before restarting the wait()
of parent.

        strace          parent        child1        child2
                                      zombie

                       sleep(1)                    sleep(10)
                     before wait()
      trap wait()



                                                 before exit()
      trap exit()
     restart child2
                                                   run exit()
     restart parent
                      run wait()

> Maybe I should have mentioned this before: the wait will clean up
> the first child at the time the second child dies, or atleast
> that's what wait() returns.
> 
> > >         if (!fork())
> > >         {
> > >                 /* Child 1. */
> > 		  sleep(2);
> > >                 return 0;
> > >         }
> > 
> > The above change is continued the parent after 2 seconds.
> 
> I know that too, as I said, only when child 1 dies before the
> parent calls wait().

strace-4.4/process.c in strace_4.4-1.tar.gz

diff -u /tmp/t/strace-4.4/process.c.orig /tmp/t/strace-4.4/process.c
--- /tmp/t/strace-4.4/process.c.orig	Fri Aug  3 20:51:28 2001
+++ /tmp/t/strace-4.4/process.c	Wed Dec 19 08:20:05 2001
@@ -1349,7 +1349,7 @@
 		/* WTA: fix bug with hanging children */
 		if (!(tcp->u_arg[2] & WNOHANG) && tcp->nchildren > 0) {
 			/* There are traced children */
-			tcp->flags |= TCB_SUSPENDED;
+			/* tcp->flags |= TCB_SUSPENDED; */
 			tcp->waitpid = tcp->u_arg[0];
 		}
 	}

Try the above patch. This restart wait() immediately. However, probably
it will break something of other. ;)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
