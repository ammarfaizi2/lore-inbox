Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSEVLLq>; Wed, 22 May 2002 07:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSEVLLp>; Wed, 22 May 2002 07:11:45 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:2735 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S310835AbSEVLLj>;
	Wed, 22 May 2002 07:11:39 -0400
Date: Wed, 22 May 2002 13:11:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] duplicate clock calculation code in 3 IDE drivers
Message-ID: <20020522131100.A32147@ucw.cz>
In-Reply-To: <20020522093013.GD312@pazke.ipt> <20020522114206.D31145@ucw.cz> <3CEB59E2.7020307@evision-ventures.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2002 at 10:42:10AM +0200, Martin Dalecki wrote:
> Uz.ytkownik Vojtech Pavlik napisa?:
> > On Wed, May 22, 2002 at 01:30:13PM +0400, Andrey Panin wrote:
> > 
> >>Hi,
> >>
> >>now it is more interesting patch. AMD, PIIX and VIA IDE drivers contain
> >>some duplicated code for (amd|piix|via)_clock calculation. Attached
> >>patch moves this code into one function in ata-timing.c file.
> >>
> >>Please take a look at it.
> > 
> > 
> > Looks quite OK - though it'd be better if "system_bus_speed" already
> > could be giving these reasonable values - this way we could get rid of
> > the (amd|piix|via)_clock variables altogether.
> 
> 
> Yes indeed this would be the "kings road".
> 
> Any one of you who cares enough?

Here you go ...

-- 
Vojtech Pavlik
SuSE Labs

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="system_bus_clock.diff"

ChangeSet@1.584, 2002-05-22 13:05:17+02:00, vojtech@twilight.ucw.cz
  In the last cset I removed the *_clock variables, but due to
  just search-replace the definitions stayed. This removes them.

ChangeSet@1.583, 2002-05-22 13:00:03+02:00, vojtech@twilight.ucw.cz
  This cset changes system_bus_speed to kHz, because the additional precisioin
  is needed for UDMA133 timing computations. It can also move the triplicated sanity
  checking and MHz->kHz converting code from the drivers to the common code as a result.

 aec62xx.c   |    4 ++--
 ali14xx.c   |    4 ++--
 alim15x3.c  |    8 ++++----
 amd74xx.c   |   45 +++++++++++++--------------------------------
 cmd640.c    |    2 +-
 cmd64x.c    |    2 +-
 cy82c693.c  |    2 +-
 ht6560b.c   |    4 ++--
 ide.c       |   56 ++++++++++++++++++++++++++++++++------------------------
 opti621.c   |    2 +-
 piix.c      |   43 ++++++++++++-------------------------------
 qd65xx.c    |   14 +++++++-------
 via82cxxx.c |   53 +++++++++++++++++------------------------------------
 13 files changed, 95 insertions(+), 144 deletions(-)

diff -Nru a/drivers/ide/aec62xx.c b/drivers/ide/aec62xx.c
--- a/drivers/ide/aec62xx.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/aec62xx.c	Wed May 22 13:09:12 2002
@@ -206,7 +206,7 @@
 {
 	for ( ; chipset_table->xfer_speed ; chipset_table++)
 		if (chipset_table->xfer_speed == speed) {
-			return ((byte) ((system_bus_speed <= 33) ? chipset_table->chipset_settings_33 : chipset_table->chipset_settings_34));
+			return ((byte) ((system_bus_speed <= 33333) ? chipset_table->chipset_settings_33 : chipset_table->chipset_settings_34));
 		}
 	return 0x00;
 }
@@ -215,7 +215,7 @@
 {
 	for ( ; chipset_table->xfer_speed ; chipset_table++)
 		if (chipset_table->xfer_speed == speed) {
-			return ((byte) ((system_bus_speed <= 33) ? chipset_table->ultra_settings_33 : chipset_table->ultra_settings_34));
+			return ((byte) ((system_bus_speed <= 33333) ? chipset_table->ultra_settings_33 : chipset_table->ultra_settings_34));
 		}
 	return 0x00;
 }
diff -Nru a/drivers/ide/ali14xx.c b/drivers/ide/ali14xx.c
--- a/drivers/ide/ali14xx.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/ali14xx.c	Wed May 22 13:09:12 2002
@@ -124,8 +124,8 @@
 	/* calculate timing, according to PIO mode */
 	time1 = t->cycle;
 	time2 = t->active;
