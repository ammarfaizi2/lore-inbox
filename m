Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUHBQox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUHBQox (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266617AbUHBQow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:44:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:52220 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266615AbUHBQni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:43:38 -0400
Subject: Re: [announce][draft4] HVCS for inclusion in 2.6 tree
From: Ryan Arnold <rsa@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, "Randy.Dunlap" <rddunlap@osdl.org>
In-Reply-To: <410936B1.8020101@pobox.com>
References: <1089819720.3385.66.camel@localhost>
	 <16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	 <1090528007.3161.7.camel@localhost> <20040722191637.52ab515a.akpm@osdl.org>
	 <1090958938.14771.35.camel@localhost>
	 <20040727155011.77897e68.rddunlap@osdl.org>
	 <1091032768.14771.283.camel@localhost>
	 <20040728131257.1fedf56d.rddunlap@osdl.org>
	 <1091045896.14771.342.camel@localhost>  <410936B1.8020101@pobox.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1091456662.14771.424.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 09:24:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 12:41, Jeff Garzik wrote:
> > +	if (!head) {
> > +		return -EINVAL;
> > +	}
> 
> style:  single statements don't want braces

Whoops, I thought I caught all of these.

> > +	while (!list_empty(head)) {
> > +		element = head->next;
> > +		pi = list_entry(element, struct hvcs_partner_info, node);
> > +		list_del(element);
> > +		kfree(pi);
> > +	}
> 
> list_for_each()

Removing an item from a list poisons the element's next and previous
pointers.  This means that list_for_each() is unable to continue
traversal after an element has been removed unless I use the
list_for_each_safe() construct.  I was told to use what you see above
instead of list_for_each_safe() several months ago by the folks on the
linuxppc64-dev mailing list.

> > +/*
> > + * The unit_address parameter is the unit address of the vty-server vdevice
> > + * in whose partner information the caller is interested.  This function
> > + * uses a pointer to a list_head instance in which to store the partner info.
> > + * This function returns non-zero on success, or if there is no partner info.
> > + *
> > + * Invocation of this function should always be followed by an invocation of
> > + * hvcs_free_partner_info() using a pointer to the SAME list head instance
> > + * that was used to store the partner_info list.
> > + */
> 
> since these are exported functions, please use kernel-doc style so that 
> they may be picked up by automated documentation tools

As in the technique outlined in Documentation/kernel-doc-nano-HOWTO.txt?

> > +/*
> > + * The hcall interface involves putting 8 chars into each of two registers.
> > + * We load up those 2 registers (in arch/ppc64/hvconsole.c) by casting char[16]
> > + * to long[2].  It would work without __ALIGNED__, but a little (tiny) bit
> > + * slower because an unaligned load is slower than aligned load.
> > + */
> > +#define __ALIGNED__	__attribute__((__aligned__(8)))
> 
> does this definition really belong here?
> 
> it also seems like the name would be likely to conflict with some 
> existing symbol.

True, this exists in drivers/char/hvc_console.c as well but isn't this
definition local to hvcs.c?

> > +/* Status of partner info rescan triggered via sysfs. */
> > +static int hvcs_rescan_status = 0;
> 
> implicitly rather than explicitly zero statics

> > +/*
> > + * Used by the khvcsd to pick up I/O operations when the kernel_thread is
> > + * already awake but potentially shifted to TASK_INTERRUPTIBLE state.
> > + */
> > +static int hvcs_kicked = 0;
> 
> implicitly rather than explicitly zero statics

I forget about this sometimes.  Will do..

> > +static spinlock_t hvcs_pi_lock;
> 
> = SPIN_LOCK_UNLOCKED ?

Currently this is initialized in hvcs_module_init().  Perhaps
initialization after declaration is more appropriate?

> > +static void hvcs_kick(void)
> > +{
> > +	hvcs_kicked = 1;
> > +	wmb();
> > +	wake_up_process(hvcs_task);
> > +}
> 
> why not a semaphore or completion?


**************************

> > +static irqreturn_t hvcs_handle_interrupt(int irq, void *dev_instance,
> > +		struct pt_regs *regs)
> > +{
> > +	struct hvcs_struct *hvcsd = dev_instance;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&hvcsd->lock, flags);
> > +	vio_disable_interrupts(hvcsd->vdev);
> > +	hvcsd->todo_mask |= HVCS_SCHED_READ;
> > +	spin_unlock_irqrestore(&hvcsd->lock, flags);
> > +	hvcs_kick();
> 
> spin_lock_irqsave isn't necessary in interrupt handlers normally

Ah yes, I forgot about the difference between spin_lock() and
spin_lock_irqsave().  Thanks.

> > +		if (sent > 0) {
> > +			hvcsd->chars_in_buffer = 0;
> > +			wmb();
> > +			hvcsd->todo_mask &= ~(HVCS_TRY_WRITE);
> > +			wmb();
> 
> You are already inside a spinlock, why bother?

Why bother with the memory barrier?  The driver was originally
implemented without that spinlock.  Maybe it would be OK to remove the
memory barriers.

> 
> > +			/*
> > +			 * We are still obligated to deliver the data to the
> > +			 * hypervisor even if the tty has been closed because
> > +			 * we commited to delivering it.  But don't try to wake
> > +			 * a non-existent tty.
> > +			 */
> > +			if (tty) {
> > +				if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP))
> > +						&& tty->ldisc.write_wakeup)
> > +					(tty->ldisc.write_wakeup) (tty);
> > +				wake_up_interruptible(&tty->write_wait);
> wouldn't just using up() be more simple?

