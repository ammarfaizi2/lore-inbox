Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267456AbUGWJu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267456AbUGWJu6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 05:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUGWJu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 05:50:58 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:49578 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267456AbUGWJuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 05:50:00 -0400
Date: Fri, 23 Jul 2004 18:51:18 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 0/5][Diskdump] IPF(IA64) support
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Message-id: <14C4709A99D341indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.63
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I release new version of diskdump for kernel 2.6.7.

- IPF(IA64) support
- Fusion-MPT scsi driver support

Source code can be downloaded from
 http://sourceforge.net/projects/lkdump

Please feel free to use!

Best Regards,
Takao Indoh
------------------------------------

Introduction
------------
Diskdump offers a function to execute so-called crash dump.
When "panic" or "oops" happens, diskdump automatically saves system
memory to the disk. We can investigate the cause of panic using this
saved memory image which we call as crash dump.




Overview
-------
- How it works

This is 2-stage dump which is similar to traditional UNIX dump.  The
1st stage starts when panic occurs, at which time the register state
and other dump-related data is stored in a header, followed by the
full contents of memory, in a dedicated dump partition.  The dump
partition will have been pre-formatted with per-block signatures.
The 2nd stage is executed by rc script after the next system reboot,
at which time the savecore command will create the vmcore file from
the contents of the dump partition.  After that, the per-block
signatures will be re-written over the dump partition, in
preparation for the next panic.

The handling of panic is essentially the same as netdump. It
inhibits interrupts, freezes all other CPUs, and then for each page
of data, issues the I/O command to the host adapter driver, followed
by calling the interrupt handler of the adapter driver iteratively
until the I/O has completed.  The difference compared to netdump is
that diskdump saves memory to the dump partition in its own loop,
and does not wait for instructions from an external entity.


- Safety

When diskdump is executed, of course the system is in serious
trouble.  Therefore, there is a possibility that user resources on
the disk containing the dump partition could be corrupted.  To avoid
this danger, signatures are written over the complete dump
partition.  When a panic occurs, the diskdump module reads the whole
dump partition, and checks if the signatures are written correctly.
If the signatures match, the diskdump presumes that it will be
writing to the correct device, and that there is a high possibility
that it will be able to write the dump correctly. The signatures
should be the ones which have low possibility to exist on the disk.

We decided that the following format will be written in each one
block (page-size) unit on the partition.  The signatures are created
by a simple formulas based on the block number, making it a low
possibility that the created signature would ever be the same as a
user resource:

  32-bit word 0: "disk"
  32-bit word 1: "dump"
  32-bit word 2: block number
  32-bit word 3: (block number+3)*11
  32-bit word 4: ((word 3)+3)*11
  32-bit work 5: ((word 4)+3)*11
  32-bit work 6: ((word 5)+3)*11
  ...
  32-bit work 1023: ((word 1022)+3)*11

The diskdump module also verifies that its code and data contents
have not been corrupted.  The dump module computes CRC value of its
module at the point that dump device is registered, and saves it.
When panic occurs, the dump module re-computes the CRC value at that
point and compares with the saved value.  If the values aren't the
same, the dump knows that it has been damaged and aborts the dump
process.


- Reliability

After panic occurs, I/O is executed by the diskdump module calling
the queuecommand() function of the host adapter driver, and by
polling the interrupt handler directly.  The dump is executed by
diskdump module and host adapter driver only. It is executed without
depending on other components of kernel, so it works even when panic
occurs in interrupt context.  (XXX To be exact, a couple of drivers
are not finished completely, because they calls kmalloc() as an
extension of queuecommand())

In SCSI, a host reset is executed first, so it is possible to dump
with a stable bus condition.  In a couple of drivers, especially in
the host reset process, timers and tasklets may be used.  For these
drivers, I created a helper library to emulate these functions.  The
helper library executes timer and tasklet functionality, which helps
to minimize the modification required to support diskdump.  The size
of initrd increases slightly because the driver depends upon the
helper library.

Multiple dump devices can be registered.  When a panic occurs, the
diskdump module checks each dump device condition and selects the
first sane device that it finds.

Diskdump and netdump can co-exist.  When both of modules are
enabled, the diskdump works in preference to the netdump.  If the
signature checking fails, if a disk I/O error occurs, or if a double
panic occurs in the diskdump process, it falls back to netdump.


- The architectures and drivers to be supported

IA32 only is supported.  Regarding drivers, aic7xxx, aic79xx and
qla1280 are supported.  I will support some qlogic drivers later.

The modification of supported drivers is needed, but the changes are
very small if they are SCSI drivers.


- The consistency with the netdump

The format of the saved vmcore file is completely the same as the
one which is created by the netdump-server.  The vmcore file created
by the savecore command can be read by the existing crash utility.

The saved directory is /var/crash/127.0.0.1-<DATE> which is
consistent with the netdump.  127.0.0.1 is an IP address which the
netdump can never use, so there is no conflict.  Our savecore
command also calls /var/crash/scripts/netdump-nospace script as does
the netdump-server daemon.


