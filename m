Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752807AbWKFMOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbWKFMOM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbWKFMOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:14:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:64742 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752807AbWKFMOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:14:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FtLBYAPynksNRDzBs+Rth8ruokR5RlbkeLXF/2yRQMNRiFG6TSIKQOSboWnQ/jEJ21/sKHX/NL48i2PESPI7Ov9TlDKUngyflewSP+4ENwDVpj/fQwt8bDfhrIrAOaYZhYouF2hnxjFvxyDH1oMarhRKAjKkwFBh6c/0KvYqbpk=
Message-ID: <454F2708.2090705@gmail.com>
Date: Mon, 06 Nov 2006 21:14:00 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Luugi Marsan <luugi.marsan@amd.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Workaround for SB600 SATA ODD issue
References: <20061103190004.9ED8DCBD48@localhost.localdomain>
In-Reply-To: <20061103190004.9ED8DCBD48@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Luugi Marsan wrote:
> From: conke.hu@amd.com
> 
> There was an ASIC bug in the SB600 SATA controller of low revision (<=13) and CD burning may hang (only SATA ODD has this issue, and SATA HDD works well). The patch provides a workaround for this issue.
> 
> Signed-off-by:  Luugi Marsan <luugi.marsan@amd.com>

As others have pointed out, code style seems a bit odd.

> --- linux-2.6.19-rc4-git5/drivers/ata/ahci.c.orig       2006-11-04 03:56:22.000000000 +0800
> +++ linux-2.6.19-rc4-git5/drivers/ata/ahci.c    2006-11-04 04:20:36.000000000 +0800
> @@ -189,6 +189,7 @@ struct ahci_host_priv {
>         unsigned long           flags;
>         u32                     cap;    /* cache of HOST_CAP register */
>         u32                     port_map; /* cache of HOST_PORTS_IMPL reg */
> +       u8                      rev;    /* PCI Revision ID */
>  };
>  
>  struct ahci_port_priv {
> @@ -220,6 +221,7 @@ static int ahci_port_resume(struct ata_p
>  static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
>  static int ahci_pci_device_resume(struct pci_dev *pdev);
>  static void ahci_remove_one (struct pci_dev *pdev);
> +static int ahci_check_atapi_dma(struct ata_queued_cmd *qc);
>  
>  static struct scsi_host_template ahci_sht = {
>         .module                 = THIS_MODULE,
> @@ -251,6 +253,8 @@ static const struct ata_port_operations
>  
>         .tf_read                = ahci_tf_read,
>  
> +       .check_atapi_dma        = ahci_check_atapi_dma,
> +
>         .qc_prep                = ahci_qc_prep,
>         .qc_issue               = ahci_qc_issue,
>  

Please make a separate port ops for broken controllers and use it only 
for broken controllers.  Say, ahci_old_sb600_ops?

> @@ -906,6 +910,28 @@ static unsigned int ahci_fill_sg(struct
>         return n_sg;
>  }
>  
> +static int ahci_check_atapi_dma(struct ata_queued_cmd *qc)
> +{
> +       struct pci_dev *pdev = to_pci_dev(qc->ap->host->dev);
> +      
> +       /* walkaround for SB600 SATA ODD isuue */

s/walkaround/workaround/

> +       if (0x1002 == pdev->vendor && 0x4380 == pdev->device)
> +       {
> +               struct ahci_host_priv *priv = qc->ap->host->private_data;
> +               u32 rq_len, low_8k;
> +
> +               if ( 13 < priv->rev )
> +                       return 0;
> +
> +               rq_len = qc->scsicmd->request_bufflen;
> +               low_8k = rq_len & 0x1fff;
> +
> +               if ( (rq_len & 0xffffe000) && low_8k && (512 > low_8k) )
> +                       return 1;
> +       }
> +       return 0;
> +}

And you won't need vendor/device/rev check...

> @@ -1366,6 +1392,7 @@ static int ahci_host_init(struct ata_pro
>  
>         hpriv->cap = readl(mmio + HOST_CAP);
>         hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
> +       pci_read_config_byte(pdev, PCI_REVISION_ID, &hpriv->rev);
>         probe_ent->n_ports = (hpriv->cap & 0x1f) + 1;
>  
>         VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n", 

if you use ahci_old_sb600_ops only for controller which have the 
problem.  e.g. Do something like the following in ahci_host_init()

	/* probe_ent initialization from port_info */

	if (vendor, device and rev match)
		probe_ent->port_ops = ahci_old_sb600_ops;

-- 
tejun