-	param3 = param1 = (time2 * system_bus_speed + 999) / 1000;
-	param4 = param2 = (time1 * system_bus_speed + 999) / 1000 - param1;
+	param3 = param1 = (time2 * system_bus_speed + 999999) / 1000000;
+	param4 = param2 = (time1 * system_bus_speed + 999999) / 1000000 - param1;
 	if (pio < XFER_PIO_3) {
 		param3 += 8;
 		param4 += 8;
diff -Nru a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
--- a/drivers/ide/alim15x3.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/alim15x3.c	Wed May 22 13:09:12 2002
@@ -261,18 +261,18 @@
 
 	s_time = t->setup;
 	a_time = t->active;
-	if ((s_clc = (s_time * system_bus_speed + 999) / 1000) >= 8)
+	if ((s_clc = (s_time * system_bus_speed + 999999) / 1000000) >= 8)
 		s_clc = 0;
-	if ((a_clc = (a_time * system_bus_speed + 999) / 1000) >= 8)
+	if ((a_clc = (a_time * system_bus_speed + 999999) / 1000000) >= 8)
 		a_clc = 0;
 	c_time = t->cycle;
 
 #if 0
-	if ((r_clc = ((c_time - s_time - a_time) * system_bus_speed + 999) / 1000) >= 16)
+	if ((r_clc = ((c_time - s_time - a_time) * system_bus_speed + 999999) / 1000000) >= 16)
 		r_clc = 0;
 #endif
 
-	if (!(r_clc = (c_time * system_bus_speed + 999) / 1000 - a_clc - s_clc)) {
+	if (!(r_clc = (c_time * system_bus_speed + 999999) / 1000000 - a_clc - s_clc)) {
 		r_clc = 1;
 	} else {
 		if (r_clc >= 16)
diff -Nru a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
--- a/drivers/ide/amd74xx.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/amd74xx.c	Wed May 22 13:09:12 2002
@@ -87,7 +87,6 @@
 static struct amd_ide_chip *amd_config;
 static unsigned char amd_enabled;
 static unsigned int amd_80w;
-static unsigned int amd_clock;
 
 static unsigned char amd_cyc2udma[] = { 6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3 };
 static unsigned char amd_udma2cyc[] = { 4, 6, 8, 10, 3, 2, 1, 1 };
@@ -131,7 +130,7 @@
 	amd_print("Highest DMA rate:                   %s", amd_dma[amd_config->flags & AMD_UDMA]);
 
 	amd_print("BM-DMA base:                        %#x", amd_base);
-	amd_print("PCI clock:                          %d.%dMHz", amd_clock / 1000, amd_clock / 100 % 10);
+	amd_print("PCI clock:                          %d.%dMHz", system_bus_speed / 1000, system_bus_speed / 100 % 10);
 	
 	amd_print("-----------------------Primary IDE-------Secondary IDE------");
 
@@ -147,7 +146,7 @@
 
 	amd_print("Cable Type:            %10s%20s", (amd_80w & 1) ? "80w" : "40w", (amd_80w & 2) ? "80w" : "40w");
 
-	if (!amd_clock)
+	if (!system_bus_speed)
                 return p - buffer;
 
 	amd_print("-------------------drive0----drive1----drive2----drive3-----");
@@ -169,22 +168,22 @@
 		den[i]  = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
 
 		if (den[i] && uen[i] && udma[i] == 1) {
-			speed[i] = amd_clock * 3;
-			cycle[i] = 666666 / amd_clock;
+			speed[i] = system_bus_speed * 3;
+			cycle[i] = 666666 / system_bus_speed;
 			continue;
 		}
 
-		speed[i] = 4 * amd_clock / ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2);
-		cycle[i] = 1000000 * ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2) / amd_clock / 2;
+		speed[i] = 4 * system_bus_speed / ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2);
+		cycle[i] = 1000000 * ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2) / system_bus_speed / 2;
 	}
 
 	amd_print_drive("Transfer Mode: ", "%10s", den[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
 
-	amd_print_drive("Address Setup: ", "%8dns", 1000000 * setup[i] / amd_clock);
-	amd_print_drive("Cmd Active:    ", "%8dns", 1000000 * active8b[i] / amd_clock);
-	amd_print_drive("Cmd Recovery:  ", "%8dns", 1000000 * recover8b[i] / amd_clock);
-	amd_print_drive("Data Active:   ", "%8dns", 1000000 * active[i] / amd_clock);
-	amd_print_drive("Data Recovery: ", "%8dns", 1000000 * recover[i] / amd_clock);
+	amd_print_drive("Address Setup: ", "%8dns", 1000000 * setup[i] / system_bus_speed);
+	amd_print_drive("Cmd Active:    ", "%8dns", 1000000 * active8b[i] / system_bus_speed);
+	amd_print_drive("Cmd Recovery:  ", "%8dns", 1000000 * recover8b[i] / system_bus_speed);
+	amd_print_drive("Data Active:   ", "%8dns", 1000000 * active[i] / system_bus_speed);
+	amd_print_drive("Data Recovery: ", "%8dns", 1000000 * recover[i] / system_bus_speed);
 	amd_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
 	amd_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);
 
@@ -238,7 +237,7 @@
 			printk(KERN_WARNING "ide%d: Drive %d didn't accept speed setting. Oh, well.\n",
 				drive->dn >> 1, drive->dn & 1);
 
-	T = 1000000000 / amd_clock;
+	T = 1000000000 / system_bus_speed;
 	UT = T / min_t(int, max_t(int, amd_config->flags & AMD_UDMA, 1), 2);
 
 	ata_timing_compute(drive, speed, &t, T, UT);
@@ -248,7 +247,7 @@
 		ata_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
 	}
 
