Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269755AbUJMRWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269755AbUJMRWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 13:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269758AbUJMRWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 13:22:54 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:23222 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269755AbUJMRWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 13:22:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp: 8-order memory allocations problem (was: Re: Fix random crashes in x86-64 swsusp)
Date: Wed, 13 Oct 2004 19:24:34 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>,
       agruen@suse.de
References: <200410052314.25253.rjw@sisk.pl> <200410082259.43627.rjw@sisk.pl> <20041010134846.GD19831@elf.ucw.cz>
In-Reply-To: <20041010134846.GD19831@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410131924.34337.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 10 of October 2004 15:48, Pavel Machek wrote:
[-- snip --] 
> > It's sort of strange, because there were 250 meg of RAM available,
> > out of 500, at that time.
> 
> Well, you have 250MB free, but apparently not enough contignuous free 
pages...
> 
> You may try this one, it may reduce probability of this kind of
> failure...
> 
> 							Pavel
> 
> --- clean/kernel/power/disk.c	2004-10-01 00:30:32.000000000 +0200
> +++ linux/kernel/power/disk.c	2004-10-02 19:43:06.000000000 +0200
> @@ -85,13 +89,26 @@
>  
>  static void free_some_memory(void)
>  {
> -	printk("Freeing memory: ");
> -	while (shrink_all_memory(10000))
> -		printk(".");
> -	printk("|\n");
> +	int i;
> +	for (i=0; i<5; i++) {
> +		int i = 0, tmp;
> +		long pages = 0;
> +		char *p = "-\\|/";
> +
> +		printk("Freeing memory...  ");
> +		while ((tmp = shrink_all_memory(10000))) {
> +			pages += tmp;
> +			printk("\b%c", p[i]);
> +			i++;
> +			if (i > 3)
> +				i = 0;
> +		}
> +		printk("\bdone (%li pages freed)\n", pages);
> +		current->state = TASK_INTERRUPTIBLE;
> +		schedule_timeout(HZ/5);
> +	}
>  }
>  
> -
>  static inline void platform_finish(void)
>  {
>  	if (pm_disk_mode == PM_DISK_PLATFORM) {
> -- 

I'm giving it a try.  Without this patch I get an 8-order allocation failure 
almost every time after using a computer for a day.  This one is pretty 
scary, IMO (there are 5 times more pages free than needed to be copied and 
still it cannot allocate enough memory):

Stopping tasks: ============================================================|
Freeing 
memory: .............................................................................................................|
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
..<7>[nosave pfn 
0x58d].........................................................................................................
..swsusp: Need to copy 21035 pages
suspend: (pages needed: 21035 + 512 free: 109844)
hibernate.sh: page allocation failure. order:8, mode:0x120
Oct 13 17:57:34 albercik kernel:
Call Trace:<ffffffff8016ec2d>{__alloc_pages+749} 
<ffffffff8016ecd1>{__get_free_pages+33}
       <ffffffff80161b93>{suspend_prepare_image+531} 
<ffffffff8026e977>{pci_device_suspend+71}
       <ffffffff80161e26>{swsusp_swap_check+22} 
<ffffffff802eae02>{suspend_device+50}
       <ffffffff80120dec>{swsusp_arch_suspend+124} 
<ffffffff8016123c>{swsusp_suspend+12}
       <ffffffff8016239a>{pm_suspend_disk+90} 
<ffffffff8015ff54>{enter_state+68}
       <ffffffff802aed4d>{acpi_system_write_sleep+100} 
<ffffffff80194b24>{vfs_write+228}
       <ffffffff80194c63>{sys_write+83} <ffffffff80110c72>{system_call+126}
Oct 13 17:57:41 albercik kernel:
suspend: Allocating pagedir failed.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
