Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274684AbRIYW5I>; Tue, 25 Sep 2001 18:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274683AbRIYW47>; Tue, 25 Sep 2001 18:56:59 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:62669 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S274681AbRIYW4l>; Tue, 25 Sep 2001 18:56:41 -0400
Message-ID: <3BB10BE4.A3ADC84E@kegel.com>
Date: Tue, 25 Sep 2001 15:57:40 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: remote core dumping / just in time debugging
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking at adding a hook to the kernel to allow
core dumps to go somewhere other than ./core.  

Initially, I'm looking into allowing core to be a fifo (yeah, it's a
hack, but supposedly it worked on solaris in 1998), but later I'll
want to be able to set a default coredump handler for all processes.

Looking at previous discussion on the topic, e.g. 
Kenneth Albanowski (kjahds@kjahds.com)'s post "Re: core files" on 1999/01/01
http://groups.google.com/groups?hl=en&selm=fa.m8ig46v.1b2q89r%40ifi.uio.no ,
the scheme that comes to mind is:

When the kernel wants to dump core on a process, it opens the fifo
/dev/coredumper and writes the pid of the process to the fifo, then
puts the process to sleep.  On error, no fifo, or fifo still full after 
a couple minutes, it dumps core as before.

The process listening to /dev/coredumper reads the pid, then opens a fd
to where it wants the core to be dumped to, then uses ptrace
to request a core dump of the given pid to the given fd.
The fd may be a normal file, or a socket or fifo (in which case the
kernel uses padding rather than seeking to page boundaries).

Security is maintained because /dev/coredumper can be owned by root and chmod 600,
and because the daemon reading from it must have privs to use ptrace on
the given process.

This would allow just-in-time debugging as well as remote core dumping.

Comments?
- Dan