- Impact to kernel

The host adapter driver needs to be modified to support diskdump,
but the required steps are small.  For example, the modification
patch for the aic7xxx/aic9xxx drivers contains 100 lines for each.
At a minimum, a poll handler needs to be added, which is called from
diskdump to handle I/O completion. If the adapter driver does not
use timers or tasklets, that's all that is required.  Even if timers
or tasklets are used, it only requires a small amount of code from
the emulation library.

Similar to netdump, the variable diskdump_mode, the diskdump_func
hook, and the diskdump_register_hook() function has been created to
register diskdump functionality.

To check the result code of Scsi_Cmnd, scsi_decide_disposition() is
also exported.

scsi_done() and scsi_eh_done() discards Scsi_Cmnds when
diskdump_mode is set.  With this implementation, extra processing
can be avoided in the the extension of outstanding completion of
Scsi_Cmd, which is completed in the extension of host reset process.
This is the only overhead to be added to the main route.  It's
simply an addition of "if unlikely(diskdump_mode) return", so the
overhead is negligible.




Internal structure
------------------
- The interface between disdkdump.o and scsi_dump.o

scsi_dump.o is the diskdump driver for SCSI, and it registers itself
to diskdump.o.  (The diskdump drivers for IDE or SATA, if and when
they are created, would also register themselves to diskdump.o.)

scsi_mod.o defines the following structures:

struct disk_dump_type {
    void *(*probe)(struct device *);
    int (*add_device)(struct disk_dump_device *);
    void (*remove_device)(struct disk_dump_device *);
    struct module *owner;
    struct list_head list;
};

static struct disk_dump_type scsi_dump_type = {
    .probe         = scsi_dump_probe,
    .add_device    = scsi_dump_add_device,
    .remove_device = scsi_dump_remove_device,
    .owner         = THIS_MODULE,
};

scsi_dump registers them by register_disk_dump_type().

The probe() handler is called from diskdump.o to determine whether
the selected kdev_t belongs to scsi_mod.o.  If it returns 0 to
probe(), diskdump.o creates a disk_dump_device structure and calls
add_device().  The add_device() handler of scsi_dump.o populates the
disk_dump_device_ops of the disk_dump_device.  disk_dump_device_ops
is the set of handlers which are called from diskdump.o when panic
occurs:

struct disk_dump_device_ops {
    int (*sanity_check)(struct disk_dump_device *);
    int (*quiesce)(struct disk_dump_device *);
    int (*shutdown)(struct disk_dump_device *);
    int (*rw_block)(struct disk_dump_partition *, int rw, unsigned long
        block_nr, void *buf, int len);
};

The handler functions are only called when a panic occurs.

sanity_check() checks if the selected device works normally.  A
device which returns an error status will not be selected as the
dump device.

quiesce() is called after the device is selected as the dump device.
If it is SCSI, host reset is executed and Write Cache Enable bit of
the disk device is temporarily set for the dump operation.

shutdown() is called after dump is completed. If it is SCSI,
"SYNCHRONIZE CACHE" command is issued to the disk.

rw_block() executes I/O in one block unit.  The length of data is a
page size, and is guaranteed to be physically contiguous.  In
scsi_dump.o, it issues I/O by calling the queuecommand() handler
from the rw_block() handler.  The poll handler of adapter driver is
called until the I/O has completed.


- The interface between scsi_dump.o and the adapter driver

The SCSI adapter which supports the diskdump prepares the following
functions:

     int (*sanity_check)(struct scsi_device *);
     int (*quiesce)(struct scsi_device *);
     int (*shutdown)(struct scsi_device *);
     void (*poll)(struct scsi_device *);

The poll function should call the interrupt handler.  It is called
repeatedly after queuecommand() is issued, and until the command is
completed.

The other handlers are called by the handlers in scsi_dump.o which
have the same names.

The adapter driver should set its own handlers to the scsi_host_template.

    struct scsi_host_template {
(snipped)

    #if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
        /* operations for dump */

        /*
         * dump_sanity_check() checks if the selected device works normally.
         * A device which returns an error status will not be selected as
         * the dump device.
         *
         * Status: OPTIONAL
         */
        int (* dump_sanity_check)(struct scsi_device *);

        /*
         * dump_quiesce() is called after the device is selected as the
         * dump device. Usually, host reset is executed and Write Cache
         * Enable bit of the disk device is temporarily set for the
         * dump operation.
         *
         * Status: OPTIONAL
         */
        int (* dump_quiesce)(struct scsi_device *);

        /*
         * dump_shutdown() is called after dump is completed. Usually
         * "SYNCHRONIZE CACHE" command is issued to the disk.
         *
         * Status: OPTIONAL
         */
        int (* dump_shutdown)(struct scsi_device *);

        /*
         * dump_poll() should call the interrupt handler. It is called
         * repeatedly after queuecommand() is issued, and until the command
         * is completed. If the low level device driver support crash dump,
         * it must have this routine.
         *
         * Status: OPTIONAL
         */
        void (* dump_poll)(struct scsi_device *);
    #endif
    };


