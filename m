Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWEXX2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWEXX2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWEXX2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 19:28:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14796 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932330AbWEXX2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 19:28:48 -0400
Date: Wed, 24 May 2006 16:31:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6]  EDAC PCI device to DEVICE cleanup
Message-Id: <20060524163129.33721d15.akpm@osdl.org>
In-Reply-To: <20060524174518.76620.qmail@web50112.mail.yahoo.com>
References: <20060524174518.76620.qmail@web50112.mail.yahoo.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Thompson <norsk5@yahoo.com> wrote:
>
> 
> +#ifdef CONFIG_PCI
>  #include <linux/pci.h>
> +#endif

That shouldn't be needed - the header file should take care of it.

> +#ifdef CONFIG_PCI
>  #define PCI_VEND_DEV(vend, dev) PCI_VENDOR_ID_ ## vend, \
>  	PCI_DEVICE_ID_ ## vend ## _ ## dev
> +#endif

There should be no need to put ifdefs around this either.

> +#if defined(CONFIG_X86) && defined(CONFIG_PCI)
> +#define dev_name(dev) pci_name(to_pci_dev(dev))
> +#else
> +#define dev_name(dev) to_platform_device(dev)->name
> +#endif

Why X86?

>  
> +#ifdef CONFIG_PCI
> +
>  /* write all or some bits in a byte-register*/
>  static inline void pci_write_bits8(struct pci_dev *pdev, int offset, u8 value,
>  		u8 mask)
> @@ -401,6 +413,8 @@
>  	pci_write_config_dword(pdev, offset, value);
>  }
>  
> +#endif /* CONFIG_PCI */

hm.  Maybe.

Generally: we want to minimize the number of ifdefs.  The only reasons for
these sorts of ifdefs are to a) avoid generation of unneeded code or data
and b) to make it compile with !CONFIG_PCI.  A lot of the ones you've added
don't appear to satisfy either requirement.

> ===================================================================
> --- linux-2.6.17-rc4.orig/drivers/edac/edac_mc.c	2006-05-15 15:50:33.000000000 -0600
> +++ linux-2.6.17-rc4/drivers/edac/edac_mc.c	2006-05-15 16:01:36.000000000 -0600
> @@ -54,16 +54,17 @@
>  static int panic_on_ue;
>  static int poll_msec = 1000;
>  
> -static int check_pci_parity = 0;	/* default YES check PCI parity */
> -static int panic_on_pci_parity;		/* default no panic on PCI Parity */
> -static atomic_t pci_parity_count = ATOMIC_INIT(0);
> -
>  /* lock to memory controller's control array */
>  static DECLARE_MUTEX(mem_ctls_mutex);
>  static struct list_head mc_devices = LIST_HEAD_INIT(mc_devices);
>  
>  static struct task_struct *edac_thread;
>  
> +#ifdef CONFIG_PCI
> +static int check_pci_parity = 0;	/* default YES check PCI parity */
> +static int panic_on_pci_parity;		/* default no panic on PCI Parity */
> +static atomic_t pci_parity_count = ATOMIC_INIT(0);
> +
>  /* Structure of the whitelist and blacklist arrays */
>  struct edac_pci_device_list {
>  	unsigned int  vendor;		/* Vendor ID */
> @@ -79,6 +80,7 @@
>  /* List of PCI devices (vendor-id:device-id) that should be scanned */
>  static struct edac_pci_device_list pci_whitelist[MAX_LISTED_PCI_DEVICES];
>  static int pci_whitelist_count ;
> +#endif
>  
>  /*  START sysfs data and methods */
>  
> @@ -132,13 +134,17 @@
>   *	/sys/devices/system/edac/pci
>   */
>  static struct kobject edac_memctrl_kobj;
> +#ifdef CONFIG_PCI
>  static struct kobject edac_pci_kobj;
> +#endif

OK, so we're saving RAM.  But the edac_pci_kobj definition could be moved
up into the earlier ifdef block, thereby saving one ifdef.

>  /* We use these to wait for the reference counts on edac_memctrl_kobj and
>   * edac_pci_kobj to reach 0.
>   */
>  static struct completion edac_memctrl_kobj_complete;
> +#ifdef CONFIG_PCI
>  static struct completion edac_pci_kobj_complete;
> +#endif

And another.

>  /*
>   * /sys/devices/system/edac/mc;
> @@ -324,6 +330,8 @@
>  #endif  /* DISABLE_EDAC_SYSFS */
>  }
>  
> +#ifdef CONFIG_PCI
> +
>  #ifndef DISABLE_EDAC_SYSFS
>  
>  /*
> @@ -624,6 +632,8 @@
>  #endif
>  }
>  
> +#endif	/* CONFIG_PCI */
> +

And conceivably another.  Ideally you could have just a single ifdef
CONFIG_PCI in the whole file.

> +#ifdef CONFIG_PCI
>  	/* Create the PCI parity sysfs entries */
>  	if (edac_sysfs_pci_setup()) {

And here, we could perhaps avoid an ifdef if we have

#ifndef CONFIG_PCI
static inline int edac_sysfs_pci_setup(void)
{
	return 0;
}
#endif

because the compiler will see the constant zero and will throw away all the
code.  As long as it still compiles then that's a good thing to do, because
the thrown-away code still gets checked by the compiler, regardless of
config settings.

(The downside can be that literal strings in the thrown-away code might still
appear in the generated code, but modern gcc's appear to have fixed that).

> +#ifdef CONFIG_PCI
>  		edac_sysfs_pci_teardown();
> +#endif

This should have an empty definition in a header if !CONFIG_PCI, hence the
ifdefs here will be unneeded.

>  		return PTR_ERR(edac_thread);
>  	}
>  
> @@ -2083,7 +2097,9 @@
>  
>          /* tear down the sysfs device */
>  	edac_sysfs_memctrl_teardown();
> +#ifdef CONFIG_PCI
>  	edac_sysfs_pci_teardown();
> +#endif

Ditto.  We have many techniques to avoid putting ifdefs in .c files -
please use them.


