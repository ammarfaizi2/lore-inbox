Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbTDICAw (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 22:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTDICAw (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 22:00:52 -0400
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:8708
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S261320AbTDICA0 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 22:00:26 -0400
From: "Shawn Starr" <spstarr@sh0n.net>
To: "'Andrew Morton'" <akpm@digeo.com>
Cc: <roland@topspin.com>, <rml@tech9.net>, <rmk@arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: [BUG][2.5.66bk9+] - tty hangings - patches, dmesg & sysctl+T info
Date: Tue, 8 Apr 2003 22:12:09 -0400
Message-ID: <003001c2fe3d$6eab1080$030aa8c0@unknown>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20030406133827.34bfbf93.akpm@digeo.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches Applied to 2.5.66-bk9:
==============================

2.5.64-sysctld.patch (from rmk):
--------------------------------

>From rmk@arm.linux.org.uk Fri Mar 14 15:19:17 2003
Date: Fri, 14 Mar 2003 19:53:22 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Shawn Starr <spstarr@sh0n.net>
Subject: Re: [BUG][2.5.64bk4] Weird problem with 2 PCs

On Fri, Mar 14, 2003 at 12:15:47PM -0500, Shawn Starr wrote:
> 2.4 isn't locking up when I turn on the other box. This is going to be
> hard to track down. Will kgdb help me out?

Ok, here's a patch.  Make sure you have sysrq enabled, and, after the
crash, <alt>-<sysrq>-d on the keyboard of the crashed machine should
dump all the kernel messages.

--- orig/kernel/printk.c        Tue Feb 11 16:10:58 2003
+++ linux/kernel/printk.c       Fri Mar 14 19:42:48 2003
@@ -675,3 +675,25 @@
                tty->driver.write(tty, 0, msg, strlen(msg));
        return;
 }
+
+#include <linux/sysrq.h>
+
+static void
+show_msg_info(int key, struct pt_regs *regs, struct tty_struct *tty)
+{
+       call_console_drivers(log_end - logged_chars, log_end);
+}
+
+static struct sysrq_key_op msg_info_op = {
+       .handler        = show_msg_info,
+       .help_msg       = "Dumpmsgs",
+       .action_msg     = "Kernel Messages",
+};
+
+static int __init dbg_init(void)
+{
+       register_sysrq_key('d', &msg_info_op);
+       return 0;
+}
+
+__initcall(dbg_init);


timerfind.diff (from akpm):
---------------------------

fs/open.c             |   33 +++++++++++++++++++++++++++++++++
 include/linux/timer.h |    3 ++-
 mm/slab.c             |   30 ++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff -puN include/linux/timer.h~freed-timer-finder include/linux/timer.h
--- 25/include/linux/timer.h~freed-timer-finder 2003-03-29
14:10:15.000000000 -0800
+++ 25-akpm/include/linux/timer.h       2003-03-29 14:10:26.000000000 -0800
@@ -8,11 +8,12 @@
 struct tvec_t_base_s;

 struct timer_list {
+       unsigned long magic;
+
        struct list_head entry;
        unsigned long expires;

        spinlock_t lock;
-       unsigned long magic;

        void (*function)(unsigned long);
        unsigned long data;
diff -puN mm/slab.c~freed-timer-finder mm/slab.c
--- 25/mm/slab.c~freed-timer-finder     2003-03-29 14:10:30.000000000 -0800
+++ 25-akpm/mm/slab.c   2003-03-29 14:16:23.000000000 -0800
@@ -800,6 +800,35 @@ static void poison_obj(kmem_cache_t *cac
        *(unsigned char *)(addr+size-1) = POISON_END;
 }

+static void timer_hunt(kmem_cache_t *cachep, void *addr)
+{
+       int size = cachep->objsize;
+       void *p;
+
+       if (cachep->flags & SLAB_RED_ZONE) {
+               addr += BYTES_PER_WORD;
+               size -= 2*BYTES_PER_WORD;
+       }
+       if (cachep->flags & SLAB_STORE_USER) {
+               size -= BYTES_PER_WORD;
+       }
+
+       for (p = addr; p < addr + size; p += sizeof(unsigned long)) {
+               unsigned long *laddr = p;
+
+               if (*laddr == TIMER_MAGIC) {
+                       struct timer_list *timer;
+
+                       timer = (struct timer_list *)laddr;
+                       if (timer_pending(timer)) {
+                               printk("free of pending timer at %p\n",
timer);
+                               printk("function=%p\n", timer->function);
+                               dump_stack();
+                       }
+               }
+       }
+}
+
 static void *fprob(unsigned char* addr, unsigned int size)
 {
        unsigned char *end;
@@ -1603,6 +1632,7 @@ static inline void *cache_free_debugchec
                else
                        cachep->dtor(objp, cachep, 0);
        }
+       timer_hunt(cachep, objp);
        if (cachep->flags & SLAB_POISON)
                poison_obj(cachep, objp, POISON_AFTER);
 #endif
diff -puN fs/open.c~freed-timer-finder fs/open.c
--- 25/fs/open.c~freed-timer-finder     2003-03-29 14:17:32.000000000 -0800
+++ 25-akpm/fs/open.c   2003-03-29 14:21:20.000000000 -0800
@@ -793,11 +793,44 @@ void fd_install(unsigned int fd, struct
        write_unlock(&files->file_lock);
 }

+#include <linux/timer.h>
+
+struct foo_thing {
+       int a;
+       struct timer_list t;

+       int b;
+};
+
+static void my_foo(unsigned long data)
+{
+       printk("the handler\n");
+}
+
+static void timer_thing(void)
+{
+       static int did_it;
+       struct foo_thing *f;
+
+       if (did_it)
+               return;
+       did_it = 1;
+
+       f = kmalloc(sizeof(*f), GFP_KERNEL);
+       init_timer(&f->t);
+       f->t.expires = jiffies + HZ;
+       f->t.function = my_foo;
+       add_timer(&f->t);
+       kfree(f);
+}
+
 asmlinkage long sys_open(const char * filename, int flags, int mode)
 {
        char * tmp;
        int fd, error;

+       if (current->uid == 9999)
+               timer_thing();
+
 #if BITS_PER_LONG != 32
        flags |= O_LARGEFILE;
 #endif


ttyfix2.diff (from akpm):
-------------------------

>  25-akpm/drivers/char/tty_io.c     |    9 ++++++++-
>  25-akpm/include/linux/workqueue.h |   10 ++++++++++
>  25-akpm/kernel/workqueue.c        |    4 +++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff -puN drivers/char/tty_io.c~tty-shutdown-race-fix
drivers/char/tty_io.c
> --- 25/drivers/char/tty_io.c~tty-shutdown-race-fix    Wed Apr  2 16:14:12
2003
> +++ 25-akpm/drivers/char/tty_io.c     Wed Apr  2 16:20:36 2003
> @@ -1286,7 +1286,14 @@ static void release_dev(struct file * fi
>       }
>
>       /*
> -      * Make sure that the tty's task queue isn't activated.
> +      * Prevent flush_to_ldisc() from rescheduling the work for later.
Then
> +      * kill any delayed work.
> +      */
> +     clear_bit(TTY_DONT_FLIP, &tty->flags);
> +     cancel_delayed_work(&tty->flip.work);
> +
> +     /*
> +      * Wait for ->hangup_work and ->flip.work handlers to terminate
>        */
>       flush_scheduled_work();

> diff -puN include/linux/workqueue.h~tty-shutdown-race-fix
> include/linux/workqueue.h ---
> 25/include/linux/workqueue.h~tty-shutdown-race-fix    Wed Apr  2 16:16:17
2003
> +++ 25-akpm/include/linux/workqueue.h Wed Apr  2 16:18:58 2003
> @@ -63,5 +63,15 @@ extern int current_is_keventd(void);
>
>  extern void init_workqueues(void);
>
> +/*
> + * Kill off a pending schedule_delayed_work().  Note that the work
> callback + * function may still be running on return from
> cancel_delayed_work().  Run + * flush_scheduled_work() to wait on it.
> + */
> +static inline int cancel_delayed_work(struct work_struct *work)
> +{
> +     return del_timer_sync(&work->timer);
> +}
> +
>  #endif
>
> diff -puN kernel/workqueue.c~tty-shutdown-race-fix kernel/workqueue.c
> --- 25/kernel/workqueue.c~tty-shutdown-race-fix       Wed Apr  2 16:21:04
2003
> +++ 25-akpm/kernel/workqueue.c        Wed Apr  2 16:31:08 2003
> @@ -231,6 +231,8 @@ void flush_workqueue(struct workqueue_st
>       struct cpu_workqueue_struct *cwq;
>       int cpu;
>
> +     might_sleep();
> +
>       for (cpu = 0; cpu < NR_CPUS; cpu++) {
>               if (!cpu_online(cpu))
>                       continue;
> @@ -246,7 +248,7 @@ void flush_workqueue(struct workqueue_st
>                        * Wait for helper thread(s) to finish up
>                        * the queue:
>                        */
> -                     set_task_state(current, TASK_INTERRUPTIBLE);
> +                     set_current_state(TASK_UNINTERRUPTIBLE);
>                       add_wait_queue(&cwq->work_done, &wait);
>                       if (atomic_read(&cwq->nr_queued))
>                               schedule();

dmesg:
======

Linux version 2.5.66-bk9 (root@coredump) (gcc version 3.2.3 20030208
(prerelease)) #1 Thu Apr 3 20:14:38 EST 2003
Video mode to be used for restore is ffff
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000007ffd9c0 (usable)
  BIOS-e820: 0000000007ffd9c0 - 0000000008000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
 127MB LOWMEM available.
 On node 0 totalpages: 32765
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 28669 pages, LIFO batch:6
   HighMem zone: 0 pages, LIFO batch:1
 ACPI: RSDP (v000 IBM                        ) @ 0x000fdfe0
 ACPI: RSDT (v001 IBM    CDTPWSNV 00000.04112) @ 0x07ffff80
 ACPI: FADT (v001 IBM    CDTPWSNV 00000.04112) @ 0x07ffff00
 ACPI: DSDT (v001 IBM    CDTPWSNV 00000.04096) @ 0x00000000
 ACPI: BIOS passes blacklist
 ACPI: MADT not present
 IBM machine detected. Enabling interrupts during APM calls.
 IBM machine detected. Disabling SMBus accesses.
 Building zonelist for node : 0
 Kernel command line: BOOT_IMAGE=newlinux ro root=301
rootflags=data=writeback pci=noacpi console=ttyS2,9600n8
 Local APIC disabled by BIOS -- reenabling.
 Found and enabled local APIC!
 Initializing CPU#0
 PID hash table entries: 512 (order 9: 4096 bytes)
 Detected 447.948 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 884.73 BogoMIPS
 Memory: 125132k/131060k available (2748k kernel code, 5392k reserved, 759k
data, 340k init, 0k highmem)
 Security Scaffold v1.0.0 initialized
 Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
 Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
 -> /dev
 -> /dev/console
 -> /root
 CPU: L1 I cache: 16K, L1 D cache: 16K
 CPU: L2 cache: 512K
 CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 CPU: Intel Pentium III (Katmai) stepping 03
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
 POSIX conformance testing by UNIFIX
 enabled ExtINT on CPU#0
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 Using local APIC timer interrupts.
 calibrating APIC timer ...
 ..... CPU clock speed is 448.0002 MHz.
 ..... host bus clock speed is 99.0556 MHz.
 Initializing RT netlink socket
 mtrr: v2.0 (20020519)
 PCI: PCI BIOS revision 2.10 entry at 0xfd83c, last bus=1
 PCI: Using configuration type 1
 BIO: pool of 256 setup, 14Kb (56 bytes/bio)
 biovec pool[0]:   1 bvecs: 242 entries (12 bytes)
 biovec pool[1]:   4 bvecs: 242 entries (48 bytes)
 biovec pool[2]:  16 bvecs: 242 entries (192 bytes)
 biovec pool[3]:  64 bvecs: 242 entries (768 bytes)
 biovec pool[4]: 128 bvecs: 121 entries (1536 bytes)
 biovec pool[5]: 256 bvecs:  60 entries (3072 bytes)
 ACPI: Subsystem revision 20030328
  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
acquired
 Parsing all Control
Methods:....................................................................
...........................
 Table [DSDT] - 250 Objects with 29 Devices 95 Methods 7 Regions
 ACPI Namespace successfully loaded at root c04d93bc
 evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
 evgpeblk-0731 [06] ev_create_gpe_block   : GPE Block: [_GPE] 2 registers at
000000000000FD0C on interrupt 9
 evgpeblk-0736 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x00 to
GPE 0x0F
 evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L0B as
GPE number 0x0B
 Executing all Device _STA and_INI methods:.............................
 29 Devices found containing: 29 _STA, 2 _INI methods
 Completing Region/Field/Buffer/Package
initialization:.........................
 Initialized 2/7 Regions 1/6 Fields 13/15 Buffers 9/9 Packages (250 nodes)
 ACPI: Interpreter enabled
 ACPI: Using PIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (00:00)
 PCI: Probing PCI hardware (bus 00)
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 ACPI: PCI Interrupt Link [PIN1] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [PIN2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
 ACPI: PCI Interrupt Link [PIN3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [PIN4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
 Linux Plug and Play Support v0.95 (c) Adam Belay
 pnp: the driver 'system' has been registered
 PnPBIOS: Found PnP BIOS installation structure at 0xc00fde50
 PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x587a, dseg 0xf0000
 pnp: match found with the PnP device '00:09' and the driver 'system'
 pnp: match found with the PnP device '00:0a' and the driver 'system'
 pnp: match found with the PnP device '00:0c' and the driver 'system'
 pnp: match found with the PnP device '00:0d' and the driver 'system'
 pnp: match found with the PnP device '00:0e' and the driver 'system'
 pnp: match found with the PnP device '00:0f' and the driver 'system'
 pnp: match found with the PnP device '00:10' and the driver 'system'
 pnp: match found with the PnP device '00:15' and the driver 'system'
 PnPBIOS: 21 nodes reported by PnP BIOS; 21 recorded by driver
 block request queues:
  128 requests per read queue
  128 requests per write queue
  8 requests per batch
  enter congestion at 15
  exit congestion at 17
 SCSI subsystem initialized
 drivers/usb/core/usb.c: registered new driver usbfs
 drivers/usb/core/usb.c: registered new driver hub
 PCI: Probing PCI hardware
 PCI: Using IRQ router PIIX [8086/7110] at 00:02.0
 IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
 Enabling SEP on CPU 0
 Journalled Block Device driver loaded
 Capability LSM initialized
 There is already a security framework initialized, register_security
failed.
 Failure registering Root Plug module with the kernel
 Failure registering Root Plug  module with primary security module.
 Initializing Cryptographic API
 Limiting direct PCI/PCI transfers.
 ACPI: Power Button (FF) [PWRF]
 ACPI: Processor [CPU0] (supports C1)
 isapnp: Scanning for PnP cards...
 pnp: Calling quirk for 01:01.00
 pnp: SB audio device quirk - increasing port range
 pnp: Calling quirk for 01:01.02
 pnp: AWE32 quirk - adding two ports
 isapnp: Card 'Creative SB32 PnP'
 isapnp: Card 'U.S. Robotics Sportster 33600 FAX/Voice Int'
 isapnp: 2 Plug & Play cards detected total
 pty: 256 Unix98 ptys configured
 request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
 lp: driver loaded but no devices found
 Real Time Clock Driver v1.11
 Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is
60 seconds).
 Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
 ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
 pnp: the driver 'serial' has been registered
 pnp: match found with the PnP device '00:12' and the driver 'serial'
 pnp: match found with the PnP device '00:13' and the driver 'serial'
 pnp: match found with the PnP device '01:02.00' and the driver 'serial'
 pnp: res: the device '01:02.00' has been activated.
 ttyS3 at I/O 0x2e8 (irq = 5) is a 16550A
 pnp: the driver 'parport_pc' has been registered
 pnp: match found with the PnP device '00:14' and the driver 'parport_pc'
 parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
 parport0: irq 7 detected
 parport0: cpp_daisy: aa5500ff(38)
 parport0: assign_addrs: aa5500ff(38)
 parport0: cpp_daisy: aa5500ff(38)
 parport0: assign_addrs: aa5500ff(38)
 lp0: using parport0 (polling).
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077
 Intel(R) PRO/100 Network Driver - version 2.2.21-k1
 Copyright (c) 2003 Intel Corporation
 PCI: Found IRQ 11 for device 00:03.0
 PCI: Sharing IRQ 11 with 00:02.2
 e100: selftest OK.
 Freeing alive device c7edc000, eth%%d
 e100: eth0: Intel(R) PRO/100 Network Connection
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 PIIX4: IDE controller at PCI slot 00:02.1
 PIIX4: chipset revision 1
 PIIX4: not 100%% native mode: will probe irqs later
     ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: hdc:DMA, hdd:pio
 hda: MAXTOR 6L040L2, ATA DISK drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hdc: CRD-8400B, ATAPI CD/DVD-ROM drive
 ide1 at 0x170-0x177,0x376 on irq 15
 ide2: I/O resource 0x3EE-0x3EE not free.
 ide2: ports already in use, skipping probe
 hda: host protected area => 1
 hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=77557/16/63, UDMA(33)
  hda: hda1 hda2
 end_request: I/O error, dev hdc, sector 0
 hdc: ATAPI 40X CD-ROM drive, 128kB Cache
 Uniform CD-ROM driver Revision: 3.12
 end_request: I/O error, dev hdc, sector 0
 PCI: Found IRQ 9 for device 00:12.0
 PCI: Sharing IRQ 9 with 01:01.0
 scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
         <Adaptec 2902/04/10/15/20/30C SCSI adapter>
         aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
   Vendor: HP        Model: T4000s            Rev: 1.10
   Type:   Sequential-Access                  ANSI SCSI revision: 02
 st: Version 20021214, fixed bufsize 32768, wrt 30720, s/g segs 256
 Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
 st0: try direct i/o: yes, max page reachable by HBA 1048575
 ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
 ohci-hcd: block sizes: ed 64 td 64
 drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver
v2.0
 PCI: Found IRQ 11 for device 00:02.2
 PCI: Sharing IRQ 11 with 00:03.0
 uhci-hcd 00:02.2: Intel Corp. 82371AB/EB/MB PIIX4 
 uhci-hcd 00:02.2: irq 11, io base 0000ff00
 Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
 uhci-hcd 00:02.2: new USB bus registered, assigned bus number 1
 drivers/usb/host/uhci-hcd.c: detected 2 ports
 uhci-hcd 00:02.2: root hub device address 1
 usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb1: Product: Intel Corp. 82371AB/EB/MB PIIX4 
 usb usb1: Manufacturer: Linux 2.5.66-bk9 uhci-hcd
 drivers/usb/host/uhci-hcd.c: ff00: suspend_hc
 usb usb1: SerialNumber: 00:02.2
 usb usb1: usb_new_device - registering interface 1-0:0
 hub 1-0:0: usb_device_probe
 hub 1-0:0: usb_device_probe - got id
 hub 1-0:0: USB hub found
 hub 1-0:0: 2 ports detected
 hub 1-0:0: standalone hub
 hub 1-0:0: ganged power switching
 hub 1-0:0: global over-current protection
 hub 1-0:0: Port indicators are not supported
 hub 1-0:0: power on to power good time: 2ms
 hub 1-0:0: hub controller current requirement: 0mA
 hub 1-0:0: local power source is good
 hub 1-0:0: no over-current condition exists
 hub 1-0:0: enabling power on all ports
 mice: PS/2 mouse device common for all mice
 input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
 serio: i8042 AUX port at 0x60,0x64 irq 12
 input: AT Set 2 keyboard on isa0060/serio0
 serio: i8042 KBD port at 0x60,0x64 irq 1
 sb: Init: Starting Probe...
 pnp: the driver 'OSS SndBlstr' has been registered
 pnp: match found with the PnP device '01:01.00' and the driver 'OSS
SndBlstr'
 pnp: res: the device '01:01.00' has been activated.
 sb: PnP: Found Card Named = "Audio", Card PnP id = CTL0048, Device PnP id =
CTL0031
 sb: PnP:      Detected at: io=0x220, irq=10, dma=1, dma16=5
 <Sound Blaster 16 (4.13)> at 0x220 irq 10 dma 1,5
 sb: Turning on MPU
 <Sound Blaster 16> at 0x300 irq 10
 sb: Init: Done
 YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft
1993-1996
 NET4: Linux TCP/IP 1.0 for NET4.0
 IP: routing cache hash table of 128 buckets, 4Kbytes
 TCP: Hash tables configured (established 8192 bind 2340)
 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with writeback data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 340k freed
 Adding 72284k swap on /dev/hda2.  Priority:1 extents:1
 EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
 process `named' is using obsolete setsockopt SO_BSDCOMPAT
 e100: eth0 NIC Link is Up 100 Mbps Full duplex
 process `rndc' is using obsolete setsockopt SO_BSDCOMPAT
 Kernel logging (proc) stopped.
 Kernel log daemon terminating.
 klogd 1.4.1, log source = /proc/kmsg started.
 Inspecting /boot/System.map
 Loaded 27575 symbols from /boot/System.map.
 Symbols match kernel version 2.5.66.
 No module symbols loaded - kernel modules not enabled.

Sysctl+T: Information - Complete list
=====================================

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S C114BEB4 4294954828     1      0     2               (NOTLB)
Call Trace:
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c012ee53>] schedule_timeout+0x93/0xf0
 [<c012edb0>] process_timeout+0x0/0x10
 [<c0186793>] do_select+0x123/0x250
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c0186c16>] sys_select+0x326/0x560
 [<c017aa17>] sys_stat64+0x37/0x40
 [<c010a2ab>] syscall_call+0x7/0xb

ksoftirqd/0   S 00000000 20828     2      1             3       (L-TLB)
Call Trace:
 [<c012982e>] ksoftirqd+0x7e/0xd0
 [<c01297b0>] ksoftirqd+0x0/0xd0
 [<c01073bd>] kernel_thread_helper+0x5/0x18

events/0      S C02597A9 157356     3      1             4     2 (L-TLB)
Call Trace:
 [<c02597a9>] flush_to_ldisc+0x159/0x250
 [<c026c9b3>] poke_blanked_console+0x53/0x70
 [<c0139175>] worker_thread+0x4d5/0x500
 [<c026b970>] console_callback+0x0/0xc0
 [<c011de30>] default_wake_function+0x0/0x20
 [<c010a182>] ret_from_fork+0x6/0x14
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0138ca0>] worker_thread+0x0/0x500
 [<c01073bd>] kernel_thread_helper+0x5/0x18

khubd         S C1180000 206288     4      1             5     3 (L-TLB)
Call Trace:
 [<c0125a9a>] allow_signal+0xca/0x200
 [<c0309076>] usb_hub_thread+0x96/0xf0
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0308fe0>] usb_hub_thread+0x0/0xf0
 [<c01073bd>] kernel_thread_helper+0x5/0x18

pdflush       S 00000000 114964228     5      1             6     4 (L-TLB)
Call Trace:
 [<c014c32d>] __pdflush+0x15d/0x660
 [<c014c830>] pdflush+0x0/0x20
 [<c014c83f>] pdflush+0xf/0x20
 [<c01073b8>] kernel_thread_helper+0x0/0x18
 [<c01073bd>] kernel_thread_helper+0x5/0x18

pdflush       S 00000000 12724     6      1             7     5 (L-TLB)
Call Trace:
 [<c014c32d>] __pdflush+0x15d/0x660
 [<c014c830>] pdflush+0x0/0x20
 [<c014c83f>] pdflush+0xf/0x20
 [<c01073b8>] kernel_thread_helper+0x0/0x18
 [<c01073bd>] kernel_thread_helper+0x5/0x18

kswapd0       S 00000064 4294932780     7      1             8     6 (L-TLB)
Call Trace:
 [<c0154653>] kswapd+0xf3/0x130
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c010a182>] ret_from_fork+0x6/0x14
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0154560>] kswapd+0x0/0x130
 [<c01073bd>] kernel_thread_helper+0x5/0x18

aio/0         S 00010000 4294927640     8      1             9     7 (L-TLB)
Call Trace:
 [<c0134e06>] do_sigaction+0x3d6/0x730
 [<c0139175>] worker_thread+0x4d5/0x500
 [<c011de16>] preempt_schedule+0x36/0x50
 [<c011de30>] default_wake_function+0x0/0x20
 [<c010a182>] ret_from_fork+0x6/0x14
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0138ca0>] worker_thread+0x0/0x500
 [<c01073bd>] kernel_thread_helper+0x5/0x18

scsi_eh_0     S 00000000 4294332912     9      1            10     8 (L-TLB)
Call Trace:
 [<c01085d7>] __down_interruptible+0x167/0x370
 [<c011de8a>] __wake_up_common+0x3a/0x60
 [<c011de30>] default_wake_function+0x0/0x20
 [<c010896b>] __down_failed_interruptible+0x7/0xc
 [<c02c9438>] .text.lock.scsi_error+0x41/0x49
 [<c02c8fa0>] scsi_error_handler+0x0/0x2e0
 [<c01073bd>] kernel_thread_helper+0x5/0x18

ahc_dv_0      S C7E4A000 4294298348    10      1            11     9 (L-TLB)
Call Trace:
 [<c028a81c>] __blk_run_queue+0x1c/0x30
 [<c01085d7>] __down_interruptible+0x167/0x370
 [<c011de30>] default_wake_function+0x0/0x20
 [<c010896b>] __down_failed_interruptible+0x7/0xc
 [<c02f4ef0>] .text.lock.aic7xxx_osm+0x19/0x89
 [<c010a182>] ret_from_fork+0x6/0x14
 [<c02ecdf0>] ahc_linux_dv_thread+0x0/0xbb0
 [<c01073bd>] kernel_thread_helper+0x5/0x18

kseriod       S C7DFE000  8028    11      1            12    10 (L-TLB)
Call Trace:
 [<c0125a9a>] allow_signal+0xca/0x200
 [<c0125ca0>] daemonize+0xd0/0xe0
 [<c03295a6>] serio_thread+0x176/0x2a0
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0329430>] serio_thread+0x0/0x2a0
 [<c01073bd>] kernel_thread_helper+0x5/0x18

