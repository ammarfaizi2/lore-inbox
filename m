Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUHQNR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUHQNR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUHQNR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:17:56 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7927 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266183AbUHQNOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:14:45 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 15:12:26 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815151346.GA13761@devserv.devel.redhat.com>
In-Reply-To: <20040815151346.GA13761@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408171512.26568.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


more comments, please read

On Sunday 15 August 2004 17:13, Alan Cox wrote:
> There really isnt any sane way to break this patch down because all the
> changes are interlinked so closely.

it turns out that it _really_ must be splitted out on invidual changes,
this is possible and needed because changes are fairly complicated

> We now
> 	- enforce and document an actual lock order
> 	- use a seperate semaphore to get sleep-read/spin-write locking for
> 	  the lists that need it
> 	- Fix the driver list locking
> 	- Fix the hwif list locking
> 	- Remove the impossible to fix and unused stuff for passing
> 	  a device between drivers
> 	- Change ide_unregister into ide_unregister_hwif as it now takes
> 	  a hwif pointer
> 	- Fix various cases we wrongly dropped locks
> 	- Split configured/present so that we can do unregister right
> 	- Call ->remove() callbacks
>
> This patch leaves pci and ide-cs broken, patches to move them to the new
> locking follow
>
>
> diff -u --new-file --recursive --exclude-from /usr/src/exclude
> linux.vanilla-2.6.8-rc3/drivers/ide/ide.c linux-2.6.8-rc3/drivers/ide/ide.c
> --- linux.vanilla-2.6.8-rc3/drivers/ide/ide.c	2004-08-09 15:51:00.000000000
> +0100 +++ linux-2.6.8-rc3/drivers/ide/ide.c	2004-08-12 17:55:05.000000000
> +0100 @@ -448,31 +515,46 @@
>  	return -ENXIO;
>  }
>
> +/*
> + *	drives_lock protects the list of drives, drivers lock the
> + *	list of drivers. Currently nobody takes both at once.
> + *	drivers_sem guards the drivers_list for readers that may
> + *	sleep. It must be taken before drivers_lock. Take drivers_sem
> + *	before ide_setting_sem and idecfg_sem before either of the
> + *	others.
> + */
> +
>  static spinlock_t drives_lock = SPIN_LOCK_UNLOCKED;
> +static DECLARE_MUTEX(drivers_sem);

Could you please explain why is it needed - what is it trying to fix?

