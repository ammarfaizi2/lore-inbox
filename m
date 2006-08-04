Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWHDFoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWHDFoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWHDFng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:43:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50351 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030319AbWHDFn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:43:29 -0400
Date: Thu, 3 Aug 2006 22:38:52 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 05/23] scx200_acb: Fix the block transactions
Message-ID: <20060804053852.GF769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i2c-02-scx200_acb-fix-block-transactions.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jean Delvare <khali@linux-fr.org>

The scx200_acb i2c bus driver pretends to support SMBus block
transactions, but in fact it implements the more simple I2C block
transactions. Additionally, it lacks sanity checks on the length
of the block transactions, which could lead to a buffer overrun.

This fixes an oops reported by Alexander Atanasov:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114970382125094

Thanks to Ben Gardner for fixing my bugs :)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/busses/scx200_acb.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.17.7.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2.6.17.7/drivers/i2c/busses/scx200_acb.c
@@ -304,8 +304,12 @@ static s32 scx200_acb_smbus_xfer(struct 
 		buffer = (u8 *)&cur_word;
 		break;
 
-	case I2C_SMBUS_BLOCK_DATA:
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (rw == I2C_SMBUS_READ)
+			data->block[0] = I2C_SMBUS_BLOCK_MAX; /* For now */
 		len = data->block[0];
+		if (len == 0 || len > I2C_SMBUS_BLOCK_MAX)
+			return -EINVAL;
 		buffer = &data->block[1];
 		break;
 
@@ -369,7 +373,7 @@ static u32 scx200_acb_func(struct i2c_ad
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	       I2C_FUNC_SMBUS_BLOCK_DATA;
+	       I2C_FUNC_SMBUS_I2C_BLOCK;
 }
 
 /* For now, we only handle combined mode (smbus) */

--
