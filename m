Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272473AbRIKOnq>; Tue, 11 Sep 2001 10:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272467AbRIKOnh>; Tue, 11 Sep 2001 10:43:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35845 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268017AbRIKOnZ>; Tue, 11 Sep 2001 10:43:25 -0400
Subject: Re: Resource starvation on a 2.2.19 web server
To: mbrennen@fni.com (Michael Brennen)
Date: Tue, 11 Sep 2001 15:48:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0109101920160.9125-100000@henry.fni.com> from "Michael Brennen" at Sep 10, 2001 08:01:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15gopX-0002lk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> I'm not on the linux-kernel list; please specifically include me in
> any reply.  Thanks...
> 
> I'm seeing a problem with what appears to be running out of file (or
> inode) handles on an apache web server.  I've done everything I have
> been able to find to fix this but have run out of things to try.
> The summary below is as concise and complete as I can make it; if
> additional information is needed I'll happily provide it.  I've run
> linux since 1.57, but I've never had to dig into tuning at this
> level until now.
> 
> This is a 1GB dual PIII-650 box.  I'm using the Mandrake 2.2.19-4.3
> source tree, their latest, as a base for the kernel.  The server is
> running a couple of software raid partitions and a 26 GB EATA SCSI
> partition.  Most of the file systems are ext2, with a Reiser fs on
> the SCSI partition.
> 
> Based on logged errors, some time ago I started increasing
> /proc/sys/fs/{file,inode}-max to 98304 and 524300 respectively.
> The large counts are pushed by rsync in syncing the large web tree
> onto another box.
> 
> >From what I have found on the 'net on kernel tuning, I have made a
> custom 2.2.19 kernel with the following changes in the include
> files.  I am not seeing logged errors on any sort of resource
> starvation on this kernel; before upping the limits I was seeing
> both system and apache errors about no sockets and file handles.
> 
> limits.h       #define NR_OPEN        2048  (overridded by file-nr, I think)
> limits.h       #define OPEN_MAX       2048  (max open files per process)
> posix_types.h: #define __FD_SETSIZE   2048
> socket.h:      #define SOMAXCONN      16384
> 
> The symptom is that after the box runs for a while, nslookup cannot
> resolve a name; it complains that it cannot find the configured DNS
> servers.  If I USR1 warm start apache, nslookup immediately works
> again.  Some system resource is being freed up when apache is
> restarted, but I've been unable to isolate what it is or fix it.
> 
> The two snapshots below are of /proc/sys/fs/* before and after an
> apache warm start.  There is some strange info in file-nr and
> inode-nr.  Per linux/Documentation/proc.txt, the middle number of
> file-nr is "the number of used file handles", and the middle number
> of inode-nr is "the number of free inodes".
> 
> After reset, the number of free inodes goes up.  What seems very
> strange is that the number of free files goes from 4 to 57034,
> almost as if beyond a certain limit the file-nr counter starts
> acting as an underflow counter (just my own observation).
> Particularly inconsistent is that the number of allocated file
> handles before warm start, 58783, is well below the permitted
> maximum of 98304.
> 
> Has anyone seen anything like this to help me understand where to go
> next?  Thanks much in advance,
> 
>    -- Michael
> 
> 
> # before apache warm start
> 0       421083  45      0       0       0
> 1024
> 0       0
> 98304
> 58783   4       98304           <===  file-nr: note the middle number
> 524288
> 524300  43622                   <===  inode-nr: note the middle number
> 524300  43622   0       0       0       0       0
> 256
> 12
> 
> # after apache warm start
> 0       421625  45      0       0       0
> 1024
> 0       0
> 98304
> 58797   57034   98304           <===  was 4 before warm start
> 524288
> 524300  99808                   <===  was 43622 before warm start
> 524300  99808   0       0       0       0       0
> 256
> 12
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

