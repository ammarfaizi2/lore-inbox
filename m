Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264402AbUE0NeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUE0NeG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264349AbUE0NeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:34:06 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:16046 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264409AbUE0NdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:33:22 -0400
Date: Thu, 27 May 2004 22:34:36 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [Document][PATCH]Diskdump - yet another crash dump function
In-reply-to: <1CC443CDA50AF2indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <24C443EF5A3185indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <1CC443CDA50AF2indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a document for diskdump including overview, installation, and so
on.

Best Regards,
Takao Indoh



Introduction
------------
Diskdump offers a function to preserve so-called crash dump.
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


- Binary compatibility

The binary compatibility is assured because of no change of the size
of the existing structures and the arguments of existing functions.


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

The function sd_find_scsi_device() which gets Scsi_Device structure
from kdev which is the selected device is added to the sd module,
and is exported.

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
    request_queue_t *(*probe)(kdev_t);
    int (*add_device)(struct disk_dump_device *);
    void (*remove_device)(struct disk_dump_device *);
    struct module *owner;
    list_t list;
};

static struct disk_dump_type scsi_dump_type = {
    .probe        = scsi_dump_probe,
    .add_device    = scsi_dump_add_device,
    .remove_device    = scsi_dump_remove_device,
    .owner        = THIS_MODULE,
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
        block_nr, void *buf);
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
structure:

     struct scsi_dump_ops {
         int (*sanity_check)(Scsi_Device *);
         int (*quiesce)(Scsi_Device *);
         int (*shutdown)(Scsi_Device *);
         void (*poll)(Scsi_Device *);
     };

The poll function should call the interrupt handler.  It is called
repeatedly after queuecommand() is issued, and until the command is
completed.

The other handlers are called by the handlers in scsi_dump.o which
have the same names.

The adapter driver should set its own scsi_dump_ops to dump_ops
field in the scsi_host_template.

     struct scsi_host_template {
(snipped)
             /*
              * operations for dump
              */
             struct scsi_dump_ops *dump_ops;
     };




Supported Hardware
------------------
Currently, diskdump supports only scsi disk(aic7xxx/aic79xx). Please
see README in diskdumputils-0.1.5.tar.bz2 for detail.




Installation
------------
1) Download software

 1. Linux kernel version 2.6.6
    linux-2.6.6.tar.bz2 can be downloaded from  
      ftp://ftp.kernel.org/pub/linux/kernel/v2.6/
 
 2. diskdump kernel patch
    diskdump-0.1.tar.gz can be downloaded from the project page.
    http://sourceforge.net/projects/lkdump
 
 3. diskdumputils
    diskdumputils-0.1.5.tar.bz2 can be downloaded from the project page.
 
 4. crash command
    Download from here: ftp://people.redhat.com/anderson/

2) Build and Install Kernel 

 1. Untar Linux kernel source
     tar -xjvf  linux-2.6.6.tar.bz2
 2. Apply all patches in the diskdump-0.1.tar.gz
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
     ex. cp arch/i386/boot/bzImage /boot/vmlinuz-2.6.6-diskdump
 8. Reboot

3) Build and Install diskdumputils

 1. Untar diskdumputils package
     tar -xjvf diskdumputils-0.1.5.tar.bz2
 2. make
 3. make install

4) Setup

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
  header blocks: 3
  bitmap blocks: 8
  total number of memory blocks: 261999
  total blocks written: 262010

The last number is the data size in pagesize units that will be
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


If /proc/diskdump exists, and it shows the registered dump device,
the diskdump has been activated:

  # cat /proc/diskdump
  /dev/sde1 514080 1012095

To test the diskdump, use Alt-SysRq-C or "echo c >
/proc/sysrq-trigger".  After completing the dump, a vmcore file will
created during the next reboot sequence, and saved in a directory of
the name format:

  /var/crash/127.0.0.1-<date>

The dump format is same as the netdump one, so we can use crash command
to analyse. Crash command can be downloaded from
ftp://people.redhat.com/anderson/. 

  # crash vmlinux vmcore


