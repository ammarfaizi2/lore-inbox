Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTAWEr0>; Wed, 22 Jan 2003 23:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbTAWEr0>; Wed, 22 Jan 2003 23:47:26 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:15887 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261205AbTAWErY>;
	Wed, 22 Jan 2003 23:47:24 -0500
Date: Wed, 22 Jan 2003 20:54:47 -0800
From: Greg KH <greg@kroah.com>
To: Stanley Wang <stanley.wang@linux.co.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [PATCH] Replace pcihpfs with sysfs.
Message-ID: <20030123045447.GB6584@kroah.com>
References: <Pine.LNX.4.44.0301220935010.25009-100000@manticore.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301220935010.25009-100000@manticore.sh.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 09:39:01AM +0800, Stanley Wang wrote:
> Hi, Grep

"Grep"?  Who's that?  :)

> Here is the patch that replace pcihpfs with sysfs. (against the lastest
> BK tree)

Thanks a lot for the patch, I appreciate.  I do have a few
comments/questions below (they are still true for your updated patch you
sent.

> diff -Nru a/drivers/hotplug/cpci_hotplug_core.c b/drivers/hotplug/cpci_hotplug_core.c
> --- a/drivers/hotplug/cpci_hotplug_core.c	Wed Jan 22 09:30:20 2003
> +++ b/drivers/hotplug/cpci_hotplug_core.c	Wed Jan 22 09:30:20 2003
> @@ -130,7 +130,7 @@
>  		return -EINVAL;
>  	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
>  	info.latch_status = value;
> -	return pci_hp_change_slot_info(hotplug_slot->name, &info);
> +	return 0;

We really need to keep this functionality.  Unfortunatly sysfs doesn't
support that yet.  I'd keep the call to pci_hp_change_slot_info() around
to point out that this needs to be fixed in sysfs.

>  /* Random magic number */
>  #define PCIHPFS_MAGIC 0x52454541

You can also remove this #define now, right?

> +static struct subsystem hotplug_slot_subsys;

You need to initialize this structure to something, and give it a name.
Otherwise all of the slots show up in the top of sysfs, right?  I would
really like to see these directories show up in /sys/bus/pci/slots/ if
you can get them to go there.

> -static ssize_t power_write_file (struct file *file, const char *ubuff, size_t count, loff_t *offset)
> +static ssize_t power_write_file (struct hotplug_slot *slot, const char *buf,
> +		size_t count)
>  {
> -	struct hotplug_slot *slot = file->private_data;
> -	char *buff;
> -	unsigned long lpower;
> -	u8 power;
> +	unsigned long power;
>  	int retval = 0;
>  
> -	if (*offset < 0)
> -		return -EINVAL;
> -	if (count == 0 || count > 16384)
> -		return 0;
> -	if (*offset != 0)
> -		return 0;
> -
> -	if (slot == NULL) {
> -		dbg("slot == NULL???\n");
> -		return -ENODEV;
> -	}
> -
> -	buff = kmalloc (count + 1, GFP_KERNEL);
> -	if (!buff)
> -		return -ENOMEM;
> -	memset (buff, 0x00, count + 1);
> - 
> -	if (copy_from_user ((void *)buff, (void *)ubuff, count)) {
> -		retval = -EFAULT;
> +	retval = sscanf(buf, "%ld", &power);
> +	if (retval != 1) {
> +		err("Illegla value specified for power\n");
> +		retval = -EINVAL;
>  		goto exit;
>  	}
> -	
> -	lpower = simple_strtoul (buff, NULL, 10);
> -	power = (u8)(lpower & 0xff);
> -	dbg ("power = %d\n", power);
> +	dbg ("power = %ld\n", power);
>  
>  	if (!try_module_get(slot->ops->owner)) {
>  		retval = -ENODEV;

Why change from simple_strtoul() to sscanf()?  Is this a needed change?

>  static void __exit pci_hotplug_exit (void)
>  {
> -	cpci_hotplug_exit();
> -
> -	unregister_filesystem(&pcihpfs_type);
> -
>  #ifdef CONFIG_PROC_FS
>  	if (slotdir)
>  		remove_proc_entry(slotdir_name, proc_bus_pci_dir);
>  #endif
> +
> +	cpci_hotplug_exit();
> +	subsystem_unregister(&hotplug_slot_subsys);
>  }
>  
>  module_init(pci_hotplug_init);

Why reorder these calls?  Also, the whole slotdir_name stuff can be
ripped out, as we will not be needing that proc directory anymore.

Again, thanks a lot for the patch, I think it's really close.

greg k-h
