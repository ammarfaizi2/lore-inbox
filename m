Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423075AbWJGCyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423075AbWJGCyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 22:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423074AbWJGCyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 22:54:47 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:5547 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1423071AbWJGCyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 22:54:45 -0400
Date: Fri, 6 Oct 2006 20:54:44 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Message-ID: <20061007025444.GV2563@parisc-linux.org>
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org> <20061006164211.GA15321@flint.arm.linux.org.uk> <Pine.LNX.4.64.0610061055490.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610061055490.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 11:01:24AM -0700, Linus Torvalds wrote:
> On Fri, 6 Oct 2006, Russell King wrote:
> > 
> > If it's obvious and trivial, it should be easy for anyone to fix, even
> > the person who broke it.  Especially as there are build logs automatically
> > generated for every -git tree at http://armlinux.simtec.co.uk/kautobuild/
> 
> Ok, I just committed a rough first cut at fixing up arm/.

Could you do:

git-pull git://git.parisc-linux.org/git/linux-2.6.git irq-fixes

Or apply the patch below, if that's easier

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 9bdd019..2ece7c7 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -35,8 +35,8 @@ #include <asm/smp.h>
 
 #undef PARISC_IRQ_CR16_COUNTS
 
-extern irqreturn_t timer_interrupt(int, void *, struct pt_regs *);
-extern irqreturn_t ipi_interrupt(int, void *, struct pt_regs *);
+extern irqreturn_t timer_interrupt(int, void *);
+extern irqreturn_t ipi_interrupt(int, void *);
 
 #define EIEM_MASK(irq)       (1UL<<(CPU_IRQ_MAX - irq))
 
@@ -375,7 +375,7 @@ #ifdef CONFIG_SMP
 		goto set_out;
 	}
 #endif
-	__do_IRQ(irq, regs);
+	__do_IRQ(irq);
 
  out:
 	irq_exit();
diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
index 1d58ce0..b448392 100644
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -66,7 +66,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	/* gcc can optimize for "read-only" case with a local clocktick */
 	unsigned long cpt = clocktick;
 
-	profile_tick(CPU_PROFILING, regs);
+	profile_tick(CPU_PROFILING);
 
 	/* Initialize next_tick to the expected tick time. */
 	next_tick = cpu_data[cpu].it_value;
