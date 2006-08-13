Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWHMQSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWHMQSY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 12:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWHMQSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 12:18:24 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:27338 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751297AbWHMQSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 12:18:23 -0400
Date: Mon, 14 Aug 2006 01:20:03 +0900 (JST)
Message-Id: <20060814.012003.29576310.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: paulus@samba.org, chris@zankel.net, johnstul@us.ibm.com,
       a.zummo@towertech.it
Subject: prepare to kill wall_jiffies
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.18-rc4-mm1, now jiffies and wall_jiffies are always synced.
So we can kill wall_jiffies completely.

Looking how wall_jiffies is used now, I found a potential problem on
arch/ppc and arch/xtensa:

 		if (ntp_synced() &&
 		    xtime.tv_sec - last_rtc_update >= 659 &&
		    abs((xtime.tv_nsec/1000)-(1000000-1000000/HZ))<5000000/HZ &&
		    jiffies - wall_jiffies == 1) {
 
 			if (platform_set_rtc_time(xtime.tv_sec+1) == 0)
 				last_rtc_update = xtime.tv_sec+1;

The condition "jiffies - wall_jiffies == 1" might be correct for
kernel 2.4, but useless now.  So this RTC updating never work.

Though the "11 min RTC update" might be disappeared from the kernel in
the future (any real plan?), it is better to fix this condition
anyway, isn't it?

---
Atsushi Nemoto