Supported Drivers
------------------
Disk dump only works on the disks which are connected to
adapters that the following drivers control:

	aic7xxx
	aic79xx
        mptscsih

Installation
------------
1) Download software

 1. Linux kernel version 2.6.7
    linux-2.6.7.tar.bz2 can be downloaded from  
      ftp://ftp.kernel.org/pub/linux/kernel/v2.6/
 
 2. diskdump kernel patch
    diskdump-0.6.tar.gz can be downloaded from the project page.
    http://sourceforge.net/projects/lkdump
 
 3. diskdumputils
    diskdumputils-0.4.2.tar.bz2 can be downloaded from the project page.
 
 4. crash command and patch
    crash can be download from ftp://people.redhat.com/anderson/.
    A patch for crash-3.8-5.tar.gz can be downloaded from the project page.

2) Build and Install Kernel 

 1. Untar Linux kernel source
     tar -xjvf  linux-2.6.7.tar.bz2
 2. Apply all patches in the diskdump-0.5.tar.gz
 3. Kernel Configuration
     a. make menuconfig
     b. Under "Device Drivers"-> "Block devices", select the following:
         i. Select "m" for "Disk dump support".
     c. Under "Device Drivers"-> "SCSI device support", select the
        following:
         i. Select "m" for "SCSI dump support".
     d. Under "Kernel hacking", select the following:
         i. Select "y" for "Kernel debugging".
        ii. Select "y" for "Magic SysRq key". (optional)
       iii. Select "y" for "Compile the kernel with debug info".
     e. Configure other kernel config settings as needed.
 4. make
 5. make modules_install
 6. Build initrd if you need
 7. Copy the kernel image to the boot directory
     ex. cp arch/i386/boot/bzImage /boot/vmlinuz-2.6.7-diskdump
 8. Reboot

3) Build and Install diskdumputils

 1. Untar diskdumputils package
     tar -xjvf diskdumputils-0.4.2.tar.bz2
 2. make
 3. make install

4) Build and Install crash

 1. Untar crash package
     tar -xjvf crash-3.8-5.tar.gz
 2. Apply crash-3.8-5.patch
 3. make
 4. make install

5) Setup

The setup procedure is as follows.  First a dump device must be
selected.  Either whole device or a partition is fine.  The dump
device is wholly formatted for dump, it cannot be shared with a file
system or as a swap partition.  The size of dump device should be
big enough to save the whole dump.  The size to be written by the
dump is the size of whole memory plus a header field.  To determine
the exact size, refer to the output kernel message after the
diskdump module is loaded:

  # modprobe diskdump

  # dmesg | tail
  disk_dump: total blocks required: 262042 (header 3 + bitmap 8 + memory 262031)
In this case, 262042 is the data size in pagesize units that will be
written by the diskdump function.

select the dump partition in /etc/sysconfig/diskdump, as in the
following example:

  -------------------
  DEVICE=/dev/sde1
  -------------------

Next, Format the dump partition.  The administrator needs to execute
this once.

  # service diskdump initialformat


Lastly, enable the service:

  # chkconfig diskdump on
  # service diskdump start

To test the diskdump, use Alt-SysRq-C or "echo c >
/proc/sysrq-trigger".  After completing the dump, a vmcore file will
created during the next reboot sequence, and saved in a directory of
the name format:

  /var/crash/127.0.0.1-<date>

The dump format is same as the netdump one, so we can use crash command
to analyse.

  # crash vmlinux vmcore


!!!NOTE!!!

Be careful when you investigate timer/tasklet/workqueue. Diskdump saves
timer/tasklet/workqueue structure and clears them before dumping. Please
see the following.

[timer]
Where is the structure saved?

	static tvec_base_t saved_tvec_base;

How is the structure saved?

	tvec_base_t *base = &per_cpu(tvec_bases, smp_processor_id());
	memcpy(&saved_tvec_base, base, sizeof(saved_tvec_base));


How is the structure cleared?

	init_timers_cpu(smp_processor_id());


[tasklet]
Where is the structure saved?

	struct tasklet_head saved_tasklet;

How is the structure saved?

	saved_tasklet.list = __get_cpu_var(tasklet_vec).list;


How is the structure cleared?

	__get_cpu_var(tasklet_vec).list = NULL;


[workqueue]
Where is the structure saved?

	struct cpu_workqueue_struct saved_cwq;

How is the structure saved?

	int cpu = smp_processor_id();
	struct cpu_workqueue_struct *cwq = keventd_wq->cpu_wq + cpu;
	memcpy(&saved_cwq, cwq, sizeof(saved_cwq));


How is the structure cleared?

	spin_lock_init(&cwq->lock);
	INIT_LIST_HEAD(&cwq->worklist);
	init_waitqueue_head(&cwq->more_work);
	init_waitqueue_head(&cwq->work_done);