diff --git a/drivers/input/keyboard/hil_kbd.c b/drivers/input/keyboard/hil_kbd.c
index c9b0b89..e774dd3 100644
--- a/drivers/input/keyboard/hil_kbd.c
+++ b/drivers/input/keyboard/hil_kbd.c
@@ -328,7 +328,7 @@ static int hil_kbd_connect(struct serio 
 	kbd->dev->id.vendor	= PCI_VENDOR_ID_HP;
 	kbd->dev->id.product	= 0x0001; /* TODO: get from kbd->rsc */
 	kbd->dev->id.version	= 0x0100; /* TODO: get from kbd->rsc */
-	kbd->dev->dev		= &serio->dev;
+	kbd->dev->cdev.dev	= &serio->dev;
 
 	for (i = 0; i < 128; i++) {
 		set_bit(hil_kbd_set1[i], kbd->dev->keybit);
diff --git a/drivers/input/mouse/hil_ptr.c b/drivers/input/mouse/hil_ptr.c
index 402b057..4f2b503 100644
--- a/drivers/input/mouse/hil_ptr.c
+++ b/drivers/input/mouse/hil_ptr.c
@@ -375,7 +375,7 @@ #endif
 	ptr->dev->id.vendor	= PCI_VENDOR_ID_HP;
 	ptr->dev->id.product	= 0x0001; /* TODO: get from ptr->rsc */
 	ptr->dev->id.version	= 0x0100; /* TODO: get from ptr->rsc */
-	ptr->dev->dev		= &serio->dev;
+	ptr->dev->cdev.dev	= &serio->dev;
 
 	input_register_device(ptr->dev);
 	printk(KERN_INFO "input: %s (%s), ID: %d\n",
diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 081fdc3..74f14e0 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -166,7 +166,7 @@ static inline int gscps2_writeb_output(s
 
 	/* make sure any received data is returned as fast as possible */
 	/* this is important e.g. when we set the LEDs on the keyboard */
-	gscps2_interrupt(0, NULL, NULL);
+	gscps2_interrupt(0, NULL);
 
 	return 1;
 }
@@ -306,7 +306,7 @@ static int gscps2_open(struct serio *por
 	/* enable it */
 	gscps2_enable(ps2port, ENABLE);
 
-	gscps2_interrupt(0, NULL, NULL);
+	gscps2_interrupt(0, NULL);
 
 	return 0;
 }
diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index bbbe15e..bdfde04 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -162,10 +162,10 @@ static void hil_mlc_send_polls(hil_mlc *
 		if (did != (p & HIL_PKT_ADDR_MASK) >> 8) {
 			if (drv == NULL || drv->interrupt == NULL) goto skip;
 
-			drv->interrupt(serio, 0, 0, NULL);
-			drv->interrupt(serio, HIL_ERR_INT >> 16, 0, NULL);
-			drv->interrupt(serio, HIL_PKT_CMD >> 8,  0, NULL);
-			drv->interrupt(serio, HIL_CMD_POL + cnt, 0, NULL);
+			drv->interrupt(serio, 0, 0);
+			drv->interrupt(serio, HIL_ERR_INT >> 16, 0);
+			drv->interrupt(serio, HIL_PKT_CMD >> 8,  0);
+			drv->interrupt(serio, HIL_CMD_POL + cnt, 0);
 		skip:
 			did = (p & HIL_PKT_ADDR_MASK) >> 8;
 			serio = did ? mlc->serio[mlc->di_map[did-1]] : NULL;
@@ -174,10 +174,10 @@ static void hil_mlc_send_polls(hil_mlc *
 		}
 		cnt++; i++;
 		if (drv == NULL || drv->interrupt == NULL) continue;
-		drv->interrupt(serio, (p >> 24), 0, NULL);
-		drv->interrupt(serio, (p >> 16) & 0xff, 0, NULL);
-		drv->interrupt(serio, (p >> 8) & ~HIL_PKT_ADDR_MASK, 0, NULL);
-		drv->interrupt(serio, p & 0xff, 0, NULL);
+		drv->interrupt(serio, (p >> 24), 0);
+		drv->interrupt(serio, (p >> 16) & 0xff, 0);
+		drv->interrupt(serio, (p >> 8) & ~HIL_PKT_ADDR_MASK, 0);
+		drv->interrupt(serio, p & 0xff, 0);
 	}
 }
 
@@ -780,16 +780,16 @@ static int hil_mlc_serio_write(struct se
 	while ((last != idx) && (*last == 0)) last--;
 
 	while (idx != last) {
-		drv->interrupt(serio, 0, 0, NULL);
-		drv->interrupt(serio, HIL_ERR_INT >> 16, 0, NULL);
-		drv->interrupt(serio, 0, 0, NULL);
-		drv->interrupt(serio, *idx, 0, NULL);
+		drv->interrupt(serio, 0, 0);
+		drv->interrupt(serio, HIL_ERR_INT >> 16, 0);
+		drv->interrupt(serio, 0, 0);
+		drv->interrupt(serio, *idx, 0);
 		idx++;
 	}
-	drv->interrupt(serio, 0, 0, NULL);
-	drv->interrupt(serio, HIL_ERR_INT >> 16, 0, NULL);
-	drv->interrupt(serio, HIL_PKT_CMD >> 8, 0, NULL);
-	drv->interrupt(serio, *idx, 0, NULL);
+	drv->interrupt(serio, 0, 0);
+	drv->interrupt(serio, HIL_ERR_INT >> 16, 0);
+	drv->interrupt(serio, HIL_PKT_CMD >> 8, 0);
+	drv->interrupt(serio, *idx, 0);
 	
 	mlc->serio_oidx[map->didx] = 0;
 	mlc->serio_opacket[map->didx] = 0;
diff --git a/drivers/net/lasi_82596.c b/drivers/net/lasi_82596.c
index 8cbd940..f4d815b 100644
--- a/drivers/net/lasi_82596.c
+++ b/drivers/net/lasi_82596.c
@@ -1252,7 +1252,7 @@ #ifdef CONFIG_NET_POLL_CONTROLLER
 static void i596_poll_controller(struct net_device *dev)
 {
 	disable_irq(dev->irq);
-	i596_interrupt(dev->irq, dev, NULL);
+	i596_interrupt(dev->irq, dev);
 	enable_irq(dev->irq);
 }
 #endif
diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index a0a8fd8..03c763c 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -389,7 +389,7 @@ ilr_again:
 		int irq = dino_dev->global_irq[local_irq];
 		DBG(KERN_DEBUG "%s(%d, %p) mask 0x%x\n",
 			__FUNCTION__, irq, intr_dev, mask);
-		__do_IRQ(irq, regs);
+		__do_IRQ(irq);
 		mask &= ~(1 << local_irq);
 	} while (mask);
 
diff --git a/drivers/parisc/eisa.c b/drivers/parisc/eisa.c
index 094562e..e97cecb 100644
--- a/drivers/parisc/eisa.c
+++ b/drivers/parisc/eisa.c
@@ -234,7 +234,7 @@ static irqreturn_t eisa_irq(int wax_irq,
 	}
 	spin_unlock_irqrestore(&eisa_irq_lock, flags);
 
-	__do_IRQ(irq, regs);
+	__do_IRQ(irq);
    
 	spin_lock_irqsave(&eisa_irq_lock, flags);
 	/* unmask */
diff --git a/drivers/serial/mux.c b/drivers/serial/mux.c
index aa819d3..8ad1b8c 100644
--- a/drivers/serial/mux.c
+++ b/drivers/serial/mux.c
@@ -230,7 +230,7 @@ static void mux_read(struct uart_port *p
 				continue;
 		}
 
-		if (uart_handle_sysrq_char(port, data & 0xffu, NULL))
+		if (uart_handle_sysrq_char(port, data & 0xffu))
 			continue;
 
 		tty_insert_flip_char(tty, data & 0xFF, TTY_NORMAL);
diff --git a/include/asm-parisc/irq_regs.h b/include/asm-parisc/irq_regs.h
new file mode 100644
index 0000000..3dd9c0b
--- /dev/null
+++ b/include/asm-parisc/irq_regs.h
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
