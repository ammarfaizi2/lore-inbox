Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbTEHJoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 05:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbTEHJoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 05:44:09 -0400
Received: from mxout4.netvision.net.il ([194.90.9.27]:52876 "EHLO
	mxout4.netvision.net.il") by vger.kernel.org with ESMTP
	id S261250AbTEHJoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 05:44:07 -0400
Date: Thu, 08 May 2003 12:54:23 +0300
From: Nir Livni <nirl@cyber-ark.com>
Subject: RE: shared objects, ELFs and memory usage
To: linux-kernel@vger.kernel.org
Message-id: <E1298E981AEAD311A98D0000E89F45134B55FB@ORCA>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> 
> > Hi all,
> > If this is not the mailing list to ask this question - 
> please let me 
> > know where should I ask it.
> >
> > I have an executable whose size is almost 2MB, and it uses a shared 
> > object that is almost 2MB. when I run the process, I see 
> (using "top") 
> > that the amount of "used memory" raises with 4MB. (make 
> sence...). the 
> > process seem to share 2MB ("shared" column).
> >
> > When the process forks, it seems that the amount of "used memory" 
> > raises with 4MB again.
> >
> > Does it mean the shared object is not really shared ? That doesn't 
> > make sence...
> >
> > Help is appreciated.
> > Please CC me because I am not subscribed.
> >
> > Thanks,
> > Nir
> 
> If your shared object is truly a shared object, then it is 
> shared. Use `strace` to trace the startup of your program. 
> You should see it mmap() some portion of your shared object. 
> You can also put a pause() in you program, then look at 
> /proc/<PID>/maps and see what your program has memapped.
> 
> Note that merely linking some object files together does not 
> create a shared object! You need to compile any 'C' code with 
> the '-shared' parameter, and any assembly code needs to not 
> use COMM variables. Then you need to link them as
> 
> 	ld -warn-common -O2 -shared -Map Shared.Map $(OBJS) -o $(SLIB)
> 

After compiling and linking my .so with the -shared option,
I've inspected strace output.
I can clearly see that the shared object (which is 2MB size) is NOT being
shared:

1395  open("/usr/local/sharedclient.so", O_RDONLY) = 6
1395  read(6, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\200"...,
1024) = 1024
1395  fstat64(6, {st_mode=S_IFREG|0644, st_size=2079700, ...}) = 0
1395  old_mmap(NULL, 2118824, PROT_READ|PROT_EXEC, MAP_PRIVATE, 6, 0) =
0x401ea000

Any idea why ?
(Please CC me because I am not subscribed)

Thanks,
Nir

> ...where OBJS is you list of object files, and SLIB is your 
> new shared library.
> 
> You can inspect Shared.Map to see what is in the library. 
> When you link against the shared library, you need to tell 
> the linker where to find the runtime file, i.e., you need to 
> use -rpath.
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 
> BogoMips). Why is the government concerned about the lunatic 
> fringe? Think about it.
> 
