Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262154AbSJFRWW>; Sun, 6 Oct 2002 13:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262150AbSJFRVD>; Sun, 6 Oct 2002 13:21:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56068 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262146AbSJFRTo>; Sun, 6 Oct 2002 13:19:44 -0400
Subject: PATCH: 2.5.40 bring telephony in line with 2.4
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:16:40 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yF1E-0001t4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also note the pcmcia fix - I think the other pcmcia cards should be
using del_timer_sync, but seem not to be.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/telephony/ixj.c linux.2.5.40-ac5/drivers/telephony/ixj.c
--- linux.2.5.40/drivers/telephony/ixj.c	2002-07-20 20:11:06.000000000 +0100
+++ linux.2.5.40-ac5/drivers/telephony/ixj.c	2002-10-03 17:01:27.000000000 +0100
@@ -274,8 +274,8 @@
 
 #include "ixj.h"
 
-#define TYPE(dev) (MINOR(dev) >> 4)
-#define NUM(dev) (MINOR(dev) & 0xf)
+#define TYPE(dev) (minor(dev) >> 4)
+#define NUM(dev) (minor(dev) & 0xf)
 
 static int ixjdebug;
 static int hertz = HZ;
@@ -386,7 +386,7 @@
 #ifdef PERFMON_STATS
 #define ixj_perfmon(x)	((x)++)
 #else
-#define ixj_perfmon(x)	do {} while(0);
+#define ixj_perfmon(x)	do { } while(0)
 #endif
 
 static int ixj_convert_loaded;
@@ -2806,7 +2806,10 @@
 	};
 
 	while (len--)
-		*buff++ = table_ulaw2alaw[*(unsigned char *)buff];
+	{
+		*buff = table_ulaw2alaw[*(unsigned char *)buff];
+		buff++;
+	}
 }
 
 static void alaw2ulaw(unsigned char *buff, unsigned long len)
@@ -2848,7 +2851,10 @@
 	};
 
         while (len--)
-                *buff++ = table_alaw2ulaw[*(unsigned char *)buff];
+        {
+                *buff = table_alaw2ulaw[*(unsigned char *)buff];
+                buff++;
+	}
 }
 
 static ssize_t ixj_read(struct file * file_p, char *buf, size_t length, loff_t * ppos)
@@ -5943,7 +5949,7 @@
 	lcp = kmalloc(sizeof(IXJ_CADENCE), GFP_KERNEL);
 	if (lcp == NULL)
 		return -ENOMEM;
-	if (copy_from_user(lcp, (char *) cp, sizeof(IXJ_CADENCE)) || (unsigned)lcp->elements_used >= ~0U/sizeof(IXJ_CADENCE) )
+	if (copy_from_user(lcp, (char *) cp, sizeof(IXJ_CADENCE)) || (unsigned)lcp->elements_used >= ~0U/sizeof(IXJ_CADENCE_ELEMENT) )
         {
                 kfree(lcp);
                 return -EFAULT;
@@ -6202,7 +6208,7 @@
 	IXJ_FILTER_RAW jfr;
 
 	unsigned int raise, mant;
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor = minor(inode->i_rdev);
 	int board = NUM(inode->i_rdev);
 
 	IXJ *j = get_ixj(NUM(inode->i_rdev));
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/telephony/ixj.h linux.2.5.40-ac5/drivers/telephony/ixj.h
--- linux.2.5.40/drivers/telephony/ixj.h	2002-07-20 20:12:29.000000000 +0100
+++ linux.2.5.40-ac5/drivers/telephony/ixj.h	2002-10-03 14:16:49.000000000 +0100
@@ -1199,7 +1199,7 @@
 	unsigned char cid_play_flag;
 	char play_mode;
 	IXJ_FLAGS flags;
-	unsigned int busyflags;
+	unsigned long busyflags;
 	unsigned int rec_frame_size;
 	unsigned int play_frame_size;
 	unsigned int cid_play_frame_size;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/telephony/ixj_pcmcia.c linux.2.5.40-ac5/drivers/telephony/ixj_pcmcia.c
--- linux.2.5.40/drivers/telephony/ixj_pcmcia.c	2002-07-20 20:12:17.000000000 +0100
+++ linux.2.5.40-ac5/drivers/telephony/ixj_pcmcia.c	2002-10-03 14:46:12.000000000 +0100
@@ -98,7 +98,6 @@
 static void ixj_detach(dev_link_t * link)
 {
 	dev_link_t **linkp;
-	long flags;
 	int ret;
 	DEBUG(0, "ixj_detach(0x%p)\n", link);
 	for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
@@ -106,13 +105,8 @@
 			break;
 	if (*linkp == NULL)
 		return;
-	save_flags(flags);
-	cli();
-	if (link->state & DEV_RELEASE_PENDING) {
-		del_timer(&link->release);
-		link->state &= ~DEV_RELEASE_PENDING;
-	}
-	restore_flags(flags);
+	del_timer_sync(&link->release);
+	link->state &= ~DEV_RELEASE_PENDING;
 	if (link->state & DEV_CONFIG)
 		ixj_cs_release((u_long) link);
 	if (link->handle) {
