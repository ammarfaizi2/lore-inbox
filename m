Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290460AbSAQVBJ>; Thu, 17 Jan 2002 16:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290461AbSAQVBA>; Thu, 17 Jan 2002 16:01:00 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:30480 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290460AbSAQVAn>; Thu, 17 Jan 2002 16:00:43 -0500
Message-ID: <3C4739D3.DCFFA025@zip.com.au>
Date: Thu, 17 Jan 2002 12:53:39 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Bernstein <matt@theBachChoir.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: probably very irrelevant oops
In-Reply-To: <Pine.LNX.4.44.0201171404410.7764-100000@nick.dcs.qmul.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Bernstein wrote:
> 
> Hi,
> 
> I built a fairly pathological kernel based on 2.4.17 with sched-O1-H7,
> ext3-0.9.17, XFS, jfs-1.0.12 and Intel's e100. (Things are orthogonal
> enough that they patch together easily :)
> 
> It boots fine (but not with devfs) and I can use all four journaled
> filesystems together happily. So I thought I'd try two very stupid stress
> tests.
> 
> find /lib/modules/2.4.17-expt/kernel/ -type f|while read i; do insmod $i; done

You're sick.  I like you.

> [Great. A few hundred modules load, no doubt some clashing with others.
> However, lsmod seems to suggest we've overrun a buffer as the output
> looks truncated (my find produced 597 lines, but lsmod only 300 or so)]

Well a lot of the modules won't stick, because they won't find the
required hardware.  Plus the /proc/modules output gets chopped after
4 kbytes.

> awk '{print $1}' /proc/modules|while read i; do rmmod $i; done
> 
> [BOOM. But I was asking for it.. the first three warnings are the modules
> in my initrd]
> 
> ...
>
> Unable to handle kernel paging request at virtual address d11cd2a0
> c017184d
> *pde = 0563e067
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c017184d>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00210246
> eax: d11cd2a0   ebx: d1191000   ecx: 00000000   edx: cf005f64
> esi: d1197540   edi: 00000000   ebp: 00000003   esp: c3b27f04
> ds: 0018   es: 0018   ss: 0018
> Process modprobe (pid: 5881, stackpage=c3b27000)
> Stack: d1191000 00000003 00000003 d11968ca d1197540 00000000 d1191000 00000003
>        00000003 d1191000 c0115945 d119763c c0ff4000 00006580 c05da000 00000060
>        ffffffea 00000006 cb8e1214 00000060 d118d000 d1191060 00006680 00000000
> Call Trace: [<d11968ca>] [<d1197540>] [<c0115945>] [<d119763c>] [<d1191060>]
>    [<c0106ebb>]
> Code: 89 30 8b 1d 28 6a 1e c0 81 fb 28 6a 1e c0 74 23 8d 76 00 53
> 
> >>EIP; c017184d <pci_register_driver+1d/60>   <=====
> Trace; d11968ca <[es1371]init_es1371+2a/50>
> Trace; d1197540 <[es1371]es1371_driver+0/3f>
> Trace; c0115945 <sys_init_module+525/5e0>
> Trace; d119763c <[es1371].data.end+bd/dae1>
> Trace; d1191060 <[es1371]wait_src_ready+0/3c>
> Trace; c0106ebb <system_call+33/38>

It appears that one of the modules failed to unregister itself
from the global driver list.  Then when the next module went
walking the list, it tried to refer to the bad module's vmalloc'ed
space.

One strange thing: why was it `modprobe' which crashed?  Were you
not purely running `rmmod' at the time?

The bug probably is in the module which immediately preceded
es1371 in your /proc/modules output.  Could you please load
them all up again, send me your /proc/modules output?

Also, change your scripts to print out the names of the modules
as they're being loaded and unloaded, run the test again and
see which modules were being loaded/unloaded shortly before the
crash.

Thanks.
