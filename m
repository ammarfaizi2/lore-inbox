Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTB0QYy>; Thu, 27 Feb 2003 11:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTB0QYy>; Thu, 27 Feb 2003 11:24:54 -0500
Received: from zmamail02.zma.compaq.com ([161.114.64.102]:43525 "EHLO
	zmamail02.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S265470AbTB0QYw>; Thu, 27 Feb 2003 11:24:52 -0500
Date: Thu, 27 Feb 2003 10:37:41 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21-pre5 cciss fix unlikely startup problem
Message-ID: <20030227043741.GA812@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Make driver wait longer for board to enter simple mode to
  handle an unlikely corner case.  (If you hot replace a 144 GB
  failed disk in a RAID 5 set at just the right time prior to 
  driver initialization, the board can take an extra long time
  to become ready when switched into "simple mode" when the
  driver is starting up.  Without the patch, in those cases, the
  driver will give up before the board becomes ready, and will not work.  
  (Though rebooting will generally "fix" it).  This patch avoids
  the problem.)
* Fix a couple of affected ioctls to return EAGAIN instead of 
  inappropriate EFAULT.


--- lx2421p5/drivers/block/cciss.c~cfg_table_wait	2003-02-27 10:11:35.000000000 +0600
+++ lx2421p5-scameron/drivers/block/cciss.c	2003-02-27 10:11:35.000000000 +0600
@@ -94,7 +94,8 @@ static struct board_type products[] = {
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
-#define MAX_CONFIG_WAIT 1000 
+#define MAX_CONFIG_WAIT 30000 
+#define MAX_IOCTL_CONFIG_WAIT 1000
 
 /*define how many times we will try a command because of bus resets */
 #define MAX_CMD_RETRIES 3
@@ -578,7 +579,7 @@ static int cciss_ioctl(struct inode *ino
                         &(c->cfgtable->HostWrite.CoalIntCount));
 		writel( CFGTBL_ChangeReq, c->vaddr + SA5_DOORBELL);
 
-		for(i=0;i<MAX_CONFIG_WAIT;i++) {
+		for(i=0;i<MAX_IOCTL_CONFIG_WAIT;i++) {
 			if (!(readl(c->vaddr + SA5_DOORBELL) 
 					& CFGTBL_ChangeReq))
 				break;
@@ -586,8 +587,11 @@ static int cciss_ioctl(struct inode *ino
 			udelay(1000);
 		}	
 		spin_unlock_irqrestore(&io_request_lock, flags);
-		if (i >= MAX_CONFIG_WAIT)
-			return -EFAULT;
+		if (i >= MAX_IOCTL_CONFIG_WAIT)
+			/* there is an unlikely case where this can happen,
+			 * involving hot replacing a failed 144 GB drive in a 
+			 * RAID 5 set just as we attempt this ioctl. */
+			return -EAGAIN;
                 return 0;
         }
 	case CCISS_GETNODENAME:
@@ -627,7 +631,7 @@ static int cciss_ioctl(struct inode *ino
 			
 		writel( CFGTBL_ChangeReq, c->vaddr + SA5_DOORBELL);
 
-		for(i=0;i<MAX_CONFIG_WAIT;i++) {
+		for(i=0;i<MAX_IOCTL_CONFIG_WAIT;i++) {
 			if (!(readl(c->vaddr + SA5_DOORBELL) 
 					& CFGTBL_ChangeReq))
 				break;
@@ -635,8 +639,11 @@ static int cciss_ioctl(struct inode *ino
 			udelay(1000);
 		}	
 		spin_unlock_irqrestore(&io_request_lock, flags);
-		if (i >= MAX_CONFIG_WAIT)
-			return -EFAULT;
+		if (i >= MAX_IOCTL_CONFIG_WAIT)
+			/* there is an unlikely case where this can happen,
+			 * involving hot replacing a failed 144 GB drive in a 
+			 * RAID 5 set just as we attempt this ioctl. */
+			return -EAGAIN;
                 return 0;
         }
 
@@ -2583,11 +2590,17 @@ static int cciss_pci_init(ctlr_info_t *c
 		&(c->cfgtable->HostWrite.TransportRequest));
 	writel( CFGTBL_ChangeReq, c->vaddr + SA5_DOORBELL);
 
+	/* Here, we wait, possibly for a long time, (4 secs or more). 
+	 * In some unlikely cases, (e.g. A failed 144 GB drive in a 
+	 * RAID 5 set was hot replaced just as we're coming in here) it 
+	 * can take that long.  Normally (almost always) we will wait 
+	 * less than 1 sec. */
 	for(i=0;i<MAX_CONFIG_WAIT;i++) {
 		if (!(readl(c->vaddr + SA5_DOORBELL) & CFGTBL_ChangeReq))
 			break;
 		/* delay and try again */
-		udelay(1000);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(1);
 	}	
 
 #ifdef CCISS_DEBUG

_
