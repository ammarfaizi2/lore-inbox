Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbREOS3R>; Tue, 15 May 2001 14:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261225AbREOS26>; Tue, 15 May 2001 14:28:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:7133 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261228AbREOSTK>; Tue, 15 May 2001 14:19:10 -0400
From: normp@us.ibm.com
Date: Tue, 15 May 2001 11:19:05 -0700
Message-Id: <200105151819.LAA16206@mandolin.paloalto.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: normp@us.ibm.com
Subject: APM Support for AD1848 driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies drivers/sound/ad1848.c to provide APM suspend/resume
support to the AD1848 driver.

To apply this patch,

        cd to the top linux source directory

        patch --dry-run -p0 < this_file

If the patch program doesn't complain then use the command

        patch -p0 < this_file

to really apply the patch.  Then issue

        make modules; make modules_install

NOTES:
        - OSS drivers support (together with the correct driver modules)
          must be enabled in the kernel config.

        - APM support must be enabled in the kernel config.

        - This patch was developed for linux-2.2.19 although it should
          apply to linux-2.2.14 through linux-2.2.19

        - There's absolutely no warranty of any kind.

Please reply directly to normp@us.ibm.com since I'm not subscribed to the
mailing list.

Thanks,
  Norm Proffitt

--- drivers/sound/ad1848.c.org  Mon Mar 19 14:28:31 2001
+++ drivers/sound/ad1848.c      Wed Mar 21 14:35:20 2001
@@ -26,6 +26,7 @@
  *                  general sleep/wakeup clean up.
  * Alan Cox       : reformatted. Fixed SMP bugs. Moved to kernel alloc/free
  *                  of irqs. Use dev_id.
+ * Norm Proffitt   : backport Aki Laukkanen's power management support
  *
  * Status:
  *             Tested. Believed fully functional.
@@ -34,6 +35,9 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/stddef.h>
+#ifdef CONFIG_APM
+#include <linux/apm_bios.h>
+#endif

 #include "soundmodule.h"

@@ -51,6 +55,7 @@
        int             irq;
        int             dma1, dma2;
        int             dual_dma;       /* 1, when two DMA channels allocated */
+       int             subtype;
        unsigned char   MCE_bit;
        unsigned char   saved_regs[32];
        int             debug_flag;
@@ -99,6 +104,7 @@
 }
 ad1848_port_info;

+static struct address_info cfg;
 static int nr_ad1848_devs = 0;
 int deskpro_xl = 0;
 int deskpro_m = 0;
@@ -166,6 +172,7 @@
 static void     ad1848_halt_input(int dev);
 static void     ad1848_halt_output(int dev);
 static void     ad1848_trigger(int dev, int bits);
+static int      ad1848_apm_callback(apm_event_t apm_event);

 #if defined(CONFIG_SEQUENCER) && !defined(EXCLUDE_TIMERS)
 static int ad1848_tmr_install(int dev);
@@ -1866,6 +1873,7 @@
        devc->timer_ticks = 0;
        devc->dma1 = dma_playback;
        devc->dma2 = dma_capture;
+       devc->subtype = cfg.card_subtype;
        devc->audio_flags = DMA_AUTOMODE;
        devc->playback_dev = devc->record_dev = 0;
        if (name != NULL)
@@ -1918,6 +1926,12 @@

        nr_ad1848_devs++;

+#ifdef CONFIG_APM
+        if (apm_register_callback(ad1848_apm_callback))
+        {
+                printk(KERN_WARNING "ad1848: APM suspend might not work.\n");
+        }
+#endif
        ad1848_init_hw(devc);

        if (irq > 0)
@@ -2079,6 +2093,13 @@
                if(mixer>=0)
                        sound_unload_mixerdev(mixer);

+#ifdef CONFIG_APM
+        if (apm_register_callback(ad1848_apm_callback))
+        {
+                printk(KERN_WARNING "ad1848: APM suspend might not work.\n");
+        }
+#endif
+
                nr_ad1848_devs--;
                for ( ; i < nr_ad1848_devs ; i++)
                        adev_info[i] = adev_info[i+1];
@@ -2695,6 +2716,104 @@
 }
 #endif

