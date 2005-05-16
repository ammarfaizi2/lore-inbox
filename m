Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVEPOw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVEPOw1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVEPOw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:52:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54958 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261669AbVEPOuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:50:44 -0400
Date: Mon, 16 May 2005 15:50:41 +0100
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH 2.6.12-rc4-mm1 3/4] megaraid_sas: updating the driver
Message-ID: <20050516145041.GA25156@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Bagalkote, Sreenivas" <sreenib@lsil.com>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
	Andrew Morton <akpm@osdl.org>,
	'James Bottomley' <James.Bottomley@SteelEye.com>
References: <0E3FA95632D6D047BA649F95DAB60E57060CCE7C@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CCE7C@exa-atlanta>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 02:57:15AM -0400, Bagalkote, Sreenivas wrote:
> +#include "megaraid_sas.h"

Please put most of the system includes in here, not megaraid_sas.h.
megaraid_sas.h should only include the headers absolutely nessecary for it
top compile.

> +
> +MODULE_LICENSE		("GPL");
> +MODULE_VERSION		(MEGASAS_VERSION);
> +MODULE_AUTHOR		("sreenivas.bagalkote@lsil.com");
> +MODULE_DESCRIPTION	("LSI Logic MegaRAID SAS Driver");

Normal style would be:

MODULE_LICENSE("GPL");
MODULE_VERSION(MEGASAS_VERSION);
MODULE_AUTHOR("sreenivas.bagalkote@lsil.com");
MODULE_DESCRIPTION("LSI Logic MegaRAID SAS Driver");

