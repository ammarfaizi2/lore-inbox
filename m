Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132180AbRCVUb1>; Thu, 22 Mar 2001 15:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132186AbRCVUbR>; Thu, 22 Mar 2001 15:31:17 -0500
Received: from mail-oak-3.pilot.net ([198.232.147.18]:50337 "EHLO
	mail03-oak.pilot.net") by vger.kernel.org with ESMTP
	id <S132185AbRCVUbJ>; Thu, 22 Mar 2001 15:31:09 -0500
Message-ID: <973C11FE0E3ED41183B200508BC7774C0124F06D@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <twoller@crystal.cirrus.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Incorrect mdelay() results on Power Managed Machines x86
Date: Thu, 22 Mar 2001 14:29:48 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: Certain Laptops (IBM Thinkpads is where i see the issue) reduce the
CPU frequency based upon whether the unit is on battery power or direct
power.  When the Linux kernel boots up, then the cpu_khz (time.c) value is
determined based upon the current cpu speed. But if the unit's power source
is subsequently changed (plugged into the power outlet from battery power;
or unplugged and moved to battery power), then the delay resulting from
mdelay() (i.e. udelay) is off by the same factor.  cpu_khz is only
calculated
during init/boot time, and not on a change in the power source.  This seems
to be a serious problem since the result is off by a factor of 4 in some
cases which impacts the mdelay() wait times in the same proportion (130 Mhz
cpu speed on battery and 500 Mhz CPU speed direct power, on an IBM
Thinkpad).

During resume the IBM thinkpad with the cs46xx driver needs to delay 700
milleseconds, so if the machine is booted up on battery power, then to
ensure that the delay is long enough, then a value of 3000 milleseconds is
must be programmed into the driver (3 seconds!).  all the mdelay and udelay
wait times are incorrect by the same factor, resulting in some serious
problems when attempting to wait specific delay times in other parts of the
driver.  

this issue seems like it would be a problem for quite a few drivers that are
used on laptops that need some fairly precise delays, but maybe this is only
an IBM Thinkpad issue.  I know that there have been some DMA timeout errors
when resuming on IBM Thinkpads and maybe these errors that have been seen
are due to the invalid delay times generated.  

solutions:
using schedule() during resume is not an option, as it causes an oops under
2.2, and causes a second resume to be entered in the pci_driver resume table
entry for some reason.  also, schedule() is not fine enough granularity for
some of the micro second delays needed.

re-initing by reinvoking time_init() on each resume cycle doesn't seem to be
an option that i can see.

Appreciate any responses or thoughts on the subject, 

Tom Woller
twoller@crystal.cirrus.com
Cirrus Logic/Crystal Semiconductor
(512) 912-3920

