Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261920AbSIYGNg>; Wed, 25 Sep 2002 02:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261921AbSIYGNg>; Wed, 25 Sep 2002 02:13:36 -0400
Received: from elin.scali.no ([62.70.89.10]:273 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S261920AbSIYGNf>;
	Wed, 25 Sep 2002 02:13:35 -0400
Date: Wed, 25 Sep 2002 08:18:40 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@dpc-27.office.scali.no
To: Lingli Zhang <lingli_z@umail.ucsb.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: mmap() failed on Linux 2.4.18-10smp with 4GB RAM
In-Reply-To: <1032929970.3d9142b22bc55@webaccess.umail.ucsb.edu>
Message-ID: <Pine.LNX.4.44.0209250814230.1579-100000@dpc-27.office.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Lingli Zhang wrote:

> Hi there,
> 
> My machine is a 2-Processor Pentium 4 (Xeon) 2.4GHz e7500 Chipset with 4GB RAM.
> I installed Redhat (kernel: Linux 2.4.18-10bigmem) on it. 
> 
> But when I run following piece of code:
> ========================================
> #include <unistd.h>
> #include <sys/mman.h>
> int main(){
>    mmap ((void *) 1090519040, 17000000,
>          PROT_READ | PROT_WRITE | PROT_EXEC,
>          MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> }
> ===========================================
> It gives out "segmentation fault". It works well if I change 17000000
> to 16000000.
> 
> I have tried Linux 2.4.18-10smp kernel, same problem.
> 
> Is there anyone have any idea what's going on here? Or do you have any
> recommendation that which version of Linux I should use for my machine to work
> around this problem?
> 

Well, the problem is that you are forcing the mmap to create a virtual map 
starting at 0x41000000 and with 17000000 bytes that map is ending at 
0x42036640, which is right in the middle of where glibc gets mapped :

# cat /proc/2441/maps
08048000-08049000 r-xp 00000000 00:0c 163922     /home/sp/a.out
08049000-0804a000 rw-p 00000000 00:0c 163922     /home/sp/a.out
40000000-40013000 r-xp 00000000 08:02 416894     /lib/ld-2.2.5.so
40013000-40014000 rw-p 00013000 08:02 416894     /lib/ld-2.2.5.so
40014000-40015000 rw-p 00000000 00:00 0
40022000-40023000 rw-p 00000000 00:00 0
42000000-4212c000 r-xp 00000000 08:02 448959     /lib/i686/libc-2.2.5.so
4212c000-42131000 rw-p 0012c000 08:02 448959     /lib/i686/libc-2.2.5.so
42131000-42135000 rw-p 00000000 00:00 0
bfffe000-c0000000 rwxp fffff000 00:00 0

If you absolutely want to use this fixed address for your mmap, link your 
application statically, or maybe there's a way to tell the dynamic linker 
to put the libraries elsewhere ?

Regards,
 -- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

