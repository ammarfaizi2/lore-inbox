Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTEBMNk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 08:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTEBMNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 08:13:39 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:26853 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S262029AbTEBMN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 08:13:27 -0400
Date: Fri, 2 May 2003 14:24:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (3/3): Remove MOD_{INC,DEC}_USE_COUNT.
Message-ID: <20030502122457.GD6110@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT pairs.

diffstat:
 arch/s390/kernel/debug.c        |    3 ---
 drivers/s390/block/dasd_ioctl.c |    2 --
 drivers/s390/net/ctcmain.c      |    8 +++-----
 drivers/s390/net/iucv.c         |    8 +++-----
 4 files changed, 6 insertions(+), 15 deletions(-)

diff -urN linux-2.5.68/arch/s390/kernel/debug.c linux-2.5.68-s390/arch/s390/kernel/debug.c
--- linux-2.5.68/arch/s390/kernel/debug.c	Sun Apr 20 04:48:51 2003
+++ linux-2.5.68-s390/arch/s390/kernel/debug.c	Fri May  2 14:06:45 2003
@@ -586,7 +586,6 @@
 {
 	debug_info_t *rc = NULL;
 
-	MOD_INC_USE_COUNT;
 	if (!initialized)
 		BUG();
 	down(&debug_lock);
@@ -606,7 +605,6 @@
       out:
         if (rc == NULL){
 		printk(KERN_ERR "debug: debug_register failed for %s\n",name);
-		MOD_DEC_USE_COUNT;
         }
 	up(&debug_lock);
 	return rc;
@@ -628,7 +626,6 @@
 	debug_info_put(id);
 	up(&debug_lock);
 
-	MOD_DEC_USE_COUNT;
       out:
 	return;
 }
diff -urN linux-2.5.68/drivers/s390/block/dasd_ioctl.c linux-2.5.68-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.5.68/drivers/s390/block/dasd_ioctl.c	Sun Apr 20 04:49:57 2003
+++ linux-2.5.68-s390/drivers/s390/block/dasd_ioctl.c	Fri May  2 14:06:45 2003
@@ -59,7 +59,6 @@
 	new->no = no;
 	new->handler = handler;
 	list_add(&new->list, &dasd_ioctl_list);
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -76,7 +75,6 @@
 		return -EINVAL;
 	list_del(&old->list);
 	kfree(old);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
diff -urN linux-2.5.68/drivers/s390/net/ctcmain.c linux-2.5.68-s390/drivers/s390/net/ctcmain.c
--- linux-2.5.68/drivers/s390/net/ctcmain.c	Sun Apr 20 04:49:10 2003
+++ linux-2.5.68-s390/drivers/s390/net/ctcmain.c	Fri May  2 14:06:45 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.40 2003/04/08 16:00:17 mschwide Exp $
+ * $Id: ctcmain.c,v 1.41 2003/04/15 16:45:37 aberg Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.40 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.41 $
  *
  */
 
@@ -272,7 +272,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.40 $";
+	char vbuf[] = "$Revision: 1.41 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -2582,7 +2582,6 @@
 	file->private_data = kmalloc(STATS_BUFSIZE, GFP_KERNEL);
 	if (file->private_data == NULL)
 		return -ENOMEM;
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -2590,7 +2589,6 @@
 ctc_stat_close(struct inode *inode, struct file *file)
 {
 	kfree(file->private_data);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
diff -urN linux-2.5.68/drivers/s390/net/iucv.c linux-2.5.68-s390/drivers/s390/net/iucv.c
--- linux-2.5.68/drivers/s390/net/iucv.c	Sun Apr 20 04:48:50 2003
+++ linux-2.5.68-s390/drivers/s390/net/iucv.c	Fri May  2 14:06:45 2003
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.10 2003/03/28 08:54:40 mschwide Exp $
+ * $Id: iucv.c,v 1.11 2003/04/15 16:45:37 aberg Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.10 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.11 $
  *
  */
 
@@ -332,7 +332,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.10 $";
+	char vbuf[] = "$Revision: 1.11 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -842,7 +842,6 @@
 		}
 		register_flag = 1;
 	}
-	MOD_INC_USE_COUNT;
 	iucv_debug(1, "exiting");
 	return new_handler;
 }				/* end of register function */
@@ -903,7 +902,6 @@
 	iucv_remove_handler(h);
 	kfree(h);
 
-	MOD_DEC_USE_COUNT;
 	iucv_debug(1, "exiting");
 	return 0;
 }
