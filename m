Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751715AbWBELl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWBELl2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWBELl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:41:28 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:39844 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750764AbWBELl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:41:27 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm] swsusp: freeze user space processes first
Date: Sun, 5 Feb 2006 12:39:52 +0100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nigel@suspend2.net
References: <200602051014.43938.rjw@sisk.pl> <200602051211.07103.rjw@sisk.pl> <20060205111815.GG1790@elf.ucw.cz>
In-Reply-To: <20060205111815.GG1790@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602051239.53175.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 February 2006 12:18, Pavel Machek wrote:
> On Ne 05-02-06 12:11:06, Rafael J. Wysocki wrote:
> > On Sunday 05 February 2006 11:50, Ingo Molnar wrote:
> > > 
> > > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > 
> > > > > The logic in that loop makes my brain burst.
> > > > > 
> > > > > What happens if a process does vfork();sleep(100000000)?
> > > > 
> > > > The freezing of processes will fail due to the timeout.
> > > > 
> > > > Without the if (!p->vfork_done) it would fail too, because the child 
> > > > would be frozen and the parent would wait for the vfork completion in 
> > > > the TASK_UNINTERRUPTIBLE state (ie. unfreezeable).  But in that case 
> > > > we have a race between the "freezer" and the child process (ie. if the 
> > > > child gets frozen before it completes the vfork completion, the paret 
> > > > will be unfreezeable) which sometimes leads to a failure when it 
> > > > should not.  [We have a test case showing this.]
> > > 
> > > then i'd suggest to change the vfork implementation to make this code 
> > > freezable.
> > 
> > I think you are right, but I don't know how to do this.
> > 
> > > Nothing that userspace does should cause freezing to fail.   If it does,
> > > we've designed things incorrectly on the kernel side. 
> > 
> > I tend to agree.
> > 
> > Generally, the problem is due to the use of completions where userland
> > processes are waited for.  The two places I know of are the vfork
> > implementation and the usermode helper code.
> 
> Can you produce userland testcase? If we have uninterruptible process for
> days... that's a bug in kernel, suspend or not.

Sure, no problem.  [Pretty scary, no?]

The test code:

#include <sys/types.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	vfork();
	sleep(300);

	return 0;
}

The result:

rafael@albercik:~/programming/c> ./vfork_test &
[1] 12288
rafael@albercik:~/programming/c> ps l
F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
0   500  6937  6931  17   0  10048  2368 read_c Ss+  pts/1      0:00 /bin/bash
0   500 12139 12133  15   0  10052  2380 wait   Ss   pts/2      0:00 /bin/bash
0   500 12288 12139  15   0   2420   304 fork   D    pts/2      0:00 ./vfork_tes
1   500 12291 12288  18   0   2420   304 hrtime S    pts/2      0:00 ./vfork_tes
0   500 12372 12139  15   0   3596   820 -      R+   pts/2      0:00 ps l
rafael@albercik:~/programming/c> kill 12288
rafael@albercik:~/programming/c> ps l
F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
0   500  6937  6931  17   0  10048  2368 read_c Ss+  pts/1      0:00 /bin/bash
0   500 12139 12133  15   0  10052  2380 wait   Ss   pts/2      0:00 /bin/bash
0   500 12288 12139  15   0   2420   304 fork   D    pts/2      0:00 ./vfork_tes
1   500 12291 12288  18   0   2420   304 hrtime S    pts/2      0:00 ./vfork_tes
0   500 12380 12139  17   0   3600   820 -      R+   pts/2      0:00 ps l
rafael@albercik:~/programming/c> kill -9 12288
rafael@albercik:~/programming/c> ps l
F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
0   500  6937  6931  17   0  10048  2368 read_c Ss+  pts/1      0:00 /bin/bash
0   500 12139 12133  15   0  10052  2380 wait   Ss   pts/2      0:00 /bin/bash
0   500 12288 12139  15   0   2420   304 fork   D    pts/2      0:00 ./vfork_tes
1   500 12291 12288  18   0   2420   304 hrtime S    pts/2      0:00 ./vfork_tes
0   500 12387 12139  16   0   3596   816 -      R+   pts/2      0:00 ps l
rafael@albercik:~/programming/c>

Greetings,
Rafael
