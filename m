Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUAXJ0k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 04:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUAXJ0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 04:26:40 -0500
Received: from plim.fujitsu-siemens.com ([217.115.66.8]:51257 "EHLO
	plim.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S266895AbUAXJ0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 04:26:38 -0500
Date: Sat, 24 Jan 2004 10:27:30 +0100
From: Josef =?ISO-8859-1?Q?=20M=F6llers?= 
	<josef.moellers@fujitsu-siemens.com>
Message-Id: <200401240927.i0O9RUQ11749@bounty.psw.pdb.fsc.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel hang under extremely high load
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We're having problems with a SuSE Linux Enterprise Server 7 2.4.18-275
kernel under very high load (A SAP system using an Oracle database and
Networker backup).
This happens on several systems!

Shortly (some 1.5 hours) after the backup is started (usually at 10pm),
kinoded went into 100% system mode, makeing the system unavailable to
users.
I thought I had found a bug in fs/buffer.c, size_buffers_type[] being 32
bits and counting bytes (the system has 8GB of main memory). I discussed
this with Andrea Arcangeli and he said that it was unlikely that this
counter overflowed, but offered a patch, nonethless (it changed the
counting from bytes to 512 byte chunks).
I have installed this patch on one of the systems and it now looks
slightly more stable. I also added two lines to check wither the count
has bit 23 set (which would indicate an overflow in the non-patched
case), but, so far, this hasn't happened.

The system is now more stable, but yesterday it killed a few Oracle and
SAP processes due to kernel oopses. As the system was still usable, I
was able to trace one of the oopses to the following:

The "page" pointer in __block_write_full_page pointed at the following
data

        c54b37f0: c630b310 c34d0490 cbde3e74 0001a018
        c54b3800: c6fbcc70 00000004 0200884d c4fbc37c
        c54b3810: c37bab7c c3a6a5c0 d32782a0 00000000

which does resemble a valid struct page (kernel virtual addresses where
they should be, more numeric looking values where indexes or counts are,
reasonably looking "flags").
The value at offset 0x28 (d32782a0) is supposed to be
        struct buffer_head * buffers;
It points to the following data

        d32782a0: 34323534 0287b08b 20012001 012c3a0c
        d32782b0: 3030030c 4c500431 300c4e51 304e3130
        d32782c0: 34313030 0a323738 37313030

which does not really resemble anything like a struct buffer_head.
The oops happened when the kernel tried to use 0x37313030 as

        struct buffer_head *b_this_page;

One other of the Oopses which killed processes had
        d3278240
in one of his registers (unfortunately they had to reboot the system
before I had a chance to analyze the other oopses).

My currenty assumption is that the system is extremely tight on free and
available memory, the backup reading in masses of data from disk (a
CLARiiON box connected through a 2GB FC link) and writing it out to tape
(a tape library connected through a 1GB FC link). Now some kernel
component (presumably in the buffer cache or paging area) tries to
allocate memory, none is available, so it gets NULL but doesn't seem to
realize this, uses it and, as a consequence, mangles some pointers.

Over the last couple of weeks we have seen some 29 oopses on one
machine, all of which were in
        __block_write_full_page+108/432
        __block_write_full_page+92/432
        kmem_cache_alloc_batch+50/188
        kmem_cache_alloc_batch+99/188
        sync_page_buffers+20/184
        sync_page_buffers+36/184
this makes me think that it's a problem somewhere in mm.

Any ideas? I'm slowly running out of 'em (and time's running out on us).

