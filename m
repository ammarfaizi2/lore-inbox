Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317426AbSGIThG>; Tue, 9 Jul 2002 15:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSGIThF>; Tue, 9 Jul 2002 15:37:05 -0400
Received: from gordo.y12.doe.gov ([134.167.141.46]:10448 "EHLO
	gordo.y12.doe.gov") by vger.kernel.org with ESMTP
	id <S317426AbSGIThD>; Tue, 9 Jul 2002 15:37:03 -0400
Message-ID: <3D2B3BEA.A89EAB88@y12.doe.gov>
Date: Tue, 09 Jul 2002 15:39:22 -0400
From: David Dillow <dillowd@y12.doe.gov>
Organization: BWXT Y-12/TC/UT Subcon/What a mess!
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine 
 fordirectories on NFS mounts
References: <Pine.LNX.3.95.1020709150615.14559A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Tue, 9 Jul 2002, Alan Cox wrote:
> 
> > > Really? Then what is the meaning of fsync() on a read-only file-
> > > descriptor? You can't update the information you can't change.
> >
> > fsync ensures the data for that inode/file content is on stable storage - note
> > _the_ _data_ not only random things written by this specific file handle.
> >

>     flags = fcntl(dirfd, F_GETFL);
>     flags &= ~O_RDONLY;
>     flags |= O_RDWR;
>     fcntl(dirfd, F_SETFL, flags);

Ehh? Not sure what you're doing here...

>     fprintf(stderr, "Write %d bytes\n", sizeof(foo) * NR_WRITES);
>     for(i=0; i< NR_WRITES; i++)
>         write(outfd, foo, sizeof(foo));
>     fprintf(stderr, "Write complete\n");
>     fprintf(stderr, "Sync the directory\n");
>     fsync(dirfd);
>     fprintf(stderr, "Done, returns immediately!\n");
>     close(outfd);
>     fprintf(stderr, "Now execute sync and see if your disk is active!\n");
> //    unlink("/foo");
> }
> 
> Again, to assure that file-data is written to storage, one must
> execute fsync on files, not directories. 

You are correct, but re-read what Alan said -- "fsync ensures the data
for that inode/file content is on stable storage". So your fsync(dirfd)
only makes sure data written to the directory is on disk, i.e. the name
of the new file "foo". sync still causes mucho activity because you did
not fsync the outfd. 

> The dummy return of 0,
> that Linux provides is a database bug waiting to happen.

No, the dummy return of 0 from NFS is not a problem, because directory
updates, and indeed all writes, are supposed to be syncronous by
default. There really is no need to fsync on an NFS directory, as the
name should already be on stable storage by the time open() returns.

At least this is my understanding,
D