> +
> +/*
> + * PCI ID table for all supported controllers
> + */
> +static struct pci_device_id megasas_pci_table_g[] = {

can be const

> +static	int				megasas_mgmt_majorno;
> +static	struct megasas_mgmt_info	megasas_mgmt_info;
> +static	struct fasync_struct*		megasas_async_queue;
> +static	DECLARE_MUTEX			(megasas_async_queue_mutex);

simiar a kind odd style.  especially the * placement is very odd as
* is a mofifier on the variable and not the type in C (you have that
a few times more below).  should be more like:

static int megasas_mgmt_majorno;
static struct megasas_mgmt_info	megasas_mgmt_info;
static struct fasync_struct *megasas_async_queue;
static DECLARE_MUTEX(megasas_async_queue_mutex);

or better not at all.  As this is all part of your rather questionable
managment interface that will need some major work to sort out.

While we're at it, is there a chance you could submit a basic driver
without managment functionality after fixing up the review comments
so that we can have it in when starting to design a better managment
interface?

> +/**
> + * megasas_get_cmd -	Get a command from the free pool
> + * @instance:		Adapter soft state
> + *
> + * Returns a free command from the pool
> + */
> +static inline struct megasas_cmd*
> +megasas_get_cmd( struct megasas_instance* instance )
> +{
> +	unsigned long		flags;
> +	struct megasas_cmd*	cmd;
> +
> +	spin_lock_irqsave(&instance->cmd_pool_lock, flags);
> +
> +	if ( list_empty(&instance->cmd_pool)) {
> +		spin_unlock_irqrestore(&instance->cmd_pool_lock, flags);
> +		return NULL;
> +	}
> +
> +	cmd = list_entry((&instance->cmd_pool)->next, struct megasas_cmd,
> list);
> +
> +	list_del_init( &cmd->list );
> +
> +	spin_unlock_irqrestore( &instance->cmd_pool_lock, flags );
> +
> +	return cmd;
> +}

Again this is very different style from normal linux.  Please read through
Documentation/CodingStyle and look at some other drivers, e.g.
drivers/net/tg3.c for how Linux code is written.  This function should
for example look like:

/**
 * megasas_get_cmd -	Get a command from the free pool
 * @instance:		Adapter soft state
 *
 * Returns a free command from the pool
 */
static inline struct megasas_cmd *
megasas_get_cmd(struct megasas_instance *instance)
{
	struct megasas_cmd *cmd = NULL;
	unsigned long flags;

	spin_lock_irqsave(&instance->cmd_pool_lock, flags);
	if (!list_empty(&instance->cmd_pool)) {
		cmd = list_entry(instance->cmd_pool.next,
				 struct megasas_cmd, list);
		list_del_init(&cmd->list);
	}
	spin_unlock_irqrestore(&instance->cmd_pool_lock, flags);
	return cmd;
}

> +static int
> +megasas_issue_polled(struct megasas_instance* instance, struct megasas_cmd*
> cmd)
> +{
> +	int	i;
> +	u32	msecs = MFI_POLL_TIMEOUT_SECS * 1000;
> +
> +	struct megasas_header* frame_hdr = (struct
> megasas_header*)cmd->frame;

megasas_header is one of the member of union megasas_frame, which is the
type of cmd->frame.  Please use Cs static typing.

> +	for( i=0; i < msecs && (frame_hdr->cmd_status == 0xff); i++ ) {
> +		rmb();
> +		msleep(1);
> +	}

who is supposed to change frame_hdr->cmd_status while this loop is running?

> +	if (!scp->use_sg) {
> +		page	= virt_to_page( scp->request_buffer );
> +		offset	= ((unsigned long)scp->request_buffer & ~PAGE_MASK);
> +
> +		mfi_sgl->sge32[0].phys_addr	=
> pci_map_page(instance->pdev,
> +							page, offset,

please use pci_map_single and avoid all the black magic on the virtual
address.

> +		page	= virt_to_page( scp->request_buffer );
> +		offset	= ((unsigned long)scp->request_buffer & ~PAGE_MASK);
> +
> +		mfi_sgl->sge64[0].phys_addr	=
> pci_map_page(instance->pdev,
> +							page, offset,
> +
> scp->request_bufflen,
> +
> scp->sc_data_direction);

dito.

> +	cmd = megasas_build_cmd( instance, scmd, &frame_count );
> +
> +	if (!cmd) {
> +		done(scmd);
> +		return 0;

I think this should return HOST_BUSY?

> +/**
> + * megasas_abort_handler -	Abort entry point
> + * @scmd:			SCSI command to be aborted
> + */
> +static int
> +megasas_abort_handler( struct scsi_cmnd* scmd )
> +{
> +	printk( KERN_NOTICE "megasas: ABORT -%ld cmd=%x <c=%d t=%d l=%d>\n",
> +		scmd->serial_number, scmd->cmnd[0], SCP2CHANNEL(scmd),
> +		SCP2TARGET(scmd), SCP2LUN(scmd));
> +
> +	return FAILED;
> +}

I don't think you should implement an abort handler at all if you
don't do anything.

> +/*
> + * Scsi host template for megaraid_sas driver
> + */
> +static struct scsi_host_template megasas_template_g = {

please remove the _g postix.

> +
> +	.module				= THIS_MODULE,
> +	.name				= "LSI Logic SAS based MegaRAID
> driver",
> +	.queuecommand			= megasas_queue_command,
> +	.eh_abort_handler		= megasas_abort_handler,
> +	.eh_device_reset_handler	= megasas_reset_device,
> +	.eh_bus_reset_handler		= megasas_reset_bus_host,
> +	.eh_host_reset_handler		= megasas_reset_bus_host,
> +	.use_clustering			= ENABLE_CLUSTERING,
> +	.shost_attrs			= megasas_shost_attrs,
> +};

> +static inline void
> +megasas_sync_buffers(struct megasas_instance* instance, struct megasas_cmd*


this is a really odd name for a function that calls the dma unmapping
functions.

> +			spin_lock( instance->host_lock );
> +			cmd->scmd->scsi_done( cmd->scmd );
> +			spin_unlock( instance->host_lock );

no need to lock around ->scsi_done

> +	/*
> +	 * instance->cmd_list is an array of struct megasas_cmd pointers.
> +	 * Allocate the dynamic array first and then allocate individual
> +	 * commands.
> +	 */
> +	instance->cmd_list = kmalloc( sizeof(struct megasas_cmd*) * max_cmd,
> +								GFP_KERNEL
> );
> +
> +	if (!instance->cmd_list) {
> +		printk( KERN_DEBUG "megasas: out of memory\n" );
> +		return -ENOMEM;
> +	}
> +
> +	memset( instance->cmd_list, 0, sizeof(struct megasas_cmd*) * max_cmd

you can use kcalloc here

> +/**
> + * megasas_io_attach -	Attaches this driver to SCSI mid-layer
> + * @instance:		Adapter soft state
> + */
> +static int
> +megasas_io_attach( struct megasas_instance* instance )
> +{
> +	struct Scsi_Host* host;
> +
> +	host = scsi_host_alloc(&megasas_template_g, sizeof(void*));
> +
> +	if (!host) {
> +		printk( KERN_DEBUG "megasas: scsi_host_alloc failed\n" );
> +		return -ENODEV;
> +	}

please allocate the scsi_host directly and early in your probe routing,
so you can allocate your private data directly through scsi_host_alloc

> +	SCSIHOST2ADAP(host)	= (caddr_t) instance;

please don't use caddr_t in kernel code.

> +	instance->host		= host;
> +
> +	/*
> +	 * Export parameters required by SCSI mid-layer
> +	 */
> +	scsi_assign_lock( host, instance->host_lock );

never use scsi_assign_lock in new drivers.

> +	scsi_set_device( host, &instance->pdev->dev );

not needed, as it's done by scsi_add_host

> +	/*
> +	 * Notify the mid-layer about the new controller
> +	 */
> +	if (scsi_add_host(host, &instance->pdev->dev)) {

this should be done at the end of your probe routine.

> +/**
> + * megasas_io_detach -	Detach the driver from SCSI mid-layer
> + * @instance:		Adapter soft state
> + */
> +static void
> +megasas_io_detach( struct megasas_instance* instance )
> +{
> +	if (instance->host)
> +		scsi_remove_host( instance->host );
> +}

please avoid that wrapper.  Also you shouldn't need the if

> +	instance->host_lock = &instance->lock;

please avoid using the host_lock pointer.

> + * @device:		Generic device structure
> + */
> +static void
> +megasas_shutdown( struct device* device )
> +{
> +	int				i;
> +	struct megasas_instance*	instance;
> +
> +	for( i = 0; i < megasas_mgmt_info.max_index; i++ ) {
> +		instance = megasas_mgmt_info.instance[i];
> +
> +		if (instance)
> +			megasas_shutdown_controller( instance );
> +	}

this doesn't make any sense.  you must only shutdown the instance you
were called for.  Use drv_get_drvdata to get it from the devices private
data.

> +/**
> + * megasas_mgmt_ioctl -	char node ioctl entry point
> + *
> + * Few ioctl commands should be handled by driver itself (driver ioctls)
> and
> + * the rest should be converted into appropriate commands for FW and
> issued.
> + */
> +static int
> +megasas_mgmt_ioctl( struct inode* inode, struct file* filep,
> +			unsigned int cmd, unsigned long arg )

now this managmnet device is completely in-acceptable.  Not only it's
based on ioctls, but also on rather odd ones.  Things like stp and sata
passthrough don't belong into a driver at all but in a transport class.
Driver and firmware versions belong into sysfs, the adapter count can
already be found easily by looking through the sysfs subdirectory for
this driver, the purpose of the adapter map isn't completely clear to
me yet, but it should be addresses using sysfs aswell

> +#ifdef CONFIG_COMPAT
> +/**
> + * megasas_compat_ioctl -	Handles conversions from 32-bit apps
> + */
> +static int
> +megasas_compat_ioctl( struct file* filep, unsigned int cmd, unsigned long
> arg,
> +							struct file* filep )
> +{
> +	return megasas_mgmt_ioctl( NULL, filep, cmd, arg );
> +}
> +#endif

the prototype doesn't match what's expect for ->compat_ioctl..

