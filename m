Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbSIZVMp>; Thu, 26 Sep 2002 17:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261528AbSIZVMp>; Thu, 26 Sep 2002 17:12:45 -0400
Received: from [198.149.18.6] ([198.149.18.6]:63443 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261525AbSIZVMS>;
	Thu, 26 Sep 2002 17:12:18 -0400
Date: Fri, 27 Sep 2002 00:32:10 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020927003210.A2476@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  /* Set EXTENT bits starting at BASE in BITMAP to value TURN_ON. */
>  static void set_bitmap(unsigned long *bitmap, short base, short extent, int new_value)
> @@ -62,7 +63,12 @@
>  		return -EINVAL;
>  	if (turn_on && !capable(CAP_SYS_RAWIO))
>  		return -EPERM;
> -
> + 
> + 	ret = security_ops->ioperm(from, num, turn_on);
> + 	if (ret) {
> + 		return ret;
> + 	}
> + 

Sorry, but this is bullshit (like most of the lsm changes).  Either you
leave the capable in and say it's enough or you add your random hook
and remove that one.  Just adding more and more hooks without thinking
gets us exactly nowhere except to an unmaintainable codebase.

Also is there a _real_ need to pass in all the arguments?

>  			return -EPERM;
>  	}
> +	retval = security_ops->iopl(old, level);
> +	if (retval) {
> +		return retval;
> +	}
> +

again (and another few times)

> + * @module_create:
> + *	Check the permission before allocating space for a module.
> + *	@name contains the module name.
> + *	@size contains the module size.
> + *	Return 0 if permission is granted.
> + * @module_initialize:
> + * 	Check permission before initializing a module.
> + * 	@mod contains a pointer to the module being initialized.
> + *	Return 0 if permission is granted.

Umm, you can't tell me you deny someone to initialize a module he has
just created?

> + * @sethostname:
> + *	Check permission before the hostname is set to @hostname.
> + *	@hostname contains the new hostname
> + *	Return 0 if permission is granted.
> + * @setdomainname:
> + *	Check permission before the domainname is set to @domainname.
> + *	@domainname contains the new domainname
> + *	Return 0 if permission is granted.

You don't think this should maybe be just one hook?

> + * @ioperm:
> + *	Check permission before setting port input/output permissions for the
> + *	process for @num bytes starting from the port address @from to the
> + *	value @turn_on.
> + *	@from contains the starting port address.
> + *	@num contains the number of bytes starting from @from.
> + *	@turn_on contains the permissions value.
> + *	Return 0 if permission is granted.
> + * @iopl:
> + *	Check permission before changing the I/O privilege level of the current
> + *	process from @old to @level.
> + *	@old contains the old level.
> + *	@level contains the new level.
> + *	Return 0 if permission is granted.

Dito.

> + * @sysctl:
> + *	Check permission before accessing the @table sysctl variable in the
> + *	manner specified by @op.
> + *	@table contains the ctl_table structure for the sysctl variable.
> + *	@op contains the operation (001 = search, 002 = write, 004 = read).
> + *	Return 0 if permission is granted.

Aha.  So every LS module knows about every single sysctl in the
kernel.  Common, this is silly guys (and girls if there any)!

> + * @swapon:
> + *	Check permission before enabling swapping to the file or block device
> + *	identified by @swap.
> + *	@swap contains the swap_info_struct structure for the swap file and device.
> + *	Return 0 if permission is granted.
> + * @swapoff:
> + *	Check permission before disabling swapping to the file or block device
> + *	identified by @swap.
> + *	@swap contains the swap_info_struct structure for the swap file and device.
> + *	Return 0 if permission is granted.

You might be allowed to swapon but not swapoff?

> diff -Nru a/kernel/sys.c b/kernel/sys.c
> --- a/kernel/sys.c	Thu Sep 26 13:23:55 2002
> +++ b/kernel/sys.c	Thu Sep 26 13:23:55 2002
> @@ -349,11 +349,17 @@
>  asmlinkage long sys_reboot(int magic1, int magic2, unsigned int cmd, void * arg)
>  {
>  	char buffer[256];
> +	int retval;
>  
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!capable(CAP_SYS_BOOT))
>  		return -EPERM;
>  
> +	retval = security_ops->reboot(cmd);
> +	if (retval) {
> +		return retval;
> +	}
> +

What's the point of cmd here?  Someone might be allowed to halt the
system but not reboot?

[don't of stubfs snipped]

> +static int cap_swapon (struct swap_info_struct *swap)
> +{
> +	return 0;
> +}
> +
> +static int cap_swapoff (struct swap_info_struct *swap)
> +{
> +	return 0;
> +}

Live would be a lot simple if an unimplemented op would behave
as returning zero..

	Christoph (not speaking for SGI, just using the fastest mailserver)
