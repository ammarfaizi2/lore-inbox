Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270627AbTGNOir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270631AbTGNOiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:38:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64785 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270627AbTGNOgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:36:09 -0400
Date: Mon, 14 Jul 2003 15:50:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       John Belmonte <jvb@prairienet.org>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Message-ID: <20030714155051.A31395@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Frank <mflt1@micrologica.com.hk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@suse.cz>, John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <200307141725.27304.mflt1@micrologica.com.hk> <20030714120134.A18177@flint.arm.linux.org.uk> <200307141937.29584.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307141937.29584.mflt1@micrologica.com.hk>; from mflt1@micrologica.com.hk on Mon, Jul 14, 2003 at 07:37:29PM +0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 07:37:29PM +0800, Michael Frank wrote:
> On Monday 14 July 2003 19:01, Russell King wrote:
> > On Mon, Jul 14, 2003 at 05:28:24PM +0800, Michael Frank wrote:
> > > Very funny - suspend/resume is not implemented ;)
> >
> > It hasn't been implemented properly for a long long time.
> >
> > I think I have all the bits necessary, but need testers willing to
> > try stuff out.  I'll produce a patch in the next couple of days.
> 
> Thank you, I look forward to testing it.

Ok, this is a rudimentary insertion of the pci_save_state/pci_restore_state
calls into yenta_socket.c.  This should result in the first 64 bytes
of config space being saved and restored over suspend/resume cycles.

diff -u /net/flint/usrc/linux-bk-2.5/linux-2.5-pcmcia/drivers/pcmcia/yenta_socket.c linux/drivers/pcmcia/yenta_socket.c
--- /net/flint/usrc/linux-bk-2.5/linux-2.5-pcmcia/drivers/pcmcia/yenta_socket.c	Sun Mar 23 11:57:21 2003
+++ linux/drivers/pcmcia/yenta_socket.c	Fri Mar 28 23:17:12 2003
@@ -534,8 +534,6 @@
 	u16 bridge;
 	struct pci_dev *dev = socket->dev;
 
-	pci_set_power_state(socket->dev, 0);
-
 	config_writel(socket, CB_LEGACY_MODE_BASE, 0);
 	config_writel(socket, PCI_BASE_ADDRESS_0, dev->resource[0].start);
 	config_writew(socket, PCI_COMMAND,
@@ -577,6 +575,10 @@
 static int yenta_init(struct pcmcia_socket *sock)
 {
 	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+
+	pci_set_power_state(socket->dev, 0);
+	pci_restore_state(socket->dev, socket->saved_state);
+
 	yenta_config_init(socket);
 	yenta_clear_maps(socket);
 
@@ -594,6 +596,8 @@
 	/* Disable interrupts */
 	cb_writel(socket, CB_SOCKET_MASK, 0x0);
 
+	pci_save_state(socket->dev, socket->saved_state);
+
 	/*
 	 * This does not work currently. The controller
 	 * loses too much information during D3 to come up
@@ -635,7 +639,7 @@
 	if (type & IORESOURCE_IO)
 		mask = ~3;
 
-	offset = 0x1c + 8*nr;
+	offset = PCI_CB_MEMORY_BASE_0 + 8*nr;
 	bus = socket->dev->subordinate;
 	res = socket->dev->resource + PCI_BRIDGE_RESOURCES + nr;
 	res->name = bus->name;
@@ -862,6 +866,8 @@
 
 	/* Set up the bridge regions.. */
 	yenta_allocate_resources(socket);
+
+	pci_save_state(dev, socket->saved_state);
 
 	socket->cb_irq = dev->irq;
 
diff -u /net/flint/usrc/linux-bk-2.5/linux-2.5-pcmcia/drivers/pcmcia/yenta_socket.h linux/drivers/pcmcia/yenta_socket.h
--- /net/flint/usrc/linux-bk-2.5/linux-2.5-pcmcia/drivers/pcmcia/yenta_socket.h	Sun Mar 23 11:57:20 2003
+++ linux/drivers/pcmcia/yenta_socket.h	Fri Mar 28 23:13:33 2003
@@ -105,6 +105,9 @@
 
 	/* A few words of private data for special stuff of overrides... */
 	unsigned int private[8];
+
+	/* PCI saved state - 64 bytes */
+	u32 saved_state[16];
 };
 
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

