Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVBXPsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVBXPsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVBXPqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:46:06 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:60545 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262401AbVBXPpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:45:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Xa3wnIcWzRbDjwyNTarM97ub22GxkbJVtowQOJorCJ+23l3TLqgOL1AfTihWuTI/1DIFsBfD91Tdix8TA9XTaFRkIAy34hGYIX1vs8so+FDMDjGVA7QuUYKLg1OaattursLd11DSSUOUJAoN4ZkPnkMETZkSvPONBVzIuf6bnA0=
Message-ID: <58cb370e0502240745fcba7a3@mail.gmail.com>
Date: Thu, 24 Feb 2005 16:45:07 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 08/11] ide: remove REQ_DRIVE_TASK handling
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050210083844.AD987173@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050210083808.48E9DD1A@htj.dyndns.org>
	 <20050210083844.AD987173@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -945,33 +931,7 @@ static ide_startstop_t execute_drive_cmd
>                 if (args->tf_out_flags.all != 0)
>                         return flagged_taskfile(drive, args);
>                 return do_rw_taskfile(drive, args);
> -       } else if (rq->flags & REQ_DRIVE_TASK) {
> -               u8 *args = rq->buffer;
> -               u8 sel;
> -
> -               if (!args)
> -                       goto done;
> -#ifdef DEBUG
> -               printk("%s: DRIVE_TASK_CMD ", drive->name);
> -               printk("cmd=0x%02x ", args[0]);
> -               printk("fr=0x%02x ", args[1]);
> -               printk("ns=0x%02x ", args[2]);
> -               printk("sc=0x%02x ", args[3]);
> -               printk("lcyl=0x%02x ", args[4]);
> -               printk("hcyl=0x%02x ", args[5]);
> -               printk("sel=0x%02x\n", args[6]);
> -#endif
> -               hwif->OUTB(args[1], IDE_FEATURE_REG);
> -               hwif->OUTB(args[3], IDE_SECTOR_REG);
> -               hwif->OUTB(args[4], IDE_LCYL_REG);
> -               hwif->OUTB(args[5], IDE_HCYL_REG);
> -               sel = (args[6] & ~0x10);
> -               if (drive->select.b.unit)
> -                       sel |= 0x10;

do_rw_taskfile() always sets LBA bit in Device register for LBA
capable disks, so converting HDIO_DRIVE_TASK to use taskfile
transport removes (theoretical?) possibility of sending CHS
commands to LBA capable disks.

This issue is addressed in my patch series.