kjournald     S C010AC18 4294696740    12      1            66    11 (L-TLB)
Call Trace:
 [<c010ac18>] common_interrupt+0x18/0x20
 [<c011e763>] interruptible_sleep_on+0xf3/0x2b0
 [<c011de30>] default_wake_function+0x0/0x20
 [<c01d20ef>] kjournald+0x1bf/0x360
 [<c01d1f10>] commit_timeout+0x0/0x10
 [<c01d1f30>] kjournald+0x0/0x360
 [<c01073bd>] kernel_thread_helper+0x5/0x18

syslogd       S 000001BF 108296488    66      1            69    12 (NOTLB)
Call Trace:
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c014a8ea>] __get_free_pages+0x1a/0x50
 [<c01864f1>] __pollwait+0x41/0xd0
 [<c0350a5b>] datagram_poll+0x2b/0xe0
 [<c0349f49>] sock_poll+0x29/0x40
 [<c0186793>] do_select+0x123/0x250
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c0186c16>] sys_select+0x326/0x560
 [<c034b91f>] sys_socketcall+0x17f/0x2a0
 [<c010a2ab>] syscall_call+0x7/0xb

klogd         R FFFFFFFF 108068924    69      1            95    66 (NOTLB)
Call Trace:
 [<c01e8313>] capable+0x23/0x50
 [<c0123e57>] do_syslog+0x437/0x8c0
 [<c011de30>] default_wake_function+0x0/0x20
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c010cd75>] do_IRQ+0x235/0x370
 [<c016cc2e>] sys_read+0x3e/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

