Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTL3WIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265832AbTL3WHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:07:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:45761 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265817AbTL3WG1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:27 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <1072821972731@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:12 -0800
Message-Id: <10728219722179@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.9.2, 2003/12/04 13:35:42-08:00, khali@linux-fr.org

[PATCH] I2C: Fix i2c-algo-bit for adapers that cannot read SCL back

Here follows a patch to i2c-algo-bit.c as found in linux-2.6.0-test9,
with two fixes for adapters that cannot read SCL back. Althouth real
adapters should be able to read SCL back, there are some that
cannot, for example the ADM1032 evaluation board I am using. Such
adapters where supposed to be already supported, but I found a probable
bug and improved support.

These changes were applied to our i2c CVS repository two weeks ago and
have been reviewed by Mark D. Studebaker.

List of changes:

* Fix sclhi() for adapters that do not have getscl().
* Enable bit_test for adapters that do not have getscl().
* Mostly rewrite test_bus(), cleaner and probably faster.


 drivers/i2c/algos/i2c-algo-bit.c |   96 ++++++++++++++++++++-------------------
 1 files changed, 50 insertions(+), 46 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
--- a/drivers/i2c/algos/i2c-algo-bit.c	Tue Dec 30 12:32:32 2003
+++ b/drivers/i2c/algos/i2c-algo-bit.c	Tue Dec 30 12:32:32 2003
@@ -18,10 +18,8 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
 /* ------------------------------------------------------------------------- */
 
-/* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
-   Frodo Looijaard <frodol@dds.nl> */
-
-/* $Id: i2c-algo-bit.c,v 1.44 2003/01/21 08:08:16 kmalkki Exp $ */
+/* With some changes from Frodo Looijaard <frodol@dds.nl>, Kyösti Mälkki
+   <kmalkki@cc.hut.fi> and Jean Delvare <khali@linux-fr.org> */
 
 /* #define DEBUG 1 */
 
@@ -87,8 +85,10 @@
 	setscl(adap,1);
 
 	/* Not all adapters have scl sense line... */
-	if (adap->getscl == NULL )
+	if (adap->getscl == NULL ) {
+		udelay(adap->udelay);
 		return 0;
+	}
 
 	start=jiffies;
 	while (! getscl(adap) ) {	
@@ -222,68 +222,72 @@
  */
 static int test_bus(struct i2c_algo_bit_data *adap, char* name) {
 	int scl,sda;
+
+	if (adap->getscl==NULL)
+		printk(KERN_INFO "i2c-algo-bit.o: Testing SDA only, "
+			"SCL is not readable.\n");
+
 	sda=getsda(adap);
-	if (adap->getscl==NULL) {
-		printk(KERN_WARNING "i2c-algo-bit.o: Warning: Adapter can't read from clock line - skipping test.\n");
-		return 0;		
-	}
-	scl=getscl(adap);
-	printk(KERN_INFO "i2c-algo-bit.o: Adapter: %s scl: %d  sda: %d -- testing...\n",
-	       name,getscl(adap),getsda(adap));
+	scl=(adap->getscl==NULL?1:getscl(adap));
+	printk(KERN_DEBUG "i2c-algo-bit.o: (0) scl=%d, sda=%d\n",scl,sda);
 	if (!scl || !sda ) {
-		printk(KERN_INFO " i2c-algo-bit.o: %s seems to be busy.\n",name);
+		printk(KERN_WARNING "i2c-algo-bit.o: %s seems to be busy.\n", name);
 		goto bailout;
 	}
+
 	sdalo(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:1 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 != getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck high!\n",name);
-		sdahi(adap);
+	sda=getsda(adap);
+	scl=(adap->getscl==NULL?1:getscl(adap));
+	printk(KERN_DEBUG "i2c-algo-bit.o: (1) scl=%d, sda=%d\n",scl,sda);
+	if ( 0 != sda ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SDA stuck high!\n");
 		goto bailout;
 	}
-	if ( 0 == getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while pulling SDA low!\n",
-			name);
+	if ( 0 == scl ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SCL unexpected low "
+			"while pulling SDA low!\n");
 		goto bailout;
 	}		
+
 	sdahi(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:2 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 == getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck low!\n",name);
-		sdahi(adap);
+	sda=getsda(adap);
+	scl=(adap->getscl==NULL?1:getscl(adap));
+	printk(KERN_DEBUG "i2c-algo-bit.o: (2) scl=%d, sda=%d\n",scl,sda);
+	if ( 0 == sda ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SDA stuck low!\n");
 		goto bailout;
 	}
-	if ( 0 == getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while SDA high!\n",
-		       name);
-	goto bailout;
+	if ( 0 == scl ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SCL unexpected low "
+			"while pulling SDA high!\n");
+		goto bailout;
 	}
+
 	scllo(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:3 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 != getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck high!\n",name);
-		sclhi(adap);
+	sda=getsda(adap);
+	scl=(adap->getscl==NULL?0:getscl(adap));
+	printk(KERN_DEBUG "i2c-algo-bit.o: (3) scl=%d, sda=%d\n",scl,sda);
+	if ( 0 != scl ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SCL stuck high!\n");
 		goto bailout;
 	}
-	if ( 0 == getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while pulling SCL low!\n",
-			name);
+	if ( 0 == sda ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SDA unexpected low "
+			"while pulling SCL low!\n");
 		goto bailout;
 	}
+	
 	sclhi(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:4 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 == getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck low!\n",name);
-		sclhi(adap);
+	sda=getsda(adap);
+	scl=(adap->getscl==NULL?1:getscl(adap));
+	printk(KERN_DEBUG "i2c-algo-bit.o: (4) scl=%d, sda=%d\n",scl,sda);
+	if ( 0 == scl ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SCL stuck low!\n");
 		goto bailout;
 	}
-	if ( 0 == getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while SCL high!\n",
-			name);
+	if ( 0 == sda ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SDA unexpected low "
+			"while pulling SCL high!\n");
 		goto bailout;
 	}
 	printk(KERN_INFO "i2c-algo-bit.o: %s passed test.\n",name);

