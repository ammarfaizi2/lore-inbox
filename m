Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUB1Hiy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 02:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUB1Hiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 02:38:54 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:64445 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262951AbUB1His (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 02:38:48 -0500
Date: Sat, 28 Feb 2004 15:38:34 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Alan Stern" <stern@rowland.harvard.edu>, "Greg KH" <greg@kroah.com>
Subject: Re: Question about (or bug in?) the kobject implementation
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0402272233330.4063-100000@netrider.rowland.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr32kuku54evsfm@smtp.pacific.net.th>
In-Reply-To: <Pine.LNX.4.44L0.0402272233330.4063-100000@netrider.rowland.org>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 23:02:34 -0500 (EST), Alan Stern <stern@rowland.harvard.edu> wrote:

> On Fri, 27 Feb 2004, Greg KH wrote:
>
>> Seriously, once kobject_del() is called, you can't safely call
>> kobject_get() anymore on that object.
>>
>> If you can think of a way we can implement this in the code to prevent
>> people from doing this, please send a patch.  We've been getting by
>> without such a "safeguard" so far...
>
> The problem is unsolvable.  Let me explain...
>
> We're actually discussing two different questions here.
>
>     A.	Is it okay to call kobject_add() after calling kobject_del() --
> 	this was my original question.
>
>     B.	Can we prevent people from doing kobject_get() after the kobject's
> 	refcount has dropped to 0?
>
> Your earlier response amounted to saying that A isn't good because it
> might cause B to happen; once kobject_del() has returned it's possible
> that the refcount is 0.  But this begs the real question.  Suppose we
> _know_ that the refcount isn't 0, say because earlier we did an unmatched
> kobject_get().  Under those circumstances should it be legal to call
> kobject_add() after calling kobject_del()?  This is question A'.
>
>
> Question B can be divided into two subcases.
>
>     B1.	The code calling kobject_get() knows that the kobject hasn't been
> 	deallocated yet.  For example, it might be the cleanup routine
> 	itself calling kobject_get().
>
> Such a thing is legal in Java, but you probably don't want to sanction
> such pranks in the driver model.  So let's forget about B1.  Your big
> concern really seems to be:
>
>     B2.	Everything else; the code calling kobject_get() doesn't know
> 	whether the kobject has been deallocated.
>
> This really is a programming error.  It means that kobject_get() has been
> passed a possibly stale pointer.  Ipso facto, the call to kobject_put()
> that decremented the refcount to 0 was made too early, while there were
> still active pointers to the kobject floating around.
>
> It's impossible to prevent people from making programming errors or
> dereferencing stale pointers.  It doesn't matter _what_ code you put in
> kobject_get() -- it will crash when given a pointer to a kobject whose
> cleanup routine has already run and deallocated the storage.
>
> The best you can do is call people's attention to such errors and fail the
> operation gracefully whenever possible (i.e., when it doesn't generate an
> addressing error).  My personal choice would be to change kobject_get() as
> follows:
>
> struct kobject * kobject_get(struct kobject * kobj)
> {
> 	if (kobj) {
> 		if (atomic_read(&kobj->refcount) == 0) {
> 			WARN_ON(1);
> 			return NULL;
> 		}
> 		atomic_inc(&kobj->refcount);
> 	}
> 	return kobj;
> }
>
> I think that's about the best you can do.

This is too ugly :-(

> And what's the answer to A'?

The weakness is really in that the refcount is stored dynamically.

What about a new struct to hold the pointer to the kobj and it's refcount:

struct kobjectref {
	struct kobject *kobj;
	int refcount;
};
...

struct kobjectref rkobj;

Using refkobj eliminates all problems as the pointer to the refcount can't
be invalid.

refcount would be removed from struct kobject.

Regards
Michael

List of files in 2.6.3 containing kobject, so it is not that bad to change it.

./arch/i386/kernel/edd.c
./arch/ppc64/kernel/vio.c
./Documentation/firmware_class/firmware_sample_firmware_class.c
./drivers/acorn/block/fd1772.c
./drivers/acpi/scan.c
./drivers/base/base.h
./drivers/base/bus.c
./drivers/base/class.c
./drivers/base/core.c
./drivers/base/cpu.c
./drivers/base/driver.c
./drivers/base/firmware.c
./drivers/base/firmware_class.c
./drivers/base/map.c
./drivers/base/sys.c
./drivers/block/amiflop.c
./drivers/block/as-iosched.c
./drivers/block/ataflop.c
./drivers/block/deadline-iosched.c
./drivers/block/elevator.c
./drivers/block/floppy98.c
./drivers/block/floppy.c
./drivers/block/genhd.c
./drivers/block/ll_rw_blk.c
./drivers/block/z2ram.c
./drivers/char/tty_io.c
./drivers/cpufreq/cpufreq.c
./drivers/i2c/chips/eeprom.c
./drivers/ide/ide-probe.c
./drivers/ieee1394/amdtp.c
./drivers/ieee1394/dv1394.c
./drivers/ieee1394/raw1394.c
./drivers/ieee1394/video1394.c
./drivers/md/md.c
./drivers/pci/hotplug/acpiphp.h
./drivers/pci/hotplug/pci_hotplug_core.c
./drivers/pci/hotplug/pci_hotplug.h
./drivers/pci/pci-driver.c
./drivers/pci/pci-sysfs.c
./drivers/scsi/qla2xxx/qla_os.c
./drivers/scsi/sd.c
./drivers/scsi/sg.c
./drivers/scsi/sim710.c
./drivers/scsi/st.c
./drivers/usb/serial/usb-serial.c
./drivers/usb/serial/usb-serial.h
./drivers/video/aty/radeon_base.c
./drivers/zorro/zorro-sysfs.c
./fs/block_dev.c
./fs/char_dev.c
./fs/partitions/check.c
./fs/sysfs/bin.c
./fs/sysfs/dir.c
./fs/sysfs/file.c
./fs/sysfs/group.c
./fs/sysfs/symlink.c
./fs/sysfs/sysfs.h
./include/acpi/acpi_bus.h
./include/linux/blkdev.h
./include/linux/cdev.h
./include/linux/cpufreq.h
./include/linux/device.h
./include/linux/elevator.h
./include/linux/fs.h
./include/linux/genhd.h
./include/linux/kobject.h
./include/linux/kobj_map.h
./include/linux/sysdev.h
./include/linux/sysfs.h
./kernel/power/main.c
./lib/kobject.c
./net/core/net-sysfs.c
./scripts/kconfig/gconf.c

--end