named         S BFFFF9B0 4286002408    95      1    96     112    69 (NOTLB)
Call Trace:
 [<c0135677>] sys_rt_sigaction+0x97/0x110
 [<c0108dad>] sys_rt_sigsuspend+0x1cd/0x2c0
 [<c010a2ab>] syscall_call+0x7/0xb

named         S C7555EFC 102819928    96     95    98               (NOTLB)
Call Trace:
 [<c012ee53>] schedule_timeout+0x93/0xf0
 [<c014a8ea>] __get_free_pages+0x1a/0x50
 [<c012edb0>] process_timeout+0x0/0x10
 [<c0186f9b>] do_poll+0xab/0xd0
 [<c0187120>] sys_poll+0x160/0x260
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c010a2ab>] syscall_call+0x7/0xb

named         S 00000015 103684588    98     96            99       (NOTLB)
Call Trace:
 [<c0108dad>] sys_rt_sigsuspend+0x1cd/0x2c0
 [<c0128994>] sys_gettimeofday+0xc4/0xd0
 [<c010a2ab>] syscall_call+0x7/0xb

named         S C7643F48 114768    99     96           104    98 (NOTLB)
Call Trace:
 [<c0140b78>] do_clock_nanosleep+0x208/0x390
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0140700>] nanosleep_wake_up+0x0/0x10
 [<c013394f>] sys_rt_sigprocmask+0xdf/0x2f0
 [<c011215a>] do_gettimeofday+0x1a/0x90
 [<c01407aa>] sys_nanosleep+0x7a/0x110
 [<c010a2ab>] syscall_call+0x7/0xb

