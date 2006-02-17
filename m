Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWBQI5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWBQI5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 03:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWBQI5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 03:57:16 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:14198 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964906AbWBQI5P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 03:57:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pN0aZgl2gXPjoayEteWMfX6J/ALxD9ehougTDtVGRZm1fM4gJ4YgFXvTnYSOAR1n+lM+/K/yFBFq11IDGvaTn64pQx7KPsvSd2L8gGe/WlkYQ1h0RscfSgbSLF+zSUDQI13tmzdyJnJYJb5Fpcj+ZUc+a0kjA7EwGMjif6/9iOk=
Message-ID: <58cb370e0602170057x59b23957n3e858d5ac4918326@mail.gmail.com>
Date: Fri, 17 Feb 2006 09:57:13 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Fix IDE locking error.
In-Reply-To: <20060216223916.GA8463@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060216223916.GA8463@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/06, Dave Jones <davej@redhat.com> wrote:
> This bit us a few kernels ago, and for some reason never made it's way
> upstream.

Because has never been submitted...

> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=144743
> Kernel panic - not syncing: drivers/ide/pci/piix.c:231:
> spin_lock(drivers/ide/ide.c:c03cef28) already locked by driver/ide/ide-iops.c/1153.

Could we get a decent description of the problem and of the patch?
Starting with the short description: it is piix locking being fixed not IDE one.

As this is piix only patch your bugzilla #144768 is not duplicate of
#144743.   Also some people reported the problem for atiixp.c
under #144743 (attixp.c has similar locking problem to piix.c).
So either they didn't care to reopen the bug or it was fixed by
some other change it the core IDE code.

> From: Alan Cox <alan@redhat.com>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
> --- linux-2.6.12/drivers/ide/pci/piix.c~        2005-07-11 10:23:24.637181320 +0100
> +++ linux-2.6.12/drivers/ide/pci/piix.c 2005-07-11 10:23:24.637181320 +0100
> @@ -203,6 +203,8 @@
>         }
>  }
>
> +static spinlock_t tune_lock = SPIN_LOCK_UNLOCKED;
> +
>  /**
>   *     piix_tune_drive         -       tune a drive attached to a PIIX
>   *     @drive: drive to tune
> @@ -229,7 +231,12 @@
>                             { 2, 3 }, };
>
>         pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
> -       spin_lock_irqsave(&ide_lock, flags);
> +
> +       /* Master v slave is synchronized above us but the slave register is
> +          shared by the two hwifs so the corner case of two slave timeouts in
> +          parallel must be locked */
> +
> +       spin_lock_irqsave(&tune_lock, flags);
>         pci_read_config_word(dev, master_port, &master_data);
>         if (is_slave) {
>                 master_data = master_data | 0x4000;
> @@ -249,7 +256,7 @@
>         pci_write_config_word(dev, master_port, master_data);
>         if (is_slave)
>                 pci_write_config_byte(dev, slave_port, slave_data);
> -       spin_unlock_irqrestore(&ide_lock, flags);
> +       spin_unlock_irqrestore(&tune_lock, flags);
>  }
>
>  /**
