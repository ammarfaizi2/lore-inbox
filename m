Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVBKHQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVBKHQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVBKHQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:16:53 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:45918 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262209AbVBKHFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:05:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [PATCH 5/10] Gameport: convert input/gameport to dynamic allocation
Date: Fri, 11 Feb 2005 02:02:17 -0500
User-Agent: KMail/1.7.2
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200502110158.47872.dtor_core@ameritech.net> <200502110201.00916.dtor_core@ameritech.net> <200502110201.31239.dtor_core@ameritech.net>
In-Reply-To: <200502110201.31239.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110202.18242.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.2153, 2005-02-11 01:19:36-05:00, dtor_core@ameritech.net
  Input: convert input/gameport to dynamic gameport allocation.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/gameport/cs461x.c     |   29 +----
 drivers/input/gameport/emu10k1-gp.c |   40 ++++----
 drivers/input/gameport/fm801-gp.c   |   57 +++++------
 drivers/input/gameport/lightning.c  |  176 ++++++++++++++++++++++--------------
 drivers/input/gameport/ns558.c      |  120 +++++++++++-------------
 drivers/input/gameport/vortex.c     |   68 ++++++-------
 drivers/input/joystick/a3d.c        |   59 +++++-------
 include/linux/gameport.h            |    3 
 8 files changed, 286 insertions(+), 266 deletions(-)


===================================================================



diff -Nru a/drivers/input/gameport/cs461x.c b/drivers/input/gameport/cs461x.c
--- a/drivers/input/gameport/cs461x.c	2005-02-11 01:38:07 -05:00
+++ b/drivers/input/gameport/cs461x.c	2005-02-11 01:38:07 -05:00
@@ -120,9 +120,6 @@
 static unsigned long ba0_addr;
 static unsigned int __iomem *ba0;
 
