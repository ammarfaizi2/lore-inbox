Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTHaVHF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTHaVHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:07:04 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:36823 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262675AbTHaVG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:06:59 -0400
Date: Sun, 31 Aug 2003 23:02:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp broken
Message-ID: <20030831210242.GA122@elf.ucw.cz>
References: <3F509D82.5050409@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F509D82.5050409@kolumbus.fi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 2.6.0-test4 software suspend seems to be badly broken...looking at it 
> (relevant code included below), no wonder. pm_suspend_disk() calls 
> swsusp_save(), which is is essentially a nop. The intention was clearly 
> that after resume control would return from swsusp_save(), which isn't 
> the case, instead we return from swsusp_write(), and power down
> again!!!

If you want working swsusp/S3, go for -test3. This is known and
Patrick is working on that... I hope we can just rollback
powermanagment to -test3 state.

> --------------------------------------------------------------------------
> static int pm_suspend_disk(void)
> {
>    int error;
> 
>    pr_debug("PM: Attempting to suspend to disk.\n");
>    if (pm_disk_mode == PM_DISK_FIRMWARE)
>        return pm_ops->enter(PM_SUSPEND_DISK);
> 
>    if (!have_swsusp)
>        return -EPERM;
> 
>    pr_debug("PM: snapshotting memory.\n");
>    in_suspend = 1;
>    if ((error = swsusp_save()))
>        goto Done;
> 
>    if (in_suspend) {
>        pr_debug("PM: writing image.\n");
>        error = swsusp_write();
>        if (!error)
>            error = power_down(pm_disk_mode);
>        pr_debug("PM: Power down failed.\n");
>    } else
>        pr_debug("PM: Image restored successfully.\n");
>    swsusp_free();
> Done:
>    return error;
> }
> ----------------------------------------------------------------------------
> 
> /**
> *    swsusp_save - Snapshot memory
> */
> 
> int swsusp_save(void)
> {
> #if defined (CONFIG_HIGHMEM) || defined (COFNIG_DISCONTIGMEM)
>    printk("swsusp is not supported with high- or discontig-mem.\n");
>    return -EPERM;
> #endif
>    return 0;
> }

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
