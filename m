Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSILIWe>; Thu, 12 Sep 2002 04:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSILIWd>; Thu, 12 Sep 2002 04:22:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:12294 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S313571AbSILIWd>; Thu, 12 Sep 2002 04:22:33 -0400
Message-ID: <3D804FB6.F310E0FB@aitel.hist.no>
Date: Thu, 12 Sep 2002 10:26:30 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: thunder7@xs4all.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: Killing/balancing processes when overcommited
References: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com> <20020911182741.GA17945@middle.of.nowhere>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan wrote:
> 
> From: Jim Sibley <jlsibley@us.ibm.com>
> Date: Wed, Sep 11, 2002 at 11:08:43AM -0700
> > 1 - cpu usage may not be a good measure
> > 2 - Large memory tasks may not be a good measure
> > 3 - Measuring memory by task is misleading
> > 4 - Niceness is not really useful in a multi-user environment.
> > 5 - Other numerical limits tend to be arbitrary.
> 
> I was just think (feel free to point out the errors of my way):
> 
> what if we used the time a program was started as a guide? The last
> programs started are killed of first.
> 
> That would mean that init survives to the last, as would the daemons
> that are started when booting.

And if one of your daemons has a slow memory leak then this happens:
You go OOM after a while (hours, days) - a user program is killed.  
Buth the leaky dameon is running, so after a shorter time you go OOM
again.
Another user program is killed.  This goes on for a while, it becomes
hard
to log in to fix things because the freshly logged in administrator
has a very new process and is the first to go!

After a while, all user programs are gone and daemons die one by one
until the offending one goes.  Or perhaps the offending damon
don't leak anymore - it might be sshd but there is not enough memory
to log in so it don't get to leak any more.  
> 
> Alternatively, suppose we get a very large pid-space, and at the end of
> booting there's something like
> 
> echo "5000" > /proc/sys/minimum-pid-from-here-on
> 
> Then, you could do:
> 
> echo "5000" > proc/sys/oom_lowest_pid_to_try_killing_first

Again, a bad daemon (pid < 5000) will slowly take out everything else,
with login impossible in the meantime.

> in other words, protect a part of pid-space against oom-killing.

Any way you protect a bunch of processes might fail if the bad one
is among them.  Also, the OOM killer will have to fall back
to the standard heuristic whenever there is only protected
processes left.  

Helge Hafting
