Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbTIRH1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 03:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbTIRH1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 03:27:50 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:31503 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262994AbTIRH1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 03:27:43 -0400
Date: Thu, 18 Sep 2003 08:27:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: akpm@osdl.org, pfg@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix console driver
Message-ID: <20030918082738.B12519@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
	pfg@sgi.com, linux-kernel@vger.kernel.org
References: <20030917222414.GA25931@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030917222414.GA25931@sgi.com>; from jbarnes@sgi.com on Wed, Sep 17, 2003 at 03:24:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 03:24:14PM -0700, Jesse Barnes wrote:
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.

This seems to be a restriction not compatible with the GPL.  And it looks
like many SGI files in the tree have it aswell..

> +#include <linux/console.h>
> +#include <linux/module.h>
> +#ifdef CONFIG_MAGIC_SYSRQ
> +#include <linux/sysrq.h>
> +#endif

Please include it unconditionally.

> +#include <asm/sn/sn_sal.h>
> +#include <asm/sn/pci/pciio.h>		/* this is needed for snia_get_console_nasid */
> +#include <asm/sn/nodepda.h>
> +#include <asm/sn/simulator.h>
> +#include <asm/sn/sn2/intr.h>
> +#include <asm/sn/sn2/sn_private.h>
> +#include <asm/sn/clksupport.h>

Yuck.  Do you really need all these crufty includes?

> +#ifdef CONFIG_KDB
> +#include <linux/kdb.h>
> +#include <linux/serial_reg.h>

Keith doesn't like kdb code hitting mainline...

> +static char *serial_revdate = "2003-09-10";

This gets out of sync easily if someone external modifies the driver,
don't do it.

> +
> +#define snia_get_console_nasid	get_console_nasid

Another level of obsfuction?

> +/* event types for our task queue -- so far just one */
> +#define SN_SAL_EVENT_WRITE_WAKEUP 0

So kill this layher of indirection?

> +#define CONSOLE_RESTART 0

When will this be enabled?


> +
> +/* 64K, when we're asynch, it must be at least printk's LOG_BUF_LEN to
> + * avoid losing chars, (always has to be a power of 2) */
> +#if 1
> +#define SN_SAL_BUFFER_SIZE (64 * (1 << 10))
> +#else
> +#define SN_SAL_BUFFER_SIZE (64)
> +#endif

Why keep the #if 0?

> +
> +#define SN_SAL_UART_FIFO_DEPTH 16
> +#define SN_SAL_UART_FIFO_SPEED_CPS 9600/10
> +
> +/* we don't kmalloc/get_free_page these as we want them available
> + * before either of those are initialized */
> +static volatile char sn_xmit_buff_mem[SN_SAL_BUFFER_SIZE];
> +
> +struct volatile_circ_buf {
> +	volatile char *cb_buf;
> +	int cb_head;
> +	int cb_tail;
> +};
> +
> +static volatile struct volatile_circ_buf xmit = { .cb_buf = sn_xmit_buff_mem };
> +static char sn_tmp_buffer[SN_SAL_BUFFER_SIZE];
> +
> +static volatile struct tty_struct *sn_sal_tty;

Please do proper locking instread of volatile abuse.

