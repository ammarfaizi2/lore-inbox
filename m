Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWFMVTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWFMVTo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWFMVTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:19:44 -0400
Received: from xenotime.net ([66.160.160.81]:22687 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932275AbWFMVTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:19:44 -0400
Date: Tue, 13 Jun 2006 14:22:29 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Markus Biermaier <mbier@office-m.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS:
 Cannot open root device
Message-Id: <20060613142229.5072b657.rdunlap@xenotime.net>
In-Reply-To: <6137A58D-963C-4379-A836-DCD28C3E88EE@office-m.at>
References: <6137A58D-963C-4379-A836-DCD28C3E88EE@office-m.at>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006 23:10:04 +0200 Markus Biermaier wrote:

> 
> Am 12.06.2006 um 21:09 schrieb Jan Engelhardt:
> 
> 
> > Hm. Maybe http://lkml.org/lkml/2005/2/26/92 (updated version for
> > 2.6.16/.17 below) can help you.
> >
> > diff --fast -Ndpru linux-2.6.17-rc6~/block/genhd.c linux-2.6.17-rc6 
> > +/block/genhd.c
> > --- linux-2.6.17-rc6~/block/genhd.c	2006-06-06 02:57:02.000000000  
> > +0200
> > +++ linux-2.6.17-rc6+/block/genhd.c	2006-06-08 22:29:16.607058000  
> > +0200
> > @@ -214,6 +214,52 @@ struct gendisk *get_gendisk(dev_t dev, i
> >  	return  kobj ? to_disk(kobj) : NULL;
> >  }
> >
> > +/*
> > + * printk a full list of all partitions - intended for
> > + * places where the root filesystem can't be mounted and thus
> > + * to give the victim some idea of what went wrong
> > + */
> > +void printk_all_partitions(void)
> >
> 
> 
> Am 13.06.2006 um 09:47 schrieb Markus Biermaier:
> 
> 
> > to get the function "printk_all_partitions" compiled I simply  
> > commented out "mutex_lock" and "mutex_unlock"...
> >
> > So the result before the boot-panic is:
> >
> > ...
> > here are the partitions available:
> > 2100     500472 hde driver: ide-disk
> >   2101     500440 hde1
> > ...
> > What does this mean?
> >
> 
> This holds the solution:
>                          /* Note, unlike /proc/partitions I'm showing  
> the numbers in hex
>                             in the same format as the root= option */
>                          printk("%02x%02x %10llu %s",
>                                 sgp->major, sgp->first_minor,
>                                 (unsigned long long)get_capacity(sgp)  
>  >> 1,
>                                 disk_name(sgp, 0, buf));
> 
> So my "/tftpboot/pxelinux.cfg/Cxxxxxx" is:
> ------------------------- [ BEGIN Cxxxxxx ] -------------------------
> DEFAULT standard
> LABEL standard
> KERNEL vmlinuz
> # APPEND initrd=initrd ramdisk_size=32768 root=/dev/hde1 udev  
> acpi=off rootdelay=5
> APPEND initrd=initrd ramdisk_size=32768 root=2101 udev acpi=off  
> rootdelay=5
> ------------------------- [ END   Cxxxxxx ] -------------------------
> 
> so the right root-string is: "root=2101".
> 
> But can anyone tell me how "root=/dev/hde1" translates to "root=2101"???

That's (hex) 0x2101.  In Documentation /devices.txt, we see:

 33 block	Third IDE hard disk/CD-ROM interface
		  0 = /dev/hde		Master: whole disk (or CD-ROM)
		 64 = /dev/hdf		Slave: whole disk (or CD-ROM)

		Partitions are handled the same way as for the first
		interface (see major number 3)

So device 33 (hex 21) is /dev/hde and 0x01 is partition 1 == hde1.


> Thank you very much, Jan.
> 
> You brought me the solution.


---
~Randy
