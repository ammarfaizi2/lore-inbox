Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310429AbSCGR52>; Thu, 7 Mar 2002 12:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310430AbSCGR5T>; Thu, 7 Mar 2002 12:57:19 -0500
Received: from boden.synopsys.com ([204.176.20.19]:10897 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S310429AbSCGR5O>; Thu, 7 Mar 2002 12:57:14 -0500
Date: Thu, 7 Mar 2002 18:06:08 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: lkml@goofy.gr05.synopsys.com
Subject: 2.4.2-SMP: problem locking nfs files mounted on HPUX (ENOLCK)
Message-ID: <20020307180608.A2750@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

i'm trying to lock a file using advisory locks.
The file is on the filesystem exported by a linux machine
(RH 6.2, 2.4.2-SMP). The filesystem is mounted on HP-UX B.11.00
(HP-UX host1 B.11.00 A 9000/785 2011306912 two-user license).
Right now i cannot try this with the newer kernels.

The following simple program fails with ENOLCK.

#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>

int main(int c, char **v)
{
    for (++v, --c; c--; ++v) {
        struct flock lck = {F_RDLCK, SEEK_SET, 0, 0}; /* whole file */
        int fd = open(*v, O_RDONLY);
        if ( fd < 0 )
            fprintf(stderr, "%s: %s\n", *v, strerror(errno));
        else {
            if ( fcntl(fd, F_SETLK, &lck) < 0 )
                fprintf(stderr, "%s[%d]: %s\n", *v, lck.l_pid, strerror(errno));
            else
                printf("%s..ok\n", *v);
	    close(fd);
        }
    }
    return 0;
}

The typical output is:

/etc/passwd..ok
/net/sun-host/file1..ok
/net/aix-host/file1..ok
/net/linux-2_4_2-host/file1[0]: No locks available

The "[0]" is lck.l_pid from the example above.

HP's manpage have 3! explanations:

           [ENOLCK]       cmd is F_SETLK or F_SETLKW, the type of lock is a
                          read or write lock, and no more file-locking
                          headers are available (too many files have
                          segments locked), or no more record locks are
                          available (too many file segments locked).

           [ENOLCK]       cmd is F_SETLK or F_SETLKW, the type of lock
                          (l_type) is a read lock (F_RDLCK) or write lock
                          (F_WRLCK) and the file is an NFS file with access
                          bits set for enforcement mode.

           [ENOLCK]       cmd is F_GETLK, F_SETLK, or F_SETLKW, the file is
                          an NFS file, and a system error occurred on the
                          remote node.


My apologies if someone find the question inappropiate with the topic.
And thanks in advance for any help.


-alex
