Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262460AbTCMRFd>; Thu, 13 Mar 2003 12:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262470AbTCMRFd>; Thu, 13 Mar 2003 12:05:33 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:22957 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262460AbTCMRFa>; Thu, 13 Mar 2003 12:05:30 -0500
Date: Thu, 13 Mar 2003 11:16:14 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Oliver Tennert <tennert@science-computing.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel setup() and initrd problems
In-Reply-To: <Pine.GHP.4.53.0303130942100.16619@alderaan.science-computing.de>
Message-ID: <Pine.LNX.4.44.0303131051160.7342-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003, Oliver Tennert wrote:

> Seems some more have problems, too. It is possibly related.
> 
> > pivot_root() is the currently preferred method. Depending on where
> > the initramfs is by the time Linux 2.6 comes out it may be replaced by
> > then, but for 2.4, pivot_root() is the way to go.
> 
> OK, I am pretty aware of the fact that it is the DOCUMENTED way to go. But
> can you tell me ONE SINGLE current distribution using the pivot_root()
> call in their initrd to mount the realrootdev?

Well, the script you attached shows one distro which does:

> [...]
> echo 0x0100 > /proc/sys/kernel/real-root-dev   ## <<<---- THIS LINE IS IMPORTANT!!
> mount -n -t ext3 /dev/sda4 /mnt
> rm -f /mnt/.initrd 2>/dev/null
> mkdir -p /mnt/.initrd
> cd /mnt
> pivot_root . .initrd
> umount -n /.initrd/proc
> exec sh -c 'umount -n /.initrd ; rmdir /.initrd ; mount -n -oremount,ro /' </dev/console >/dev/console 2>&1
> 
> </SHELLSCRIPT>
> 
> The fact is, without the "echo 0x0100 ..." line this linuxrc script WILL
> NOT be able to mount your root device for kernel >=2.4.19. This is
> independent of the distribution used.
> 
> So why is that?
> 
> I always thought the pivot_root() would make this echo-stuff unnecessary.
> 
> The way used by virtually all latest distributions is getting rid of the
> pivot stuff altogether, leaving the loading of the modules, and that's it.
> 
> Seems totally unclear (and unclean) to me.

I agree it's a mess and for all I can tell pivot_root is not used in the 
way it was originally designed.

Since I cleaned up the initrd stuff in 2.5 lately, I can at least explain
what's going on:

The kernel finds an initrd, loads that into /dev/ram, mounts that as root 
and then basically fork()s and execve()s /linuxrc. So we're still using 
the special initrd code, and the /linuxrc which is running has a pid != 1. 
At this point, we can do preparations like loading modules and mounting 
filesystems. As shown by the script above, we can also change the root 
filesystem. However, we can not finish the script by just exec'ing 
/sbin/init in the new root, since we're not pid 1. So instead, we need to 
exit from the script (actually, the above first exec's and then the new 
shells exits soon after).

Now kernel code takes control again, the "after-initrd-code" is run. 
Traditionally, that means we now mount the real root device, free the 
initrd mem (and also all __init mem a bit alter), and then execve() 
/sbin/init, which then gets run as PID 1, and normal startup begins.

However, in the case above, we have already mounted root device, so we 
don't want the kernel to mess with it. So we do echo 0x0100 > 
/proc/real-root-dev, which tells the kernel that what he thinks is our 
current root, /dev/ram, is the real root too, so it skips unmounting 
the initrd root and mounting the real one.

I think whoever came up with that just got the idea of pivot_root wrong. 
The idea was to get rid of the initrd special case. It should be possible 
to do the following, though I didn't work out the details: 

Tell the kernel that our root dev is /dev/ram and give it an initrd which 
isn't really a classical initrd (with /linuxrc on it), but instead has a 
/sbin/init which is similar to the linuxrc above.

Then, the kernel will load the image into /dev/ram, mount that as root and 
exec /sbin/init, skipping the special initrd code.

Now, we have to take care of all the remaining business in /sbin/init 
ourselves, i.e.

- load modules
- mount real root
- pivot root to real root
- execve /sbin/init on real root, pointing stdin/out/err to /dev/console 
  on the new root
- umount and free our first (ramdisk) root

--Kai


