Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318447AbSHENJx>; Mon, 5 Aug 2002 09:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318455AbSHENJx>; Mon, 5 Aug 2002 09:09:53 -0400
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:64687
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S318447AbSHENJv>; Mon, 5 Aug 2002 09:09:51 -0400
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: root@chaos.analogic.com
cc: linux-kernel@vger.kernel.org
Message-ID: <80256C0C.003A0ED2.00@notesmta.eur.3com.com>
Date: Mon, 5 Aug 2002 11:29:02 +0100
Subject: Re: ioremap_nocache(0xfffe0000, 0x00020000);
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I used the program below to get a copy of Bios rom on a National Geode / CS5530
board. If I remember correctly this code depended on the chipset decoding the
rom at this specific address range, the 'standard' address  range was
0xC0000..0xFFFFF but not all the Rom was available here. If you wanted to write
to the rom then it needed some other chipset bits set correctly as well.

You could also take a look at the
linux-2.4.19/drivers/mtd/maps/{netsc520.c,sc520cdp.c}.

You could probably acomplish the same with the right 'dd if=/dev/mem of=bios.rom
...'

     Jon Burgess

/* dumprom.c
 *
 * Dump BIOS Rom space to a file
 */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <ctype.h>

// To read the full 4Mbit ROM it needs to be accessed at the 'high' address
range
// Only 128Kb is available at 'low' address of 0xc0000
#define START  0xfff80000
#define LENGTH 0x00080000

int main(int argc, char *argv[])
{
     void *pmem;
     int fd, fd2;

     if (argc != 2)
     {
          printf("%s: <filename>\n", argv[0]);
          printf("Writes the BIOS memory space out to the file specifed\n");
          exit(1);
     }

     fd2 = open(argv[1], O_WRONLY | O_CREAT);
     if (!fd2)
          {
         perror("Error creating file");
         exit(1);
          }

     /* Get access BIOS memory space */
     fd = open("/dev/mem", O_RDONLY);
     if(!fd)
       {
         perror("Error opening /dev/mem");
               close(fd2);
         exit(1);
       }

     pmem = mmap(0, LENGTH, PROT_READ, MAP_SHARED, fd, START);
     if (pmem == MAP_FAILED)
       {
         perror("Error mapping /dev/mem");
               close(fd2);
               close(fd);
         exit(1);
       }

     if (write(fd2, pmem, LENGTH) == -1)
          {
               perror("Error writing data");
               close(fd2);
               close(fd);
               exit(2);
          }

     munmap(pmem, LENGTH);

     close(fd);
     close(fd2);

     exit(0);
}


