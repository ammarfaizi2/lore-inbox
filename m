Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283421AbRK2Wmu>; Thu, 29 Nov 2001 17:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283425AbRK2Wmk>; Thu, 29 Nov 2001 17:42:40 -0500
Received: from zeus.kernel.org ([204.152.189.113]:40622 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S283421AbRK2Wm1>;
	Thu, 29 Nov 2001 17:42:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: logging to NFS-mounted files seems to cause hangs when NFS dies
Date: Thu, 29 Nov 2001 16:42:18 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <3C065D2F.B45332C6@nortelnetworks.com>
In-Reply-To: <3C065D2F.B45332C6@nortelnetworks.com>
MIME-Version: 1.0
Message-Id: <01112916421800.11678@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 November 2001 10:07, Christopher Friesen wrote:
> I'm working on an embedded platform and we seem to be having a problem with
> syslog and logging to NFS-mounted files.
>
> We have syslog logging to NFS and also logging to a server on another
> machine. The desired behaviour is that if the NFS server or the net
> connection conks out, the logs are silently dropped.  (Critical logs are
> also logged in memory that isn't wiped out on reboot.)
>
> Currently,  /var/log is mounted with the following options:
> rw,rsize=4096,wsize=4096,timeo=7,retrans=3,bg,soft,intr
>
> We started off with hard mounts due to the warnings about soft mounts, but
> that led to boxes totally hanging when the network connections were pulled
> or the NFS server was taken down.  In this scenario we are even unable to
> login as root at the console.  This forced us to go to soft mounts in an
> attempt to fix this behaviour.
>
> The problem we are seeing is that if we lose the network connection or the
> NFS mount (which immediately causes an attempt to log the problem), it
> seems that syslog gets stuck in NFS code in the kernel and other stuff can
> be delayed for a substantial amount of time (many tens of seconds).  Just
> for kicks we tried logging to ramdisk, and everything works beautifully.
>
> Now I'm a bit unclear as to why other processes are being delayed--does
> anyone have any ideas?  My current theories are that either the nfs client
> code has a bug, or syslog() calls are somehow blocking if syslogd can't
> write the file out.  I've just started looking at the syslog code, but its
> pretty rough going as there are very few comments.
>
> Help?  We're running a customized 2.2.17 kernel and syslog 1.4.1.

There is an easier way - depending on your point of view:

1. Designate a host on the network to be a loghost, and have syslog send the
   messages there. Syslog will use UDP to send the messages so if the
   network is dead, the messages will be dropped.

2. Don't log messages to a NFS mounted disk. Part of the problem
   in doing so causes a cascading of messages (NFS timeout, log
   the timeout, syslog writes to NFS... another NFS timeout + long
   delay with syslog trying to write the first... buffers fill up....

There should be an example entry in the default /etc/syslog.conf for
logging to a remote host, but the line entry should be:

*	@loghost

This can (most likely) be the only entry in the config file.

One advantage this has is that all log files can be scanned at
once, and on one system. Another is that if a workstation gets
hacked, at least they won't be able to remove any evidence that might
have shown up in the syslog output...
