Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbUKHU7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbUKHU7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 15:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUKHU7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:59:16 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:18121 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S261167AbUKHUys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:54:48 -0500
Message-ID: <418FDD0A.5010308@akamai.com>
Date: Mon, 08 Nov 2004 12:54:34 -0800
From: peter swain <pswain@akamai.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>, andrews@gate.ort.spb.ru,
       scott.feldman@intel.com
Subject: [patch] e100 and shared interrupts [was: Spurious interrupts when
 SCI shared with e100]
References: <20041108115955.1c8bf10f.us15@os.inf.tu-dresden.de>
In-Reply-To: <20041108115955.1c8bf10f.us15@os.inf.tu-dresden.de>
Content-Type: multipart/mixed;
 boundary="------------040600090704020206000802"
X-OriginalArrivalTime: 08 Nov 2004 20:54:35.0062 (UTC) FILETIME=[2742ED60:01C4C5D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040600090704020206000802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Udo A. Steinberg wrote:

>My laptop has IRQ9 configured as ACPI SCI. When IRQ9 is shared between ACPI
>and e100 an IRQ9 storm occurs when e100 is enabled, as can be seen in the
>dmesg output below. The kernel then disables IRQ9, thus preventing e100 from
>working properly. The problem does not occur, if I override the default PCI
>steering in the BIOS, e.g. by routing LNKA to IRQ11.
>
>Nonetheless it would be good if someone could figure out why sharing IRQ9 
>is problematic.
>  
>
Udo, please try the attached 2.6.9 patch.

I suspect intel e100 driver always had problems with shared interrupts, 
due to a classic case of
"executable comment syndrome" in the original intel driver.
I noticed races on some of our ancient boxes with e100s, sharing 
interrupts with other e100s, or other cards.

The intel e100 v2.0.40 e100intr() code says.....
        intr_status = readw(&bdp->scb->scb_status);
        /* If not my interrupt, just return */
        if (!(intr_status & SCB_STATUS_ACK_MASK) || (intr_status == 
0xffff)) {
                return IRQ_NONE;
        }

But the test above is *not* "not my interrupt" but "no interesting 
conditions".
Both tests are needed for reliable operation in a shared-irq scenario.

When the driver is meddling with e100 setup, causing intr_status bits to 
pop up, but has not yet enabled
e100 interrupts, a "stray" interrupt from a device sharing the IRQ will 
cause e100intr() to walk all over the
device even if the driver is in a critical section.  Chaos ensues -- in 
my case duplicate skb_free calls when
a parasitic interrupt "completed" processing of tx ring skbs which napi 
bh was still setting up.

Compare with becker's eepro100, where there are (IIRC) 3 locks -- a lock 
on tx resources, a lock on rx resources, and an implicit lock by way of 
the card's interrupt-enable bit.  If you enable interrupts, you're
allowing the irq-handler to play with tx,rx resources without any other 
locks.  So a courteous irq-handler will
check to see if it has been granted the privilege, by inspecting the 
interrupt-enable bit.
Other drivers follow this model, but e100 driver merely has a misleading 
comment instead of the check.

I'd guess that Udo's problem appears when...
- e100 driver is meddling with card, with e100 interrupt enable *off*
- ACPI interrupt causes e100intr to be invoked parasitcally, cleaning up 
(or breaking) some half-finished
   work intended to be guarded by interrupt-enable bit
- driver enables e100 interrupt
- e100-driven IRQ calls e100intr(), finds no work to do
- (conjecture) 2.6.10-rc1 actually checks the IRQ_NONE return, notes 
spurious interrupt & disables IRQ

Our e100 problems went away on hundreds of old linux-2.4 dual-e100 boxes 
when the attached e100-v2-irq-share.patch was applied. It applies 
cleanly to linux-2.4.27, but is untested there.
I'd seen no lkml mention of shared-irq e100 problems, so was letting it 
bake for a couple of weeks before
declaring success, porting it to recent 2.6 and publishing.

But Udo has a problem, so let's see if this fixes it...
My linux-2.6.9 patch is an untested transliteration to intel's e100-v3 
driver structure.
(v3 driver has one e100.c, v2 has e100/*.c tree, cutover was about 
2.6.4? 5?)

I'm not sure if this is implicated in the widespread mistrust of e100 
multiport cards under linux, the e100-eepro100 wars, or the recent 
e100-suspend problems. Could be the missing piece in all.


^..^ feedback very welcome
(oo)




--------------040600090704020206000802
Content-Type: text/plain;
 name="e100-v2-irq-share.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e100-v2-irq-share.patch"

## add a module param own_irq=1 to forbid interrupt sharing
## add a check in e100intr for device interrupt masking -- if the driver has masked irqs off,
##  don't execute the usual irq service, but simply report the clash

--- Linux/drivers/net/e100/e100_main.c	Thu Oct 21 17:25:24 2004
+++ linux/drivers/net/e100/e100_main.c	Fri Oct 22 11:45:27 2004
@@ -424,6 +424,9 @@ E100_PARAM(BundleMax, "Maximum number fo
 E100_PARAM(IFS, "Disable or enable the adaptive IFS algorithm");
 E100_PARAM(weight, "rx packets processed per poll");
 
+int own_irq = 0; /* every card gets *own* IRQ? */
+MODULE_PARM(own_irq, "i");
+
 /**
  * e100_exec_cmd - issue a comand
  * @bdp: atapter's private data struct
@@ -1153,7 +1156,7 @@ e100_open(struct net_device *dev)
 		netif_start_queue(dev);
 
 	e100_start_ru(bdp);
-	if ((rc = request_irq(dev->irq, &e100intr, SA_SHIRQ,
+	if ((rc = request_irq(dev->irq, &e100intr, own_irq ? 0 : SA_SHIRQ,
 			      dev->name, dev)) != 0) {
 		del_timer_sync(&bdp->watchdog_timer);
 		goto err_exit;
@@ -2062,11 +2065,20 @@ e100intr(int irq, void *dev_inst, struct
 	dev = dev_inst;
 	bdp = dev->priv;
 
-	intr_status = readw(&bdp->scb->scb_status);
 	/* If not my interrupt, just return */
-	if (!(intr_status & SCB_STATUS_ACK_MASK) || (intr_status == 0xffff)) {
+	if (readb(&bdp->scb->scb_cmd_hi) & SCB_INT_MASK) {
+		static int once = 0;
+
+		if (!once)
+			printk(KERN_ERR "e100intr ignoring disabled interrupt, suspect irq-sharing\n");
+		once = 1;
 		return IRQ_NONE;
 	}
+
+	/* If no pending action, just return */
+	intr_status = readw(&bdp->scb->scb_status);
+	if (!(intr_status & SCB_STATUS_ACK_MASK) || (intr_status == 0xffff))
+		return IRQ_NONE;
 
 
 #ifdef CONFIG_E100_NAPI

--------------040600090704020206000802
Content-Type: text/plain;
 name="e100-linux-2.6.9-irq-sharing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e100-linux-2.6.9-irq-sharing.patch"

--- drivers/net/e100.c-pre-swine	Mon Nov  8 12:19:08 2004
+++ drivers/net/e100.c	Mon Nov  8 12:25:36 2004
@@ -1580,11 +1580,18 @@ static irqreturn_t e100_intr(int irq, vo
 {
 	struct net_device *netdev = dev_id;
 	struct nic *nic = netdev_priv(netdev);
-	u8 stat_ack = readb(&nic->csr->scb.stat_ack);
+	u8 stat_ack, cmd_hi;
 
+	cmd_hi = readb(&nic->csr->scb.cmd_hi);
+	DPRINTK(INTR, DEBUG, "cmd_hi = 0x%02X\n", cmd_hi);
+
+	if(cmd_hi & irq_mask_all)	/* Not our interrupt */
+		return IRQ_NONE;
+
+	stat_ack = readb(&nic->csr->scb.stat_ack);
 	DPRINTK(INTR, DEBUG, "stat_ack = 0x%02X\n", stat_ack);
 
-	if(stat_ack == stat_ack_not_ours ||	/* Not our interrupt */
+	if(stat_ack == stat_ack_not_ours ||	/* nothing to do */
 	   stat_ack == stat_ack_not_present)	/* Hardware is ejected */
 		return IRQ_NONE;
 

--------------040600090704020206000802--
