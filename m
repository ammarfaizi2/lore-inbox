Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269621AbRHADig>; Tue, 31 Jul 2001 23:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269622AbRHADiS>; Tue, 31 Jul 2001 23:38:18 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:19663 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S269621AbRHADiP>; Tue, 31 Jul 2001 23:38:15 -0400
Message-Id: <5.1.0.14.2.20010731203011.03570770@pop.we.mediaone.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 31 Jul 2001 20:37:35 -0700
To: linux-kernel@vger.kernel.org
From: Eric Taylor <et@rocketship1.com>
Subject: "[PATCH] linux-2.4.7, <chg TASK_UNMAPPED_BASE to a variable>"
Cc: eric.a.tailor@jpl.nasa.gov
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On a stock 2.4.7 Intel kernel, with the 4gig memory option, the constant
TASK_UNMAPPED_BASE is computed to be 0x4000_0000 or 1 gig. This is
the starting address where the dynamic (.so) libraries get loaded.
The patch provides a dynamic method of changing this, with the
default value set in the same way as before this patch. This allows
some users to move the .so libraries while having no
effect on others who don't do not change this parameter. This permits w/o relinking,
the ability of some programs that provide their own memory management to
grow to almost the max of 3 gigs virtual space available to a singe process.
It supports rw access to the file /proc/sys/vm/task_unmapped_base.


To use this patch:

(assuming you copy the below into "/usr/src/patch.diff" and you are cd'd to /usr/src
and your system kernel sources are in /usr/src/linux-2.4.7)

$patch -p1 -d linux-2.4.7  <patch.diff

regards,
eric
et@rocketship1.com
please cc me on any reply



Motivation:
#==========



Let's look at the init process mapping:


[5407]$ cat /proc/1/maps
08048000-0804e000 r-xp 00000000 16:05 55302      /sbin/init
0804e000-08050000 rw-p 00005000 16:05 55302      /sbin/init
08050000-08054000 rwxp 00000000 00:00 0
(region 1)
40000000-40015000 r-xp 00000000 16:05 41390      /lib/ld-2.2.2.so
40015000-40016000 rw-p 00014000 16:05 41390      /lib/ld-2.2.2.so
40016000-40017000 rw-p 00000000 00:00 0
40020000-40141000 r-xp 00000000 16:05 41395      /lib/libc-2.2.2.so
40141000-40146000 rw-p 00120000 16:05 41395      /lib/libc-2.2.2.so
40146000-4014a000 rw-p 00000000 00:00 0
(region 2)
bfffe000-c0000000 rwxp fffff000 00:00 0


This shows that there are two discontiguous regions of virtual memory
that a process can allocate. Region 1 is the less than 1 gig space above the code, up
to the start of the libraries. Region 2 is the space after the libraries
that extend up to the low point of the stack, for at most 2 gigs. This allows
the stack to grow downward, while the heap (in this region) can grow upwards.


While malloc appears to understand how to use both these regions, (i.e. when
it runs out of one, it will start using the other) it cannot allocate
more than 2 gigs contigously. Also, code that uses sbrk, would normally allocate
memory only in the first region. Note: on intel, malloc (apparently) uses signed numbers
and cannot allocate more than 2 gigs (at once) in any case (I have been told that this
has changed in a  recent version of libc but have not verified this).


The starting address of the libraries is computed at kernel compile time
resulting in a constant TASK_UNMAPPED_BASE which is usually 1/3 of the
remaining 3 gig user virtual address space (out of a max of 4 gigs for 32
bit architecture).

As we reach the limits of 32 bit systems, there will be some need to have
the libraries load at a different location than the default. For example,
I have a program that uses sbrk exclusively, and cannot grow more than
about 850 meg, because the libraries are in the way. However, this program
uses very little stack. By moving the load point of the libraries up to a about 2.7
gig, I can have programs on the system use sbrk to allocate contiguous
memory of nearly 2.6 gigs. 

The downside of this patch is that it affects all programs that are subsequently
run. The stack then becomes limited to about .3 gig, but I have not found that
any programs in common use require this much stack.

I have not tried loading the libraries at a lower address, but I would think that
would work as well, so that the region 2 could be made larger.

Originally, I would patch the one "use" of TASK_UNMAPPED_BASE, and build
a new kernel. With the kind help of Philip Armstrong, who created a patch
to change this constant to a tunable vm parameter, I am requesting that
this change be incorporated into Linux.


Since this patch transforms a heretofore constant into a variable with
an initial value computed identically as before, if one does nothing, then
it should have no effect on the operation of linux. 

There are caveats: 

As mentioned, the change is system wide and if done while
a process that is already running decides to
do another mapping while running, this change could affect that
process, causing VA fragmentation or even possibly to make it fail. 

Indeed, there are better approaches to this procedure. I view this patch as a
short term solution to a problem that should eventually be solved differently. Each
process should have a way to specify the starting location of the libraries.
Perhaps, it should be a parameter to exec or an environment variable. It should
have range checking and possibly alignment properties. Another possibility would
be to have this property be part of the link, so that each executable program
could determine for itself what the best layout would be. 

And when and if any of the above are implemented, there will still need to be a 
default, and it could still be this variable.

