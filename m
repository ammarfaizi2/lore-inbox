Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271919AbRHVDbB>; Tue, 21 Aug 2001 23:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271920AbRHVDau>; Tue, 21 Aug 2001 23:30:50 -0400
Received: from pioneer.oftheInter.net ([216.61.42.221]:4615 "HELO
	pioneer.oftheInter.net") by vger.kernel.org with SMTP
	id <S271919AbRHVDaf>; Tue, 21 Aug 2001 23:30:35 -0400
Date: Tue, 21 Aug 2001 22:30:42 -0500
From: Taylor Carpenter <taylorcc@codecafe.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when accessing /dev/fd0 (kernel 2.4.7 and devfsd 1.3.11)
Message-ID: <20010821223042.A30478@pioneer.oftheInter.net>
In-Reply-To: <20010816222811.A1672@pioneer.oftheInter.net> <200108170419.f7H4J7c20693@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108170419.f7H4J7c20693@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Thu, Aug 16, 2001 at 10:19:07PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Aug 16, 2001 at 10:19:07PM -0600, Richard Gooch wrote:
> If you think the problem may be devfs-related, a good test is to try
> again with CONFIG_DEVFS_FS=n.

I tried kernel 2.4.8 and also had an oops.  An earlier kernel w/out devfs did
not cause an oops.  I plan on making a non-devfs 2.4.8 kernel to see if the
oops does not happen.

> However, I run devfs, and I don't see this problem.

I do not know if the devfs info, in the oops (ksymoops output) data below
indicates a problem w/devfs or not.  Maybe you can tell?

> You need to run this through ksymoops before anyone can help you.

Here is the output from ksymoops

-----
>>EIP; c013c4c4 <vfs_readlink+24/60>   <=====
Trace; c015469b <devfs_unregister_blkdev+12eb/1960>
Trace; c01376d2 <cdput+5e2/880>
Trace; c0106c2b <__up_wakeup+108b/24a0>
Code;  c013c4c4 <vfs_readlink+24/60>
00000000 <_EIP>:
Code;  c013c4c4 <vfs_readlink+24/60>   <=====
   0:   f2 ae                     repnz scas %es:(%edi),%al   <=====
Code;  c013c4c6 <vfs_readlink+26/60>
   2:   f7 d1                     not    %ecx
Code;  c013c4c8 <vfs_readlink+28/60>
   4:   49                        dec    %ecx
Code;  c013c4c9 <vfs_readlink+29/60>
   5:   89 ce                     mov    %ecx,%esi
Code;  c013c4cb <vfs_readlink+2b/60>
   7:   39 de                     cmp    %ebx,%esi
Code;  c013c4cd <vfs_readlink+2d/60>
   9:   0f 47 f3                  cmova  %ebx,%esi
Code;  c013c4d0 <vfs_readlink+30/60>
   c:   56                        push   %esi
Code;  c013c4d1 <vfs_readlink+31/60>
   d:   52                        push   %edx
Code;  c013c4d2 <vfs_readlink+32/60>
   e:   8b 44 24 1c               mov    0x1c(%esp,1),%eax
Code;  c013c4d6 <vfs_readlink+36/60>
  12:   50                        push   %eax
Code;  c013c4d7 <vfs_readlink+37/60>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c013c4dc <vfs_readlink+3c/60>
-----

After watching what happens during the boot process I started turning off
things that might be touching the floppy device (at boot), such as autofs.
What finally stopped the Oops was to comment out the floppy entry in
/etc/fstab:

	/dev/fd0 /floppy auto defaults,user,noauto 0 0

I can then load the floppy module after boot, and successfully access the
floppy device w/o any problems.  The oops happened when the mountall script
(Debian testing) was running:

	mount -avt nonfs,noproc,nosmbfs

Devfsd is started way before mountall is ran so I do not know why it is
causing problems.

Please CC replies to taylorcc@codecafe.com as I am not on the list.  Thanks.
