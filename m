Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751654AbWJTB1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbWJTB1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 21:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWJTB1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 21:27:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:24346 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751654AbWJTB1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 21:27:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding:from;
        b=XkybDACRs8XxEkmuq+CjDmMLOfgdb3AjXLMQbntek8Xjis5hq4gGAbcAKK43kYQFJC7DUp4AywFDVOUqxB3wiLU81/bO64wWY3hYWwbGDwzBJGKpKfzWYLL97/kpGuOHmMCkn41i02xek2Oks6eju6OwyHsa375z9z/yHxCW0Wk=
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Use time_after instead of comparisons for jiffies (TAKE 2)
Date: Thu, 19 Oct 2006 18:27:19 -0700
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610191827.19771.karhudever@gmial.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: David KOENIG <karhudever@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy found some issues with my patch, so here's the up to date one.  Sorry 
for the extra stuff.

---
 drivers/net/tokenring/3c359.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/tokenring/3c359.c b/drivers/net/tokenring/3c359.c
index 7580bde..8ebcef1 100644
--- a/drivers/net/tokenring/3c359.c
+++ b/drivers/net/tokenring/3c359.c
@@ -48,6 +48,7 @@ #include <linux/errno.h>
 #include <linux/timer.h>
 #include <linux/in.h>
 #include <linux/ioport.h>
+#include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
 #include <linux/ptrace.h>
@@ -409,7 +410,7 @@ static int xl_hw_reset(struct net_device
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
 		schedule();		
-		if(jiffies-t > 40*HZ) {
+		if(time_after(jiffies, t + 40 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL  card not responding to global 
reset.\n", dev->name);
 			return -ENODEV;
 		}
@@ -520,7 +521,7 @@ #endif
 	t=jiffies;
 	while ( !(readw(xl_mmio + MMIO_INTSTATUS_AUTO) & INTSTAT_SRB) ) { 
 		schedule();		
-		if(jiffies-t > 15*HZ) {
+		if(time_after(jiffies, t + 15 * HZ)) {
 			printk(KERN_ERR "3COM 3C359 Velocity XL  card not responding.\n");
 			return -ENODEV; 
 		}
@@ -795,8 +796,8 @@ static int xl_open_hw(struct net_device 
 
 	t=jiffies;
 	while (! (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_SRB)) { 
-		schedule();		
-		if(jiffies-t > 40*HZ) {
+		schedule();
+		if(time_after(jiffies, t + 40 * HZ) {
 			printk(KERN_ERR "3COM 3C359 Velocity XL  card not responding.\n");
 			break ; 
 		}
@@ -1010,8 +1011,8 @@ static void xl_reset(struct net_device *
 	 */
 
 	t=jiffies;
-	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
-		if(jiffies-t > 40*HZ) {
+	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) {
+		if(time_after(jiffies, t + 40 * HZ)) {
 			printk(KERN_ERR "3COM 3C359 Velocity XL  card not responding.\n");
 			break ; 
 		}
@@ -1282,8 +1283,8 @@ static int xl_close(struct net_device *d
     	writew(DNSTALL, xl_mmio + MMIO_COMMAND) ; 
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
-		schedule();		
-		if(jiffies-t > 10*HZ) {
+		schedule();
+		if(time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-DNSTALL not responding.\n", 
dev->name);
 			break ; 
 		}
@@ -1291,8 +1292,8 @@ static int xl_close(struct net_device *d
     	writew(DNDISABLE, xl_mmio + MMIO_COMMAND) ; 
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
-		schedule();		
-		if(jiffies-t > 10*HZ) {
+		schedule();
+		if(time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-DNDISABLE not responding.\n", 
dev->name);
 			break ;
 		}
@@ -1301,7 +1302,7 @@ static int xl_close(struct net_device *d
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
 		schedule();		
-		if(jiffies-t > 10*HZ) {
+		if(time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-UPSTALL not responding.\n", 
dev->name);
 			break ; 
 		}
@@ -1318,7 +1319,7 @@ static int xl_close(struct net_device *d
 	t=jiffies;
 	while (!(readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_SRB)) { 
 		schedule();		
-		if(jiffies-t > 10*HZ) {
+		if(time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-CLOSENIC not responding.\n", 
dev->name);
 			break ; 
 		}
@@ -1347,7 +1348,7 @@ static int xl_close(struct net_device *d
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
 		schedule();		
-		if(jiffies-t > 10*HZ) {
+		if(time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-UPRESET not responding.\n", 
dev->name);
 			break ; 
 		}
@@ -1356,7 +1357,7 @@ static int xl_close(struct net_device *d
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
 		schedule();		
-		if(jiffies-t > 10*HZ) {
+		if(time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-DNRESET not responding.\n", 
dev->name);
 			break ; 
 		}
-- 
1.4.1


-- 
<>< karhudever@gmail.com
