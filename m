Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWDUEvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWDUEvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWDUEvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:51:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:46977 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932226AbWDUEoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:04 -0400
Date: Thu, 20 Apr 2006 21:38:04 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 06/22] i2c-i801: Fix resume when PEC is used
Message-ID: <20060421043804.GG12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i2c-i801-fix-resume-when-pec-is-used.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for bug #6395:
Fail to resume on Tecra M2 with ADM1032 and Intel 82801DBM

The BIOS of the Tecra M2 doesn't like it when it has to reboot or
resume after the i2c-i801 driver has left the SMBus in PEC mode.
I have a more complete fix for 2.6.17 but the simple approach of
leaving the SMBus in non-PEC mode after every transaction should do
for -stable. That's what the i2c-i801 driver was doing up to 2.6.15
(inclusive).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/busses/i2c-i801.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.16.9.orig/drivers/i2c/busses/i2c-i801.c
+++ linux-2.6.16.9/drivers/i2c/busses/i2c-i801.c
@@ -478,6 +478,11 @@ static s32 i801_access(struct i2c_adapte
 		ret = i801_transaction();
 	}
 
+	/* Some BIOSes don't like it when PEC is enabled at reboot or resume
+	   time, so we forcibly disable it after every transaction. */
+	if (hwpec)
+		outb_p(0, SMBAUXCTL);
+
 	if(block)
 		return ret;
 	if(ret)

--
