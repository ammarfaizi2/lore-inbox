Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261533AbSIXCgG>; Mon, 23 Sep 2002 22:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261537AbSIXCgG>; Mon, 23 Sep 2002 22:36:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7432 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261533AbSIXCgC>;
	Mon, 23 Sep 2002 22:36:02 -0400
Message-ID: <3D8FD0A9.1010906@pobox.com>
Date: Mon, 23 Sep 2002 22:40:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry Kessler <kessler@us.ibm.com>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Hien Nguyen <hien@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
References: <3D8FC601.80BAC684@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Kessler wrote:
> There are 5 patches that represent the combined efforts of Rusty
> Russell, the Enterprise Event logging team (Larry Kessler, Jim Keniston
> and Hien Nguyen), and Mike Sullivan (all from IBM).  Patchs 1-4 are in 
> separate notes.  Patch 5 is included at the end of this note.
> 
> The concept:
> -----------
> * Device Drivers use new macros to log "problems" when errors are
>   detected.  Devices are also "introduced" at init time.
> 
> * If event logging is not configured, then the "details" passed to
>   problem() and introduce() are written to printk.   
> 
> If event logging is configured....
> 
> * During the build process
>   the static details (textual description, problem attribute names,
>   format specifiers for problem attributes, source file name, function
>   name and line number) associated with the problem() and introduce()
>   calls are stored in a .log section in the .o file. 
> 
> * A user-mode utility reads the static details from the .log 
>   section and creates a "formatting template", which contains the
>   static details needed to interpret and format the problem data
>   that's logged during runtime. 
> 
> * Developers, Distros, Sys Admins, etc. can simply edit the template
>   (or provide an alternate template) to control which information from
>   the problem record is displayed, how it is displayed, what language
>   it is displayed in, and can add additional information like probable
>   cause, recommended operator actions, recommended repair actions, etc.
>   ...all without requiring any changes in the device driver source code.
>      
> * Event logging utilities apply the templates to problem records for 
>   querying events, displaying events, event notification, and log 
>   management.  Named-attributes in the problem data allow the above
>   actions to key on specific attributes like MAC address, device name,
>   etc.     	 
> 
> 
> The patches for 2.5.38:
> ----------------------
> Patch 1/5 - Logging macros and template generation code
>             (separate note)
> Patch 2/5 - Event Logging (separate note)
> Patch 3/5 - KBUILD_MODNAME (from Kai Germaschewski; separate note)
> Patch 4/5 - scsi device driver using the macros (separate note)
> Patch 5/5 - eepro100 device driver using the macros (end of this note)
> -> apply in the above sequence (patch 4 and 5 do not depend on
>    each other, but both contain pci_problem.h)
> 
> 
> Example:
> -------
> (1) disk_dummy.c uses the problem() and detail() macros:
> /* serious disk problem */
>     problem(LOG_ALERT, "Disk on fire!",
>                 detail(disk, "%s", drive->name),
>                 detail(temperature, "%d", drive->degC),
>                 detail(action, "%s", "Put out fire; run fsck."));
> 
> (2) During 'make bzImage' or 'make modules' static event data is stored
>     in a .log section in the disk_dummy.o file.
> 
> (3) 'make templates' extracts this data from the disk_dummy.o file and
>     generates a formatting template in templates/disk_dummy/disk_dummy.t:
> 
>       facility "disk_dummy";
>       event_type 0x8ab218f4; /* file, message */
>       const {
>           string message = "Disk on fire!";
>           string file = "disk_dummy.c";
>           string function = "disk_mon";
>           int line = 81;
>       }
>       attributes {
>           string action "%s";
>           string disk "%s";
>           int temperature "%d"; 
>       }
>       format
>       %file%:%function%:%line%
>       %message%  action=%action% disk=%disk% temperature=%temperature%
>  
>     The .log section is not included in bzImage nor in modules installed
>     with 'make modules_install'.  However, the original disk_dummy.o file
>     still has it.  'objcopy -R .log disk_dummy.o' removes it.      
> 
> (4)  'make templates_install' copies disk_dummy/disk_dummy.t to 
>      /var/evlog/templates.  
>   
> (5) 'evlfacility -a disk_dummy' adds the facility to the registry.
>     'evltc disk_dummy.t' compiles the template, and generates
>      /var/evlog/templates/disk_dummy/0x8ab218f4.to, which is used
>      by the event logging utilities.
> 
> (6) When a problem() is logged by the device driver, the static info. is
>     not stored in the event.  Instead it is read by event logging 
>     utilities from the 0x8ab218f4.to file after the problem record is
>     read from the event log file. 
> 
> (7) The template under (3) above would allow the command...
>         >evlview -b -f 'disk="sda3" && temperature>80'
>     to display events where sda3's temperature was greater than 80...
>         
> recid=2163, size=33, format=BINARY, event_type=0x8ab218f4, facility=disk_dummy, 
> severity=ALERT, uid=root, gid=root, pid=1, pgrp=0, 
> time=Fri 20 Sep 2002 04:00:01 PM PDT, flags=0x2 (KERNEL), thread=0x0, 
> processor=2
> disk_dummy.c:dummy_mon:62
> Disk on fire!  action=Put out fire; run fsck. disk=sda3 temperature=88
> 
>     Some other examples...
> 
>         evlview -b -f 'disk="sda3" && temperature>80' -m
> 
> Sep 20 16:00:01 elm3b99 kernel: disk_dummy.c:dummy_mon:62
> Disk on fire!  action=Put out fire; run fsck. disk=sda3 temperature=88
>         
>         ...-m causes a printk style display.
> 
>     By editing disk_dummy.t, recompiling it, and then reissuing the above 
>     command, the same problem data would be displayed differently...
> 
> Sep 20 16:00:01 elm3b99 kernel: 
> <<< Se quema el disco!  Se quema el disco!    >>> 
> !!!  temperatura=88 degrees C  el disko=sda3
> 
> 
> Notes:
> -----
> For the following 3 invocations, the first 2 work, the 3rd does not...
> 
> problem(LOG_ALERT, "Disk on fire");    // OK
> 
> #define DISK_ON_FIRE "Disk on fire"
> problem(LOG_ALERT, DISK_ON_FIRE);     // OK
> 
> msg = "Disk on fire";
> problem(LOG_ALERT, msg);  // No good
> 
> Furthermore, you cannot have more than one problem() call on a single
> line.  This restriction does not apply to the detail() macro.
> 
> See http://evlog.sourceforge.net/ for more details about event logging.
> 
> Go to https://sourceforge.net/project/showfiles.php?group_id=34226
>   to download release evlog-2.5_kernel, 1.4.2_k2.5 for the companion 
>   user lib and utilities.
> 
> 
> To-do List
> ----------
> 
> 1) Resolve "one problem() per line" restriction.
> 2) Generate shell scripts during 'make templates_install' that 
>    execute 'evlfacility' for all facilities and 'evltc' for all .t
>    files (currently have to do one at a time).
> 3) For event-logging not configured case, buffer problem() data and 
>    make a single call to printk(), since multiple printks are 
>    non-atomic.
> 4) Define valid severities to use with for problem()...3 or 4.
> 
> 
> An actual device driver
> -----------------------
> 
> Note that this patch includes pci_problem.h, as does the ips.c
> device driver patch included in the '4 of 4' note.
>  
> Summary of this patch...
>  
>  drivers/net/eepro100.c
>     Device Driver for the Intel PCI EtherExpressPro with new logging 
>     macros replacing prink() for error conditions.
>  
>  include/linux/net_problem.h
>   -  net_detail() macro providing common information of interest
>      for ethernet-class devices.    
>   -  net_problem, net_pci_problem, and net_introduce macros   
> 
>  include/linux/pci_problem.h
> 
>   -  pci_detail() macro providing common information on a per class
>      basis when problems are being reported for devices of that class. 
>   -  pci_problem and pci_introduce macros.
> 
> 
> --- linux-2.5.37/drivers/net/eepro100.c	Fri Sep 20 10:20:31 2002
> +++ linux-2.5.37-net/drivers/net/eepro100.c	Mon Sep 23 20:20:14 2002
> @@ -119,6 +119,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/skbuff.h>
>  #include <linux/ethtool.h>
> +#include <linux/net_problem.h>
>  
>  MODULE_AUTHOR("Maintainer: Andrey V. Savochkin <saw@saw.sw.com.sg>");
>  MODULE_DESCRIPTION("Intel i82557/i82558/i82559 PCI EtherExpressPro driver");
> @@ -325,7 +326,8 @@
>  	while(inb(cmd_ioaddr) && --wait >= 0);
>  #ifndef final_version
>  	if (wait < 0)
> -		printk(KERN_ALERT "eepro100: wait_for_cmd_done timeout!\n");
> +		problem(LOG_ALERT, "eepro100: wait_for_cmd_done timeout!",
> +				detail(ioaddr, "%lx", cmd_ioaddr));

