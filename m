Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283288AbRK2QHU>; Thu, 29 Nov 2001 11:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283292AbRK2QHQ>; Thu, 29 Nov 2001 11:07:16 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:62139 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S283297AbRK2QHF>; Thu, 29 Nov 2001 11:07:05 -0500
Message-ID: <3C065D2F.B45332C6@nortelnetworks.com>
Date: Thu, 29 Nov 2001 11:07:11 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: logging to NFS-mounted files seems to cause hangs when NFS dies
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working on an embedded platform and we seem to be having a problem with
syslog and logging to NFS-mounted files.

We have syslog logging to NFS and also logging to a server on another machine. 
The desired behaviour is that if the NFS server or the net connection conks out,
the logs are silently dropped.  (Critical logs are also logged in memory that
isn't wiped out on reboot.)

Currently,  /var/log is mounted with the following options:
rw,rsize=4096,wsize=4096,timeo=7,retrans=3,bg,soft,intr

We started off with hard mounts due to the warnings about soft mounts, but that
led to boxes totally hanging when the network connections were pulled or the NFS
server was taken down.  In this scenario we are even unable to login as root at
the console.  This forced us to go to soft mounts in an attempt to fix this
behaviour.

The problem we are seeing is that if we lose the network connection or the NFS
mount (which immediately causes an attempt to log the problem), it seems that
syslog gets stuck in NFS code in the kernel and other stuff can be delayed for a
substantial amount of time (many tens of seconds).  Just for kicks we tried
logging to ramdisk, and everything works beautifully.

Now I'm a bit unclear as to why other processes are being delayed--does anyone
have any ideas?  My current theories are that either the nfs client code has a
bug, or syslog() calls are somehow blocking if syslogd can't write the file
out.  I've just started looking at the syslog code, but its pretty rough going
as there are very few comments.

Help?  We're running a customized 2.2.17 kernel and syslog 1.4.1.

Thanks,

Chris Friesen


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