-static char phys[32];
-static char name[] = "CS416x Gameport";
-
 #ifdef CS461X_FULL_MAP
 static unsigned long ba1_addr;
 static union ba1_t {
@@ -160,10 +157,10 @@
 static int cs461x_free(struct pci_dev *pdev)
 {
 	struct gameport *port = pci_get_drvdata(pdev);
-	if(port){
+
+	if (port)
 	    gameport_unregister_port(port);
-	    kfree(port);
-	}
+
 	if (ba0) iounmap(ba0);
 #ifdef CS461X_FULL_MAP
 	if (ba1.name.data0) iounmap(ba1.name.data0);
@@ -267,18 +264,17 @@
                 return -ENOMEM;
         }
 #else
-	if (ba0 == NULL){
+	if (ba0 == NULL) {
 		cs461x_free(pdev);
 		return -ENOMEM;
 	}
 #endif
 
-	if (!(port = kmalloc(sizeof(struct gameport), GFP_KERNEL))) {
-		printk(KERN_ERR "Memory allocation failed.\n");
+	if (!(port = gameport_allocate_port())) {
+		printk(KERN_ERR "cs461x: Memory allocation failed\n");
 		cs461x_free(pdev);
 		return -ENOMEM;
 	}
-	memset(port, 0, sizeof(struct gameport));
 
 	pci_set_drvdata(pdev, port);
 
@@ -287,21 +283,14 @@
 	port->read = cs461x_gameport_read;
 	port->cooked_read = cs461x_gameport_cooked_read;
 
-	sprintf(phys, "pci%s/gameport0", pci_name(pdev));
-
-	port->name = name;
-	port->phys = phys;
-	port->id.bustype = BUS_PCI;
-	port->id.vendor = pdev->vendor;
-	port->id.product = pdev->device;
+	gameport_set_name(port, "CS416x");
+	gameport_set_phys(port, "pci%s/gameport0", pci_name(pdev));
+	port->dev.parent = &pdev->dev;
 
 	cs461x_pokeBA0(BA0_JSIO, 0xFF); // ?
 	cs461x_pokeBA0(BA0_JSCTL, JSCTL_SP_MEDIUM_SLOW);
 
 	gameport_register_port(port);
-
-	printk(KERN_INFO "gameport: %s on pci%s speed %d kHz\n",
-		name, pci_name(pdev), port->speed);
 
 	return 0;
 }
diff -Nru a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
--- a/drivers/input/gameport/emu10k1-gp.c	2005-02-11 01:38:07 -05:00
+++ b/drivers/input/gameport/emu10k1-gp.c	2005-02-11 01:38:07 -05:00
@@ -44,13 +44,13 @@
 
 struct emu {
 	struct pci_dev *dev;
-	struct gameport gameport;
+	struct gameport *gameport;
+	int io;
 	int size;
-	char phys[32];
 };
 
 static struct pci_device_id emu_tbl[] = {
- 
+
 	{ 0x1102, 0x7002, PCI_ANY_ID, PCI_ANY_ID }, /* SB Live gameport */
 	{ 0x1102, 0x7003, PCI_ANY_ID, PCI_ANY_ID }, /* Audigy gameport */
 	{ 0x1102, 0x7004, PCI_ANY_ID, PCI_ANY_ID }, /* Dell SB Live */
@@ -64,6 +64,7 @@
 {
 	int ioport, iolen;
 	struct emu *emu;
+	struct gameport *port;
 
 	if (pci_enable_device(pdev))
 		return -EBUSY;
@@ -74,31 +75,29 @@
 	if (!request_region(ioport, iolen, "emu10k1-gp"))
 		return -EBUSY;
 
-	if (!(emu = kmalloc(sizeof(struct emu), GFP_KERNEL))) {
-		printk(KERN_ERR "emu10k1-gp: Memory allocation failed.\n");
+	emu = kcalloc(1, sizeof(struct emu), GFP_KERNEL);
+	port = gameport_allocate_port();
+	if (!emu || !port) {
+		printk(KERN_ERR "emu10k1-gp: Memory allocation failed\n");
 		release_region(ioport, iolen);
+		kfree(emu);
+		gameport_free_port(port);
 		return -ENOMEM;
 	}
-	memset(emu, 0, sizeof(struct emu));
-
-	sprintf(emu->phys, "pci%s/gameport0", pci_name(pdev));
 
+	emu->io = ioport;
 	emu->size = iolen;
 	emu->dev = pdev;
+	emu->gameport = port;
 
-	emu->gameport.io = ioport;
-	emu->gameport.name = pci_name(pdev);
-	emu->gameport.phys = emu->phys;
-	emu->gameport.id.bustype = BUS_PCI;
-	emu->gameport.id.vendor = pdev->vendor;
-	emu->gameport.id.product = pdev->device;
+	gameport_set_name(port, "EMU10K1");
+	gameport_set_phys(port, "pci%s/gameport0", pci_name(pdev));
+	port->dev.parent = &pdev->dev;
+	port->io = ioport;
 
 	pci_set_drvdata(pdev, emu);
 
-	gameport_register_port(&emu->gameport);
-
-	printk(KERN_INFO "gameport: pci%s speed %d kHz\n",
-		pci_name(pdev), emu->gameport.speed);
+	gameport_register_port(port);
 
 	return 0;
 }
@@ -106,8 +105,9 @@
 static void __devexit emu_remove(struct pci_dev *pdev)
 {
 	struct emu *emu = pci_get_drvdata(pdev);
-	gameport_unregister_port(&emu->gameport);
-	release_region(emu->gameport.io, emu->size);
+
+	gameport_unregister_port(emu->gameport);
+	release_region(emu->io, emu->size);
 	kfree(emu);
 }
 
diff -Nru a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
--- a/drivers/input/gameport/fm801-gp.c	2005-02-11 01:38:07 -05:00
+++ b/drivers/input/gameport/fm801-gp.c	2005-02-11 01:38:07 -05:00
@@ -37,10 +37,8 @@
 #define HAVE_COOKED
 
 struct fm801_gp {
-	struct gameport gameport;
+	struct gameport *gameport;
 	struct resource *res_port;
-	char phys[32];
-	char name[32];
 };
 
 #ifdef HAVE_COOKED
@@ -83,40 +81,42 @@
 static int __devinit fm801_gp_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	struct fm801_gp *gp;
+	struct gameport *port;
 
-	if (! (gp = kmalloc(sizeof(*gp), GFP_KERNEL))) {
-		printk("cannot malloc for fm801-gp\n");
-		return -1;
+	gp = kcalloc(1, sizeof(struct fm801_gp), GFP_KERNEL);
+	port = gameport_allocate_port();
+	if (!gp || !port) {
+		printk(KERN_ERR "fm801-gp: Memory allocation failed\n");
+		kfree(gp);
+		gameport_free_port(port);
+		return -ENOMEM;
 	}
-	memset(gp, 0, sizeof(*gp));
 
-	gp->gameport.open = fm801_gp_open;
+	pci_enable_device(pci);
+
+	port->open = fm801_gp_open;
 #ifdef HAVE_COOKED
-	gp->gameport.cooked_read = fm801_gp_cooked_read;
+	port->cooked_read = fm801_gp_cooked_read;
 #endif
-
-	pci_enable_device(pci);
-	gp->gameport.io = pci_resource_start(pci, 0);
-	if ((gp->res_port = request_region(gp->gameport.io, 0x10, "FM801 GP")) == NULL) {
-		printk("unable to grab region 0x%x-0x%x\n", gp->gameport.io, gp->gameport.io + 0x0f);
+	gameport_set_name(port, "FM801");
+	gameport_set_phys(port, "pci%s/gameport0", pci_name(pci));
+	port->dev.parent = &pci->dev;
+	port->io = pci_resource_start(pci, 0);
+
+	gp->gameport = port;
+	gp->res_port = request_region(port->io, 0x10, "FM801 GP");
+	if (!gp->res_port) {
 		kfree(gp);
-		return -1;
+		gameport_free_port(port);
+		printk(KERN_DEBUG "fm801-gp: unable to grab region 0x%x-0x%x\n",
+			port->io, port->io + 0x0f);
+		return -EBUSY;
 	}
 
-	gp->gameport.phys = gp->phys;
-	gp->gameport.name = gp->name;
-	gp->gameport.id.bustype = BUS_PCI;
-	gp->gameport.id.vendor = pci->vendor;
-	gp->gameport.id.product = pci->device;
-
 	pci_set_drvdata(pci, gp);
 
-	outb(0x60, gp->gameport.io + 0x0d); /* enable joystick 1 and 2 */
-
-	gameport_register_port(&gp->gameport);
-
-	printk(KERN_INFO "gameport: at pci%s speed %d kHz\n",
-		pci_name(pci), gp->gameport.speed);
+	outb(0x60, port->io + 0x0d); /* enable joystick 1 and 2 */
+	gameport_register_port(port);
 
 	return 0;
 }
@@ -124,8 +124,9 @@
 static void __devexit fm801_gp_remove(struct pci_dev *pci)
 {
 	struct fm801_gp *gp = pci_get_drvdata(pci);
+
 	if (gp) {
-		gameport_unregister_port(&gp->gameport);
+		gameport_unregister_port(gp->gameport);
 		release_resource(gp->res_port);
 		kfree(gp);
 	}
diff -Nru a/drivers/input/gameport/lightning.c b/drivers/input/gameport/lightning.c
--- a/drivers/input/gameport/lightning.c	2005-02-11 01:38:07 -05:00
+++ b/drivers/input/gameport/lightning.c	2005-02-11 01:38:07 -05:00
@@ -53,13 +53,12 @@
 MODULE_DESCRIPTION("PDPI Lightning 4 gamecard driver");
 MODULE_LICENSE("GPL");
 
-static struct l4 {
-	struct gameport gameport;
+struct l4 {
+	struct gameport *gameport;
 	unsigned char port;
-	char phys[32];
-} *l4_port[8];
+};
 
-static char l4_name[] = "PDPI Lightning 4";
+static struct l4 l4_ports[8];
 
 /*
  * l4_wait_ready() waits for the L4 to become ready.
@@ -67,10 +66,10 @@
 
 static int l4_wait_ready(void)
 {
-	unsigned int t;
-	t = L4_TIMEOUT;
+	unsigned int t = L4_TIMEOUT;
+
 	while ((inb(L4_PORT) & L4_BUSY) && t > 0) t--;
-	return -(t<=0);
+	return -(t <= 0);
 }
 
 /*
@@ -113,6 +112,7 @@
 static int l4_open(struct gameport *gameport, int mode)
 {
 	struct l4 *l4 = gameport->port_data;
+
         if (l4->port != 0 && mode != GAMEPORT_MODE_COOKED)
 		return -1;
 	outb(L4_SELECT_ANALOG, L4_PORT);
@@ -129,24 +129,29 @@
 
 	outb(L4_SELECT_ANALOG, L4_PORT);
 	outb(L4_SELECT_DIGITAL + (port >> 2), L4_PORT);
+	if (inb(L4_PORT) & L4_BUSY)
+		goto out;
 
-	if (inb(L4_PORT) & L4_BUSY) goto fail;
 	outb(L4_CMD_GETCAL, L4_PORT);
+	if (l4_wait_ready())
+		goto out;
 
-	if (l4_wait_ready()) goto fail;
-	if (inb(L4_PORT) != L4_SELECT_DIGITAL + (port >> 2)) goto fail;
+	if (inb(L4_PORT) != L4_SELECT_DIGITAL + (port >> 2))
+		goto out;
 
-	if (l4_wait_ready()) goto fail;
+	if (l4_wait_ready())
+		goto out;
         outb(port & 3, L4_PORT);
 
 	for (i = 0; i < 4; i++) {
-		if (l4_wait_ready()) goto fail;
+		if (l4_wait_ready())
+			goto out;
 		cal[i] = inb(L4_PORT);
 	}
 
 	result = 0;
 
-fail:	outb(L4_SELECT_ANALOG, L4_PORT);
+out:	outb(L4_SELECT_ANALOG, L4_PORT);
 	return result;
 }
 
@@ -160,24 +165,29 @@
 
 	outb(L4_SELECT_ANALOG, L4_PORT);
 	outb(L4_SELECT_DIGITAL + (port >> 2), L4_PORT);
+	if (inb(L4_PORT) & L4_BUSY)
+		goto out;
 
-	if (inb(L4_PORT) & L4_BUSY) goto fail;
 	outb(L4_CMD_SETCAL, L4_PORT);
+	if (l4_wait_ready())
+		goto out;
 
-	if (l4_wait_ready()) goto fail;
-	if (inb(L4_PORT) != L4_SELECT_DIGITAL + (port >> 2)) goto fail;
+	if (inb(L4_PORT) != L4_SELECT_DIGITAL + (port >> 2))
+		goto out;
 
-	if (l4_wait_ready()) goto fail;
+	if (l4_wait_ready())
+		goto out;
         outb(port & 3, L4_PORT);
 
 	for (i = 0; i < 4; i++) {
-		if (l4_wait_ready()) goto fail;
+		if (l4_wait_ready())
+			goto out;
 		outb(cal[i], L4_PORT);
 	}
 
 	result = 0;
 
-fail:	outb(L4_SELECT_ANALOG, L4_PORT);
+out:	outb(L4_SELECT_ANALOG, L4_PORT);
 	return result;
 }
 
@@ -209,73 +219,102 @@
 	return 0;
 }
 
-static int __init l4_init(void)
+static int __init l4_create_ports(int card_no)
 {
-	int cal[4] = {255,255,255,255};
-	int i, j, rev, cards = 0;
-	struct gameport *gameport;
 	struct l4 *l4;
+	struct gameport *port;
+	int i, idx;
 
-	if (!request_region(L4_PORT, 1, "lightning"))
-		return -1;
+	for (i = 0; i < 4; i++) {
 
-	for (i = 0; i < 2; i++) {
+		idx = card_no * 4 + i;
+		l4 = &l4_ports[idx];
 
-		outb(L4_SELECT_ANALOG, L4_PORT);
-		outb(L4_SELECT_DIGITAL + i, L4_PORT);
+		if (!(l4->gameport = port = gameport_allocate_port())) {
+			printk(KERN_ERR "lightning: Memory allocation failed\n");
+			while (--i >= 0) {
+				gameport_free_port(l4->gameport);
+				l4->gameport = NULL;
+			}
+			return -ENOMEM;
+		}
+		l4->port = idx;
 
-		if (inb(L4_PORT) & L4_BUSY) continue;
-		outb(L4_CMD_ID, L4_PORT);
+		port->port_data = l4;
+		port->open = l4_open;
+		port->cooked_read = l4_cooked_read;
+		port->calibrate = l4_calibrate;
 
-		if (l4_wait_ready()) continue;
-		if (inb(L4_PORT) != L4_SELECT_DIGITAL + i) continue;
+		gameport_set_name(port, "PDPI Lightning 4");
+		gameport_set_phys(port, "isa%04x/gameport%d", L4_PORT, idx);
 
-		if (l4_wait_ready()) continue;
-		if (inb(L4_PORT) != L4_ID) continue;
+		if (idx == 0)
+			port->io = L4_PORT;
+	}
 
-		if (l4_wait_ready()) continue;
-		rev = inb(L4_PORT);
+	return 0;
+}
 
-		if (!rev) continue;
+static int __init l4_add_card(int card_no)
+{
+	int cal[4] = { 255, 255, 255, 255 };
+	int i, rev, result;
+	struct l4 *l4;
 
-		if (!(l4_port[i * 4] = kmalloc(sizeof(struct l4) * 4, GFP_KERNEL))) {
-			printk(KERN_ERR "lightning: Out of memory allocating ports.\n");
-			continue;
-		}
-		memset(l4_port[i * 4], 0, sizeof(struct l4) * 4);
+	outb(L4_SELECT_ANALOG, L4_PORT);
+	outb(L4_SELECT_DIGITAL + card_no, L4_PORT);
 
-		for (j = 0; j < 4; j++) {
+	if (inb(L4_PORT) & L4_BUSY)
+		return -1;
+	outb(L4_CMD_ID, L4_PORT);
 
-			l4 = l4_port[i * 4 + j] = l4_port[i * 4] + j;
-			l4->port = i * 4 + j;
+	if (l4_wait_ready())
+		return -1;
 
-			sprintf(l4->phys, "isa%04x/gameport%d", L4_PORT, 4 * i + j);
+	if (inb(L4_PORT) != L4_SELECT_DIGITAL + card_no)
+		return -1;
 
-			gameport = &l4->gameport;
-			gameport->port_data = l4;
-			gameport->open = l4_open;
-			gameport->cooked_read = l4_cooked_read;
-			gameport->calibrate = l4_calibrate;
+	if (l4_wait_ready())
+		return -1;
+	if (inb(L4_PORT) != L4_ID)
+		return -1;
 
-			gameport->name = l4_name;
-			gameport->phys = l4->phys;
-			gameport->id.bustype = BUS_ISA;
+	if (l4_wait_ready())
+		return -1;
+	rev = inb(L4_PORT);
 
-			if (!i && !j)
-				gameport->io = L4_PORT;
+	if (!rev)
+		return -1;
 
-			if (rev > 0x28)		/* on 2.9+ the setcal command works correctly */
-				l4_setcal(l4->port, cal);
+	result = l4_create_ports(card_no);
+	if (result)
+		return result;
 
-			gameport_register_port(gameport);
-		}
+	printk(KERN_INFO "gameport: PDPI Lightning 4 %s card v%d.%d at %#x\n",
+		card_no ? "secondary" : "primary", rev >> 4, rev, L4_PORT);
 
-		printk(KERN_INFO "gameport: PDPI Lightning 4 %s card v%d.%d at %#x\n",
-			i ? "secondary" : "primary", rev >> 4, rev, L4_PORT);
+	for (i = 0; i < 4; i++) {
+		l4 = &l4_ports[card_no * 4 + i];
 
-		cards++;
+		if (rev > 0x28)		/* on 2.9+ the setcal command works correctly */
+			l4_setcal(l4->port, cal);
+		gameport_register_port(l4->gameport);
 	}
 
+	return 0;
+}
+
+static int __init l4_init(void)
+{
+	int i, cards = 0;
+
+	if (!request_region(L4_PORT, 1, "lightning"))
+		return -1;
+
+	for (i = 0; i < 2; i++)
+		if (l4_add_card(i) == 0)
+			cards++;
+
 	outb(L4_SELECT_ANALOG, L4_PORT);
 
 	if (!cards) {
@@ -289,13 +328,14 @@
 static void __exit l4_exit(void)
 {
 	int i;
-	int cal[4] = {59, 59, 59, 59};
+	int cal[4] = { 59, 59, 59, 59 };
 
 	for (i = 0; i < 8; i++)
-		if (l4_port[i]) {
-			l4_setcal(l4_port[i]->port, cal);
-			gameport_unregister_port(&l4_port[i]->gameport);
+		if (l4_ports[i].gameport) {
+			l4_setcal(l4_ports[i].port, cal);
+			gameport_unregister_port(l4_ports[i].gameport);
 		}
+
 	outb(L4_SELECT_ANALOG, L4_PORT);
 	release_region(L4_PORT, 1);
 }
diff -Nru a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
--- a/drivers/input/gameport/ns558.c	2005-02-11 01:38:07 -05:00
+++ b/drivers/input/gameport/ns558.c	2005-02-11 01:38:07 -05:00
@@ -49,12 +49,11 @@
 
 struct ns558 {
 	int type;
+	int io;
 	int size;
 	struct pnp_dev *dev;
+	struct gameport *gameport;
 	struct list_head node;
-	struct gameport gameport;
-	char phys[32];
-	char name[32];
 };
 
 static LIST_HEAD(ns558_list);
@@ -65,18 +64,19 @@
  * A joystick must be attached for this to work.
  */
 
-static void ns558_isa_probe(int io)
+static int ns558_isa_probe(int io)
 {
 	int i, j, b;
 	unsigned char c, u, v;
-	struct ns558 *port;
+	struct ns558 *ns558;
+	struct gameport *port;
 
 /*
  * No one should be using this address.
  */
 
 	if (!request_region(io, 1, "ns558-isa"))
-		return;
+		return -EBUSY;
 
 /*
  * We must not be able to write arbitrary values to the port.
@@ -87,8 +87,8 @@
 	outb(~c & ~3, io);
 	if (~(u = v = inb(io)) & 3) {
 		outb(c, io);
-		i = 0;
-		goto out;
+		release_region(io, 1);
+		return -ENODEV;
 	}
 /*
  * After a trigger, there must be at least some bits changing.
@@ -98,8 +98,8 @@
 
 	if (u == v) {
 		outb(c, io);
-		i = 0;
-		goto out;
+		release_region(io, 1);
+		return -ENODEV;
 	}
 	msleep(3);
 /*
@@ -110,8 +110,8 @@
 	for (i = 0; i < 1000; i++)
 		if ((u ^ inb(io)) & 0xf) {
 			outb(c, io);
-			i = 0;
-			goto out;
+			release_region(io, 1);
+			return -ENODEV;
 		}
 /*
  * And now find the number of mirrors of the port.
@@ -119,7 +119,7 @@
 
 	for (i = 1; i < 5; i++) {
 
-		release_region(io & (-1 << (i-1)), (1 << (i-1)));
+		release_region(io & (-1 << (i - 1)), (1 << (i - 1)));
 
 		if (!request_region(io & (-1 << i), (1 << i), "ns558-isa"))
 			break;				/* Don't disturb anyone */
@@ -139,34 +139,33 @@
 
 	if (i != 4) {
 		if (!request_region(io & (-1 << i), (1 << i), "ns558-isa"))
-			return;
+			return -EBUSY;
 	}
 
-	if (!(port = kmalloc(sizeof(struct ns558), GFP_KERNEL))) {
+	ns558 = kcalloc(1, sizeof(struct ns558), GFP_KERNEL);
+	port = gameport_allocate_port();
+	if (!ns558 || !port) {
 		printk(KERN_ERR "ns558: Memory allocation failed.\n");
-		goto out;
+		release_region(io & (-1 << i), (1 << i));
+		kfree(ns558);
+		gameport_free_port(port);
+		return -ENOMEM;
 	}
-	memset(port, 0, sizeof(struct ns558));
-
-	port->size = (1 << i);
-	port->gameport.io = io;
-	port->gameport.phys = port->phys;
-	port->gameport.name = port->name;
-	port->gameport.id.bustype = BUS_ISA;
 
-	sprintf(port->phys, "isa%04x/gameport0", io & (-1 << i));
-	sprintf(port->name, "NS558 ISA");
+	memset(ns558, 0, sizeof(struct ns558));
+	ns558->io = io;
+	ns558->size = 1 << i;
+	ns558->gameport = port;
+
+	port->io = io;
+	gameport_set_name(port, "NS558 ISA Gameport");
+	gameport_set_phys(port, "isa%04x/gameport0", io & (-1 << i));
 
-	gameport_register_port(&port->gameport);
+	gameport_register_port(port);
 
-	printk(KERN_INFO "gameport: NS558 ISA at %#x", port->gameport.io);
-	if (port->size > 1) printk(" size %d", port->size);
-	printk(" speed %d kHz\n", port->gameport.speed);
+	list_add(&ns558->node, &ns558_list);
 
-	list_add(&port->node, &ns558_list);
-	return;
-out:
-	release_region(io & (-1 << i), (1 << i));
+	return 0;
 }
 
 #ifdef CONFIG_PNP
@@ -202,45 +201,42 @@
 static int ns558_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
 	int ioport, iolen;
-	struct ns558 *port;
+	struct ns558 *ns558;
+	struct gameport *port;
 
 	if (!pnp_port_valid(dev, 0)) {
 		printk(KERN_WARNING "ns558: No i/o ports on a gameport? Weird\n");
 		return -ENODEV;
 	}
 
-	ioport = pnp_port_start(dev,0);
-	iolen = pnp_port_len(dev,0);
+	ioport = pnp_port_start(dev, 0);
+	iolen = pnp_port_len(dev, 0);
 
 	if (!request_region(ioport, iolen, "ns558-pnp"))
 		return -EBUSY;
 
-	if (!(port = kmalloc(sizeof(struct ns558), GFP_KERNEL))) {
-		printk(KERN_ERR "ns558: Memory allocation failed.\n");
+	ns558 = kcalloc(1, sizeof(struct ns558), GFP_KERNEL);
+	port = gameport_allocate_port();
+	if (!ns558 || !port) {
+		printk(KERN_ERR "ns558: Memory allocation failed\n");
+		kfree(ns558);
+		gameport_free_port(port);
 		return -ENOMEM;
 	}
-	memset(port, 0, sizeof(struct ns558));
-
-	port->size = iolen;
-	port->dev = dev;
-
-	port->gameport.io = ioport;
-	port->gameport.phys = port->phys;
-	port->gameport.name = port->name;
-	port->gameport.id.bustype = BUS_ISAPNP;
-	port->gameport.id.version = 0x100;
-
-	sprintf(port->phys, "pnp%s/gameport0", dev->dev.bus_id);
-	sprintf(port->name, "%s", "NS558 PnP Gameport");
 
-	gameport_register_port(&port->gameport);
+	ns558->io = ioport;
+	ns558->size = iolen;
+	ns558->dev = dev;
+	ns558->gameport = port;
+
+	gameport_set_name(port, "NS558 PnP Gameport");
+	gameport_set_phys(port, "pnp%s/gameport0", dev->dev.bus_id);
+	port->dev.parent = &dev->dev;
+	port->io = ioport;
 
-	printk(KERN_INFO "gameport: NS558 PnP at pnp%s io %#x",
-		dev->dev.bus_id, port->gameport.io);
-	if (iolen > 1) printk(" size %d", iolen);
-	printk(" speed %d kHz\n", port->gameport.speed);
+	gameport_register_port(port);
 
-	list_add_tail(&port->node, &ns558_list);
+	list_add_tail(&ns558->node, &ns558_list);
 	return 0;
 }
 
@@ -279,12 +275,12 @@
 
 static void __exit ns558_exit(void)
 {
-	struct ns558 *port;
+	struct ns558 *ns558;
 
-	list_for_each_entry(port, &ns558_list, node) {
-		gameport_unregister_port(&port->gameport);
-		release_region(port->gameport.io & ~(port->size - 1), port->size);
-		kfree(port);
+	list_for_each_entry(ns558, &ns558_list, node) {
+		gameport_unregister_port(ns558->gameport);
+		release_region(ns558->io & ~(ns558->size - 1), ns558->size);
+		kfree(ns558);
 	}
 
 	if (pnp_registered)
diff -Nru a/drivers/input/gameport/vortex.c b/drivers/input/gameport/vortex.c
--- a/drivers/input/gameport/vortex.c	2005-02-11 01:38:07 -05:00
+++ b/drivers/input/gameport/vortex.c	2005-02-11 01:38:07 -05:00
@@ -53,11 +53,10 @@
 #define VORTEX_DATA_WAIT	20	/* 20 ms */
 
 struct vortex {
-	struct gameport gameport;
+	struct gameport *gameport;
 	struct pci_dev *dev;
-        unsigned char __iomem *base;
-        unsigned char __iomem *io;
-	char phys[32];
+	unsigned char __iomem *base;
+	unsigned char __iomem *io;
 };
 
 static unsigned char vortex_read(struct gameport *gameport)
@@ -109,30 +108,17 @@
 static int __devinit vortex_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct vortex *vortex;
+	struct gameport *port;
 	int i;
 
-	if (!(vortex = kmalloc(sizeof(struct vortex), GFP_KERNEL)))
-		return -1;
-        memset(vortex, 0, sizeof(struct vortex));
-
-	vortex->dev = dev;
-	sprintf(vortex->phys, "pci%s/gameport0", pci_name(dev));
-
-	pci_set_drvdata(dev, vortex);
-
-	vortex->gameport.port_data = vortex;
-	vortex->gameport.fuzz = 64;
-
-	vortex->gameport.read = vortex_read;
-	vortex->gameport.trigger = vortex_trigger;
-	vortex->gameport.cooked_read = vortex_cooked_read;
-	vortex->gameport.open = vortex_open;
-
-	vortex->gameport.name = pci_name(dev);
-	vortex->gameport.phys = vortex->phys;
-	vortex->gameport.id.bustype = BUS_PCI;
-	vortex->gameport.id.vendor = dev->vendor;
-	vortex->gameport.id.product = dev->device;
+	vortex = kcalloc(1, sizeof(struct vortex), GFP_KERNEL);
+	port = gameport_allocate_port();
+	if (!vortex || !port) {
+		printk(KERN_ERR "vortex: Memory allocation failed.\n");
+		kfree(vortex);
+		gameport_free_port(port);
+		return -ENOMEM;
+	}
 
 	for (i = 0; i < 6; i++)
 		if (~pci_resource_flags(dev, i) & IORESOURCE_IO)
@@ -140,14 +126,26 @@
 
 	pci_enable_device(dev);
 
+	vortex->dev = dev;
+	vortex->gameport = port;
 	vortex->base = ioremap(pci_resource_start(vortex->dev, i),
 				pci_resource_len(vortex->dev, i));
 	vortex->io = vortex->base + id->driver_data;
 
-	gameport_register_port(&vortex->gameport);
+	pci_set_drvdata(dev, vortex);
+
+	port->port_data = vortex;
+	port->fuzz = 64;
 
-	printk(KERN_INFO "gameport at pci%s speed %d kHz\n",
-		pci_name(dev), vortex->gameport.speed);
+	gameport_set_name(port, "AU88x0");
+	gameport_set_phys(port, "pci%s/gameport0", pci_name(dev));
+	port->dev.parent = &dev->dev;
+	port->read = vortex_read;
+	port->trigger = vortex_trigger;
+	port->cooked_read = vortex_cooked_read;
+	port->open = vortex_open;
+
+	gameport_register_port(port);
 
 	return 0;
 }
@@ -155,15 +153,17 @@
 static void __devexit vortex_remove(struct pci_dev *dev)
 {
 	struct vortex *vortex = pci_get_drvdata(dev);
-	gameport_unregister_port(&vortex->gameport);
+
+	gameport_unregister_port(vortex->gameport);
 	iounmap(vortex->base);
 	kfree(vortex);
 }
 
-static struct pci_device_id vortex_id_table[] =
-{{ 0x12eb, 0x0001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0x11000 },
- { 0x12eb, 0x0002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0x28800 },
- { 0 }};
+static struct pci_device_id vortex_id_table[] = {
+	{ 0x12eb, 0x0001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0x11000 },
+	{ 0x12eb, 0x0002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0x28800 },
+	{ 0 }
+};
 
 static struct pci_driver vortex_driver = {
 	.name =		"vortex_gameport",
diff -Nru a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
--- a/drivers/input/joystick/a3d.c	2005-02-11 01:38:07 -05:00
+++ b/drivers/input/joystick/a3d.c	2005-02-11 01:38:07 -05:00
@@ -55,7 +55,7 @@
 
 struct a3d {
 	struct gameport *gameport;
-	struct gameport adc;
+	struct gameport *adc;
 	struct input_dev dev;
 	struct timer_list timer;
 	int axes[4];
@@ -66,7 +66,6 @@
 	int reads;
 	int bads;
 	char phys[32];
-	char adcphys[32];
 };
 
 /*
@@ -261,6 +260,7 @@
 static void a3d_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct a3d *a3d;
+	struct gameport *adc;
 	unsigned char data[A3D_MAX_LENGTH];
 	int i;
 
@@ -292,7 +292,6 @@
 	}
 
 	sprintf(a3d->phys, "%s/input0", gameport->phys);
-	sprintf(a3d->adcphys, "%s/gameport0", gameport->phys);
 
 	if (a3d->mode == A3D_MODE_PXL) {
 
@@ -315,16 +314,11 @@
 		a3d_read(a3d, data);
 
 		for (i = 0; i < 4; i++) {
-			if (i < 2) {
-				a3d->dev.absmin[axes[i]] = 48;
-				a3d->dev.absmax[axes[i]] = a3d->dev.abs[axes[i]] * 2 - 48;
-				a3d->dev.absflat[axes[i]] = 8;
-			} else {
-				a3d->dev.absmin[axes[i]] = 2;
-				a3d->dev.absmax[axes[i]] = 253;
-			}
-			a3d->dev.absmin[ABS_HAT0X + i] = -1;
-			a3d->dev.absmax[ABS_HAT0X + i] = 1;
+			if (i < 2)
+				input_set_abs_params(&a3d->dev, axes[i], 48, a3d->dev.abs[axes[i]] * 2 - 48, 0, 8);
+			else
+				input_set_abs_params(&a3d->dev, axes[i], 2, 253, 0, 0);
+			input_set_abs_params(&a3d->dev, ABS_HAT0X + i, -1, 1, 0, 0);
 		}
 
 	} else {
@@ -336,23 +330,23 @@
 		a3d->dev.relbit[0] |= BIT(REL_X) | BIT(REL_Y);
 		a3d->dev.keybit[LONG(BTN_MOUSE)] |= BIT(BTN_RIGHT) | BIT(BTN_LEFT) | BIT(BTN_MIDDLE);
 
-		a3d->adc.port_data = a3d;
-		a3d->adc.open = a3d_adc_open;
-		a3d->adc.close = a3d_adc_close;
-		a3d->adc.cooked_read = a3d_adc_cooked_read;
-		a3d->adc.fuzz = 1;
-
-		a3d->adc.name = a3d_names[a3d->mode];
-		a3d->adc.phys = a3d->adcphys;
-		a3d->adc.id.bustype = BUS_GAMEPORT;
-		a3d->adc.id.vendor = GAMEPORT_ID_VENDOR_MADCATZ;
-		a3d->adc.id.product = a3d->mode;
-		a3d->adc.id.version = 0x0100;
-
 		a3d_read(a3d, data);
 
-		gameport_register_port(&a3d->adc);
-		printk(KERN_INFO "gameport: %s on %s\n", a3d_names[a3d->mode], gameport->phys);
+		if (!(a3d->adc = adc = gameport_allocate_port()))
+			printk(KERN_ERR "a3d: Not enough memory for ADC port\n");
+		else {
+			adc->port_data = a3d;
+			adc->open = a3d_adc_open;
+			adc->close = a3d_adc_close;
+			adc->cooked_read = a3d_adc_cooked_read;
+			adc->fuzz = 1;
+
+			gameport_set_name(adc, a3d_names[a3d->mode]);
+			gameport_set_phys(adc, "%s/gameport0", gameport->phys);
+			adc->dev.parent = &gameport->dev;
+
+			gameport_register_port(adc);
+		}
 	}
 
 	a3d->dev.private = a3d;
@@ -370,17 +364,20 @@
 	printk(KERN_INFO "input: %s on %s\n", a3d_names[a3d->mode], a3d->phys);
 
 	return;
+
 fail2:	gameport_close(gameport);
 fail1:  kfree(a3d);
 }
 
 static void a3d_disconnect(struct gameport *gameport)
 {
-
 	struct a3d *a3d = gameport->private;
+
 	input_unregister_device(&a3d->dev);
-	if (a3d->mode < A3D_MODE_PXL)
-		gameport_unregister_port(&a3d->adc);
+	if (a3d->adc) {
+		gameport_unregister_port(a3d->adc);
+		a3d->adc = NULL;
+	}
 	gameport_close(gameport);
 	kfree(a3d);
 }
diff -Nru a/include/linux/gameport.h b/include/linux/gameport.h
--- a/include/linux/gameport.h	2005-02-11 01:38:07 -05:00
+++ b/include/linux/gameport.h	2005-02-11 01:38:07 -05:00
@@ -10,7 +10,6 @@
  */
 
 #include <asm/io.h>
-#include <linux/input.h>
 #include <linux/list.h>
 #include <linux/device.h>
 
@@ -22,8 +21,6 @@
 	char name_buf[32];
 	char *phys;
 	char phys_buf[32];
-
-	struct input_id id;
 
 	int io;
 	int speed;
