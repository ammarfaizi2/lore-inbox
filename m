Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUJJOyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUJJOyj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 10:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUJJOyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 10:54:39 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:39679 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S268310AbUJJOy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 10:54:29 -0400
Subject: Re: [PATCH]: pbook apm_emu.c fix remaining time when charging
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1097366985.5591.16.camel@gaston>
References: <1097352701.3483.12.camel@localhost>
	 <1097366985.5591.16.camel@gaston>
Content-Type: multipart/mixed; boundary="=-KXFbPjKH2Rp8iAiGFXsA"
Date: Sun, 10 Oct 2004 09:16:01 +0200
Message-Id: <1097392561.3419.7.camel@localhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KXFbPjKH2Rp8iAiGFXsA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-10-10 at 10:09 +1000, Benjamin Herrenschmidt wrote: 
> On Sun, 2004-10-10 at 06:11, Soeren Sonnenburg wrote:
[...] 
>                 if (amperage < 0) {
> +                       /* when less than 100mA are used the machine must be on AC and as it is 
> +                          not charging the battery is only slightly self decharging and thus full be definition */
> +                       if (amperage < 100) {
> 
> There must be something wrong in the above...

Yes you are right, I check for amperage < 0 first and then for 
amperage < 100. It should of course be amperage < -100 and is meant for
the case where one is on AC, battery was fully charged and which is now
slightly decharging by less than 100mA/min leading to a remaining time
being displayed of more than 700 hours left.

/proc/apm output with that patch (but wrong check amperage < 100):
0.5 1.1 0x00 0x01 0x00 0x01 99% 92276 min

/proc/apm output with new patch:
0.5 1.1 0x00 0x01 0x00 0x01 99% 0 min

This is the /proc/pmu/battery_0 equivalent.

flags      : 00000011
charge     : 3130
max_charge : 3148
current    : -2
voltage    : 16629
time rem.  : 5634000

Well it is a special case to be dealt with... one could aswell change
the flags from 'high battery' status to 'charging' or return -1 as the
remaining time... However the battery is fully charged but as the system
is on AC it is simply idling messing up the remaining time.

> +                                       time_units = (charge * 59) / (amperage * -1);
> +                               else
> +                                       time_units = (charge * 16440) / (amperage * -60);
> 
> Can you make sure also that amperage is never 0 ?

actually that is dealt with already as there is a check for both
amperage < 0 and for amperage > 0.

Soeren.
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

--=-KXFbPjKH2Rp8iAiGFXsA
Content-Disposition: attachment; filename=apm_emu_fix.diff
Content-Type: text/x-patch; name=apm_emu_fix.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- t/linux-2.6.9-rc3/drivers/macintosh/apm_emu.c	2004-09-30 05:05:41.000000000 +0200
+++ linux-2.6.9-rc3-sonne/drivers/macintosh/apm_emu.c	2004-10-10 08:46:33.000000000 +0200
@@ -440,6 +440,7 @@
 	char *		p = buf;
 	char		charging       = 0;
 	long		charge	       = -1;
+	long		max_charge	   = -1;
 	long		amperage       = 0;
 	unsigned long	btype          = 0;
 
@@ -450,9 +451,12 @@
 				percentage = 0;
 			if (charge < 0)
 				charge = 0;
+			if (max_charge < 0)
+				max_charge = 0;
 			percentage += (pmu_batteries[i].charge * 100) /
 				pmu_batteries[i].max_charge;
 			charge += pmu_batteries[i].charge;
+			max_charge += pmu_batteries[i].max_charge;
 			amperage += pmu_batteries[i].amperage;
 			if (btype == 0)
 				btype = (pmu_batteries[i].flags & PMU_BATT_TYPE_MASK);
@@ -461,13 +465,27 @@
 				charging++;
 		}
 	}
+
 	if (real_count) {
 		if (amperage < 0) {
+			/* when less than 100mA are used the machine must be on AC and as it is 
+			   not charging the battery is only slightly self decharging and thus full be definition */
+			if (amperage < -100) {
+				if (btype == PMU_BATT_TYPE_SMART)
+					time_units = (charge * 59) / (amperage * -1);
+				else
+					time_units = (charge * 16440) / (amperage * -60);
+			}
+			else
+				time_units = 0;
+		}
+		else if (amperage > 0 && max_charge >= charge) {
 			if (btype == PMU_BATT_TYPE_SMART)
-				time_units = (charge * 59) / (amperage * -1);
+				time_units = ( (max_charge - charge) * 59) / amperage;
 			else
-				time_units = (charge * 16440) / (amperage * -60);
+				time_units = ( (max_charge - charge) * 16440) / amperage;
 		}
+
 		percentage /= real_count;
 		if (charging > 0) {
 			battery_status = 0x03;
@@ -483,6 +501,7 @@
 			battery_flag = 0x01;
 		}
 	}
+
 	p += sprintf(p, "%s %d.%d 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
 		     driver_version,
 		     (FAKE_APM_BIOS_VERSION >> 8) & 0xff,

--=-KXFbPjKH2Rp8iAiGFXsA--

