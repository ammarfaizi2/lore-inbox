Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVGYOlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVGYOlo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVGYOlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:41:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55184 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261245AbVGYOke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:40:34 -0400
Date: Mon, 25 Jul 2005 08:22:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [warning: ugly, FYI] battery charging support for sharp sl-5500
Message-ID: <20050725062242.GA3292@elf.ucw.cz>
References: <20050725054642.GA6651@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050725054642.GA6651@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I took battery charging code from sharp and placed it in
> arch/arm/mach-sa1100/battery-collie.c (hope that's good place...). It
> still does not link, and will need complete rewrite, but... If you
> have done this already please let me know.

I replaced sharp functions with ucb_1x00 functions this way; I hope I
did not mess it up.

diff --git a/arch/arm/mach-sa1100/battery-collie.c b/arch/arm/mach-sa1100/battery-collie.c
--- a/arch/arm/mach-sa1100/battery-collie.c
+++ b/arch/arm/mach-sa1100/battery-collie.c
@@ -54,9 +54,6 @@
 
 /* Various strange defines, coming from sharp */
 
-#define COLLIE_TC35143_IODAT_LOW       0      /* set up fs 8k LPF on data      */
-#define COLLIE_TC35143_IODAT_HIGH      1      /* set up fs 8k LPF off data     */
-
 #define COLLIE_TC35143_IODIR_OUTPUT    1      /* set up output mode            */
 #define COLLIE_TC35143_IODIR_INPUT     0      /* set up input  mode            */
 
@@ -226,13 +223,8 @@ static struct miscdevice battery_device 
 
 #define ADC_REQ_ID	(u32)(&battery_device)
 
-#ifdef CONFIG_COLLIE_TR0
-#define CHARGE_ON()        ucb1200_set_io(COLLIE_TC35143_GPIO_CHRG_ON, COLLIE_TC35143_IODAT_HIGH)
-#define CHARGE_OFF()       ucb1200_set_io(COLLIE_TC35143_GPIO_CHRG_ON, COLLIE_TC35143_IODAT_LOW)
-#else
 #define CHARGE_ON()        SCP_REG_GPWR |= COLLIE_SCP_CHARGE_ON
 #define CHARGE_OFF()       SCP_REG_GPWR &= ~COLLIE_SCP_CHARGE_ON
-#endif
 
 #define CHARGE_LED_ON()    printk("charger on\n");
 #define CHARGE_LED_OFF()   printk("charger off\n");
@@ -540,9 +532,6 @@ int GetMainChargePercent( int Volt )
 /*** get adc *********************************************************************/
 int collie_get_main_battery(void)
 {
-#ifdef CONFIG_COLLIE_TR0
-	return 	COLLIE_BATTERY_STATUS_HIGH;
-#else
 	int i = 0;
 
 	MainCntWk++;
@@ -570,8 +559,6 @@ int collie_get_main_battery(void)
 	  DPRINTK("MainCntWk = %d\n",MainCntWk);
 	}
 	return collie_main_battery;
-
-#endif
 }
 
 
