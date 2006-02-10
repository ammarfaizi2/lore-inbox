Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWBJUUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWBJUUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWBJUUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:20:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38315 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751374AbWBJUUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:20:18 -0500
Date: Fri, 10 Feb 2006 21:20:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nigel@suspend2.net
Subject: vfork makes processes uninterruptible [was Re: [PATCH -mm] swsusp: freeze user space processes first]
Message-ID: <20060210202000.GB1696@elf.ucw.cz>
References: <200602051014.43938.rjw@sisk.pl> <200602051211.07103.rjw@sisk.pl> <20060205111815.GG1790@elf.ucw.cz> <200602051239.53175.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602051239.53175.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can you produce userland testcase? If we have uninterruptible process for
> > days... that's a bug in kernel, suspend or not.
> 
> Sure, no problem.  [Pretty scary, no?]

Yes, pretty scary. It will also raise system load for 300 seconds
without any real load.

> The test code:
> 
> #include <sys/types.h>
> #include <unistd.h>
> 
> int main(int argc, char *argv[])
> {
> 	vfork();
> 	sleep(300);
> 
> 	return 0;
> }
> 
> The result:
> 
> rafael@albercik:~/programming/c> ./vfork_test &
> [1] 12288
> rafael@albercik:~/programming/c> ps l
> F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
> 0   500  6937  6931  17   0  10048  2368 read_c Ss+  pts/1      0:00 /bin/bash
> 0   500 12139 12133  15   0  10052  2380 wait   Ss   pts/2      0:00 /bin/bash
> 0   500 12288 12139  15   0   2420   304 fork   D    pts/2      0:00 ./vfork_tes
> 1   500 12291 12288  18   0   2420   304 hrtime S    pts/2      0:00 ./vfork_tes
> 0   500 12372 12139  15   0   3596   820 -      R+   pts/2      0:00 ps l
> rafael@albercik:~/programming/c> kill 12288
> rafael@albercik:~/programming/c> ps l
> F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
> 0   500  6937  6931  17   0  10048  2368 read_c Ss+  pts/1      0:00 /bin/bash
> 0   500 12139 12133  15   0  10052  2380 wait   Ss   pts/2      0:00 /bin/bash
> 0   500 12288 12139  15   0   2420   304 fork   D    pts/2      0:00 ./vfork_tes
> 1   500 12291 12288  18   0   2420   304 hrtime S    pts/2      0:00 ./vfork_tes
> 0   500 12380 12139  17   0   3600   820 -      R+   pts/2      0:00 ps l
> rafael@albercik:~/programming/c> kill -9 12288
> rafael@albercik:~/programming/c> ps l
> F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
> 0   500  6937  6931  17   0  10048  2368 read_c Ss+  pts/1      0:00 /bin/bash
> 0   500 12139 12133  15   0  10052  2380 wait   Ss   pts/2      0:00 /bin/bash
> 0   500 12288 12139  15   0   2420   304 fork   D    pts/2      0:00 ./vfork_tes
> 1   500 12291 12288  18   0   2420   304 hrtime S    pts/2      0:00 ./vfork_tes
> 0   500 12387 12139  16   0   3596   816 -      R+   pts/2      0:00 ps l
> rafael@albercik:~/programming/c>
> 
> Greetings,
> Rafael

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
