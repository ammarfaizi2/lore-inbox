Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131067AbQK0OV4>; Mon, 27 Nov 2000 09:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131120AbQK0OVq>; Mon, 27 Nov 2000 09:21:46 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25475 "EHLO
        chaos.analogic.com") by vger.kernel.org with ESMTP
        id <S131067AbQK0OVh>; Mon, 27 Nov 2000 09:21:37 -0500
Date: Mon, 27 Nov 2000 08:51:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Anders Torger <torger@ludd.luth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to transfer memory from PCI memory directly to user space safely and portable?
In-Reply-To: <00112614213105.05228@paganini>
Message-ID: <Pine.LNX.3.95.1001127082148.20557A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000, Anders Torger wrote:

> 
> I'm writing a sound card driver where I need to transfer memory from the card 
> to user space using the CPU. Ideally I'd like to do that without needing to 
> have an intermediate buffer in kernel memory. I have implemented the copy 
> functions like this:
> 
> >From user space to the sound card:
> 
> 	if (verify_area(VERIFY_READ, user_space_src, count) != 0) {
> 	    return -EFAULT;
> 	}
> 	memcpy_toio(iobase, user_space_src, count);
> 	return 0;
> 
> >From the sound card to user space:
> 
> 	if (verify_area(VERIFY_WRITE, user_space_dst, count) != 0) {
> 	    return -EFAULT;
> 	}
> 	memcpy_fromio(user_space_dst, iobase, count);
> 	return 0;
> 

This contains a known bug. The user's buffer may be paged out even
though it is called by the current process. 

> 
> These functions are called on the behalf of the user, so the current process 
> should be the correct one. The iobase is ioremapped: 
> 
> 	iobase = ioremap(sound_card_port, sound_card_io_size);

ioremap() does not return a pointer. Although this may seem to work
for some addresses (below 1 megabyte), this is also a bug.

> 
> Now, this code works, I have a working driver. However, some questions have 
> been raised about the code, namely the following:
> 
> 1. What happens if the user space memory is swapped to disk? Will 
> verify_area() make sure that the memory is in physical RAM when it returns, 
> or will it return -EFAULT, or will something even worse happen?
> 

verify_area() is not used for this and, in fact, it is obsolete in new
kernels. You need to use copy_to/from_user(). This has the capability
of generating the proper page-fault machanism.

> 2. Is this code really portable? I currently have an I386 architecture, and I 
> could use copy_to/from_user on that instead, but that is not portable. Now, 
> by using memcpy_to/fromio instead, is this code fully portable?
> 

Portable? If you use the necessary kernel functions, then your
driver can run on various Linux architectures. However I don't
think you can call this "portable".


> 3. Will the current process always be the correct one? The copy functions is 
> directly initiated by the user, and not through an interrupt, so I think the 
> user space mapping will always be to the correct process. Is that correct?
> 

If your user calls open(), close(), read(), write(), ioctl(), etc., in
your driver, 'current' will be correct. However, this does not mean that
any of your data space is present in memory.


A guaranteed procedure to get data from your device to a user involves
a temporary buffer.


 	iobase = ioremap(sound_card_port, sound_card_io_size);
 	memcpy_fromio(kmalloced_buffer, iobase, count);
        copy_to_user(user_space_dst, kmalloced_buffer, count);


This involves an extra copy. You can get rid of the extra copy by
doing the following:

(1)	Using an ioctl() from user-space, return the physical address of
	'iobase' there is a macro for this.

(2)	From user-space, mmap(), MAP_FIXED this address space.

Here is a test program that does that (shows how mmap works):


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <signal.h>
#include <fcntl.h>
#include <termios.h>
#include <sys/types.h>
#include <sys/mman.h>

#define NoDEBUG

#if !defined(PAGE_SIZE)
#define PAGE_SIZE 0x1000
#endif
#if !defined(PAGE_MASK)
#define PAGE_MASK ~(PAGE_SIZE - 1)
#endif
#if !defined(MAP_FAILED)
#define MAP_FAILED (void *) -1
#endif
#define UL unsigned long

#define ERRORS \
    { fprintf(stderr, errmsg, __LINE__,\
      __FILE__, errno, strerror(errno));\
      exit(EXIT_FAILURE); }

#ifdef DEBUG
#define DEB(f) (f)
#else
#define DEB(f)
#endif

static const char errmsg[]="Error at line %d, file %s (%d) [%s]\n";
static const char mapfile[]="/dev/mem";
#define PROT (PROT_READ|PROT_WRITE)
#define FLAGS (MAP_FIXED|MAP_SHARED)
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
/*
 *  This writes a 'debug-like' dump out the screen. It always writes
 *  16 lines of 16 characters. It returns the last address displayed.
 */
static off_t dump(off_t addr);

static off_t dump(off_t addr)
{
    size_t i, j;
    int fd;
    caddr_t mem;
    off_t next;
    unsigned char c, *buf;

    next = addr; 
    addr &= PAGE_MASK;
    if((fd = open(mapfile, O_RDWR)) < 0)
        ERRORS;

    if((mem = mmap((caddr_t)addr, PAGE_SIZE * 2, PROT, FLAGS, fd, addr)) == MAP_FAILED)
    {
        (void)close(fd);
        fprintf(stderr, "\tCan't map address %08lX\n", (UL) addr);
        return (off_t)mem;
    } 
    buf = (unsigned char *) next;
    DEB(fprintf(stderr, "Mapped address = 0x%lx\n", addr));
    DEB(fprintf(stderr, "Buffer address = %p\n", buf));

    for(i=0; i< 0x10; i++)
    {
        fprintf(stdout, "\n%08lX ", (UL) next);
        next += 0x10;
        for(j=0; j< 0x10; j++)
            fprintf(stdout, "%02X ", (unsigned int) *buf++);
        buf -= 0x10;
        for(j=0; j<0x10; j++)
        {
            c = *buf++;
            if((c < (unsigned char) ' ') || (c > (unsigned char) 'z'))
                c = (unsigned char) '.';
            fprintf(stdout, "%c", c);
        }
    }
    fprintf(stdout, "\n");
    (void)fflush(stdout);
    (void)close(fd);
    if(munmap(mem, PAGE_SIZE)< 0)
        ERRORS;
    return next;
}

void usage(char *cp)
{
        fprintf(stderr, "Usage\n%s <start address> [end address]\n", cp);
        exit(EXIT_FAILURE);
}

int main(int args, char *argv[])
{
    off_t addr;
    off_t end;

    if(args < 2)
        usage(argv[0]);
    end = 0;
    if(sscanf(argv[1], "%lx", &addr) != 1)
        usage(argv[0]);
    if(argv[2] != NULL)
        (void)sscanf(argv[2], "%lx", &end);
    do {    
        if((addr = dump(addr)) == 0xffffffff)
            break;
        } while (end > addr);
    return 0;
}

-----------





Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
