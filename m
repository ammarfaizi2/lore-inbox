Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267054AbRGMMDq>; Fri, 13 Jul 2001 08:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267055AbRGMMDg>; Fri, 13 Jul 2001 08:03:36 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:25289 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267054AbRGMMD2>; Fri, 13 Jul 2001 08:03:28 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Abramo Bagnara <abramo@alsa-project.org>,
        Linus Torvalds <torvalds@transmeta.com>
Date: Fri, 13 Jul 2001 22:03:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15182.58236.133661.221154@notabene.cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, nfs-devel@linux.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] Bug in NFS - should umask be allowed to set umask???
In-Reply-To: message from Abramo Bagnara on Friday July 13
In-Reply-To: <3B4E93E9.F6506CC0@alsa-project.org>
	<15182.48923.214510.180434@notabene.cse.unsw.edu.au>
	<3B4EDBCE.D2AEAD16@alsa-project.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Background for Linus who has been added to the To: list
  Abramo noticed that knfsd appeared to be running with a umask of 022.
  I commented that nfsd has the same umask as /sbin/init as they share
  current->fs, courtesy of daemonize().  I asked what "init" he was
  running]

On Friday July 13, abramo@alsa-project.org wrote:
> $ rpm -qf /sbin/init
> SysVinit-2.78-17

Ok, I found SysVinit-2.78-15 which is probably close enough, managed
to find a redhat system to explode it on, and found this patch:

--- sysvinit-2.78/src/init.c.foo        Wed Apr  4 01:42:27 2001
+++ sysvinit-2.78/src/init.c    Wed Apr  4 01:42:49 2001
@@ -2451,6 +2451,8 @@
        p = argv[0];
        
 
+  umask(022);
+       
   /*
    *   Is this telinit or init ?
    */
@@ -2523,8 +2525,6 @@
   /* Check syntax. */
   if (argc - optind != 1 || strlen(argv[optind]) != 1) Usage(p);
   if (!strchr("0123456789SsQqAaBbCcUu", argv[optind][0])) Usage(p);
-
-  umask(022);
 
   /* Open the fifo and write a command. */
   memset(&request, 0, sizeof(request));


what this does is that instead of just setting umask when running as
"telinit", init always sets umask to 022.  This is setting the umask
for nfsd. This completely explains your observations.
So we have several options:

1/ Claim that redhat is broken. Leave them to fix SysVinit.
2/ Have nfsd over-write the umask setting that /sbin/init imposed.
   This is effectively what your patch does.
3/ Decide that it is inappropriate for nfsd to share the current->fs
   fs_struct with init.  Unfortunately this means changing or
   replacing daemonize().

None of these seem ideal.  (3) is probably most correct (i.e. protect
the kernel from user space mucking about) but is the most work.

Suggestions please ??? Linus??

NeilBrown
