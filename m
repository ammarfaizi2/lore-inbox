Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264521AbSIVUo3>; Sun, 22 Sep 2002 16:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264522AbSIVUo3>; Sun, 22 Sep 2002 16:44:29 -0400
Received: from smtpout.mac.com ([204.179.120.97]:7380 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S264521AbSIVUo2>;
	Sun, 22 Sep 2002 16:44:28 -0400
Date: Sun, 22 Sep 2002 20:55:39 +0200
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: ingo Molnar <mingo@redhat.com>
To: linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <E2E1F730-CE5C-11D6-8873-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > The true cost of M:N shows up when threading is actually used
 > for what it's intended to be used :-)

 > M:N's big mistakes is that it concentrates on what
 > matters the least: useruser context switches.

Well, from the perspective of the kernel, userspace is a black box.
Is that also true for kernel developers?

If you, as an application engineer, decide to use a multithreaded
design, it could be a) you want to learn or b) have some good
reasons to choose that.

Having multiple threads doing real work including IO means more
blocking IO and therefore more context switches. One reason to
choose threading is to _not_ have to use select/poll in app code.
If you gather more IO requests and multiplex them with select/poll
the chances are higher that the syscall returns without context
switch. Therefore you _save_ some real context switches with
useruser context switches.

Don't make the mistake to think too much about the optimal case.
(as Linus told us: optimize for the _common_ case :)

You think that one should have an almost equal number of threads
and processors. This is unrealistic despite some server apps
running on +4(8?) way systems. With this assumption nobody would
write a multithreaded desktop app (>90% are UP).

The effect of M:N on UP systems should be even more clear. Your
multithreaded apps can't profit of parallelism but they do not
add load to the system scheduler. The drawback: more syscalls
(I think about removing the need for
flags=fcntl(GETFLAGS);fcntl(fd,NONBLOCK);write(fd);fcntl(fd,flags))

Until we have some numbers we can't say which approach is better.
I'm convinced that apps exist that run better on one and others
on the other.

AIX and Irix deploy M:N - I guess for a good reason: it's more
flexible and combine both approaches with easy runtime tuning if
the app happens to run on SMP (the uncommon case).

Your great work at the scheduler and tuning on exit are highly
appreciated. Both models profit - of course 1:1 much more.

