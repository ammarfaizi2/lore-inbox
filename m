Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbUKRNvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbUKRNvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 08:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUKRNvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 08:51:38 -0500
Received: from mail.convergence.de ([212.227.36.84]:29646 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261739AbUKRNvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 08:51:33 -0500
Date: Thu, 18 Nov 2004 14:55:22 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Gerd Knorr <kraxel@bytesex.org>
Subject: Re: modprobe + request_module() deadlock
Message-ID: <20041118135522.GA16910@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Gerd Knorr <kraxel@bytesex.org>
References: <20041117222949.GA9006@linuxtv.org> <1100749702.5865.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100749702.5865.39.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:48:22PM +1100, Rusty Russell wrote:
> On Wed, 2004-11-17 at 23:29 +0100, Johannes Stezenbach wrote:
> > Hi,
> > 
> > it seems that modprobe in newer versions of module-init-tools
> > (here: 3.1-pre6) gets an exclusive lock on the module's .ko file:
> > 
> >                 struct flock lock;
> >                 lock.l_type = F_WRLCK;
> >                 lock.l_whence = SEEK_SET;
> >                 lock.l_start = 0;
> >                 lock.l_len = 1;
> >                 fcntl(fd, F_SETLKW, &lock);
> > 
> > This leads to a deadlock when the loaded module calls
> > request_module() in its module_init() function, to load
> > a module which in turn depends on the first module.
> 
> My bug, I think.  Does this help?

Yes and no. The deadlock is gone, but now I get:

Nov 18 14:30:03 abc kernel: saa7130/34: v4l2 driver version 0.2.12 loaded
Nov 18 14:30:03 abc kernel: saa7134[0]: found at 0000:02:0c.0, rev: 1, irq: 20, latency: 64, mmio: 0xfeafec00
Nov 18 14:30:03 abc kernel: saa7134[0]: subsystem: 1131:6752, board: BMK MPEX Tuner [card=23,insmod option]
Nov 18 14:30:03 abc kernel: saa7134[0]: board init: gpio is 10000
Nov 18 14:30:04 abc kernel: saa7134[0]: i2c eeprom 00: 31 11 52 67 06 80 00 01 00 00 00 00 00 00 01 00
Nov 18 14:30:04 abc kernel: saa7134[0]: i2c eeprom 10: 00 ff c2 0f ff ff ff ff ff ff ff ff ff ff ff ff
Nov 18 14:30:04 abc kernel: saa7134[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Nov 18 14:30:04 abc kernel: saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Nov 18 14:30:04 abc kernel: saa7134[0]/irq[10,91590999]: r=0x4000 s=0x00 GPIO16?
Nov 18 14:30:04 abc kernel: saa7134[0]/irq: looping -- clearing all enable bits

(Maybe Gerd has an idea what's wrong with the irq.
BTW, Documentation/video4linux/CARDLIST.saa7134 is out of date wrt
drivers/media/video/saa7134/saa7134.h)

Nov 18 14:30:04 abc kernel: tuner: chip found at addr 0xc0 i2c-bus saa7134[0]
Nov 18 14:30:04 abc kernel: tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by saa7134[0]
Nov 18 14:30:04 abc udev[16759]: configured rule in '/etc/udev/rules.d/compat-full.rules' at line 29 applied, added symlNov 18 14:30:04 abc udev[16759]: configured rule in '/etc/udev/rules.d/devfs.rules' at line 70 applied, 'i2c-2' becomes Nov 18 14:30:04 abc udev[16759]: creating device node '/dev/i2c/2'
Nov 18 14:30:04 abc kernel: saa7134_empress: Unknown symbol saa7134_devlist
Nov 18 14:30:04 abc kernel: saa7134_empress: Unknown symbol saa7134_common_ioctl
Nov 18 14:30:04 abc kernel: saa7134_empress: Unknown symbol saa7134_boards
Nov 18 14:30:04 abc kernel: saa7134_empress: Unknown symbol saa7134_ts_register
Nov 18 14:30:04 abc kernel: saa7134_empress: Unknown symbol saa7134_print_ioctl
Nov 18 14:30:04 abc kernel: saa7134_empress: Unknown symbol saa7134_ts_qops
Nov 18 14:30:04 abc kernel: saa7134_empress: Unknown symbol saa7134_i2c_call_clients
Nov 18 14:30:04 abc kernel: saa7134_empress: Unknown symbol saa7134_ts_unregister
Nov 18 14:30:04 abc modprobe: FATAL: Error inserting saa7134_empress (/lib/modules/2.6.10-rc2/kernel/drivers/media/video/saa7134/saa7134-empress.ko): Unknown symbol in module, or unknown parameter (see dmesg)

However, the symbols are exported:

$ grep EXPORT_SYMBOL *.c
saa7134-core.c:EXPORT_SYMBOL(saa7134_ts_register);
saa7134-core.c:EXPORT_SYMBOL(saa7134_ts_unregister);
saa7134-core.c:EXPORT_SYMBOL(saa7134_print_ioctl);
saa7134-core.c:EXPORT_SYMBOL(saa7134_i2c_call_clients);
saa7134-core.c:EXPORT_SYMBOL(saa7134_devlist);
saa7134-core.c:EXPORT_SYMBOL(saa7134_boards);
saa7134-ts.c:EXPORT_SYMBOL_GPL(saa7134_ts_qops);
saa7134-video.c:EXPORT_SYMBOL(saa7134_common_ioctl);

If I 'modprobe saa7134-empress' manually after saa7134.ko is loaded, it works.

This is an unpatched 2.6.10-rc2 kernel, BTW.


Johannes

> --- modprobe.c.~70~	2004-09-30 20:16:19.000000000 +1000
> +++ modprobe.c	2004-11-18 14:44:57.000000000 +1100
> @@ -735,6 +735,11 @@
>  		       strip_vermagic, strip_modversion);
>  	}
>  
> +	/* Don't do ANYTHING if already in kernel. */
> +	if (!ignore_proc
> +	    && module_in_kernel(newname ?: mod->modname, NULL) == 1)
> +		goto exists_error;
> +
>  	fd = lock_file(mod->filename);
>  	if (fd < 0) {
>  		error("Could not open '%s': %s\n",
> @@ -742,11 +747,6 @@
>  		goto out_optstring;
>  	}
>  
> -	/* Don't do ANYTHING if already in kernel. */
> -	if (!ignore_proc
> -	    && module_in_kernel(newname ?: mod->modname, NULL) == 1)
> -		goto exists_error;
> -
>  	command = find_command(mod->modname, commands);
>  	if (command && !ignore_commands) {
>  		/* It might recurse: unlock. */
> @@ -799,7 +799,7 @@
>  	if (first_time)
>  		error("Module %s already in kernel.\n",
>  		      newname ?: mod->modname);
> -	goto out_unlock;
> +	goto out_optstring;
>  }
>  
>  /* Do recursive removal. */
> 
> -- 
> A bad analogy is like a leaky screwdriver -- Richard Braakman
> 