-	if (speed == XFER_UDMA_5 && amd_clock <= 33333) t.udma = 1;
+	if (speed == XFER_UDMA_5 && system_bus_speed <= 33333) t.udma = 1;
 
 	amd_set_speed(drive->channel->pci_dev, drive->dn, &t);
 
@@ -356,24 +355,6 @@
 	pci_read_config_byte(dev, AMD_IDE_CONFIG, &t);
 	pci_write_config_byte(dev, AMD_IDE_CONFIG,
 		(amd_config->flags & AMD_BAD_FIFO) ? (t & 0x0f) : (t | 0xf0));
-
-/*
- * Determine the system bus clock.
- */
-
-	amd_clock = system_bus_speed * 1000;
-
-	switch (amd_clock) {
-		case 33000: amd_clock = 33333; break;
-		case 37000: amd_clock = 37500; break;
-		case 41000: amd_clock = 41666; break;
-	}
-
-	if (amd_clock < 20000 || amd_clock > 50000) {
-		printk(KERN_WARNING "AMD_IDE: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", amd_clock);
-		printk(KERN_WARNING "AMD_IDE: Use ide0=ata66 if you want to assume 80-wire cable\n");
-		amd_clock = 33333;
-	}
 
 /*
  * Print the boot message.
diff -Nru a/drivers/ide/cmd640.c b/drivers/ide/cmd640.c
--- a/drivers/ide/cmd640.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/cmd640.c	Wed May 22 13:09:12 2002
@@ -603,7 +603,7 @@
 	u8 cycle_count;
 
 	recovery_time = cycle_time - (setup_time + active_time);
-	clock_time = 1000 / system_bus_speed;
+	clock_time = 1000000 / system_bus_speed;
 	cycle_count = (cycle_time + clock_time - 1) / clock_time;
 
 	setup_count = (setup_time + clock_time - 1) / clock_time;
diff -Nru a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
--- a/drivers/ide/cmd64x.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/cmd64x.c	Wed May 22 13:09:12 2002
@@ -305,7 +305,7 @@
 	 */
 
 	recovery_time = t->cycle - (t->setup + t->active);
-	clock_time = 1000 / system_bus_speed;
+	clock_time = 1000000 / system_bus_speed;
 	cycle_count = (t->cycle + clock_time - 1) / clock_time;
 	setup_count = (t->setup + clock_time - 1) / clock_time;
 	active_count = (t->active + clock_time - 1) / clock_time;
