Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131015AbRAURrq>; Sun, 21 Jan 2001 12:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131138AbRAURrg>; Sun, 21 Jan 2001 12:47:36 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:46701 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S131015AbRAURrT>; Sun, 21 Jan 2001 12:47:19 -0500
Date: Sun, 21 Jan 2001 11:47:17 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101211747.LAA84311@tomcat.admin.navo.hpc.mil>
To: leitner@convergence.de, linux-kernel@vger.kernel.org
Subject: Re: Off-Topic: how do I trace a PID over double-forks?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> This is more a Unix API question than a Linux question.
> 
> I hope the issue is interesting enough to be of interest to some of you.
> 
> Basically, I am writing an init which features process watching
> capabilities.  My init has a management channel with which you can tell
> it "the PID of the ssh process is really 123 instead of 12".
> 
> When init forks a getty and that getty exits, it is restarted.  So far
> so good.  But I want my init to be able to restart uncooperative
> processes like sendmail that fork in the background.  sendmail may be a
> bad example because the sources are available, but please imagine you
> didn't have the sources to sendmail or didn't want to touch them.

Ummm ... basicly a "respawn" entry in the inittab is enough for that.

Second, a "wrapper" can run, and as the last thing it does is "exec binary".
That way the "init" still waits for the same pid.

SGI IRIX systems to this to assign privileges to the started process:

t48:23:respawn:/sbin/suattr -C CAP_FOWNER,CAP_DEVICE_MGT,CAP_DAC_WRITE+ip -c "exec /
sbin/getty -N ttyd48 co_9600"

The "wrapper" is /sbin/suattr, which sets privileges and then execs
the getty program.

If you wanted sendmail then:

sndm:234:respawn:/usr/lib/sendmail -bd -q15m

Will restart sendmail whenever it aborts in runleves 2,3, or 4.

Of course you better have the network functioning by this time.

> Now, the back channel for my init has a function that allows to set the
> PID of a process.  The idea is that the init does not start sendmail but
> a wrapper.  The wrapper forks, runs sendmail, does some magic trickery
> to find the real PID of the daemonized sendmail and tells init this PID
> so init will know it has to restart sendmail when it exits and won't
> restart the wrapper when that exits.

??? The last thing the wrapper should do is "exec", otherwise it really
isn't a wrapper.

> Follow me this far?  Great!  The real problem at hand is: what kind of
> trickery can I employ in that wrapper.  I was hoping for something that
> is not Linux specific, but I haven't found anything yet.  I was also
> hoping that I could find a method that does not rely on /proc being
> there or on any filesystem being mounted read-write (yes, my back
> channel works if the filesystem is mounted read-only).  So, using
> /proc and relying on something like /var/run/sendmail.pid are out.

You can use anything in the wrapper, as long as it is a builtin function.
You can't use things like "ps" or "cat" since they may not be available
yet (/usr may need to be mounted, and in some cases even root). And
watch out for shared libraries too - they may not be available either.

> Someone suggested using fcntl to create a lock and then use fcntl again
> to see who holds the lock.  That sounded good at first, but fork() does
> not seem to inherit locks.  Does anyone have another idea?

Nope. can't use locks - since you haven't got a mounted file system yet.

now you might look at "clone". It is linux specific, but you do get
to specify what is inherited.

> In case I made you wonder: http://www.fefe.de/minit/

I looked, but didn't see a description of what it is for, other than
a replacement for init.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
