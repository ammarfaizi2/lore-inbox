Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUDOAAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 20:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUDOAAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 20:00:13 -0400
Received: from smtp-out3.xs4all.nl ([194.109.24.13]:45841 "EHLO
	smtp-out3.xs4all.nl") by vger.kernel.org with ESMTP id S261897AbUDOAAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 20:00:00 -0400
Subject: Re: reiser4 and megaraid problems with debian 2.6.5
From: Paul Wagland <paul@kungfoocoder.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: reiserfs-list@Namesys.COM,
       Linux SCSI mailing list <linux-scsi@vger.kernel.org>,
       Atul Mukker <atulm@lsil.com>, Domenico Andreoli <cavok@libero.it>,
       Hans Reiser <reiser@Namesys.COM>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <295743F0-8E17-11D8-A41D-000A95CD704C@wagland.net>
References: <36927C82-8DE0-11D8-A41D-000A95CD704C@wagland.net>
	 <20040414090547.GB13578@raptus.homelinux.org>
	 <6699459A-8E10-11D8-A41D-000A95CD704C@wagland.net>
	 <16509.14375.539110.986025@laputa.namesys.com>
	 <295743F0-8E17-11D8-A41D-000A95CD704C@wagland.net>
Content-Type: text/plain
Organization: Kung Foo Coders!
Message-Id: <1081987184.11193.87.camel@morsel.kungfoocoder.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 01:59:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-14 at 15:25, Paul Wagland wrote:
> On Apr 14, 2004, at 15:09, Nikita Danilov wrote:
> 
> >>> Paul Wagland writes:
> >>>> If I can help debug this situation (I am probably the only person
> >>>> trying this combination :-) please let me know how I should go about
> >>>> it.
> >
> > Is there anything in the logs?
> 
> Sadly I forgot to check... though I will check again tonight since the 
> problem is quite reproducible for me. Will report back later...

OK. There is nothing in the logs. I have recompiled the kernel with
extra REISER4 debugging and checking and still nothing.

This error is 100% reproducible for me.

I have had a thought, what if it is "only" the wrong error code that is
being returned? What if the real problem is that we are running out of
free blocks. To test this theory (a little at least) I ran:

# bonnie++ -q -x4 -d /mnt/sdq -u 0:0 -f -r500
name,file_size,putc,putc_cpu,put_block,put_block_cpu,rewrite,rewrite_cpu,getc,getc_cpu,get_block,get_block_cpu,seeks,seeks_cpu,num_files,seq_create,seq_create_cpu,seq_stat,seq_stat_cpu,seq_del,seq_del_cpu,ran_create,ran_create_cpu,ran_stat,ran_stat_cpu,ran_del,ran_del_cpu
tidbit.kungfoocoder.org,1G,,,55236,11,36165,10,,,73514,8,2138.3,2,16,+++++,+++,+++++,+++,25015,99,28712,100,+++++,+++,26846,100
tidbit.kungfoocoder.org,1G,,,55236,11,30073,8,,,84287,10,2046.9,2,16,+++++,+++,+++++,+++,24862,99,28340,99,+++++,+++,26490,99
tidbit.kungfoocoder.org,1G,,,55391,11,30140,9,,,84506,10,2050.2,2,16,+++++,+++,+++++,+++,24642,100,28725,100,+++++,+++,26653,100
tidbit.kungfoocoder.org,1G,,,55364,11,30165,8,,,83055,11,2051.9,2,16,+++++,+++,+++++,+++,24682,100,28264,100,+++++,+++,26804,99


Note that even with debugging turned on we are about 5% faster at
reading and 20% slower than writing compared to reiserfs. Pretty good I
dare say.

However, when I run:

~# bonnie++ -x4 -d /mnt/sdq -u 0:0 -f -q -r800
name,file_size,putc,putc_cpu,put_block,put_block_cpu,rewrite,rewrite_cpu,getc,getc_cpu,get_block,get_block_cpu,seeks,seeks_cpu,num_files,seq_create,seq_create_cpu,seq_stat,seq_stat_cpu,seq_del,seq_del_cpu,ran_create,ran_create_cpu,ran_stat,ran_stat_cpu,ran_del,ran_del_cpu
Can't write block.
Bonnie: drastic I/O error (re write(2)): No such file or directory

Using reiserfs I can happily run:
# bonnie++ -x4 -d /mnt/sdq -u 0:0 -f -q -r1008

and the partition is 2.5GB in size.

Some more background information: my hardware is not overclocked, and
has been 100% reliable, about two weeks ago I sat it through about 24
hours of memtest86+ without any problems. The machine has 1GB of RAM.
The logical partition that I am testing is 2.5Gb

Here are the REISER4 settings from my configuration:
tidbit:~# grep REISER4 /boot/config-2.6.5pw-newmega-k7-1
CONFIG_REISER4_FS=m
# CONFIG_REISER4_FS_SYSCALL is not set
CONFIG_REISER4_LARGE_KEY=y
CONFIG_REISER4_CHECK=y
CONFIG_REISER4_FS_SYSCALL_DEBUG=y
# CONFIG_REISER4_DEBUG_MODIFY is not set
# CONFIG_REISER4_DEBUG_MEMCPY is not set
# CONFIG_REISER4_DEBUG_NODE is not set
# CONFIG_REISER4_ZERO_NEW_NODE is not set
# CONFIG_REISER4_TRACE is not set
# CONFIG_REISER4_EVENT_LOG is not set
# CONFIG_REISER4_STATS is not set
# CONFIG_REISER4_PROF is not set
# CONFIG_REISER4_LOCKPROF is not set
# CONFIG_REISER4_DEBUG_OUTPUT is not set
# CONFIG_REISER4_NOOPT is not set
CONFIG_REISER4_USE_EFLUSH=y
# CONFIG_REISER4_COPY_ON_CAPTURE is not set
# CONFIG_REISER4_BADBLOCKS is not set


I have removed the |1 from the jiffies|1 assignment. It still works,
which means that the kernel must have been fixed :-) But it didn't help
:-\

Hope this helps provide some illumination to the gurus out there...

Cheers,
Paul

