Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268522AbTGLVUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 17:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbTGLVUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 17:20:33 -0400
Received: from c180224.adsl.hansenet.de ([213.39.180.224]:19352 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S268522AbTGLVUa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 17:20:30 -0400
Message-ID: <3F107F0F.40701@portrix.net>
Date: Sat, 12 Jul 2003 23:35:11 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Three drivers/i2c/ patches 
Content-Type: multipart/mixed;
 boundary="------------050200050702060500040503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050200050702060500040503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

these are 2 patches to the drivers/i2c subdirectory.

The first patch removes a warning from i2c-algo-bit.c, which I get 
regularly with my tv cards. It's more an info than a failure and 
spamming the logs at a rate of about 1/min. It indicates a send failure 
on the i2c bus or a miss of the ACK. Technically I think, it should 
resend the message, shouldn't it?

The second patch removes the cli/sti usage from i2c-elektor. It's only 
used to protect pcf_pending from changing. I replaced it (hopefully 
correct) with a spinlock.

The third patch is actually a resend and converts w83781d to use milli 
Celsius instead of centi Celsius.

Thanks,

Jan



-- 
Linux rubicon 2.5.75-mm1-jd10 #1 SMP Sat Jul 12 19:40:28 CEST 2003 i686

--------------050200050702060500040503
Content-Type: text/plain;
 name="i2c-algo-bit.remove.warning2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c-algo-bit.remove.warning2"

--- linux-bk/drivers/i2c/i2c-algo-bit.c	Mon May  5 01:53:31 2003
+++ 2.5.75-bk1-jd2/drivers/i2c/i2c-algo-bit.c	Sat Jul 12 23:22:01 2003
@@ -347,7 +347,6 @@
 			temp++;
 			wrcount++;
 		} else { /* arbitration or no acknowledge */
-			dev_err(&i2c_adap->dev, "sendbytes: error - bailout.\n");
 			i2c_stop(adap);
 			return (retval<0)? retval : -EFAULT;
 			        /* got a better one ?? */

--------------050200050702060500040503
Content-Type: text/plain;
 name="i2c_elektor_remove_cli_sti"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_elektor_remove_cli_sti"

This removes cli/sti from i2c-elektor which protected pcf_pending from changing.
Replaced by a spinlock instead.

Jan

diff -urN -X exclude linux-bk/drivers/i2c/i2c-elektor.c 2.5.75-bk1/drivers/i2c/i2c-elektor.c
--- linux-bk/drivers/i2c/i2c-elektor.c	Sun Jun 15 14:04:13 2003
+++ 2.5.75-bk1/drivers/i2c/i2c-elektor.c	Sat Jul 12 11:51:34 2003
@@ -59,6 +59,8 @@
   need to be rewriten - but for now just remove this for simpler reading */
 
 static wait_queue_head_t pcf_wait;
+
+spinlock_t pcf_pending_lock = SPIN_LOCK_UNLOCKED;
 static int pcf_pending;
 
 /* ----- global defines -----------------------------------------------	*/
@@ -120,12 +122,12 @@
 	int timeout = 2;
 
 	if (irq > 0) {
-		cli();
+		spin_lock_irq(&pcf_pending_lock);
 		if (pcf_pending == 0) {
 			interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
 		} else
 			pcf_pending = 0;
-		sti();
+		spin_unlock_irq(&pcf_pending_lock);
 	} else {
 		udelay(100);
 	}
@@ -133,8 +135,11 @@
 
 
 static irqreturn_t pcf_isa_handler(int this_irq, void *dev_id, struct pt_regs *regs) {
+	unsigned long flags;
+	spin_lock_irqsave(&pcf_pending_lock, flags);
 	pcf_pending = 1;
 	wake_up_interruptible(&pcf_wait);
+	spin_unlock_irqrestore(&pcf_pending_lock, flags);
 	return IRQ_HANDLED;
 }
 

--------------050200050702060500040503
Content-Type: text/plain;
 name="i2c.w83781d.temp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c.w83781d.temp"

--- linux-mm/drivers/i2c/chips/w83781d.c	2003-07-03 15:17:37.000000000 +0200
+++ 2.5.73-mm3/drivers/i2c/chips/w83781d.c	2003-07-10 13:43:49.000000000 +0200
@@ -496,13 +496,13 @@
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		if (data->type == as99127f) { \
 			return sprintf(buf,"%ld\n", \
-				(long)AS99127_TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
+				(long)AS99127_TEMP_ADD_FROM_REG(data->reg##_add[nr-2])*10); \
 		} else { \
 			return sprintf(buf,"%ld\n", \
-				(long)TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
+				(long)TEMP_ADD_FROM_REG(data->reg##_add[nr-2])*10); \
 		} \
 	} else {	/* TEMP1 */ \
-		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
+		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)*10); \
 	} \
 }
 show_temp_reg(temp);
@@ -516,7 +516,7 @@
 	struct w83781d_data *data = i2c_get_clientdata(client); \
 	u32 val; \
 	 \
-	val = simple_strtoul(buf, NULL, 10); \
+	val = simple_strtoul(buf, NULL, 10)/10; \
 	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		if (data->type == as99127f) \

--------------050200050702060500040503--

