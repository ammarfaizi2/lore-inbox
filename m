Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSFKLS3>; Tue, 11 Jun 2002 07:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317004AbSFKLS2>; Tue, 11 Jun 2002 07:18:28 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:57428 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317003AbSFKLS2>; Tue, 11 Jun 2002 07:18:28 -0400
Message-Id: <5.1.0.14.2.20020611120032.00aec7f0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 11 Jun 2002 12:22:15 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp
In-Reply-To: <3D05C27D.186DC066@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:27 11/06/02, Andrew Morton wrote:
>Rusty Russell wrote:
> >
> > ...
> > Let's not perpetuate the myth that everything in the kernel needs to
> > be tuned to the last cycle at all costs, hm?
>
>I was more concerned about the RAM use, actually.
>
>This patch is an additional reason for CONFIG_NR_CPUS, but I've rather
>gone cold on that idea because the "proper fix" is to make all those
>huge per-cpu arrays dynamically allocated.   So you can run a 64p kernel
>on 2p without losing hundreds of k of memory and kernel address space.
>
>But it looks like all those dynamically-allocated structures would
>have to be allocated out to NR_CPUS anyway, to support hotplug, yes?
>
>In which case, CONFIG_NR_CPUS is the only way to get the memory
>back...

Why? You can get rid of all uses of NR_CPUS (except for using it as a max 
capping value so none goes above it) and always use smp_num_cpus instead. 
And make the cpu hotplug code update smp_num_cpus as appropriate.

All code relying on smp_num_cpus for per-cpu buffers can do a check whether 
the current cpu is greater than the value of smp_num_cpus at per-cpu buffer 
allocation time and if so lock the kernel (or only the buffers if possible) 
and grow the buffer allocation up to the new smp_num_cpus value. And all 
that can be done nicely out of line in a really, really, snail speed slow 
path... The fastpath only needs to contain:

         cpu = smp_processor_id();
#ifdef CONFIG_HOTPLUG_CPU
         if (unlikely(cpu >= old_smp_num_cpus))
                 goto snail_path;
         snail_path_done:
#endif

So zero penalty for non-hotplug users and loads of penalty for hotplug 
users but frankly I couldn't care less for those. The slow path will 
trigger so seldom it is not worth thinking about the performance hit there.

You could even make the above look nicer by making it a function like:

cpu = smp_processor_id();
check_for_cpu_hotplug_event(cpu, old_smp_num_cpus, our_hotplug_callback);

And let our_hotplug_callback() deal with the case where cpu is >= 
old_smp_num_cpus, for example for ntfs that would involve extending the 
number of per-cpu buffers. And in the !CONFIG_HOTPLUG_CPU case the whole 
check_for_cpu_hotplug_event function becomes a NOP. All in the spirit of 
not having #ifdefs sprinkled around the code.

There are a lot of ways to deal with this corner case dynamically, so 
please use one of them. I don't buy the "lets penalise 99% of users for the 
sake of a feature that almost noone will ever use" argument.

Best regards,

         Anton



-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

