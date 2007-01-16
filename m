Return-Path: <linux-kernel-owner+w=401wt.eu-S1751419AbXAPXfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbXAPXfh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 18:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbXAPXfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 18:35:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56215 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXAPXfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 18:35:36 -0500
Date: Tue, 16 Jan 2007 23:35:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kwatch: kernel watchpoints using CPU debug registers
Message-ID: <20070116233528.GA19834@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrew Morton <akpm@osdl.org>,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0701161153200.2276-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0701161153200.2276-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fir4st I'd say thanks a lot for forward-porting this, it's really useful
feature for all kinds of nasty debugging.

I think you should split this into two patches, one for the debugreg
infrastructure, and one for the actual kwatch code.

Also I think you provide one (or even a few) example wathes for
trivial things, say updating i_ino for an inode given through debugfs.

Some comments on the code below:

> --- /dev/null
> +++ usb-2.6/arch/i386/kernel/debugreg.c
> @@ -0,0 +1,182 @@
> +/*
> + *  Debug register
> + *  arch/i386/kernel/debugreg.c

Please don't put in comments that mention the name of the containing
file.  Also the "Debug register" comments seems rather useless.

> + * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> and
> + *		Bharata Rao <bharata@in.ibm.com> to provide debug register
> + *		allocation mechanism.
> + * 2004-Oct	Updated by Prasanna S Panchamukhi <prasanna@in.ibm.com> with
> + *		idr_allocations mechanism as suggested by Andi Kleen.

I think these kinds of comments aren't in fashion anymore either, all
changelogs should be in git commit messages and initial credits go
into the first commit message.

> +struct debugreg dr_list[DR_MAX];
> +static spinlock_t dr_lock = SPIN_LOCK_UNLOCKED;

I think you're supposed to use magic DEFINE_SPINLOCK macro these days.

> +unsigned long dr7_global_mask = DR_CONTROL_RESERVED | DR_GLOBAL_SLOWDOWN |
> +		DR_GLOBAL_ENABLE_MASK;

I'd rahter keep this static and make  set_process_dr7 a non-inline
function.

> +
> +static unsigned long dr7_global_reg_mask(unsigned int regnum)
> +{
> +	return (0xf << (16 + regnum * 4)) | (0x1 << (regnum * 2));
> +}
> +
> +static int get_dr(int regnum, int flag)
> +{
> +	if (flag == DR_ALLOC_GLOBAL && !dr_list[regnum].flag) {
> +		dr_list[regnum].flag = flag;
> +		dr7_global_mask |= dr7_global_reg_mask(regnum);
> +		return regnum;
> +	}
> +	if (flag == DR_ALLOC_LOCAL &&
> +			dr_list[regnum].flag != DR_ALLOC_GLOBAL) {
> +		dr_list[regnum].flag = flag;
> +		dr_list[regnum].use_count++;
> +		return regnum;
> +	}
> +	return -1;

This looks rather poorly structured, as the function does compltely
different things depending on the flags passed in.

> +static void free_dr(int regnum)
> +{
> +	if (dr_list[regnum].flag == DR_ALLOC_LOCAL) {
> +		if (!--dr_list[regnum].use_count)
> +			dr_list[regnum].flag = 0;
> +	} else {
> +		dr_list[regnum].flag = 0;
> +		dr_list[regnum].use_count = 0;
> +		dr7_global_mask &= ~(dr7_global_reg_mask(regnum));
> +	}
> +}

Same here.

> +int dr_alloc(int regnum, int flag)
> +{
> +	int ret = -1;
> +
> +	spin_lock(&dr_lock);
> +	if (regnum >= 0 && regnum < DR_MAX)
> +		ret = get_dr(regnum, flag);
> +	else if (regnum == DR_ANY) {
> +
> +		/* gdb allocates local debug registers starting from 0.
> +		 * To help avoid conflicts, we'll start from the other end.
> +		 */
> +		for (regnum = DR_MAX - 1; regnum >= 0; --regnum) {
> +			ret = get_dr(regnum, flag);
> +			if (ret >= 0)
> +				break;
> +		}
> +	} else
> +		printk(KERN_ERR "dr_alloc: "
> +				"Cannot allocate debug register %d\n", regnum);
> +	spin_unlock(&dr_lock);
> +	return ret;

I suspect this should be replaced wit ha global and local variant
to fix the above mentioned issue.  It's a tiny bit duplicated code,
but seems much cleaner.

> +static int get_dr(int regnum, int flag)
> +{
> +	if (flag == DR_ALLOC_GLOBAL && !dr_list[regnum].flag) {
> +		dr_list[regnum].flag = flag;
> +		dr7_global_mask |= dr7_global_reg_mask(regnum);
> +		return regnum;
> +	}
> +	if (flag == DR_ALLOC_LOCAL &&
> +			dr_list[regnum].flag != DR_ALLOC_GLOBAL) {
> +		dr_list[regnum].flag = flag;
> +		dr_list[regnum].use_count++;
> +		return regnum;
> +	}
> +	return -1;

Same comments about global vs local here.

> +
> +EXPORT_SYMBOL(dr_alloc);
> +EXPORT_SYMBOL(dr_free);

I don't think we want these exported at all, and if a proper modular
user shows up they should be _GPL as they're fairly lowlevel.

Btw, the naming in the whole debugregs code should be consolidated to
be debugreg_ instead of all kinds of different variants.

> +#ifdef CONFIG_KWATCH
> +
> +/* Set the type, len and global flag in dr7 for a debug register */
> +#define SET_DR7(dr, regnum, type, len)	do {		\
> +		dr &= ~(0xf << (16 + (regnum) * 4));	\
> +		dr |= (((((len) - 1) << 2) | (type)) <<	\
> +				(16 + (regnum) * 4)) |	\
> +			(0x2 << ((regnum) * 2));	\
> +	} while (0)
> +
> +/* Disable a debug register by clearing the global/local flag in dr7 */
> +#define RESET_DR7(dr, regnum)	dr &= ~(0x3 << ((regnum) * 2))

