Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289631AbSBGQh0>; Thu, 7 Feb 2002 11:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289347AbSBGQhM>; Thu, 7 Feb 2002 11:37:12 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:38072 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289374AbSBGQgu>; Thu, 7 Feb 2002 11:36:50 -0500
Date: Thu, 7 Feb 2002 08:36:36 -0800
From: Dave Hansen <haveblue@us.ibm.com>
Message-Id: <200202071636.g17Gaax02463@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Removal of big kernel lock from isdn drivers [2/3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2 of 3

isdn.bkl-remove.ippp_lock.patch:
   added ippp_lock to ippp_struct
   * It appeared that the BKL was being used to guard the file struct's
     private data field, which is a ippp_struct.  I added a semaphore to
     that structure which can be locked instead of the BKL.
 
I've been examining the continuing additions of the big kernel lock 
(BKL) to the 2.5 tree.  I noticed that in 2.5.3, the ISDN subsystem 
added the BKL to several places.  In response to this, I have written 
several patches to attempt removal of the BKL from the ISDN subsystem. 
I have little knowledge of the drivers themselves, so I would like some 
assistance from those of you who understand them better.  I probably 
have an over-simplified view of the code, so my patches may be too 
simplistic. 

-- 
Dave Hansen
haveblue@us.ibm.com
--- linux-2.5.3-clean/drivers/isdn/isdn_ppp.c	Fri Feb  1 16:43:35 2002
+++ linux/drivers/isdn/isdn_ppp.c	Mon Feb  4 11:34:16 2002
@@ -329,7 +329,7 @@
 	int i;
 	struct ippp_struct *is;
 
-	lock_kernel();
+	down( ((ippp_struct*)file->private_data)->ippp_lock);
 
 	is = file->private_data;
 
@@ -385,7 +385,7 @@
 
 	isdn_unlock_drivers();
 	
-	unlock_kernel();
+	up(&is->ippp_lock)
 	return 0;
 }
 
@@ -588,7 +588,7 @@
 	unsigned long flags;
 	struct ippp_struct *is;
 
-	lock_kernel();
+	down( ((ippp_struct*)file->private_data)->ippp_lock);
 	is = file->private_data;
 
 	if (is->debug & 0x2)
@@ -624,7 +624,7 @@
 	restore_flags(flags);
 
  out:
-	unlock_kernel();
+	up(&is->ippp_lock);
 	return mask;
 }
 
@@ -702,7 +702,7 @@
 	if (off != &file->f_pos)
 		return -ESPIPE;
 	
-	lock_kernel();
+	down( ((ippp_struct*)file->private_data)->ippp_lock);
 
 	is = file->private_data;
 
@@ -737,7 +737,7 @@
 	retval = count;
 
  out:
-	unlock_kernel();
+	up(&is->ippp_lock);
 	return retval;
 }
 
@@ -757,7 +757,7 @@
 	if (off != &file->f_pos)
 		return -ESPIPE;
 
-	lock_kernel();
+	down( ((ippp_struct*)file->private_data)->ippp_lock);
 
 	is = file->private_data;
 
@@ -826,7 +826,7 @@
 	retval = count;
 	
  out:
-	unlock_kernel();
+	up(&is->ippp_lock);
 	return retval;
 }
 
--- linux-2.5.3-clean/drivers/isdn/isdn_ppp.c	Wed Feb  6 11:42:18 2002
+++ linux/drivers/isdn/isdn_ppp.c	Wed Feb  6 11:05:41 2002
@@ -866,6 +866,7 @@
 			return -1;
 		}
 		memset((char *) ippp_table[i], 0, sizeof(struct ippp_struct));
+		init_MUTEX(&ippp_table[i]->ippp_lock);
 		ippp_table[i]->state = 0;
 		ippp_table[i]->first = ippp_table[i]->rq + NUM_RCV_BUFFS - 1;
 		ippp_table[i]->last = ippp_table[i]->rq;
--- linux-2.5.3-clean/include/linux/isdn_ppp.h	Sun Sep 30 12:26:42 2001
+++ linux/include/linux/isdn_ppp.h	Mon Feb  4 11:34:16 2002
@@ -201,6 +201,7 @@
 };
 
 struct ippp_struct {
+  struct semaphore ippp_lock;
   struct ippp_struct *next_link;
   int state;
   struct ippp_buf_queue rq[NUM_RCV_BUFFS]; /* packet queue for isdn_ppp_read() */
