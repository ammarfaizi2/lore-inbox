Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVAHKPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVAHKPq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 05:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVAHKOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 05:14:03 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:53767 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261826AbVAHJci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 04:32:38 -0500
Date: Sat, 8 Jan 2005 10:34:49 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Simone Piunno <pioppo@ferrara.linux.it>, Jonas Munsin <jmunsin@iki.fi>
Cc: djg@pdp8.net, greg@kroah.com, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <20050108103449.345def67.khali@linux-fr.org>
In-Reply-To: <200501080150.44653.pioppo@ferrara.linux.it>
References: <200501080150.44653.pioppo@ferrara.linux.it>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simone,

> Today I've tried 2.6.10-mm2 compiled for x86_64 and found something
> bad. As soon as I modprobe it87 (one of the i2c sensors drivers) the
> CPU fan  completely halts and the CPU temperature skyrockets even
> while idle. For context:
> I have an Athlon64 3200+ on a Gigabyte K8VT800 motherboard (i2c_viapro
> module) running Gentoo compiled in x86_64 mode, it87 is controlled
> through ISA bus,  VT8237 ISA bridge.
> 
> The same setup doesn't show the problem on vanilla 2.6.10 and neither
> on the  last -mm I tried, which IIRC was 2.6.9-rc4-mm1.
> 
> After some tweaking, it looks like ACPI is not the problem (tried to
> look at  full debug trace, nothing appears when loading it87). 
> Instead, I've found I  can control the fan speed using
> /sys/devices/platform/i2c-0/0-0290/pwm1 and initially it is set to
> 225, but setting it to 0 the fan runs at max speed. Intermediate
> values works as well: the higher the value, the slower the fan.
> 
> I've google for this sysfs interface and found than everyone expects
> pwm*  values to have the reverse meaning: 255 should be max speed and
> 0 should halt  the fan.  So apparently the problem is really in the
> it87 driver, using the  wrong coefficient for this scale and therefore
> setting it to the wrong  default value.

Thanks a lot for the detective work. You are right, PWM control was
added very recently to the it87 driver in 2.6 (but is there for some
time alredy for 2.4 kernels in the lm_sensors project).

The 0-255 range happens to be in the correct "direction" for at least
one other board () so the it87 driver isn't plain wrong, more likely it
is a matter of how the chip was wired and (mis)configured by the
motherboard manufacturer. In particular, I suspect the fan polarity bit
not to be properly set on your board.

Could you please provide a dump of your it87 chip before loading the
it87 driver? "isadump 0x295 0x296" should tell you. I would also be
interested in a dump right after you load the driver if possible (but
don't burn your CPU for me).

Do you know what kind of it87 chip you do have? There are three of them,
IT8705F, IT8712F and a SIS950 clone (mostly similar to the IT8705F).

> Comparing drivers/i2c/chips/it87.c in 2.6.10 vanilla and 2.6.10-mm2,
> I've  found only -mm tree includes the pwm fan controller.  
> 
> I think a quick fix could be the following, but didn't try it.

Although it works for you, it probably breaks the driver for other
people, so it doesn't look like the correct fix. I'll propose a patch
after I see your chip dumps.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
