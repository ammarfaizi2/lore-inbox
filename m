Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVFVV1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVFVV1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVFVV01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:26:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15120 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262152AbVFVVSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:18:45 -0400
Date: Wed, 22 Jun 2005 22:18:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pat Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix - add ioc3 serial driver support
Message-ID: <20050622221837.B26597@flint.arm.linux.org.uk>
Mail-Followup-To: Pat Gefre <pfg@sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200506222024.j5MKO5nD023262@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200506222024.j5MKO5nD023262@fsgi900.americas.sgi.com>; from pfg@sgi.com on Wed, Jun 22, 2005 at 03:24:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 03:24:05PM -0500, Pat Gefre wrote:
> 
> I have a patch : ftp://oss.sgi.com/projects/sn2/sn2-update/042-ioc3-support
> 
> This driver adds support for a 2 port PCI IOC3 serial card on Altix boxes.
> 
> Signed-off-by: Patrick Gefre <pfg@sgi.com>

Here's some initial comments:

+write_ireg(struct ioc3_mem __iomem *mem, struct ioc3_soft *ioc3_soft,
+				uint32_t val, int which)
...
+	if (!mem || !ioc3_soft)
+		return;

Can either of these really be null here?

+static inline int set_mcr(struct uart_port *the_port, int set,
+			  int mask1, int mask2)
...
+	/* Set new value */
+	if (set) {
+		mcr |= mask1;
+		shadow |= mask2;
+	} else {
+		mcr &= ~mask1;
+		shadow &= ~mask2;
+	}
...
+static void ic3_set_mctrl(struct uart_port *the_port, unsigned int mctrl)
+	unsigned char mcr = 0;
...
+	set_mcr(the_port, 1, mcr, IOC3_SHADOW_DTR);

How can RTS/DTR/OUT1/OUT2/LOOP be disabled if "set" is always passed as '1' ?

+static void
+ioc3_change_speed(struct uart_port *the_port,
+		  struct termios *new_termios, struct termios *old_termios)
...
+	struct uart_info *info = the_port->info;	**
...
+	if (cflag & CRTSCTS) {
+		info->flags |= ASYNC_CTS_FLOW;		**
+		/* enable hardware flow control */
+		port->ip_sscr |= IOC3_SSCR_HFC_EN;
+		writel(port->ip_sscr, &port->ip_serial_regs->sscr);
+	}
+	else {
+		info->flags &= ~ASYNC_CTS_FLOW;		**
+		/* disable hardware flow control */
+		port->ip_sscr &= ~IOC3_SSCR_HFC_EN;
+		writel(port->ip_sscr, &port->ip_serial_regs->sscr);
+	}

The serial core appropriately takes account of this when this structure
exists.  It may not always exist when your change_speed method is called,
so you have a potential oops situation there.

+	baud = uart_get_baud_rate(the_port, new_termios, old_termios,
+				  MIN_BAUD_SUPPORTED, MAX_BAUD_SUPPORTED);
...
+	/* default is 9600 */
+	if (!baud)
+		baud = 9600;

baud being zero should never happen - uart_get_baud_rate tries very
hard to ensure that it returns something sensible, unless 9600 baud
is not covered by the min...max range you gave it.

+static inline int ic3_startup_local(struct uart_port *the_port)
...
+	info = the_port->info;
+	if (info->flags & UIF_INITIALIZED) {
+		NOT_PROGRESS();
+		return retval;
+	}
...
+	ioc3_change_speed(the_port, info->tty->termios, (struct termios *)0);
+
+	info->flags |= UIF_INITIALIZED;

+static void ic3_shutdown(struct uart_port *the_port)
...
+	info = the_port->info;
+
+	if (!(info->flags & UIF_INITIALIZED))
+		return;
...
+	info->flags &= ~UIF_INITIALIZED;

Again, you should not do this.  You're accessing things which you
should not be accessing here.  Please explain why you're doing this.

+static unsigned int ic3_get_mctrl(struct uart_port *the_port)
...
+	if (shadow & IOC3_SHADOW_RTS)
+		ret |= TIOCM_RTS;

The serial core layer returns RTS as appropriate from the settings
it was asked to set.  You should not return the actual setting if
you're using automatic flow control, since that's technically an
API change.

+static int ic3_startup(struct uart_port *the_port)
...
+	if (port->ip_inuse) {
+		NOT_PROGRESS();
+		return -EBUSY;
+	}
...
+		port->ip_inuse = 1;

You're guaranteed to be called exactly once to startup a port, and
exactly once to shut it down before you'll be called to start it
up again.  You should not need to track "inuse"-ness.

+void ioc3_remove_one(struct pci_dev *pdev)

Should be static.

+	if (card_ptr->ic_serial) {
+		release_region((unsigned long)card_ptr->ic_serial,
+			sizeof(struct ioc3_serial));
+	}
+	if (card_ptr->ic_mem) {
+		release_region((unsigned long)card_ptr->ic_mem,
+			sizeof(struct ioc3_mem));
+	}

This seems to imply that ic_serial and ic_mem are IO port regions.
However...

+int __devinit
+ioc3_probe_one(struct pci_dev *pdev, const struct pci_device_id *pci_id)

Should also be static.

+	tmp_addr = pci_resource_start(pdev, 0);
+	if (!request_region(tmp_addr, sizeof(struct ioc3_mem), "sioc3_mem")) {

tmp_addr seems to be an IO port region, but...

+	mem = ioremap(tmp_addr, sizeof(struct ioc3_mem));

you ioremap it, so it must be a MMIO region.  But then...

+	card_ptr->ic_mem = mem;

and in ioc3_remove_one, you release_region this, which is completely
unrelated to that which you claimed.  Plus, I don't see an iounmap in
the remove_one function, so you're leaking memory.  Same goes for
ic_serial and associated code.

+	/* Init the IOC3 */
+	pci_read_config_dword(pdev, PCI_COMMAND, &tmp);
+	pci_write_config_dword(pdev, PCI_COMMAND,
+                               tmp | PCI_COMMAND_MEMORY |
+                               PCI_COMMAND_PARITY | PCI_COMMAND_SERR |
+                               IOC3_PCI_SCR_DROP_MODE_EN);

I think you need to talk to PCI folk about this.  They aren't keen on
drivers reading/writing directly the PCI command register.

+static int __devinit ioc3_detect(void)
...
+	if ((ret = uart_register_driver(&ioc3_uart)) < 0) {
...
+	}
+	return pci_register_driver(&ioc3_s_driver);

If pci_register_driver returns an error, we remove the module without
first unregistering the uart driver.  That's not good.

And one final question: how does ioc3 differ from ioc4?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
