Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTARDEg>; Fri, 17 Jan 2003 22:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbTARDEg>; Fri, 17 Jan 2003 22:04:36 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:19328 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262201AbTARDEd>;
	Fri, 17 Jan 2003 22:04:33 -0500
Date: Sat, 18 Jan 2003 04:13:19 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Raja R Harinath <harinath@cs.umn.edu>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, alsa-devel@alsa-project.org,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant errno variable
Message-ID: <20030118031319.GA19982@vana.vc.cvut.cz>
References: <20030117155717.A6250@baldur.yggdrasil.com> <d9n0lz18an.fsf@bose.cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9n0lz18an.fsf@bose.cs.umn.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 08:49:36PM -0600, Raja R Harinath wrote:
> Hi,
> 
> "Adam J. Richter" <adam@yggdrasil.com> writes:
> 
> > 	linux-2.5.59/sound/sound_firmware.c attempts to use the
> > user level system call interface from the kernel, which I understand
> > works on i386 and perhaps all architectures, but requires a variable
> > named "errno." 
> 
> Which is provided in-kernel (not for modules) by 'lib/errno.c'.

Not safe. We should either remove errno from kernel syscall wrappers 
completely when building __KERNEL__ (just return -1 and nothing more
specific), or even disallow use of unistd.h wrappers from kernel 
completely (which is best solution IMHO). Or we must make errno 
per-thread variable, which is unnecessary complication...

> > (Actually, it mixed things like close() and sys_close(), but that's
> > beside the point.)
> 
> Those are provided by <linux/unistd.h>, with __KERNEL_SYSCALLS__
> defined.
> 
> > 	I could just declare a "static int errno;" in the file,
> 
> That was originally there, but removed in 2.5.57 IIRC.
> <linux/unistd.h> has 'extern int errno;' -- so 'static int errno;'
> would be a bug.

I sent patch below few days ago, but I received only confirmations that
fixes compilation - nobody with hardware which uses this firmware
loader confirmed that it works.

Today morning I decided to send it to Linus anyway, as at worst
less broken is better than more broken, but unfortunately Linus was
already at airport :-(

BTW, static int errno is by far best solution if you do not agree with
patch below: due to toolchain behavior soundcore will use its own
errno for syscall wrappers it uses, and it is nearest to the behavior
we wanted...
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz

diff -ur linux-2.5.58-c952.dist/sound/sound_firmware.c linux-2.5.58-c952/sound/sound_firmware.c
--- linux-2.5.58-c952.dist/sound/sound_firmware.c	2003-01-16 22:33:32.000000000 +0100
+++ linux-2.5.58-c952/sound/sound_firmware.c	2003-01-17 14:54:40.000000000 +0100
@@ -1,47 +1,46 @@
 #include <linux/vmalloc.h>
-#define __KERNEL_SYSCALLS__
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/unistd.h>
 #include <asm/uaccess.h>
 
 static int do_mod_firmware_load(const char *fn, char **fp)
 {
-	int fd;
+	struct file* filp;
 	long l;
 	char *dp;
+	loff_t pos;
 
-	fd = open(fn, 0, 0);
-	if (fd == -1)
+	filp = filp_open(fn, 0, 0);
+	if (IS_ERR(filp))
 	{
 		printk(KERN_INFO "Unable to load '%s'.\n", fn);
 		return 0;
 	}
-	l = lseek(fd, 0L, 2);
+	l = filp->f_dentry->d_inode->i_size;
 	if (l <= 0 || l > 131072)
 	{
 		printk(KERN_INFO "Invalid firmware '%s'\n", fn);
-		sys_close(fd);
+		filp_close(filp, NULL);
 		return 0;
 	}
-	lseek(fd, 0L, 0);
 	dp = vmalloc(l);
 	if (dp == NULL)
 	{
 		printk(KERN_INFO "Out of memory loading '%s'.\n", fn);
-		sys_close(fd);
+		filp_close(filp, NULL);
 		return 0;
 	}
-	if (read(fd, dp, l) != l)
+	pos = 0;
+	if (vfs_read(filp, dp, l, &pos) != l)
 	{
 		printk(KERN_INFO "Failed to read '%s'.\n", fn);
 		vfree(dp);
-		sys_close(fd);
+		filp_close(filp, NULL);
 		return 0;
 	}
-	close(fd);
+	filp_close(filp, NULL);
 	*fp = dp;
 	return (int) l;
 }
