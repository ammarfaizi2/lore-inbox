Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUGZNBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUGZNBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 09:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUGZNBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 09:01:23 -0400
Received: from web13605.mail.yahoo.com ([216.136.175.116]:7948 "HELO
	web13605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265264AbUGZNBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 09:01:08 -0400
Message-ID: <20040726130106.63000.qmail@web13605.mail.yahoo.com>
Date: Mon, 26 Jul 2004 06:01:06 -0700 (PDT)
From: Kaloian Manassiev <kmanassieff@yahoo.com>
Subject: Re: mmap + mprotect + malloc strange behaviour
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nevermind, I found it :)

I just found out (by reading
/usr/src/linux-2.4.20-8/Documentation/sysctl/vm.txt)
that there is a limit on the number of mappings that a
process may have and that for some reason malloc
consumes mappings.

I just increased the limit by editing the file
/proc/sys/vm/max_map_count. This works okay for my
application...

Does someone know what repercussions this could have
on the "normal" operation of the system?

Cheers,
Kaloian.



--- Kaloian Manassiev <kmanassieff@yahoo.com> wrote:
> Hi all,
> 
> I am writing a tool which keeps track of the
> accessed
> memory pages and needs to persist the modified pages
> back to disk on exit. For the purpose, it mmaps a
> large file (512MB or 131072 pages), then protects
> all
> its pages for both reading and writing using
> mprotect(
> ptr, PAGE_SIZE, 0). I do this in order to be able to
> keep track of the accessed pages.
> 
> Throughout the code I also use malloc in order to
> allocate heap memory for some of the internal
> structures. The problem I have is that all mallocs
> that follow the mmapping and mprotect described
> above
> return NULL, no matter what the passed size is.
> 
> I noticed that this behaviour is caused by the
> mprotection of the pages one-by-one rather than as a
> whole chunk. E.g., if I mprotect my whole mmapped
> space with a single call everything works fine at
> the
> beginning. However, this is not very helpful,
> because
> in the process of execution, I eventually mprotect
> many separate pages, and malloc starts to fail
> again.
> 
> I checked my limits using the "ulimit" BASH command
> and it shows that I have no limits concerning
> memory-related issues.
> 
> ------------------
> core file size        (blocks, -c) 0
> data seg size         (kbytes, -d) unlimited
> file size             (blocks, -f) unlimited
> max locked memory     (kbytes, -l) unlimited
> max memory size       (kbytes, -m) unlimited
> open files                    (-n) 1024
> pipe size          (512 bytes, -p) 8
> stack size            (kbytes, -s) 10240
> cpu time             (seconds, -t) unlimited
> max user processes            (-u) 4092
> virtual memory        (kbytes, -v) unlimited
> -------------------
> 
> With my lack of knowledge about Linux VM management
> I
> can only suspect that is some way I am exceeding the
> process' virtual address space slots and it cannot
> bookkeep the additional malloc entries.
> 
> I am using Fedora Linux on a dual AMD Athlon MP
> 2600+
> processor machine with 512MB of physical memory and
> 1GB swap disk space. However, I observe the same
> effects on many other machines and distributions
> (for
> example, 4 Intel Xeon processor machine with 4GB RAM
> +
> 6GB swap running Red Hat Linux 9).
> 
> Has anyone had a similar problem, and does anyone
> know
> a remedy for it? At the bottom of this post I have
> pasted a sample program that exhibits this
> behaviour.
> 
> Any help will be much appreciated. Please, if
> possible, reply to (or CC) my personal email address
> in answers to this post.
> 
> Many thanks in advance.
> 
> Cheers,
> Kaloian.
> 
> 
> ----- Sample code (buildable)
> --------------------------
> 
> #include <stdio.h>
> #include <errno.h>
> #include <sys/mman.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <assert.h>
> 
> #define	PAGE_SIZE	4096
> #define NUM_PAGES	131072
> #define SIZE		PAGE_SIZE * NUM_PAGES
> #define MMAP_ADDR	((void *)0x10000000L)
> 
> int   array[ NUM_PAGES * 64];
> int * mem_load;
> 
> int main( int argc, char ** argv) {
>     char c;
>     int i;
>     int fd_mmap = open( "/tmp/swap.tmp", O_CREAT |
> O_RDWR, S_IRWXU);
> 
>     if ( fd_mmap) {
> 	lseek( fd_mmap, SIZE - 1, SEEK_SET);
> 	write( fd_mmap, &c, 1);
>     }
> 
>     printf( "Allocating %d bytes of memory...\n",
> SIZE);
>     mem_load = malloc( SIZE);
>     printf( "mem_load = %p\n", mem_load);
>     array[ NUM_PAGES * 64 - 1] = 10000;
>     
>     if ( NULL == mem_load)
> 	printf( "Failed...\n");
> 
>     void * p = mmap( MMAP_ADDR, SIZE, PROT_READ |
> PROT_WRITE,
> MAP_FIXED | MAP_SHARED, fd_mmap, PAGE_SIZE);
>     printf( "File %d mapped at %p.\n", fd_mmap, p);
>     if ( !p) {
> 	exit( 1);	
>     }
>     void * alias = mmap( MMAP_ADDR + 2 * SIZE, SIZE,
> PROT_READ |
> PROT_WRITE, MAP_SHARED, fd_mmap, PAGE_SIZE);
>     if ( !alias) {
> 	exit( 2);
>     }
>     void * pg = p;
>     for ( i = 0; i < NUM_PAGES; i++) {
> 	if ( 0 > mprotect( pg, PAGE_SIZE, 0)) {
> 	    printf( "Failed to mprotect.\n");
> 	    exit( 4);
> 	}
> 	pg += PAGE_SIZE;
>     }
> 
>     /* If you substitute the above with the call
> below,
>        malloc suddenly starts to work. */
>     // mprotect( pg, SIZE, 0);
> 
>     printf( "Alias mapped at %p.\n", alias);
> 
>     assert( mem_load > p + SIZE || ( (mem_load < p +
> SIZE) && ((
> mem_load + SIZE) < alias)));
> 
>     free( mem_load);
>     mem_load = malloc( SIZE);
>     printf( "mem_load = %p\n", mem_load);
> 
>     return 0;
> }


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
