Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262219AbTCWBfO>; Sat, 22 Mar 2003 20:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbTCWBew>; Sat, 22 Mar 2003 20:34:52 -0500
Received: from dp.samba.org ([66.70.73.150]:38359 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262212AbTCWBdj>;
	Sat, 22 Mar 2003 20:33:39 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15997.4164.258276.444381@nanango.paulus.ozlabs.org>
Date: Sun, 23 Mar 2003 12:39:16 +1100 (EST)
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] update via-pmu driver
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch forward-ports various fixes to the driver for the PMU
(power manager unit) on powermacs and powerbooks from 2.4, and in
particular, some improvements to the battery charge calculations.
>From Ben Herrenschmidt.

Please apply.  This patch depends on the patch to include/linux/pmu.h
that I sent earlier.

Paul.

diff -urN linux-2.5/drivers/macintosh/via-pmu.c linuxppc-2.5/drivers/macintosh/via-pmu.c
--- linux-2.5/drivers/macintosh/via-pmu.c	2003-02-25 19:16:43.000000000 +1100
+++ linuxppc-2.5/drivers/macintosh/via-pmu.c	2003-02-25 19:22:53.000000000 +1100
@@ -33,6 +33,7 @@
 #include <linux/pm.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -343,10 +344,6 @@
 	} else
 		pmu_kind = PMU_UNKNOWN;
 
-#ifdef CONFIG_PMAC_PBOOK
-	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
-		can_sleep = 1;
-#endif /* CONFIG_PMAC_PBOOK */
 	via = (volatile unsigned char *) ioremap(vias->addrs->address, 0x2000);
 	
 	out_8(&via[IER], IER_CLR | 0x7f);	/* disable all intrs */
@@ -405,6 +402,8 @@
 	bright_req_3.complete = 1;
 #ifdef CONFIG_PMAC_PBOOK
 	batt_req.complete = 1;