The TTY layer uses wait_queues so wake_up_interruptible() is the method
used to wake the tty layer's write wait so that the tty layer knows that
the hypervisor & hvcs driver are available for further data writes.


> > +static int khvcsd(void *unused)
> > +{
> > +	struct hvcs_struct *hvcsd = NULL;
> > +	struct list_head *element;
> > +	struct list_head *safe_temp;
> > +	int hvcs_todo_mask;
> > +	unsigned long structs_flags;
> > +
> > +	__set_current_state(TASK_RUNNING);
> > +
> > +	do {
> > +		hvcs_todo_mask = 0;
> > +		hvcs_kicked = 0;
> > +		wmb();
> > +
> > +		spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
> > +		list_for_each_safe(element, safe_temp, &hvcs_structs) {
> > +			hvcsd = list_entry(element, struct hvcs_struct, next);
> > +				hvcs_todo_mask |= hvcs_io(hvcsd);
> > +		}
> > +		spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
> > +
> > +		/*
> > +		 * If any of the hvcs adapters want to try a write or quick read
> > +		 * don't schedule(), yield a smidgen then execute the hvcs_io
> > +		 * thread again for those that want the write.
> > +		 */
> > +		 if (hvcs_todo_mask & (HVCS_TRY_WRITE | HVCS_QUICK_READ)) {
> > +			yield();
> > +			continue;
> > +		}
> > +
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		if (!hvcs_kicked)
> > +			schedule();
> > +		__set_current_state(TASK_RUNNING);
> 
> This is essentially a busy loop.
> 
> This thread has no condition to actually block on, which means it is 
> running in a tight loop calling either yield() or schedule().  Not 
> terrible, but it's far better to simply down_interruptible().

Basically the point of khvcsd is that it should sleep until the driver
gets an interrupt from the hypervisor saying there is data on a
vty-server adapter at which point the kthread will execute in a tight
loop with a yield to allow the tty buffers to clear until such time as
there is no more data available for output to the TTY layer.

The thread is also kicked awake when the hypervisor blocks writes.  The
thread is awoken and continues to try to send data to the hypervisor
until the send is successful, at which point it awakens the TTY layer
for further writes.

Furthermore, this kthread can process mutliple vty-servers
simultaneously.

Ben Herrenschmidt originally suggested that I use the kthreads
methodology so I'd like his opinion on your comments.

> > +	hvcsd = kmalloc(sizeof(*hvcsd), GFP_KERNEL);
> > +	if (!hvcsd) {
> > +		return -ENODEV;
> > +	}
> 
> style

Yes, will fix.

> 
> > +	/* hvcsd->tty is zeroed out with the memset */
> > +	memset(hvcsd, 0x00, sizeof(*hvcsd));
> > +
> > +	hvcsd->lock = SPIN_LOCK_UNLOCKED;
> > +	/* Automatically incs the refcount the first time */
> > +	kobject_init(&hvcsd->kobj);
> > +	/* Set up the callback for terminating the hvcs_struct's life */
> > +	hvcsd->kobj.ktype = &hvcs_kobj_type;
> > +
> > +	hvcsd->vdev = dev;
> > +	dev->dev.driver_data = hvcsd;
> > +
> > +	hvcsd->index = ++hvcs_struct_count;
> > +	hvcsd->chars_in_buffer = 0;
> > +	hvcsd->todo_mask = 0;
> > +	hvcsd->connected = 0;
> > +
> > +	/*
> > +	 * This will populate the hvcs_struct's partner info fields for the
> > +	 * first time.
> > +	 */
> > +	if (hvcs_get_pi(hvcsd)) {
> > +		printk(KERN_ERR "HVCS: Failed to fetch partner"
> > +			" info for vty-server@%X on device probe.\n",
> > +			hvcsd->vdev->unit_address);
> > +	}
> > +
> > +	/*
> > +	 * If a user app opens a tty that corresponds to this vty-server before
> > +	 * the hvcs_struct has been added to the devices list then the user app
> > +	 * will get -ENODEV.
> > +	 */
> > +
> > +	spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
> > +
> > +	list_add_tail(&(hvcsd->next), &hvcs_structs);
> > +
> > +	spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
> > +
> > +	hvcs_create_device_attrs(hvcsd);
> > +
> > +	printk(KERN_INFO "HVCS: Added vty-server@%X.\n", dev->unit_address);
> > +
> > +	/*
> > +	 * DON'T enable interrupts here because there is no user to receive the
> > +	 * data.
> > +	 */
> > +	return 0;
> > +}
> > +
> > +static int __devexit hvcs_remove(struct vio_dev *dev)
> > +{
> 
> remove returns an error???  I question the vio API builder...

>From arch/ppc64/kernel/vio.c

        if (viodrv->remove) {
                return viodrv->remove(viodev);
        }

I'm not sure why this is done.

> 
> > +	struct hvcs_struct *hvcsd = dev->dev.driver_data;
> > +	unsigned long flags;
> > +	struct kobject *kobjp;
> > +	struct tty_struct *tty;
> > +
> > +	if (!hvcsd)
> > +		return -ENODEV;
> 
> this should be a BUG(), no?

Maybe?  Reasoning?

> > +{
> > +	struct hvcs_struct *hvcsd = NULL;
> > +	unsigned long flags;
> > +	unsigned long structs_flags;
> > +
> > +	spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
> > +
> > +	list_for_each_entry(hvcsd, &hvcs_structs, next) {
> > +		spin_lock_irqsave(&hvcsd->lock, flags);
> > +		hvcs_get_pi(hvcsd);
> > +		spin_unlock_irqrestore(&hvcsd->lock, flags);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
> 
> Isn't this double spin_lock_irqsave rather obviously silly?

Oops, I did it again...

> > +	if (!request_irq(irq, &hvcs_handle_interrupt,
> > +				SA_INTERRUPT, "ibmhvcs", hvcsd)) {
> > +		/*
> > +		 * It is possible the vty-server was removed after the irq was
> > +		 * requested but before we have time to enable interrupts.
> > +		 */
> > +		if (vio_enable_interrupts(vdev) == H_Success)
> > +			return 0;
> > +		else {
> > +			printk(KERN_ERR "HVCS: int enable failed for"
> > +					" vty-server@%X.\n", unit_address);
> > +			free_irq(irq, hvcsd);
> > +		}
> > +	} else
> > +		printk(KERN_ERR "HVCS: irq req failed for"
> > +				" vty-server@%X.\n", unit_address);
> 
> propagate return value from request_irq()

Good idea!

> > +struct hvcs_struct *hvcs_get_by_index(int index)
> > +{
> > +	struct hvcs_struct *hvcsd = NULL;
> > +	struct list_head *element;
> > +	struct list_head *safe_temp;
> > +	unsigned long flags;
> > +	unsigned long structs_flags;
> > +
> > +	spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
> > +	/* We can immediately discard OOB requests */
> > +	if (index >= 0 && index < HVCS_MAX_SERVER_ADAPTERS) {
> > +		list_for_each_safe(element, safe_temp, &hvcs_structs) {
> > +			hvcsd = list_entry(element, struct hvcs_struct, next);
> > +			spin_lock_irqsave(&hvcsd->lock, flags);
> > +			if (hvcsd->index == index) {
> > +				kobject_get(&hvcsd->kobj);
> > +				spin_unlock_irqrestore(&hvcsd->lock, flags);
> > +				spin_unlock_irqrestore(&hvcs_structs_lock,
> > +						structs_flags);
> > +				return hvcsd;
> > +			}
> > +			spin_unlock_irqrestore(&hvcsd->lock, flags);
> > +		}
> > +		hvcsd = NULL;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
> 
> another spin_lock_irqsave() inside spin_lock_irqsave()

And again..

> > +	if ((hvcs_enable_device(hvcsd, unit_address, irq, vdev))) {
> > +		kobject_put(&hvcsd->kobj);
> > +		printk(KERN_WARNING "HVCS: enable device failed.\n");
> > +		return -ENODEV;
> > +	}
> 
> propagate return value?

Yes.

> > +static int __init hvcs_module_init(void)
> > +{
> > +	int rc;
> > +	int num_ttys_to_alloc;
> > +
> > +	printk(KERN_INFO "Initializing %s\n", hvcs_driver_string);
> > +
> > +	/* Has the user specified an overload with an insmod param? */
> > +	if (hvcs_parm_num_devs <= 0 ||
> > +		(hvcs_parm_num_devs > HVCS_MAX_SERVER_ADAPTERS)) {
> > +		num_ttys_to_alloc = HVCS_DEFAULT_SERVER_ADAPTERS;
> > +	} else
> > +		num_ttys_to_alloc = hvcs_parm_num_devs;
> > +
> > +	hvcs_tty_driver = alloc_tty_driver(num_ttys_to_alloc);
> > +	if (!hvcs_tty_driver)
> > +		return -ENOMEM;
> > +
> > +	hvcs_tty_driver->owner = THIS_MODULE;
> > +
> > +	hvcs_tty_driver->driver_name = hvcs_driver_name;
> > +	hvcs_tty_driver->name = hvcs_device_node;
> > +
> > +	/*
> > +	 * We'll let the system assign us a major number, indicated by leaving
> > +	 * it blank.
> > +	 */
> > +
> > +	hvcs_tty_driver->minor_start = HVCS_MINOR_START;
> > +	hvcs_tty_driver->type = TTY_DRIVER_TYPE_SYSTEM;
> > +
> > +	/*
> > +	 * We role our own so that we DONT ECHO.  We can't echo because the
> > +	 * device we are connecting to already echoes by default and this would
> > +	 * throw us into a horrible recursive echo-echo-echo loop.
> > +	 */
> > +	hvcs_tty_driver->init_termios = hvcs_tty_termios;
> > +	hvcs_tty_driver->flags = TTY_DRIVER_REAL_RAW;
> > +
> > +	tty_set_operations(hvcs_tty_driver, &hvcs_ops);
> > +
> > +	/*
> > +	 * The following call will result in sysfs entries that denote the
> > +	 * dynamically assigned major and minor numbers for our devices.
> > +	 */
> > +	if (tty_register_driver(hvcs_tty_driver)) {
> > +		printk(KERN_ERR "HVCS: registration "
> > +			" as a tty driver failed.\n");
> > +		put_tty_driver(hvcs_tty_driver);
> > +		return rc;
> > +	}
> > +
> > +	hvcs_structs_lock = SPIN_LOCK_UNLOCKED;
> > +
> > +	hvcs_pi_lock = SPIN_LOCK_UNLOCKED;
> > +	hvcs_pi_buff = kmalloc(PAGE_SIZE, GFP_KERNEL);
> 
> check return value

That is important, thanks.

> 
> > +	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
> > +	if (IS_ERR(hvcs_task)) {
> > +		printk("khvcsd creation failed.  Driver not loaded.\n");
> > +		kfree(hvcs_pi_buff);
> > +		put_tty_driver(hvcs_tty_driver);
> > +		return -EIO;
> > +	}
> > +
> > +	rc = vio_register_driver(&hvcs_vio_driver);
> > +	/*
> > +	 * This needs to be done AFTER the vio_register_driver() call or else
> > +	 * the kobjects won't be initialized properly.
> > +	 */
> > +	hvcs_create_driver_attrs();
> 
> Are you sure about all this??  The whole order of initialization looks 
> wrong.
> 
> What happens if someone opens a tty before vio_register_driver() is 
> finished?

from hvcs_open():

        if (!(hvcsd = hvcs_get_by_index(tty->index))) {
                printk(KERN_WARNING "HVCS: open failed, no index.\n");
                return -ENODEV;
        }

This check will fail early in hvcs_open() since hvcs_probe() will not be
called on vty-server adapters until vio_register_driver() has
completed.  hvcs_struct instances aren't added to the hvcs_strucst list
until they are added during hvcs_probe() meaning, hvcs_open won't
succeed until the adapter actually exists and has been probed into the
driver.

Jeff, thanks for all the comments.  Since Linus has already taken the
patch I'll take the advice of David Boutcher on #ppc64 where he
recommended that I implement the changes based on your comments once we
see a prepatch tree with the HVCS driver in it.

Ryan S. Arnold
IBM Linux Technology Center
> 

