Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbTB0TKn>; Thu, 27 Feb 2003 14:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTB0TKn>; Thu, 27 Feb 2003 14:10:43 -0500
Received: from zmamail01.zma.compaq.com ([161.114.64.101]:34565 "EHLO
	zmamail01.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S266224AbTB0TKl>; Thu, 27 Feb 2003 14:10:41 -0500
Date: Thu, 27 Feb 2003 13:23:30 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.63 cciss fix unlikely startup problem
Message-ID: <20030227072330.GA1020@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applies to 2.5.63

* Make cciss driver wait longer for board to enter simple mode to
  handle an unlikely corner case.  (Hot replace of failed 144GB
  drive in RAID 5 set at just the wrong time prior to driver loading
  can make the board take a longer than usual time to go into "simple
  mode".  Without the patch, the driver gives up too early, and consequently
  doesn't work.  (A reboot will generally "fix" it.)  This patch avoids
  the problem.
* Fix a couple ioctls to return EAGAIN instead of inappropriate EFAULT.
-- steve

--- linux-2.5.63/drivers/block/cciss.c~cciss_cfg_table_wait_for_RHAS21	2003-02-26 11:07:55.000000000 +0600
+++ linux-2.5.63-scameron/drivers/block/cciss.c	2003-02-27 13:11:12.000000000 +0600
@@ -99,7 +99,8 @@ static struct board_type products[] = {
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
-#define MAX_CONFIG_WAIT 1000 
+#define MAX_CONFIG_WAIT 30000 
+#define MAX_IOCTL_CONFIG_WAIT 1000
 
 #define READ_AHEAD 	 128
 #define NR_CMDS		 384 /* #commands that can be outstanding */
@@ -479,8 +480,7 @@ static int cciss_ioctl(struct inode *ino
                         &(c->cfgtable->HostWrite.CoalIntCount));
 		writel( CFGTBL_ChangeReq, c->vaddr + SA5_DOORBELL);
 
-		for(i=0;i<MAX_CONFIG_WAIT;i++)
-		{
+		for(i=0;i<MAX_IOCTL_CONFIG_WAIT;i++) {
 			if (!(readl(c->vaddr + SA5_DOORBELL) 
 					& CFGTBL_ChangeReq))
 				break;
@@ -488,8 +488,8 @@ static int cciss_ioctl(struct inode *ino
 			udelay(1000);
 		}	
 		spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
-		if (i >= MAX_CONFIG_WAIT)
-			return( -EFAULT);
+		if (i >= MAX_IOCTL_CONFIG_WAIT)
+			return -EAGAIN;
                 return(0);
         }
 	case CCISS_GETNODENAME:
@@ -526,8 +526,7 @@ static int cciss_ioctl(struct inode *ino
 			
 		writel( CFGTBL_ChangeReq, c->vaddr + SA5_DOORBELL);
 
-		for(i=0;i<MAX_CONFIG_WAIT;i++)
-		{
+		for(i=0;i<MAX_IOCTL_CONFIG_WAIT;i++) {
 			if (!(readl(c->vaddr + SA5_DOORBELL) 
 					& CFGTBL_ChangeReq))
 				break;
@@ -535,8 +534,8 @@ static int cciss_ioctl(struct inode *ino
 			udelay(1000);
 		}	
 		spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
-		if (i >= MAX_CONFIG_WAIT)
-			return( -EFAULT);
+		if (i >= MAX_IOCTL_CONFIG_WAIT)
+			return -EAGAIN;
                 return(0);
         }
 
@@ -2050,12 +2049,15 @@ static int cciss_pci_init(ctlr_info_t *c
 		&(c->cfgtable->HostWrite.TransportRequest));
 	writel( CFGTBL_ChangeReq, c->vaddr + SA5_DOORBELL);
 
-	for(i=0;i<MAX_CONFIG_WAIT;i++)
-	{
+	/* under certain very rare conditions, this can take awhile.
+	 * (e.g.: hot replace a failed 144GB drive in a RAID 5 set right
+	 * as we enter this code.) */
+	for(i=0;i<MAX_CONFIG_WAIT;i++) {
 		if (!(readl(c->vaddr + SA5_DOORBELL) & CFGTBL_ChangeReq))
 			break;
 		/* delay and try again */
-		udelay(1000);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(10);
 	}	
 
 #ifdef CCISS_DEBUG

_
