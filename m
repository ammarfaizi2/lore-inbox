Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265714AbRGJT3h>; Tue, 10 Jul 2001 15:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbRGJT31>; Tue, 10 Jul 2001 15:29:27 -0400
Received: from [209.234.73.40] ([209.234.73.40]:61199 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S265714AbRGJT3W>;
	Tue, 10 Jul 2001 15:29:22 -0400
Date: Tue, 10 Jul 2001 14:28:13 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Andreas Dilger <adilger@turbolinux.com>,
        Johan Simon Seland <johans@netfonds.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Trying to free nonexistent swap-page" error message.
Message-ID: <20010710142813.O4148@altus.drgw.net>
In-Reply-To: <la8zibpur5.fsf@glass.netfonds.no> <200106290902.f5T924Qv014328@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106290902.f5T924Qv014328@webber.adilger.int>; from adilger@turbolinux.com on Fri, Jun 29, 2001 at 03:02:03AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2001 at 03:02:03AM -0600, Andreas Dilger wrote:
> Johan Seland
> > One one of our Linux Oracle servers the following messages has started
> > to appear : 
> > 
> > Jun 29 07:16:32 blanco kernel: swap_free: Trying to free nonexistent swap-page
> > Jun 29 07:16:32 blanco kernel: swap_free: Trying to free nonexistent swap-page
> > 
> > I also find some of these:
> > 
> > Jun 29 06:25:01 blanco kernel: EXT2-fs error (device sd(8,10)): ext2_readdir: bad entry in directory #172258: rec_len %% 4 != 0 - offset=192, inode=812610409, rec_len=11833, name_len=115
> > Jun 29 06:25:32 blanco kernel: EXT2-fs error (device sd(8,10)): ext2_readdir: bad entry in directory #172258: rec_len %% 4 != 0 - offset=192, inode=812610409, rec_len=11833, name_len=115
> > 
> > Machine is a 2x933MhZ P3 with 2GB of memory. Kernel version is now
> > 2.2.19, but the same problem appeared with 2.2.18 as well.
> 
> My first guess would be some sort of hardware/software problem with your
> SCSI controller, cables, disk, etc.  I'm not sure about the swap problem,
> but the ext2 problems are caused by corruption of the disk or memory.

My first guess would be hardware also, except in this case I've seen
similiar things on three different dual processor G4 systems running 2.2,
and they work fine with 2.4.

Does Oracle for Linux us pthreads or the 'clone()' system call?

Can you try running the included pthreads program on an 2.2.19 SMP system
(but make it's idle, since if this is a genric 2.2 SMP bug it will
probably crash the system)

Compile with the following command:
gcc -o pt pthread-test.c -lpthread 

Run it repeatedly:
I=0; while [ $? -eq 0 ] ; let I=I+1; do ./pt ; done ; echo $I

on 2.2.19 on a mac dual G4, the pthreads program will sometimes get 
segfaults and illegal instructions, and if I run it long enough, I will 
eventually get the following in dmesg:

swap_free: Trying to free nonexistent swap-page
swap_free: offset exceeds max
swap_free: Trying to free nonexistent swap-page
swap_free: Trying to free nonexistent swap-page
swap_free: offset exceeds max
swap_free: Trying to free nonexistent swap-page
swap_free: Trying to free nonexistent swap-page
swap_free: offset exceeds max
swap_free: offset exceeds max
swap_free: offset exceeds max
swap_free: Trying to free nonexistent swap-page
swap_free: Trying to free nonexistent swap-page
swap_free: Trying to free nonexistent swap-page
swap_free: Trying to free nonexistent swap-page
swap_free: offset exceeds max
swap_free: offset exceeds max
swap_free: offset exceeds max

If I keep running it, I will eventually wind up with a kernel panic on an 
illegal instruction. Something is corrupting memory, and in my case, the 
kernel panics are caused by a '0x00000008' being written over a random 
location in the kernel code.


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
 
#define NTH 8
 
void
thread(void *arg)
{
        printf("THREAD: pid %d\n", getpid());
 
        return;
}

int
main(int argc, char **argv)
{
        int i;
        pthread_t t[NTH];
 
        for (i=0; i<NTH; i++)
           pthread_create(t+i, NULL, thread, NULL);
 
        for (i=0; i<NTH; i++)
           pthread_join(t[i], NULL);
 
        return 0;
}



-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
