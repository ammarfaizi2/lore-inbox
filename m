Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVAKBIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVAKBIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVAKBEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:04:02 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:2278 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262562AbVAKBAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:00:46 -0500
Date: Mon, 10 Jan 2005 17:00:45 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] scsi/st: replace schedule_timeout() with msleep_interruptible()
Message-ID: <20050111010045.GM9186@us.ibm.com>
References: <20050110164703.GD14307@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110164703.GD14307@nd47.coderock.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:47:03PM +0100, Domen Puncer wrote:
> Patchset of 171 patches is at http://coderock.org/kj/2.6.10-bk13-kj/
> 
> Quick patch summary: about 30 new, 30 merged, 30 dropped.
> Seems like most external trees are merged in -linus, so i'll start
> (re)sending old patches.

<snip>

> msleep_interruptible-drivers_scsi_st.patch

Please consider updating to the following patch:

Description: Use msleep_interruptible() instead of
schedule_timeout() to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/scsi/st.c	2004-12-24 13:35:01.000000000 -0800
+++ 2.6.10/drivers/scsi/st.c	2005-01-05 14:23:05.000000000 -0800
@@ -36,6 +36,7 @@ static char *verstr = "20041025";
 #include <linux/moduleparam.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/cdev.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/dma.h>
 #include <asm/system.h>
@@ -760,9 +761,7 @@ static int test_ready(struct scsi_tape *
 
 			if (scode == NOT_READY) {
 				if (waits < max_wait) {
-					set_current_state(TASK_INTERRUPTIBLE);
-					schedule_timeout(HZ);
-					if (signal_pending(current)) {
+					if (msleep_interruptible(1000)) {
 						retval = (-EINTR);
 						break;
 					}
