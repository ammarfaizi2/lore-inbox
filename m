Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAYASi>; Wed, 24 Jan 2001 19:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRAYAS3>; Wed, 24 Jan 2001 19:18:29 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:43175 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129406AbRAYASS>; Wed, 24 Jan 2001 19:18:18 -0500
Message-ID: <3A6F7251.1A764EC1@uow.edu.au>
Date: Thu, 25 Jan 2001 11:24:49 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Network hang with 2.4.1-pre9 and 3c59x
In-Reply-To: <3A6E247A.C6A2FD17@uow.edu.au> <Pine.GSO.3.96.1010124132925.8454B-100000@delta.ds2.pg.gda.pl>
Content-Type: multipart/mixed;
 boundary="------------2B2DA464CCBDEAFDDE8A039E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2B2DA464CCBDEAFDDE8A039E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Maciej W. Rozycki" wrote:
> 
> On Wed, 24 Jan 2001, Andrew Morton wrote:
> 
> > This is due to a lost APIC interrupt acknowledgement.  A workaround
> > is to boot with the `noapic' LILO option.
> >
> > This long-standing and very nasty problem was discussed extensively
> > a week or two ago.  Suspicions were cast at the disable_irq() function
> > but I'm not sure anything 100% conclusive was arrived at.
> 
>  Not sure if that is 100% conclusive but I decided to develop an APIC
> lockup recovery procedure.  Fortunately chips provide us enough
> information we may deal with the problem with moderate pain.

Cool.

> > I guess I'll have to find a way to make disable_irq() go away,
> > see if that helps.
> 
>  Please don't.  This would be hiding problems under a carpet.

Whether it's fixed properly, or kludged in the APIC code or kludged
in the drivers, it needs to be fixed.  I've spent nine months
methodically picking away at the 3com driver so it's now very
reliable, and this interrupt problem is the major failure mode.
In fact, the only failure mode, apart from the usual dodgy
ethernet switch negotiation blah.

So I've started to poke at this problem as well.  I'd be glad to stop :)

Attached are two patches:

irq-whacker.patch:

This is a patch against the 3com driver which simply calls
disable_irq()/enable_irq() at 100kHz.  Enable it with the
`whacker=1' module parm.  With this thread running, the
APIC dies within about one second as soon as you start
sending 100baseT traffic through the interface.  So it's
nice and reproducible.  This testing setup should translate
easily into any PCI netdriver.

manfred.patch:

Manfred's edge+level trigger hack.  This fixes the problem!
It slows down disable_irq()/enable_irq() a bit, but that
doesn't seem an issue.   A proper fix would be nice, but
this puppy works.

Manfred's ALT+SYSRQ+Q trick also fixes the problem.

Enabling processor focus simply makes interrupts
stop altogether.  Haven't looked into this yet.

-
--------------2B2DA464CCBDEAFDDE8A039E
Content-Type: text/plain; charset=us-ascii;
 name="manfred.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="manfred.patch"

>From - Thu Jan 25 02:34:14 2001
Received: from pop.zip.com.au
	by localhost with POP3 (fetchmail-5.1.0)
	for morton@localhost (single-drop); Sat, 13 Jan 2001 09:10:27 +1100 (EST)
Received: by leeloo.zip.com.au (mbox akpm)
 (with Cubic Circle's cucipop (v1.31 1998/05/13) Sat Jan 13 09:03:25 2001)
X-From_: linux-kernel-owner@vger.kernel.org  Sat Jan 13 07:58:29 2001
Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [199.183.24.194])
	by leeloo.zip.com.au (8.9.1/8.9.1) with ESMTP id HAA17314;
	Sat, 13 Jan 2001 07:58:22 +1100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132402AbRALU46>; Fri, 12 Jan 2001 15:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132461AbRALU4r>; Fri, 12 Jan 2001 15:56:47 -0500
Received: from colorfullife.com ([216.156.138.34]:56581 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132402AbRALU4g>;
	Fri, 12 Jan 2001 15:56:36 -0500
Received: from clsrvli.local (localhost [127.0.0.1])
	by colorfullife.com (8.9.3/8.9.3) with ESMTP id QAA12504;
	Fri, 12 Jan 2001 16:02:22 -0500
Received: from colorfullife.com (clsrvli.local [172.23.10.10])
	by clsrvli.local (8.11.0/8.11.0) with ESMTP id f0CKuMr05457;
	Fri, 12 Jan 2001 21:56:22 +0100
Message-ID: <3A5F6F07.88564D5B@colorfullife.com>
Date: 	Fri, 12 Jan 2001 21:54:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Frank de Lange <frank@unternet.org>,
        Linus Torvalds <torvalds@transmeta.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <Pine.LNX.4.30.0101122136180.2772-100000@e2>
Content-Type: multipart/mixed;
 boundary="------------55919F484DB2C7B38B8C5162"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: 	linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------55919F484DB2C7B38B8C5162
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> 
> 
> okay - i just wanted to hear a definitive word from you that this fixes
> your problem, because this is what we'll have to do as a final solution.
> (barring any other solution.)
> 
Ingo, is that possible?

The current fix is "disable_irq_nosync() and enable_irq() cause
deadlocks with level triggered ioapic irqs, do not use them" - I'm sure
ne2k-pci isn't the only driver that uses these function.

I have found one combination that doesn't hang with the unpatched
8390.c, but network throughput is down to 1/2. I hope that's due to the
debugging changes.

I'll restart now from a fresh 2.4.0 tree:
Changes:

1) enable focus cpu.
2) apply the attached patch.

