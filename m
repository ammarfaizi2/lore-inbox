Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVDAUFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVDAUFO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVDAUFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:05:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:34760 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262865AbVDAUEZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:04:25 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Move functionality handling from i2c-core to i2c.h
In-Reply-To: <11123858541382@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 12:04:15 -0800
Message-Id: <11123858552208@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2340, 2005/04/01 11:49:04-08:00, khali@linux-fr.org

[PATCH] I2C: Move functionality handling from i2c-core to i2c.h

So far, the functionality handling of i2c adapters was done in i2c-core
by two exported functions: i2c_get_functionality and
i2c_check_functionality. I found that both functions could be reduced to
one line each, and propose that we turn them into inline function in the
i2c.h header file, much like other i2c helper functions (e.g.
i2c_get_clientdata, i2c_set_clientdata and i2c_clientname).

The conversion of i2c_get_functionality suppresses a legacy check which
shouldn't be needed anymore. Only one driver (s3c2410) was still relying
on it, and was fixed some days ago.

The conversion lets us get rid of two exports. Not only i2c-core gets
smaller (by 458 bytes), but the client drivers using these functions get
smaller too (typically by 48 bytes). And of course the new way is likely
to be faster too, even if it wasn't my primary objective.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/i2c-core.c |   19 -------------------
 include/linux/i2c.h    |   10 ++++++++--
 2 files changed, 8 insertions(+), 21 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2005-04-01 11:53:08 -08:00
+++ b/drivers/i2c/i2c-core.c	2005-04-01 11:53:08 -08:00
@@ -1236,22 +1236,6 @@
 }
 
 
-/* You should always define `functionality'; the 'else' is just for
-   backward compatibility. */ 
-u32 i2c_get_functionality (struct i2c_adapter *adap)
-{
-	if (adap->algo->functionality)
-		return adap->algo->functionality(adap);
-	else
-		return 0xffffffff;
-}
-
-int i2c_check_functionality (struct i2c_adapter *adap, u32 func)
-{
-	u32 adap_func = i2c_get_functionality (adap);
-	return (func & adap_func) == func;
-}
-
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
@@ -1282,9 +1266,6 @@
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
-
-EXPORT_SYMBOL(i2c_get_functionality);
-EXPORT_SYMBOL(i2c_check_functionality);
 
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-04-01 11:53:08 -08:00
+++ b/include/linux/i2c.h	2005-04-01 11:53:08 -08:00
@@ -368,10 +368,16 @@
 
 
 /* Return the functionality mask */
-extern u32 i2c_get_functionality (struct i2c_adapter *adap);
+static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
+{
+	return adap->algo->functionality(adap);
+}
 
 /* Return 1 if adapter supports everything we need, 0 if not. */
-extern int i2c_check_functionality (struct i2c_adapter *adap, u32 func);
+static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
+{
+	return (func & i2c_get_functionality(adap)) == func;
+}
 
 /*
  * I2C Message - used for pure i2c transaction, also from /dev interface