> +
> +/* The early printk (possible setup) and function call */
> +
> +void
> +early_printk_sn_sal(const char *s, unsigned count)
> +{
> +	extern void early_sn_setup(void);
> +

there is not early printk in mainline, only in the ia64 tree, isn't it?

> +/*********************************************************************
> + * Interrupt handling routines.
> + */

Please fix the comment format.

> +
> +static irqreturn_t
> +sn_sal_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	/* this call is necessary to pass the interrupt back to the
> +	 * SAL, since it doesn't intercept the UART interrupts
> +	 * itself */
> +	int status = ia64_sn_console_intr_status();
> +
> +	spin_lock(&sn_sal_lock);

This is registered with SA_INTERRUPT, so the plain spin_lock probably
is not enough.

> +/* returns the console irq if interrupt is successfully registered,
> + * else 0 */
> +static int
> +sn_sal_connect_interrupt(void)
> +{
> +	cpuid_t intr_cpuid;
> +	unsigned int intr_cpuloc;
> +	nasid_t console_nasid;
> +	unsigned int console_irq;
> +	int result;
> +
> +	console_nasid = ia64_sn_get_console_nasid();
> +	intr_cpuid = NODEPDA(NASID_TO_COMPACT_NODEID(console_nasid))->node_first_cpu;
> +	intr_cpuloc = cpu_physical_id(intr_cpuid);
> +	console_irq = CPU_VECTOR_TO_IRQ(intr_cpuloc, SGI_UART_VECTOR);
> +
> +	result = intr_connect_level(intr_cpuid, SGI_UART_VECTOR, 0 /*not used*/, 0 /*not used*/);
> +	BUG_ON(result != SGI_UART_VECTOR);
> +
> +	result = request_irq(console_irq, sn_sal_interrupt, SA_INTERRUPT,  "SAL console driver", &sn_sal_tty);
> +	if (result >= 0)
> +		return console_irq;
> +
> +	printk(KERN_INFO "sn_serial: console proceeding in polled mode\n");
> +	return 0;

Yikes!  WTF is this?  Okay, looking through arch/ia64/sn I see that
request_irq is basically a noop on SN2 and you must do intr_connect_level
instead.  Could you _please_fix this up by registering a
struct hw_interrupt_type for the hub-level interrupts and getting rid of
all this intr_connect_level madness?

> +static void
> +sn_sal_tasklet_action(unsigned long data)
> +{
> +	unsigned long flags;
> +
> +	if (sn_sal_tty) {
> +		spin_lock_irqsave(&sn_sal_lock, flags);
> +		if (sn_sal_tty) {
> +			if (test_and_clear_bit(SN_SAL_EVENT_WRITE_WAKEUP, &sn_sal_event)) {
> +				if ((sn_sal_tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && sn_sal_tty->ldisc.write_wakeup)
> +					(sn_sal_tty->ldisc.write_wakeup)((struct tty_struct *)sn_sal_tty);
> +				wake_up_interruptible((wait_queue_head_t *)&sn_sal_tty->write_wait);
> +			}

Please linebreak after 80 chars.

> +static int
> +sn_sal_open(struct tty_struct *tty, struct file *filp)
> +{
> +	unsigned long flags;
> +
> +	DPRINTF("sn_sal_open: sn_sal_tty = %p, tty = %p, filp = %p\n",
> +		sn_sal_tty, tty, filp);
> +
> +	spin_lock_irqsave(&sn_sal_lock, flags);
> +	if (!sn_sal_tty)
> +		sn_sal_tty = tty;

Eeek.  Either you allow opening just one tty and you don't need this
lock or you fix up the driver to pass the tty_struct to where it is used
properly.

> +
> +			memcpy((char *)xmit.cb_buf + xmit.cb_head, sn_tmp_buffer, c);

No need to cast the first ar to memcpy.  And even if you did it it would
be void *..

> +static int
> +sn_sal_ioctl(struct tty_struct *tty, struct file *file,
> +	       unsigned int cmd, unsigned long arg)
> +{
> +	/* nothing supported */
> +
> +	return -ENOIOCTLCMD;
> +}

So don't implement this function at all.  The upper layers will deal
with this nicely.

> +static int
> +sn_sal_read_proc(char *page, char **start, off_t off, int count,
> +		   int *eof, void *data)
> +{
> +	int len = 0;
> +	off_t	begin = 0;
> +
> +	len += sprintf(page, "sn_serial: revision:%s nasid:%d irq:%d tx:%d rx:%d\n",
> +		       serial_revdate, snia_get_console_nasid(), sn_sal_irq,
> +		       sn_total_tx_count, sn_total_rx_count);
> +	*eof = 1;
> +
> +	if (off >= len+begin)
> +		return 0;
> +	*start = page + (off-begin);
> +
> +	return count < begin+len-off ? count : begin+len-off;
> +}

Either convert to seq_file or better kill it off completly.  I don't
look very useful.

> +static struct tty_operations sn_sal_driver_ops = {
> +	.open = sn_sal_open,
> +	.close = sn_sal_close,
> +	.write = sn_sal_write,

	.open			= sn_sal_open,
	.close			= sn_sal_close,

etc..

> +	sn_sal_driver->owner = THIS_MODULE;
> +	sn_sal_driver->driver_name = "sn_serial";
> +	sn_sal_driver->name = "ttyS";
> +	sn_sal_driver->major = TTY_MAJOR;
> +	sn_sal_driver->minor_start = SN_SAL_MINOR;
> +	sn_sal_driver->type = TTY_DRIVER_TYPE_SERIAL;
> +	sn_sal_driver->subtype = SERIAL_TYPE_NORMAL;
> +	sn_sal_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;

So you're using the normal TTY_MAJOR in this driver?  And use a different
name for 64 minors offsets.  So what happens if someone puts a multiport
pci serial card into an SN2?

Also you really want to use drivers/serial/serial_core.c for this driver
and move it to drivers/serial.  rmk has a 2.4 version of that file aswell
so the 2.4 altix driver can use it, too.

> +	if ((retval = tty_register_driver(sn_sal_driver))) {
> +		printk(KERN_ERR "sn_serial: Unable to register tty driver\n");
> +		return retval;
> +	}
> +#ifdef CONFIG_SGI_L1_SERIAL_CONSOLE
> +	{
> +		void __init sn_sal_serial_console_init(void);
> +		sn_sal_serial_console_init();
> +	}
> +#endif	/* CONFIG_SGI_L1_SERIAL_CONSOLE */

Eeek.  sn_sal_serial_console_init should be static, shouldn't it.  And
have a proper prototype.  Then you could also get rid of the ugly scoping
mess.

> +	del_timer_sync(&sn_sal_timer);
> +	spin_lock_irqsave(&sn_sal_lock, flags);
> +	if ((tmp = tty_unregister_driver(sn_sal_driver)))
> +		printk(KERN_ERR "sn_serial: failed to unregister driver (%d)\n", tmp);
> +
> +	spin_unlock_irqrestore(&sn_sal_lock, flags);

tty_unregister_driver under a look looks strange.  Also where's the
put_tty_driver?  And the retval from tty_unregister_driver is meaningless,
your module is gone now anyway.

> +static void
> +sn_sal_console_write(struct console *co, const char *s, unsigned count)
> +{
> +	BUG_ON(!sn_sal_is_asynch);
> +
> +	/* somebody really wants this output, might be an
> +	 * oops, kdb, panic, etc.  make sure they get it. */
> +	if (spin_is_locked(&sn_sal_lock)) {

spin_is_locked doesn't work on !SMP && !PREEMPT..

> +		synch_flush_xmit();
> +		sn_func->sal_puts(s, count);
> +	}
> +	else if (in_interrupt()) {

	} else if (in_interrupt()) {

> +		spin_lock(&sn_sal_lock);
> +		synch_flush_xmit();
> +		spin_unlock(&sn_sal_lock);
> +		sn_func->sal_puts(s, count);
> +	}
> +	else

	} else

