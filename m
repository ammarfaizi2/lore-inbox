Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbUCXCPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 21:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUCXCPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 21:15:31 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:56533 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262971AbUCXCP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 21:15:27 -0500
Subject: Re: Hidden PIDs in /proc
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: AlberT@agilemovement.it, miquels@cistron.nl
Content-Type: text/plain
Organization: 
Message-Id: <1080094813.2232.815.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Mar 2004 21:20:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I allready did it ... infact the second test I posted
> correctly shows the  thread ... but, why ps ax -m does
> *not* show it ??  

It does show the threads, but your "grep" missed them.
The built-in process selection and sorting features
are properly thread-aware.

> uh oh .. my bad ...  but .. my ignorance now ask
> what is the real diff between  -m and -T option for ps ...

-m  process followed by threads, Tru64 SysV style
m   process followed by threads, Tru64 BSD style
-T  grouped threads with TID column, Irix style
-L  grouped threads with LWP (and NLWP maybe), Solaris style
H   loose threads, FreeBSD style

I'll give you a few examples with a 2-thread process.
Note how the m option distinguishes signals that are
pending on a process from signals that are pending on
a thread. (some whitespace has been trimmed out too)
Also, the H option's PID column most likely should show
the thread ID instead; help with FreeBSD 5's thread
and MAC behavior would be appreciated.

$ ps -C clone-once sH
UID PID   PENDING   BLOCKED   IGNORED    CAUGHT STAT TTY   TIME COMMAND         
100 634  00000000  00000000 <00000000  00000001 S    pts/9 0:00 clone-once           
100 634  00000000  00000000 <00000000  00000001 S    pts/9 0:00 clone-once           
$ ps -C clone-once sm
UID PID   PENDING   BLOCKED   IGNORED    CAUGHT STAT TTY   TIME COMMAND         
100 634  00000000         -         -         - -    pts/9 0:00 clone-once           
100   -  00000000  00000000 <00000000  00000001 S    -     0:00 -         
100   -  00000000  00000000 <00000000  00000001 S    -     0:00 -         
$ ps -C clone-once -fm
UID    PID  PPID C STIME TTY       TIME CMD        
albert 634     1 0 20:42 pts/9 00:00:00 clone-once          
albert   -     - 0 20:42 -     00:00:00 -        
albert   -     - 0 20:42 -     00:00:00 -        
$ ps -C clone-once -fT
UID    PID  SPID  PPID C STIME TTY       TIME CMD        
albert 634 16634     1 0 20:42 pts/9 00:00:00 clone-once          
albert 634 16635     1 0 20:42 pts/9 00:00:00 clone-once          
$ ps -C clone-once -fL
UID    PID  PPID   LWP C NLWP STIME TTY       TIME CMD        
albert 634     1 16634 0    2 20:42 pts/9 00:00:00 clone-once          
albert 634     1 16635 0    2 20:42 pts/9 00:00:00 clone-once          
$ 


