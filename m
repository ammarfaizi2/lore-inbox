Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVCANLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVCANLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVCANLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:11:49 -0500
Received: from gprs215-241.eurotel.cz ([160.218.215.241]:38879 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261896AbVCANLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:11:07 -0500
Date: Tue, 1 Mar 2005 14:10:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-ID: <20050301131051.GE1843@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz> <20050301020722.6faffb69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301020722.6faffb69.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> btw, suspend is a bit messy.  The disk spins down.  Then up.  Then down
> again.  And:

Yes, this is going to be properly solved by switching pm_message_t to
struct (preview patch attached, EVENT will become .event, this is just
for me). I could do some hack to make disk not go up-down-up (and will
need to do it for suse9.3, anyway), but I do not think that would
belong to mainline.

> Powering off system
> Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
> in_atomic():0, irqs_disabled():1                                                
>  [<c010318d>] dump_stack+0x19/0x20
>  [<c0111731>] __might_sleep+0x91/0x9c
>  [<c0285872>] device_shutdown+0x16/0x82
>  [<c012aa97>] power_down+0x47/0x74     
>  [<c012ac5a>] pm_suspend_disk+0x5a/0x74
>  [<c01292ea>] enter_state+0x2e/0x70    
>  [<c0129336>] software_suspend+0xa/0x10
>  [<c024a8a7>] acpi_system_write_sleep+0x73/0x98
>  [<c0149f1b>] vfs_write+0xaf/0x118             
>  [<c014a028>] sys_write+0x3c/0x68 
>  [<c0102c05>] sysenter_past_esp+0x52/0x75
> Synchronizing SCSI cache for disk sda:   
> Shutdown: hda                          
> acpi_power_off called

Hmm, device_shutdown is confused. Should it be called with interrupts
enabled or disabled? It uses rwsem, that suggests interrupts enabled,
but I do not think sysdev_shutdown with enabled interrupts is good
idea (and comment suggests it should be called with interrupts disabled).

								Pavel

/**
 * We handle system devices differently - we suspend and shut them
 * down last and resume them first. That way, we don't do anything
stupid like
 * shutting down the interrupt controller before any devices..
 *
 * Note that there are not different stages for power management calls
-
 * they only get one called once when interrupts are disabled.
 */

extern int sysdev_shutdown(void);

/**
 * device_shutdown - call ->shutdown() on each device to shutdown.
 */
void device_shutdown(void)
{
        struct device * dev;

        down_write(&devices_subsys.rwsem);
        list_for_each_entry_reverse(dev, &devices_subsys.kset.list, kobj.entry) {
                pr_debug("shutting down %s: ", dev->bus_id);
                if (dev->driver && dev->driver->shutdown) {
                        pr_debug("Ok\n");
                        dev->driver->shutdown(dev);
                } else
                        pr_debug("Ignored.\n");
        }
        up_write(&devices_subsys.rwsem);

        sysdev_shutdown();
}



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
