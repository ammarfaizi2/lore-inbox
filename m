Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbUDNAjA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263838AbUDNAjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:39:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:50101 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263835AbUDNAi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:38:57 -0400
Date: Tue, 13 Apr 2004 17:34:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hannal@us.ibm.com, greg@kroah.com,
       mhw@wittsend.com
Subject: Re: [PATCH 2.6.5] Add class support to drivers/char/ip2main.c
Message-Id: <20040413173406.6d62c782.rddunlap@osdl.org>
In-Reply-To: <116700000.1081902014@w-hlinder.beaverton.ibm.com>
References: <116700000.1081902014@w-hlinder.beaverton.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004 17:20:14 -0700 Hanna Linder wrote:

| 
| Here is a patch to add class support to ip2main.c which is the Linux tty Device Driver for 
| IntelliPort family of multiport serial I/O controllers. This will enable udev to see these devices.
| 
| I have compiled but do not have the hardware to test. Please consider for testing or inclusion.
| 
| ------
| diff -Nrup -Xdontdiff linux-2.6.5/drivers/char/ip2main.c linux-2.6.5p/drivers/char/ip2main.c
| --- linux-2.6.5/drivers/char/ip2main.c	2004-04-03 19:38:27.000000000 -0800
| +++ linux-2.6.5p/drivers/char/ip2main.c	2004-04-13 17:07:41.000000000 -0700
| @@ -683,7 +690,14 @@ ip2_loadmain(int *iop, int *irqp, unsign
|  	/* Register the IPL driver. */
|  	if ( ( err = register_chrdev ( IP2_IPL_MAJOR, pcIpl, &ip2_ipl ) ) ) {
|  		printk(KERN_ERR "IP2: failed to register IPL device (%d)\n", err );
| -	} else
| +	} else {
| +	/* create the sysfs class */
| +	ip2_class = class_simple_create(THIS_MODULE, "ip2");
| +	if (IS_ERR(ip2_class)) {
| +		err = PTR_ERR(ip2_class);
| +		goto out_chrdev;	
| +	}
* indent that entire block.

| +	}
|  	/* Register the read_procmem thing */
|  	if (!create_proc_info_entry("ip2mem",0,&proc_root,ip2_read_procmem)) {
|  		printk(KERN_ERR "IP2: failed to register read_procmem\n");
| @@ -700,13 +714,23 @@ ip2_loadmain(int *iop, int *irqp, unsign
|  			}
|  
|  			if ( NULL != ( pB = i2BoardPtrTable[i] ) ) {
| -				devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i),
| +				class_simple_device_add(ip2_class, MKDEV(IP2_IPL_MAJOR, 4 * i), NULL, "ipl%d", i);
* line is too long.  break it up.

| +				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i),
|  						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
|  						"ip2/ipl%d", i);
| +				if (err) {
| +					class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 4 * i));
| +					goto out_class;
| +				}
|  
| -				devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i + 1),
| +				class_simple_device_add(ip2_class, MKDEV(IP2_IPL_MAJOR, 4 * i + 1), NULL, "stat%d", i);
* line is too long.  break it up.

| +				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i + 1),
|  						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
|  						"ip2/stat%d", i);
| +				if (err) {
| +					class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 4 * i + 1));
| +					goto out_class;
| +				}
|  
|  			    for ( box = 0; box < ABS_MAX_BOXES; ++box )
|  			    {
| @@ -759,8 +783,15 @@ retry:
|  		}
|  	}
|  	ip2trace (ITRC_NO_PORT, ITRC_INIT, ITRC_RETURN, 0 );
| +	goto out;
|  
| -	return 0;
| +out_class:
| +	class_simple_destroy(ip2_class);
| +
| +out_chrdev:
| +	unregister_chrdev(IP2_IPL_MAJOR, "ip2");
| +out:
| +	return err;
|  }
* use consistent spacing (lines) before labels.  None needed here (before out_chrdev:).

--
~Randy
