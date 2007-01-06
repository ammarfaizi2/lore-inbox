Return-Path: <linux-kernel-owner+w=401wt.eu-S1751103AbXAFCby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbXAFCby (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbXAFCbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:31:15 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36655 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbXAFCap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:30:45 -0500
Message-Id: <20070106023213.935679000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:11 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jean Delvare <khali@linux-fr.org>,
       Dirk Eibach <eibach@gdsys.de>, Adrian Bunk <bunk@stusta.de>,
       Dirk Stieler <stieler@gdsys.de>
Subject: [patch 18/50] i2c: fix broken ds1337 initialization
Content-Disposition: inline; filename=i2c-fix-broken-ds1337-initialization.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Dirk Eibach <eibach@gdsys.de>

On a custom board with ds1337 RTC I found that upgrade from 2.6.15 to
2.6.18 broke RTC support.

The main problem are changes to ds1337_init_client().
When a ds1337 recognizes a problem (e.g. power or clock failure) bit 7
in status register is set. This has to be reset by writing 0 to status
register. But since there are only 16 byte written to the chip and the
first byte is interpreted as an address, the status register (which is
the 16th) is never written.
The other problem is, that initializing all registers to zero is not
valid for day, date and month register. Funny enough this is checked by
ds1337_detect(), which depends on this values not being zero. So then
treated by ds1337_init_client() the ds1337 is not detected anymore,
whereas the failure bit in the status register is still set.

Broken by commit f9e8957937ebf60d22732a5ca9130f48a7603f60 (2.6.16-rc1,
2006-01-06). This fix is in Linus' tree since 2.6.20-rc1 (commit
763d9c046a2e511ec090a8986d3f85edf7448e7e).

Signed-off-by: Dirk Stieler <stieler@gdsys.de>
Signed-off-by: Dirk Eibach <eibach@gdsys.de>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/i2c/chips/ds1337.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.19.1.orig/drivers/i2c/chips/ds1337.c
+++ linux-2.6.19.1/drivers/i2c/chips/ds1337.c
@@ -347,13 +347,19 @@ static void ds1337_init_client(struct i2
 
 	if ((status & 0x80) || (control & 0x80)) {
 		/* RTC not running */
-		u8 buf[16];
+		u8 buf[1+16];	/* First byte is interpreted as address */
 		struct i2c_msg msg[1];
 
 		dev_dbg(&client->dev, "%s: RTC not running!\n", __FUNCTION__);
 
 		/* Initialize all, including STATUS and CONTROL to zero */
 		memset(buf, 0, sizeof(buf));
+
+		/* Write valid values in the date/time registers */
+		buf[1+DS1337_REG_DAY] = 1;
+		buf[1+DS1337_REG_DATE] = 1;
+		buf[1+DS1337_REG_MONTH] = 1;
+
 		msg[0].addr = client->addr;
 		msg[0].flags = 0;
 		msg[0].len = sizeof(buf);

--
