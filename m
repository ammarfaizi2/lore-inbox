Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317671AbSFLIY3>; Wed, 12 Jun 2002 04:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317672AbSFLIY2>; Wed, 12 Jun 2002 04:24:28 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:48393 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317671AbSFLIYY>; Wed, 12 Jun 2002 04:24:24 -0400
Message-Id: <5.1.0.14.2.20020612090736.04192860@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 12 Jun 2002 09:25:17 +0100
To: Rusty Russell <rusty@rustcorp.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp
In-Reply-To: <E17I39U-00054u-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:06 12/06/02, Rusty Russell wrote:
>In message <5.1.0.14.2.20020612084157.041970e0@pop.cus.cam.ac.uk> you write:
> > >Now, you *could* only allocate buffers for cpus where cpu_possible(i)
> > >is true, once the rest of the patch goes in.  That would be a valid
> > >optimization.
> >
> > Please explain. What is cpu_possible()?
>
> >From Hotcpu/hotcpu-boot-i386.patch.gz:
>
>--- working-2.5.19-pre-hotcpu/include/asm-i386/smp.h    Tue Jun  4 
>15:37:09 2002
>+++ working-2.5.19-hotcpu/include/asm-i386/smp.h        Mon Jun  3 
>18:00:09 2002
>@@ -93,6 +94,8 @@
>  #define smp_processor_id() (current_thread_info()->cpu)
>
>  #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
>+
>+#define cpu_possible(cpu) (phys_cpu_present_map & (1<<(cpu)))
>
>  extern inline unsigned int num_online_cpus(void)
>  {
>
>ie. "Can this CPU number *ever* exist?", for exactly this kind of
>optimization.

Aha, now we are talking! This looks like it will restore the current memory 
usage just fine.

>   It looks like it was a mistake to leave that to a later
>patch, but I didn't appreciate the 64k-per-cpu buffer for NTFS (what
>is it for, by the way?  per-cpu buffering for a filesystem seems, um,
>wierd).

It is used by the NTFS decompression engine. When implementing 
decompression I went for using a single linear buffer holding the 
compressed data to avoid having to switch pages midstream of memcpy()s 
multi byte assignments, etc. (It could be argued that I was lazy but I 
think it makes sense from a performance point of view.) After making that 
decision I saw three choices:

1) Use a single buffer and lock it so once one file is under decompression 
no other files can be and if multiple compressed files are being accessed 
simultaneously on different CPUs only one CPU would be decompressing. The 
others would be waiting for the lock. (Obviously scheduling and doing other 
stuff.)

2) Use multiple buffers and allocate a buffer every time the decompression 
engine is used. Note this means a vmalloc()+vfree() in EVERY ->readpage() 
for a compressed file!

3) Use one buffer for each CPU and use a critical section during 
decompression (disable preemption, don't sleep). Allocated at mount time of 
first partition supporting compression. Freed at umount time of last 
partition supporting compression.

I think it is obvious why I went for 3)...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

