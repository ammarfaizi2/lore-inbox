Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbUKQEl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbUKQEl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbUKQEk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:40:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1804 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262207AbUKQEfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:35:23 -0500
Date: Wed, 17 Nov 2004 05:32:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] telephony/ixj.c cleanup (fwd)
Message-ID: <20041117043231.GI4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below still applies and compiles against 2.6.10-rc2-mm1.

Please apply.



----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 31 Oct 2004 00:38:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] telephony/ixj.c cleanup

The patch below does:
- remove ixj_register and ixj_unregister
  these were EXPORT_SYMBOL'ed static (sic) functions
  it seems the only reason why this "worked" was that there were exactly
  zero users of them...
- remove four local variables that are after this removal no longer 
  required
- make five functions that were needlessly global static


diffstat output:
 drivers/telephony/ixj.c |  105 +---------------------------------------
 1 files changed, 5 insertions(+), 100 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/drivers/telephony/ixj.c.old	2004-10-31 00:10:49.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/telephony/ixj.c	2004-10-31 00:23:17.000000000 +0200
@@ -406,14 +406,10 @@
 	return 0;
 }
 
-static IXJ_REGFUNC ixj_DownloadG729 = &Stub;
-static IXJ_REGFUNC ixj_DownloadTS85 = &Stub;
 static IXJ_REGFUNC ixj_PreRead = &Stub;
 static IXJ_REGFUNC ixj_PostRead = &Stub;
 static IXJ_REGFUNC ixj_PreWrite = &Stub;
 static IXJ_REGFUNC ixj_PostWrite = &Stub;
-static IXJ_REGFUNC ixj_PreIoctl = &Stub;
-static IXJ_REGFUNC ixj_PostIoctl = &Stub;
 
 static void ixj_read_frame(IXJ *j);
 static void ixj_write_frame(IXJ *j);
@@ -792,97 +788,6 @@
 	return 0;
 }
 
-static int ixj_register(int index, IXJ_REGFUNC regfunc)
-{
-	int cnt;
-	int retval = 0;
-	switch (index) {
-	case G729LOADER:
-		ixj_DownloadG729 = regfunc;
-		for (cnt = 0; cnt < IXJMAX; cnt++) {
-			IXJ *j = get_ixj(cnt);
-			while(test_and_set_bit(cnt, (void *)&j->busyflags) != 0) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(1);
-			}
-			ixj_DownloadG729(j, 0L);
-			clear_bit(cnt, &j->busyflags);
-		}
-		break;
-	case TS85LOADER:
-		ixj_DownloadTS85 = regfunc;
-		for (cnt = 0; cnt < IXJMAX; cnt++) {
-			IXJ *j = get_ixj(cnt);
-			while(test_and_set_bit(cnt, (void *)&j->busyflags) != 0) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(1);
-			}
-			ixj_DownloadTS85(j, 0L);
-			clear_bit(cnt, &j->busyflags);
-		}
-		break;
-	case PRE_READ:
-		ixj_PreRead = regfunc;
-		break;
-	case POST_READ:
-		ixj_PostRead = regfunc;
-		break;
-	case PRE_WRITE:
-		ixj_PreWrite = regfunc;
-		break;
-	case POST_WRITE:
-		ixj_PostWrite = regfunc;
-		break;
-	case PRE_IOCTL:
-		ixj_PreIoctl = regfunc;
-		break;
-	case POST_IOCTL:
-		ixj_PostIoctl = regfunc;
-		break;
-	default:
-		retval = 1;
-	}
-	return retval;
-}
-
-EXPORT_SYMBOL(ixj_register);
-
-static int ixj_unregister(int index)
-{
-	int retval = 0;
-	switch (index) {
-	case G729LOADER:
-		ixj_DownloadG729 = &Stub;
-		break;
-	case TS85LOADER:
-		ixj_DownloadTS85 = &Stub;
-		break;
-	case PRE_READ:
-		ixj_PreRead = &Stub;
-		break;
-	case POST_READ:
-		ixj_PostRead = &Stub;
-		break;
-	case PRE_WRITE:
-		ixj_PreWrite = &Stub;
-		break;
-	case POST_WRITE:
-		ixj_PostWrite = &Stub;
-		break;
-	case PRE_IOCTL:
-		ixj_PreIoctl = &Stub;
-		break;
-	case POST_IOCTL:
-		ixj_PostIoctl = &Stub;
-		break;
-	default:
-		retval = 1;
-	}
-	return retval;
-}
-
-EXPORT_SYMBOL(ixj_unregister);
-
 static void ixj_init_timer(IXJ *j)
 {
 	init_timer(&j->timer);
@@ -2257,7 +2162,7 @@
 	return 0;
 }
 
-int ixj_release(struct inode *inode, struct file *file_p)
+static int ixj_release(struct inode *inode, struct file *file_p)
 {
 	IXJ_TONE ti;
 	int cnt;
@@ -6785,7 +6690,7 @@
 	return fasync_helper(fd, file_p, mode, &j->async_queue);
 }
 
-struct file_operations ixj_fops =
+static struct file_operations ixj_fops =
 {
         .owner          = THIS_MODULE,
         .read           = ixj_enhanced_read,
@@ -7735,7 +7640,7 @@
 	return res;
 }
 
-int __init ixj_probe_isapnp(int *cnt)
+static int __init ixj_probe_isapnp(int *cnt)
 {               
 	int probe = 0;
 	int func = 0x110;
@@ -7815,7 +7720,7 @@
 	return probe;
 }
                         
-int __init ixj_probe_isa(int *cnt)
+static int __init ixj_probe_isa(int *cnt)
 {
 	int i, probe;
 
@@ -7839,7 +7744,7 @@
 	return 0;
 }
 
-int __init ixj_probe_pci(int *cnt)
+static int __init ixj_probe_pci(int *cnt)
 {
 	struct pci_dev *pci = NULL;   
 	int i, probe = 0;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

