Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314128AbSESEQD>; Sun, 19 May 2002 00:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314132AbSESEQD>; Sun, 19 May 2002 00:16:03 -0400
Received: from slip-202-135-75-36.ca.au.prserv.net ([202.135.75.36]:9355 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314128AbSESEQB>; Sun, 19 May 2002 00:16:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: kernel-janitor-discuss@lists.sourceforge.net
Subject: AUDIT of 2.5.15 copy_to/from_user
Date: Sun, 19 May 2002 14:18:53 +1000
Message-Id: <E179IA6-0002eQ-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following uses seem to be incorrect: copy_from_user and
copy_to_user return the number of bytes NOT copied on failure, not
-EFAULT.

You can CC: fixups to trivial at rustcorp.com.au.

(I didn't look for cases where the Torvalds/McVoy philosophy says we
should be returning a partial result on EFAULT: that's more complex).

Thanks,
Rusty.
================
Some cases are endemic: whole subsystems or drivers where the author
obviously thought copy_from_user follows the kernel conventions:

Whole Subsystems:
fs/intermezzo/*.c
sound/oss/*.c
sound/pci/*.c

Whole Drivers:
drivers/block/DAC960.c
drivers/block/cpqarray.c
drivers/block/swim3.c
drivers/block/swim_iop.c
drivers/char/rio/rioctrl.c
drivers/char/raw.c
drivers/isdn/icn/icn.c
drivers/isdn/capi/capi.c
drivers/isdn/capi/kcapi.c
drivers/isdn/sc/command.c
drivers/isdn/sc/ioctl.c
drivers/isdn/act2000/module.c
drivers/isdn/divert/divert_procfs.c
drivers/sbus/char/openprom.c
drivers/usb/class/audio.c
drivers/tc/zs.c
drivers/ieee1394/pcilynx.c
drivers/s390/misc/chandev.c
drivers/usb/input/hiddev.c
drivers/usb/media/dabusb.c

Lines:
drivers/char/nwflash.c:158:		ret = copy_to_user(buf, (void *)(FLASH_BASE + p), count);
drivers/scsi/scsi_ioctl.c:383:        return copy_to_user(arg, dev->host->pci_dev->slot_name,
drivers/sgi/char/sgiserial.c:1239:	return copy_to_user(retinfo,&tmp,sizeof(*retinfo));
drivers/usb/misc/auerswald.c:1556:		ret = copy_to_user(devinfo.buf, cp->dev_desc, u);
arch/i386/kernel/signal.c:37:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/sparc/kernel/signal.c:101:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/alpha/kernel/signal.c:44:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/sparc/kernel/sys_sunos.c:481:	ret = copy_to_user(&name->sname[0], &system_utsname.sysname[0], sizeof(name->sname) - 1);
arch/mips/kernel/signal.c:45:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/ppc/kernel/signal.c:70:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/m68k/kernel/signal.c:198:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/sparc64/kernel/sys_sparc32.c:3675:	return copy_to_user(res32, kres, sizeof(*res32));
arch/sparc64/kernel/signal.c:49:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/arm/kernel/signal.c:62:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/sh/kernel/signal.c:42:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/ia64/kernel/signal.c:147:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/mips64/kernel/linux32.c:1537:	err |= __copy_from_user (p->mtext, &up->mtext, second);
arch/mips64/kernel/signal.c:45:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/s390/kernel/debug.c:458:			if ((rc = copy_to_user(user_buf + count, 
arch/s390/kernel/ptrace.c:119:			retval=copy_from_user((void *)realuseraddr,(void *)copyaddr,len);
arch/s390/kernel/ptrace.c:345:		if((ret=copy_from_user(&parea,(void *)addr,sizeof(parea)))==0)  
arch/s390/kernel/signal.c:57:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/parisc/kernel/signal.c:44:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/cris/kernel/signal.c:51:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/s390x/kernel/debug.c:458:			if ((rc = copy_to_user(user_buf + count, 
arch/s390x/kernel/ptrace.c:119:			retval = copy_from_user(realuserptr, copyptr, len);
arch/s390x/kernel/ptrace.c:360:		if((ret=copy_from_user(&parea,(void *)addr,sizeof(parea)))==0)  
arch/cris/kernel/signal.c:51:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/x86_64/ia32/ia32_signal.c:48:		return __copy_to_user(to, from, sizeof(siginfo_t));
arch/x86_64/ia32/sys_ia32.c:2362:		ret = copy_to_user(name->machine, "i386\0\0", 8);
arch/x86_64/ia32/sys_ia32.c:2971:	return copy_to_user(res32, kres, sizeof(*res32));
arch/x86_64/kernel/signal.c:47:		return __copy_to_user(to, from, sizeof(siginfo_t));
sound/isa/sb/sb16_csp.c:218:		err = copy_to_user((void *) arg, &info, sizeof(info));
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
