Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310799AbSCHSWP>; Fri, 8 Mar 2002 13:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310774AbSCHSWF>; Fri, 8 Mar 2002 13:22:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38158 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310799AbSCHSV4>; Fri, 8 Mar 2002 13:21:56 -0500
Subject: Re: Suspend support for IDE
To: pavel@ucw.cz (Pavel Machek)
Date: Fri, 8 Mar 2002 18:37:10 +0000 (GMT)
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20020308180204.GA7035@elf.ucw.cz> from "Pavel Machek" at Mar 08, 2002 07:02:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jPEs-00073F-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	while (HWGROUP(drive)->handler)
> +		schedule();

You need to yield. Remember the process might be hard real time and blocking
your real work from occuring. while(foo) schedule() is always a bug

> +static int idedisk_resume(struct device *dev, u32 level)
> +{
> +	ide_drive_t *drive = dev->driver_data;
> +	if (!drive->blocked)
> +		panic("ide: Resume but not suspended?\n");
> +	drive->blocked = 0;
> +}

Also remember you must perform the sequences to wake up the drive and
restore the controller logic (and of course in the right order). Newer
disks won't just wake up when fed a random command (eg ibm microdrives)

The suspend order similarly is important - finish the current command,
then flush the disk cache, then when it completes you can tell the drive
to power down. On some systems you want to drop it back to PIO0 non DMA
before the powerdown or S4BIOS restore from disk will fail.

APM generally does all this for you, ACPI won't.
