Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbSJDTc1>; Fri, 4 Oct 2002 15:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261794AbSJDTc1>; Fri, 4 Oct 2002 15:32:27 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:59534 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261553AbSJDTc0>; Fri, 4 Oct 2002 15:32:26 -0400
Date: Fri, 4 Oct 2002 15:37:55 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: bidulock@openss7.org
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021004153755.A1116@devserv.devel.redhat.com>
References: <1033684027.1247.43.camel@phantasy.suse.lists.linux.kernel> <20021003233504.GA20570@suse.de.suse.lists.linux.kernel> <20021003235022.GA82187@compsoc.man.ac.uk.suse.lists.linux.kernel> <mailman.1033691043.6446.linux-kernel2news@redhat.com.suse.lists.linux.kerne <200210040403.g9443Vu03329@devserv.devel.redhat.com.suse.lists.linux.kernel> <20021003233221.C31444@openss7.org.suse.lists.linux.kernel> <20021004133657.B17216@devserv.devel.redhat.com.suse.lists.linux.kernel> <p73fzvmqdg4.fsf@oldwotan.suse.de> <1033757193.31839.51.camel@irongate.swansea.linux.org.uk> <20021004131547.B2369@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004131547.B2369@openss7.org>; from bidulock@openss7.org on Fri, Oct 04, 2002 at 01:15:47PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 4 Oct 2002 13:15:47 -0600
> From: "Brian F. G. Bidulock" <bidulock@openss7.org>

> Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
> 	Andi Kleen <ak@suse.de>, Pete Zaitcev <zaitcev@redhat.com>,
> 	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

You headers are a little broken - you should include yourself.

> > AFS patches a collection of random syscalls in pretty icky ways. Again
> > afssyscall wants doing the right way - with a kernel stub like NFS has

> Attached is an untested patch for LiS.

How about attaching a tested patch? At unit testing level at least?

> + EXPORT_SYMBOL(register_streams_calls);
> + EXPORT_SYMBOL(unregister_streams_calls);

Isn't it EXPORT_SYMBOL_GPL? Otherwise you are just making general
override hooks.

> + static rwlock_t streams_call_lock = RW_LOCK_UNLOCKED;

Personally, I STONGLY disagree with people who put RW locks
everywhere by default. It's your decision though.

> + long asmlinkage sys_putpmsg(int fd, void *ctlptr, void *datptr, int band, int flags)
> + {
> + 	int ret = -ENOSYS;
> + 	read_lock(&streams_call_lock);
> + 	if (do_putpmsg)
> + 		ret = (*do_putpmsg) (fd, ctrlptr, datptr, band, flags);
> + 	read_unlock(&streams_call_lock);
> + 	return ret;
> + }

Can you sleep in putmsg? Not even for kmalloc?
Just get the pointer into a local variable.

> Index: include/asm-sparc/unistd.h
> ***************
> *** 166,173 ****
>   #define __NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
>   #define __NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
>   #define __NR_getsockname        150 /* Common                                      */
> ! /* #define __NR_getmsg          151    SunOS Specific                              */
> ! /* #define __NR_putmsg          152    SunOS Specific                              */
>   #define __NR_poll               153 /* Common                                      */
>   #define __NR_getdents64		154 /* Linux specific				   */
>   #define __NR_fcntl64		155 /* Linux sparc32 Specific                      */
> --- 166,173 ----
>   #define __NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
>   #define __NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
>   #define __NR_getsockname        150 /* Common                                      */
> ! #define __NR_getpmsg		151 /* Common					   */
> ! #define __NR_putpmsg		152 /* Common					   */
>   #define __NR_poll               153 /* Common                                      */
>   #define __NR_getdents64		154 /* Linux specific				   */
>   #define __NR_fcntl64		155 /* Linux sparc32 Specific                      */

I can take it if you make an oath that arguments are compatible
to SVR4 and SunOS.

-- Pete