+#ifdef CONFIG_APM
+static int ad1848_suspend(ad1848_info * devc)
+{
+        unsigned long   flags;
+
+        save_flags(flags);
+        cli();
+
+        ad_mute(devc);
+
+        restore_flags(flags);
+        return 0;
+}
+
+static int ad1848_resume(ad1848_info * devc)
+{
+        unsigned long   flags;
+        int             mixer_levels[32], i;
+
+        save_flags(flags);
+        cli();
+
+        /* store old mixer levels */
+        memcpy(mixer_levels, devc->levels, sizeof(mixer_levels));
+        ad1848_init_hw(devc);
+
+        /* restore mixer levels */
+        for (i = 0; i < 32; i++)
+                ad1848_mixer_set(devc, devc->dev_no, mixer_levels[i]);
+
+        if (devc->subtype)
+        {
+                static signed char interrupt_bits[12] =
+                {
+                        -1, -1, -1, -1, -1, 0x00, -1, 0x08, -1, 0x10,
+                        0x18, 0x20
+                };
+                static char     dma_bits[4] =
+                {
+                        1, 2, 0, 3
+                };
+
+                signed char     bits;
+                char            dma2_bit = 0;
+                int             config_port = devc->base + 0;
+
+                bits = interrupt_bits[devc->irq];
+                if (bits == -1)
+                {
+                        printk(KERN_ERR "MSS: Bad IRQ %d\n", devc->irq);
+                        restore_flags(flags);
+                        return -1;
+                }
+
+                outb((bits | 0x40), config_port);
+
+                if (devc->dma2 != -1 && devc->dma2 != devc->dma1)
+                        if ((devc->dma1 == 0 && devc->dma2 == 1) ||
+                            (devc->dma1 == 1 && devc->dma2 == 0) ||
+                            (devc->dma1 == 3 && devc->dma2 == 0))
+                                dma2_bit = 0x04;
+
+                outb((bits | dma_bits[devc->dma1] | dma2_bit),
+                 config_port);
+        }
+
+        restore_flags(flags);
+        return 0;
+}
+
+static int ad1848_apm_callback(apm_event_t apm_event)
+{
+        int             n;
+
+        switch (apm_event)
+        {
+                case APM_SYS_SUSPEND:
+                case APM_CRITICAL_SUSPEND:
+                case APM_USER_SUSPEND:
+                        for (n = 0; n < nr_ad1848_devs; n++)
+                                ad1848_suspend(&adev_info[n]);
+                        break;
+
+                case APM_NORMAL_RESUME:
+                case APM_CRITICAL_RESUME:
+                case APM_STANDBY_RESUME:
+                        for (n = 0; n < nr_ad1848_devs; n++)
+                                ad1848_resume(&adev_info[n]);
+                        break;
+
+                default:
+                        break;
+        }
+
+        return 0;
+}
+
+#endif

 EXPORT_SYMBOL(ad1848_detect);
 EXPORT_SYMBOL(ad1848_init);
@@ -2724,8 +2843,6 @@

 static int loaded = 0;

-struct address_info hw_config;
-
 int init_module(void)
 {
        printk(KERN_INFO "ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996\n");
@@ -2736,14 +2853,14 @@
                        printk(KERN_WARNING "ad1848: must give I/O , IRQ and DMA.\n");
                        return -EINVAL;
                }
-               hw_config.irq = irq;
-               hw_config.io_base = io;
-               hw_config.dma = dma;
-               hw_config.dma2 = dma2;
-               hw_config.card_subtype = type;
-               if(!probe_ms_sound(&hw_config))
+               cfg.irq = irq;
+               cfg.io_base = io;
+               cfg.dma = dma;
+               cfg.dma2 = dma2;
+               cfg.card_subtype = type;
+               if(!probe_ms_sound(&cfg))
                        return -ENODEV;
-               attach_ms_sound(&hw_config);
+               attach_ms_sound(&cfg);
                loaded=1;
        }
        SOUND_LOCK;
@@ -2754,7 +2871,7 @@
 {
        SOUND_LOCK_END;
        if(loaded)
-               unload_ms_sound(&hw_config);
+               unload_ms_sound(&cfg);
 }

 #endif
