Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSJDTV2>; Fri, 4 Oct 2002 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261820AbSJDTV2>; Fri, 4 Oct 2002 15:21:28 -0400
Received: from ns.suse.de ([213.95.15.193]:40208 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261669AbSJDTV0>;
	Fri, 4 Oct 2002 15:21:26 -0400
Date: Fri, 4 Oct 2002 21:26:59 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: bidulock@openss7.org
Subject: Re: export of sys_call_table
Message-ID: <20021004212659.A18954@wotan.suse.de>
References: <1033684027.1247.43.camel@phantasy.suse.lists.linux.kernel> <20021003233504.GA20570@suse.de.suse.lists.linux.kernel> <20021003235022.GA82187@compsoc.man.ac.uk.suse.lists.linux.kernel> <mailman.1033691043.6446.linux-kernel2news@redhat.com.suse.lists.linux.kerne <200210040403.g9443Vu03329@devserv.devel.redhat.com.suse.lists.linux.kernel> <20021003233221.C31444@openss7.org.suse.lists.linux.kernel> <20021004133657.B17216@devserv.devel.redhat.com.suse.lists.linux.kernel> <p73fzvmqdg4.fsf@oldwotan.suse.de> <1033757193.31839.51.camel@irongate.swansea.linux.org.uk> <20021004131547.B2369@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004131547.B2369@openss7.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 01:15:47PM -0600, Brian F. G. Bidulock wrote:
> Alan,
> 
> On Fri, 04 Oct 2002, Alan Cox wrote:
> > 
> > AFS patches a collection of random syscalls in pretty icky ways. Again
> > afssyscall wants doing the right way - with a kernel stub like NFS has
> > 
> 
> Attached is an untested patch for LiS.  AK doesn't like the read/write_lock.
> AFAIK it will work for LiS but might not work for AFS.  Also LiS doesn't need
> module load like nfsd, perhaps afs does.  If someone could add an afs patch we
> could kill these two birds with one stone.  Patch is against 2.4.18 but should
> move up fine.
> 
> --brian
> 
>  kernel/ksyms.c                |    2 ++
>  kernel/sys.c                  |   39 +++++++++++++++++++++++++++++++++++++++
>  arch/alpha/kernel/entry.S     |    2 ++
>  arch/arm/kernel/calls.S       |    4 !!!!
>  arch/cris/kernel/entry.S      |    4 !!!!
>  arch/i386/kernel/entry.S      |    4 !!!!
>  arch/ia64/kernel/entry.S      |    4 !!!!
>  arch/m68k/kernel/entry.S      |    4 !!!!
>  arch/mips/kernel/syscalls.h   |    4 !!!!
>  arch/mips64/kernel/scall_64.S |    4 !!!!
>  arch/parisc/kernel/syscall.S  |    4 !!!!
>  arch/ppc/kernel/misc.S        |    4 !!!!
>  arch/s390/kernel/entry.S      |    4 !!!!
>  arch/s390x/kernel/entry.S     |    4 !!!!
>  arch/sh/kernel/entry.S        |    4 !!!!
>  arch/sparc/kernel/systbls.S   |    4 !!!!
>  arch/sparc64/kernel/systbls.S |    6 !!!!!!
>  include/asm-alpha/unistd.h    |    2 ++
>  include/asm-arm/unistd.h      |    4 !!!!
>  include/asm-sh/unistd.h       |    4 !!!!
>  include/asm-sparc/unistd.h    |    4 !!!!
>  include/asm-sparc64/unistd.h  |    4 !!!!
>  22 files changed, 45 insertions(+), 74 modifications(!)
> 
> 
> Index: kernel/ksyms.c
> ===================================================================
> RCS file: /home/common/cvsroot/linux/kernel/ksyms.c,v
> retrieving revision 1.1.3.1
> diff -c -r1.1.3.1 ksyms.c
> *** kernel/ksyms.c	25 Feb 2002 19:38:13 -0000	1.1.3.1
> --- kernel/ksyms.c	4 Oct 2002 17:17:09 -0000
> ***************
> *** 469,474 ****
> --- 469,476 ----
>   #ifndef __mips__
>   EXPORT_SYMBOL(sys_call_table);
>   #endif
> + EXPORT_SYMBOL(register_streams_calls);
> + EXPORT_SYMBOL(unregister_streams_calls);
>   EXPORT_SYMBOL(machine_restart);
>   EXPORT_SYMBOL(machine_halt);
>   EXPORT_SYMBOL(machine_power_off);
> Index: kernel/sys.c
> ===================================================================
> RCS file: /home/common/cvsroot/linux/kernel/sys.c,v
> retrieving revision 1.1.3.1
> diff -c -r1.1.3.1 sys.c
> *** kernel/sys.c	25 Feb 2002 19:38:13 -0000	1.1.3.1
> --- kernel/sys.c	4 Oct 2002 18:45:03 -0000
> ***************
> *** 167,172 ****
> --- 167,211 ----
>   	return notifier_chain_unregister(&reboot_notifier_list, nb);
>   }
>   
> + static int (*do_putpmsg) (int, void *, void *, int, int) = NULL;
> + static int (*do_getpmsg) (int, void *, void *, int, int) = NULL;
> + 
> + static rwlock_t streams_call_lock = RW_LOCK_UNLOCKED;
> + 
> + long asmlinkage sys_putpmsg(int fd, void *ctlptr, void *datptr, int band, int flags)
> + {
> + 	int ret = -ENOSYS;
> + 	read_lock(&streams_call_lock);

Really you cannot use a spinlock here, because that would disallow
do_putpmsg from ever sleeping. Please review the mails I wrote 
earlier.

Either use atomic_inc(&some_counter) or a rw semaphore. I would likely
choose the atomic_inc. Alternatively you could use the RCU infrastructure
and stick a synchronize_kernel into module unload, then everything
would be fine too.

> + 	if (do_putpmsg)
> + 		ret = (*do_putpmsg) (fd, ctrlptr, datptr, band, flags);
> + 	read_unlock(&streams_call_lock);
> + 	return ret;

Same problem in the other stubs.

-Andi

