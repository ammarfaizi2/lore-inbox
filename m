Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310446AbSCGSsD>; Thu, 7 Mar 2002 13:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310447AbSCGSrx>; Thu, 7 Mar 2002 13:47:53 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:25078 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S310446AbSCGSrp>; Thu, 7 Mar 2002 13:47:45 -0500
Date: Thu, 7 Mar 2002 19:47:27 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Rick Stevens <rstevens@vitalstream.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-SMP: problem locking nfs files mounted on HPUX (ENOLCK)
Message-ID: <20020307194727.A3390@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Rick Stevens <rstevens@vitalstream.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020307180608.A2750@riesen-pc.gr05.synopsys.com> <3C87AFB9.3000008@vitalstream.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C87AFB9.3000008@vitalstream.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the lockd is running (kernel lockd).
Besides works from sun to linux (running the program on a sun host show
positive results).


On Thu, Mar 07, 2002 at 10:21:45AM -0800, Rick Stevens wrote:
> Alex Riesen wrote:
> 
> >Hi, all
> >
> >i'm trying to lock a file using advisory locks.
> >The file is on the filesystem exported by a linux machine
> >(RH 6.2, 2.4.2-SMP). The filesystem is mounted on HP-UX B.11.00
> >(HP-UX host1 B.11.00 A 9000/785 2011306912 two-user license).
> >Right now i cannot try this with the newer kernels.
> 
> 
> Is the Linux server running lockd?  I can't recall if RH6.2 has
> that or not.  There are other problems with older RH releases.
> For example, RH6.2 doesn't support NFS V3, hence no bigfile support
> over NFS.
> 
> You really should upgrade to RH7.2 and many of your problems will
> go away.
> 
> 
> >The following simple program fails with ENOLCK.
> >
> >#define _GNU_SOURCE
> >#include <unistd.h>
> >#include <stdio.h>
> >#include <fcntl.h>
> >#include <string.h>
> >#include <errno.h>
> >
> >int main(int c, char **v)
> >{
> >    for (++v, --c; c--; ++v) {
> >        struct flock lck = {F_RDLCK, SEEK_SET, 0, 0}; /* whole file */
> >        int fd = open(*v, O_RDONLY);
> >        if ( fd < 0 )
> >            fprintf(stderr, "%s: %s\n", *v, strerror(errno));
> >        else {
> >            if ( fcntl(fd, F_SETLK, &lck) < 0 )
> >                fprintf(stderr, "%s[%d]: %s\n", *v, lck.l_pid, strerror(errno));
> >            else
> >                printf("%s..ok\n", *v);
> >	    close(fd);
> >        }
> >    }
> >    return 0;
> >}
> >
> >The typical output is:
> >
> >/etc/passwd..ok
> >/net/sun-host/file1..ok
> >/net/aix-host/file1..ok
> >/net/linux-2_4_2-host/file1[0]: No locks available
> >
> >The "[0]" is lck.l_pid from the example above.
> >
> >HP's manpage have 3! explanations:
> >
> >           [ENOLCK]       cmd is F_SETLK or F_SETLKW, the type of lock is a
> >                          read or write lock, and no more file-locking
> >                          headers are available (too many files have
> >                          segments locked), or no more record locks are
> >                          available (too many file segments locked).
> >
> >           [ENOLCK]       cmd is F_SETLK or F_SETLKW, the type of lock
> >                          (l_type) is a read lock (F_RDLCK) or write lock
> >                          (F_WRLCK) and the file is an NFS file with access
> >                          bits set for enforcement mode.
> >
> >           [ENOLCK]       cmd is F_GETLK, F_SETLK, or F_SETLKW, the file is
> >                          an NFS file, and a system error occurred on the
> >                          remote node.
> >
> >
> >My apologies if someone find the question inappropiate with the topic.
> >And thanks in advance for any help.
