Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVAHAry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVAHAry (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVAHAry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:47:54 -0500
Received: from [195.110.122.101] ([195.110.122.101]:31934 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S261725AbVAHArk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:47:40 -0500
From: Simone Piunno <pioppo@ferrara.linux.it>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.10-mm2: it87 sensor driver stops CPU fan
Date: Sat, 8 Jan 2005 01:50:42 +0100
User-Agent: KMail/1.7.2
Cc: djg@pdp8.net, greg@kroah.com, sensors@stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-ID: 860314FC/C09E842C
X-Message: GnuPG/PGP5 are welcome
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501080150.44653.pioppo@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Today I've tried 2.6.10-mm2 compiled for x86_64 and found something bad.
As soon as I modprobe it87 (one of the i2c sensors drivers) the CPU fan 
completely halts and the CPU temperature skyrockets even while idle.
For context:
I have an Athlon64 3200+ on a Gigabyte K8VT800 motherboard (i2c_viapro module)
running Gentoo compiled in x86_64 mode, it87 is controlled through ISA bus, 
VT8237 ISA bridge.

The same setup doesn't show the problem on vanilla 2.6.10 and neither on the 
last -mm I tried, which IIRC was 2.6.9-rc4-mm1.

After some tweaking, it looks like ACPI is not the problem (tried to look at 
full debug trace, nothing appears when loading it87).  Instead, I've found I 
can control the fan speed using /sys/devices/platform/i2c-0/0-0290/pwm1 and
initially it is set to 225, but setting it to 0 the fan runs at max speed.
Intermediate values works as well: the higher the value, the slower the fan.

I've google for this sysfs interface and found than everyone expects pwm* 
values to have the reverse meaning: 255 should be max speed and 0 should halt 
the fan.  So apparently the problem is really in the it87 driver, using the 
wrong coefficient for this scale and therefore setting it to the wrong 
default value.

Comparing drivers/i2c/chips/it87.c in 2.6.10 vanilla and 2.6.10-mm2, I've 
found only -mm tree includes the pwm fan controller.  

I think a quick fix could be the following, but didn't try it.

--- drivers/i2c/chips/it87.c    2005-01-07 15:13:52.000000000 +0100
+++ drivers/i2c/chips/it87.c.new        2005-01-08 01:41:16.000000000 +0100
@@ -163,8 +163,8 @@

 #define ALARMS_FROM_REG(val) (val)

-#define PWM_TO_REG(val)   ((val) >> 1)
-#define PWM_FROM_REG(val) (((val)&0x7f) << 1)
+#define PWM_TO_REG(val)   ((255-val) >> 1)
+#define PWM_FROM_REG(val) (255-(((val)&0x7f) << 1))

 static int DIV_TO_REG(int val)
 {

Regards,
  Simone Piunno
-- 
http://thisurlenablesemailtogetthroughoverzealousspamfilters.org