I'm not sure if it's a real fix or if it just hides the problem: my
sysrq patch has shown that clearing and setting the "level trigger" bit
in the io apic reanimates the IO APIC.

--
        Manfred
--------------55919F484DB2C7B38B8C5162
Content-Type: text/plain; charset=us-ascii;
 name="patch-io"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-io"

--- build-2.4/arch/i386/kernel/io_apic.c.orig	Fri Jan 12 20:17:36 2001
+++ build-2.4/arch/i386/kernel/io_apic.c	Fri Jan 12 21:26:31 2001
@@ -134,6 +134,30 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
+DO_ACTION( __trigger_level,    0, |= 0x00008000, io_apic_sync(entry->apic))/* mask = 1 */
+DO_ACTION( __trigger_edge,  0, &= 0xffff7fff, )				/* mask = 0 */
+
+
+static void unmask_level_IO_APIC_irq (unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	__trigger_level_IO_APIC_irq(irq);
+	__unmask_IO_APIC_irq(irq);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
+static void mask_level_IO_APIC_irq (unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	__mask_IO_APIC_irq(irq);
+	__trigger_edge_IO_APIC_irq(irq);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
 static void unmask_IO_APIC_irq (unsigned int irq)
 {
 	unsigned long flags;
@@ -143,6 +167,7 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
+
 void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 {
 	struct IO_APIC_route_entry entry;
@@ -1181,14 +1206,14 @@
  */
 static unsigned int startup_level_ioapic_irq (unsigned int irq)
 {
-	unmask_IO_APIC_irq(irq);
+	unmask_level_IO_APIC_irq(irq);
 
 	return 0; /* don't check for pending */
 }
 
-#define shutdown_level_ioapic_irq	mask_IO_APIC_irq
-#define enable_level_ioapic_irq		unmask_IO_APIC_irq
-#define disable_level_ioapic_irq	mask_IO_APIC_irq
+#define shutdown_level_ioapic_irq	mask_level_IO_APIC_irq
+#define enable_level_ioapic_irq		unmask_level_IO_APIC_irq
+#define disable_level_ioapic_irq	mask_level_IO_APIC_irq
 
 static void end_level_ioapic_irq (unsigned int i)
 {

--------------55919F484DB2C7B38B8C5162--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

--------------2B2DA464CCBDEAFDDE8A039E
Content-Type: text/plain; charset=us-ascii;
 name="irq-whacker.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq-whacker.patch"

Index: drivers/net/3c59x.c
===================================================================
RCS file: /opt/cvs/lk/drivers/net/3c59x.c,v
retrieving revision 1.21
diff -u -u -r1.21 3c59x.c
--- drivers/net/3c59x.c	2001/01/23 08:25:53	1.21
+++ drivers/net/3c59x.c	2001/01/25 00:23:11
@@ -220,6 +220,8 @@
 static char version[] __devinitdata =
 "3c59x.c:LK1.1.13 14 Jan 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html\n";
 
+static int whacker = 0;
+
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("3Com 3c59x/3c90x/3c575 series Vortex/Boomerang/Cyclone driver");
 MODULE_PARM(debug, "i");
@@ -232,6 +234,7 @@
 MODULE_PARM(compaq_irq, "i");
 MODULE_PARM(compaq_device_id, "i");
 MODULE_PARM(watchdog, "i");
+MODULE_PARM(whacker, "i");
 
 /* Operational parameter that usually are not changed. */
 
@@ -775,6 +778,41 @@
 
 static int vortex_cards_found;
 
+static volatile int run_thread, thread_running;;
+
+static int kthread(void *arg)
+{
+	struct net_device *dev = arg;
+
+	printk("kthread running\n");
+	thread_running = 1;
+	while (run_thread) {
+		disable_irq(dev->irq);
+		udelay(5);
+		schedule();
+		enable_irq(dev->irq);
+		udelay(5);
+	}
+	printk("kthread stops\n");
+	thread_running = 0;
+	return 0;
+}
+
+static void start_irq_whacker(struct net_device *dev)
+{
+	run_thread = 1;
+	thread_running = 0;
+	if (whacker)
+		kernel_thread(kthread, dev, 0);
+}
+
+static void stop_irq_whacker(struct net_device *dev)
+{
+	run_thread = 0;
+	while (thread_running)
+		;
+}
+
 static void vortex_suspend (struct pci_dev *pdev)
 {
 	struct net_device *dev = pdev->driver_data;
@@ -1421,6 +1459,7 @@
 	if (vp->cb_fn_base)			/* The PCMCIA people are idiots.  */
 		writel(0x8000, vp->cb_fn_base + 4);
 	netif_start_queue (dev);
+	start_irq_whacker(dev);
 }
 
 static int
@@ -2298,6 +2337,8 @@
 {
 	struct vortex_private *vp = (struct vortex_private *)dev->priv;
 	long ioaddr = dev->base_addr;
+
+	stop_irq_whacker(dev);
 
 	netif_stop_queue (dev);
 

--------------2B2DA464CCBDEAFDDE8A039E--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
