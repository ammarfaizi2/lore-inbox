Return-Path: <linux-kernel-owner+w=401wt.eu-S1753249AbWLQXsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbWLQXsT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 18:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbWLQXsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 18:48:19 -0500
Received: from smtp-7.smtp.ucla.edu ([169.232.46.138]:42461 "EHLO
	smtp-7.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbWLQXsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 18:48:18 -0500
X-Greylist: delayed 18032 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 18:48:17 EST
Date: Sun, 17 Dec 2006 10:47:32 -0800
From: Chris Frost <chris@frostnet.net>
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <w@1wt.eu>
Subject: Re: PROBLEM: 2.4 oops: proc_pid_stat()
Message-ID: <20061217184732.GJ4030@pooh.cs.ucla.edu>
References: <20060916232402.GW13465@pooh.cs.ucla.edu> <20060917055032.GL541@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060917055032.GL541@1wt.eu>
X-PGP-Key: Send email with subject 'retrieve pgp key'
X-PGP-Fingerprint: Send email with subject 'retrieve pgp fingerprint'
User-Agent: Mutt/1.5.10i
X-Probable-Spam: no
X-Spam-Hits: 0.05
X-Spam-Report: FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for these thoughts, Willy. Because the affected machine is a
server in another state I first tried going ahead and upgrading to 2.6.17.3.
The machine has now been up for 91 days and counting; in the year since
the mentioned change that brought on the segfaults I do not believe it
had ever ran that long. So it seems 2.4.32 to 2.6.17.3 either fixed
or happened to sidestep the issue. If I had another machine with the
problem I would be happy to investigate further, but, unfortunately, this
machine needs to stay up.

I just wanted to let possible others with similar problems know and
thank you and Grant Coady for your feedback!


On Sun, Sep 17, 2006 at 07:50:32AM +0200, Willy Tarreau wrote:
> On Sat, Sep 16, 2006 at 04:24:02PM -0700, Chris Frost wrote:
> > [1.] One line summary of the problem:
> > 2.4.32 proc_pid_stat() repeatedly segfaults.
> > 
> > [2.] Full description of the problem/report:
> > 2.4.32 kernel, after being up for a few days to a few weeks, repeatedly
> > segfaults in proc_pid_stat(), triggered by w, ps, and other programs.
> > 
> > [3.] Keywords (i.e., modules, networking, kernel):
> > kernel proc_pid_stat()
> > 
> > [4.] Kernel version (from /proc/version):
> > $ cat /proc/version
> > Linux version 2.4.32 (root@tiger) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 Wed Dec 21 10:57:37 CST 2005
> > 
> > [5.] Output of Oops.. message (if applicable) with symbolic information 
> >      resolved (see Documentation/oops-tracing.txt)
> > See attached oops.w.log (triggered by w) and oops.ps.log (triggered by ps).
> > 
> > [6.] A small shell script or example program which triggers the
> >      problem (if possible)
> > Once it starts oopsing, "w" and "ps aux" trigger an oops every time.
> > 
> > [7.] Environment
> > i386 Debian sarge on a network server in a closet.
> > 

<snip hardware information from original email>

> > 
> > [7.7.] Other information that might be relevant to the problem
> >        (please look in /proc and include all information that you
> >        think to be relevant):
> > ls -lR /proc does not trigger an oops.
> > 
> > [X.] Other notes, patches, fixes, workarounds:
> > I am not familiar with this aspect of linux, but 2.4.33.3's proc_pid_stat()
> > appears to be identical. It also appears there have been several bug fixes
> > in 2.6 (including race condition corrections); perhaps there are issues
> > fixed in 2.6 but whose patches not been backported to 2.4?
> 
> The code in 2.6 is quite different. Your problem here does not seem related
> to locking, because you can repeat it at will. I rather think that one of
> your tasks is going ill. I looked at the oops and compared with the code.
> In your case, the task->sig pointer equals 0x170, which is clearly wrong.
> I suspect it's a kernel thread which goes mad, because user tasks should
> not be able to write anything there.
> 
> When this problem happens, could you try to identify the wrong task ?
> Basically, this should help :
> 
> # cd /proc
> # for i in [0-9]*; do
>     echo "Trying pid $i..."
>     if ! cat $i/stat > /dev/null; then
>       echo "!!! BAD PID : $i !!!"
>     fi
>  done
> 
> If it is a kernel thread (low pid), you will not be able to find
> which one until you reboot, because the only other entry which
> might return its name is "status" which also uses collect_sigign_sigcatch().
> Otherwise, it is easy to find the full command line of the process :
> 
> # echo $(tr '\000' ' ' < /proc/$BADPID/cmdline)
> 
> > The machine in question become unstable, about a year ago, when an additional
> > harddrive and ram were added and the kernel upgraded from 2.2.19 (with ext3)
> > to 2.4.31. There, there may certainly be a hardware issue playing a role
> > here. However, since the problem is completely reliable once it starts within
> > a given boot and occurs, given time, across reboots, it seems likely
> > that a software bug may be involved.
> 
> To be honnest, I'm skeptical. This is the first report of such an easily
> reproductible problem. Since you added RAM in your system, I would strongly
> suggest passing memtest on it during a full night. Random bit flips might
> turn a null into non-null, causing some unexpected code paths to be taken.

-- 
Chris Frost  |  <http://www.frostnet.net/chris/>
-------------+----------------------------------
Public PGP Key:
   Email chris@frostnet.net with the subject "retrieve pgp key"
   or visit <http://www.frostnet.net/chris/about/pgp_key.phtml>