Another approach, suggested in a thread I initiated on this subject was:
to make TASK_UNMAPPED_BASE a variable inherited on a per process basis and
settable by setrlimit(). 

Here are some comments from Phil (who created the patch for me):

>>>
Note also that this is not a production level patch; it doesn't play
nice with the non-x86 linux architectures for a start (SPARC at least
plays its own games with TASK_UNMAPPED_BASE).

Also, writing silly values to this field might cause your system to
cease being able to spawn processes (I haven't looked closely enough
at the implementation of mmap to see what happens if you start
searching at the end of memory!). You have been warned etc etc.
<<<

I think it is clear that nobody should be modifying
kernel parameters unless they know what they are doing. This patch
is intended for a small audience who will be willing to accept
the risk.

However, on the plus side is that this patch will allow those who need to
squeeze the most out of soon to be obsolete 32 bit architecture at very
low risk. If it ain't broke for you, then don't touch it. 


Specifics of the patch:
#======================

The patch adds a vm tunning file to the /proc/sys/vm directory. For example,
to start loading libaries at 0x5000_0000 instead of 0x4000_0000 one would
do this:

$ echo 0x50000000 >/proc/sys/vm/task_unmapped_base

To read out the value, in hex:

$ cat /proc/sys/vm/task_unmapped_base | awk '{printf "%08x\n", $1}'
50000000

checking proc 914 which I just started in another window:

$ cat /proc/914/maps
08048000-0804a000 r-xp 00000000 16:05 344547     /rh5/code/test/fr/fr
0804a000-0804b000 rw-p 00001000 16:05 344547     /rh5/code/test/fr/fr
0804b000-08240000 rwxp 00000000 00:00 0
50000000-50015000 r-xp 00000000 16:05 41390      /lib/ld-2.2.2.so
50015000-50016000 rw-p 00014000 16:05 41390      /lib/ld-2.2.2.so
50016000-50018000 rw-p 00000000 00:00 0
50020000-50141000 r-xp 00000000 16:05 41395      /lib/libc-2.2.2.so
50141000-50146000 rw-p 00120000 16:05 41395      /lib/libc-2.2.2.so
50146000-54d96000 rw-p 00000000 00:00 0
bfffe000-c0000000 rwxp fffff000 00:00 0



The Patch:
#======================


diff -urN linux-2.4.7.orig/include/asm-i386/processor.h linux-2.4.7-mine/include/asm-i386/processor.h
--- linux-2.4.7.orig/include/asm-i386/processor.h	Fri Jul 20 12:52:18 2001
+++ linux-2.4.7-mine/include/asm-i386/processor.h	Sat Jul 28 10:37:37 2001
@@ -268,7 +268,7 @@
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	(TASK_SIZE / 3)
+#define TASK_UNMAPPED_BASE     sysctl_task_unmapped_base
 
 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
diff -urN linux-2.4.7.orig/include/linux/sysctl.h linux-2.4.7-mine/include/linux/sysctl.h
--- linux-2.4.7.orig/include/linux/sysctl.h	Fri Jul 20 12:52:18 2001
+++ linux-2.4.7-mine/include/linux/sysctl.h	Sat Jul 28 10:37:31 2001
@@ -134,7 +134,8 @@
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
 	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
-	VM_PAGE_CLUSTER=10	/* int: set number of pages to swap together */
+       VM_PAGE_CLUSTER=10,     /* int: set number of pages to swap together */
+       VM_TASK_UNMAPPED_BASE=11 /* unsigned long: where to start looking for space to mmap */
 };
 
 
diff -urN linux-2.4.7.orig/kernel/sysctl.c linux-2.4.7-mine/kernel/sysctl.c
--- linux-2.4.7.orig/kernel/sysctl.c	Thu Apr 12 12:20:31 2001
+++ linux-2.4.7-mine/kernel/sysctl.c	Sat Jul 28 10:37:28 2001
@@ -44,6 +44,7 @@
 extern int C_A_D;
 extern int bdf_prm[], bdflush_min[], bdflush_max[];
 extern int sysctl_overcommit_memory;
+extern unsigned long sysctl_task_unmapped_base;
 extern int max_threads;
 extern int nr_queued_signals, max_queued_signals;
 extern int sysrq_enabled;
@@ -270,6 +271,8 @@
 	&pgt_cache_water, 2*sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
 	&page_cluster, sizeof(int), 0644, NULL, &proc_dointvec},
+       {VM_TASK_UNMAPPED_BASE, "task_unmapped_base", &sysctl_task_unmapped_base,
+        sizeof(sysctl_task_unmapped_base), 0644, NULL, &proc_dointvec},
 	{0}
 };
 
diff -urN linux-2.4.7.orig/mm/mmap.c linux-2.4.7-mine/mm/mmap.c
--- linux-2.4.7.orig/mm/mmap.c	Tue Jul  3 12:14:15 2001
+++ linux-2.4.7-mine/mm/mmap.c	Sat Jul 28 10:37:30 2001
@@ -398,6 +398,9 @@
  *
  * This function "knows" that -ENOMEM has the bits set.
  */
+
+unsigned long sysctl_task_unmapped_base = (TASK_SIZE / 3);
+
 #ifndef HAVE_ARCH_UNMAPPED_AREA
 static inline unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {






