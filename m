Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTFCUVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbTFCUVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:21:33 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:35642 "EHLO
	mail-2.tiscali.it") by vger.kernel.org with ESMTP id S264108AbTFCUVc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:21:32 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Daniele Bellucci <dbellucci@mybox.it>
To: linux-kernel@vger.kernel.org
Subject: [DVB] PATCH: Handling failure of dvb_frontend_start in dvb_frontend_open [2.5.69-70]
Date: Tue, 3 Jun 2003 22:34:57 +0200
User-Agent: KMail/1.4.3
Cc: kernel-janitor-discuss@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306032234.57209.dbellucci@mybox.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies both to 2.5.69 and to 2.5.70


diff -urN linux-2.5.69-my/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.5.69/drivers/media/dvb/dvb-core/dvb_frontend.c
--- linux-2.5.69-my/drivers/media/dvb/dvb-core/dvb_frontend.c	2003-06-03 21:54:32.000000000 +0200
+++ linux-2.5.69/drivers/media/dvb/dvb-core/dvb_frontend.c	2003-06-03 22:08:07.000000000 +0200
@@ -20,6 +20,10 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
+ *
+ * Changes:
+ * 03/06/2003:   handling failure of dvb_frontend_start in dvb_frontend_open
+ *               Daniele Bellucci <bellucda@tiscali.it>.
  */
 
 #include <linux/sched.h>
@@ -527,20 +531,21 @@
 
 
 static
-void dvb_frontend_start (struct dvb_frontend_data *fe)
+pid_t dvb_frontend_start (struct dvb_frontend_data *fe)
 {
+	pid_t dvb_kthread;
 	dprintk ("%s\n", __FUNCTION__);
 
 	if (fe->thread)
 		dvb_frontend_stop (fe);
 
 	if (down_interruptible (&fe->sem))
-		return;
+		return -ERESTARTSYS;
 
 	fe->exit = 0;
 	fe->thread = (void*) ~0;
 
-	kernel_thread (dvb_frontend_thread, fe, 0);
+	return kernel_thread (dvb_frontend_thread, fe, 0);
 }
 
 
@@ -610,6 +615,7 @@
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend_data *fe = dvbdev->priv;
+	pid_t dvb_kthread;
 	int ret;
 
 	dprintk ("%s\n", __FUNCTION__);
@@ -618,12 +624,18 @@
 		return ret;
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
-		dvb_frontend_start (fe);
+		dvb_kthread = dvb_frontend_start (fe);
+		if (dvb_kthread < 0) {
+			ret = dvb_kthread;
+			dvb_generic_release(inode, file);
+			goto out;
+		}
+	}
 
 		/*  empty event queue */
 		fe->events.eventr = fe->events.eventw;
 	}
-	
+out:
 	return ret;
 }
 

please apply.

Daniele Bellucci.




