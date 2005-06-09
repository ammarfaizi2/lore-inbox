Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVFIASj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVFIASj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVFIARh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:17:37 -0400
Received: from femail.waymark.net ([206.176.148.84]:25277 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S262250AbVFIAOu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:14:50 -0400
Date: 9 Jun 2005 00:14:40 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: Re: [ACPI] acpi_processor_set_power_policy
To: linux-kernel@vger.kernel.org
Message-ID: <203fc2.c899d4@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> Kenneth Parrish wrote to All <=-

 KP> SEEN-BY: 8/1 2 2003
 KP> PATH: 8/2003 1 2
 KP> MSGID: 8:8/2003 122ea9cd
 KP> TZUTC: -0600
 KP> CHARSET: PC-8
 KP> From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>

 KP> # readprofile -r ; sleep 1 ; readprofile -m /boot/System.map
 | sort -nr

 KP>     527 total                                      0.0003
 KP>     502 acpi_processor_set_power_policy            2.6989
 KP>       7 sort                                       0.0208
 KP>       7 release_task                               0.0208
 KP>       4 zone_watermark_ok                          0.0208
 KP>       3 do_page_fault                              0.0021
 KP>       1 unmap_page_range                           0.0057
 KP>       1 show_free_areas                            0.0013
 KP>       1 do_file_page                               0.0048
 KP>       1 buffered_rmqueue                           0.0020

 KP> Should acpi_processor_set_power_policy be called this often?

 KP> Kernel: 2.6.12-rc5-git9  # define HZ    500
 KP> <include/asm-i386/param.h> Computer: Cyrix MII and VIA MVP3,
 KP> e-machines '99 dmesg.. Kernel command line:
 KP> BOOT_IMAGE=2.6.12-rc5-git9 ro root=301 clock=tsc elevator=
 KP>  deadline lpj=376832 profile=2
 KP>  kernel profiling enabled (shift: 2)

 KP> More information and at request.

 KP> ...  A:  6-1/2" x 6-1/2" x 2"   Q: How big is the Mac Mini?
 KP> -+- MultiMail/Linux v0.46  [currently BlueWave packet type]
 KP> -
 KP> To unsubscribe from this list: send the line "unsubscribe
 KP> linux-kernel" in the body of a message to
 KP> majordomo@vger.kernel.org More majordomo info at
 KP> http://vger.kernel.org/majordomo-info.html Please read the
 KP> FAQ at http://www.tux.org/lkml/

 KP> --- BBBS/NT v4.01 Flag-5
 KP>  * Origin: FamilyNet Sponsored by
 KP> http://www.christian-wellness.net (8:8/2003)

I noticed the subject function appears in drivers/acpi/processor_idle.c
and tried a couple of things. Look OK? comments on the [misguided?] patch?
:-)
This seems to cut the acpi function time reported by readprofile
~85%, and changes the function from acpi_processor_set_power_policy to
acpi_processor_idle.

   260 total                                      0.0002
   251 acpi_processor_idle                        0.4163
     4 __copy_to_user_ll                          0.0625
     3 __unhash_process                           0.0170
     1 zap_page_range                             0.0042
     1 create_elf_tables                          0.0010

Note the tick has changed from 500 -> 250 HZ.

Apparently C1<->C2 transition works OK still:

active state:            C2
max_cstate:              C8
bus master activity:     00000000
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[000]
usage[00004380]
   *C2:                  type[C2] promotion[--] demotion[C1] latency[100]
usage[00381931]

--- processor_idle.c.orig       2005-06-08 13:05:11.000000000 -0500
+++ processor_idle.c    2005-06-08 16:59:06.000000000 -0500
@@ -67,7 +67,7 @@
  * 100 HZ: 0x0000000F: 4 jiffies = 40ms
  * reduce history for more aggressive entry into C3
  */
-static unsigned int bm_history = (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25))
- 1));
+static unsigned int bm_history = (HZ >= 500 ? 0xFFFFFFFF : ((1U << (HZ / 25))
- 1));
 module_param(bm_history, uint, 0644);
 /* --------------------------------------------------------------------------
                                 Power Management
@@ -336,7 +336,7 @@
                        cx->promotion.count++;
                        cx->demotion.count = 0;
                        if (cx->promotion.count >= cx->promotion.threshold.coun
-                               if (pr->flags.bm_check) {
+                               if (unlikely(pr->flags.bm_check)) {
                                        if (!(pr->power.bm_activity & cx->promo
                                                next_state = cx->promotion.stat
                                                goto end;
@@ -382,7 +382,7 @@
         * If we're going to start using a new Cx state we must clean up
         * from the previous and prepare to use the new.
         */
-       if (next_state != pr->power.state)
+       if (unlikely(next_state != pr->power.state))
                acpi_processor_power_activate(pr, next_state);

        return;
@@ -446,8 +446,6 @@
                        cx->demotion.state = lower;
                        cx->demotion.threshold.ticks = cx->latency_ticks;
                        cx->demotion.threshold.count = 1;
-                       if (cx->type == ACPI_STATE_C3)
-                               cx->demotion.threshold.bm = bm_history;
                }

                lower = cx;
@@ -462,12 +460,7 @@
                if (higher) {
                        cx->promotion.state  = higher;
                        cx->promotion.threshold.ticks = cx->latency_ticks;
-                       if (cx->type >= ACPI_STATE_C2)
-                               cx->promotion.threshold.count = 4;
-                       else
                                cx->promotion.threshold.count = 10;
-                       if (higher->type == ACPI_STATE_C3)
-                               cx->promotion.threshold.bm = bm_history;
                }

                higher = cx;

...  "Will he say nasty things at my funeral?"  -- Ezra Pound
--- MultiMail/Linux v0.46