named         S C2810788 4294019292   104     96                  99 (NOTLB)
Call Trace:
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c036ddb3>] tcp_poll+0x33/0x190
 [<c0349f49>] sock_poll+0x29/0x40
 [<c0186793>] do_select+0x123/0x250
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c0186c16>] sys_select+0x326/0x560
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c010a2ab>] syscall_call+0x7/0xb

bash          S C0419DA0 4293682660   112      1           113    95 (NOTLB)
Call Trace:
 [<c028a417>] generic_unplug_device+0x167/0x1c0
 [<c011d914>] schedule+0x214/0x6e0
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c01464e1>] __lock_page+0xd1/0xf0
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c025d4f1>] read_chan+0x2e1/0x1010
 [<c0146335>] unlock_page+0x15/0x60
 [<c0157dc3>] do_wp_page+0x523/0x580
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c012e606>] update_wall_time+0x16/0x40
 [<c02563bd>] tty_read+0x24d/0x2d0
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c010cd75>] do_IRQ+0x235/0x370
 [<c016cc2e>] sys_read+0x3e/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

agetty        S 00000086 4182782832   113      1           115   112 (NOTLB)
Call Trace:
 [<c0279a19>] serial8250_start_tx+0x79/0x80
 [<c0273831>] __uart_start+0x51/0x60
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c02743e0>] uart_write+0x190/0x4c0
 [<c025d4f1>] read_chan+0x2e1/0x1010
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c02563bd>] tty_read+0x24d/0x2d0
 [<c025e220>] write_chan+0x0/0x240
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c016cc2e>] sys_read+0x3e/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

