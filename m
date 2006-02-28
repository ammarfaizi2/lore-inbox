Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWB1L66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWB1L66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbWB1L65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:58:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1759 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751617AbWB1L64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:58:56 -0500
Date: Tue, 28 Feb 2006 12:55:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org, jgarzik@pobox.com
Subject: Re: [PATCH 8/13] ATA ACPI: PATA methods
Message-ID: <20060228115533.GD4081@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135857.09929ffe.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222135857.09929ffe.randy_d_dunlap@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Add PATA support to the previous SATA support.

Does it make your CONFIG_SATA_ACPI option missnamed?

> --- linux-2616-rc4-ata.orig/drivers/scsi/libata-acpi.c
> +++ linux-2616-rc4-ata/drivers/scsi/libata-acpi.c
> @@ -35,6 +35,23 @@ struct taskfile_array {
>  	u8	tfa[REGS_PER_GTF];	/* regs. 0x1f1 - 0x1f7 */
>  };
>  
> +struct GTM_buffer {
> +	__u32	PIO_speed0;
> +	__u32	DMA_speed0;
> +	__u32	PIO_speed1;
> +	__u32	DMA_speed1;
> +	__u32	GTM_flags;
> +};

No reason to use __u32 here, u32 should be okay.

> +static int pata_get_dev_handle(struct device *dev, acpi_handle *handle,
> +					acpi_integer *pcidevfn)
> +{
> +	unsigned int domain, bus, devnum, func;
> +	acpi_integer addr;
> +	acpi_handle dev_handle, parent_handle;
> +	int scanned;
> +	struct acpi_buffer buffer = {.length = ACPI_ALLOCATE_BUFFER,
> +					.pointer = NULL};
> +	acpi_status status;
> +	struct acpi_device_info	*dinfo = NULL;
> +	int ret = -ENODEV;
> +
> +	printk(KERN_DEBUG "%s: ENTER: dev->bus_id='%s'\n",
> +		__FUNCTION__, dev->bus_id);

Have you catched some nasty disease from acpi people or what? Having
"printk(enter)" at beggining of each function may be nice for your
development, but should be removed prior to merge.

> +	if ((scanned = sscanf(dev->bus_id, "%x:%x:%x.%x",
> +			&domain, &bus, &devnum, &func)) != 4) {
> +		printk(KERN_DEBUG "%s: sscanf ret. %d\n",
> +			__FUNCTION__, scanned);
> +		goto err;
> +	}

Is there no other way than to parse back name?

> +	if (ata_msg_probe(ap))
> +		printk(KERN_DEBUG
> +			"%s: ENTER: ap->id: %d, port#: %d, hard_port#: %d\n",
> +			__FUNCTION__, ap->id,
> +		ap->port_no, ap->hard_port_no);
> +

Again, please clean your printks.
> @@ -557,11 +701,11 @@ EXPORT_SYMBOL_GPL(do_drive_set_taskfiles
>   */
>  int ata_acpi_exec_tfs(struct ata_port *ap)
>  {
> -	int ix;
> -	int ret;
> -	unsigned int gtf_length;
> -	unsigned long gtf_address;
> -	unsigned long obj_loc;
> +	int		ix;
> +	int		ret;
> +	unsigned int	gtf_length;
> +	unsigned long	gtf_address;
> +	unsigned long	obj_loc;
>  
>  	if (ata_msg_probe(ap))
>  		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);

Again!

> +void ata_acpi_get_timing(struct ata_port *ap)
> +{
> +	struct device		*dev = ap->dev;
> +	int			err;
> +	acpi_handle		dev_handle;
> +	acpi_integer		pcidevfn;
> +	acpi_handle		chan_handle;
> +	acpi_status		status;
> +	struct acpi_buffer	output;
> +	union acpi_object 	*out_obj;
> +	struct GTM_buffer	*gtm;
> +
> +	if (noacpi)
> +		goto out;
> +
> +	if (ata_msg_probe(ap))
> +		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);

Again!

> +void ata_acpi_push_timing(struct ata_port *ap)
> +{
> +	struct device		*dev = ap->dev;
> +	int			err;
> +	acpi_handle		dev_handle;
> +	acpi_integer		pcidevfn;
> +	acpi_handle		chan_handle;
> +	acpi_status		status;
> +	struct acpi_object_list	input;
> +	union acpi_object 	in_params[1];
> +
> +	if (noacpi)
> +		goto out;
> +
> +	if (ata_msg_probe(ap))
> +		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);

And again!
							Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
