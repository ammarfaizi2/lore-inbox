Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQLRNis>; Mon, 18 Dec 2000 08:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbQLRNii>; Mon, 18 Dec 2000 08:38:38 -0500
Received: from r1873.muc.dial.surf-callino.de ([213.21.8.95]:1540 "EHLO
	notebook.diehl.home") by vger.kernel.org with ESMTP
	id <S129449AbQLRNiY>; Mon, 18 Dec 2000 08:38:24 -0500
Date: Mon, 18 Dec 2000 14:08:25 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] yenta, pm - part 1
In-Reply-To: <Pine.LNX.4.10.10012151042170.2255-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012181325370.579-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2000, Linus Torvalds wrote:

> I suspect that the suspend/resume will do something bad to the BAT
> registers, which control the BIOS area mapping behaviour, and it just
> kills the forwarding of the legacy region to the PCI bus, or something.

FYI: I've identified a single byte in the hostbridges config space which
is altered after resume. Blindly restoring it makes the 0xe6000 pci bus
address mapping accessible again. But I think that's not the Right way to
fix it.

> I wonder if the PCI cardbus init code should just notice this, and force
> all cardbus windows to be re-initialized. That legacy area address really
> doesn't look right.

That's what I've done now. So I'm sending the modification I made in case
you would still like them for 2.4.0. I've separated it in 2 (almost
independent) patches meant to be applied in series against 2.4.0-t12 (final)

This is part 1. It provides:

- pm_state, pm_lock for cardbus socket to prevent multiple suspend/resume,
  especially the reentrant case due to some driver sleeping in resume.
- cardbus_change_pm_state() to handle pm state transition. Suspend is
  handled synchronously but resume schedules an asynchronous completion
  handler since pcmcia_resume_socket() may sleep.
- placing the pci_set_power_state() calls at the right place

Mainly touching pci_socket.* it fixes the suspend/resume multiple entrance
issues due to some driver (notably cardbus itself) sleeping in resume.

Regards
Martin

-----
diff -Nur v2.4.0-test12/drivers/pcmcia/pci_socket.c v2.4.0-t12-yenta1/driver/pcmcia/pci_socket.c
--- v2.4.0-test12/drivers/pcmcia/pci_socket.c	Wed Nov 29 21:47:10 2000
+++ v2.4.0-t12-yenta1/driver/pcmcia/pci_socket.c	Sun Dec 17 19:59:27 2000
@@ -178,6 +178,8 @@
 	socket->op = ops;
 	dev->driver_data = socket;
 	spin_lock_init(&socket->event_lock);
+	socket->pm_state = 0;
+	spin_lock_init(&socket->pm_lock);
 	return socket->op->open(socket);
 }
 
@@ -212,16 +214,83 @@
 	dev->driver_data = 0;
 }
 
+/* Delayed handler scheduled to complete the D3->D0 transition in the
+ * upper layers. We may sleep in pcmcia_resume_socket() with pm_lock
+ * hold - so we are save from resume re-entry due to other drivers
+ * sleeping in pci_pm resume handling.
+ */
+
+static void cardbus_resume_bh(void *data)
+{
+	pci_socket_t  *socket = (pci_socket_t *)data;
+
+	pcmcia_resume_socket(socket->pcmcia_socket);
+	socket->pm_state = 0;
+	spin_unlock(&socket->pm_lock);
+	MOD_DEC_USE_COUNT;
+}
+
+/* We are forced to implement asynch resume semantics because the
+ * pcmcia_resume path sleeps and we might get screwed by a second
+ * pci_pm_resume_device() hitting us in the middle of the first one.
+ * Which might happen anyway, if other drivers do not cooperate!
+ * So it's good to know we are protected by our socket->pm_lock.
+ */
+
+static void cardbus_change_pm_state(pci_socket_t *socket, int newstate)
+{
+	switch (newstate) {
+		case 3:
+			pcmcia_suspend_socket(socket->pcmcia_socket);
+			break;
+
+		case 0:
+			socket->tq_resume.routine = cardbus_resume_bh;
+			socket->tq_resume.data = socket;
+			MOD_INC_USE_COUNT;
+			schedule_task(&socket->tq_resume);
+			break;
+		default:
+			printk("cardbus: undefined power state\n");
+			break;
+	}
+}
+
+
 static void cardbus_suspend (struct pci_dev *dev)
 {
 	pci_socket_t *socket = (pci_socket_t *) dev->driver_data;
-	pcmcia_suspend_socket (socket->pcmcia_socket);
+
+	spin_lock(&socket->pm_lock);
+	if (socket->pm_state != 0) {
+		spin_unlock(&socket->pm_lock);
+		printk("cardbus: suspend of already suspended socket blocked\n");
+		return;
+	}
+	cardbus_change_pm_state(socket,3);
+	pci_set_power_state(dev,3);
+	socket->pm_state = 3;
+	spin_unlock(&socket->pm_lock);
 }
 
 static void cardbus_resume (struct pci_dev *dev)
 {
 	pci_socket_t *socket = (pci_socket_t *) dev->driver_data;
-	pcmcia_resume_socket (socket->pcmcia_socket);
+	
+	spin_lock(&socket->pm_lock);
+	if (socket->pm_state != 3) {
+		spin_unlock(&socket->pm_lock);
+		printk("cardbus: resume of non-suspended socket blocked\n");
+		return;
+	}
+	pci_set_power_state(dev,0);
+	cardbus_change_pm_state(socket, 0);
+
+	/* we intentionally leave with socket->pm_state not updated
+	 * and socket->pm_lock still acquired!
+	 * Will be released by the pending cardbus_resume_bh()
+	 * Needed to protect against resume re-entry.
+	 */
 }
 
 
diff -Nur v2.4.0-test12/drivers/pcmcia/pci_socket.h v2.4.0-t12-yenta1/driver/pcmcia/pci_socket.h
--- v2.4.0-test12/drivers/pcmcia/pci_socket.h	Wed Nov 29 21:47:10 2000
+++ v2.4.0-t12-yenta1/driver/pcmcia/pci_socket.h	Sun Dec 17 20:04:32 2000
@@ -26,6 +26,14 @@
 
 	/* A few words of private data for the low-level driver.. */
 	unsigned int private[8];
+
+	/* used for delayed resume completion handler */
+	struct tq_struct tq_resume;
+
+	/* to protect our pm state management */
+	unsigned int pm_state;
+	spinlock_t pm_lock;
+
 } pci_socket_t;
 
 struct pci_socket_ops {
diff -Nur v2.4.0-test12/drivers/pcmcia/yenta.c v2.4.0-t12-yenta1/driver/pcmcia/yenta.c
--- v2.4.0-test12/drivers/pcmcia/yenta.c	Wed Nov 29 21:47:10 2000
+++ v2.4.0-t12-yenta1/driver/pcmcia/yenta.c	Sun Dec 17 20:00:17 2000
@@ -629,8 +629,6 @@
 	u16 bridge;
 	struct pci_dev *dev = socket->dev;
 
-	pci_set_power_state(socket->dev, 0);
-
 	config_writel(socket, CB_LEGACY_MODE_BASE, 0);
 	config_writel(socket, PCI_BASE_ADDRESS_0, dev->resource[0].start);
 	config_writew(socket, PCI_COMMAND,
@@ -687,8 +685,6 @@
 	 * the IO and MEM bridging region data.. That is
 	 * something that pci_set_power_state() should
 	 * probably know about bridges anyway.
-	 *
-	pci_set_power_state(socket->dev, 3);
 	 */
 
 	return 0;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