login         D C7250C94 4191040372   115      1           116   113 (L-TLB)
Call Trace:
 [<c01394a5>] flush_workqueue+0x305/0x450
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0257a44>] release_dev+0x6a4/0x860
 [<c010cd75>] do_IRQ+0x235/0x370
 [<c0258204>] tty_release+0x94/0x1b0
 [<c016dd7c>] __fput+0xac/0x100
 [<c0258170>] tty_release+0x0/0x1b0
 [<c016ddcb>] __fput+0xfb/0x100
 [<c016bcbc>] filp_close+0x15c/0x230
 [<c0125d1c>] put_files_struct+0x6c/0xe0
 [<c0127160>] do_exit+0x400/0xaa0
 [<c0127a3b>] do_group_exit+0x1cb/0x210
 [<c01302d5>] dequeue_signal+0x35/0xa0
 [<c013308e>] get_signal_to_deliver+0x40e/0x920
 [<c0140b89>] do_clock_nanosleep+0x219/0x390
 [<c010a08d>] do_signal+0xdd/0x110
 [<c0140700>] nanosleep_wake_up+0x0/0x10
 [<c0133901>] sys_rt_sigprocmask+0x91/0x2f0
 [<c014080c>] sys_nanosleep+0xdc/0x110
 [<c010a119>] do_notify_resume+0x59/0x5c
 [<c010a2f6>] work_notifysig+0x13/0x15

agetty        S 000000FF 4191410640   116      1           118   115 (NOTLB)
Call Trace:
 [<c026b094>] do_con_trol+0xd44/0xf00
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c026b54a>] do_con_write+0x2fa/0x720
 [<c025d4f1>] read_chan+0x2e1/0x1010
 [<c026bf09>] con_write+0x39/0x50
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c012e606>] update_wall_time+0x16/0x40
 [<c02563bd>] tty_read+0x24d/0x2d0
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c010cd75>] do_IRQ+0x235/0x370
 [<c016cc2e>] sys_read+0x3e/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

bash          S 00000004 2025136   118      1           119   116 (NOTLB)
Call Trace:
 [<c0268528>] set_cursor+0x78/0xa0
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c025a7c0>] opost_block+0xf0/0x1b0
 [<c0301ebb>] vgacon_cursor+0x18b/0x450
 [<c025d4f1>] read_chan+0x2e1/0x1010
 [<c0268528>] set_cursor+0x78/0xa0
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0134e06>] do_sigaction+0x3d6/0x730
 [<c02563bd>] tty_read+0x24d/0x2d0
 [<c025e220>] write_chan+0x0/0x240
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c016cc2e>] sys_read+0x3e/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

bash          D C012ECD0 1125648   119      1           120   118 (L-TLB)
Call Trace:
 [<c012ecd0>] do_timer+0xe0/0xf0
 [<c011286e>] timer_interrupt+0x19e/0x3f0
 [<c0147f60>] generic_file_aio_write_nolock+0x200/0xa50
 [<c01394a5>] flush_workqueue+0x305/0x450
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0257a44>] release_dev+0x6a4/0x860
 [<c01566ab>] zap_pmd_range+0x4b/0x70
 [<c0258204>] tty_release+0x94/0x1b0
 [<c016dd7c>] __fput+0xac/0x100
 [<c0258170>] tty_release+0x0/0x1b0
 [<c016ddcb>] __fput+0xfb/0x100
 [<c016bcbc>] filp_close+0x15c/0x230
 [<c0125d1c>] put_files_struct+0x6c/0xe0
 [<c0127160>] do_exit+0x400/0xaa0
 [<c0133901>] sys_rt_sigprocmask+0x91/0x2f0
 [<c0127a3b>] do_group_exit+0x1cb/0x210
 [<c01372e4>] sys_setpgid+0x54/0x1c0
 [<c010a2ab>] syscall_call+0x7/0xb

svscanboot    S 00000001 849732   120      1   122   19632   119 (NOTLB)
Call Trace:
 [<c0123080>] do_fork+0x110/0x1d0
 [<c01280c2>] sys_wait4+0x1e2/0x290
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c010a2ab>] syscall_call+0x7/0xb

svscan        S C73D7F48 4294545664   122    120   124     123       (NOTLB)
Call Trace:
 [<c0140b78>] do_clock_nanosleep+0x208/0x390
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0140700>] nanosleep_wake_up+0x0/0x10
 [<c0133901>] sys_rt_sigprocmask+0x91/0x2f0
 [<c01407aa>] sys_nanosleep+0x7a/0x110
 [<c010a2ab>] syscall_call+0x7/0xb

readproctitle S C73E4A18    80   123    120                 122 (NOTLB)
Call Trace:
 [<c01566ab>] zap_pmd_range+0x4b/0x70
 [<c017e24e>] pipe_wait+0x9e/0xe0
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c017e3fd>] pipe_read+0x16d/0x270
 [<c015bd6f>] unmap_vma_list+0x1f/0x30
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c010cd75>] do_IRQ+0x235/0x370
 [<c016cc2e>] sys_read+0x3e/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

supervise     S C7353EFC 4294565868   124    122   137     125       (NOTLB)
Call Trace:
 [<c012ee53>] schedule_timeout+0x93/0xf0
 [<c014a8ea>] __get_free_pages+0x1a/0x50
 [<c012edb0>] process_timeout+0x0/0x10
 [<c0186f9b>] do_poll+0xab/0xd0
 [<c0187120>] sys_poll+0x160/0x260
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c010a2ab>] syscall_call+0x7/0xb

