Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261565AbSIXFLG>; Tue, 24 Sep 2002 01:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261566AbSIXFLG>; Tue, 24 Sep 2002 01:11:06 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:2565 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261565AbSIXFLA>;
	Tue, 24 Sep 2002 01:11:00 -0400
Date: Mon, 23 Sep 2002 22:15:06 -0700
From: Greg KH <greg@kroah.com>
To: Larry Kessler <kessler@us.ibm.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux \(Keith Mitchell\)" <ipslinux@us.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Hien Nguyen <hien@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
Message-ID: <20020924051505.GA21499@kroah.com>
References: <3D8FC601.80BAC684@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8FC601.80BAC684@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First off, this looks much nicer than what the Driver Hardening Group
just tried to pass off as event logging.  The two groups might want to
get together to sort out which formats is the desired ones, as they are
radically different.


On Mon, Sep 23, 2002 at 06:55:13PM -0700, Larry Kessler wrote:
> There are 5 patches that represent the combined efforts of Rusty
> Russell, the Enterprise Event logging team (Larry Kessler, Jim Keniston
> and Hien Nguyen), and Mike Sullivan (all from IBM).  Patchs 1-4 are in 
> separate notes.  Patch 5 is included at the end of this note.
> 
> The concept:
> -----------
> * Device Drivers use new macros to log "problems" when errors are
>   detected.

Nice concept.  But what's wrong with the existing method of logging when
errors are detected?  Can you give us some background as to what is
lacking in the current stuff?

> Devices are also "introduced" at init time.

Um, this isn't a new concept.  Devices show up when they are found by a
bus.  Or are you talking about a different kind of "device"?  And all
"introduction" of devices pass through /sbin/hotplug, so you can grab
all the detailed information about new devices you want right then.

> * If event logging is not configured, then the "details" passed to
>   problem() and introduce() are written to printk.   

So problem() and introduce() are just printk macros?  Do they provide
the same compile-time type-safety that we have in printk (hint, based on
your example below, I would guess not.)

Can you have different levels of problem()?  Like dbg(), warn(), and
info() are used in the USB subsystem (see drivers/include/usb.h).  If
so, can these levels be adjusted at driver load, or run-time (like the
"debug" option on many kernel drivers.)

IMHO, that would be one of the main places to look at standardizing
across the kernel, much like Linus just mentioned last week or so.

> If event logging is configured....
> 
> * During the build process
>   the static details (textual description, problem attribute names,
>   format specifiers for problem attributes, source file name, function
>   name and line number) associated with the problem() and introduce()
>   calls are stored in a .log section in the .o file. 

Nice.

> * A user-mode utility reads the static details from the .log 
>   section and creates a "formatting template", which contains the
>   static details needed to interpret and format the problem data
>   that's logged during runtime. 

Nice.

> * Developers, Distros, Sys Admins, etc. can simply edit the template
>   (or provide an alternate template) to control which information from
>   the problem record is displayed, how it is displayed, what language
>   it is displayed in, and can add additional information like probable
>   cause, recommended operator actions, recommended repair actions, etc.
>   ...all without requiring any changes in the device driver source code.

But who is going to be doing these "translations"?  Kernel log messages
change with every release.  That would be a _huge_ undertaking to
translate them all.

> * Event logging utilities apply the templates to problem records for 
>   querying events, displaying events, event notification, and log 
>   management.  Named-attributes in the problem data allow the above
>   actions to key on specific attributes like MAC address, device name,
>   etc.     	 

But what happens when the attributes, and events change on every kernel
release?  Who is keeping track of all of these?  Who is managing them?
Is there some maintainer people need to notify when they create a new
type of event or attribute?

I can see someone creating some job security for a long time with this
task :)

If event logging is enabled in a kernel, what kind of format will the
kernel log messages show up as (i.e. can they be read by humans?)

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

Is the second argument of problem() a format string?  In your example
below, sometimes it is, and sometimes it is not.

If not, you just lost a very handy way of showing data in a line of
text, and changed the existing messages in a large way.  What would the
above message look like in the kernel log if event logging is not
enabled?


> (2) During 'make bzImage' or 'make modules' static event data is stored
>     in a .log section in the disk_dummy.o file.

Nice.

> (3) 'make templates' extracts this data from the disk_dummy.o file and
>     generates a formatting template in templates/disk_dummy/disk_dummy.t:
> 
>       facility "disk_dummy";
>       event_type 0x8ab218f4; /* file, message */

How is this generated?  What does it match up with?  Does this value
show up in the log file now?

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

But where does the log info go to?  Is there a chunk of new code that
now does  kernel logging stuff, that differs from the way printk() works
today?


> (7) The template under (3) above would allow the command...
>         >evlview -b -f 'disk="sda3" && temperature>80'
>     to display events where sda3's temperature was greater than 80...
>         
> recid=2163, size=33, format=BINARY, event_type=0x8ab218f4, facility=disk_dummy, 
                       ^^^^^^
		       um, where did binary show up from?  This used to
		       be a simple text message.

> severity=ALERT, uid=root, gid=root, pid=1, pgrp=0, 
> time=Fri 20 Sep 2002 04:00:01 PM PDT, flags=0x2 (KERNEL), thread=0x0, 
> processor=2
> disk_dummy.c:dummy_mon:62
> Disk on fire!  action=Put out fire; run fsck. disk=sda3 temperature=88

Like Jeff said, policy remains in userspace.  Let the user decide if
they really want to put the fire out, or not :)

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

Why does this not work?

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

So this would be a "logging level", much like we currently have with the
KERN_* levels?

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

Ok, msg is not a format string here.

Why not just use the existing KERN_* values, and not create new LOG_*
values, as it looks like you are matching them 1 to 1.

> @@ -568,6 +570,7 @@
>  	static int cards_found /* = 0 */;
>  
>  	static int did_version /* = 0 */;		/* Already printed version info. */
> +	pci_introduce(pdev);

Please put this in the driver core.  That way you only have to modify
one file, not 500.

>  	if (speedo_debug > 0  &&  did_version++ == 0)
>  		printk(version);
>  
> @@ -586,12 +589,12 @@
>  
>  	if (!request_region(pci_resource_start(pdev, 1),
>  			pci_resource_len(pdev, 1), "eepro100")) {
> -		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
> +		pci_problem(LOG_ERR, pdev, "eepro100: cannot reserve I/O ports");
>  		goto err_out_none;
>  	}
>  	if (!request_mem_region(pci_resource_start(pdev, 0),
>  			pci_resource_len(pdev, 0), "eepro100")) {
> -		printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
> +		pci_problem(LOG_ERR, pdev, "eepro100: cannot reserve MMIO region");
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

But msg is a format string here.  What's the rules for this?


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

This used to be 3 messages.  Now it's 1.  Is that acceptable?

thanks,

greg k-h
