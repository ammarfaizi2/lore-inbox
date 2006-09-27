Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031175AbWI0Wtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031175AbWI0Wtb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031178AbWI0Wtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:49:31 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15564 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1031175AbWI0Wt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:49:29 -0400
Message-ID: <451AFFF7.3050707@pobox.com>
Date: Wed, 27 Sep 2006 18:49:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: [patch 1/2] libata: _GTF support
References: <20060927223441.205181000@localhost.localdomain> <20060927153627.c931de2d.kristen.c.accardi@intel.com>
In-Reply-To: <20060927153627.c931de2d.kristen.c.accardi@intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Carlson Accardi wrote:
> _GTF is an acpi method that is used to reinitialize the drive.  It returns
> a task file containing ata commands that are sent back to the drive to restore
> it to boot up defaults.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

I have minor complaints only...


> +EXPORT_SYMBOL_GPL(do_drive_get_GTF);
> +EXPORT_SYMBOL_GPL(do_drive_set_taskfiles);
> +EXPORT_SYMBOL_GPL(ata_acpi_exec_tfs);
> +
> --- 2.6-mm.orig/drivers/ata/libata-core.c
> +++ 2.6-mm/drivers/ata/libata-core.c
> @@ -90,6 +90,10 @@ static int ata_probe_timeout = ATA_TMOUT
>  module_param(ata_probe_timeout, int, 0444);
>  MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
>  
> +int noacpi;
> +module_param(noacpi, int, 0444);
> +MODULE_PARM_DESC(noacpi, "Disables the use of ACPI in suspend/resume when set");
> +
>  MODULE_AUTHOR("Jeff Garzik");
>  MODULE_DESCRIPTION("Library module for ATA devices");
>  MODULE_LICENSE("GPL");
> @@ -1597,6 +1601,9 @@ int ata_bus_probe(struct ata_port *ap)
>  	/* reset and determine device classes */
>  	ap->ops->phy_reset(ap);
>  
> +	/* retrieve and execute the ATA task file of _GTF */
> +	ata_acpi_exec_tfs(ap);
> +
>  	for (i = 0; i < ATA_MAX_DEVICES; i++) {
>  		dev = &ap->device[i];
>  
> --- 2.6-mm.orig/drivers/ata/libata.h
> +++ 2.6-mm/drivers/ata/libata.h
> @@ -43,6 +43,7 @@ extern struct workqueue_struct *ata_aux_
>  extern int atapi_enabled;
>  extern int atapi_dmadir;
>  extern int libata_fua;
> +extern int noacpi;
>  extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
>  extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
>  extern void ata_dev_disable(struct ata_device *dev);
> @@ -74,6 +75,33 @@ extern void ata_port_init(struct ata_por
>  extern struct ata_probe_ent *ata_probe_ent_alloc(struct device *dev,
>  						 const struct ata_port_info *port);
>  
> +/* libata-acpi.c */
> +#ifdef CONFIG_SATA_ACPI
> +extern int do_drive_get_GTF(struct ata_port *ap, int ix,
> +			unsigned int *gtf_length, unsigned long *gtf_address,
> +			unsigned long *obj_loc);
> +extern int do_drive_set_taskfiles(struct ata_port *ap,
> +			struct ata_device *atadev, unsigned int gtf_length,
> +			unsigned long gtf_address);
> +extern int ata_acpi_exec_tfs(struct ata_port *ap);
> +#else
> +static inline int do_drive_get_GTF(struct ata_port *ap, int ix,
> +			unsigned int *gtf_length, unsigned long *gtf_address,
> +			unsigned long *obj_loc)
> +{
> +	return 0;
> +}
> +static inline int do_drive_set_taskfiles(struct ata_port *ap,
> +                       struct ata_device *atadev,
> +                       unsigned int gtf_length, unsigned long gtf_address)
> +{
> +	return 0;
> +}
> +static inline int ata_acpi_exec_tfs(struct ata_port *ap)
> +{
> +	return 0;
> +}
> +#endif

1) No symbols should be exported to external kernel modules.   Delete 
all EXPORT_SYMBOL_GPL()

2) No symbols except for ata_acpi_exec_tfs() should be exported outside 
of the libata-acpi.c C module.  Mark everything except 
ata_acpi_exec_tfs() static, and remove the 'static inline' no-op 
functions for everything but ata_acpi_exec_tfs().

Otherwise ACK.

	Jeff


