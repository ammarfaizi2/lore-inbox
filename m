Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280669AbRKSUDS>; Mon, 19 Nov 2001 15:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280676AbRKSUDJ>; Mon, 19 Nov 2001 15:03:09 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:53239 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280669AbRKSUDA>;
	Mon, 19 Nov 2001 15:03:00 -0500
Date: Mon, 19 Nov 2001 13:02:23 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: DD-ing from device to device.
Message-ID: <20011119130223.K1308@lynx.no>
Mail-Followup-To: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20011119101340.I1308@lynx.no> <200111191728.SAA05962@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111191728.SAA05962@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Mon, Nov 19, 2001 at 06:28:55PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 19, 2001  18:28 +0100, Rogier Wolff wrote:
> > There is another report saying 2.4.14
> > also "Creating partitions under 2.4.14", and I have read several more
> > recently but am unsure of the exact kernel version.  What fs are you
> > using, just in case it matters?
> 
> ext2. 

Well, I just tried this on ext2 instead of ext3 (on my 2.4.13 system)
and it worked fine as a logged-in non-root user (creates a 16GB sparse file):

dd if=/dev/zero of=tt bs=1k count=1 seek=16M

> > I know for sure that 2.4.13+ext3 is working mostly OK, as I have been
> > playing with multi-TB file sizes (sparse of course) although there is
> > a minor bug in the case where you hit the fs size maximum.  I'm glad
> > my patch isn't in yet, or I would be getting flak over this I'm sure.
> 
> > The only problem is that I can't see anything in the 2.4.14 patch which
> > would cause this problem.  All the previous reports had to do with
> > ulimit, caused by su'ing to root instead of logging into root, but I'm
> > not sure exactly where the problem lies.
> 
> Gotcha!!!! 
> 
> The "wouldn't work" case was tested by me, logged in as wolff, su-ing
> to root, and the "works just fine" cases were tested by a guy who logs
> in to the machine on the console (as root).
> 
> 
> Now, can someone tell me why "unlimited" is interpreted somehow as 2G
> or something thereabouts? :
> 
>  /home/wolff> limit
> cputime         unlimited
> filesize        unlimited
> datasize        unlimited
> stacksize       unlimited
> coredumpsize    unlimited
> memoryuse       unlimited
> descriptors     1024 
> memorylocked    unlimited
> maxproc         4095 
> openfiles       1024 
>  /home/wolff> su
> Password: 
>  /home/wolff# limit
> cputime         unlimited
> filesize        unlimited
> datasize        unlimited
> stacksize       unlimited
> coredumpsize    unlimited
> memoryuse       unlimited
> descriptors     1024 
> memorylocked    unlimited
> maxproc         4095 
> openfiles       1024 

Well, because of 32-bit API issues "unlimited" actually IS the same as 2G
for 32-bit systems, but the code internally checks if the limit is equal
to RLIM_INFINITY (mm/filemap.c:generic_file_write()) and (should) ignore
it if so.  Thus it is impossible to set a ulimit exactly 2GB, but that
isn't really a problem.

Hmm, looking at the user-space header <customs/customs.h>, it has
RLIM_INFINITY as 0x7fffffff, the <bits/resource.h> has:

#ifndef __USE_FILE_OFFSET64
# define RLIM_INFINITY ((long int) (~0UL >> 1))
#else
# define RLIM_INFINITY 0x7fffffffffffffffLL
#endif

but the kernel code has RLIM_INFINITY as ~0UL for most arches.

>  /home/wolff# cat /proc/version
> Linux version 2.4.9 (wolff@machine) (gcc version 2.95.2 19991024 (release)) #3 SMP
>  Mon Sep 10 09:17:17 BST 2001
>  /home/wolff# 
> 
> (The machine was downgraded due to other problems. )

Can you test the "dd" above to ensure it works with your tools and the old
kernel?  For your next 2.4.14 kernel build, it may be instructive to put
a printk() inside the 3 checks in generic_file_write() before it outputs
SIGXFSZ, which tells us limit and RLIM_INIFINITY, pos and count, and pos
and s_maxbytes are, respectively.  This will also tell us what limit is
being hit (although it is most likely a ulimit issue).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