>  static spinlock_t drivers_lock = SPIN_LOCK_UNLOCKED;
> +
>  static LIST_HEAD(drivers);
>
> -/* Iterator */
> +/* Iterator for the driver list. */
> +
>  static void *m_start(struct seq_file *m, loff_t *pos)
>  {
>  	struct list_head *p;
>  	loff_t l = *pos;
> -	spin_lock(&drivers_lock);
> +	down(&drivers_sem);
>  	list_for_each(p, &drivers)
>  		if (!l--)
>  			return list_entry(p, ide_driver_t, drivers);
>  	return NULL;
>  }
> +
>  static void *m_next(struct seq_file *m, void *v, loff_t *pos)
>  {
>  	struct list_head *p = ((ide_driver_t *)v)->drivers.next;
>  	(*pos)++;
>  	return p==&drivers ? NULL : list_entry(p, ide_driver_t, drivers);
>  }
> +
>  static void m_stop(struct seq_file *m, void *v)
>  {
> -	spin_unlock(&drivers_lock);
> +	up(&drivers_sem);
>  }
> +
>  static int show_driver(struct seq_file *m, void *v)
>  {
>  	ide_driver_t *driver = v;
> @@ -515,6 +597,7 @@
>   *	MMIO leaves it to the controller driver,
>   *	PIO will migrate this way over time.
>   */
> +
>  int ide_hwif_request_regions(ide_hwif_t *hwif)
>  {
>  	unsigned long addr;
> @@ -564,6 +647,7 @@
>   *	importantly our caller should be doing this so we need to
>   *	restructure this as a helper function for drivers.
>   */
> +
>  void ide_hwif_release_regions(ide_hwif_t *hwif)
>  {
>  	u32 i = 0;
> @@ -581,7 +665,15 @@
>  			release_region(hwif->io_ports[i], 1);
>  }
>
> -/* restore hwif to a sane state */
> +/**
> + *	ide_hwif_restore	-	restore hwif to template
> + *	@hwif: hwif to update
> + *	@tmp_hwif: template
> + *
> + *	Restore hwif to a default state by copying most settngs
> + *	from the template.
> + */
> +
>  static void ide_hwif_restore(ide_hwif_t *hwif, ide_hwif_t *tmp_hwif)
>  {
>  	hwif->hwgroup			= tmp_hwif->hwgroup;
> @@ -678,15 +771,16 @@
>  }
>
>  /**
> - *	ide_unregister		-	free an ide interface
> - *	@index: index of interface (will change soon to a pointer)
> + *	__ide_unregister_hwif	-	free an ide interface
> + *	@hwif: interface to unregister
>   *
>   *	Perform the final unregister of an IDE interface. At the moment
>   *	we don't refcount interfaces so this will also get split up.
>   *
>   *	Locking:
> - *	The caller must not hold the IDE locks
> - *	The drive present/vanishing is not yet properly locked
> + *	The caller must not hold the IDE locks except for ide_cfg_sem
> + *	which must be held.
> + *
>   *	Take care with the callbacks. These have been split to avoid
>   *	deadlocking the IDE layer. The shutdown callback is called
>   *	before we take the lock and free resources. It is up to the
> @@ -695,31 +789,43 @@
>   *	isnt yet done btw). After we commit to the final kill we
>   *	call the cleanup callback with the ide locks held.
>   *
> + *	An interface can be in four states we care about
> + *	- It can be busy (drive or driver thinks its active). No unload
> + *	- It can be unconfigured - which means its already gone
> + *	- It can be configured and present - a full interface
> + *	- It can be configured and not present - pci configured but no drives
> + *						 so logically absent.
> + *
>   *	Unregister restores the hwif structures to the default state.
> - *	This is raving bonkers.
>   */
>
> -void ide_unregister(unsigned int index)
> +int __ide_unregister_hwif(ide_hwif_t *hwif)
>  {
>  	ide_drive_t *drive;
> -	ide_hwif_t *hwif, *g, *tmp_hwif;
> +	ide_hwif_t *g;
>  	ide_hwgroup_t *hwgroup;
>  	int irq_count = 0, unit, i;
> +	int index;
> +	static ide_hwif_t tmp_hwif;	/* Serialized by locking */
> +	int ret = 0;
> +	int was_present;
>
> -	BUG_ON(index >= MAX_HWIFS);
> -
> -	tmp_hwif = kmalloc(sizeof(*tmp_hwif), GFP_KERNEL|__GFP_NOFAIL);
> -	if (!tmp_hwif) {
> -		printk(KERN_ERR "%s: unable to allocate memory\n", __FUNCTION__);
> -		return;
> -	}
> -
> +	index = hwif->index;
> +
>  	BUG_ON(in_interrupt());
>  	BUG_ON(irqs_disabled());
> -	down(&ide_cfg_sem);
> +
> +	/* Make sure nobody sneaks in via the proc interface */
> +	down(&ide_setting_sem);
> +
> +	/* Now ensure nobody gets in for I/O while we clean up and
> +	   do the busy check. If busy is set then the device is still
> +	   open and we must stop */
>  	spin_lock_irq(&ide_lock);
> -	hwif = &ide_hwifs[index];
> -	if (!hwif->present)
> +
> +	printk("Unregister %d\n", index);
> +
> +	if (!hwif->configured)
>  		goto abort;
>  	for (unit = 0; unit < MAX_DRIVES; ++unit) {
>  		drive = &hwif->drives[unit];
> @@ -729,10 +835,18 @@
>  			goto abort;
>  		drive->dead = 1;
>  	}
> +	/*
> +	 * Protect against new users. From this point the hwif
> +	 * is not present so cannot be opened by a new I/O source.
> +	 * This also invalidates key driven access from procfs
> +	 */
> +
> +	was_present = hwif->present;
>  	hwif->present = 0;
>
>  	spin_unlock_irq(&ide_lock);
> -
> +	up(&ide_setting_sem);
> +
>  	for (unit = 0; unit < MAX_DRIVES; ++unit) {
>  		drive = &hwif->drives[unit];
>  		if (!drive->present)
> @@ -743,27 +857,36 @@
>  #ifdef CONFIG_PROC_FS
>  	destroy_proc_ide_drives(hwif);
>  #endif
> -
> +	spin_lock_irq(&ide_lock);
> +
>  	hwgroup = hwif->hwgroup;
> -	/*
> -	 * free the irq if we were the only hwif using it
> -	 */
> -	g = hwgroup->hwif;
> -	do {
> -		if (g->irq == hwif->irq)
> -			++irq_count;
> -		g = g->next;
> -	} while (g != hwgroup->hwif);
> -	if (irq_count == 1)
> +	if(hwgroup)
> +	{
> +		/*
> +		 * free the irq if we were the only hwif using it
> +		 */
> +		g = hwgroup->hwif;
> +		do {
> +			if (g->irq == hwif->irq)
> +				++irq_count;
> +			g = g->next;
> +		} while (g != hwgroup->hwif);
> +	}
> +	spin_unlock_irq(&ide_lock);

new race(s) here because of not holding ide_cfg_sem anylonger,
see init_irq() in ide-probe.c and ide_cfg_sem comments in ide.h

some other driver may accessing this hwif->hwgroup without holding ide_lock
- probably will result in a crash few lines below when we try to free this 
hwgroup

> +	if (irq_count == 1 && hwgroup)
>  		free_irq(hwif->irq, hwgroup);
>
> -	spin_lock_irq(&ide_lock);
>  	/*
>  	 * Note that we only release the standard ports,
>  	 * and do not even try to handle any extra ports
>  	 * allocated for weird IDE interface chipsets.
> +	 *
> +	 * FIXME: should defer this I think
>  	 */
> -	ide_hwif_release_regions(hwif);
> +
> +	if(was_present)
> +		ide_hwif_release_regions(hwif);
>
>  	/*
>  	 * Remove us from the hwgroup, and free
> @@ -777,6 +900,14 @@
>  		}
>  		if (!drive->present)
>  			continue;
> +
> +		/*
> +		 * The hwgroup chain is IRQ touched. We must protect
> +		 * walking this from an IDE event for another device
> +		 * in the chain
> +		 */
> +
> +		spin_lock_irq(&ide_lock);
>  		if (drive == drive->next) {
>  			/* special case: last drive from hwgroup. */
>  			BUG_ON(hwgroup->drive != drive);
> @@ -793,51 +924,73 @@
>  				hwgroup->hwif = HWIF(hwgroup->drive);
>  			}
>  		}
> +		spin_unlock_irq(&ide_lock);
> +
> +		/*
> +		 * The rest of the cleanup is private
> +		 */
> +
>  		BUG_ON(hwgroup->drive == drive);
>  		if (drive->id != NULL) {
>  			kfree(drive->id);
>  			drive->id = NULL;
>  		}
>  		drive->present = 0;
> -		/* Messed up locking ... */
> -		spin_unlock_irq(&ide_lock);
>  		blk_cleanup_queue(drive->queue);
>  		device_unregister(&drive->gendev);
>  		down(&drive->gendev_rel_sem);
> -		spin_lock_irq(&ide_lock);
>  		drive->queue = NULL;
>  	}
> -	if (hwif->next == hwif) {
> -		BUG_ON(hwgroup->hwif != hwif);
> -		kfree(hwgroup);
> -	} else {
> -		/* There is another interface in hwgroup.
> -		 * Unlink us, and set hwgroup->drive and ->hwif to
> -		 * something sane.
> -		 */
> -		g = hwgroup->hwif;
> -		while (g->next != hwif)
> -			g = g->next;
> -		g->next = hwif->next;
> -		if (hwgroup->hwif == hwif) {
> -			/* Chose a random hwif for hwgroup->hwif.
> -			 * It's guaranteed that there are no drives
> -			 * left in the hwgroup.
> +
> +	/*
> +	 * Lock against hwgroup walkers including interrupts off other
> +	 * IDE devices wile we unhook ourselves.
> +	 */
> +
> +	spin_lock_irq(&ide_lock);
> +
> +	if (hwgroup)
> +	{
> +		if (hwif->next == hwif) {
> +			BUG_ON(hwgroup->hwif != hwif);
> +			kfree(hwgroup);
> +		} else {
> +			/* There is another interface in hwgroup.
> +			 * Unlink us, and set hwgroup->drive and ->hwif to
> +			 * something sane.
>  			 */
> -			BUG_ON(hwgroup->drive != NULL);
> -			hwgroup->hwif = g;
> +			g = hwgroup->hwif;
> +			while (g->next != hwif)
> +				g = g->next;
> +			g->next = hwif->next;
> +			if (hwgroup->hwif == hwif) {
> +				/* Chose a random hwif for hwgroup->hwif.
> +				 * It's guaranteed that there are no drives
> +				 * left in the hwgroup.
> +				 */
> +				BUG_ON(hwgroup->drive != NULL);
> +				hwgroup->hwif = g;
> +			}
> +			BUG_ON(hwgroup->hwif == hwif);
>  		}
> -		BUG_ON(hwgroup->hwif == hwif);
>  	}
> -
> -	/* More messed up locking ... */
>  	spin_unlock_irq(&ide_lock);
> -	device_unregister(&hwif->gendev);
> -	down(&hwif->gendev_rel_sem);
> +
> +	/*
> +	 * PCI interfaces with no devices don't exist in the device
> +	 * tree so don't unregister them.
> +	 */
> +
> +	if(was_present)
> +	{
> +		device_unregister(&hwif->gendev);
> +		down(&hwif->gendev_rel_sem);
> +	}
>
>  	/*
>  	 * Remove us from the kernel's knowledge
>  	 */
> +
>  	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
>  	for (i = 0; i < MAX_DRIVES; i++) {
>  		struct gendisk *disk = hwif->drives[i].disk;
> @@ -845,8 +998,16 @@
>  		put_disk(disk);
>  	}
>  	unregister_blkdev(hwif->major, hwif->name);
> +
>  	spin_lock_irq(&ide_lock);
>
> +	/*
> +	 * Let the driver free up private objects
> +	 */
> +
> +	if(hwif->remove)
> +		hwif->remove(hwif);
> +
>  	if (hwif->dma_base) {
>  		(void) ide_release_dma(hwif);
>
> @@ -858,24 +1019,70 @@
>  		hwif->dma_vendor3 = 0;
>  		hwif->dma_prdtable = 0;
>  	}
> +
> +	hwif->chipset = ide_unknown;

this breaks (half-working) HDIO_SCAN_HWIF ioctl
and can change ordering of IDE devices in some situations
- many host drivers look at hwif->chipset during init

>  	/* copy original settings */
> -	*tmp_hwif = *hwif;
> +	tmp_hwif = *hwif;
>
>  	/* restore hwif data to pristine status */
>  	init_hwif_data(hwif, index);
>  	init_hwif_default(hwif, index);
> +
> +	hwif->key++;
> +	hwif->configured = 0;

hwif->key is not restored in ide_hwif_restore() so it will be
always == 1 for once unregistered hwifs due to init_hwif_data()

Have you tested 'hwif->key' infrastructure?

> -	ide_hwif_restore(hwif, tmp_hwif);
> +	ide_hwif_restore(hwif, &tmp_hwif);
> +
> +	spin_unlock_irq(&ide_lock);
> +	return 0;
>
>  abort:
> +	if(hwif->configured)
> +	{
> +		printk("Unregister %d fail %d %d\n", index, drive->usage,
> DRIVER(drive)->busy); +		ret = -EBUSY;
> +	}
> +	else
> +	{
> +		printk("No such hwif!\n");
> +		ret = -ENOENT;
> +	}
>  	spin_unlock_irq(&ide_lock);
> -	up(&ide_cfg_sem);
> +	up(&ide_setting_sem);
> +	return ret;
> +}
> +
> +EXPORT_SYMBOL_GPL(__ide_unregister_hwif);
>
> -	kfree(tmp_hwif);
> +
> +/**
> + *	ide_unregister_hwif	-	free an ide interface
> + *	@hwif: interface to unregister
> + *
> + *	Perform the final unregister of an IDE interface. At the moment
> + *	we don't refcount interfaces so this will also get split up.
> + *	Unregister restores the hwif structures to the default state.
> + *
> + *	No locks should be held on entry. When an unregister must
> + *	be done atomically with a register see __ide_unregister_hwif
> + *	and hold the ide_cfg_sem yourself.
> + */
> +
> +int ide_unregister_hwif(ide_hwif_t *hwif)
> +{
> +	int ret;
> +
> +	/* This protects two things. Firstly it serializes the
> +	   shutdown sequence, secondly it protects us from
> +	   races while we are killing off a device */
> +	down(&ide_cfg_sem);
> +	ret = __ide_unregister_hwif(hwif);
> +	up(&ide_cfg_sem);
> +	return ret;
>  }
>
> -EXPORT_SYMBOL(ide_unregister);
> +EXPORT_SYMBOL_GPL(ide_unregister_hwif);
>
>
>  /**
> @@ -931,15 +1138,25 @@
>   */
>  }
>
> -/*
> - * Register an IDE interface, specifying exactly the registers etc
> - * Set init=1 iff calling before probes have taken place.
> +/**
> + *	ide_register_hw		-	register IDE interface
> + *	@hw: hardware registers
> + *	@hwifp: pointer to returned hwif
> + *
> + *	Register an IDE interface, specifying exactly the registers etc
> + *	Set init=1 iff calling before probes have taken place. The
> + *	ide_cfg_sem protects this against races.
> + *
> + *	Returns -1 on error.
>   */
> +
>  int ide_register_hw (hw_regs_t *hw, ide_hwif_t **hwifp)
>  {
>  	int index, retry = 1;
>  	ide_hwif_t *hwif;
>
> +	down(&ide_cfg_sem);
> +
>  	do {
>  		for (index = 0; index < MAX_HWIFS; ++index) {
>  			hwif = &ide_hwifs[index];
> @@ -950,28 +1167,37 @@
>  			hwif = &ide_hwifs[index];
>  			if (hwif->hold)
>  				continue;
> -			if ((!hwif->present && !hwif->mate && !initializing) ||
> +			if ((!hwif->configured && !hwif->mate && !initializing) ||
>  			    (!hwif->hw.io_ports[IDE_DATA_OFFSET] && initializing))
>  				goto found;
>  		}
> +		/* FIXME- this check should die as should the retry loop */
>  		for (index = 0; index < MAX_HWIFS; index++)
> -			ide_unregister(index);
> +		{
> +			hwif = &ide_hwifs[index];
> +			__ide_unregister_hwif(hwif);
> +		}
>  	} while (retry--);
> +
> +	up(&ide_cfg_sem);
>  	return -1;
>  found:
> -	if (hwif->present)
> -		ide_unregister(index);
> +	/* FIXME: do we really need this case */
> +	if (hwif->configured)
> +		__ide_unregister_hwif(hwif);
>  	else if (!hwif->hold) {
>  		init_hwif_data(hwif, index);
>  		init_hwif_default(hwif, index);
>  	}
> -	if (hwif->present)
> +	if (hwif->configured)
>  		return -1;
> +	hwif->configured = 1;
>  	memcpy(&hwif->hw, hw, sizeof(*hw));
>  	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
>  	hwif->irq = hw->irq;
>  	hwif->noprobe = 0;
>  	hwif->chipset = hw->chipset;
> +	up(&ide_cfg_sem);
>
>  	if (!initializing) {
>  		probe_hwif_init(hwif);
> @@ -1008,21 +1234,21 @@
>   *	@set: setting
>   *
>   *	Removes the setting named from the device if it is present.
> - *	The function takes the settings_lock to protect against
> - *	parallel changes. This function must not be called from IRQ
> - *	context. Returns 0 on success or -1 on failure.
> + *	This function must not be called from IRQ context. Returns 0
> + *	on success or -1 on failure.
>   *
>   *	BUGS: This code is seriously over-engineered. There is also
>   *	magic about how the driver specific features are setup. If
>   *	a driver is attached we assume the driver settings are auto
>   *	remove.
> + *
> + *	The caller must hold settings_lock
>   */
>
>  int ide_add_setting (ide_drive_t *drive, const char *name, int rw, int
> read_ioctl, int write_ioctl, int data_type, int min, int max, int
> mul_factor, int div_factor, void *data, ide_procset_t *set) {
>  	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting =
> NULL;
>
> -	down(&ide_setting_sem);
>  	while ((*p) && strcmp((*p)->name, name) < 0)
>  		p = &((*p)->next);
>  	if ((setting = kmalloc(sizeof(*setting), GFP_KERNEL)) == NULL)
> @@ -1046,10 +1272,8 @@
>  	if (drive->driver != &idedefault_driver)
>  		setting->auto_remove = 1;
>  	*p = setting;
> -	up(&ide_setting_sem);
>  	return 0;
>  abort:
> -	up(&ide_setting_sem);
>  	if (setting)
>  		kfree(setting);
>  	return -1;
> @@ -1058,7 +1282,7 @@
>  EXPORT_SYMBOL(ide_add_setting);

this breaks locking for IDE device drivers which also call ide_add_setting()
but they are not holding ide_setting_sem

>  /**
> - *	__ide_remove_setting	-	remove an ide setting option
> + *	ide_remove_setting	-	remove an ide setting option
>   *	@drive: drive to use
>   *	@name: setting name
>   *
> @@ -1066,7 +1290,7 @@
>   *	The caller must hold the setting semaphore.
>   */
>
> -static void __ide_remove_setting (ide_drive_t *drive, char *name)
> +static void ide_remove_setting (ide_drive_t *drive, char *name)
>  {
>  	ide_settings_t **p, *setting;
>
> @@ -1144,7 +1368,7 @@
>  	setting = drive->settings;
>  	while (setting) {
>  		if (setting->auto_remove) {
> -			__ide_remove_setting(drive, setting->name);
> +			ide_remove_setting(drive, setting->name);
>  			goto repeat;
>  		}
>  		setting = setting->next;
> @@ -1322,25 +1556,19 @@
>  	return err;
>  }
>
> -int ide_atapi_to_scsi (ide_drive_t *drive, int arg)
> -{
> -	if (drive->media == ide_disk) {
> -		drive->scsi = 0;
> -		return 0;
> -	}
> -
> -	if (DRIVER(drive)->cleanup(drive)) {
> -		drive->scsi = 0;
> -		return 0;
> -	}
> -
> -	drive->scsi = (u8) arg;
> -	ata_attach(drive);
> -	return 0;
> -}
>
> +/**
> + *	ide_add_generic_settings	-	generic /proc settings
> + *	@drive: drive being configured
> + *
> + *	Add the generic parts of the system settings to the /proc files
> + *	for this IDE device. The caller must not be holding the settings_sem
> + *	.lock
> + */
> +
>  void ide_add_generic_settings (ide_drive_t *drive)
>  {
> +	down(&ide_setting_sem);
>  /*
>   *			drive	setting name		read/write access				read ioctl		write
> ioctl		data type	min	max				mul_factor	div_factor	data pointer			set
> function */
> @@ -1353,10 +1581,17 @@
> 
> 	ide_add_setting(drive,	"init_speed",		SETTING_RW,					-1,			-1,			TYPE_BYT
>E,	0,	70,				1,		1,		&drive->init_speed,		NULL);
> ide_add_setting(drive,	"current_speed",	SETTING_RW,					-1,			-1,			TYPE_BY
>TE,	0,	70,				1,		1,		&drive->current_speed,		set_xfer_rate);
> ide_add_setting(drive,	"number",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,
>	3,				1,		1,		&drive->dn,			NULL); -	if (drive->media != ide_disk)
> -		ide_add_setting(drive,	"ide-scsi",		SETTING_RW,					-1,		HDIO_SET_IDE_SC
>SI,		TYPE_BYTE,	0,	1,				1,		1,		&drive->scsi,			ide_atapi_to_scsi); +
> +	up(&ide_setting_sem);
>  }
>
> +/**
> + *	system_bus_clock	-	clock guess
> + *
> + *	External version of the bus clock guess used by old old IDE drivers
> + *	for things like VLB timings. Should not be used.
> + */
> +
>  int system_bus_clock (void)
>  {
>  	return((int) ((!system_bus_speed) ? ide_system_bus_speed() :
> system_bus_speed )); @@ -1364,52 +1599,42 @@
>
>  EXPORT_SYMBOL(system_bus_clock);
>
> -/*
> - *	Locking is badly broken here - since way back.  That sucker is
> - * root-only, but that's not an excuse...  The real question is what
> - * exclusion rules do we want here.
> +/**
> + *	ata_attach		-	attach an ATA/ATAPI device
> + *	@drive: drive to attach
> + *
> + *	Takes a drive that is as yet not assigned to any midlayer IDE
> + *	module and figures out which driver would like to own it. If
> + *	nobody claims the driver then it is automatically attached
> + *	to the default driver used for unclaimed objects.
> + *
> + *	A return of zero indicates attachment to a driver, of one
> + *	attachment to the default driver
> + *
> + *	Takes the driver list lock and the ide_settings semaphore.
>   */
> -int ide_replace_subdriver (ide_drive_t *drive, const char *driver)
> -{
> -	if (!drive->present || drive->usage || drive->dead)
> -		goto abort;
> -	if (DRIVER(drive)->cleanup(drive))
> -		goto abort;
> -	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
> -	if (ata_attach(drive)) {
> -		spin_lock(&drives_lock);
> -		list_del_init(&drive->list);
> -		spin_unlock(&drives_lock);
> -		drive->driver_req[0] = 0;
> -		ata_attach(drive);
> -	} else {
> -		drive->driver_req[0] = 0;
> -	}
> -	if (DRIVER(drive)!= &idedefault_driver && !strcmp(DRIVER(drive)->name,
> driver)) -		return 0;
> -abort:
> -	return 1;
> -}
> -
> +
>  int ata_attach(ide_drive_t *drive)
>  {
>  	struct list_head *p;
> -	spin_lock(&drivers_lock);
> +	down(&drivers_sem);
> +	down(&ide_setting_sem);
>  	list_for_each(p, &drivers) {
>  		ide_driver_t *driver = list_entry(p, ide_driver_t, drivers);
>  		if (!try_module_get(driver->owner))
>  			continue;
> -		spin_unlock(&drivers_lock);
>  		if (driver->attach(drive) == 0) {
>  			module_put(driver->owner);
>  			drive->gendev.driver = &driver->gen_driver;
> +			up(&ide_setting_sem);
> +			up(&drivers_sem);
>  			return 0;
>  		}
> -		spin_lock(&drivers_lock);
>  		module_put(driver->owner);
>  	}
>  	drive->gendev.driver = &idedefault_driver.gen_driver;
> -	spin_unlock(&drivers_lock);
> +	up(&ide_setting_sem);
> +	up(&drivers_sem);
>  	if(idedefault_driver.attach(drive) != 0)
>  		panic("ide: default attach failed");
>  	return 1;
> @@ -1549,9 +1774,11 @@
>  		}
>  	        case HDIO_UNREGISTER_HWIF:
>  			if (!capable(CAP_SYS_RAWIO)) return -EACCES;
> -			/* (arg > MAX_HWIFS) checked in function */
> -			ide_unregister(arg);
> -			return 0;
> +			if(arg > MAX_HWIFS || arg < 0)
> +				return -EINVAL;
> +			if(ide_hwifs[arg].pci_dev)
> +				return -EINVAL;

Why this change?  It prohibits all IDE PCI drivers and ide-cs
from using HDIO_UNREGISTER_HWIF ioctl (which is half-working for IDE PCI 
because next call to HDIO_SCAN_HWIF will clear hwif out due to hwif->hold == 
0 but it is not the case for ide-cs).

I hate HDIO_SCAN_HWIF and HDIO_UNREGISTER_HWIF and I still think we should 
remove them - I waited with such changes for 2.7 but this plan failed becuase 
there won't be 2.7 soon. :/

> +			return ide_unregister_hwif(&ide_hwifs[arg]);
>  		case HDIO_SET_NICE:
>  			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
>  			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP) | (1 << IDE_NICE_1))))
> @@ -2199,9 +2426,23 @@
>
>  EXPORT_SYMBOL(ide_register_subdriver);
>
> +/**
> + *	ide_unregister_subdriver	-	disconnect drive from driver
> + *	@drive: drive to unplug
> + *
> + *	Disconnect a drive from the driver it was attached to and then
> + *	clean up the various proc files and other objects attached to it.
> + *	Takes ide_sem, ide_lock, and drive_lock. Caller must hold none of
> + *	the locks.
> + *
> + *	No locking versus subdriver unload because we are moving to the
> + *	default driver anyway. Wants double checking.
> + */
> +
>  int ide_unregister_subdriver (ide_drive_t *drive)
>  {
>  	unsigned long flags;
> +	ide_proc_entry_t *dir;
>
>  	down(&ide_setting_sem);
>  	spin_lock_irqsave(&ide_lock, flags);
> @@ -2210,13 +2451,14 @@
>  		up(&ide_setting_sem);
>  		return 1;
>  	}
> +	dir = DRIVER(drive)->proc;
> +	drive->driver = &idedefault_driver;
> +	spin_unlock_irqrestore(&ide_lock, flags);
>  #ifdef CONFIG_PROC_FS
> -	ide_remove_proc_entries(drive->proc, DRIVER(drive)->proc);
> +	ide_remove_proc_entries(drive->proc, dir);
>  	ide_remove_proc_entries(drive->proc, generic_subdriver_entries);
>  #endif
>  	auto_remove_settings(drive);
> -	drive->driver = &idedefault_driver;
> -	spin_unlock_irqrestore(&ide_lock, flags);
>  	up(&ide_setting_sem);
>  	spin_lock(&drives_lock);
>  	list_del_init(&drive->list);
> @@ -2234,6 +2476,18 @@
>  	return 0;
>  }
>
> +/**
> + *	ide_register_driver	-	new driver loaded
> + *	@driver: the IDE driver module
> + *
> + *	Register a new driver module and then scan the devices
> + *	on the IDE bus in case any should be attached to the
> + *	driver we have just attached. If so attach them
> + *
> + *	Takes the drivers and drives lock. Should take the
> + *	ide_sem but doesn't - FIXME
> + */
> +
>  int ide_register_driver(ide_driver_t *driver)
>  {
>  	struct list_head list;
> @@ -2242,9 +2496,11 @@
>
>  	setup_driver_defaults(driver);
>
> +	down(&drivers_sem);
>  	spin_lock(&drivers_lock);
>  	list_add(&driver->drivers, &drivers);
>  	spin_unlock(&drivers_lock);
> +	up(&drivers_sem);
>
>  	INIT_LIST_HEAD(&list);
>  	spin_lock(&drives_lock);
> @@ -2265,13 +2521,25 @@
>
>  EXPORT_SYMBOL(ide_register_driver);
>
> +/**
> + *	ide_unregister_driver	-	IDE module unload
> + *	@driver: IDE driver module
> + *
> + *	Unload a driver module and reattach any devices to whatever
> + *	driver claims them next (typically the default driver). Takes
> + *	the drivers lock, and called functions will take the
> + *	IDE setting semaphore.
> + */
> +
>  void ide_unregister_driver(ide_driver_t *driver)
>  {
>  	ide_drive_t *drive;
>
> +	down(&drivers_sem);
>  	spin_lock(&drivers_lock);
>  	list_del(&driver->drivers);
>  	spin_unlock(&drivers_lock);
> +	up(&drivers_sem);
>
>  	driver_unregister(&driver->gen_driver);
>
> @@ -2385,7 +2653,8 @@
>  	int index;
>
>  	for (index = 0; index < MAX_HWIFS; ++index) {
> -		ide_unregister(index);
> +		if(ide_unregister_hwif(&ide_hwifs[index]))
> +			printk(KERN_ERR "ide: unload yet busy!\n");
>  		if (ide_hwifs[index].dma_base)
>  			(void) ide_release_dma(&ide_hwifs[index]);
>  	}
> diff -u --new-file --recursive --exclude-from /usr/src/exclude
> linux.vanilla-2.6.8-rc3/include/linux/ide.h
> linux-2.6.8-rc3/include/linux/ide.h ---
> linux.vanilla-2.6.8-rc3/include/linux/ide.h	2004-08-09 15:50:59.000000000
> +0100 +++ linux-2.6.8-rc3/include/linux/ide.h	2004-08-12 16:45:17.000000000
> +0100 @@ -1503,9 +1509,11 @@
>  extern void ide_pci_unregister_driver(struct pci_driver *driver);
>  extern void ide_pci_setup_ports(struct pci_dev *dev, struct
> ide_pci_device_s *d, int autodma, int pciirq, ata_index_t *index); extern
> void ide_setup_pci_noise (struct pci_dev *dev, struct ide_pci_device_s *d);
> +extern void ide_pci_remove_hwifs(struct pci_dev *dev);
>
>  extern void default_hwif_iops(ide_hwif_t *);
>  extern void default_hwif_mmiops(ide_hwif_t *);
> +extern void removed_hwif_iops(ide_hwif_t *);
>  extern void default_hwif_transport(ide_hwif_t *);
>
>  int ide_register_driver(ide_driver_t *driver);
> @@ -1603,8 +1611,9 @@
>  #endif
>
>  extern int ide_hwif_request_regions(ide_hwif_t *hwif);
> -extern void ide_hwif_release_regions(ide_hwif_t* hwif);
> -extern void ide_unregister (unsigned int index);
> +extern void ide_hwif_release_regions(ide_hwif_t *hwif);
> +extern int ide_unregister_hwif(ide_hwif_t *hwif);
> +extern int __ide_unregister_hwif(ide_hwif_t *hwif);
>
>  extern int probe_hwif_init(ide_hwif_t *);
>
>
> Signed-off-by: Alan Cox <alan@redhat.com>
