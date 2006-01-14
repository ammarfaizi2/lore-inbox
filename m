Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWANVUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWANVUJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWANVUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:20:09 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:56336 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750739AbWANVUH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:20:07 -0500
Date: Sat, 14 Jan 2006 22:20:32 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Andrey Borzenkov <arvidjaar@newmail.ru>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [lm-sensors] 2.6.15: lm90 0-004c: Register 0x13 read failed
 (-1)
Message-Id: <20060114222032.1c2ff252.khali@linux-fr.org>
In-Reply-To: <200601142223.35838.arvidjaar@newmail.ru>
References: <200601142223.35838.arvidjaar@newmail.ru>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

> Vanilla 2.6.15 on Toshiba Portege 4000. I get constant messages in dmesg:
> 
> i2c_adapter i2c-0: Error: command never completed
> lm90 0-004c: Register 0x1 read failed (-1)
> i2c_adapter i2c-0: Error: command never completed
> lm90 0-004c: Register 0x14 read failed (-1)
> i2c_adapter i2c-0: Error: command never completed
> lm90 0-004c: Register 0x8 read failed (-1)
> i2c_adapter i2c-0: Error: command never completed
> lm90 0-004c: Register 0x0 read failed (-1)
> 
> for quite a number of registers. Apparently I can read sensors just fine still 
> I am uneasy seeing those.

Before 2.6.15, the lm90 driver did not handle read errors in any way,
so they were probably already there, you simply were not aware of it.
However, I guess that you already had the "command never completed"
errors? These come from the i2c-ali1535 bus driver.

It would be possible to add a retry-on-failure mechanism in the lm90
driver. However, the real problem is more likely in the i2c-ali1535
driver so fixing this one driver would be preferable.

> eeprom-i2c-0-50
> Adapter: SMBus ALI1535 adapter at ef00
> Memory type:            SDR SDRAM DIMM
> Memory size (MB):       256
> 
> adm1032-i2c-0-4c
> Adapter: SMBus ALI1535 adapter at ef00
> M/B Temp:    +43°C  (low  =   -65°C, high =  +127°C)
> CPU Temp:  +47.6°C  (low  = +43.0°C, high = +51.0°C)   ALARM
> M/B Crit:   +127°C  (hyst =  +122°C)
> CPU Crit:   +100°C  (hyst =   +95°C)

Do you also have "command never completed" errors without an associated
error from the lm90 driver? This would suggest that the eeprom driver
too is triggering errors, which in turn would confirm that we need to
fix the i2c-ali1535 driver rather than adding a workaround to the lm90
driver.

It looks like the i2c-ali1535 driver as it exists in the lm_sensors CVS
repository (for Linux 2.4 kernels) did receive a major change in March
2005. These changes were supposed to "fix stability problems" (by
adding delay loops pretty much everywhere). They were never ported to
the Linux 2.6 version of the driver. Maybe we should try doing so now.

This is a 400 lines patch, porting it won't be trivial, I am not
familiar with this driver myself and I don't have a chip to test my
changes on, so if someone else wants to take his/her chance, go. If
not, I'll do it.

Andrey, will you be able to test a i2c-ali1535 patch if we come up with
one?

-- 
Jean Delvare
