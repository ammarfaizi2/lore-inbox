Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312411AbSELK1b>; Sun, 12 May 2002 06:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312447AbSELK1a>; Sun, 12 May 2002 06:27:30 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:61233 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312411AbSELK1a>; Sun, 12 May 2002 06:27:30 -0400
Message-Id: <5.1.0.14.2.20020512111022.02051b70@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 12 May 2002 11:26:42 +0100
To: mcp@linux-systeme.de
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [ANNOUNCE] NTFS 2.0.7a for Linux 2.4.18
Cc: Pawel Kot <pkot@ziew.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020512040757.27097A-100000@fps>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:26 12/05/02, mcp@linux-systeme.de wrote:
>Hi Pawel,
>
> >Backported NTFS 2.0.7 from 2.5.x to 2.4.18 is available from linux-ntfs
> >project page:
>i've tried this, have a look:

I just had a look at the ntfs patch. Pawel has removed all preemption code 
from ntfs. This means that if you use the new ntfs with 2.4.x + preempt 
your kernel will cause MASSIVE in-memory data corruption. So in a way I am 
very glad it didn't compile in the first place... Saved you a lot of grief.

 From the below errors it is very clear that it is the preempt patch 
interacting badly with the ntfs patch and breaking the compile. I have made 
a few suggestions to Pawel on how to add preemption to ntfs again but if 
you want to do it yourself, basically look at the 2.5.x new ntfs driver and 
grep for "preempt" (in fs/ntfs/*.[hc]) and wherever you find it in 2.5.x 
put it into 2.4.x, too. Basically only fs/ntfs/compress.c uses preempt_*() 
so it is very easy to do this. Then there is the compilation problem below. 
I suspect preempt itself is not including a header file somewhere, and you 
get away with this when ntfs is not present because it just so happens that 
all other code adds the right #include. In 2.4.x vanilla "current" used to 
be defined in asm/current.h which is usually included via linux/sched.h. So 
at a guess you could fix compilation of fs/ntfs/debug.c by adding #include 
<linux/sched.h> to the list of includes in debug.c.

Best regards,

         Anton


>cc  -D__KERNEL__ -I/usr/src/linux-2.4.18/include  -Wall
>-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
>-fno-strict-aliasing -fno-common -Wno-unused -pipe
>-mpreferred-stack-boundary=2 -march=i686 -DMODULE
>-DNTFS_VERSION=\"2.0.7a\" -DDEBUG -DKBUILD_BASENAME=debug  -c -o debug.o
>debug.c
>debug.c: In function `__ntfs_warning':
>debug.c:58: `current' undeclared (first use in this function)
>debug.c:58: (Each undeclared identifier is reported only once
>debug.c:58: for each function it appears in.)
>debug.c:68: warning: implicit declaration of function `preempt_schedule'
>debug.c: In function `__ntfs_error':
>debug.c:98: `current' undeclared (first use in this function)
>debug.c: In function `__ntfs_debug':
>debug.c:126: `current' undeclared (first use in this function)
>make[2]: *** [debug.o] Error 1
>make[2]: Leaving directory
>`/usr/src/linux-2.4.18/fs/ntfs'
>make[1]: *** [_modsubdir_ntfs] Error 2
>make[1]: Leaving directory `/usr/src/linux-2.4.18/fs'
>make: *** [_mod_fs] Error 2
>
>Yes, 2.4.18 + preempt and some other additional stuff.
>NTFS is a Module, happs with/without selecting debug feature in kernel
>config.
>
>Kind regards,
>         Marc
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

