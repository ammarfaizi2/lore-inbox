Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTFJJ4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbTFJJyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:54:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60670 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261411AbTFJJyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:54:03 -0400
Date: Tue, 10 Jun 2003 15:40:35 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: cp-user-eicon
Message-ID: <20030610101035.GF2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100527.GA2194@in.ibm.com> <20030610100643.GB2194@in.ibm.com> <20030610100746.GC2194@in.ibm.com> <20030610100905.GD2194@in.ibm.com> <20030610100950.GE2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610100950.GE2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use copy_to_user, not memcpy with user buffers


 drivers/isdn/eicon/linchr.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/isdn/eicon/linchr.c~cp-user-eicon drivers/isdn/eicon/linchr.c
--- linux-2.5.70-ds/drivers/isdn/eicon/linchr.c~cp-user-eicon	2003-06-08 03:30:31.000000000 +0530
+++ linux-2.5.70-ds-dipankar/drivers/isdn/eicon/linchr.c	2003-06-08 03:30:31.000000000 +0530
@@ -153,17 +153,17 @@ ssize_t do_read(struct file *pFile, char
 	klog_t *pHeadItem;
 
 	if (BufferSize < sizeof(klog_t))
-	{
-		printk(KERN_WARNING "Divas: Divalog buffer specifed a size that is too small (%d - %d required)\n",
-			BufferSize, sizeof(klog_t));
 		return -EIO;
-	}
 
 	pHeadItem = (klog_t *) DivasLogFifoRead();
 
 	if (pHeadItem)
 	{
-		memcpy(pClientLogBuffer, pHeadItem, sizeof(klog_t));
+		if(copy_to_user(pClientLogBuffer, pHeadItem, sizeof(klog_t)))
+		{
+			kfree(pHeadItem);
+			return -EFAULT;
+		}
 		kfree(pHeadItem);
 		return sizeof(klog_t);
 	}

_
