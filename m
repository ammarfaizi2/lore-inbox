Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVALRtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVALRtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 12:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVALRtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 12:49:16 -0500
Received: from gateway.penguincomputing.com ([64.243.132.186]:31128 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S261278AbVALRtF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 12:49:05 -0500
X-Mda: Mail::Internet Mail::Sendmail Sendmail +mmhack 1.1 on Linux
User-Agent: Mutt/1.4.1i
Subject: PATCH (take 3) for adm1026.c, kernel 2.6.10-bk14
In-Reply-To: <20050103221249.GB12765@penguincomputing.com>
Content-Disposition: inline
Date: Wed, 12 Jan 2005 10:50:55 -0800
Message-Id: <20050112185055.GB16724@penguincomputing.com>
References: <41D5D075.4000200@paradyne.com>
 <20050101001205.6b2a44d3.khali@linux-fr.org>
 <20050103194355.GA11979@penguincomputing.com>
 <20050103201056.3c55e330.khali@linux-fr.org>
 <20050103213707.GA12765@penguincomputing.com>
 <20050103205231.GK9923@schnapps.adilger.int>
 <20050103221249.GB12765@penguincomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: LM Sensors <sensors@Stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       khali@linux-fr.org
Content-Transfer-Encoding: 8BIT
From: Justin Thiessen <jthiessen@penguincomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, take 3 on the adm1026 patch.

In this patch:

(1) Code has been added which ensures that the fan divisor registers are 
    properly read into the data structure before fan minimum speeds are 
    determined.  This prevents a possible divide by zero error.  The line 
    which reads the hardware default fan divisor values has been reformatted 
    as suggested by Andreas Dilger to make the intent of the statement clearer.

(2) In a similar spirit, an unecessary carriage return from a "dev_dbg" 
    statement in the adm1026_print_gpio() function has been elminated,
    shortening the statement to a single line and making the code easier
    to read.

Signed-off-by: Justin Thiessen <jthiessen@penguincomputing.com

---------------------------------------

--- linux-2.6.10/drivers/i2c/chips/adm1026.c.orig	2005-01-12 10:28:15.000000000 -0800
+++ linux-2.6.10/drivers/i2c/chips/adm1026.c	2005-01-12 10:30:02.000000000 -0800
@@ -452,6 +452,14 @@ void adm1026_init_client(struct i2c_clie
 		client->id, value);
 	data->config1 = value;
 	adm1026_write_value(client, ADM1026_REG_CONFIG1, value);
+
+	/* initialize fan_div[] to hardware defaults */
+	value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3) |
+		(adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7) << 8);
+	for (i = 0;i <= 7;++i) {
+		data->fan_div[i] = DIV_FROM_REG(value & 0x03);
+		value >>= 2;
+	}
 }
 
 void adm1026_print_gpio(struct i2c_client *client)
@@ -459,8 +467,7 @@ void adm1026_print_gpio(struct i2c_clien
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int  i;
 
-	dev_dbg(&client->dev, "(%d): GPIO config is:",
-			    client->id);
+	dev_dbg(&client->dev, "(%d): GPIO config is:", client->id);
 	for (i = 0;i <= 7;++i) {
 		if (data->config2 & (1 << i)) {
 			dev_dbg(&client->dev, "\t(%d): %sGP%s%d\n", client->id,



