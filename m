Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283390AbRK2VIY>; Thu, 29 Nov 2001 16:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283391AbRK2VIO>; Thu, 29 Nov 2001 16:08:14 -0500
Received: from dialin-145-254-146-210.arcor-ip.net ([145.254.146.210]:12338
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S283392AbRK2VH4>; Thu, 29 Nov 2001 16:07:56 -0500
Message-ID: <3C06A3DC.F959F464@loewe-komp.de>
Date: Thu, 29 Nov 2001 22:08:44 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.13-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Christopher Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: logging to NFS-mounted files seems to cause hangs when NFS dies
In-Reply-To: <3C065D2F.B45332C6@nortelnetworks.com> <20011129094348.E29249@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger schrieb:
> 
> On Nov 29, 2001  11:07 -0500, Christopher Friesen wrote:
> > I'm working on an embedded platform and we seem to be having a problem with
> > syslog and logging to NFS-mounted files.
> >
> > We have syslog logging to NFS and also logging to a server on another machine.
> 
> Why not just log to the syslog daemon on another machine.  Logging to NFS
> does not help you in this case.
> 
> > The desired behaviour is that if the NFS server or the net connection conks
> > out, the logs are silently dropped.  (Critical logs are also logged in memory
> > that isn't wiped out on reboot.)
> 
> > The problem we are seeing is that if we lose the network connection or the
> > NFS mount (which immediately causes an attempt to log the problem), it seems
> > that syslog gets stuck in NFS code in the kernel and other stuff can be
> > delayed for a substantial amount of time (many tens of seconds).  Just for
> > kicks we tried logging to ramdisk, and everything works beautifully.
> 
> Well, it seems obvious, doesn't it?  If the network connection is lost, then
> you can't very well write to the Network File System, can you?  One of the
> features of NFS is that if the network dies, or the server is lost, then
> the client does not lose any data that was being written to the NFS mount.
> 
> > Now I'm a bit unclear as to why other processes are being delayed--does anyone
> > have any ideas?  My current theories are that either the nfs client code has a
> > bug, or syslog() calls are somehow blocking if syslogd can't write the file
> > out.  I've just started looking at the syslog code, but its pretty rough going
> > as there are very few comments.
> 
> This is entirely a syslog problem, if you want to do it that way.  The NFS
> code is working as expected, and will not be changed.  You might have to
> multi-thread syslog to get it to do what you want, but in the end you are
> better off just using the network logging feature and write the logs at
> the server directly.
> 

Well, it could use nonblocking IO like it does with named pipes.

When syslogd logs to a named pipe and the reader does not consume the data,
syslogd will not block but discards the messages.

The best way, like you suggested, is logging to a remote syslogd, running
with syslogd -r
