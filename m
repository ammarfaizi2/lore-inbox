Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbVJSGag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbVJSGag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 02:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbVJSGag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 02:30:36 -0400
Received: from host-84-9-201-132.bulldogdsl.com ([84.9.201.132]:52868 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1751548AbVJSGaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 02:30:35 -0400
Date: Wed, 19 Oct 2005 07:30:19 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: Arthur Othieno <a.othieno@bluewin.ch>
Cc: Ben Dooks <ben@fluff.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - create common header for init/main.c called init functions
Message-ID: <20051019063019.GB32720@home.fluff.org>
References: <20051014004210.GA3095@home.fluff.org> <20051018231109.GA15443@krypton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018231109.GA15443@krypton>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 07:11:09PM -0400, Arthur Othieno wrote:
> On Fri, Oct 14, 2005 at 01:42:10AM +0100, Ben Dooks wrote:
> > init/main.c calls a number of functions externally
> > but declaring them locally. This patch creates a
> > new header (linux/kernel_init.h) and moves all
> > the declarations into it.
> 
> These functions are only referenced in init/main.c, and rightfully so.
> In the end, this doesn't change anything much, other than maintainance
> overhead for the new include/linux/kernel_init.h

Yes, but they generate warnings from sparse, and there
are currently quite a lot of them.

Maybe the patch should move the init functions into their
respective header files, i'll look at sortig that out and
re-issuing them.
 
> But, comments within..
> 
> > Also removes any old init functions now done by
> > an initcall()
> 
> (mca|sbus|tc)_init() removal look good.
> 
> > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/drivers/acpi/bus.c linux-2.6.14-rc4-bjd3c/drivers/acpi/bus.c
> > --- linux-2.6.14-rc4-bjd3b/drivers/acpi/bus.c	2005-10-11 10:56:31.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/drivers/acpi/bus.c	2005-10-14 01:32:27.000000000 +0100
> > @@ -30,6 +30,7 @@
> >  #include <linux/pm.h>
> >  #include <linux/device.h>
> >  #include <linux/proc_fs.h>
> > +#include <linux/kernel_init.h>
> 
> Unecessary, acpi_early_init() defined here.

I missed the actual definition, but, you notice it is
wrappered in `CONFIG_X86`, which isn't much used on non X86
systems.

> >  #ifdef CONFIG_X86
> >  #include <asm/mpspec.h>
> >  #endif
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/drivers/base/init.c linux-2.6.14-rc4-bjd3c/drivers/base/init.c
> > --- linux-2.6.14-rc4-bjd3b/drivers/base/init.c	2005-10-13 15:27:05.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/drivers/base/init.c	2005-10-14 01:29:35.000000000 +0100
> > @@ -9,6 +9,7 @@
> >  
> >  #include <linux/device.h>
> >  #include <linux/init.h>
> > +#include <linux/kernel_init.h>
> 
> Ditto driver_init().
> 
> >  #include "base.h"
> >  
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/fs/buffer.c linux-2.6.14-rc4-bjd3c/fs/buffer.c
> > --- linux-2.6.14-rc4-bjd3b/fs/buffer.c	2005-10-11 10:56:33.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/fs/buffer.c	2005-10-14 01:36:06.000000000 +0100
> > @@ -19,7 +19,9 @@
> >   */
> >  
> >  #include <linux/config.h>
> > +#include <linux/init.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kernel_init.h>
> 
> Ditto buffer_init().

not a header file
 
> >  #include <linux/syscalls.h>
> >  #include <linux/fs.h>
> >  #include <linux/mm.h>
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/include/linux/kernel_init.h linux-2.6.14-rc4-bjd3c/include/linux/kernel_init.h
> > --- linux-2.6.14-rc4-bjd3b/include/linux/kernel_init.h	1970-01-01 01:00:00.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/include/linux/kernel_init.h	2005-10-14 01:34:28.000000000 +0100
> > @@ -0,0 +1,26 @@
> 
> #ifndef _LINUX_KERNEL_INIT_H
> #define _LINUX_KERNEL_INIT_H
> 
> > +/* include/linux/kernel_init.h
> > + *
> > + * (C) 2005 Simtec Electronics
> > + *	Ben Dooks <ben@simtec.co.uk>
> 
> A little too much, no? This is only moving existing stuff around..
> 
> > + *
> > + * Initialisation function prototypes
> > +*/
> > +
> > +extern void init_IRQ(void);
> > +extern void __init fork_init(unsigned long);
> > +extern void __init signals_init(void);
> > +extern void __init buffer_init(void);
> > +extern void __init driver_init(void);
> > +extern void __init pidhash_init(void);
> > +extern void __init pidmap_init(void);
> > +extern void __init prio_tree_init(void);
> > +extern void __init populate_rootfs(void);
> > +extern void __init prepare_namespace(void);
> 
> extern void foo_init(void) __init;
> 
> > +
> > +extern void free_initmem(void);
> > +
> > +#ifdef	CONFIG_ACPI
> > +extern void __init acpi_early_init(void);
> > +#else
> > +static inline void acpi_early_init(void) { }
> > +#endif
> 
> #endif /* _LINUX_KERNEL_INIT_H */
> 
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/init/do_mounts.c linux-2.6.14-rc4-bjd3c/init/do_mounts.c
> > --- linux-2.6.14-rc4-bjd3b/init/do_mounts.c	2005-10-11 10:56:34.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/init/do_mounts.c	2005-10-14 01:31:42.000000000 +0100
> > @@ -8,6 +8,7 @@
> >  #include <linux/security.h>
> >  #include <linux/delay.h>
> >  #include <linux/mount.h>
> > +#include <linux/kernel_init.h>
> 
> Unecessary, prepare_namespace() defined here.

not a header file
 
> >  #include <linux/nfs_fs.h>
> >  #include <linux/nfs_fs_sb.h>
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/init/initramfs.c linux-2.6.14-rc4-bjd3c/init/initramfs.c
> > --- linux-2.6.14-rc4-bjd3b/init/initramfs.c	2005-10-11 23:47:02.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/init/initramfs.c	2005-10-14 01:29:01.000000000 +0100
> > @@ -6,6 +6,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/string.h>
> >  #include <linux/syscalls.h>
> > +#include <linux/kernel_init.h>
> 
> Ditto populate_rootfs().
> 
> >  static __initdata char *message;
> >  static void __init error(char *x)
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/init/main.c linux-2.6.14-rc4-bjd3c/init/main.c
> > --- linux-2.6.14-rc4-bjd3b/init/main.c	2005-10-11 10:56:34.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/init/main.c	2005-10-14 01:35:11.000000000 +0100
> > @@ -17,6 +17,7 @@
> >  #include <linux/proc_fs.h>
> >  #include <linux/devfs_fs_kernel.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kernel_init.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/string.h>
> >  #include <linux/ctype.h>
> > @@ -47,8 +48,11 @@
> >  #include <linux/rmap.h>
> >  #include <linux/mempolicy.h>
> >  #include <linux/key.h>
> > +#include <linux/sysctl.h>
> >  #include <net/sock.h>
> >  
> > +#include <linux/radix-tree.h>
> > +
> 
> No need for the extra whitespace, could have as well gone right below
> <linux/sysctl.h>
> 
> >  #include <asm/io.h>
> >  #include <asm/bugs.h>
> >  #include <asm/setup.h>
> > @@ -80,30 +84,7 @@
> >  
> >  static int init(void *);
> >  
> > -extern void init_IRQ(void);
> > -extern void fork_init(unsigned long);
> > -extern void mca_init(void);
> > -extern void sbus_init(void);
> > -extern void sysctl_init(void);
> > -extern void signals_init(void);
> > -extern void buffer_init(void);
> > -extern void pidhash_init(void);
> > -extern void pidmap_init(void);
> > -extern void prio_tree_init(void);
> > -extern void radix_tree_init(void);
> > -extern void free_initmem(void);
> > -extern void populate_rootfs(void);
> > -extern void driver_init(void);
> > -extern void prepare_namespace(void);
> > -#ifdef	CONFIG_ACPI
> > -extern void acpi_early_init(void);
> > -#else
> > -static inline void acpi_early_init(void) { }
> > -#endif
> >  
> > -#ifdef CONFIG_TC
> > -extern void tc_init(void);
> > -#endif
> >  
> >  enum system_states system_state;
> >  EXPORT_SYMBOL(system_state);
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/kernel/fork.c linux-2.6.14-rc4-bjd3c/kernel/fork.c
> > --- linux-2.6.14-rc4-bjd3b/kernel/fork.c	2005-10-11 10:56:34.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/kernel/fork.c	2005-10-14 01:18:16.000000000 +0100
> > @@ -42,6 +42,7 @@
> >  #include <linux/profile.h>
> >  #include <linux/rmap.h>
> >  #include <linux/acct.h>
> > +#include <linux/kernel_init.h>
> 
> Unecessary, fork_init() defined here.

not a header file!
 
> >  #include <asm/pgtable.h>
> >  #include <asm/pgalloc.h>
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/kernel/pid.c linux-2.6.14-rc4-bjd3c/kernel/pid.c
> > --- linux-2.6.14-rc4-bjd3b/kernel/pid.c	2005-06-17 20:48:29.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/kernel/pid.c	2005-10-14 01:24:27.000000000 +0100
> > @@ -26,6 +26,7 @@
> >  #include <linux/init.h>
> >  #include <linux/bootmem.h>
> >  #include <linux/hash.h>
> > +#include <linux/kernel_init.h>
> 
> Ditto pid(map|hash)_init().
> 
> >  #define pid_hashfn(nr) hash_long((unsigned long)nr, pidhash_shift)
> >  static struct hlist_head *pid_hash[PIDTYPE_MAX];
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/kernel/signal.c linux-2.6.14-rc4-bjd3c/kernel/signal.c
> > --- linux-2.6.14-rc4-bjd3b/kernel/signal.c	2005-10-11 10:56:34.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/kernel/signal.c	2005-10-14 01:22:16.000000000 +0100
> > @@ -25,6 +25,7 @@
> >  #include <linux/posix-timers.h>
> >  #include <linux/signal.h>
> >  #include <linux/audit.h>
> > +#include <linux/kernel_init.h>
> 
> Ditto signals_init().

hmm, 
 
> >  #include <asm/param.h>
> >  #include <asm/uaccess.h>
> >  #include <asm/unistd.h>
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/lib/prio_tree.c linux-2.6.14-rc4-bjd3c/lib/prio_tree.c
> > --- linux-2.6.14-rc4-bjd3b/lib/prio_tree.c	2005-06-17 20:48:29.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/lib/prio_tree.c	2005-10-14 01:27:04.000000000 +0100
> > @@ -14,6 +14,7 @@
> >  #include <linux/init.h>
> >  #include <linux/mm.h>
> >  #include <linux/prio_tree.h>
> > +#include <linux/kernel_init.h>
> 
> Ditto prio_tree_init().

aha

> >  /*
> >   * A clever mix of heap and radix trees forms a radix priority search tree (PST)
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/lib/radix-tree.c linux-2.6.14-rc4-bjd3c/lib/radix-tree.c
> > --- linux-2.6.14-rc4-bjd3b/lib/radix-tree.c	2005-10-11 10:56:34.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/lib/radix-tree.c	2005-10-14 01:27:21.000000000 +0100
> > @@ -21,6 +21,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kernel_init.h>
> 
> Ditto radix_tree_init(), and already prototyped in include/linux/radix-tree.h:

ok, missed that one

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
