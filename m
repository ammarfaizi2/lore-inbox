Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318643AbSHPSY0>; Fri, 16 Aug 2002 14:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318649AbSHPSY0>; Fri, 16 Aug 2002 14:24:26 -0400
Received: from smtpout.mac.com ([204.179.120.86]:29155 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S318643AbSHPSYZ>;
	Fri, 16 Aug 2002 14:24:25 -0400
Date: Fri, 16 Aug 2002 20:27:12 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [RFD]replace save_flags();cli(); with spin_lock_irqsave
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C8181396-B145-11D6-8C8C-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a large patch (>130KB) against 2.5.31 converting most of oss 
sound drivers to
use spinlocks instead of cli() - so that they compile on SMP systems.

Most changes are trivial but I think some drivers are simply not SMP 
safe. I hope I haven't
break any drivers. Since one can argue that OSS in the kernel gets 
obsolete and there are
no maintainers for individual drivers I would  prefer NOT to split the 
patches for each
individual driver.

Some like the GUS driver and the dmabuf.c were more complicated - I had 
to change the
locking a lot. Now if I grep through the kernel source with

/usr/src/linux-2.5.31:>find . -name "*.c"| xargs egrep 'cli[ \t]*\(\)' | 
wc -l
    1838

Is the usage of cli() really obsolete? Will all occurences will be fixed 
as stated in

/usr/src/linux-2.5.31/include/linux/interrupt.h
/*
  * Temporary defines for UP kernels, until all code gets fixed.
  */
#if !CONFIG_SMP
# define cli()                  local_irq_disable()
# define sti()                  local_irq_enable()
# define save_flags(x)          local_irq_save(x)
# define restore_flags(x)       local_irq_restore(x)
# define save_and_cli(x)        local_irq_save_off(x)
#endif

