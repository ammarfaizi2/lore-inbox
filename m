Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVAFR1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVAFR1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVAFR0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:26:36 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:61056 "EHLO vana")
	by vger.kernel.org with ESMTP id S262922AbVAFR0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:26:13 -0500
Date: Thu, 6 Jan 2005 18:26:13 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106172613.GI5772@vana.vc.cvut.cz>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106163559.GG5772@vana.vc.cvut.cz> <20050106165715.GH1830@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106165715.GH1830@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 05:57:15PM +0100, Andi Kleen wrote:
> On Thu, Jan 06, 2005 at 05:35:59PM +0100, Petr Vandrovec wrote:
> > BTW, vmmon will still require register_ioctl32_conversion as we are using
> > (abusing) it to be able to issue 64bit ioctls from 32bit application.  I
> > assume that there is no supported way how to issue 64bit ioctls from 32bit
> > aplication anymore after you disallow system-wide translations to be registered
> > by modules.
> 
> Why are you issuing 64bit ioctls from 32bit applications? 

There are three reasons (main reason is that vmware is 32bit app, but it is how
things are currently laid out; even if there will be 64bit app, 32bit versions are
already in use and people wants to use them on 64bit kernels):

* USB.  usbfs API is written in a way which does not allow you to safely wrap
it in "generic" 32->64 layer, and attempts to do it in non-generic way in usbfs
code itself did not look feasible year ago.  Even on current 64bit kernels it is not
possible to issue raw USB operations from 32bit apps, and I do not believe that
it is going to change - after all, just issuing ioctl through 64bit path from application
which is aware of 64bit kernel is quite simple, much simpler than any attempt to
make kernel dual-interface.

* parport interface, serial port:  not all APIs were implemented in kernel.  Current
kernels do wrap all APIs vmware needs, but older kernels do not, and so we had to find
some solution for older kernels too.  Not so surprisingly, solution we had in place for
USB works for them too...

* floppy:  it is actually different from examples above, as FDRAWCMD command is
supported by 32->64 layer, but it is supported incorrectly.  Due to this all above
started, as we had to make application aware of kernel it runs on, as FDRAWCMD on 32bit
kernel returns 80 byte structure, while 104 byte on 64bit kernel, and you do not now
which one you'll get until you call this ioctl...  And once we had code in place,
it was reused for USB and later for ppdev & serial.

So we added simple wrapper to vmmon which just gets {64bit-ioctl-number, 64bit-arg-argument}
and passes it down to 64bit sys_ioctl:

/* Use weak: not all kernels export sys_ioctl for use by modules */
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 66)
asmlinkage __attribute__((weak)) long
sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
#else
asmlinkage __attribute__((weak)) int
sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
#endif

...

static int
LinuxDriver_Ioctl3264Passthrough(unsigned int fd, unsigned int iocmd,
                                 unsigned long ioarg, struct file * filp)
{
   VMIoctl64 cmd;

   if (copy_from_user(&cmd, (VMIoctl64*)ioarg, sizeof(cmd))) {
      return -EFAULT;
   }
   if (sys_ioctl) {
      int err;

#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 26) || \
   (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 0) && LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 3))
      err = sys_ioctl(fd, cmd.iocmd, cmd.ioarg);
#else
      unlock_kernel();
      err = sys_ioctl(fd, cmd.iocmd, cmd.ioarg);
      lock_kernel();
#endif
      return err;
   }
   return -ENOTTY;
}


We were thinking about creating 64bit thread, and issuing 64bit syscalls from it, but 
it looked more fragile than code above.
								Best regards,
									Petr Vandrovec