diff -Nru a/drivers/ide/cy82c693.c b/drivers/ide/cy82c693.c
--- a/drivers/ide/cy82c693.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/cy82c693.c	Wed May 22 13:09:12 2002
@@ -121,7 +121,7 @@
 {
 	int clocks;
 
-	clocks = (time*bus_speed+999)/1000 -1;
+	clocks = (time*bus_speed+999999)/1000000 -1;
 
 	if (clocks < 0)
 		clocks = 0;
diff -Nru a/drivers/ide/ht6560b.c b/drivers/ide/ht6560b.c
--- a/drivers/ide/ht6560b.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/ht6560b.c	Wed May 22 13:09:12 2002
@@ -219,8 +219,8 @@
 		/*
 		 *  Cycle times should be Vesa bus cycles
 		 */
-		active_cycles   = (active_time   * system_bus_speed + 999) / 1000;
-		recovery_cycles = (recovery_time * system_bus_speed + 999) / 1000;
+		active_cycles   = (active_time   * system_bus_speed + 999999) / 1000000;
+		recovery_cycles = (recovery_time * system_bus_speed + 999999) / 1000000;
 		/*
 		 *  Upper and lower limits
 		 */
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/ide.c	Wed May 22 13:09:12 2002
@@ -241,8 +241,6 @@
 
 	/* Add default hw interfaces */
 	ide_init_default_hwifs();
-
-	idebus_parameter = 0;
 }
 
 /*
@@ -2785,10 +2783,7 @@
 	if (!strncmp(s, "idebus", 6)) {
 		if (match_parm(&s[6], NULL, vals, 1) != 1)
 			goto bad_option;
-		if (vals[0] >= 20 && vals[0] <= 66) {
-			idebus_parameter = vals[0];
-		} else
-			printk(" -- BAD BUS SPEED! Expected value from 20 to 66");
+		idebus_parameter = vals[0];
 		goto done;
 	}
 
@@ -3217,27 +3212,40 @@
 
 	ide_devfs_handle = devfs_mk_dir (NULL, "ide", NULL);
 
-	/* Initialize system bus speed.
-	 *
-	 * This can be changed by a particular chipse initialization module.
-	 * Otherwise we assume 33MHz as a safe value for PCI bus based systems.
-	 * 50MHz will be assumed for abolitions like VESA, since higher values
-	 * result in more conservative timing setups.
-	 *
-	 * The kernel parameter idebus=XX overrides the default settings.
-	 */
+/*
+ * Because most of the ATA adapters represent the timings in unit of bus
+ * clocks, and there is no known reliable way to detect the bus clock
+ * frequency, we assume 50 MHz for non-PCI (VLB, EISA) and 33 MHz for PCI based
+ * systems. Since assuming only hurts performance and not stability, this is
+ * OK. The user can change this on the command line by using the "idebus=XX"
+ * parameter. While the system_bus_speed variable is in kHz units, we accept
+ * both MHz and kHz entry on the command line for backward compatibility.
+ */
 
-	system_bus_speed = 50;
-	if (idebus_parameter)
-	    system_bus_speed = idebus_parameter;
-#ifdef CONFIG_PCI
-	else if (pci_present())
-	    system_bus_speed = 33;
-#endif
+	system_bus_speed = 50000;
 
-	printk(KERN_INFO "ATA: system bus speed %dMHz\n", system_bus_speed);
+	if (pci_present())
+	    system_bus_speed = 33333;
 
-	init_ide_data ();
+	if (idebus_parameter >= 20 && idebus_parameter <= 80) {
+
+		system_bus_speed = idebus_parameter * 1000;
+
+		switch (system_bus_speed) {
+			case 33000: system_bus_speed = 33333; break;
+			case 37000: system_bus_speed = 37500; break;
+			case 41000: system_bus_speed = 41666; break;
+			case 66000: system_bus_speed = 66666; break;
+		}
+	}
+
+	if (idebus_parameter >= 20000 && idebus_parameter <= 80000)
+	    system_bus_speed = idebus_parameter;
+	
+	printk(KERN_INFO "ATA: %s bus speed %d.%dMHz\n",
+		pci_present() ? "PCI" : "System", system_bus_speed / 1000, system_bus_speed / 100 % 10);
+
+	init_ide_data();
 
 	initializing = 1;
 