+	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
+		can_sleep = 1;
 #endif
 
 	if (request_irq(vias->intrs[0].line, via_pmu_interrupt, 0, "VIA-PMU",
@@ -457,12 +456,20 @@
 
 #ifdef CONFIG_PMAC_PBOOK
   	if (machine_is_compatible("AAPL,3400/2400") ||
-  		machine_is_compatible("AAPL,3500"))
+  		machine_is_compatible("AAPL,3500")) {
+		int mb = pmac_call_feature(PMAC_FTR_GET_MB_INFO,
+			NULL, PMAC_MB_INFO_MODEL, 0);
 		pmu_battery_count = 1;
-	else if (machine_is_compatible("AAPL,PowerBook1998") ||
-		machine_is_compatible("PowerBook1,1"))
+		if (mb == PMAC_TYPE_COMET)
+			pmu_batteries[0].flags |= PMU_BATT_TYPE_COMET;
+		else
+			pmu_batteries[0].flags |= PMU_BATT_TYPE_HOOPER;
+	} else if (machine_is_compatible("AAPL,PowerBook1998") ||
+		machine_is_compatible("PowerBook1,1")) {
 		pmu_battery_count = 2;
-	else {
+		pmu_batteries[0].flags |= PMU_BATT_TYPE_SMART;
+		pmu_batteries[1].flags |= PMU_BATT_TYPE_SMART;
+	} else {
 		struct device_node* prim = find_devices("power-mgt");
 		u32 *prim_info = NULL;
 		if (prim)
@@ -470,6 +477,9 @@
 		if (prim_info) {
 			/* Other stuffs here yet unknown */
 			pmu_battery_count = (prim_info[6] >> 16) & 0xff;
+			pmu_batteries[0].flags |= PMU_BATT_TYPE_SMART;
+			if (pmu_battery_count > 1)
+				pmu_batteries[1].flags |= PMU_BATT_TYPE_SMART;
 		}
 	}
 #endif /* CONFIG_PMAC_PBOOK */
@@ -550,156 +560,30 @@
 	return 1;
 }
 
-int
+int __pmac
 pmu_get_model(void)
 {
 	return pmu_kind;
 }
 
-#ifdef CONFIG_PMAC_PBOOK
-
-/* 
- * WARNING ! This code probably needs some debugging... -- BenH.
- */
-#ifdef NEW_OHARE_CODE
-static void __pmac
-done_battery_state_ohare(struct adb_request* req)
+static inline void wakeup_decrementer(void)
 {
-	unsigned int bat_flags = 0;
-	int current = 0;
-	unsigned int capa, max, voltage, time;
-	int lrange[] = { 0, 275, 850, 1680, 2325, 
-				2765, 3160, 3500, 3830, 4115, 
-				4360, 4585, 4795, 4990, 5170, 
-				5340, 5510, 5710, 5930, 6150, 
-				6370, 6500
-				};
-	
-	if (req->reply[0] & 0x01)
-		pmu_power_flags |= PMU_PWR_AC_PRESENT;
-	else
-		pmu_power_flags &= ~PMU_PWR_AC_PRESENT;
+	set_dec(tb_ticks_per_jiffy);
+	/* No currently-supported powerbook has a 601,
+	 * so use get_tbl, not native
+	 */
+	last_jiffy_stamp(0) = tb_last_stamp = get_tbl();
+}
 
-	if (req->reply[0] & 0x04) {
-		int vb, i, j, k, charge, pcharge;
-		bat_flags |= PMU_BATT_PRESENT;
-		vb = (req->reply[1] << 8) | req->reply[2];
-		voltage = ((vb * 2650) + 726650)/100;
-		vb *= 100;
-		current = req->reply[5];
-		if ((req->reply[0] & 0x01) == 0 && (current > 200))
-			vb += (current - 200) * 15;
-		else if (req->reply[0] & 0x02)
-			vb = (vb - 2000);
-	  	i = (33000 - vb) / 10;
-	  	j = i - (i % 100);
-		k = j/100;
-		if (k <= 0)
-	       		charge = 0;
-		else if (k >= 21)
-	       		charge = 650000;
-	  	else
-			charge = (lrange[k + 1] - lrange[k]) * (i - j) + (lrange[k] * 100);
-		charge = (1000 - charge / 650) / 10;
-		if (req->reply[0] & 0x40) {
-			pcharge = (req->reply[6] << 8) + req->reply[7];
-			if (pcharge > 6500)
-				pcharge = 6500;
-			pcharge *= 100;
-			pcharge = (1000 - pcharge / 650) / 10;
-			if (pcharge < charge)
-				charge = pcharge;
-		}
-		capa = charge;
-		max = 100;
-		time = (charge * 16440) / current;
-		current = -current;
-		
-	} else
-		capa = max = current = voltage = time = 0;
 
-	if (req->reply[0] & 0x02)
-		bat_flags |= PMU_BATT_CHARGING;
+#ifdef CONFIG_PMAC_PBOOK
 
-	pmu_batteries[pmu_cur_battery].flags = bat_flags;
-	pmu_batteries[pmu_cur_battery].charge = capa;
-	pmu_batteries[pmu_cur_battery].max_charge = max;
-	pmu_batteries[pmu_cur_battery].current = current;
-	pmu_batteries[pmu_cur_battery].voltage = voltage;
-	pmu_batteries[pmu_cur_battery].time_remaining = time;
-}
-#else /* NEW_OHARE_CODE */
+/* This new version of the code for 2400/3400/3500 powerbooks
+ * is inspired from the implementation in gkrellm-pmu
+ */
 static void __pmac
 done_battery_state_ohare(struct adb_request* req)
 {
-	unsigned int bat_flags = 0;
-	int current = 0;
-	unsigned int capa, max, voltage, time;
-	int lrange[] = { 0, 275, 850, 1680, 2325, 
-				2765, 3160, 3500, 3830, 4115, 
-				4360, 4585, 4795, 4990, 5170, 
-				5340, 5510, 5710, 5930, 6150, 
-				6370, 6500
-				};
-	
-	if (req->reply[0] & 0x01)
-		pmu_power_flags |= PMU_PWR_AC_PRESENT;
-	else
-		pmu_power_flags &= ~PMU_PWR_AC_PRESENT;
-
-	if (req->reply[0] & 0x04) {
-		int vb, i, j, charge, pcharge;
-		bat_flags |= PMU_BATT_PRESENT;
-		vb = (req->reply[1] << 8) | req->reply[2];
-		voltage = ((vb * 2650) + 726650)/100;
-		current = *((signed char *)&req->reply[5]);
-		if ((req->reply[0] & 0x01) == 0 && (current > 200))
-			vb += (current - 200) * 15;
-		else if (req->reply[0] & 0x02)
-			vb = (vb - 10) * 100;
-	  	i = (33000 - vb) / 10;
-	  	j = i - (i % 100);
-	  	if (j <= 0)
-	       		charge = 0;
-	  	else if (j >= 21)
-	       		charge = 650000;
-	  	else
-			charge = (lrange[j + 1] - lrange[j]) * (i - j) + (lrange[j] * 100);
-		charge = (1000 - charge / 650) / 10;
-		if (req->reply[0] & 0x40) {
-			pcharge = (req->reply[6] << 8) + req->reply[7];
-			if (pcharge > 6500)
-				pcharge = 6500;
-			pcharge *= 100;
-			pcharge = (1000 - pcharge / 650) / 10;
-			if (pcharge < charge)
-				charge = pcharge;
-		}
-		capa = charge;
-		max = 100;
-		time = (charge * 274) / current;
-		current = -current;
-		
-	} else
-		capa = max = current = voltage = time = 0;
-
-	if ((req->reply[0] & 0x02) && (current > 0))
-		bat_flags |= PMU_BATT_CHARGING;
-	if (req->reply[0] & 0x04) /* CHECK THIS ONE */
-		bat_flags |= PMU_BATT_PRESENT;
-
-	pmu_batteries[pmu_cur_battery].flags = bat_flags;
-	pmu_batteries[pmu_cur_battery].charge = capa;
-	pmu_batteries[pmu_cur_battery].max_charge = max;
-	pmu_batteries[pmu_cur_battery].current = current;
-	pmu_batteries[pmu_cur_battery].voltage = voltage;
-	pmu_batteries[pmu_cur_battery].time_remaining = time;
-}
-#endif /* NEW_OHARE_CODE */
-
- static void __pmac
-done_battery_state_comet(struct adb_request* req)
-{
 	/* format:
 	 *  [0]    :  flags
 	 *    0x01 :  AC indicator
@@ -718,57 +602,62 @@
 	 *  [6][7] :  pcharge
 	 *              --tkoba
 	 */
+	unsigned int bat_flags = PMU_BATT_TYPE_HOOPER;
+	long pcharge, charge, vb, vmax, lmax;
+	long vmax_charging, vmax_charged;
+	long current, voltage, time, max;
+	int mb = pmac_call_feature(PMAC_FTR_GET_MB_INFO,
+			NULL, PMAC_MB_INFO_MODEL, 0);
 
-	unsigned int bat_flags = 0;
-	int current = 0;
-	unsigned int max = 100;
-	unsigned int charge, voltage, time;
-	int lrange[] = { 0, 600, 750, 900, 1000, 1080, 
-				1180, 1250, 1300, 1340, 1360, 
-				1390, 1420, 1440, 1470, 1490, 
-				1520, 1550, 1580, 1610, 1650, 
-				1700
-				};
-	
 	if (req->reply[0] & 0x01)
 		pmu_power_flags |= PMU_PWR_AC_PRESENT;
 	else
 		pmu_power_flags &= ~PMU_PWR_AC_PRESENT;
+	
+	if (mb == PMAC_TYPE_COMET) {
+		vmax_charged = 189;
+		vmax_charging = 213;
+		lmax = 6500;
+	} else {
+		vmax_charged = 330;
+		vmax_charging = 330;
+		lmax = 6500;
+	}
+	vmax = vmax_charged;
 
-	if (req->reply[0] & 0x04) {	/* battery exist */
-		int vb, i;
+	/* If battery installed */
+	if (req->reply[0] & 0x04) {
 		bat_flags |= PMU_BATT_PRESENT;
+		if (req->reply[0] & 0x02)
+			bat_flags |= PMU_BATT_CHARGING;
 		vb = (req->reply[1] << 8) | req->reply[2];
-		voltage = ((vb * 2650) + 726650)/100;
-		vb *= 10;
+		voltage = (vb * 265 + 72665) / 10;
 		current = req->reply[5];
-		if ((req->reply[0] & 0x01) == 0 && (current > 200))
-			vb += ((current - 200) * 3);	/* vb = 500<->1800 */
-		else if (req->reply[0] & 0x02)
-			vb = ((vb - 800) * 1700/13)/100;	/*  in charging vb = 1300<->2130 */
-
-		if (req->reply[0] & 0x20) {	/* full charged */
-			charge = max;
-		} else {
-			if (lrange[21] < vb)
-				charge = max;
-			else {
-				if (vb < lrange[1])
-					charge = 0;
-				else {
-					for (i=21; vb < lrange[i]; --i);
-					charge = (i * 100)/21;
-				}
-			}
-			if (charge > max) charge = max;
+		if ((req->reply[0] & 0x01) == 0) {
+			if (current > 200)
+				vb += ((current - 200) * 15)/100;
+		} else if (req->reply[0] & 0x02) {
+			vb = (vb * 97) / 100;
+			vmax = vmax_charging;
+		}
+		charge = (100 * vb) / vmax;
+		if (req->reply[0] & 0x40) {
+			pcharge = (req->reply[6] << 8) + req->reply[7];
+			if (pcharge > lmax)
+				pcharge = lmax;
+			pcharge *= 100;
+			pcharge = 100 - pcharge / lmax;
+			if (pcharge < charge)
+				charge = pcharge;
 		}
-		time = (charge * 72);
+		if (current > 0)
+			time = (charge * 16440) / current;
+		else
+			time = 0;
+		max = 100;
 		current = -current;
 	} else
-		max = current = voltage = time = 0;
-
-	if (req->reply[0] & 0x02)
-		bat_flags |= PMU_BATT_CHARGING;
+		charge = max = current = voltage = time = 0;
 
 	pmu_batteries[pmu_cur_battery].flags = bat_flags;
 	pmu_batteries[pmu_cur_battery].charge = charge;
@@ -800,7 +689,7 @@
 	 *  [8][9] : voltage
 	 */
 	 
-	unsigned int bat_flags = 0;
+	unsigned int bat_flags = PMU_BATT_TYPE_SMART;
 	int current;
 	unsigned int capa, max, voltage;
 	
@@ -858,24 +747,17 @@
 {
 	if (!batt_req.complete)
 		return;
-	if (pmu_kind == PMU_OHARE_BASED) {
-		int mb = pmac_call_feature(PMAC_FTR_GET_MB_INFO,
-			NULL, PMAC_MB_INFO_MODEL, 0);
-
-		if (mb == PMAC_TYPE_COMET)
-			pmu_request(&batt_req, done_battery_state_comet,
-				1, PMU_BATTERY_STATE);
-		else
-			pmu_request(&batt_req, done_battery_state_ohare,
-				1, PMU_BATTERY_STATE);
-	} else
+	if (pmu_kind == PMU_OHARE_BASED)
+		pmu_request(&batt_req, done_battery_state_ohare,
+			1, PMU_BATTERY_STATE);
+	else
 		pmu_request(&batt_req, done_battery_state_smart,
 			2, PMU_SMART_BATTERY_STATE, pmu_cur_battery+1);
 }
 
 #endif /* CONFIG_PMAC_PBOOK */
 
-static int
+static int __pmac
 proc_get_info(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
 {
@@ -893,7 +775,7 @@
 }
 
 #ifdef CONFIG_PMAC_PBOOK
-static int
+static int __pmac
 proc_get_batt(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
 {
@@ -918,7 +800,7 @@
 }
 #endif /* CONFIG_PMAC_PBOOK */
 
-static int
+static int __pmac
 proc_read_options(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
@@ -932,7 +814,7 @@
 	return p - page;
 }
 			
-static int
+static int __pmac
 proc_write_options(struct file *file, const char *buffer,
 			unsigned long count, void *data)
 {
@@ -972,7 +854,7 @@
 
 #ifdef CONFIG_ADB
 /* Send an ADB command */
-static int __openfirmware
+static int __pmac
 pmu_send_request(struct adb_request *req, int sync)
 {
 	int i, ret;
@@ -1052,7 +934,7 @@
 }
 
 /* Enable/disable autopolling */
-static int __openfirmware
+static int __pmac
 pmu_adb_autopoll(int devs)
 {
 	struct adb_request req;
@@ -1075,7 +957,7 @@
 }
 
 /* Reset the ADB bus */
-static int __openfirmware
+static int __pmac
 pmu_adb_reset_bus(void)
 {
 	struct adb_request req;
@@ -1137,7 +1019,7 @@
 	return pmu_queue_request(req);
 }
 
-int __openfirmware
+int __pmac
 pmu_queue_request(struct adb_request *req)
 {
 	unsigned long flags;
@@ -1229,7 +1111,7 @@
 		(*done)(req);
 }
 
-static void __openfirmware
+static void __pmac
 pmu_start()
 {
 	struct adb_request *req;
@@ -1342,7 +1224,7 @@
 }
 
 /* Interrupt data could be the result data from an ADB cmd */
-static void __openfirmware
+static void __pmac
 pmu_handle_data(unsigned char *data, int len, struct pt_regs *regs)
 {
 	asleep = 0;
@@ -1417,7 +1299,7 @@
 	}
 }
 
-static struct adb_request* __openfirmware
+static struct adb_request* __pmac
 pmu_sr_intr(struct pt_regs *regs)
 {
 	struct adb_request *req;
@@ -1511,7 +1393,7 @@
 	return NULL;
 }
 
-static void __openfirmware
+static void __pmac
 via_pmu_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
 	unsigned long flags;
@@ -1561,10 +1443,10 @@
 			wait_for_ack();
 			send_byte(PMU_INT_ACK);
 			adb_int_pending = 0;
-no_free_slot:			
 		} else if (current_req)
 			pmu_start();
 	}
+no_free_slot:			
 	/* Mark the oldest buffer for flushing */
 	if (int_data_state[!int_data_last] == int_data_ready) {
 		int_data_state[!int_data_last] = int_data_flush;
@@ -1593,7 +1475,7 @@
 	}
 }
 
-static void __openfirmware
+static void __pmac
 gpio1_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
 	if ((in_8(gpio_reg + 0x9) & 0x02) == 0) {
@@ -1603,7 +1485,7 @@
 }
 
 #ifdef CONFIG_PMAC_BACKLIGHT
-static int backlight_to_bright[] = {
+static int backlight_to_bright[] __pmacdata = {
 	0x7f, 0x46, 0x42, 0x3e, 0x3a, 0x36, 0x32, 0x2e,
 	0x2a, 0x26, 0x22, 0x1e, 0x1a, 0x16, 0x12, 0x0e
 };
@@ -1649,7 +1531,7 @@
 }
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
-void __openfirmware
+void __pmac
 pmu_enable_irled(int on)
 {
 	struct adb_request req;
@@ -1665,7 +1547,7 @@
 		pmu_poll();
 }
 
-void __openfirmware
+void __pmac
 pmu_restart(void)
 {
 	struct adb_request req;
@@ -1688,7 +1570,7 @@
 		;
 }
 
-void __openfirmware
+void __pmac
 pmu_shutdown(void)
 {
 	struct adb_request req;
@@ -1723,7 +1605,7 @@
 static LIST_HEAD(sleep_notifiers);
 
 #ifdef CONFIG_PM
-static int
+static int __pmac
 generic_notify_sleep(struct pmu_sleep_notifier *self, int when)
 {
 	switch (when) {
@@ -1765,7 +1647,7 @@
 }
 
 /* Sleep is broadcast last-to-first */
-static int
+static int __pmac
 broadcast_sleep(int when, int fallback)
 {
 	int ret = PBOOK_SLEEP_OK;
@@ -1790,7 +1672,7 @@
 }
 
 /* Wake is broadcast first-to-last */
-static int
+static int __pmac
 broadcast_wake(void)
 {
 	int ret = PBOOK_SLEEP_OK;
@@ -1821,7 +1703,7 @@
 } *pbook_pci_saves;
 static int pbook_npci_saves;
 
-static void __openfirmware
+static void __pmac
 pbook_alloc_pci_save(void)
 {
 	int npci;
@@ -1838,7 +1720,7 @@
 	pbook_npci_saves = npci;
 }
 
-static void __openfirmware
+static void __pmac
 pbook_free_pci_save(void)
 {
 	if (pbook_pci_saves == NULL)
@@ -1848,7 +1730,7 @@
 	pbook_npci_saves = 0;
 }
 
-static void __openfirmware
+static void __pmac
 pbook_pci_save(void)
 {
 	struct pci_save *ps = pbook_pci_saves;
@@ -1879,7 +1761,7 @@
  * during boot, it will be in the pci dev list. If it's disabled at this point
  * (and it will probably be), then you can't access it's config space.
  */
-static void __openfirmware
+static void __pmac
 pbook_pci_restore(void)
 {
 	u16 cmd;
@@ -1927,7 +1809,7 @@
 
 #ifdef DEBUG_SLEEP
 /* N.B. This doesn't work on the 3400 */
-void
+void  __pmac
 pmu_blink(int n)
 {
 	struct adb_request req;
@@ -1966,8 +1848,10 @@
  * Put the powerbook to sleep.
  */
  
-static u32 save_via[8];
-static void save_via_state(void)
+static u32 save_via[8] __pmacdata;
+
+static void __pmac
+save_via_state(void)
 {
 	save_via[0] = in_8(&via[ANH]);
 	save_via[1] = in_8(&via[DIRA]);
@@ -1978,7 +1862,8 @@
 	save_via[6] = in_8(&via[T1CL]);
 	save_via[7] = in_8(&via[T1CH]);
 }
-static void restore_via_state(void)
+static void __pmac
+restore_via_state(void)
 {
 	out_8(&via[ANH], save_via[0]);
 	out_8(&via[DIRA], save_via[1]);
@@ -1993,15 +1878,6 @@
 	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
 }
 
-static inline void wakeup_decrementer(void)
-{
-	set_dec(tb_ticks_per_jiffy);
-	/* No currently-supported powerbook has a 601,
-	 * so use get_tbl, not native
-	 */
-	last_jiffy_stamp(0) = tb_last_stamp = get_tbl();
-}
-
 extern int sys_sync(void);
 
 #define	GRACKLE_PM	(1<<7)
@@ -2009,7 +1885,8 @@
 #define	GRACKLE_NAP	(1<<4)
 #define	GRACKLE_SLEEP	(1<<3)
 
-int __openfirmware powerbook_sleep_G3(void)
+int __pmac
+powerbook_sleep_G3(void)
 {
 	unsigned long save_l2cr;
 	unsigned short pmcr1;
@@ -2152,7 +2029,8 @@
 	return 0;
 }
 
-int __openfirmware powerbook_sleep_Core99(void)
+static int __pmac
+powerbook_sleep_Core99(void)
 {
 	unsigned long save_l2cr;
 	unsigned long save_l3cr;
@@ -2322,7 +2200,8 @@
 #define PB3400_MEM_CTRL		0xf8000000
 #define PB3400_MEM_CTRL_SLEEP	0x70
 
-int __openfirmware powerbook_sleep_3400(void)
+static int __pmac
+powerbook_sleep_3400(void)
 {
 	int ret, i, x;
 	unsigned int hid0;
@@ -2463,9 +2342,10 @@
 };
 
 static LIST_HEAD(all_pmu_pvt);
-static spinlock_t all_pvt_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t all_pvt_lock __pmacdata = SPIN_LOCK_UNLOCKED;
 
-static void pmu_pass_intr(unsigned char *data, int len)
+static void __pmac
+pmu_pass_intr(unsigned char *data, int len)
 {
 	struct pmu_private *pp;
 	struct list_head *list;
@@ -2493,7 +2373,8 @@
 	spin_unlock_irqrestore(&all_pvt_lock, flags);
 }
 
-static int __openfirmware pmu_open(struct inode *inode, struct file *file)
+static int __pmac
+pmu_open(struct inode *inode, struct file *file)
 {
 	struct pmu_private *pp;
 	unsigned long flags;
@@ -2514,7 +2395,8 @@
 	return 0;
 }
 
-static ssize_t __openfirmware pmu_read(struct file *file, char *buf,
+static ssize_t  __pmac
+pmu_read(struct file *file, char *buf,
 			size_t count, loff_t *ppos)
 {
 	struct pmu_private *pp = file->private_data;
@@ -2566,13 +2448,15 @@
 	return ret;
 }
 
-static ssize_t __openfirmware pmu_write(struct file *file, const char *buf,
+static ssize_t __pmac
+pmu_write(struct file *file, const char *buf,
 			 size_t count, loff_t *ppos)
 {
 	return 0;
 }
 
-static unsigned int pmu_fpoll(struct file *filp, poll_table *wait)
+static unsigned int __pmac
+pmu_fpoll(struct file *filp, poll_table *wait)
 {
 	struct pmu_private *pp = filp->private_data;
 	unsigned int mask = 0;
@@ -2588,7 +2472,8 @@
 	return mask;
 }
 
-static int pmu_release(struct inode *inode, struct file *file)
+static int __pmac
+pmu_release(struct inode *inode, struct file *file)
 {
 	struct pmu_private *pp = file->private_data;
 	unsigned long flags;
@@ -2613,7 +2498,8 @@
 }
 
 /* Note: removed __openfirmware here since it causes link errors */
-static int pmu_ioctl(struct inode * inode, struct file *filp,
+static int __pmac
+pmu_ioctl(struct inode * inode, struct file *filp,
 		     u_int cmd, u_long arg)
 {
 	struct pmu_private *pp = filp->private_data;
@@ -2687,7 +2573,7 @@
 	return -EINVAL;
 }
 
-static struct file_operations pmu_device_fops = {
+static struct file_operations pmu_device_fops __pmacdata = {
 	.read		= pmu_read,
 	.write		= pmu_write,
 	.poll		= pmu_fpoll,
@@ -2696,7 +2582,7 @@
 	.release	= pmu_release,
 };
 
-static struct miscdevice pmu_device = {
+static struct miscdevice pmu_device __pmacdata = {
 	PMU_MINOR, "pmu", &pmu_device_fops
 };
 
@@ -2710,7 +2596,8 @@
 #endif /* CONFIG_PMAC_PBOOK */
 
 #ifdef DEBUG_SLEEP
-static inline void polled_handshake(volatile unsigned char *via)
+static inline void  __pmac
+polled_handshake(volatile unsigned char *via)
 {
 	via[B] &= ~TREQ; eieio();
 	while ((via[B] & TACK) != 0)
@@ -2720,14 +2607,16 @@
 		;
 }
 
-static inline void polled_send_byte(volatile unsigned char *via, int x)
+static inline void  __pmac
+polled_send_byte(volatile unsigned char *via, int x)
 {
 	via[ACR] |= SR_OUT | SR_EXT; eieio();
 	via[SR] = x; eieio();
 	polled_handshake(via);
 }
 
-static inline int polled_recv_byte(volatile unsigned char *via)
+static inline int __pmac
+polled_recv_byte(volatile unsigned char *via)
 {
 	int x;
 
@@ -2738,7 +2627,7 @@
 	return x;
 }
 
-int
+int __pmac
 pmu_polled_request(struct adb_request *req)
 {
 	unsigned long flags;