@@ -617,14 +604,13 @@ int collie_read_MainBattery(void)
 {
 	int voltage;
 
-
-  	ucb1200_set_io(COLLIE_TC35143_GPIO_BBAT_ON, COLLIE_TC35143_IODAT_LOW);
-  	ucb1200_set_io(COLLIE_TC35143_GPIO_MBAT_ON, COLLIE_TC35143_IODAT_HIGH);
-	voltage = ucb1200_get_adc_value(ADC_REQ_ID, COLLIE_TC35143_ADC_BAT_VOL);
+	ucb1x00_io_write(NULL, 0, COLLIE_TC35143_GPIO_BBAT_ON);
+	ucb1x00_io_write(NULL, COLLIE_TC35143_GPIO_MBAT_ON, 0);
+	voltage = ucb1x00_adc_read(NULL, COLLIE_TC35143_ADC_BAT_VOL, UCB_SYNC);
 	if ( battery_off_flag )
 	  voltage = -1;
-  	ucb1200_set_io(COLLIE_TC35143_GPIO_MBAT_ON, COLLIE_TC35143_IODAT_LOW);
 
+	ucb1x00_io_write(NULL, 0, COLLIE_TC35143_GPIO_MBAT_ON);
 	battery_off_flag = 0;
 
 	DPRINTK("adc = %d\n",voltage);
@@ -641,13 +627,13 @@ int collie_read_BackBattery(void)
 {
 	int voltage;
 
-  	ucb1200_set_io(COLLIE_TC35143_GPIO_MBAT_ON, COLLIE_TC35143_IODAT_LOW);
-  	ucb1200_set_io(COLLIE_TC35143_GPIO_BBAT_ON, COLLIE_TC35143_IODAT_HIGH);
+	ucb1x00_io_write(NULL, 0, COLLIE_TC35143_GPIO_MBAT_ON);
+	ucb1x00_io_write(NULL, COLLIE_TC35143_GPIO_BBAT_ON, 0);
 	mdelay(3);
-	voltage = ucb1200_get_adc_value(ADC_REQ_ID, COLLIE_TC35143_ADC_BAT_VOL);
+	voltage = ucb1x00_adc_read(NULL, COLLIE_TC35143_ADC_BAT_VOL, UCB_SYNC);
 	if ( battery_off_flag )
 	  voltage = -1;
-  	ucb1200_set_io(COLLIE_TC35143_GPIO_BBAT_ON, COLLIE_TC35143_IODAT_LOW);
+	ucb1x00_io_write(NULL, 0, COLLIE_TC35143_GPIO_BBAT_ON);
 
 	battery_off_flag = 0;
 	return voltage;
@@ -657,12 +643,12 @@ int collie_read_Temp(void)
 {
 	int voltage;
 
-
-  	ucb1200_set_io(COLLIE_TC35143_GPIO_TMP_ON, COLLIE_TC35143_IODAT_HIGH);
-	voltage = ucb1200_get_adc_value(ADC_REQ_ID, COLLIE_TC35143_ADC_BAT_TMP);
+	ucb1x00_io_write(NULL, COLLIE_TC35143_GPIO_TMP_ON, 0);
+	voltage = ucb1x00_adc_read(NULL, COLLIE_TC35143_ADC_BAT_TMP, UCB_SYNC);
 	if ( battery_off_flag )
 	  voltage = -1;
-  	ucb1200_set_io(COLLIE_TC35143_GPIO_TMP_ON, COLLIE_TC35143_IODAT_LOW);
+	ucb1x00_io_write(NULL, 0, COLLIE_TC35143_GPIO_TMP_ON);
+
 
 	battery_off_flag = 0;
 	return voltage;
@@ -722,14 +708,12 @@ int suspend_collie_read_Temp(void)
 {
   int temp;
 
-  ucb1200_set_io(COLLIE_TC35143_GPIO_TMP_ON, COLLIE_TC35143_IODAT_HIGH);
+  ucb1x00_io_write(NULL, COLLIE_TC35143_GPIO_TMP_ON, 0);
   udelay(700);
-  temp = suspend_read_adc((int)&temp, COLLIE_TC35143_ADC_BAT_TMP);
-  ucb1200_set_io(COLLIE_TC35143_GPIO_TMP_ON, COLLIE_TC35143_IODAT_LOW);
+  temp = ucb1x00_adc_read(NULL, COLLIE_TC35143_ADC_BAT_TMP, UCB_SYNC);
+  ucb1x00_io_write(NULL, 0, COLLIE_TC35143_GPIO_TMP_ON);
 
   printk("suspend temp = %d\n",temp);
-
-
   return temp;
 }
 
@@ -738,10 +722,11 @@ unsigned short suspend_collie_read_MainB
 {
   int temp;
 
-  ucb1200_set_io(COLLIE_TC35143_GPIO_MBAT_ON, COLLIE_TC35143_IODAT_HIGH);
+  ucb1x00_io_write(NULL, COLLIE_TC35143_GPIO_MBAT_ON, 0);
   udelay(700);
-  temp = suspend_read_adc((int)&temp, COLLIE_TC35143_ADC_BAT_VOL);
-  ucb1200_set_io(COLLIE_TC35143_GPIO_MBAT_ON, COLLIE_TC35143_IODAT_LOW);
+  temp = ucb1x00_adc_read(NULL, COLLIE_TC35143_ADC_BAT_VOL, UCB_SYNC);
+
+  ucb1x00_io_write(NULL, 0, COLLIE_TC35143_GPIO_MBAT_ON);
 
   printk("suspend main adc = %d(%d)\n",(temp+ConvRevise(temp)),temp);
 
@@ -753,11 +738,10 @@ unsigned short GetBackupBatteryAD(void)
 {
   int temp;
 
-  ucb1200_set_io(COLLIE_TC35143_GPIO_BBAT_ON, COLLIE_TC35143_IODAT_HIGH);
-  //  mdelay(3);
+  ucb1x00_io_write(NULL, COLLIE_TC35143_GPIO_BBAT_ON, 0);
   mdelay(5);
-  temp = suspend_read_adc((int)&temp, COLLIE_TC35143_ADC_BAT_VOL);
-  ucb1200_set_io(COLLIE_TC35143_GPIO_BBAT_ON, COLLIE_TC35143_IODAT_LOW);
+  temp = ucb1x00_adc_read(NULL, COLLIE_TC35143_ADC_BAT_VOL, UCB_SYNC);
+  ucb1x00_io_write(NULL, 0, COLLIE_TC35143_GPIO_BBAT_ON);
 
   printk("suspend backup adc = %d(%d)\n",(temp+ConvRevise(temp)),temp);
 
@@ -776,9 +760,6 @@ void collie_get_ad(void)
 
 unsigned short chkFatalBatt(void)
 {
-#ifdef CONFIG_COLLIE_TR0
-  return 1;
-#else
   int volt;
 
   // fail safe
@@ -804,7 +785,6 @@ unsigned short chkFatalBatt(void)
     return 0;
   else
     return 1;
-#endif
 }
 
 
@@ -928,17 +908,9 @@ void battery_init(void)
   /* get ad revise */
   collie_get_ad();
 
-  /* 35143F io port initialize */
-#ifdef CONFIG_COLLIE_TR0
-  ucb1200_set_io_direction(COLLIE_TC35143_GPIO_CHRG_ON, COLLIE_TC35143_IODIR_OUTPUT);
-#endif
-  ucb1200_set_io_direction(COLLIE_TC35143_GPIO_MBAT_ON, COLLIE_TC35143_IODIR_OUTPUT);
-  ucb1200_set_io_direction(COLLIE_TC35143_GPIO_TMP_ON,  COLLIE_TC35143_IODIR_OUTPUT);
-  ucb1200_set_io_direction(COLLIE_TC35143_GPIO_BBAT_ON, COLLIE_TC35143_IODIR_OUTPUT);
-
   /* Set transition detect */
-  usb1x00_enable_irq(NULL, COLLIE_GPIO_AC_IN, UCB_RISING);
-  usb1x00_enable_irq(NULL, COLLIE_GPIO_CO, UCB_RISING);
+  ucb1x00_enable_irq(NULL, COLLIE_GPIO_AC_IN, UCB_RISING);
+  ucb1x00_enable_irq(NULL, COLLIE_GPIO_CO, UCB_RISING);
 
   /* Register interrupt handler. */
   if ((err = request_irq(IRQ_GPIO_AC_IN, Collie_ac_interrupt, SA_INTERRUPT,
@@ -1066,7 +1038,6 @@ int __init Collie_battery_init(void)
 
 	proc_batt = proc_mkdir("driver/battery", NULL);
 	if (proc_batt == NULL) {
-	  ucb1200_cancel_get_adc_value(ADC_REQ_ID);
 	  free_irq(IRQ_GPIO_AC_IN, Collie_ac_interrupt);
 	  free_irq(IRQ_GPIO_CO, Collie_co_interrupt);
 
@@ -1089,7 +1060,6 @@ int __init Collie_battery_init(void)
 			}
 			remove_proc_entry("driver/battery", &proc_root);
 			proc_batt = 0;
-			ucb1200_cancel_get_adc_value(ADC_REQ_ID);
 			free_irq(IRQ_GPIO_AC_IN, Collie_ac_interrupt);
 			free_irq(IRQ_GPIO_CO, Collie_co_interrupt);
 			misc_deregister(&battery_device);


-- 
teflon -- maybe it is a trademark, but it should not be.
