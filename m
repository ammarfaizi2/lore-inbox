Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbTE1UGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264859AbTE1UGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:06:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:51335 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264855AbTE1UGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:06:19 -0400
Date: Wed, 28 May 2003 16:22:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 bug: fifo-write causes diskwrites to read-only fs ! 
In-Reply-To: <200305281934.h4SJYHtX015646@verdi.et.tudelft.nl>
Message-ID: <Pine.LNX.4.53.0305281612160.13968@chaos>
References: <200305281934.h4SJYHtX015646@verdi.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Rob van Nieuwkerk wrote:

> > On Wed, 28 May 2003, Rob van Nieuwkerk wrote:
> >
> > >
> > > I wrote:
> > > > It turns out that Linux is updating inode timestamps of fifos (named
> > > > pipes) that are written to while residing on a read-only filesystem.
> > > > It is not only updating in-ram info, but it will issue *physical*
> > > > writes to the read-only fs on the disk !
> > > 	.
> > > 	.
> > > 	.
> > > > Sysinfo:
> > > > --------
> > > > - various 2.4 kernels including RH-2.4.20-13.9,
> > > >   but also straight 2.4(ac) ones.
> > > > - CompactFlash (= IDE disk)
> > > > - Geode GX1 CPU (i586 compatible)
> > >
> > > Forgot to mention: I use an ext2 fs, but maybe it's a generic,
> > > fs-independant problem.
> > >
> > > 	greetings,
> > > 	Rob van Nieuwkerk
> >
> > How does it 'know' it's a R/O file-system? Have you mounted it
> > R/O, mounted it noatime, or just taken whatever you get when
> > you boot from a ramdisk?
>
> Hi Richard,
>
> The kernel has the "ro" commandline-parameter.
> There is no remount after the system boots.
> "touch /bla" gives a read-only fs error.
>
> > FYI, I created a FIFO with mkfifo, remounted the file-system
> > R/O, executed `cat` with it's input coming from the FIFO, and
> > then waited for a few minutes. I then wrote to the FIFO.
> > The atime did not change with 2.4.20.
>
> Just did the same here (on my workstation).  And the times *did* change ..
> More precisely: the "modification" & "change" were updated, the "access"
> time remained unchanged.
>

Okay. I can now verify the problem. There are two problems as this
script will show:

Script started on Wed May 28 16:10:13 2003
# cat xxx.c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/fcntl.h>
#include <sys/stat.h>
#include <sys/wait.h>

int main(void);
static const char fifo[]="/alt/FIFO";
void reaper(int unused)
{
    while(wait3(&unused, WNOHANG, NULL) > 0)
        ;
}
int main()
{
    int fd;
    int i;
    char buf[0x1000];
    struct stat sb;

    (void)mkfifo(fifo, 0644);
    (void)signal(SIGCHLD, reaper);
    if((fd = open(fifo, O_RDWR)) < 0)
        exit(EXIT_FAILURE);
    switch(fork())
    {
    case 0:
        for(;;)
        {
            if(read(fd, buf, sizeof(buf)) < 0)
                exit(EXIT_FAILURE);
            if(*buf == (char) 0xa5) exit(EXIT_SUCCESS);
        }
        break;  /* Not reached */
    case -1:
        fprintf(stderr, "Can't fork()\n");
        exit(EXIT_FAILURE);
        break; /* Not reached */
    default:
        break; /* Now required */
    }
    memset(buf, 0x00, sizeof(buf));
    for(i=0; i< 0x10; i++)
    {
        (void)write(fd, buf, sizeof(buf));
        (void)fstat(fd, &sb);
        printf("atime = %08lx\n", sb.st_atime);
        printf("mtime = %08lx\n", sb.st_mtime);
        printf("ctime = %08lx\n", sb.st_ctime);
        sleep(1);
    }
    *buf = (char)0xa5;
    (void)write(fd, buf, 0x01);
    (void)close(fd);
//    (void)unlink(fifo);
    return 0;
}

# gcc -O2 -o xxx -Wall xxx.c
# ./xxx
atime = 3ed51750
mtime = 3ed517c5
ctime = 3ed517c5
atime = 3ed51750
mtime = 3ed517c6
ctime = 3ed517c6
atime = 3ed51750
mtime = 3ed517c7
ctime = 3ed517c7
atime = 3ed51750
mtime = 3ed517c8
ctime = 3ed517c8
atime = 3ed51750
mtime = 3ed517c9
ctime = 3ed517c9
atime = 3ed51750
mtime = 3ed517ca
ctime = 3ed517ca
atime = 3ed51750
mtime = 3ed517cb
ctime = 3ed517cb
atime = 3ed51750
mtime = 3ed517cc
ctime = 3ed517cc
atime = 3ed51750
mtime = 3ed517cd
ctime = 3ed517cd
atime = 3ed51750
mtime = 3ed517ce
ctime = 3ed517ce
atime = 3ed51750
mtime = 3ed517cf
ctime = 3ed517cf
atime = 3ed51750
mtime = 3ed517d0
ctime = 3ed517d0
atime = 3ed51750
mtime = 3ed517d1
ctime = 3ed517d1
atime = 3ed51750
mtime = 3ed517d2
ctime = 3ed517d2
atime = 3ed51750
mtime = 3ed517d3
ctime = 3ed517d3
atime = 3ed51750
mtime = 3ed517d4
ctime = 3ed517d4
# >/alt/foo
bash: /alt/foo: Read-only file system
# exit
exit
Script done on Wed May 28 16:11:12 2003

As you can clearly see, access time (atime) is not changed.
However, both ctime and mtime are both changed with every
FIFO access. Since this FIFO is provably on a R/O file system,
nothing should change.

Now, somebody will probably claim that this is the correct
POSIX defined behavior <sigh> so you might have to make some
work-around like use a pipe or socket instead of the FIFO??

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