supervise     S C7345EFC 4294510252   125    122   136     126   124 (NOTLB)
Call Trace:
 [<c012ee53>] schedule_timeout+0x93/0xf0
 [<c014a8ea>] __get_free_pages+0x1a/0x50
 [<c012edb0>] process_timeout+0x0/0x10
 [<c0186f9b>] do_poll+0xab/0xd0
 [<c0187120>] sys_poll+0x160/0x260
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c010a2ab>] syscall_call+0x7/0xb

supervise     S C733DEFC 4294478976   126    122   131     127   125 (NOTLB)
Call Trace:
 [<c012ee53>] schedule_timeout+0x93/0xf0
 [<c014a8ea>] __get_free_pages+0x1a/0x50
 [<c012edb0>] process_timeout+0x0/0x10
 [<c0186f9b>] do_poll+0xab/0xd0
 [<c0187120>] sys_poll+0x160/0x260
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c010a2ab>] syscall_call+0x7/0xb

supervise     S C732FEFC 4294423488   127    122   138     128   126 (NOTLB)
Call Trace:
 [<c012ee53>] schedule_timeout+0x93/0xf0
 [<c014a8ea>] __get_free_pages+0x1a/0x50
 [<c012edb0>] process_timeout+0x0/0x10
 [<c0186f9b>] do_poll+0xab/0xd0
 [<c0187120>] sys_poll+0x160/0x260
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c010a2ab>] syscall_call+0x7/0xb

supervise     S C7321EFC  6552   128    122   130     129   127 (NOTLB)
Call Trace:
 [<c012ee53>] schedule_timeout+0x93/0xf0
 [<c014a8ea>] __get_free_pages+0x1a/0x50
 [<c012edb0>] process_timeout+0x0/0x10
 [<c0186f9b>] do_poll+0xab/0xd0
 [<c0187120>] sys_poll+0x160/0x260
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c010a2ab>] syscall_call+0x7/0xb

supervise     S C7317EFC 4294934536   129    122   132           128 (NOTLB)
Call Trace:
 [<c012ee53>] schedule_timeout+0x93/0xf0
 [<c014a8ea>] __get_free_pages+0x1a/0x50
 [<c012edb0>] process_timeout+0x0/0x10
 [<c0186f9b>] do_poll+0xab/0xd0
 [<c0187120>] sys_poll+0x160/0x260
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c010a2ab>] syscall_call+0x7/0xb

tcpserver     S C7351A58 4294633008   130    128                     (NOTLB)
Call Trace:
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c012e796>] update_process_times+0x46/0x60
 [<c012e606>] update_wall_time+0x16/0x40
 [<c012ecd0>] do_timer+0xe0/0xf0
 [<c011286e>] timer_interrupt+0x19e/0x3f0
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c018588f>] kill_fasync+0x2f/0x50
 [<c017e729>] pipe_write+0x229/0x310
 [<c01336c4>] sigprocmask+0xf4/0x2a0
 [<c01280e6>] sys_wait4+0x206/0x290
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c010a2ab>] syscall_call+0x7/0xb

tcpserver     S C73513F8 4294577296   131    126                     (NOTLB)
Call Trace:
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c018588f>] kill_fasync+0x2f/0x50
 [<c017e729>] pipe_write+0x229/0x310
 [<c01336c4>] sigprocmask+0xf4/0x2a0
 [<c01280e6>] sys_wait4+0x206/0x290
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c010a2ab>] syscall_call+0x7/0xb

multilog      S 00000000 4294234592   132    129                     (NOTLB)
Call Trace:
 [<c016c9fb>] do_sync_write+0x8b/0xc0
 [<c017e24e>] pipe_wait+0x9e/0xe0
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c017e3fd>] pipe_read+0x16d/0x270
 [<c01336c4>] sigprocmask+0xf4/0x2a0
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c016cc2e>] sys_read+0x3e/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

multilog      S C7E7C864 4294713296   136    125                     (NOTLB)
Call Trace:
 [<c0108960>] __down_failed+0x8/0xc
 [<c01c41e8>] .text.lock.namei+0x19/0x41
 [<c017e24e>] pipe_wait+0x9e/0xe0
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c01be240>] ext3_setattr+0x210/0x310
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c017e3fd>] pipe_read+0x16d/0x270
 [<c01336c4>] sigprocmask+0xf4/0x2a0
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c016cc2e>] sys_read+0x3e/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

qmail-send    S C71A1EB4 4294313440   137    124   140               (NOTLB)
Call Trace:
 [<c0170c44>] __find_get_block+0x74/0xf0
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c012ee53>] schedule_timeout+0x93/0xf0
 [<c012edb0>] process_timeout+0x0/0x10
 [<c0186793>] do_select+0x123/0x250
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c0186c16>] sys_select+0x326/0x560
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c010a2ab>] syscall_call+0x7/0xb

multilog      S 00000000 4294628208   138    127                     (NOTLB)
Call Trace:
 [<c016c9fb>] do_sync_write+0x8b/0xc0
 [<c017e24e>] pipe_wait+0x9e/0xe0
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c017e3fd>] pipe_read+0x16d/0x270
 [<c01336c4>] sigprocmask+0xf4/0x2a0
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c016cc2e>] sys_read+0x3e/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

splogger      S 00000000 188872   140    137           141       (NOTLB)
Call Trace:
 [<c017e24e>] pipe_wait+0x9e/0xe0
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c017e3fd>] pipe_read+0x16d/0x270
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c016cc2e>] sys_read+0x3e/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

qmail-lspawn  S C0130228 14800   141    137           142   140 (NOTLB)
Call Trace:
 [<c0130228>] __dequeue_signal+0x108/0x180
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c014a8ea>] __get_free_pages+0x1a/0x50
 [<c01864f1>] __pollwait+0x41/0xd0
 [<c017e8c4>] pipe_poll+0x34/0x80
 [<c0186793>] do_select+0x123/0x250
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c0186c16>] sys_select+0x326/0x560
 [<c0133901>] sys_rt_sigprocmask+0x91/0x2f0
 [<c010a2ab>] syscall_call+0x7/0xb

qmail-rspawn  S C7243EB0 505956   142    137           143   141 (NOTLB)
Call Trace:
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c014a8ea>] __get_free_pages+0x1a/0x50
 [<c01864f1>] __pollwait+0x41/0xd0
 [<c017e8c4>] pipe_poll+0x34/0x80
 [<c0186793>] do_select+0x123/0x250
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c0186c16>] sys_select+0x326/0x560
 [<c0133901>] sys_rt_sigprocmask+0x91/0x2f0
 [<c010a2ab>] syscall_call+0x7/0xb

qmail-clean   S C71A1F08 4294625320   143    137                 142 (NOTLB)
Call Trace:
 [<c0120d17>] autoremove_wake_function+0x27/0x50
 [<c017e24e>] pipe_wait+0x9e/0xe0
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c017e729>] pipe_write+0x229/0x310
 [<c017e3fd>] pipe_read+0x16d/0x270
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c016cc2e>] sys_read+0x3e/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