bloat, the ioaddr can easily be deduced


>  #endif
>  }
>  
> @@ -568,6 +570,7 @@
>  	static int cards_found /* = 0 */;
>  
>  	static int did_version /* = 0 */;		/* Already printed version info. */
> +	pci_introduce(pdev);


bloat, we don't need foo_introduce() functions for every subsystem, when 
every subsystem always has an attach-new-device function.



> -		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
> +		pci_problem(LOG_ERR, pdev, "eepro100: cannot reserve I/O ports");
>  		goto err_out_none;
>  	}
>  	if (!request_mem_region(pci_resource_start(pdev, 0),
>  			pci_resource_len(pdev, 0), "eepro100")) {
> -		printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
> +		pci_problem(LOG_ERR, pdev, "eepro100: cannot reserve MMIO region");

bloat, no advantage over printk


>  		goto err_out_free_pio_region;
>  	}
>  
> @@ -605,8 +608,10 @@
>  	ioaddr = (unsigned long)ioremap(pci_resource_start(pdev, 0),
>  									pci_resource_len(pdev, 0));
>  	if (!ioaddr) {
> -		printk (KERN_ERR "eepro100: cannot remap MMIO region %lx @ %lx\n",
> -				pci_resource_len(pdev, 0), pci_resource_start(pdev, 0));
> +		pci_problem(LOG_ERR, pdev,
> +					"eepro100: cannot remap MMIO region %lx @ %lx",
> +					detail(region, "%lx", pci_resource_len(pdev, 0)),
> +					detail(base, "%lx", pci_resource_start(pdev, 0)));
>  		goto err_out_free_mmio_region;
>  	}
>  	if (speedo_debug > 2)
> @@ -653,11 +658,12 @@
>  
>  	dev = init_etherdev(NULL, sizeof(struct speedo_private));
>  	if (dev == NULL) {
> -		printk(KERN_ERR "eepro100: Could not allocate ethernet device.\n");
> +		pci_problem(LOG_ERR, pdev, "Could not allocate ethernet device.");

likewise


>  		pci_free_consistent(pdev, size, tx_ring_space, tx_ring_dma);
>  		return -1;
>  	}
>  
> +	net_introduce(dev);

