Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136367AbREDM5V>; Fri, 4 May 2001 08:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136370AbREDM5M>; Fri, 4 May 2001 08:57:12 -0400
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:35850 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S136367AbREDM46>; Fri, 4 May 2001 08:56:58 -0400
Message-ID: <3AF2A732.5D4BF81F@beam.demon.co.uk>
Date: Fri, 04 May 2001 13:57:22 +0100
From: Terry Barnaby <terry@beam.demon.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question on mmap(2) with kernel alocated memory
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to mmap() into user space a kernel buffer  and am having
problems.
I have a simple test example, can someone please tell me what I have got
wrong ?

In a driver I do:
    uint*    kva;

    kva = (uint*)kmalloc(4096, GFP_KERNEL);
    *kva = 0x11223344;
    printk("Address: %p %lx %x\n", kva, virt_to_phys(kva), *kva);

Now in some simple user program I do:

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <fcntl.h>

int main(int argc, char** argv){
 int fm;
 char* p;
 uint* pi;
 uint v;
 uint add = 0x74b000;

 if((fm = open("/dev/mem", O_RDWR)) < 0)
  return 1;

 p = mmap(0, 128 * 1024 * 1024, PROT_READ|PROT_WRITE, MAP_SHARED, fm,
0);
 printf("Mapped: %p\n", p);

 lseek(fm, add, SEEK_SET);
 read(fm, &v, sizeof(v));
 printf("V: %x\n", v);

 pi = (uint*)(p + add);
 printf("Vmmap: %p %x\n", pi, *pi);

 close(fm);
 return 0;
}

The value of add is hardcoded to the value printed for the physical
address in the drivers prink routine.
The lseek/read from the /dev/mem device yields the value 0x11223344.
However the mmap method also on /dev/mem yields the value 0.

Whats wrong with my mmap() or kalloc() ?

Terry

--
  Dr Terry Barnaby                     BEAM Ltd
  Phone: +44 1454 324512               Northavon Business Center, Dean Rd
  Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
  Email: terry@beam.demon.co.uk        Web: www.beam.demon.co.uk
  BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software Dev
                         "Tandems are twice the fun !"