bash          D 080F00CD 4192964224 19632      1         19660   120 (L-TLB)
Call Trace:
 [<c0147f60>] generic_file_aio_write_nolock+0x200/0xa50
 [<c01394a5>] flush_workqueue+0x305/0x450
 [<c010ac3a>] apic_timer_interrupt+0x1a/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0257a44>] release_dev+0x6a4/0x860
 [<c01566ab>] zap_pmd_range+0x4b/0x70
 [<c0258204>] tty_release+0x94/0x1b0
 [<c016dd7c>] __fput+0xac/0x100
 [<c0258170>] tty_release+0x0/0x1b0
 [<c016ddcb>] __fput+0xfb/0x100
 [<c016bcbc>] filp_close+0x15c/0x230
 [<c0125d1c>] put_files_struct+0x6c/0xe0
 [<c0127160>] do_exit+0x400/0xaa0
 [<c0133901>] sys_rt_sigprocmask+0x91/0x2f0
 [<c0127a3b>] do_group_exit+0x1cb/0x210
 [<c01372e4>] sys_setpgid+0x54/0x1c0
 [<c010a2ab>] syscall_call+0x7/0xb

httpd         S C51BDEB4 47646384 19660      1 19663    8211 19632 (NOTLB)
Call Trace:
 [<c012ee53>] schedule_timeout+0x93/0xf0
 [<c010ac3a>] apic_timer_interrupt+0x1a/0x20
 [<c012edb0>] process_timeout+0x0/0x10
 [<c0186793>] do_select+0x123/0x250
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c0186c16>] sys_select+0x326/0x560
 [<c010a2ab>] syscall_call+0x7/0xb

httpd         S 00000000 4201288560 19663  19660         19669       (NOTLB)
Call Trace:
 [<c01bb5ba>] ext3_commit_write+0x1ba/0x3d0
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c0146335>] unlock_page+0x15/0x60
 [<c01481e2>] generic_file_aio_write_nolock+0x482/0xa50
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0372a14>] tcp_recvmsg+0x674/0xee0
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c0373d46>] tcp_close+0x706/0xcc0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c0190c80>] destroy_inode+0x40/0x60
 [<c01b7e70>] ext3_release_file+0x0/0x70
 [<c018be80>] dput+0x30/0x660
 [<c016dd7c>] __fput+0xac/0x100
 [<c01b7e70>] ext3_release_file+0x0/0x70
 [<c01b7e70>] ext3_release_file+0x0/0x70
 [<c016dd88>] __fput+0xb8/0x100
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c016bdf2>] sys_close+0x62/0xa0
 [<c010a2ab>] syscall_call+0x7/0xb

httpd         S 00000000 4239923672 19669  19660         19670 19663 (NOTLB)
Call Trace:
 [<c029a0d0>] e100_xmit_frame+0x1a0/0x240
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c0146335>] unlock_page+0x15/0x60
 [<c035b586>] qdisc_restart+0x16/0x550
 [<c03522c9>] dev_queue_xmit+0x609/0x730
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0368a0f>] ip_output+0x10f/0x220
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c0373d46>] tcp_close+0x706/0xcc0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c0190c80>] destroy_inode+0x40/0x60
 [<c0193912>] iput+0x62/0x90
 [<c017e2f0>] pipe_read+0x60/0x270
 [<c016dd7c>] __fput+0xac/0x100
 [<c0349fa0>] sock_close+0x0/0x50
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c016cc37>] sys_read+0x47/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

httpd         S 00000000 4214874192 19670  19660          8595 19669 (NOTLB)
Call Trace:
 [<c029a0d0>] e100_xmit_frame+0x1a0/0x240
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c0146335>] unlock_page+0x15/0x60
 [<c035b586>] qdisc_restart+0x16/0x550
 [<c03522c9>] dev_queue_xmit+0x609/0x730
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0368a0f>] ip_output+0x10f/0x220
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c0373d46>] tcp_close+0x706/0xcc0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c0190c80>] destroy_inode+0x40/0x60
 [<c01b7e70>] ext3_release_file+0x0/0x70
 [<c018be80>] dput+0x30/0x660
 [<c016dd7c>] __fput+0xac/0x100
 [<c01b7e70>] ext3_release_file+0x0/0x70
 [<c01b7e70>] ext3_release_file+0x0/0x70
 [<c016dd88>] __fput+0xb8/0x100
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c016bdf2>] sys_close+0x62/0xa0
 [<c010a2ab>] syscall_call+0x7/0xb

agetty        D C7250D6C 4190447280  8211      1          8387 19660 (L-TLB)
Call Trace:
 [<c01394a5>] flush_workqueue+0x305/0x450
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0276566>] uart_close+0x56/0x330
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0257a44>] release_dev+0x6a4/0x860
 [<c01566ab>] zap_pmd_range+0x4b/0x70
 [<c0258204>] tty_release+0x94/0x1b0
 [<c016dd7c>] __fput+0xac/0x100
 [<c0258170>] tty_release+0x0/0x1b0
 [<c016ddcb>] __fput+0xfb/0x100
 [<c016bcbc>] filp_close+0x15c/0x230
 [<c0125d1c>] put_files_struct+0x6c/0xe0
 [<c0127160>] do_exit+0x400/0xaa0
 [<c025d537>] read_chan+0x327/0x1010
 [<c0127a3b>] do_group_exit+0x1cb/0x210
 [<c01302d5>] dequeue_signal+0x35/0xa0
 [<c013308e>] get_signal_to_deliver+0x40e/0x920
 [<c010a08d>] do_signal+0xdd/0x110
 [<c02563bd>] tty_read+0x24d/0x2d0
 [<c025e220>] write_chan+0x0/0x240
 [<c016c891>] vfs_read+0xe1/0x1c0
 [<c010a119>] do_notify_resume+0x59/0x5c
 [<c010a2f6>] work_notifysig+0x13/0x15

sshd          S C014A681 4217195792  8387      1          8524  8211 (NOTLB)
Call Trace:
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c014a8ea>] __get_free_pages+0x1a/0x50
 [<c01864f1>] __pollwait+0x41/0xd0
 [<c036ddb3>] tcp_poll+0x33/0x190
 [<c0349f49>] sock_poll+0x29/0x40
 [<c0186793>] do_select+0x123/0x250
 [<c01864b0>] __pollwait+0x0/0xd0
 [<c0186c16>] sys_select+0x326/0x560
 [<c0109128>] restore_sigcontext+0x128/0x140
 [<c010a2ab>] syscall_call+0x7/0xb

bash          D C04CDC68 4233453816  8524      1                8387 (L-TLB)
Call Trace:
 [<c010cd75>] do_IRQ+0x235/0x370
 [<c01394a5>] flush_workqueue+0x305/0x450
 [<c010ac18>] common_interrupt+0x18/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c011de30>] default_wake_function+0x0/0x20
 [<c0257a44>] release_dev+0x6a4/0x860
 [<c01566ab>] zap_pmd_range+0x4b/0x70
 [<c0258204>] tty_release+0x94/0x1b0
 [<c016dd7c>] __fput+0xac/0x100
 [<c0258170>] tty_release+0x0/0x1b0
 [<c016ddcb>] __fput+0xfb/0x100
 [<c016bcbc>] filp_close+0x15c/0x230
 [<c0125d1c>] put_files_struct+0x6c/0xe0
 [<c0127160>] do_exit+0x400/0xaa0
 [<c0130228>] __dequeue_signal+0x108/0x180
 [<c0127a3b>] do_group_exit+0x1cb/0x210
 [<c013032a>] dequeue_signal+0x8a/0xa0
 [<c013308e>] get_signal_to_deliver+0x40e/0x920
 [<c010a08d>] do_signal+0xdd/0x110
 [<c01356c3>] sys_rt_sigaction+0xe3/0x110
 [<c01092f6>] sys_sigreturn+0x1b6/0x2a0
 [<c010a119>] do_notify_resume+0x59/0x5c
 [<c010a2f6>] work_notifysig+0x13/0x15