diff -Nru a/drivers/ide/opti621.c b/drivers/ide/opti621.c
--- a/drivers/ide/opti621.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/opti621.c	Wed May 22 13:09:12 2002
@@ -175,7 +175,7 @@
  * Use idebus=xx to select right frequency.
  */
 {
-	return ((time*bus_speed+999)/1000);
+	return ((time*bus_speed+999999)/1000000);
 }
 
 static void write_reg(byte value, int reg)
diff -Nru a/drivers/ide/piix.c b/drivers/ide/piix.c
--- a/drivers/ide/piix.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/piix.c	Wed May 22 13:09:12 2002
@@ -105,7 +105,6 @@
 static struct piix_ide_chip *piix_config;
 static unsigned char piix_enabled;
 static unsigned int piix_80w;
-static unsigned int piix_clock;
 
 static char *piix_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 
@@ -147,7 +146,7 @@
 								: piix_dma[piix_config->flags & PIIX_UDMA]);
 
 	piix_print("BM-DMA base:                        %#x", piix_base);
-	piix_print("PCI clock:                          %d.%dMHz", piix_clock / 1000, piix_clock / 100 % 10);
+	piix_print("PCI clock:                          %d.%dMHz", system_bus_speed / 1000, system_bus_speed / 100 % 10);
 
 	piix_print("-----------------------Primary IDE-------Secondary IDE------");
 
@@ -160,7 +159,7 @@
 
 	piix_print("Cable Type:            %10s%20s", (piix_80w & 1) ? "80w" : "40w", (piix_80w & 2) ? "80w" : "40w");
 
-	if (!piix_clock)
+	if (!system_bus_speed)
                 return p - buffer;
 
 	piix_print("-------------------drive0----drive1----drive2----drive3-----");
@@ -192,8 +191,8 @@
 		}
 
 		dmaen[i] = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
-		cycle[i] = 1000000 / piix_clock * (active[i] + recover[i]);
-		speed[i] = 2 * piix_clock / (active[i] + recover[i]);
+		cycle[i] = 1000000 / system_bus_speed * (active[i] + recover[i]);
+		speed[i] = 2 * system_bus_speed / (active[i] + recover[i]);
 
 		if (!(piix_config->flags & PIIX_UDMA))
 			continue;
@@ -213,17 +212,17 @@
 			udma[i] = (4 - ((e >> (i << 2)) & 3)) * umul;
 		} else  udma[i] = (8 - ((e >> (i << 2)) & 7)) * 2;
 
