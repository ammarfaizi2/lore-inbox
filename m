Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbTDYWxI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 18:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTDYWxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 18:53:07 -0400
Received: from mail0.lsil.com ([147.145.40.20]:35488 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S264541AbTDYWwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 18:52:54 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E570185F148@EXA-ATLANTA.se.lsil.com>
From: "Mukker, Atul" <atulm@lsil.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'alan@redhat.com'" <alan@redhat.com>,
       "'James.Bottomley@steeleye.com'" <James.Bottomley@steeleye.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>,
       "'linux-megaraid-announce@dell.com'" 
	<linux-megaraid-announce@dell.com>
Subject: RE: [ANNOUNCE]: version 2.00.3 megaraid driver for 2.4.x and 2.5.67 kernels
Date: Fri, 25 Apr 2003 19:04:55 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have posted the 2.00.5 driver on ftp.lsil.com/pub/linux-megaraid I have
tried to address most of your concerns in this driver except for the
following

>     b) please don't use such global arrays but always use the
>     ->hostdata field

The driver needs a global access to all adapters since it implements a
private ioctl node for applications . The applications use a single node for
all controllers


The patch for 2.5.6x is not available yet but I will announce that pretty
soon.

Thanks
-Atul Mukker <atulm@lsil.com>

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Thursday, April 17, 2003 8:38 AM
> To: Mukker, Atul
> Cc: 'alan@redhat.com'; 'James.Bottomley@steeleye.com';
> 'linux-kernel@vger.kernel.org'; 'linux-scsi@vger.kernel.org';
> 'linux-megaraid-devel@dell.com'; 'linux-megaraid-announce@dell.com'
> Subject: Re: [ANNOUNCE]: version 2.00.3 megaraid driver for 2.4.x and
> 2.5.67 kernels
> 
> 
> On Wed, Apr 16, 2003 at 04:34:22PM -0400, Mukker, Atul wrote:
> > New megaraid driver 2.00.3 is now available at
> > ftp://ftp.lsil.com/pub/linux-megaraid For this driver, a 
> patch is also
> > available for 2.5.67 kernel.
> 
> Hmm, why are you patching and announcing 2.00.3 here if 2.00.4beta is
> already out?
> 
> Anyway, here's some comments for the driver:
> 
> 
> static int hba_count;
> static adapter_t *hba_soft_state[MAX_CONTROLLERS];
> 
>     a) please avoid typedefs for structs.  Also adapter_t is a bit
>     too generic.  What about struct mega_adapter instead?
>     b) please don't use such global arrays but always use the
>     ->hostdata field.
> 
> static struct proc_dir_entry *mega_proc_dir_entry;
> 
> static struct notifier_block mega_notifier = {
> 	.notifier_call = megaraid_reboot_notify
> };
> 
>     Do you really need this?  Why can you use
>     struct device_driver->shutdown?
> 
> 
> /*
>  * megaraid_validate_parms()
>  *
>  * Validate that any module parms passed in
>  * have proper values.
>  */
> static void
> megaraid_validate_parms(void)
> {
> 	if( (max_cmd_per_lun <= 0) || (max_cmd_per_lun > 
> MAX_CMD_PER_LUN) )
> 		max_cmd_per_lun = MAX_CMD_PER_LUN;
> 	if( max_mbox_busy_wait > MBOX_BUSY_WAIT )
> 		max_mbox_busy_wait = MBOX_BUSY_WAIT;
> }
> 
>     Please run the whole driver through scripts/Lindent
> 
> 
> /**
>  * megaraid_detect()
>  * @host_template - Our soft state maintained by mid-layer
>  *
>  * the detect entry point for the mid-layer.
>  * We scan the PCI bus for our controllers and start them.
>  *
>  * Note: PCI_DEVICE_ID_PERC4_DI below represents the PERC4/Di class of
>  * products. All of them share the same vendor id, device id, 
> and subsystem
>  * vendor id but different subsystem ids. As of now, driver 
> does not use the
>  * subsystem id.
>  */
> static int
> megaraid_detect(Scsi_Host_Template *host_template)
> 
>     Please get rid of ->detect and use the new-style pci API +
>     scsi_add_host instead.
> 
> 	host_template->proc_name = "megaraid";
> 
>     CAn be initialized at compile-time.
> 
> 	printk(KERN_NOTICE "megaraid: " MEGARAID_VERSION);
> 
> 	megaraid_validate_parms();
> 
> 	memset(mega_hbas, 0, sizeof (mega_hbas));
> 
> 	hba_count = 0;
> 
>     These are in .bss
> 
> 	}
> 
> 	return;
> 
> }
>     This is superflous.
> 
> /*
>  * megaraid_proc_info()
>  *
>  * Returns data to be displayed in /proc/scsi/megaraid/X
>  */
> static int
> megaraid_proc_info(char *buffer, char **start, off_t offset, 
> int length,
> 		int host_no, int inout)
> {
> 	*start = buffer;
> 	return 0;
> }
> 
>     Just don't implement this method instead?
> 
> volatile static int internal_done_flag = 0;
> volatile static int internal_done_errcode = 0;
> 
> 
> static DECLARE_WAIT_QUEUE_HEAD (internal_wait);
> 
> static void internal_done (Scsi_Cmnd *cmd)
> {
> 	internal_done_errcode = cmd->result;
> 	internal_done_flag++;
> 	wake_up (&internal_wait);
> }
> 
> /* shouldn't be used, but included for completeness */
> 
> static int
> megaraid_command (Scsi_Cmnd *cmd)
> {
> 	internal_done_flag = 0;
> 
> 	/* Queue command, and wait until it has completed */
> 	megaraid_queue (cmd, internal_done);
> 
> 	while (!internal_done_flag)
> 		interruptible_sleep_on (&internal_wait);
> 
> 	return internal_done_errcode;
> }
> 
>     This looks horribly racy.
> 
> 
> 				return TRUE;
> 			}
> 		}
> 	}
> 
> 	return FALSE;
> }
> 
>     Please don't use TRUE/FALSE but 1/0 directly.
> 
> static int
> megadev_open (struct inode *inode, struct file *filep)
> {
> 	/*
> 	 * Only allow superuser to access private ioctl interface
> 	 */
> 	if( !capable(CAP_SYS_ADMIN) ) return -EACCES;
> 
> 	if (!try_module_get(THIS_MODULE)) {
> 		return -ENXIO;
> 	}
> 
>    This is broken as hell (and I fixed it in the old megraid driver
>    ages ago!)  Just set ->owner in the file_operation.
> 
> 	/*
> 	 * Wait till all the issued commands are complete and 
> there are no
> 	 * commands in the pending queue
> 	 */
> 	while( atomic_read(&adapter->pend_cmds) > 0 ||
> 			!list_empty(&adapter->pending_list) ) {
> 
> 		sleep_on_timeout( &wq, 1*HZ );	/* sleep for 1s */
> 	}
> 
>   Again racy.  You need to opencode this (similar to wait_event, maybe
>   just add wait_even_timeout).
> 
> 	if (adapter->read_ldidmap) {
> 		struct list_head *pos;
> 		list_for_each(pos, &adapter->pending_list) {
> 			scb = list_entry(pos, scb_t, list);
> 
>   list_for_each_entry()?
> 
> /**
>  * mega_allocate_inquiry()
>  * @dma_handle - handle returned for dma address
>  * @pdev - handle to pci device
>  *
>  * allocates memory for inquiry structure
>  */
> static inline caddr_t
> mega_allocate_inquiry(dma_addr_t *dma_handle, struct pci_dev *pdev)
> {
> 	return pci_alloc_consistent(pdev, 
> sizeof(mega_inquiry3), dma_handle);
> }
> 
> 
> static inline void
> mega_free_inquiry(caddr_t inquiry, dma_addr_t dma_handle, 
> struct pci_dev *pdev)
> {
> 	pci_free_consistent(pdev, sizeof(mega_inquiry3), 
> inquiry, dma_handle);
> }
> 
> Do you really need a wrapper for those?
> 
> 
> 
> 	/*
> 	 * For all internal commands, the buffer must be 
> allocated in <4GB
> 	 * address range
> 	 */
> 	if( make_local_pdev(adapter, &pdev) != 0 ) return -1;
> 
>     So use dma_alloc_coherent with a GFP_KERNEL arg instead 
> of such ugly hacks.
> 
> 	/*
> 	 * Wait till this command finishes. Do not use
> 	 * wait_event_interruptible(). It causes panic if 
> CTRL-C is hit when
> 	 * dumping e.g., physical disk information through 
> /proc interface.
> 	 */
> #if 0
> 	wait_event_interruptible(adapter->int_waitq, scmd->state);
> #endif
> 	wait_event(adapter->int_waitq, scmd->state);
> 
>     Maybe you need to actually look at wait_event_interruptible and
>     handle it's return value? :)
> 
> 
> static Scsi_Host_Template driver_template = MEGARAID;
> 
>     Get rid of the ugly macro and add the members right here.
> 
> While we're at it:  Please also get rid of all those prototypes in
> megaraid.h
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
