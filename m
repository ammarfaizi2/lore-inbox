Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbUK3PQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbUK3PQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbUK3PQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:16:32 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:43234 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262117AbUK3PJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:09:59 -0500
Date: Tue, 30 Nov 2004 16:09:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 5/6] s390: z/VM monitor stream.
Message-ID: <20041130150958.GF4758@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/6] s390: z/VM monitor stream.

From: Gerald Schaefer <geraldsc@de.ibm.com>

z/VM monitor stream changes:
 - Add monitor control element to deal with end-of-frame records.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 Documentation/s390/monreader.txt |   56 +++++++++++++++++++++++++++------------
 drivers/s390/char/monreader.c    |   31 ++++++++++++++++++---
 2 files changed, 65 insertions(+), 22 deletions(-)

diff -urN linux-2.6/Documentation/s390/monreader.txt linux-2.6-patched/Documentation/s390/monreader.txt
--- linux-2.6/Documentation/s390/monreader.txt	2004-11-30 14:02:59.000000000 +0100
+++ linux-2.6-patched/Documentation/s390/monreader.txt	2004-11-30 14:03:22.000000000 +0100
@@ -1,5 +1,5 @@
 
-Date  : 2004-Nov-04
+Date  : 2004-Nov-26
 Author: Gerald Schaefer (geraldsc@de.ibm.com)
 
 
@@ -72,7 +72,8 @@
 of the monitor DCSS, if already defined, and the users connected to the
 *MONITOR service.
 Refer to the "z/VM Performance" book (SC24-6109-00) on how to create a monitor
-DCSS, you need Class E privileges to define and save a DCSS.
+DCSS if your z/VM doesn't have one already, you need Class E privileges to
+define and save a DCSS.
 
 Example:
 --------
@@ -121,20 +122,41 @@
 
 Read:
 -----
-Reading from the device provides a set of one or more contiguous monitor
-records, there is no control data (unlike the CMS MONWRITE utility output).
-The monitor record layout can be found here (z/VM 5.1):
-http://www.vm.ibm.com/pubs/mon510/index.html
-
-Each set of records is exclusively composed of either event records or sample
-records. The end of such a set of records is indicated by a successful read
-with a return value of 0 (0-Byte read).
-Any received data must be considered invalid until a complete record set was
-read successfully, including the closing 0-Byte read. Therefore you should
+Reading from the device provides a 12 Byte monitor control element (MCE),
+followed by a set of one or more contiguous monitor records (similar to the
+output of the CMS utility MONWRITE without the 4K control blocks). The MCE
+contains information on the type of the following record set (sample/event
+data), the monitor domains contained within it and the start and end address
+of the record set in the monitor DCSS. The start and end address can be used
+to determine the size of the record set, the end address is the address of the
+last byte of data. The start address is needed to handle "end-of-frame" records
+correctly (domain 1, record 13), i.e. it can be used to determine the record
+start offset relative to a 4K page (frame) boundary.
+
+See "Appendix A: *MONITOR" in the "z/VM Performance" document for a description
+of the monitor control element layout. The layout of the monitor records can
+be found here (z/VM 5.1): http://www.vm.ibm.com/pubs/mon510/index.html
+
+The layout of the data stream provided by the monreader device is as follows:
+...
+<0 byte read>
+<first MCE>              \
+<first set of records>    |
+...                       |- data set
+<last MCE>                |
+<last set of records>    /
+<0 byte read>
+...
+
+There may be more than one combination of MCE and corresponding record set
+within one data set and the end of each data set is indicated by a successful
+read with a return value of 0 (0 byte read).
+Any received data must be considered invalid until a complete set was
+read successfully, including the closing 0 byte read. Therefore you should
 always read the complete set into a buffer before processing the data.
 
-The maximum size of a set of records can be as large as the size of the
-monitor DCSS, so design the buffer adequately or use dynamic memory allocation
+The maximum size of a data set can be as large as the size of the
+monitor DCSS, so design the buffer adequately or use dynamic memory allocation.
 The size of the monitor DCSS will be printed into syslog after loading the
 module. You can also use the (Class E privileged) CP command Q NSS MAP to
 list all available segments and information about them.
