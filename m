Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278886AbRKAMst>; Thu, 1 Nov 2001 07:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278887AbRKAMsj>; Thu, 1 Nov 2001 07:48:39 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:52360 "HELO hazard.jcu.cz")
	by vger.kernel.org with SMTP id <S278886AbRKAMsY>;
	Thu, 1 Nov 2001 07:48:24 -0500
Date: Thu, 1 Nov 2001 13:47:42 +0100
From: Jan Marek <jmarek@jcu.cz>
To: linux-kernel@vger.kernel.org
Subject: Problem with yenta.c in 2.4.12
Message-ID: <20011101134742.V20754@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

I have problem with PCMCIA kernel package: when i modprobe-ing
yenta_socket.o, kernel freeze and I get no oops: simply nothing.
I can't use Magic-SysRQ: keyboard is freeze too...

Kernel:
2.4.12 (last working kernel was 2.4.10) with xfs support from CVS
sgi on i386 architecture, but when I get vanilla kernel, I got
the same behavior...

Compiler:
gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011006 (Debian prerelease)

HW: Compaq Armada M300, lspci:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
00:04.0 CardBus bridge: Texas Instruments PCI1211
00:05.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro (rev dc)
00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
00:09.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)

Cardbus bridge share IRQ 11 with VGA controller

I tried find, where is problem, then I added some lines to
yenta.c (yes, some are stupid, I know it ;-))):

--- cut of drivers/pcmcia/yenta.c
/*
 * Initialize the standard cardbus registers
 */
static void yenta_config_init(pci_socket_t *socket)
{
	u16 bridge;
	struct pci_dev *dev = socket->dev;

	printk("yenta_config_init:\n");
	pci_set_power_state(socket->dev, 0);
	printk("- after pci_set_power_state\n");

	config_writel(socket, CB_LEGACY_MODE_BASE, 0);
	printk("- after 1st config_writel\n");
	config_writel(socket, PCI_BASE_ADDRESS_0, dev->resource[0].start);
	printk("- after 2nd config_writel\n");
	config_writew(socket, PCI_COMMAND,
			PCI_COMMAND_IO |
			PCI_COMMAND_MEMORY |
			PCI_COMMAND_MASTER |
			PCI_COMMAND_WAIT);
	printk("- after config_writew\n");

	/* MAGIC NUMBERS! Fixme */
	config_writeb(socket, PCI_CACHE_LINE_SIZE, L1_CACHE_BYTES / 4);
	printk("- after 1st config_writeb\n");
	config_writeb(socket, PCI_LATENCY_TIMER, 168);
	printk("- after 2nd config_writeb\n");
	config_writel(socket, PCI_PRIMARY_BUS,
		(176 << 24) |			   /* sec. latency timer */
		(dev->subordinate->subordinate << 16) | /* subordinate bus */
		(dev->subordinate->secondary << 8) |  /* secondary bus */
		dev->subordinate->primary);		   /* primary bus */
	printk("- after config_writel\n");

	/*
	 * Set up the bridging state:
	 *  - enable write posting.
	 *  - memory window 0 prefetchable, window 1 non-prefetchable
	 *  - PCI interrupts enabled if a PCI interrupt exists..
	 */
	bridge = config_readw(socket, CB_BRIDGE_CONTROL);
	printk("- after bridge = config_readw\n");
	bridge &= ~(CB_BRIDGE_CRST | CB_BRIDGE_PREFETCH1 | CB_BRIDGE_INTR | CB_BRIDGE_ISAEN | CB_BRIDGE_VGAEN);
	printk("- after bridge &= ~(...\n");
	bridge |= CB_BRIDGE_PREFETCH0 | CB_BRIDGE_POSTEN;
	printk("- after bridge |= CB...\n");
	if (!socket->cb_irq)
		bridge |= CB_BRIDGE_INTR;
	printk("- after if...\n");
	config_writew(socket, CB_BRIDGE_CONTROL, bridge);
	printk("- after config_writew\n");

	exca_writeb(socket, I365_GBLCTL, 0x00);
	printk("- after 1st exca_writeb\n");
	exca_writeb(socket, I365_GENCTL, 0x00);
	printk("- after 2nd exca_writeb\n");

	/* Redo card voltage interrogation */
	cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST); 
	printk("- after last cb_writel\n");
}

/* Called at resume and initialization events */
static int yenta_init(pci_socket_t *socket)
{
	yenta_config_init(socket);
	printk("yenta_config_init OK!\n");
	yenta_clear_maps(socket);
	return 0;
}
--- end of part of drivers/pcmcia/yenta.c

but I got strange listing: the last message was:
- after last cb_writel
!!!

This is the repeatable behavior.

I mean, that in some function must be overwritten exit address of
function yenta_config_init()?

I'm sorry, but I'm not subscribed in l-k, can you send CC to me?
Thank you. I can send other information od demand ;-).

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
