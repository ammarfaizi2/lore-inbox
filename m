Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWFFQ6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWFFQ6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWFFQ6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:58:50 -0400
Received: from khc.piap.pl ([195.187.100.11]:30469 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750737AbWFFQ6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:58:50 -0400
To: Jean Delvare <khali@linux-fr.org>
Cc: <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org
Subject: [PATCH] I2C: i2c_bit_add_bus should initialize SDA and SCL lines
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 06 Jun 2006 18:58:46 +0200
Message-ID: <m34pyyz0e1.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another thing: I noticed the i2c_bit_add_bus doesn't set SDA and SCL
lines to a known levels. If the hw driver set them to 1 all is fine
and the first START condition is detected correctly. But if they're
set differently (for example, if both are zero), the START will not
work.

I'm not sure if the following patch isn't an overkill, though, and
if the lack of initialization is a real problem which shows in
practice and not only on my analyzer.

In case you think it's needed:

This patch makes i2c_bit_add_bus() initialize SDA and SCL lines
as required by subsequent START condition.

Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -544,6 +544,13 @@ int i2c_bit_add_bus(struct i2c_adapter *
 	adap->timeout = 100;	/* default values, should	*/
 	adap->retries = 3;	/* be replaced by defines	*/
 
+	setsda(bit_adap, 0);	/* may mean START if SCL = 1 */
+	udelay(bit_adap->udelay);
+	setscl(bit_adap, 1);	/* may clock a zero bit in */
+	udelay(bit_adap->udelay);
+	setsda(bit_adap, 1);	/* STOP */
+	udelay(bit_adap->udelay);
+
 	i2c_add_adapter(adap);
 	return 0;
 }
