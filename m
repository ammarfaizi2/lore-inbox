Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265439AbRGGW12>; Sat, 7 Jul 2001 18:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265449AbRGGW1I>; Sat, 7 Jul 2001 18:27:08 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:33806 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S265439AbRGGW1G>; Sat, 7 Jul 2001 18:27:06 -0400
Date: Sat, 7 Jul 2001 15:27:04 -0700 (PDT)
From: Paul Buder <paulb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Large ramdisk crashes 2.4.6
Message-ID: <Pine.LNX.4.33.0107071525430.23709-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I mailed the list about similar problems with 2.4.5.  Since it's
still happening now that 2.4.6 is out I decided to send another
report.

The following will crash my 128 meg x86 running 2.4.6.
mke2fs /dev/ram0 80000
mount /dev/ram0 /mnt
dd if=/dev/zero of=/mnt/junk bs=1024000 count=60

I poked around with sysrq and noticed one thing that seems definitely
wrong.  The bdflush process is stuck in an infinite loop executing the
same eight functions over and over again.  The ksymoops looks like
this.

Trace; c0129e2d <__alloc_pages+109/278>
Trace; c0129d22 <_alloc_pages+16/18>
Trace; c0132dde <grow_buffers+3e/190>
Trace; c0130ff4 <refill_freelist+1c/50>
Trace; c0131000 <refill_freelist+28/50>

# Repeating starts here

Trace; c01314e4 <getblk+158/16c>
Trace; c017cff2 <rd_make_request+72/f4>
Trace; c01758fc <generic_make_request+110/11c>
Trace; c0175962 <submit_bh+5a/74>
Trace; c0175bbb <ll_rw_block+1fb/26c>
Trace; c013331a <flush_dirty_buffers+9e/e4>
Trace; c013338e <wakeup_bdflush+2e/34>
Trace; c013100e <refill_freelist+36/50>

# Round two

Trace; c01314e4 <getblk+158/16c>
Trace; c017cff2 <rd_make_request+72/f4>
Trace; c01758fc <generic_make_request+110/11c>
Trace; c0175962 <submit_bh+5a/74>
Trace; c0175bbb <ll_rw_block+1fb/26c>
Trace; c013331a <flush_dirty_buffers+9e/e4>
Trace; c013338e <wakeup_bdflush+2e/34>
Trace; c013100e <refill_freelist+36/50>

It has repeated the above eight functions about (roughly) 50 times
at the time the system is crashed.


I extracted the code from the kernel for those eight functions
and put them into a single file in the ksymoops reverse order,
also putting in easy to spot comments within each function for
where the next one is called.  The hope is this will make it
easier for someone to spot the problem.  It seems too long for this
email but it's at www.aracnet.com/~paulb/endlessloop.c.html.

I don't think the dd trace will turn out to be interesting, especially
since with some number combinations the dd process exits before
the system actually crashes but here is the full listing anyway.

Trace; c0129e2d <__alloc_pages+109/278>
Trace; c0129d22 <_alloc_pages+16/18>
Trace; c0124489 <generic_file_write+33d/534>
Trace; c012f5ba <sys_write+8e/c4>
Trace; c0106e63 <system_call+33/40>

Finally, the system would crash in a number of ways.  Sometimes it
will silently hang.  Other times it will give a message of one
sort or another.  These include

Unable to handle kernel null pointer dereference
Unable to handle kernel paging request
Aiee, killing interrupt handler



