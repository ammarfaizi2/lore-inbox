Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264571AbSIVWV2>; Sun, 22 Sep 2002 18:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264572AbSIVWV1>; Sun, 22 Sep 2002 18:21:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38159 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264571AbSIVWV0>;
	Sun, 22 Sep 2002 18:21:26 -0400
Message-ID: <3D8E437A.1050800@mandrakesoft.com>
Date: Sun, 22 Sep 2002 18:26:02 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK/GNU] kill schedule_timeout(0) uses
Content-Type: multipart/mixed;
 boundary="------------090008000300070602060501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090008000300070602060501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

GNU patch attached and CC'd to lkml to encourage an extra look-over 
being applying...


--------------090008000300070602060501
Content-Type: text/plain;
 name="misc-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.5.txt"

Linus, please do a

	bk pull http://gkernel.bkbits.net/misc-2.5

This will update the following files:

 drivers/cdrom/cdu31a.c    |    3 +--
 drivers/cdrom/sonycd535.c |    3 +--
 drivers/net/sb1000.c      |    8 ++++----
 drivers/net/sis900.c      |    4 ++--
 4 files changed, 8 insertions(+), 10 deletions(-)

through these ChangeSets:

<jgarzik@mandrakesoft.com> (02/09/22 1.598)
   s/schedule_timeout(0)/yield/ in cdu31a, sonycd535, sb1000, and sis900 drivers


--------------090008000300070602060501
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/cdrom/cdu31a.c b/drivers/cdrom/cdu31a.c
--- a/drivers/cdrom/cdu31a.c	Sun Sep 22 18:24:25 2002
+++ b/drivers/cdrom/cdu31a.c	Sun Sep 22 18:24:25 2002
@@ -386,8 +386,7 @@
 	unsigned long flags;
 
 	if (cdu31a_irq <= 0) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(0);
+		yield();
 	} else {		/* Interrupt driven */
 
 		save_flags(flags);
diff -Nru a/drivers/cdrom/sonycd535.c b/drivers/cdrom/sonycd535.c
--- a/drivers/cdrom/sonycd535.c	Sun Sep 22 18:24:25 2002
+++ b/drivers/cdrom/sonycd535.c	Sun Sep 22 18:24:25 2002
@@ -344,8 +344,7 @@
 sony_sleep(void)
 {
 	if (sony535_irq_used <= 0) {	/* poll */
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(0);
+		yield();
 	} else {	/* Interrupt driven */
 		cli();
 		enable_interrupts();
diff -Nru a/drivers/net/sb1000.c b/drivers/net/sb1000.c
--- a/drivers/net/sb1000.c	Sun Sep 22 18:24:25 2002
+++ b/drivers/net/sb1000.c	Sun Sep 22 18:24:25 2002
@@ -295,8 +295,8 @@
 	timeout = jiffies + TimeOutJiffies;
 	while (a & 0x80 || a & 0x40) {
 		/* a little sleep */
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(0);
+		yield();
+
 		a = inb(ioaddr[0] + 7);
 		if (jiffies >= timeout) {
 			printk(KERN_WARNING "%s: card_wait_for_busy_clear timeout\n",
@@ -319,8 +319,8 @@
 	timeout = jiffies + TimeOutJiffies;
 	while (a & 0x80 || !(a & 0x40)) {
 		/* a little sleep */
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(0);
+		yield();
+
 		a = inb(ioaddr[1] + 6);
 		if (jiffies >= timeout) {
 			printk(KERN_WARNING "%s: card_wait_for_ready timeout\n",
diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	Sun Sep 22 18:24:25 2002
+++ b/drivers/net/sis900.c	Sun Sep 22 18:24:25 2002
@@ -573,8 +573,8 @@
 
 	if(status & MII_STAT_LINK){
 		while (poll_bit) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(0);
+			yield();
+
 			poll_bit ^= (mdio_read(net_dev, sis_priv->cur_phy, MII_STATUS) & poll_bit);
 			if (jiffies >= timeout) {
 				printk(KERN_WARNING "%s: reset phy and link down now\n", net_dev->name);

--------------090008000300070602060501--

