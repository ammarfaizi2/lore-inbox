Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVERAAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVERAAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVEQX76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:59:58 -0400
Received: from mail0.lsil.com ([147.145.40.20]:668 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262043AbVEQX4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:56:16 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57060CCE99@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>
Subject: RE: [PATCH 2.6.12-rc4-mm1 3/4] megaraid_sas: updating the driver
Date: Tue, 17 May 2005 19:51:14 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph, thank you for your extensive review.

>
>On Mon, May 16, 2005 at 02:57:15AM -0400, Bagalkote, Sreenivas wrote:
>> +#include "megaraid_sas.h"
>
>Please put most of the system includes in here, not megaraid_sas.h.
>megaraid_sas.h should only include the headers absolutely 
>nessecary for it
>top compile.
>

Okay.

>> +
>> +MODULE_LICENSE		("GPL");
>> +MODULE_VERSION		(MEGASAS_VERSION);
>> +MODULE_AUTHOR		("sreenivas.bagalkote@lsil.com");
>> +MODULE_DESCRIPTION	("LSI Logic MegaRAID SAS Driver");
>
>Normal style would be:
>
>MODULE_LICENSE("GPL");
>MODULE_VERSION(MEGASAS_VERSION);
>MODULE_AUTHOR("sreenivas.bagalkote@lsil.com");
>MODULE_DESCRIPTION("LSI Logic MegaRAID SAS Driver");
>

I will remove the alignment. I am curious however, to know
why this is less readable or against the normal style.

>> +
>> +/*
>> + * PCI ID table for all supported controllers
>> + */
>> +static struct pci_device_id megasas_pci_table_g[] = {
>
>can be const

Okay. I will make it a constant.

>
>> +static	int				megasas_mgmt_majorno;
>> +static	struct megasas_mgmt_info	megasas_mgmt_info;
>> +static	struct fasync_struct*		megasas_async_queue;
>> +static	DECLARE_MUTEX			
>(megasas_async_queue_mutex);
>
>simiar a kind odd style.  especially the * placement is very odd as
>* is a mofifier on the variable and not the type in C (you have that
>a few times more below).  should be more like:
>
>static int megasas_mgmt_majorno;
>static struct megasas_mgmt_info	megasas_mgmt_info;
>static struct fasync_struct *megasas_async_queue;
>static DECLARE_MUTEX(megasas_async_queue_mutex);
>

I will change the * placement. But does the alignment (of data types and
variables) offend Linux coding style? If it does, I will remove that.

>or better not at all.  As this is all part of your rather questionable
>managment interface that will need some major work to sort out.
>
>While we're at it, is there a chance you could submit a basic driver
>without managment functionality after fixing up the review comments
>so that we can have it in when starting to design a better managment
>interface?
>

I will respond to all your comments about management interface in my next
post.

>> +/**
>> + * megasas_get_cmd -	Get a command from the free pool
>> + * @instance:		Adapter soft state
>> + *
>> + * Returns a free command from the pool
>> + */
>> +static inline struct megasas_cmd*
>> +megasas_get_cmd( struct megasas_instance* instance )
>> +{
>> +	unsigned long		flags;
>> +	struct megasas_cmd*	cmd;
>> +
>> +	spin_lock_irqsave(&instance->cmd_pool_lock, flags);
>> +
>> +	if ( list_empty(&instance->cmd_pool)) {
>> +		spin_unlock_irqrestore(&instance->cmd_pool_lock, flags);
>> +		return NULL;
>> +	}
>> +
>> +	cmd = list_entry((&instance->cmd_pool)->next, struct 
>megasas_cmd,
>> list);
>> +
>> +	list_del_init( &cmd->list );
>> +
>> +	spin_unlock_irqrestore( &instance->cmd_pool_lock, flags );
>> +
>> +	return cmd;
>> +}
>
>Again this is very different style from normal linux.  Please 
>read through
>Documentation/CodingStyle and look at some other drivers, e.g.
>drivers/net/tg3.c for how Linux code is written.  This function should
>for example look like:
>
>/**
> * megasas_get_cmd -	Get a command from the free pool
> * @instance:		Adapter soft state
> *
> * Returns a free command from the pool
> */
>static inline struct megasas_cmd *
>megasas_get_cmd(struct megasas_instance *instance)
>{
>	struct megasas_cmd *cmd = NULL;
>	unsigned long flags;
>
>	spin_lock_irqsave(&instance->cmd_pool_lock, flags);
>	if (!list_empty(&instance->cmd_pool)) {
>		cmd = list_entry(instance->cmd_pool.next,
>				 struct megasas_cmd, list);
>		list_del_init(&cmd->list);
>	}
>	spin_unlock_irqrestore(&instance->cmd_pool_lock, flags);
>	return cmd;
>}
>

Not that you pointed it out, it looks obvious. I will change all
such occurences. Thank you.

>> +static int
>> +megasas_issue_polled(struct megasas_instance* instance, 
>struct megasas_cmd*
>> cmd)
>> +{
>> +	int	i;
>> +	u32	msecs = MFI_POLL_TIMEOUT_SECS * 1000;
>> +
>> +	struct megasas_header* frame_hdr = (struct
>> megasas_header*)cmd->frame;
>
>megasas_header is one of the member of union megasas_frame, 
>which is the
>type of cmd->frame.  Please use Cs static typing.
>

Could you please elaborate this point? Are you saying use:
struct megasas_header* frame_hdr = &cmd->frame->hdr instead of what
I have above? If that's what you have in mind, then yes, I will do that.

>> +	for( i=0; i < msecs && (frame_hdr->cmd_status == 0xff); i++ ) {
>> +		rmb();
>> +		msleep(1);
>> +	}
>
>who is supposed to change frame_hdr->cmd_status while this 
>loop is running?

In the previous statement, I am issuing the frame to the FW. FW will
change the cmd_status. I will add a comment.

>
>> +	if (!scp->use_sg) {
>> +		page	= virt_to_page( scp->request_buffer );
>> +		offset	= ((unsigned long)scp->request_buffer & 
>~PAGE_MASK);
>> +
>> +		mfi_sgl->sge32[0].phys_addr	=
>> pci_map_page(instance->pdev,
>> +							page, offset,
>
>please use pci_map_single and avoid all the black magic on the virtual
>address.
>

Okay. I will change this.

>> +		page	= virt_to_page( scp->request_buffer );
>> +		offset	= ((unsigned long)scp->request_buffer & 
>~PAGE_MASK);
>> +
>> +		mfi_sgl->sge64[0].phys_addr	=
>> pci_map_page(instance->pdev,
>> +							page, offset,
>> +
>> scp->request_bufflen,
>> +
>> scp->sc_data_direction);
>
>dito.
>

I will change here also.

>> +	cmd = megasas_build_cmd( instance, scmd, &frame_count );
>> +
>> +	if (!cmd) {
>> +		done(scmd);
>> +		return 0;
>
>I think this should return HOST_BUSY?
>

I will add a readable comment here. I return NULL cmd when I can complete
the command from queue routine itself.

>> +/**
>> + * megasas_abort_handler -	Abort entry point
>> + * @scmd:			SCSI command to be aborted
>> + */
>> +static int
>> +megasas_abort_handler( struct scsi_cmnd* scmd )
>> +{
>> +	printk( KERN_NOTICE "megasas: ABORT -%ld cmd=%x <c=%d 
>t=%d l=%d>\n",
>> +		scmd->serial_number, scmd->cmnd[0], SCP2CHANNEL(scmd),
>> +		SCP2TARGET(scmd), SCP2LUN(scmd));
>> +
>> +	return FAILED;
>> +}
>
>I don't think you should implement an abort handler at all if you
>don't do anything.
>

My reset handler will still get called, won't it be? Moreover, isn't
it a good diagnostic message to be printed from abort handler? Please
consider.

>> +/*
>> + * Scsi host template for megaraid_sas driver
>> + */
>> +static struct scsi_host_template megasas_template_g = {
>
>please remove the _g postix.
>

Okay.

>> +
>> +	.module				= THIS_MODULE,
>> +	.name				= "LSI Logic SAS based MegaRAID
>> driver",
>> +	.queuecommand			= megasas_queue_command,
>> +	.eh_abort_handler		= megasas_abort_handler,
>> +	.eh_device_reset_handler	= megasas_reset_device,
>> +	.eh_bus_reset_handler		= megasas_reset_bus_host,
>> +	.eh_host_reset_handler		= megasas_reset_bus_host,
>> +	.use_clustering			= ENABLE_CLUSTERING,
>> +	.shost_attrs			= megasas_shost_attrs,
>> +};
>
>> +static inline void
>> +megasas_sync_buffers(struct megasas_instance* instance, 
>struct megasas_cmd*
>
>
>this is a really odd name for a function that calls the dma unmapping
>functions.
>

Okay, I will change the name.

>> +			spin_lock( instance->host_lock );
>> +			cmd->scmd->scsi_done( cmd->scmd );
>> +			spin_unlock( instance->host_lock );
>
>no need to lock around ->scsi_done
>

Thanks. I will remove the lock.

>> +	/*
>> +	 * instance->cmd_list is an array of struct megasas_cmd 
>pointers.
>> +	 * Allocate the dynamic array first and then allocate individual
>> +	 * commands.
>> +	 */
>> +	instance->cmd_list = kmalloc( sizeof(struct 
>megasas_cmd*) * max_cmd,
>> +								
>GFP_KERNEL
>> );
>> +
>> +	if (!instance->cmd_list) {
>> +		printk( KERN_DEBUG "megasas: out of memory\n" );
>> +		return -ENOMEM;
>> +	}
>> +
>> +	memset( instance->cmd_list, 0, sizeof(struct 
>megasas_cmd*) * max_cmd
>
>you can use kcalloc here
>

Okay.

>> +/**
>> + * megasas_io_attach -	Attaches this driver to SCSI mid-layer
>> + * @instance:		Adapter soft state
>> + */
>> +static int
>> +megasas_io_attach( struct megasas_instance* instance )
>> +{
>> +	struct Scsi_Host* host;
>> +
>> +	host = scsi_host_alloc(&megasas_template_g, sizeof(void*));
>> +
>> +	if (!host) {
>> +		printk( KERN_DEBUG "megasas: scsi_host_alloc 
>failed\n" );
>> +		return -ENODEV;
>> +	}
>
>please allocate the scsi_host directly and early in your probe routing,
>so you can allocate your private data directly through scsi_host_alloc
>

The instance is allocated on DMA memory. scsi_host_alloc uses kmalloc().
I allocate instance on DMA memory because some of its members get their
values refreshed from FW. Currently only producer and consumer are used. But
in near future, we will have more such members.

>> +	SCSIHOST2ADAP(host)	= (caddr_t) instance;
>
>please don't use caddr_t in kernel code.
>

Okay.

>> +	instance->host		= host;
>> +
>> +	/*
>> +	 * Export parameters required by SCSI mid-layer
>> +	 */
>> +	scsi_assign_lock( host, instance->host_lock );
>
>never use scsi_assign_lock in new drivers.
>

Yes, of course. Thanks.

>> +	scsi_set_device( host, &instance->pdev->dev );
>
>not needed, as it's done by scsi_add_host
>

Okay. This will be removed.

>> +	/*
>> +	 * Notify the mid-layer about the new controller
>> +	 */
>> +	if (scsi_add_host(host, &instance->pdev->dev)) {
>
>this should be done at the end of your probe routine.
>

It is indeed being done at the end of the probe routine.

>> +/**
>> + * megasas_io_detach -	Detach the driver from SCSI mid-layer
>> + * @instance:		Adapter soft state
>> + */
>> +static void
>> +megasas_io_detach( struct megasas_instance* instance )
>> +{
>> +	if (instance->host)
>> +		scsi_remove_host( instance->host );
>> +}
>
>please avoid that wrapper.  Also you shouldn't need the if
>

Okay. I will remove megasas_io_detach() function.

>> +	instance->host_lock = &instance->lock;
>
>please avoid using the host_lock pointer.
>

Okay. Am I allowed to use scsi host's per-host lock inside my
reset handler? Is my usage of lock inside the reset_handler correct?

>> + * @device:		Generic device structure
>> + */
>> +static void
>> +megasas_shutdown( struct device* device )
>> +{
>> +	int				i;
>> +	struct megasas_instance*	instance;
>> +
>> +	for( i = 0; i < megasas_mgmt_info.max_index; i++ ) {
>> +		instance = megasas_mgmt_info.instance[i];
>> +
>> +		if (instance)
>> +			megasas_shutdown_controller( instance );
>> +	}
>
>this doesn't make any sense.  you must only shutdown the instance you
>were called for.  Use drv_get_drvdata to get it from the 
>devices private
>data.
>

Okay. I will change that. That was dumb.

>> +/**
>> + * megasas_mgmt_ioctl -	char node ioctl entry point
>> + *

Please allow me to respond to your comments about management interface in
later post.

Thank you very much.

Sincerely,
Sreenivas Bagalkote
