Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWJWSX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWJWSX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWJWSX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:23:26 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:12248 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964986AbWJWSXY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:23:24 -0400
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in
	several drivers
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, kernel-janitors@lists.osdl.org,
       akpm@osdl.org, benh@kernel.crashing.org, maxk@qualcomm.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061023175427.GB23714@hmsreliant.homelinux.net>
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
	 <1161625164.21701.18.camel@localhost.localdomain>
	 <20061023175427.GB23714@hmsreliant.homelinux.net>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 11:23:04 -0700
Message-Id: <1161627784.5182.151.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For tpm:

Ack'ed-by: Kylene Hall <kjhall@us.ibm.com>

On Mon, 2006-10-23 at 13:54 -0400, Neil Horman wrote:
> On Mon, Oct 23, 2006 at 06:39:24PM +0100, Alan Cox wrote:
> > Ar Llu, 2006-10-23 am 13:19 -0400, ysgrifennodd Neil Horman:
> > > +	for_each_online_node(node) {
> > > +		if(timers[node] != NULL)
> > > +			kfree(timers[node]);
> > > +	}
> > 
> > The if test appears to be redundant as kfree(NULL) is a valid no-op.
> > 
> > > +	if (misc_register(&hp_sdc_rtc_dev) != 0)
> > > +		printk(KERN_INFO "Could not register misc. dev for sdc\n");
> > 
> > Many users will misconstrue this has a hard disk name - is there a
> > better name to use.
> > 
> > >  	if (ret)
> > >  		printk(KERN_ERR "tun: Can't register misc device %d\n", TUN_MINOR);
> > 
> > These all really show that we should pass the name into the misc
> > register and do the printk there to cut down on random name variants and
> > kernel size. Separate problem, just noting it in case someone feels
> > inspired 8)
> > 
> > Alan
> 
> New patch attached, taking Alan's suggestions into account.  I'll consolidate
> the printk error messages into misc_register in a later patch when I have a
> moment.  Thanks Alan.
> 
> Regards
> Neil
> 
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
>  drivers/char/mmtimer.c          |   28 ++++++++++++++++++++++------
>  drivers/char/tpm/tpm.c          |    1 +
>  drivers/input/misc/hp_sdc_rtc.c |    6 +++++-
>  drivers/macintosh/apm_emu.c     |    5 ++++-
>  drivers/net/tun.c               |    2 ++
>  fs/dlm/user.c                   |    1 +
>  6 files changed, 35 insertions(+), 8 deletions(-)
> 
> 
> 
> diff --git a/drivers/char/mmtimer.c b/drivers/char/mmtimer.c
> --- a/drivers/char/mmtimer.c
> +++ b/drivers/char/mmtimer.c
> @@ -669,6 +669,7 @@ static struct k_clock sgi_clock = {
>  static int __init mmtimer_init(void)
>  {
>  	unsigned i;
> +	int err = -1;
>  	cnodeid_t node, maxn = -1;
>  
>  	if (!ia64_platform_is("sn2"))
> @@ -680,7 +681,7 @@ static int __init mmtimer_init(void)
>  	if (sn_rtc_cycles_per_second < 100000) {
>  		printk(KERN_ERR "%s: unable to determine clock frequency\n",
>  		       MMTIMER_NAME);
> -		return -1;
> +		goto out;
>  	}
>  
>  	mmtimer_femtoperiod = ((unsigned long)1E15 + sn_rtc_cycles_per_second /
> @@ -689,13 +690,13 @@ static int __init mmtimer_init(void)
>  	if (request_irq(SGI_MMTIMER_VECTOR, mmtimer_interrupt, IRQF_PERCPU, MMTIMER_NAME, NULL)) {
>  		printk(KERN_WARNING "%s: unable to allocate interrupt.",
>  			MMTIMER_NAME);
> -		return -1;
> +		goto out;
>  	}
>  
>  	if (misc_register(&mmtimer_miscdev)) {
>  		printk(KERN_ERR "%s: failed to register device\n",
>  		       MMTIMER_NAME);
> -		return -1;
> +		goto out1;
>  	}
>  
>  	/* Get max numbered node, calculate slots needed */
> @@ -709,16 +710,18 @@ static int __init mmtimer_init(void)
>  	if (timers == NULL) {
>  		printk(KERN_ERR "%s: failed to allocate memory for device\n",
>  				MMTIMER_NAME);
> -		return -1;
> +		goto out2;
>  	}
>  
> +	memset(timers,0,(sizeof(mmtimer_t *)*maxn));
> +
>  	/* Allocate mmtimer_t's for each online node */
>  	for_each_online_node(node) {
>  		timers[node] = kmalloc_node(sizeof(mmtimer_t)*NUM_COMPARATORS, GFP_KERNEL, node);
>  		if (timers[node] == NULL) {
>  			printk(KERN_ERR "%s: failed to allocate memory for device\n",
>  				MMTIMER_NAME);
> -			return -1;
> +			goto out3;
>  		}
>  		for (i=0; i< NUM_COMPARATORS; i++) {
>  			mmtimer_t * base = timers[node] + i;
> @@ -738,7 +741,20 @@ static int __init mmtimer_init(void)
>  	printk(KERN_INFO "%s: v%s, %ld MHz\n", MMTIMER_DESC, MMTIMER_VERSION,
>  	       sn_rtc_cycles_per_second/(unsigned long)1E6);
>  
> -	return 0;
> +	err = 0;
> +out:
> +	return err;
> +
> +out3:
> +	for_each_online_node(node) {
> +		kfree(timers[node]);
> +	}
> +out2:
> +	misc_deregister(&mmtimer_miscdev);
> +out1:
> +	free_irq(SGI_MMTIMER_VECTOR, NULL);
> +	goto out;
> +	
>  }
>  
>  module_init(mmtimer_init);
> diff --git a/drivers/char/tpm/tpm.c b/drivers/char/tpm/tpm.c
> --- a/drivers/char/tpm/tpm.c
> +++ b/drivers/char/tpm/tpm.c
> @@ -1155,6 +1155,7 @@ #define DEVNAME_SIZE 7
>  
>  	if (sysfs_create_group(&dev->kobj, chip->vendor.attr_group)) {
>  		list_del(&chip->list);
> +		misc_deregister(&chip->vendor.miscdev);
>  		put_device(dev);
>  		clear_bit(chip->dev_num, dev_mask);
>  		kfree(chip);
> diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
> --- a/drivers/input/misc/hp_sdc_rtc.c
> +++ b/drivers/input/misc/hp_sdc_rtc.c
> @@ -693,9 +693,13 @@ static int __init hp_sdc_rtc_init(void)
>  
>  	init_MUTEX(&i8042tregs);
>  
> +	INIT_LIST_HEAD(&hp_sdc_rtc_dev.list);
> +
>  	if ((ret = hp_sdc_request_timer_irq(&hp_sdc_rtc_isr)))
>  		return ret;
> -	misc_register(&hp_sdc_rtc_dev);
> +	if (misc_register(&hp_sdc_rtc_dev) != 0)
> +		printk(KERN_INFO "Could not register misc. dev for i8042 rtc\n");
> +
>          create_proc_read_entry ("driver/rtc", 0, NULL,
>  				hp_sdc_rtc_read_proc, NULL);
>  
> diff --git a/drivers/macintosh/apm_emu.c b/drivers/macintosh/apm_emu.c
> --- a/drivers/macintosh/apm_emu.c
> +++ b/drivers/macintosh/apm_emu.c
> @@ -520,6 +520,8 @@ static int __init apm_emu_init(void)
>  {
>  	struct proc_dir_entry *apm_proc;
>  
> +	INIT_LIST_HEAD(&apm_device.list);
> +
>  	if (sys_ctrler != SYS_CTRLER_PMU) {
>  		printk(KERN_INFO "apm_emu: Requires a machine with a PMU.\n");
>  		return -ENODEV;
> @@ -529,7 +531,8 @@ static int __init apm_emu_init(void)
>  	if (apm_proc)
>  		apm_proc->owner = THIS_MODULE;
>  
> -	misc_register(&apm_device);
> +	if (misc_register(&apm_device) != 0)
> +		printk(KERN_INFO "Could not create misc. device for apm\n");
>  
>  	pmu_register_sleep_notifier(&apm_sleep_notifier);
>  
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -856,6 +856,8 @@ static int __init tun_init(void)
>  	printk(KERN_INFO "tun: %s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
>  	printk(KERN_INFO "tun: %s\n", DRV_COPYRIGHT);
>  
> +	INIT_LIST_HEAD(&tun_miscdev.list);
> +
>  	ret = misc_register(&tun_miscdev);
>  	if (ret)
>  		printk(KERN_ERR "tun: Can't register misc device %d\n", TUN_MINOR);
> diff --git a/fs/dlm/user.c b/fs/dlm/user.c
> --- a/fs/dlm/user.c
> +++ b/fs/dlm/user.c
> @@ -773,6 +773,7 @@ int dlm_user_init(void)
>  	ctl_device.name = "dlm-control";
>  	ctl_device.fops = &ctl_device_fops;
>  	ctl_device.minor = MISC_DYNAMIC_MINOR;
> +	INIT_LIST_HEAD(&ctl_device.list);
>  
>  	error = misc_register(&ctl_device);
>  	if (error)

