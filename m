Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129410AbQKZWbV>; Sun, 26 Nov 2000 17:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129704AbQKZWbK>; Sun, 26 Nov 2000 17:31:10 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:1808 "EHLO tepid.osl.fast.no")
        by vger.kernel.org with ESMTP id <S129410AbQKZWau>;
        Sun, 26 Nov 2000 17:30:50 -0500
Date: Sun, 26 Nov 2000 22:00:12 GMT
Message-Id: <200011262200.WAA80893@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test11-irda1
Reply-To: dagb@fast.no
X-Mailer: Pygmy (v0.4.5)
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please apply this patch to your latest 2.4 code. The patch have been 
tested by users at the Linux-IrDA mailing-list which confirms that
it fixes the specific problems listed below.

Changes:

o Devfs support with IrCOMM (pmhahn?)

o IrLAN connection failures with DHCP (me)

o NSC FIR dongle fixes (Pontus Fuchs)

o Fixes IrLAP discovery problems with some devices (me)

o Updates to some doc files (me)

-- Dag

diff -urpN linux-2.4.0-test11-pre6/Documentation/networking/irda.txt linux/Documentation/networking/irda.txt
--- linux-2.4.0-test11-pre6/Documentation/networking/irda.txt	Tue Sep  7 19:14:36 1999
+++ linux/Documentation/networking/irda.txt	Fri Nov 17 23:23:39 2000
@@ -1,10 +1,10 @@
 To use the IrDA protocols within Linux you will need to get a suitable copy
 of the IrDA Utilities. More detailed information about these and associated
-programs can be found on http://www.cs.uit.no/linux-irda/
+programs can be found on http://irda.sourceforge.net/
 
 For more information about how to use the IrDA protocol stack, see the
-IR-HOWTO (http://www.snafu.de/~wehe/IR-HOWTO.html) written by Werner Heuser
-<wehe@snafu.de>
+IR-HOWTO (http://www.mobilix.org/Infrared-HOWTO/Infrared-HOWTO.html) written by Werner Heuser
+<wehe@mobilix.org>
 
 There is an active mailing list for discussing Linux-IrDA matters called
 linux-irda. To subscribe to it, visit:
diff -urpN linux-2.4.0-test11-pre6/MAINTAINERS linux/MAINTAINERS
--- linux-2.4.0-test11-pre6/MAINTAINERS	Thu Nov 23 13:17:15 2000
+++ linux/MAINTAINERS	Fri Nov 17 23:25:14 2000
@@ -645,9 +645,9 @@ S:	Maintained
 
 IRDA SUBSYSTEM
 P:      Dag Brattli
-M:      Dag Brattli <dagb@cs.uit.no>
+M:      Dag Brattli <dag@brattli.net>
 L:      linux-irda@pasta.cs.uit.no
-W:      http://www.cs.uit.no/linux-irda/
+W:      http://irda.sourceforge.net/
 S:      Maintained
 
 ISAPNP
diff -urpN linux-2.4.0-test11-pre6/drivers/net/irda/irtty.c linux/drivers/net/irda/irtty.c
--- linux-2.4.0-test11-pre6/drivers/net/irda/irtty.c	Thu Nov 23 13:17:18 2000
+++ linux/drivers/net/irda/irtty.c	Sun Nov 19 20:41:00 2000
@@ -960,7 +960,7 @@ static int irtty_net_ioctl(struct net_de
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRTTY_MAGIC, return -1;);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
+	IRDA_DEBUG(3, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
 	
 	/* Disable interrupts & save flags */
 	save_flags(flags);
diff -urpN linux-2.4.0-test11-pre6/drivers/net/irda/nsc-ircc.c linux/drivers/net/irda/nsc-ircc.c
--- linux-2.4.0-test11-pre6/drivers/net/irda/nsc-ircc.c	Thu Nov 23 13:17:18 2000
+++ linux/drivers/net/irda/nsc-ircc.c	Wed Nov 22 23:01:34 2000
@@ -708,9 +708,12 @@ static int nsc_ircc_setup(chipio_t *info
 	switch_bank(iobase, BANK0);
 	
 	/* Set FIFO threshold to TX17, RX16, reset and enable FIFO's */
-	switch_bank(iobase, BANK0);	
+	switch_bank(iobase, BANK0);
 	outb(FCR_RXTH|FCR_TXTH|FCR_TXSR|FCR_RXSR|FCR_FIFO_EN, iobase+FCR);
-	
+
+	outb(0x03, iobase+LCR); 	/* 8 bit word length */
+	outb(MCR_SIR, iobase+MCR); 	/* Start at SIR-mode, also clears LSR*/
+
 	/* Set FIFO size to 32 */
 	switch_bank(iobase, BANK2);
 	outb(EXCR2_RFSIZ|EXCR2_TFSIZ, iobase+EXCR2);
@@ -723,7 +726,7 @@ static int nsc_ircc_setup(chipio_t *info
 	switch_bank(iobase, BANK6);
 	outb(0x20, iobase+0); /* Set 32 bits FIR CRC */
 	outb(0x0a, iobase+1); /* Set MIR pulse width */
-	outb(0x0d, iobase+2); /* Set SIR pulse width */
+	outb(0x0d, iobase+2); /* Set SIR pulse width to 1.6us */
 	outb(0x2a, iobase+4); /* Set beginning frag, and preamble length */
 
 	MESSAGE("%s, driver loaded (Dag Brattli)\n", driver_name);
@@ -804,8 +807,6 @@ static void nsc_ircc_init_dongle_interfa
 			   dongle_types[dongle_id]); 
 		break;
 	case 0x04: /* Sharp RY5HD01 */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not supported yet\n",
-			   dongle_types[dongle_id]); 
 		break;
 	case 0x05: /* Reserved, but this is what the Thinkpad reports */
 		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
@@ -892,8 +893,7 @@ static void nsc_ircc_change_dongle_speed
 			   dongle_types[dongle_id]); 
 		break;
 	case 0x04: /* Sharp RY5HD01 */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not supported yet\n",
-			   dongle_types[dongle_id]); 
+		break;
 	case 0x05: /* Reserved */
 		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
 			   dongle_types[dongle_id]); 
