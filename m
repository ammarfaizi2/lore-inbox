Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262444AbTCMPC6>; Thu, 13 Mar 2003 10:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbTCMPC6>; Thu, 13 Mar 2003 10:02:58 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:19588 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262444AbTCMPCO>; Thu, 13 Mar 2003 10:02:14 -0500
Date: Thu, 13 Mar 2003 15:10:33 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mb800 watchdog driver
Message-ID: <20030313161033.GA8751@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1047543064.16975.23.camel@gregs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047543064.16975.23.camel@gregs>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 08:11:04AM +0000, Grzegorz Jaskiewicz wrote:
 > 
 > I've wrote small driver for mb800 motherboards (x86, intel). And i want
 > to share with others. 
 > Any comments/patches are welcome.


> #include <sys/syscall.h>

not needed.
 
> #include <linux/version.h>

not needed.

> #include <linux/errno.h>            
> #include <linux/stddef.h>           

not needed.

> #include <asm/page.h>               
> #include <asm/pgtable.h>            

not needed.

> #ifdef CONFIG_DEVFS_FS
> #include <linux/devfs_fs_kernel.h>
> #else
> #error "this driver requires devfs, otherwise it would not work - sorry dude"
> #endif

devfs only drivers == EVIL. Pure EVIL.

> spinlock_t tab_lock;

can be static

> static struct proc_dir_entry *proc_mtd;
> int tab_o_count;

unused

>static struct file_operations tabfs = {
>    owner   : THIS_MODULE,
>    open    : open_wdog,      /* open */
>    write   : write_wdog,	/* write */
>    release : close_wdog,   /* release */
> };

use C99  .owner = THIS_MODULE
Ok, this is a 2.4 driver, but it makes forward porting simpler.
Also, the comments are pointless.

> void LockChip()
> void UnLockChip()

can be static (as can most other functions in this file)

>/*
>    if (check_region(0x2e, 2)){
>	printk(KERN_INFO "tab: my I/O space is allready in use, can't share it .. sorry\n");
>	return -1;
>    }
>
>    request_region(0x2e, 2, "mb800 watchdog");
>*/    

1. Probably shouldn't be commented out.
2. Don't use check_region, just check return of request_region.

>    printk(KERN_INFO "watchdog: DIE !!!\n");

Something more userfriendly "mb8wdog: unloading\n" would be nicer.

>	printk(KERN_INFO "MB800 WATCHDOG: LOAD DEVICE ENDED\n");

KERN_DEBUG ? and STOP SHOUTING!

>	printk(KERN_INFO "MB800 WATCHDOG: ENTER CREATE DISPATCH\n");

in fact, these printk's should probably be something like dprintk's
with dprintk being defined at the top of source like..

#define DEBUG
#ifndef DEBUG
# define dprintk(format, args...)
#else
# define dprintk(format, args...) printk(KERN_DEBUG "mb8wdog:", ## args)
#endif

>    if (copy_from_user(&b, buf, 1)){
>	return -EFAULT;
>    }
>
>    if (b){    
>	EnableAndSetWatchdog(b);
>    }
>    else{
>	DisableWatchdog();
>    }

Please choose one indentation style, and stick to it.
Preferably the one described in Documenation/CodingStyle

	if (b) {
		EnableAndSetWatchdog(b);
	} else {
		DisableWatchdog();
	}

Other than these small nits, I don't see any problems with it.
The biggest issue is the devfs-only requirement, which as I mentioned,
is really evil, and afaics, totally unnecessary.

		Dave