I don't think there's any point in making these macros conditional.
Then again is there a good reason to mke these macros?

> + *  Kernel Watchpoint interface.
> + *  arch/i386/kernel/kwatch.c
> + *
> + *
> + * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> for
> + *		Kernel Watchpoint implementation.
> + * 2004-Oct	Updated by Prasanna S Panchamukhi <prasanna@in.ibm.com> to
> + *		to make use of notifiers.
> + */

Same comments about these comments applies as in debugreg.c

> +#include <linux/kprobes.h>
> +#include <linux/ptrace.h>
> +#include <linux/spinlock.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <asm/kwatch.h>
> +#include <asm/kdebug.h>
> +#include <asm/debugreg.h>
> +#include <asm/bitops.h>

I think this should be linux/bitops.h these days.

> +
> +#define RF_MASK	0x00010000
> +
> +static struct kwatch kwatch_list[DR_MAX];
> +static spinlock_t kwatch_lock = SPIN_LOCK_UNLOCKED;



> +static unsigned long kwatch_in_progress;	/* currently being handled */

Give that this is a bitmap the comment is rather misleading, it should
probably be:

/*
 * Bitmap of registers beeing handled.
 */

> +static void write_dr(int debugreg, unsigned long addr)
> +{
> +	switch (debugreg) {
> +		case 0:	set_debugreg(addr, 0);	break;
> +		case 1:	set_debugreg(addr, 1);	break;
> +		case 2:	set_debugreg(addr, 2);	break;
> +		case 3:	set_debugreg(addr, 3);	break;
> +		case 6:	set_debugreg(addr, 6);	break;
> +		case 7:	set_debugreg(addr, 7);	break;
> +	}
> +}

What's the point of this wrapper?

> +
> +#define write_dr7(val)	set_debugreg((val), 7)
> +#define read_dr7(val)	get_debugreg((val), 7)

And these?

> +	if (kwatch_in_progress)
> +		goto recursed;
> +

I don't think there's any point in this goto, just handle it inside
the if block

> +	set_bit(debugreg, &kwatch_in_progress);
> +
> +	spin_lock(&kwatch_lock);
> +	if ((unsigned long) kwatch_list[debugreg].addr != addr)
> +		goto out;
> +
> +	if (kwatch_list[debugreg].handler)
> +		kwatch_list[debugreg].handler(&kwatch_list[debugreg], regs);
> +
> +	if (kwatch_list[debugreg].type == DR_TYPE_EXECUTE)
> +		regs->eflags |= RF_MASK;
> +      out:

Again, I think the goto here could be avoided and actually make the code
cleanere.  Also a local variable for kwatch_list[debugreg] with a short
would probably make this section of code a lot more readable.

> +
> +static int __init init_kwatch(void)
> +{
> +	int err = 0;
> +
> +	err = register_die_notifier(&kwatch_exceptions_nb);
> +	return err;
> +}

Just remove the err local variable here.

> +EXPORT_SYMBOL_GPL(register_kwatch);
> +EXPORT_SYMBOL_GPL(unregister_kwatch);

Please move these exports close to the actual function definition.

> --- /dev/null
> +++ usb-2.6/include/asm-i386/kwatch.h
> @@ -0,0 +1,60 @@
> +#ifndef _ASM_KWATCH_H
> +#define _ASM_KWATCH_H
> +/*
> + *  Kernel Watchpoint interface.
> + *  include/asm-i386/kwatch.h

> + * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> for
> + *		Kernel Watchpoint implementation.
> + */

Same comments once again.

> +#include <linux/types.h>
> +#include <linux/ptrace.h>
> +
> +struct kwatch;
> +typedef void (*kwatch_handler_t) (struct kwatch *, struct pt_regs *);
> +
> +struct kwatch {
> +	void *addr;		/* location of watchpoint */
> +	u8 length;		/* range of address */
> +	u8 type;		/* type of watchpoint */
> +	kwatch_handler_t handler;
> +};
> +
> +#define DR_TYPE_EXECUTE 	0x0	/* Watchpoint types */
> +#define DR_TYPE_WRITE		0x1
> +#define DR_TYPE_IO		0x2
> +#define DR_TYPE_RW		0x3

I think large parts of this header should go into a new linux/kwatch.h
so that generic code can use kwatches.

> +config KWATCH
> +	bool "Kwatch points (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL
> +	help
> +	  Kwatch enables kernel-space data watchpoints using the processor's
> +	  debug registers.  It can be very useful for kernel debugging.
> +	  If in doubt, say "N".

I think we want different options for debugregs and kwatch.  The debugreg
one probably doesn't have to be actually user-visible, though.
