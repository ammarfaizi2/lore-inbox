Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVCGXAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVCGXAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCGW7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:59:47 -0500
Received: from linux.us.dell.com ([143.166.224.162]:51830 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261873AbVCGWSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:18:35 -0500
Date: Mon, 7 Mar 2005 16:18:00 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: Re: [ANNOUNCE][PATCH 2.6.11 2/3] megaraid_sas: Announcing new module for LSI Logic's SAS based MegaRAID controllers
Message-ID: <20050307221800.GA11734@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E570230CC0E@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CC0E@exa-atlanta>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 10:06:00PM -0500, Bagalkote, Sreenivas wrote:
> We are announcing a driver for LSI Logic's new SAS based MegaRAID
> controllers.

I'd like to start off by thanking Sreenivas and LSI for posting this
code for comment as early as he has.  Hardware is still quite a ways
off from being in people's hands, yielding time for constructive
criticism to be taken into account before product launch.  This is a
rarity, and deserves to be acknowledged.


trivial: the driver is called megaraid_sas, yet all functions are
called megasas_foo.  Doesn't seem consistent.



> diff -Naur linux-2.6.11-orig/drivers/scsi/megaraid/megaraid_sas.c
> linux-2.6.11/drivers/scsi/megaraid/megaraid_sas.c
> +static int	megasas_init			(void);
> +static void	megasas_exit			(void);
> +
> +static int	megasas_probe_one		(struct pci_dev*, 
> +						const struct
> pci_device_id*);

[snip]

Ick, way too many function prototypes.  Please reorder your code such
that you can eliminate all of these (or as many as possible).  Define
the function before its first use.

> +MODULE_AUTHOR		("LSI Logic Corporation");

please include an email address that the authors may be reached at here.

> +/*
> + * Scsi host template for megaraid mfi driver
> + */

What is MFI?


> +static struct scsi_host_template megasas_template_g = {
> +	.proc_name			= "megaraid_sas",

No .proc_name please, you won't be exporting anything in /proc, right?

> + * File opereations structure for management interface

typo: operations

> + */
> +static struct file_operations megasas_mgmt_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= megasas_mgmt_open,
> +	.release	= megasas_mgmt_release,
> +	.fasync		= megasas_mgmt_fasync,
> +	.ioctl		= megasas_mgmt_ioctl,
> +};

You've got a private device node for your management application to
issue ioctl() calls through (akin to megaraid).  I expect you're going
to get lots of requests to move this to sysfs instead.


> +/**
> + * megasas_get_cmd : Get a command from the free pool
> + */

Trivial: your function comments don't follow
linux/Documentation/kernel-doc-nano-HOWTO.txt.


> +static inline struct megasas_cmd*
> +megasas_get_cmd( struct megasas_instance* instance )
> +{
> +	unsigned long		flags;
> +	struct megasas_cmd*	cmd;
> +
> +	spin_lock_irqsave(&instance->cmd_pool_lock, flags);

Is this ever called from interrupt context?  I couldn't easily tell.
If not, then you need not irqsave/irqrestore, yes?

> +megasas_return_cmd( struct megasas_instance* instance, struct megasas_cmd*
> cmd )
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave( &instance->cmd_pool_lock, flags );

likewise.

> +megasas_init( void )
> +	is_dma64 = (sizeof(dma_addr_t) == 8) ? 1 : 0;

This should be set after calling pci_set_dma_mask() instead of before.
Also, this then should be an instance parameter rather than driver-global.


> +
> +	/*
> +	 * Register character device node
> +	 */
> +	rval =  register_chrdev(0, "megaraid_sas_ioctl",
> &megasas_mgmt_fops);
> +
> +	if (rval < 0) {
> +		printk( KERN_ERR "megasas: failed to open device node\n" );
> +		return rval;
> +	}
> +
> +	megasas_mgmt_majorno = rval;
> +
> +	/*
> +	 * Register ourselves as PCI hotplug module
> +	 */
> +	rval = pci_module_init( &megasas_pci_driver );
> +
> +	if( rval ) 
> +		printk(KERN_ERR "megasas: PCI hotplug regisration failed
> \n");
> +
> +	return rval;

You could return an error here (so the module won't stay loaded) even
though register_chrdev() succeeded.  Leak of the chrdev.


> +megasas_exit( void )
> +	printk( KERN_NOTICE "megasas: unloaded the driver\n" );

unnecessary.

> +megasas_probe_one( struct pci_dev *pdev, const struct pci_device_id *id )
> +	printk( KERN_INFO "megasas: probe new device "

trivial: why print "probe new device" ?

> +	/*
> +	 * PCI prepping: enable device set bus mastering and dma mask
> +	 */
> +	if (pci_enable_device(pdev)) {
> +		printk( KERN_ERR "megasas: pci_enable_device failed\n");
> +		return -ENODEV;
> +	}

Instead, store the return value of pci_enable_device() and return
that.  Don't bother with the printk.


> +	/*
> +	 * All our contollers are capable of performing 64-bit DMA
> +	 */

This is true for the mailboxes (or equivalent) as well as the I/O data?

> +	if (is_dma64) {
> +		if (pci_set_dma_mask( pdev, DMA_64BIT_MASK) != 0) {
> +
> +			printk( KERN_WARNING "megasas: failed to set 64 bit
> \
> +					dma mask; trying 32 bit mask\n" );

Please don't print this at KERN_WARNING, you'll only scare sysadmins.
Neither printks are strictly necessary.


> +	/*
> +	 * Initiate AEN
> +	 */

What is AEN?

> +	if (megasas_start_aen(instance)) {
> +		printk( KERN_WARNING "megasas: failed to initiate aen\n" );
> +	}

and why does it matter to a sysadmin (again, KERN_WARNING level)?
What does it affect, and what can they do about it (besides call tech support)?



> +megasas_detach_one( struct pci_dev *pdev )
> +	if( !instance ) {
> +		printk( KERN_ERR "megasas: Invalid detach\n" );

This would seem to be a debug message, rather than a KERN_ERR level.


> +megasas_shutdown_controller( struct megasas_instance* instance )
> +	dcmd->mbox[0]			= MR_ENABLE_DRIVE_SPINDOWN;

Is spinning down drives here such a good idea?  Consider a
multi-initiator cluster scenario.

> +megasas_init_mfi( struct megasas_instance* instance )
> +	if (!instance->reply_queue) {
> +		printk( KERN_ERR "megasas: Out of DMA memory\n" );

add "for reply queue" so we see what function is failing.


> +	/*
> +	 * Prepare a init frame. Note the init frame points to queue info
> +	 * structure. Each frame has SGL allocated after first 64 bytes. For
> +	 * this frame - since we don't need any SGL - we use SGL's space as
> +	 * queue info structure
> +	 */
> +	cmd = megasas_get_cmd( instance );

no check for cmd=NULL

> +	if (!megasas_get_ctrl_info( instance, &ctrl_info ))
> +		instance->max_sectors_per_req = ctrl_info.max_request_size;
> +	else
> +		instance->max_sectors_per_req = instance->max_num_sge *
> +						PAGE_SIZE / 512;

This assumes a worst-case size of one 512-byte entry in each SGE, yes?
Seems like this would yield a pretty small value, but as max_num_sge
apparently comes from querying the adapter, maybe you never hit this
clause?

> +megasas_alloc_cmds( struct megasas_instance* instance )
> +	max_cmd = instance->max_fw_cmds;
> +
> +	/* 
> +	 * Alloc mem for all cmds in one chunk 
> +	 */
> +	instance->cmd_list = kmalloc( sizeof(struct megasas_cmd) * max_cmd,
> +								GFP_KERNEL);

How large is max_cmd?  It's given to us by the firmware.  Could this
wind up being larger than the (current) 128KB kmalloc() limit ever
(i.e. future firmwares that can handle more commands)?

Perhaps requiring this to be one chunk isn't a good idea


> +	/* 
> +	 * Slice cmd_list into individual cmds and add to cmd_pool 
> +	 */
> +	for( i = 0, cmd = instance->cmd_list; i < max_cmd; i++, cmd++ ) {
> +		cmd->index = i;
> +		list_add_tail( &cmd->list, &instance->cmd_pool );
> +	}

especially when the next thing you do is split it into chunks anyway.

> +
> +	/* 
> +	 * Create a frame pool and assign one frame to each cmd 
> +	 */
> +	if (megasas_create_frame_pool( instance )) {
> +		printk(KERN_ERR "megasas: error creating DMA pool\n");

trivial: message doesn't appear to match failing function (frame pool
vs DMA pool).  Please be consistent.


> +/**
> + * megasas_free_cmds
> + */
> +static void
> +megasas_free_cmds( struct megasas_instance* instance )
> +{
> +	/* First free the MFI frame pool */
> +	megasas_teardown_frame_pool( instance );
> +
> +	/* Free the cmd_list buffer itself */
> +	if (instance->cmd_list ) {
> +		kfree( instance->cmd_list );
> +		instance->cmd_list = NULL;

It's safe to call kfree() without checking for NULL.  So this just
becomes:

 +	/* Free the cmd_list buffer itself */
 +	kfree( instance->cmd_list );
 +	instance->cmd_list = NULL;



> +megasas_create_frame_pool( struct megasas_instance* instance )
> +	instance->frame_dma_pool = pci_pool_create( "megasas frame pool",
> +					instance->pdev, total_sz, 64, 0 );
> +
> +	instance->sense_dma_pool = pci_pool_create( "megasas sense pool",
> +					instance->pdev, 128, 4, 0 );
> +
> +	if (!instance->frame_dma_pool || !instance->sense_dma_pool) {
> +		printk( KERN_ERR "megasas: failed to setup DMA pool\n" );
> +		return -ENOMEM;
> +	}

If the second pci_pool_create() fails, you leak the first pool.



> +
> +	/*
> +	 * Allocate and attach a frame to each of the commands in cmd_list.
> +	 * By making cmd->index as the context instead of the &cmd, we can
> +	 * always use 32bit context regardless of the architecture
> +	 */
> +	for( i = 0, cmd = instance->cmd_list; i < max_cmd; i++, cmd++ ) {
> +
> +		cmd->frame = pci_pool_alloc( instance->frame_dma_pool, 
> +				GFP_KERNEL, &cmd->frame_phys_addr );
> +
> +		cmd->sense = pci_pool_alloc( instance->sense_dma_pool,
> +				GFP_KERNEL, &cmd->sense_phys_addr );
> +
> +		if (!cmd->frame || !cmd->sense) {
> +			printk(KERN_ERR "megasas: pci_pool_alloc failed
> \n");
> +			megasas_teardown_frame_pool( instance );
> +			return -ENOMEM;
> +		}

If the second pci_pool_create() fails, you leak the first pool.



> +megasas_register_aen( struct megasas_instance* instance, uint32_t seq_num,
> +	uint32_t*			mbox_word;

s/uint32_t/u32/ everywhere.  Likewise for the other sizes.

> +megasas_reset_handler( struct scsi_cmnd* scmd )

This reset command doesn't do anything except wait and hope.  Any
chance there's a way to do a write to a bit in your adapter PCI
config space to force an adapter reset?  Or some other manner?  This
is a long-standing issue with the other LSI RAID cards too - you can't
effectively abort an issued command, and you can't reset the adapter
from the driver.  Many of the megaraid issues seen by customers over
time is from adapter firmwares going catatonic.  Having a real method
to reset the adapter would benefit users.



> +/**
> + * megasas_build_dcdb
> + */

What is a dcdb?



> +/**
> + * megasas_mgmt_open
> + */
> +static int	
> +megasas_mgmt_open( struct inode* inode, struct file* filep )

Could you consider moving the management device code into a separate
file?  This is getting long already...

> +/**
> + * megasas_mgmt_ioctl
> + */
> +static int	
> +megasas_mgmt_ioctl( struct inode* inode, struct file* filep,
> +			unsigned int cmd, unsigned long arg )
> +{
> +	int				i;
> +	int				j;
> +	int				rc;
> +	uint8_t				fw_status;
> +	struct iocpacket		uioc;

This is ~200 bytes.  Seems large to put on the (4KB) stack.


> +	case MR_LINUX_GET_ADAPTER_MAP:
> +		/*
> +		 * README: encrypting logic for adapter map
> +		 * The adpater field size allows up to 16-bit adapter
> number,
> +		 * which translates into 65536 possible adapters, which
> +		 * obviously is too much. So we reserve the lower 4-bits to
> +		 * put the coding nibble (0xF) and add 1 to the adapter
> +		 * number. Applications shall have (12-bits - 1) to provide
> +		 * the adapter number. This still translates in 4095
> possible
> +		 * adapters, which should be  sufficient :-)
> +		*/

While confusing, I appreciate the large comment about it.

> +/**
> + * megasas_mgmt_fw_smp

What is SMP in this instance?

> +/* vim: set ts=8 sw=8 tw=78 ai si: */

unnecessary.  megaraid is about the only driver in the tree with
such a line (one USB serial dongle has it too, but that's it).




> diff -Naur linux-2.6.11-orig/drivers/scsi/megaraid/megaraid_sas.h
> linux-2.6.11/drivers/scsi/megaraid/megaraid_sas.h
> --- linux-2.6.11-orig/drivers/scsi/megaraid/megaraid_sas.h	1969-12-31
> 19:00:00.000000000 -0500
> +++ linux-2.6.11/drivers/scsi/megaraid/megaraid_sas.h	2005-03-05
> 21:41:25.503377336 -0500




> +struct megasas_ctrl_prop {
> +
> +	uint16_t	seq_num;

Covered above, but again, use u16 rather than uint16_t.  Likewise
their equivalents.


There's virtually no information exposed via sysfs.  That would be a
welcome addition.  A RAID device transport, exposing data common to
logical drives (RAID level, stripe size, health, cache mode, ...).

Very good start though.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
