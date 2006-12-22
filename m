Return-Path: <linux-kernel-owner+w=401wt.eu-S1751564AbWLVRag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWLVRag (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWLVRae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:30:34 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:64393 "EHLO
	mtiwmhc12.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751417AbWLVRab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:30:31 -0500
Message-ID: <458C1633.1040606@lwfinger.net>
Date: Fri, 22 Dec 2006 11:30:27 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: LKML <linux-kernel@vger.kernel.org>,
       bcm43xx devel <Bcm43xx-dev@lists.berlios.de>,
       netdev <netdev@vger.kernel.org>
Subject: bcm43xx from 2.6.20-rc1-mm1 on HPC nx6325 (x86_64)
Content-Type: multipart/mixed;
 boundary="------------050005090701040404010308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050005090701040404010308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm trying to make the bcm43xx driver out of the 2.6.20-rc1-mm1 kernel work on
an HPC nx6325, with no luck, so far, although I'm using a firmware that has
been reported to work with these boxes
(http://gentoo-wiki.com/HARDWARE_Gentoo_on_HP_Compaq_nx6325#Onboard_Wireless_.28802.11.29).

The driver loads and seems to operate the hardware to some extent, but there
seems to be a problem with interrupts. Namely, the chip doesn't seem to
generate any.
Raphael J. Wysocki wrote:

 > Right after a fresh 'modprobe bcm43xx' I get the following messages in dmesg:

 > bcm43xx driver
 > ACPI: PCI Interrupt 0000:30:00.0[A] -> GSI 18 (level, low) -> IRQ 18
 > PCI: Setting latency timer of device 0000:30:00.0 to 64
 > bcm43xx: Chip ID 0x4311, rev 0x1
 > bcm43xx: Number of cores: 4
 > bcm43xx: Core 0: ID 0x800, rev 0x11, vendor 0x4243
 > bcm43xx: Core 1: ID 0x812, rev 0xa, vendor 0x4243
 > bcm43xx: Core 2: ID 0x817, rev 0x3, vendor 0x4243
 > bcm43xx: Core 3: ID 0x820, rev 0x1, vendor 0x4243
 > bcm43xx: PHY connected
 > bcm43xx: Detected PHY: Version: 4, Type 2, Revision 8
 > bcm43xx: Detected Radio: ID: 2205017f (Manuf: 17f Ver: 2050 Rev: 2)
 > bcm43xx: Radio turned off
 > bcm43xx: Radio turned off
 > PM: Adding info for No Bus:eth1
 > printk: 3 messages suppressed.
 > SoftMAC: ASSERTION FAILED (0) at: > 
net/ieee80211/softmac/ieee80211softmac_wx.c:306:ieee80211softmac_wx_get_rate()
 >
 > but, strangely enough, eth1 does not appear, but eth2 appears instead:
 >

Usually the problem generates an oops, but I think your problem is due to the changes in the work 
struct in 2.6.20-rc1. There is a fix in the pipeline, but it has not propagated through the system.

You should apply the work_struct2 patch attached. If your computer has a switch to kill the RF, you 
may also wish to apply the radio_hwenable patch, which should cause the radio LED to be turned on.

The selection of eth2 rather than eth1 is probably due to the rules in 
/etc/udev/rules.d/30-net_persistent_names.rules. When I boot a softmac version, my bcm43xx device is 
wlan0, but when I boot the d80211 version, it is eth1. I have a second bcm43xx card, which becomes 
eth2 under softmac.

Larry

--------------050005090701040404010308
Content-Type: text/plain;
 name="work_struct2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="work_struct2"

From: Ulrich Kunitz <kune@deine-taler.de>

The signature of work functions changed recently from a context
pointer to the work structure pointer. This caused a problem in
the ieee80211softmac code, because the ieee80211softmac_assox_work
function has  been called directly with a parameter explicitly
casted to (void*). This compiled correctly but resulted in a
softlock, because mutex_lock was called with the wrong memory
address. The patch fixes the problem. Another issue was a wrong
call of the schedule_work function. Softmac works again and this
fixes the problem I mentioned earlier in the zd1211rw rx tasklet
patch. The patch is against Linus' tree (commit af1713e0).

Signed-off-by: Ulrich Kunitz <kune@deine-taler.de>
Acked-by: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---

John,

This patch should be pushed upstream to 2.6.20. At the moment, the work
struct changes have not yet propagated to wireless-2.6. When they do,
it will be needed there as well.

Larry

 net/ieee80211/softmac/ieee80211softmac_assoc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ieee80211/softmac/ieee80211softmac_assoc.c b/net/ieee80211/softmac/ieee80211softmac_assoc.c
index eec1a1d..a824852 100644
--- a/net/ieee80211/softmac/ieee80211softmac_assoc.c
+++ b/net/ieee80211/softmac/ieee80211softmac_assoc.c
@@ -167,7 +167,7 @@ static void
 ieee80211softmac_assoc_notify_scan(struct net_device *dev, int event_type, void *context)
 {
 	struct ieee80211softmac_device *mac = ieee80211_priv(dev);
-	ieee80211softmac_assoc_work((void*)mac);
+	ieee80211softmac_assoc_work(&mac->associnfo.work.work);
 }
 
 static void
@@ -177,7 +177,7 @@ ieee80211softmac_assoc_notify_auth(struc
 
 	switch (event_type) {
 	case IEEE80211SOFTMAC_EVENT_AUTHENTICATED:
-		ieee80211softmac_assoc_work((void*)mac);
+		ieee80211softmac_assoc_work(&mac->associnfo.work.work);
 		break;
 	case IEEE80211SOFTMAC_EVENT_AUTH_FAILED:
 	case IEEE80211SOFTMAC_EVENT_AUTH_TIMEOUT:


--------------050005090701040404010308
Content-Type: text/plain;
 name="radio_hwenable"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radio_hwenable"

Index: linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -2441,6 +2441,9 @@ static int bcm43xx_chip_init(struct bcm4
 	if (err)
 		goto err_gpio_cleanup;
 	bcm43xx_radio_turn_on(bcm);
+	bcm->radio_hw_enable = bcm43xx_is_hw_radio_enabled(bcm);
+	printk(KERN_INFO PFX "Radio %s by hardware\n",
+		(bcm->radio_hw_enable == 0) ? "disabled" : "enabled");
 
 	bcm43xx_write16(bcm, 0x03E6, 0x0000);
 	err = bcm43xx_phy_init(bcm);
@@ -3172,9 +3175,24 @@ static void bcm43xx_periodic_every30sec(
 
 static void bcm43xx_periodic_every15sec(struct bcm43xx_private *bcm)
 {
+	bcm43xx_phy_xmitpower(bcm); //FIXME: unless scanning?
+	//TODO for APHY (temperature?)
+}
+
+static void bcm43xx_periodic_every1sec(struct bcm43xx_private *bcm)
+{
 	struct bcm43xx_phyinfo *phy = bcm43xx_current_phy(bcm);
 	struct bcm43xx_radioinfo *radio = bcm43xx_current_radio(bcm);
+	int radio_hw_enable;
 
+	/* check if radio hardware enabled status changed */
+	radio_hw_enable = bcm43xx_is_hw_radio_enabled(bcm);
+	if (unlikely(bcm->radio_hw_enable != radio_hw_enable)) {
+		bcm->radio_hw_enable = radio_hw_enable;
+		printk(KERN_INFO PFX "Radio hardware status changed to %s\n",
+		       (radio_hw_enable == 0) ? "disabled" : "enabled");
+
+	}
 	if (phy->type == BCM43xx_PHYTYPE_G) {
 		//TODO: update_aci_moving_average
 		if (radio->aci_enable && radio->aci_wlan_automatic) {
@@ -3198,21 +3216,21 @@ static void bcm43xx_periodic_every15sec(
 			//TODO: implement rev1 workaround
 		}
 	}
-	bcm43xx_phy_xmitpower(bcm); //FIXME: unless scanning?
-	//TODO for APHY (temperature?)
 }
 
 static void do_periodic_work(struct bcm43xx_private *bcm)
 {
-	if (bcm->periodic_state % 8 == 0)
+	if (bcm->periodic_state % 120 == 0)
 		bcm43xx_periodic_every120sec(bcm);
-	if (bcm->periodic_state % 4 == 0)
+	if (bcm->periodic_state % 60 == 0)
 		bcm43xx_periodic_every60sec(bcm);
-	if (bcm->periodic_state % 2 == 0)
+	if (bcm->periodic_state % 30 == 0)
 		bcm43xx_periodic_every30sec(bcm);
-	bcm43xx_periodic_every15sec(bcm);
+	if (bcm->periodic_state % 15 == 0)
+		bcm43xx_periodic_every15sec(bcm);
+	bcm43xx_periodic_every1sec(bcm);
 
-	schedule_delayed_work(&bcm->periodic_work, HZ * 15);
+	schedule_delayed_work(&bcm->periodic_work, HZ);
 }
 
 static void bcm43xx_periodic_work_handler(struct work_struct *work)
@@ -3225,7 +3243,7 @@ static void bcm43xx_periodic_work_handle
 	unsigned long orig_trans_start = 0;
 
 	mutex_lock(&bcm->mutex);
-	if (unlikely(bcm->periodic_state % 4 == 0)) {
+	if (unlikely(bcm->periodic_state % 60 == 0)) {
 		/* Periodic work will take a long time, so we want it to
 		 * be preemtible.
 		 */
@@ -3257,7 +3275,7 @@ static void bcm43xx_periodic_work_handle
 
 	do_periodic_work(bcm);
 
-	if (unlikely(bcm->periodic_state % 4 == 0)) {
+	if (unlikely(bcm->periodic_state % 60 == 0)) {
 		spin_lock_irqsave(&bcm->irq_lock, flags);
 		tasklet_enable(&bcm->isr_tasklet);
 		bcm43xx_interrupt_enable(bcm, savedirqs);
Index: linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_radio.h
===================================================================
--- linux-2.6.orig/drivers/net/wireless/bcm43xx/bcm43xx_radio.h
+++ linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_radio.h
@@ -65,6 +65,22 @@ void bcm43xx_radio_init2060(struct bcm43
 void bcm43xx_radio_turn_on(struct bcm43xx_private *bcm);
 void bcm43xx_radio_turn_off(struct bcm43xx_private *bcm);
 
+static inline
+int bcm43xx_is_hw_radio_enabled(struct bcm43xx_private *bcm)
+{
+	/* function to return state of hardware enable of radio
+	 * returns 0 if radio disabled, 1 if radio enabled
+	 */
+	if (likely(bcm->current_core->rev >= 3))
+		return ((bcm43xx_read32(bcm, BCM43xx_MMIO_RADIO_HWENABLED_HI)
+					& BCM43xx_MMIO_RADIO_HWENABLED_HI_MASK)
+					== 0) ? 1 : 0;
+	else
+		return ((bcm43xx_read16(bcm, BCM43xx_MMIO_RADIO_HWENABLED_LO)
+					& BCM43xx_MMIO_RADIO_HWENABLED_LO_MASK)
+					== 0) ? 0 : 1;
+}
+
 int bcm43xx_radio_selectchannel(struct bcm43xx_private *bcm, u8 channel,
 				int synthetic_pu_workaround);
 
Index: linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx.h
===================================================================
--- linux-2.6.orig/drivers/net/wireless/bcm43xx/bcm43xx.h
+++ linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx.h
@@ -352,6 +352,10 @@
 #define BCM43xx_UCODEFLAG_UNKPACTRL	0x0040
 #define BCM43xx_UCODEFLAG_JAPAN		0x0080
 
+/* Hardware Radio Enable masks */
+#define BCM43xx_MMIO_RADIO_HWENABLED_HI_MASK (1 << 16)
+#define BCM43xx_MMIO_RADIO_HWENABLED_LO_MASK (1 << 4)
+
 /* Generic-Interrupt reasons. */
 #define BCM43xx_IRQ_READY		(1 << 0)
 #define BCM43xx_IRQ_BEACON		(1 << 1)
@@ -758,7 +762,8 @@ struct bcm43xx_private {
 	    bad_frames_preempt:1,	/* Use "Bad Frames Preemption" (default off) */
 	    reg124_set_0x4:1,		/* Some variable to keep track of IRQ stuff. */
 	    short_preamble:1,		/* TRUE, if short preamble is enabled. */
-	    firmware_norelease:1;	/* Do not release the firmware. Used on suspend. */
+	    firmware_norelease:1,	/* Do not release the firmware. Used on suspend. */
+	    radio_hw_enable:1;		/* TRUE if radio is hardware enabled */
 
 	struct bcm43xx_stats stats;
 
Index: linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_leds.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/bcm43xx/bcm43xx_leds.c
+++ linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_leds.c
@@ -108,6 +108,7 @@ static void bcm43xx_led_init_hardcoded(s
 	switch (led_index) {
 	case 0:
 		led->behaviour = BCM43xx_LED_ACTIVITY;
+		led->activelow = 1;
 		if (bcm->board_vendor == PCI_VENDOR_ID_COMPAQ)
 			led->behaviour = BCM43xx_LED_RADIO_ALL;
 		break;

--------------050005090701040404010308--
