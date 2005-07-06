Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVGFTTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVGFTTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVGFTTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:19:31 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:16222 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262297AbVGFOFR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:05:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K807fPjemyLFDhxqDuy5BBwE+4KWTCWCK9Em6PaFKkMba1Pxs8u1uRG3DLqEM3L5Qtm4wYaVte1wHN3dAknhnZVQVPVP9YJcrRkTbrMXDx8DnJZfMI4M6lOJhDUUknctmm1GCnVZrtOt8joa7uc3UqLaI1xGc/BmdO0vs7UA/8M=
Message-ID: <58cb370e050706070512c93ee1@mail.gmail.com>
Date: Wed, 6 Jul 2005 16:05:15 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       christoph@lameter.com
In-Reply-To: <20050706133052.GF21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050706133052.GF21330@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Andi Kleen <ak@suse.de> wrote:
> 
> Without this patch a dual Xeon EM64T machine would oops on boot
> because the hwif pointer here was NULL. I also added a check for
> pci_dev because it's doubtful that all IDE devices have pci_devs.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> 
> Index: linux/drivers/ide/ide-probe.c
> ===================================================================
> --- linux.orig/drivers/ide/ide-probe.c
> +++ linux/drivers/ide/ide-probe.c
> @@ -978,8 +978,10 @@ static int ide_init_queue(ide_drive_t *d
>          *      do not.
>          */
> 
> -       q = blk_init_queue_node(do_ide_request, &ide_lock,
> -                               pcibus_to_node(drive->hwif->pci_dev->bus));
> +       int node = 0; /* Should be -1 */
> +       if (drive->hwif && drive->hwif->pci_dev)
> +               node = pcibus_to_node(drive->hwif->pci_dev->bus);
> +       q = blk_init_queue_node(do_ide_request, &ide_lock, node);
>         if (!q)
>                 return 1;

drive->hwif check is redundant, please remove it

> @@ -1096,8 +1098,13 @@ static int init_irq (ide_hwif_t *hwif)
>                 hwgroup->hwif->next = hwif;
>                 spin_unlock_irq(&ide_lock);
>         } else {
> -               hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
> -                       pcibus_to_node(hwif->drives[0].hwif->pci_dev->bus));
> +               int node = 0;
> +               if (hwif->drives[0].hwif) {
> +                       struct pci_dev *pdev = hwif->drives[0].hwif->pci_dev;
> +                       if (pdev)
> +                               node = pcibus_to_node(pdev->bus);
> +               }

ditto, moreover hwif->drives[0].hwif == hwif

> +               hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,node);
>                 if (!hwgroup)
>                         goto out_up;