diff -urpN linux-2.4.0-test11-pre6/net/irda/ircomm/ircomm_core.c linux/net/irda/ircomm/ircomm_core.c
--- linux-2.4.0-test11-pre6/net/irda/ircomm/ircomm_core.c	Thu Nov 23 13:17:28 2000
+++ linux/net/irda/ircomm/ircomm_core.c	Sat Nov 18 10:23:46 2000
@@ -512,7 +512,7 @@ int ircomm_proc_read(char *buf, char **s
 #endif /* CONFIG_PROC_FS */
 
 #ifdef MODULE
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("IrCOMM protocol");
 
 int init_module(void) 
diff -urpN linux-2.4.0-test11-pre6/net/irda/ircomm/ircomm_tty.c linux/net/irda/ircomm/ircomm_tty.c
--- linux-2.4.0-test11-pre6/net/irda/ircomm/ircomm_tty.c	Thu Nov 23 13:17:28 2000
+++ linux/net/irda/ircomm/ircomm_tty.c	Sat Nov 18 10:17:52 2000
@@ -100,7 +100,11 @@ int __init ircomm_tty_init(void)
 	memset(&driver, 0, sizeof(struct tty_driver));
 	driver.magic           = TTY_DRIVER_MAGIC;
 	driver.driver_name     = "ircomm";
+#ifdef CONFIG_DEVFS_FS
+	driver.name            = "ircomm%d";
+#else
 	driver.name            = "ircomm";
+#endif
 	driver.major           = IRCOMM_TTY_MAJOR;
 	driver.minor_start     = IRCOMM_TTY_MINOR;
 	driver.num             = IRCOMM_TTY_PORTS;
diff -urpN linux-2.4.0-test11-pre6/net/irda/irlan/irlan_client_event.c linux/net/irda/irlan/irlan_client_event.c
--- linux-2.4.0-test11-pre6/net/irda/irlan/irlan_client_event.c	Thu Jan  6 23:46:18 2000
+++ linux/net/irda/irlan/irlan_client_event.c	Sun Nov 19 21:25:28 2000
@@ -108,11 +108,10 @@ static int irlan_client_state_idle(struc
 		self->client.iriap = iriap_open(LSAP_ANY, IAS_CLIENT, self,
 						irlan_client_get_value_confirm);
 		/* Get some values from peer IAS */
+		irlan_next_client_state(self, IRLAN_QUERY);
 		iriap_getvaluebyclass_request(self->client.iriap,
 					      self->saddr, self->daddr,
 					      "IrLAN", "IrDA:TinyTP:LsapSel");
-		
-		irlan_next_client_state(self, IRLAN_QUERY);
 		break;
 	case IRLAN_WATCHDOG_TIMEOUT:
 		IRDA_DEBUG(2, __FUNCTION__ "(), IRLAN_WATCHDOG_TIMEOUT\n");
diff -urpN linux-2.4.0-test11-pre6/net/irda/irlap_event.c linux/net/irda/irlap_event.c
--- linux-2.4.0-test11-pre6/net/irda/irlap_event.c	Thu Nov 23 13:17:29 2000
+++ linux/net/irda/irlap_event.c	Sun Nov 19 20:42:46 2000
@@ -4,10 +4,10 @@
  * Version:       0.9
  * Description:   IrLAP state machine implementation
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sat Aug 16 00:59:29 1997
  * Modified at:   Sat Dec 25 21:07:57 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>,
  *     Copyright (c) 1998      Thomas Davis <ratbert@radiks.net>
@@ -551,13 +551,15 @@ static int irlap_state_query(struct irla
 		 * since we want to work even with devices that violate the
 		 * timing requirements.
 		 */
-		if (irda_device_is_receiving(self->netdev)) {
-			IRDA_DEBUG(1, __FUNCTION__ 
+		if (irda_device_is_receiving(self->netdev) && !self->add_wait) {
+			IRDA_DEBUG(2, __FUNCTION__ 
 				   "(), device is slow to answer, "
 				   "waiting some more!\n");
 			irlap_start_slot_timer(self, MSECS_TO_JIFFIES(10));
+			self->add_wait = TRUE;
 			return ret;
 		}
+		self->add_wait = FALSE;
 
 		if (self->s < self->S) {
 			irlap_send_discovery_xid_frame(self, self->S, 
@@ -1324,9 +1326,7 @@ static int irlap_state_nrm_p(struct irla
 		 *  of receiving a frame (page 45, IrLAP). Check that
 		 *  we only do this once for each frame.
 		 */
-		if (irda_device_is_receiving(self->netdev) && 
-		    !self->add_wait) 
-		{
+		if (irda_device_is_receiving(self->netdev) && !self->add_wait) {
 			IRDA_DEBUG(1, "FINAL_TIMER_EXPIRED when receiving a "
 			      "frame! Waiting a little bit more!\n");
 			irlap_start_final_timer(self, MSECS_TO_JIFFIES(300));


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