@@ -155,7 +177,7 @@
 
 In the last case (EOVERFLOW) there may be missing data, in the first two cases
 (EIO, EFAULT) there will be missing data. It's up to the application if it will
-continue reading subsequent records or rather exit.
+continue reading subsequent data or rather exit.
 
 Open:
 -----
@@ -163,8 +185,8 @@
 open function will fail (return a negative value) and set errno to EBUSY.
 The open function may also fail if an IUCV connection to the *MONITOR service
 cannot be established. In this case errno will be set to EIO and an error
-message with an IPUSER SEVER code will be printed into syslog.
-The IPUSER SEVER codes are described in the "z/VM Performance" book.
+message with an IPUSER SEVER code will be printed into syslog. The IPUSER SEVER
+codes are described in the "z/VM Performance" book, Appendix A.
 
 NOTE:
 -----
diff -urN linux-2.6/drivers/s390/char/monreader.c linux-2.6-patched/drivers/s390/char/monreader.c
--- linux-2.6/drivers/s390/char/monreader.c	2004-11-30 14:03:20.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/monreader.c	2004-11-30 14:03:22.000000000 +0100
@@ -238,6 +238,7 @@
 	atomic_dec(&monpriv->msglim_count);
 	if (likely(!monmsg->msglim_reached)) {
 		monmsg->pos = 0;
+		monmsg->mca_offset = 0;
 		monpriv->read_index = (monpriv->read_index + 1) %
 				      MON_MSGLIM;
 		atomic_dec(&monpriv->read_ready);
@@ -329,6 +330,7 @@
 		monmsg->replied_msglim = 0;
 		monmsg->msglim_reached = 0;
 		monmsg->pos = 0;
+		monmsg->mca_offset = 0;
 		P_WARNING("read, message limit reached\n");
 		monpriv->read_index = (monpriv->read_index + 1) %
 				      MON_MSGLIM;
@@ -501,6 +503,7 @@
 	struct mon_private *monpriv = filp->private_data;
 	struct mon_msg *monmsg;
 	int ret;
+	u32 mce_start;
 
 	monmsg = mon_next_message(monpriv);
 	if (IS_ERR(monmsg))
@@ -520,13 +523,28 @@
 	}
 
 	if (!monmsg->pos) {
-		monmsg->pos = mon_rec_start(monmsg);
+		monmsg->pos = mon_mca_start(monmsg) + monmsg->mca_offset;
 		mon_read_debug(monmsg, monpriv);
 	}
 	if (mon_check_mca(monmsg))
 		goto reply;
 
-	if (mon_rec_end(monmsg) > monmsg->pos) {
+	/* read monitor control element (12 bytes) first */
+	mce_start = mon_mca_start(monmsg) + monmsg->mca_offset;
+	if ((monmsg->pos >= mce_start) && (monmsg->pos < mce_start + 12)) {
+		count = min(count, (size_t) mce_start + 12 - monmsg->pos);
+		ret = copy_to_user(data, (void *) (unsigned long) monmsg->pos,
+				   count);
+		if (ret)
+			return -EFAULT;
+		monmsg->pos += count;
+		if (monmsg->pos == mce_start + 12)
+			monmsg->pos = mon_rec_start(monmsg);
+		goto out_copy;
+	}
+
+	/* read records */
+	if (monmsg->pos <= mon_rec_end(monmsg)) {
 		count = min(count, (size_t) mon_rec_end(monmsg) - monmsg->pos
 					    + 1);
 		ret = copy_to_user(data, (void *) (unsigned long) monmsg->pos,
@@ -534,14 +552,17 @@
 		if (ret)
 			return -EFAULT;
 		monmsg->pos += count;
-		*ppos += count;
-		if (mon_rec_end(monmsg) == monmsg->pos)
+		if (monmsg->pos > mon_rec_end(monmsg))
 			mon_next_mca(monmsg);
-		return count;
+		goto out_copy;
 	}
 reply:
 	ret = mon_send_reply(monmsg, monpriv);
 	return ret;
+
+out_copy:
+	*ppos += count;
+	return count;
 }
 
 static unsigned int
