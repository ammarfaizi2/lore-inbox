Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135989AbRD0Mv3>; Fri, 27 Apr 2001 08:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135971AbRD0MvU>; Fri, 27 Apr 2001 08:51:20 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:16823 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S135989AbRD0MvK>; Fri, 27 Apr 2001 08:51:10 -0400
Date: Fri, 27 Apr 2001 07:51:08 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104271251.HAA45696@tomcat.admin.navo.hpc.mil>
To: subba9@home.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: init process in 2.2.19
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subba Rao <subba9@home.com>:
> I am trying to add a process which is to be managed by init. I have added the
> following entry to /etc/inittab
> 
> SV:2345:respawn:env - PATH=/usr/local/bin:/usr/sbin:/usr/bin:/bin svscan /service </dev/null 2> dev/console
> 
> After saving, I execute the following command:
> 
> 	# kill -HUP 1
> 
> This does not start the process I have added. The process that I have added
> only starts when I do:
> 
> 	# init u
> or
> 	# telinit u
> 
> PS - The process will not start even after a reboot. I have to manually do one
> of the above commands as root.
> 
> My kernel version is : 2.2.19
> Distro : Slackware
> GCC : gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
> 
> Any help appreciated.

I'm using Slackware 7.1, so one of the following possible solutions may work:

First
	Make sure the daemon is available at boot time - if /usr/local/bin is
	where the svscan daemon exists, then /usr/local must be part of the
	root file system.

	What I do is have a "/host" directory tree on the root file system
	for this purpose. Alternatively, I start the daemon when the system
	enters multi-user mode (either /etc/rc.d/rc.local, or one of the
	already existing scripts related to what the daemon does).

A second possibility (try this first - its easer:
	I see that the daemon is to run in modes "2345". There is a possiblity
	that you have this entry near the beginning of the inittab. If so, try
	putting it at the end. I believe that init runs each line of the
	inittab for a given run level in the same order that it appears in the
	file. Putting the entry last should allow it to be started AFTER
	all file systems are mounted - the  entry for multiuser mode is:

	# Script to run when going multi user.
	rc:2345:wait:/etc/rc.d/rc.M

	If your daemon entry follows this line then it may work as you
	expect.

	Remember, any facility that the daemon depends on must be
	initialized before the daemon starts - If it uses the network
	then the network needs to be loaded (mine needs sockets loaded...)
	before the daemon is started.

	Note: since the assumption that the daemon is in /usr/local and
	      that /usr/local is a separate file system is true, then
	      you will no longer be able to dismount the /usr/local
	      file system while in multi-user mode (it's busy). This may
	      only be relevent to how your backups are done.

BTW, SIGHUP may not be the correct signal - from the init manpage:

       SIGHUP
            Init looks for /etc/initrunlvl and  /var/log/initrun-
            lvl.   If  one  of  these  files exist and contain an
            ASCII runlevel, init switches to  the  new  runlevel.
            This  is  for backwards compatibility only! .  In the
            normal case (the files don't exist) init behaves like
            telinit q was executed.

The only documented startup is "init u" or "telinit u". To re-read the
inittab file use "init q" or "telinit q". I suspect the manpage is a
little "inaccurate" in stating that SIGHUP is equivalent to "telinit q"

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
