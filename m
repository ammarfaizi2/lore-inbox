Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbRFAHsK>; Fri, 1 Jun 2001 03:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263399AbRFAHsA>; Fri, 1 Jun 2001 03:48:00 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:16794 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262997AbRFAHrr>;
	Fri, 1 Jun 2001 03:47:47 -0400
Message-ID: <3B17489B.354E899F@mandrakesoft.com>
Date: Fri, 01 Jun 2001 03:47:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
Cc: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for real 
 this time)
In-Reply-To: <3B1702AB.89C0790F@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

General comments:

* Code looks really clean.  Nice work.
* Use module_init/exit.  I know, I know, you heard it before :)
* I dunno if Linus will take it as-is because he has been threatening to
stop taking PCI drives that use old-style PCI init for no good reason. 
(he even made me change a driver that used old-style PCI init for a good
reason :))
* There is a ton of procfs stuff in there.  I suppose !CONFIG_PROC_FS is
not a supported configuration on Cobalt?  :)


Tim Hockin wrote:
> +/* this is essentially an exported function - it is in the hwif structs */
> +static int
> +ruler_busproc_fn(ide_hwif_t *hwif, int arg)
[...]
> +               read_lock(&ruler_lock);
[...]
> +               read_unlock(&ruler_lock);

Should this be read_lock_bh, since other uses are in a timer function or
_irqsave/restore?


> +               /* The GPIO tied to the ID chip is on the PMU */
> +               id_dev = pci_find_device(PCI_VENDOR_ID_AL,
> +                       PCI_DEVICE_ID_AL_M7101, NULL);

as mentioned earlier, pci_register_driver is preferred over "old style"
PCI.


> +               spin_lock_irqsave(&cobalt_superio_lock, flags);
> +               outb(SUPERIO_LOGICAL_DEV, SUPERIO_INDEX_PORT);
> +               outb(SUPERIO_DEV_GPIO, SUPERIO_DATA_PORT);
> +               outb(SUPERIO_ADDR_HIGH, SUPERIO_INDEX_PORT);
> +               addr = inb(SUPERIO_DATA_PORT) << 8;
> +               outb(SUPERIO_ADDR_LOW, SUPERIO_INDEX_PORT);
> +               addr |= inb(SUPERIO_DATA_PORT);
> +               spin_unlock_irqrestore(&cobalt_superio_lock, flags);

Nothing wrong here, just commenting that I wish other superio did this
sometimes in some cases... :)

> +static void __init
> +io_write_byte(unsigned char c)
> +{
> +       int i;
> +       unsigned long flags;
> +
> +       save_flags(flags);
> +
> +       for (i = 0; i < 8; i++, c >>= 1) {
> +               cli();
> +               if (c & 1) {
> +                       /* Transmit a 1 */
> +                       io_write(5);
> +                       udelay(80);
> +               } else {
> +                       /* Transmit a 0 */
> +                       io_write(80);
> +                       udelay(10);
> +               }
> +               restore_flags(flags);
> +       }
> +}

Can save/restore flags be replaced with a spinlock?


> +       /* get version from CVS */
> +       version = strchr("$Revision: 1.4 $", ':') + 2;
> +       if (version) {
> +               char *p;
> +
> +               strncpy(vstring, version, sizeof(vstring));
> +               if ((p = strchr(vstring, ' '))) {
> +                       *p = '\0';
> +               }
> +       } else {
> +               strncpy(vstring, "unknown", sizeof(vstring));
> +       }

ug :)  It would be nice if this could be done at compile time

> +       proc_serialnum = create_proc_read_entry("serialnumber", 0, NULL,
> +               serialnum_read, NULL);
> +       if (!proc_serialnum) {
> +               EPRINTK("can't create /proc/serialnumber\n");
> +       }
> +#endif
> +       proc_chostid = create_proc_read_entry("hostid", 0, proc_cobalt,
> +               hostid_read, NULL);
> +       if (!proc_chostid) {
> +               EPRINTK("can't create /proc/cobalt/hostid\n");
> +       }
> +       proc_cserialnum = create_proc_read_entry("serialnumber", 0,
> +               proc_cobalt, serialnum_read, NULL);
> +       if (!proc_cserialnum) {
> +               EPRINTK("can't create /proc/cobalt/serialnumber\n");

security concern?

We disable CPU processor serial numbers on x86, maybe you want to make
everything except the output of /usr/bin/hostid priveleged?


> diff -ruN dist-2.4.5/drivers/cobalt/wdt.c cobalt-2.4.5/drivers/cobalt/wdt.c
> --- dist-2.4.5/drivers/cobalt/wdt.c     Wed Dec 31 16:00:00 1969
> +++ cobalt-2.4.5/drivers/cobalt/wdt.c   Thu May 31 14:32:15 2001

Shouldn't this be stored with other watchdog timers?

> diff -ruN dist-2.4.5/include/linux/cobalt-acpi.h cobalt-2.4.5/include/linux/cobalt-acpi.h
> --- dist-2.4.5/include/linux/cobalt-acpi.h      Wed Dec 31 16:00:00 1969
> +++ cobalt-2.4.5/include/linux/cobalt-acpi.h    Thu May 31 14:33:16 2001

Another ACPI user... neat!



> +/* the root of /proc/cobalt */
> +extern struct proc_dir_entry *proc_cobalt;

I am wondering if some of this stuff can be a sysctl instead of
procfs???

> +
> +#endif
> diff -ruN dist-2.4.5/include/linux/cobalt-i2c.h cobalt-2.4.5/include/linux/cobalt-i2c.h
> --- dist-2.4.5/include/linux/cobalt-i2c.h       Wed Dec 31 16:00:00 1969
> +++ cobalt-2.4.5/include/linux/cobalt-i2c.h     Thu May 31 14:33:16 2001

Sometimes I wish for a directory structure with:
* arch-specific includes
* platform-specific includes
* generic core includes

Then we could put this stuff in include/cobalt/* or
platform/cobalt/include or somesuch.  


> +extern cobt_sys_t cobt_type;
> +/* one for each major board-type - COBT_SUPPORT_* from <linux/cobalt.h> */
> +#define cobt_is_raq3()  (COBT_SUPPORT_GEN_III && cobt_type == COBT_RAQ3)
> +#define cobt_is_qube3()         (COBT_SUPPORT_GEN_III && cobt_type == COBT_QUBE3)
> +#define cobt_is_raqxtr() (COBT_SUPPORT_GEN_V && cobt_type == COBT_RAQXTR)
> +/* one for each major generation */
> +#define cobt_is_3k()    (cobt_is_raq3() || cobt_is_qube3())
> +#define cobt_is_5k()    (cobt_is_raqxtr())

Is they look like functions, why not make them static inline?



>  static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
>  {
> +#if defined(CONFIG_COBALT_GEN_V)
> +       cobalt_nmi(reason, regs);
> +#else
>         printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
>         printk("You probably have a hardware problem with your RAM chips\n");
> +#endif
> 
> -       /* Clear and disable the memory parity error line. */
> -       reason = (reason & 0xf) | 4;
> -       outb(reason, 0x61);
> +       /* Clear and re-enable the memory parity error line. */
> +       reason &= 0xf;
> +       outb(reason | 4, 0x61);
> +       outb(reason & ~4, 0x61);
> +
>  }

Interesting.  I wonder if this positively affects anyone else.


-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
