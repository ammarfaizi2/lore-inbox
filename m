Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130131AbQLNJVG>; Thu, 14 Dec 2000 04:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130638AbQLNJU5>; Thu, 14 Dec 2000 04:20:57 -0500
Received: from c290168-a.stcla1.sfba.home.com ([65.0.213.53]:25838 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S130131AbQLNJUj>; Thu, 14 Dec 2000 04:20:39 -0500
From: brian@worldcontrol.com
Date: Thu, 14 Dec 2000 00:53:46 -0800
To: linux-kernel@vger.kernel.org
Subject: Is this a compromise and how?
Message-ID: <20001214005345.A3732@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry is this is too far off topic, but it seems to me the
kernel may be helping in this break in or maybe some magic
aspect of the filesystem.

I noted in an ls that

-rwxr-xr-x   1 root     root        36784 Jul 17 05:06 rpc.mountd*
-rwxr-xr-x   1 root     root         3368 Jul 17 05:06 rpc.nfsd*
-rwxr-xr-x   1 root     ftp            22 Sep  8 22:15 rpc.rcmd*
-rwxr-xr-x   1 root     root         9872 Jul 17 05:06 rpc.rquotad*
-rwxr-xr-x   1 root     root        13936 Feb  9  2000 rpc.rstatd*
-rwxr-xr-x   1 root     root         7952 Feb  9  2000 rpc.rusersd*
-rwxr-xr-x   1 root     root         6512 Feb 11  2000 rpc.rwalld*
-rwxr-xr-x   1 root     root        17624 Mar  7  2000 rpc.yppasswdd*
-rwxr-xr-x   1 root     root        23984 Mar  7  2000 rpc.ypxfrd*
-rwxr-xr-x   1 root     root        10692 Sep  5 16:03 rpcinfo*

rpc.rcmd look a little suspicious?

And guess what it contains?

%cat /usr/sbin/rpc.rcmd 
/usr/include/strlib.h

Hmmmm.

%ls -l /usr/include/strlib.h
-rwxr-xr-x   1 root     root        16768 Sep 16 09:55 /usr/include/strlib.h*

%file /usr/include/strlib.h
/usr/include/strlib.h: ELF 32-bit LSB executable, Intel 80386, version 1, dynamically linked (uses shared libs), not stripped

%/usr/include/strlib.h
bind: Address already in use

Now watch this magic trick:

%mkdir foo
%cd foo
%touch strlib.h
%ls
%find . -print
.
./strlib.h
%

Get it?  strlib.h never appears in the file system via ls whereever
it may be created.

More fun:

%echo hello >strlib.h
%ls
%cat strlib.h
hello
%

Pretty cool huh?

Let me know if you would like a copy of the code.

A quick strace shows that it binds to port 24000.

It also contains a list of 5 IP addrs.  I suspect it doesn't
broadcast, but allows people in from those IPs.

Anyone know what has happened?  I religiously install the redhat
updates, and am subscribed to the CERT advistors and install
the fixes the moment I get them.

The system was RedHat 6.2, linux 2.2.17pre14 at the time the
breakin occured.

I've been running firewalled with only services I provide turned
on for access, and in /etc/inetd.conf.

What is keeping strlib.h from appearing ls's?  A hacked ls command?

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2000 By Brian Litzinger, All Rights Reserved
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
