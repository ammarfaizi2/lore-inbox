Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292548AbSBTWbL>; Wed, 20 Feb 2002 17:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292547AbSBTWbD>; Wed, 20 Feb 2002 17:31:03 -0500
Received: from chaos.analogic.com ([204.178.40.224]:27012 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292542AbSBTWas>; Wed, 20 Feb 2002 17:30:48 -0500
Date: Wed, 20 Feb 2002 17:34:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jason Yan <jasonyanjk@yahoo.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Is there any story about the magic number 0x08048000 in  "ld" internal linker script ?
In-Reply-To: <20020220215605.KXU6407.tomts21-srv.bellnexxia.net@abc337>
Message-ID: <Pine.LNX.3.95.1020220171749.12923B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Jason Yan wrote:

> Hi,
> 
> When I use gdb to trace/debug my program, I notice that the programe
> linear address always start from 0x8048xxx, then I use "ld --verbose" 
> to display the internal linker script, I find an interesting address
> 0x08048000 :
> 
> SECTIONS
> {
>   /* Read-only sections, merged into text segment: */
>   . = 0x08048000 + SIZEOF_HEADERS
>   ......snip....
> 
> that's where 0x8048xxx comes from. I'm just curious, why 0x08048000 not
> other number? Any story?
> 
> Thanks,
> 
> Jason 
> 

That's how address space is layed out.

Script started on Wed Feb 20 17:16:34 2002

# cat >xxx.c
#include <stdio.h>
int foo = 1;
int bar;
extern char _start[];
extern char _end[];

const char x[]="hello";
int main()
{
   int i;
   printf("Program entry point at %p\n", _start);
   printf("Last data allocation at %p\n", _end);
   printf(".stack addresses at %p\n", &i);
   printf(".data addresses at %p\n", &foo);
   printf(".bss  addresses at %p\n", &bar);
   printf(".text addresses at %p\n", main);
   return 0;
}
# gcc -o xxx xxx.c
# ./xxx
Program entry point at 0x8048410
Last data allocation at 0x8049728
.stack addresses at 0xbffff6dc
.data addresses at 0x8049640
.bss  addresses at 0x8049724
.text addresses at 0x80484cc
# exit
exit

Script done on Wed Feb 20 17:16:53 2002

The kernel is mapped into the virtual address-space below about
0x08000000. User-mode code just can't access it directly, you
have to execute the proper trap. This is because, in Unix/Linux
the kernel performs functions on behalf of the user-mode code
in the context of the user. If the kernel used seperate address-
space, you would have to do inefficient paging to access the kernel.

So, every process sees the exact same available virtual address-
space and shares it with the kernel and memory-mapped runtime
libraries, etc. Using mmap(), you can uncover the protection of,
and access the address space wherein the kernel lives:


Script started on Wed Feb 20 17:28:50 2002
# cat dump.c


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

#define xxDEBUG

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
#define FAIL -1

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
#define PROT PROT_READ
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
    if((fd = open(mapfile, O_RDWR)) == FAIL)
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
    if(munmap(mem, PAGE_SIZE) == FAIL)
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
        if((addr = dump(addr)) == (off_t)0xffffffff)
            break;
        } while (end > addr);
    return 0;
}

# ./dump 0x10000000 0x10000010

10000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
10000010 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
10000020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
10000030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
10000040 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
10000050 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
10000060 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
10000070 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
10000080 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
10000090 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
100000A0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
100000B0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
100000C0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
100000D0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
100000E0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
100000F0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
# ./dump 0x01000000 0x0100010

01000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
01000010 10 00 00 C1 10 00 00 C1 00 00 00 00 00 00 00 00 ................
01000020 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00 00 ................
01000030 00 00 00 00 00 00 00 00 01 00 00 00 3C 00 00 C1 ............<...
01000040 3C 00 00 C1 00 00 00 00 00 00 00 00 00 00 00 C0 <...............
01000050 40 05 21 C0 54 00 00 C1 54 00 00 C1 00 00 00 00 @.!.T...T.......
01000060 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80 ................
01000070 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 ................
01000080 80 00 00 C1 80 00 00 C1 00 00 00 00 00 00 00 00 ................
01000090 00 10 00 C0 40 05 21 C0 98 00 00 C1 98 00 00 C1 ....@.!.........
010000A0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
010000B0 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00 ................
010000C0 01 00 00 00 C4 00 00 C1 C4 00 00 C1 00 00 00 00 ................
010000D0 00 00 00 00 00 20 00 C0 40 05 21 C0 DC 00 00 C1 ..... ..@.!.....
010000E0 DC 00 00 C1 00 00 00 00 00 00 00 00 00 00 00 00 ................
010000F0 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00 00 ................
# ./dump 0x00100000 0x00100010

00100000 FC B8 18 00 00 00 8E D8 8E C0 8E E0 8E E8 66 09 ..............f.
00100010 DB 74 17 83 3D 0C 13 25 00 00 74 26 0F 20 E0 0B .t..=..%..t&. ..
00100020 05 0C 13 25 00 0F 22 E0 EB 18 BF 00 20 10 00 B8 ...%.."..... ...
00100030 07 00 00 00 AB 05 00 10 00 00 81 FF 00 40 10 00 .............@..
00100040 75 F2 B8 00 10 10 00 0F 22 D8 0F 20 C0 0D 00 00 u.......".. ....
00100050 00 80 0F 22 C0 EB 00 B8 5E 00 10 C0 FF E0 0F B2 ..."....^.......
00100060 25 30 02 10 C0 66 09 DB 74 05 6A 00 9D EB 5C 31 %0...f..t.j...\1
00100070 C0 BF F0 A8 23 C0 B9 B0 3D 27 C0 29 F9 F3 AA E8 ....#...='.)....
00100080 76 01 00 00 6A 00 9D BF 00 40 10 C0 B9 00 02 00 v...j....@......
00100090 00 FC F3 A5 31 C0 B9 00 02 00 00 F3 AB 8B 35 28 ....1.........5(
001000A0 42 10 C0 21 F6 75 18 66 81 3D 20 00 09 00 3F A3 B..!.u.f.= ...?.
001000B0 75 19 0F B7 35 22 00 09 00 81 C6 00 00 09 00 BF u...5"..........
001000C0 00 48 10 C0 B9 00 02 00 00 F3 A5 C7 05 68 E2 20 .H...........h. 
001000D0 C0 FF FF FF FF C7 05 60 E2 20 C0 03 00 00 00 9C .......`. ......
001000E0 58 89 C1 35 00 00 04 00 50 9D 9C 58 31 C8 25 00 X..5....P..X1.%.
001000F0 00 04 00 74 79 C7 05 60 E2 20 C0 04 00 00 00 89 ...ty..`. ......
# exit
exit
Script done on Wed Feb 20 17:30:55 2002


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

