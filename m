Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263406AbRFAIL0>; Fri, 1 Jun 2001 04:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263407AbRFAILR>; Fri, 1 Jun 2001 04:11:17 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:923 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S263406AbRFAILB>;
	Fri, 1 Jun 2001 04:11:01 -0400
Message-ID: <3B174E0F.77CA7448@mandrakesoft.com>
Date: Fri, 01 Jun 2001 04:10:55 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
Cc: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for real 
 this time)
In-Reply-To: <3B17025B.E5E23095@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> +int __init
> +cobalt_acpi_init(void)
> +{
> +       int err, reg;
> +       u16 addr;
> +       unsigned long flags;
> +
> +       if (cobt_is_5k()) {
> +               /* setup osb4 i/o regions */
> +               if ((reg = get_reg(OSB4_INDEX_PORT, OSB4_DATA_PORT, 0x20)))
> +                       request_region(reg, 4, "OSB4 (pm1a_evt_blk)");
> +               if ((reg = get_reg(OSB4_INDEX_PORT, OSB4_DATA_PORT, 0x22)))
> +                       request_region(reg, 2, "OSB4 (pm1a_cnt_blk)");
> +               if ((reg = get_reg(OSB4_INDEX_PORT, OSB4_DATA_PORT, 0x24)))
> +                       request_region(reg, 4, "OSB4 (pm_tmr_blk)");
> +               if ((reg = get_reg(OSB4_INDEX_PORT, OSB4_DATA_PORT, 0x26)))
> +                       request_region(reg, 6, "OSB4 (p_cnt_blk)");
> +               if ((reg = get_reg(OSB4_INDEX_PORT, OSB4_DATA_PORT, 0x28)))
> +                       request_region(reg, 8, "OSB4 (gpe0_blk)");
> +               osb4_port = reg;
> +
> +               spin_lock_irqsave(&cobalt_superio_lock, flags);
> +
> +               /* superi/o -- select pm logical device and get base address */
> +               outb(SUPERIO_LOGICAL_DEV, SUPERIO_INDEX_PORT);
> +               outb(SUPERIO_DEV_PM, SUPERIO_DATA_PORT);
> +               outb(SUPERIO_ADDR_HIGH, SUPERIO_INDEX_PORT);
> +               addr = inb(SUPERIO_DATA_PORT) << 8;
> +               outb(SUPERIO_ADDR_LOW, SUPERIO_INDEX_PORT);
> +               addr |= inb(SUPERIO_DATA_PORT);
> +               if (addr) {
> +                       /* get registers */
> +                       if ((reg = get_reg(addr, addr + 1, 0x08))) {
> +                               request_region(reg, 4, "SUPERIO (pm1_evt_blk)");
> +                               superio_port = reg;
> +                       }
> +                       if ((reg = get_reg(addr, addr + 1, 0x0c)))
> +                               request_region(reg, 2, "SUPERIO (pm1_cnt_blk)");
> +                       if ((reg = get_reg(addr, addr + 1, 0x0e)))
> +                               request_region(reg, 16, "SUPERIO (gpe_blk)");

need to check for request_region failure.  since you have a lot of
request_region calls, you may want to consider breaking them out into a
separate function which returns success or failure, and handles details
of cleaning up after 4 request_regions succeed but the 5th one fails.

	if (!request_region(region1))
		goto out;
	if (!request_region(region2))
		goto cleanup_1;
	if (!request_region(region3))
		goto cleanup_2;
	return 0;

cleanup_2:
	release_region(region2);
cleanup_1:
	release_region(region1);
out:
	return -EBUSY;

> +               /* setup an interrupt handler for an ACPI SCI */
> +               err = request_irq(ACPI_IRQ, acpi_interrupt,
> +                         SA_SHIRQ, ACPI_NAME, (void *)ACPI_MAGIC);
> +               if (err) {
> +                       EPRINTK("couldn't assign ACPI IRQ (%d)\n", ACPI_IRQ);
> +                       return -1;
> +               }

return 'err' not -1 here?

> +bool 'Support for Cobalt Networks x86 servers' CONFIG_COBALT
> +
> +if [ "$CONFIG_COBALT" != "n" ]; then
> +   bool 'Gen III (3000 series) system support' CONFIG_COBALT_GEN_III
> +   bool 'Gen V (5000 series) system support' CONFIG_COBALT_GEN_V
> +   bool 'Create legacy /proc files' CONFIG_COBALT_OLDPROC
> +
> +   comment 'Cobalt hardware options'
> +
> +   bool 'Front panel (LCD) support' CONFIG_COBALT_LCD
> +   bool 'Software controlled LED support' CONFIG_COBALT_LED
> +   bool 'Serial number support' CONFIG_COBALT_SERNUM
> +   bool 'Watchdog timer support' CONFIG_COBALT_WDT
> +   bool 'Thermal sensor support' CONFIG_COBALT_THERMAL
> +   bool 'Fan tachometer support' CONFIG_COBALT_FANS
> +   bool 'Disk drive ruler support' CONFIG_COBALT_RULER
> +fi

Style:  s/bool '/bool '  /


> +#ifdef CONFIG_PROC_FS
> +#ifdef CONFIG_COBALT_OLDPROC
> +       proc_faninfo = create_proc_read_entry("faninfo", S_IFREG | S_IRUGO,
> +               NULL, fan_read_proc, NULL);
> +        if (!proc_faninfo) {
> +               EPRINTK("can't create /proc/faninfo\n");
> +       }
> +#endif
> +       proc_cfaninfo = create_proc_read_entry("faninfo", S_IFREG | S_IRUGO,
> +               proc_cobalt, fan_read_proc, NULL);
> +        if (!proc_cfaninfo) {
> +               EPRINTK("can't create /proc/cobalt/faninfo\n");
> +       }
> +#endif
> +
> +       printk("Cobalt Networks fan tachometers v1.2\n");
> +
> +       return 0;
> +}

S_IFREG|S_IRUGO is the default, so simply pass zero mode for this
behavior.

But, each time a user cats this proc file, the user is banging the
hardware.  What happens when a malicious user forks off 100 processes to
continually cat this file?  :)

> +/* various file operations we support for this driver */
> +static struct file_operations lcd_fops = {
> +       read:   cobalt_lcd_read,
> +       ioctl:  cobalt_lcd_ioctl,
> +       open:   cobalt_lcd_open,
> +};

Needs owner field assigned a value.

> +static int
> +cobalt_lcd_ioctl(struct inode *inode, struct file *file,
> +                           unsigned int cmd, unsigned long arg)
> +{
> +       struct lcd_display button_display, display;
> +       unsigned long address, a;
> +       int index;
> +       int dlen = sizeof(struct lcd_display);
> +
> +       spin_lock(&lcd_lock);
> +
> +       switch (cmd) {
> +       /* Turn the LCD on */
> +       case LCD_On:
> +               lcddev_write_inst(0x0F);
> +               break;

Security: don't you want CAP_RAW_IO or something before executing any of
these ioctls?

> +       /* Read what's on the LCD */
> +        case LCD_Read:
> +                for (address = DD_R00; address <= DD_R01; address++) {
> +                        lcddev_write_inst(address | LCD_Addr);
> +                        display.line1[address] = lcddev_read_data();
> +                }
> +                display.line1[DD_R01] = '\0';
> +
> +                for (address = DD_R10; address <= DD_R11; address++) {
> +                        lcddev_write_inst(address | LCD_Addr);
> +                        display.line2[address - DD_R10] = lcddev_read_data();
> +               }
> +                display.line2[DD_R01] = '\0';
> +
> +                copy_to_user((struct lcd_display *)arg, &display, dlen);

unchecked copy_to_user.  should be:

	if (copy_to_user(...))
		return -EFAULT;

> +       case LCD_Raw_Inst:
> +                copy_from_user(&display, (struct lcd_display *)arg, dlen);
> +                lcddev_write_inst(display.character);
> +                break;
> +
> +        case LCD_Raw_Data:
> +                copy_from_user(&display, (struct lcd_display *)arg, dlen);

ditto.  other unchecked copy_from_user and put_user cases snipped.



> +       /* clear an led */
> +       case LED_Bit_Clear:
> +                copy_from_user(&display, (struct lcd_display *)arg, dlen);
> +                cobalt_led_set_lazy(cobalt_led_get() & ~display.leds);
> +               break;
> +
> +       default:
> +       }
> +
> +       spin_unlock(&lcd_lock);

bug: you can't hold a spinlock while you are sleeping in copy_from_user

> +/* LED daemon sits on this, we wake it up once a key is pressed */
> +static ssize_t
> +cobalt_lcd_read(struct file *file, char *buf, size_t count, loff_t *ppos)
> +{
> +       int buttons_now;
> +       static atomic_t lcd_waiters = ATOMIC_INIT(0);
> +
> +       if (atomic_read(&lcd_waiters) > 0)
> +               return -EINVAL;
> +       atomic_inc(&lcd_waiters);
> +
> +       while (((buttons_now = button_pressed()) == 0) &&
> +              !(signal_pending(current)))
> +       {
> +               current->state = TASK_INTERRUPTIBLE;
> +               schedule_timeout((2 * HZ));
> +       }
> +       atomic_dec(&lcd_waiters);
> +
> +       if (signal_pending(current))
> +               return -ERESTARTSYS;
> +
> +       return buttons_now;

why not use a semaphore here?
also, you do not have O_NONBLOCK.

> +int
> +cobalt_fpled_register(unsigned int (*function)(void *), void *data)
> +{
> +       int r = -1;
> +
> +       if (cobt_is_5k()) {
> +               struct led_handler *newh;
> +               unsigned long flags;
> +
> +               newh = kmalloc(sizeof(*newh), GFP_ATOMIC);
> +               if (!newh) {
> +                       EPRINTK("can't allocate memory for handler %p(%p)\n",
> +                               function, data);
> +                       return -1;
> +               }

maybe I am misunderstanding the context in which this code is called. 
why not GFP_KERNEL?

> +#define MAX_COBT_NETDEVS       2
> +static struct net_device *netdevs[MAX_COBT_NETDEVS];
> +static int n_netdevs;
> +static spinlock_t cobaltnet_lock = SPIN_LOCK_UNLOCKED;
> +
> +#if defined(CONFIG_COBALT_LED)
> +static unsigned int
> +net_led_handler(void *data)
> +{
> +       int i;
> +       unsigned int leds = 0;
> +       static int txrxmap[MAX_COBT_NETDEVS] = {LED_ETH0_TXRX, LED_ETH1_TXRX};
> +       static int linkmap[MAX_COBT_NETDEVS] = {LED_ETH0_LINK, LED_ETH1_LINK};
> +       unsigned long flags;
> +       static unsigned long net_old[MAX_COBT_NETDEVS];
> +
> +       spin_lock_irqsave(&cobaltnet_lock, flags);
> +
> +       for (i = 0; i < n_netdevs; i++) {
> +               unsigned long txrxstate;
> +               struct net_device *dev = netdevs[i];
> +               if (!dev) {
> +                       continue;
> +               }
> +               /* check for link */
> +               if (dev->link_check && dev->link_check(dev)) {

Obviously dev->link_check is a new and nonstandard addition.

You should use:  netif_carrier_{on,off,ok}


> +void
> +cobalt_net_register(struct net_device *ndev)
> +{
> +       unsigned long flags;
> +       int i;
> +
> +        if (!ndev) {
> +              return;
> +       }
> +
> +       /* we'll track the first MAX_COBT_NETDEVS NICs */
> +       if (n_netdevs >= MAX_COBT_NETDEVS) {
> +              return;
> +       }
> +
> +       spin_lock_irqsave(&cobaltnet_lock, flags);
> +
> +       /* find a free slot */
> +       for (i = 0; i < n_netdevs; i++) {
> +               if (!netdevs[i]) {
> +                       netdevs[i] = ndev;
> +                       n_netdevs++;
> +               }
> +       }
> +
> +       spin_unlock_irqrestore(&cobaltnet_lock, flags);
> +}

Are you sure this is needed?

Each Cobalt NIC should store its struct net_device instance in struct
pci_dev::private_data, using pci_{get,set}_drvdata wrapper.

So, the system already store a list of Cobalt net devices for you.  Just
search the pci_drivers list for all members whose pci_dev::driver value
== &cobalt_net_pci_driver.

This of course assumes all the net devices are PCI, and that the net
device uses current (a.k.a. "new style") PCI driver init.

It is heavily encouraged to convert your PCI drivers to struct
pci_driver, because in 2.5 this will become a more generic struct
driver, and struct pci_dev will become a more generic struct device, to
be used by all kernel drivers.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
