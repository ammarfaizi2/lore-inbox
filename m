Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbUB2Vhz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 16:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbUB2Vhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 16:37:55 -0500
Received: from pD9EF00E7.dip.t-dialin.net ([217.239.0.231]:19194 "EHLO
	roesrv01.roemling.home") by vger.kernel.org with ESMTP
	id S262149AbUB2Vhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 16:37:48 -0500
Message-ID: <40425BA2.6030905@roemling.net>
Date: Sun, 29 Feb 2004 22:37:38 +0100
From: Jochen Roemling <jochen@roemling.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it> <1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net> <20040226160616.E1652@build.pdx.osdl.net> <20040226163236.M22989@build.pdx.osdl.net> <403E958B.6020406@roemling.net> <20040227011151.GT693@holomorphy.com> <403E9E54.6030404@roemling.net> <20040227021101.GV693@holomorphy.com>
In-Reply-To: <20040227021101.GV693@holomorphy.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020808010403050202070801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020808010403050202070801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

William Lee Irwin III wrote:

>It's capable(CAP_IPC_LOCK) || in_group_p(0), not current->uid == 0.
>It will barf if you ask for more than either one of those limits. It
>will also barf if you ask for an amount not a multiple of the hugepage
>size. Please show the test program's code and strace the test program
>to determine what response it's getting.
>
>  
>
I attached the test pgm. It is nearly the same as shown
in Documentation/vm/hugetlbpage.txt

If you run it as root, it allocates 1 Hugepage, if run as user, it fails.

roesrv01:~ # ./a.out
shmid: 0x220004
shmaddr: 0x40167000
Starting the writes:
....
Starting the Check...Done.
roesrv01:~ # su - jochen
jochen@roesrv01:~> ./a.out
Failure:: Operation not permitted

I guess, a strace is not necessary.
The pgm has only the main function and only one position where it says 
"Failure"

What do I have to do to make this pgm run as an ordinary user with a 
stock kernel?

Curious...
Jochen

--------------020808010403050202070801
Content-Type: text/plain;
 name="huge.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="huge.c"

/* Example of using hugepage in user application using Sys V shared memory
 * system calls.  In this example, app is requesting memory of size 256MB that
 * is backed by huge pages.  Application uses the flag SHM_HUGETLB in shmget
 * system call to informt the kernel that it is requesting hugepages.  For
 * IA-64 architecture, Linux kernel reserves Region number 4 for hugepages.
 * That means the addresses starting with 0x800000....will need to be
 * specified.
 */
#include <sys/types.h>
#include <sys/shm.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <errno.h>

extern int errno;
#define SHM_HUGETLB 04000
#define LPAGE_SIZE      (4UL*1024UL*1024UL)
#define         dprintf(x)  printf(x)
#define ADDR (0x8000000000000000UL)
main()
{
        int shmid;
        int     i, j, k;
        volatile        char    *shmaddr;

	if ((shmid =shmget(IPC_PRIVATE, LPAGE_SIZE, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W )) < 0) {
                perror("Failure:");
                exit(1);
        }
        printf("shmid: 0x%x\n", shmid);
        shmaddr = shmat(shmid, (void *)ADDR, SHM_RND) ;
        if (errno != 0) {
                perror("Shared Memory Attach Failure:");
                exit(2);
        }
        printf("shmaddr: %p\n", shmaddr);

        dprintf("Starting the writes:\n");
        for (i=0;i<LPAGE_SIZE;i++) {
                shmaddr[i] = (char) (i);
                if (!(i%(1024*1024))) dprintf(".");
        }
        dprintf("\n");
        dprintf("Starting the Check...");
        for (i=0; i<LPAGE_SIZE;i++)
                if (shmaddr[i] != (char)i)
                        printf("\nIndex %d mismatched.");
        dprintf("Done.\n");
        if (shmdt((const void *)shmaddr) != 0) {
                perror("Detached Failure:");
                exit (3);
        }
}

--------------020808010403050202070801--