-		speed[i] = 8 * piix_clock / udma[i];
-		cycle[i] = 250000 * udma[i] / piix_clock;
+		speed[i] = 8 * system_bus_speed / udma[i];
+		cycle[i] = 250000 * udma[i] / system_bus_speed;
 	}
 
 	piix_print_drive("Transfer Mode: ", "%10s", dmaen[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
 
-	piix_print_drive("Address Setup: ", "%8dns", (1000000 / piix_clock) * 3);
-	piix_print_drive("Cmd Active:    ", "%8dns", (1000000 / piix_clock) * 12);
-	piix_print_drive("Cmd Recovery:  ", "%8dns", (1000000 / piix_clock) * 18);
-	piix_print_drive("Data Active:   ", "%8dns", (1000000 / piix_clock) * active[i]);
-	piix_print_drive("Data Recovery: ", "%8dns", (1000000 / piix_clock) * recover[i]);
+	piix_print_drive("Address Setup: ", "%8dns", (1000000 / system_bus_speed) * 3);
+	piix_print_drive("Cmd Active:    ", "%8dns", (1000000 / system_bus_speed) * 12);
+	piix_print_drive("Cmd Recovery:  ", "%8dns", (1000000 / system_bus_speed) * 18);
+	piix_print_drive("Data Active:   ", "%8dns", (1000000 / system_bus_speed) * active[i]);
+	piix_print_drive("Data Recovery: ", "%8dns", (1000000 / system_bus_speed) * recover[i]);
 	piix_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
 	piix_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);
 
@@ -339,7 +338,7 @@
 	if (speed > XFER_UDMA_4 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100)
 		umul = 4;
 	
-	T = 1000000000 / piix_clock;
+	T = 1000000000 / system_bus_speed;
 	UT = T / umul;
 
 	ata_timing_compute(drive, speed, &t, T, UT);
@@ -491,24 +490,6 @@
 		if (~piix_config->flags & PIIX_NO_SITRE) w |= 0x4000;
 		w |= 0x44;
 		pci_write_config_word(dev, PIIX_IDETIM0 + (i << 1), w);
-	}
-
-/*
- * Determine the system bus clock.
- */
-
-	piix_clock = system_bus_speed * 1000;
-
-	switch (piix_clock) {
-		case 33000: piix_clock = 33333; break;
-		case 37000: piix_clock = 37500; break;
-		case 41000: piix_clock = 41666; break;
-	}
-
-	if (piix_clock < 20000 || piix_clock > 50000) {
-		printk(KERN_WARNING "PIIX: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", piix_clock);
-		printk(KERN_WARNING "PIIX: Use ide0=ata66 if you want to assume 80-wire cable\n");
-		piix_clock = 33333;
 	}
 
 /*
diff -Nru a/drivers/ide/qd65xx.c b/drivers/ide/qd65xx.c
--- a/drivers/ide/qd65xx.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/qd65xx.c	Wed May 22 13:09:12 2002
@@ -133,12 +133,12 @@
 {
 	byte active_cycle,recovery_cycle;
 
-	if (system_bus_speed <= 33) {
-		active_cycle =   9  - IDE_IN(active_time   * system_bus_speed / 1000 + 1, 2, 9);
-		recovery_cycle = 15 - IDE_IN(recovery_time * system_bus_speed / 1000 + 1, 0, 15);
+	if (system_bus_speed <= 33333) {
+		active_cycle =   9  - IDE_IN(active_time   * system_bus_speed / 1000000 + 1, 2, 9);
+		recovery_cycle = 15 - IDE_IN(recovery_time * system_bus_speed / 1000000 + 1, 0, 15);
 	} else {
-		active_cycle =   8  - IDE_IN(active_time   * system_bus_speed / 1000 + 1, 1, 8);
-		recovery_cycle = 18 - IDE_IN(recovery_time * system_bus_speed / 1000 + 1, 3, 18);
+		active_cycle =   8  - IDE_IN(active_time   * system_bus_speed / 1000000 + 1, 1, 8);
+		recovery_cycle = 18 - IDE_IN(recovery_time * system_bus_speed / 1000000 + 1, 3, 18);
 	}
 
 	return((recovery_cycle<<4) | 0x08 | active_cycle);
@@ -152,8 +152,8 @@
 
 static byte qd6580_compute_timing (int active_time, int recovery_time)
 {
-	byte active_cycle   = 17-IDE_IN(active_time   * system_bus_speed / 1000 + 1, 2, 17);
-	byte recovery_cycle = 15-IDE_IN(recovery_time * system_bus_speed / 1000 + 1, 2, 15);
+	byte active_cycle   = 17-IDE_IN(active_time   * system_bus_speed / 1000000 + 1, 2, 17);
+	byte recovery_cycle = 15-IDE_IN(recovery_time * system_bus_speed / 1000000 + 1, 2, 15);
 
 	return((recovery_cycle<<4) | active_cycle);
 }
diff -Nru a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
--- a/drivers/ide/via82cxxx.c	Wed May 22 13:09:12 2002
+++ b/drivers/ide/via82cxxx.c	Wed May 22 13:09:12 2002
@@ -132,7 +132,6 @@
 static struct via_isa_bridge *via_config;
 static unsigned char via_enabled;
 static unsigned int via_80w;
-static unsigned int via_clock;
 static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 
 /*
@@ -175,7 +174,7 @@
 	via_print("Highest DMA rate:                   %s", via_dma[via_config->flags & VIA_UDMA]);
 
 	via_print("BM-DMA base:                        %#x", via_base);
-	via_print("PCI clock:                          %d.%dMHz", via_clock / 1000, via_clock / 100 % 10);
+	via_print("PCI clock:                          %d.%dMHz", system_bus_speed / 1000, system_bus_speed / 100 % 10);
 
 	pci_read_config_byte(dev, VIA_MISC_1, &t);
 	via_print("Master Read  Cycle IRDY:            %dws", (t & 64) >> 6);
@@ -223,8 +222,8 @@
 		uen[i]       = ((u >> ((3 - i) << 3)) & 0x20);
 		den[i]       = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
 
-		speed[i] = 2 * via_clock / (active[i] + recover[i]);
-		cycle[i] = 1000000 * (active[i] + recover[i]) / via_clock;
+		speed[i] = 2 * system_bus_speed / (active[i] + recover[i]);
+		cycle[i] = 1000000 * (active[i] + recover[i]) / system_bus_speed;
 
 		if (!uen[i] || !den[i])
 			continue;
@@ -232,34 +231,34 @@
 		switch (via_config->flags & VIA_UDMA) {
 
 			case VIA_UDMA_33:
-				speed[i] = 2 * via_clock / udma[i];
-				cycle[i] = 1000000 * udma[i] / via_clock;
+				speed[i] = 2 * system_bus_speed / udma[i];
+				cycle[i] = 1000000 * udma[i] / system_bus_speed;
 				break;
 
 			case VIA_UDMA_66:
-				speed[i] = 4 * via_clock / (udma[i] * umul[i]);
-				cycle[i] = 500000 * (udma[i] * umul[i]) / via_clock;
+				speed[i] = 4 * system_bus_speed / (udma[i] * umul[i]);
+				cycle[i] = 500000 * (udma[i] * umul[i]) / system_bus_speed;
 				break;
 
 			case VIA_UDMA_100:
-				speed[i] = 6 * via_clock / udma[i];
-				cycle[i] = 333333 * udma[i] / via_clock;
+				speed[i] = 6 * system_bus_speed / udma[i];
+				cycle[i] = 333333 * udma[i] / system_bus_speed;
 				break;
 
 			case VIA_UDMA_133:
-				speed[i] = 8 * via_clock / udma[i];
-				cycle[i] = 250000 * udma[i] / via_clock;
+				speed[i] = 8 * system_bus_speed / udma[i];
+				cycle[i] = 250000 * udma[i] / system_bus_speed;
 				break;
 		}
 	}
 
 	via_print_drive("Transfer Mode: ", "%10s", den[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
 
-	via_print_drive("Address Setup: ", "%8dns", 1000000 * setup[i] / via_clock);
-	via_print_drive("Cmd Active:    ", "%8dns", 1000000 * active8b[i] / via_clock);
-	via_print_drive("Cmd Recovery:  ", "%8dns", 1000000 * recover8b[i] / via_clock);
-	via_print_drive("Data Active:   ", "%8dns", 1000000 * active[i] / via_clock);
-	via_print_drive("Data Recovery: ", "%8dns", 1000000 * recover[i] / via_clock);
+	via_print_drive("Address Setup: ", "%8dns", 1000000 * setup[i] / system_bus_speed);
+	via_print_drive("Cmd Active:    ", "%8dns", 1000000 * active8b[i] / system_bus_speed);
+	via_print_drive("Cmd Recovery:  ", "%8dns", 1000000 * recover8b[i] / system_bus_speed);
+	via_print_drive("Data Active:   ", "%8dns", 1000000 * active[i] / system_bus_speed);
+	via_print_drive("Data Recovery: ", "%8dns", 1000000 * recover[i] / system_bus_speed);
 	via_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
 	via_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);
 
@@ -314,7 +313,7 @@
 			printk(KERN_WARNING "ide%d: Drive %d didn't accept speed setting. Oh, well.\n",
 				drive->dn >> 1, drive->dn & 1);
 
-	T = 1000000000 / via_clock;
+	T = 1000000000 / system_bus_speed;
 
 	switch (via_config->flags & VIA_UDMA) {
 		case VIA_UDMA_33:   UT = T;   break;
@@ -469,24 +468,6 @@
 	}
 
 	pci_write_config_byte(dev, VIA_FIFO_CONFIG, t);
-
-/*
- * Determine system bus clock.
- */
-
-	via_clock = system_bus_speed * 1000;
-
-	switch (via_clock) {
-		case 33000: via_clock = 33333; break;
-		case 37000: via_clock = 37500; break;
-		case 41000: via_clock = 41666; break;
-	}
-
-	if (via_clock < 20000 || via_clock > 50000) {
-		printk(KERN_WARNING "VP_IDE: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", via_clock);
-		printk(KERN_WARNING "VP_IDE: Use ide0=ata66 if you want to assume 80-wire cable.\n");
-		via_clock = 33333;
-	}
 
 /*
  * Print the boot message.

--KsGdsel6WgEHnImy--
