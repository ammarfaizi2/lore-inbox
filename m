Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317376AbSGITKn>; Tue, 9 Jul 2002 15:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317378AbSGITKm>; Tue, 9 Jul 2002 15:10:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10373 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317376AbSGITKl>; Tue, 9 Jul 2002 15:10:41 -0400
Date: Tue, 9 Jul 2002 15:13:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
In-Reply-To: <E17S0OD-0005UY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1020709150615.14559A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002, Alan Cox wrote:

> > Really? Then what is the meaning of fsync() on a read-only file-
> > descriptor? You can't update the information you can't change.
> 
> fsync ensures the data for that inode/file content is on stable storage - note
> _the_ _data_ not only random things written by this specific file handle.
> 

That is what it's supposed to do with files. The attached code clearly
shows that it doesn't work with directories. The fsync() instantly
returns, even though there is buffered data still to be written.


#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#define NR_WRITES 0x1000
int main()
{
    char foo[0x10000];

    int dirfd, outfd;
    int flags, i;
    outfd = open("/foo", O_WRONLY|O_TRUNC|O_CREAT, 0644);


    dirfd = open("/", O_RDONLY, 0);
    flags = fcntl(dirfd, F_GETFL);
    flags &= ~O_RDONLY;
    flags |= O_RDWR;
    fcntl(dirfd, F_SETFL, flags);
    fprintf(stderr, "Write %d bytes\n", sizeof(foo) * NR_WRITES);
    for(i=0; i< NR_WRITES; i++)
        write(outfd, foo, sizeof(foo));
    fprintf(stderr, "Write complete\n");
    fprintf(stderr, "Sync the directory\n");
    fsync(dirfd);
    fprintf(stderr, "Done, returns immediately!\n");
    close(outfd);
    fprintf(stderr, "Now execute sync and see if your disk is active!\n");
//    unlink("/foo");
}


Again, to assure that file-data is written to storage, one must
execute fsync on files, not directories. The dummy return of 0,
that Linux provides is a database bug waiting to happen.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