likewise, RE foo_introduce()


>  	SET_MODULE_OWNER(dev);
>  
>  	if (dev->mem_start > 0)
> @@ -700,9 +706,9 @@
>  			}
>  		}
>  		if (sum != 0xBABA)
> -			printk(KERN_WARNING "%s: Invalid EEPROM checksum %#4.4x, "
> -				   "check settings before activating this device!\n",
> -				   dev->name, sum);
> +			net_pci_problem(LOG_WARNING, dev, pdev, "Invalid EEPROM checksum, "
> +				   "check settings before activating this device!",

> +				   detail(checksum, "%#4.4x", sum));

bloat, checksum is purely informational, and can be obtained through 
other means


>  		/* Don't  unregister_netdev(dev);  as the EEPro may actually be
>  		   usable, especially if the MAC address is set later.
>  		   On the other hand, it may be unusable if MDI data is corrupted. */
> @@ -784,11 +790,9 @@
>  		} while (self_test_results[1] == -1  &&  --boguscnt >= 0);
>  
>  		if (boguscnt < 0) {		/* Test optimized out. */
> -			printk(KERN_ERR "Self test failed, status %8.8x:\n"
> -				   KERN_ERR " Failure to initialize the i82557.\n"
> -				   KERN_ERR " Verify that the card is a bus-master"
> -				   " capable slot.\n",
> -				   self_test_results[1]);
> +			net_pci_problem(LOG_ERR, dev, pdev, 
> +				"Self test failed.Failure to initialize the i82557. Verify that the card is a bus-master capable slot.\n",
> +				detail(results, "%8.8x", self_test_results[1]));
>  		} else
>  			printk(KERN_INFO "  General self-test: %s.\n"
>  				   KERN_INFO "  Serial sub-system self-test: %s.\n"
> @@ -931,7 +935,9 @@
>  	do {
>  		val = inl(ioaddr + SCBCtrlMDI);
>  		if (--boguscnt < 0) {
> -			printk(KERN_ERR " mdio_read() timed out with val = %8.8x.\n", val);
> +			problem(LOG_ERR, " mdio_read() timed out.\n",
> +				detail(ioaddr, "%lx", ioaddr),
> +				detail(value, "%8.8x", val));

bloat, no need for ioaddr


>  			break;
>  		}
>  	} while (! (val & 0x10000000));
> @@ -947,7 +953,9 @@
>  	do {
>  		val = inl(ioaddr + SCBCtrlMDI);
>  		if (--boguscnt < 0) {
> -			printk(KERN_ERR" mdio_write() timed out with val = %8.8x.\n", val);
> +			problem(LOG_ERR, " mdio_write() timed out.\n",
> +				detail(ioaddr, "%lx", ioaddr),
> +				detail(value, "%8.8x", val));

likewise

etcetera...