httpd         S 00000000  1100  8595  19660          8597 19670 (NOTLB)
Call Trace:
 [<c029a0d0>] e100_xmit_frame+0x1a0/0x240
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c0146335>] unlock_page+0x15/0x60
 [<c035b586>] qdisc_restart+0x16/0x550
 [<c03522c9>] dev_queue_xmit+0x609/0x730
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0368a0f>] ip_output+0x10f/0x220
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c0373d46>] tcp_close+0x706/0xcc0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c0190c80>] destroy_inode+0x40/0x60
 [<c0193912>] iput+0x62/0x90
 [<c017e2f0>] pipe_read+0x60/0x270
 [<c016dd7c>] __fput+0xac/0x100
 [<c0349fa0>] sock_close+0x0/0x50
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c016cc37>] sys_read+0x47/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

httpd         S C041F8FC 10923632  8597  19660          8598  8595 (NOTLB)
Call Trace:
 [<c014a424>] buffered_rmqueue+0xc4/0x280
 [<c029a0d0>] e100_xmit_frame+0x1a0/0x240
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c014e3b4>] cache_init_objs+0x144/0x160
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c0373d46>] tcp_close+0x706/0xcc0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c0190c80>] destroy_inode+0x40/0x60
 [<c01b7e70>] ext3_release_file+0x0/0x70
 [<c018be80>] dput+0x30/0x660
 [<c016dd7c>] __fput+0xac/0x100
 [<c01b7e70>] ext3_release_file+0x0/0x70
 [<c01b7e70>] ext3_release_file+0x0/0x70
 [<c016dd88>] __fput+0xb8/0x100
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c016bdf2>] sys_close+0x62/0xa0
 [<c010a2ab>] syscall_call+0x7/0xb

httpd         S 00000000 4281504624  8598  19660          8601  8597 (NOTLB)
Call Trace:
 [<c029a0d0>] e100_xmit_frame+0x1a0/0x240
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c0146335>] unlock_page+0x15/0x60
 [<c035b586>] qdisc_restart+0x16/0x550
 [<c03522c9>] dev_queue_xmit+0x609/0x730
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0368a0f>] ip_output+0x10f/0x220
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c0373d46>] tcp_close+0x706/0xcc0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c0190c80>] destroy_inode+0x40/0x60
 [<c0193912>] iput+0x62/0x90
 [<c017e2f0>] pipe_read+0x60/0x270
 [<c016dd7c>] __fput+0xac/0x100
 [<c0349fa0>] sock_close+0x0/0x50
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c016cc37>] sys_read+0x47/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

httpd         S C041F8FC 4278766908  8601  19660          8602  8598 (NOTLB)
Call Trace:
 [<c014a424>] buffered_rmqueue+0xc4/0x280
 [<c029a0d0>] e100_xmit_frame+0x1a0/0x240
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c014e3b4>] cache_init_objs+0x144/0x160
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c0373d46>] tcp_close+0x706/0xcc0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c0190c80>] destroy_inode+0x40/0x60
 [<c0193912>] iput+0x62/0x90
 [<c017e2f0>] pipe_read+0x60/0x270
 [<c016dd7c>] __fput+0xac/0x100
 [<c0349fa0>] sock_close+0x0/0x50
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c016cc37>] sys_read+0x47/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

httpd         S 00000000 36396268  8602  19660          8621  8601 (NOTLB)
Call Trace:
 [<c035b586>] qdisc_restart+0x16/0x550
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c034df33>] kfree_skbmem+0x13/0x70
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0372a14>] tcp_recvmsg+0x674/0xee0
 [<c0368a0f>] ip_output+0x10f/0x220
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c0373d2c>] tcp_close+0x6ec/0xcc0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c0190c80>] destroy_inode+0x40/0x60
 [<c0193912>] iput+0x62/0x90
 [<c017e2f0>] pipe_read+0x60/0x270
 [<c016dd7c>] __fput+0xac/0x100
 [<c0349fa0>] sock_close+0x0/0x50
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c016cc37>] sys_read+0x47/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

httpd         S C041F8FC 4270070224  8621  19660          8622  8602 (NOTLB)
Call Trace:
 [<c014a424>] buffered_rmqueue+0xc4/0x280
 [<c029a0d0>] e100_xmit_frame+0x1a0/0x240
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c014a681>] __alloc_pages+0xa1/0x2f0
 [<c014e3b4>] cache_init_objs+0x144/0x160
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c0373d46>] tcp_close+0x706/0xcc0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c0190c80>] destroy_inode+0x40/0x60
 [<c0193912>] iput+0x62/0x90
 [<c017e2f0>] pipe_read+0x60/0x270
 [<c016dd7c>] __fput+0xac/0x100
 [<c0349fa0>] sock_close+0x0/0x50
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c016cc37>] sys_read+0x47/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

httpd         S 00000000 11785072  8622  19660                8621 (NOTLB)
Call Trace:
 [<c029a0d0>] e100_xmit_frame+0x1a0/0x240
 [<c012eea5>] schedule_timeout+0xe5/0xf0
 [<c0146335>] unlock_page+0x15/0x60
 [<c035b586>] qdisc_restart+0x16/0x550
 [<c03522c9>] dev_queue_xmit+0x609/0x730
 [<c0374a23>] wait_for_connect+0x383/0x450
 [<c0368a0f>] ip_output+0x10f/0x220
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0120cf0>] autoremove_wake_function+0x0/0x50
 [<c0348fb8>] sock_alloc_inode+0x18/0xc0
 [<c0374dc9>] tcp_accept+0x2d9/0x570
 [<c0190b90>] alloc_inode+0xd0/0x180
 [<c0397da5>] inet_accept+0x35/0x3d0
 [<c0373d46>] tcp_close+0x706/0xcc0
 [<c03492ac>] sockfd_lookup+0x1c/0x80
 [<c034aaf4>] sys_accept+0xa4/0x180
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c034907b>] sock_destroy_inode+0x1b/0x20
 [<c0190c80>] destroy_inode+0x40/0x60
 [<c0193912>] iput+0x62/0x90
 [<c017e2f0>] pipe_read+0x60/0x270
 [<c016dd7c>] __fput+0xac/0x100
 [<c0349fa0>] sock_close+0x0/0x50
 [<c034b88d>] sys_socketcall+0xed/0x2a0
 [<c016cc37>] sys_read+0x47/0x60
 [<c010a2ab>] syscall_call+0x7/0xb

-----Original Message-----
From: Andrew Morton [mailto:akpm@digeo.com] 
Sent: Sunday, April 06, 2003 4:38 PM
To: Shawn Starr
Cc: spstarr@sh0n.net; roland@topspin.com; rml@tech9.net;
linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.5.66bk9+] - changes to timers still broken - we don't
oops anymore

> What is "it"?

> I receive rather a lot of email and am dependent on people helping me
> out a bit with context.  I have lost the plot on this one.

> I don't know why Here's what strace reports:
> 
> Sshd is stuck in 'D' and a child in zombie state. The machine has been up
> for 2 days 18 hours 50 mins.

> a sysrq-T trace here would help.

