Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268533AbUIQHeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268533AbUIQHeA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268534AbUIQHce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:32:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33933 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268533AbUIQH3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:29:54 -0400
Date: Fri, 17 Sep 2004 00:29:35 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] ub.c badness in current bk
Message-Id: <20040917002935.77620d1d@lembas.zaitcev.lan>
In-Reply-To: <mailman.1095300780.10032.linux-kernel2news@redhat.com>
References: <mailman.1095300780.10032.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 12:06:01 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> ub: sizeof ub_scsi_cmd 60 ub_dev 924
> uba: device 2 capacity nsec 50 bsize 512
> uba: made changed
> uba: device 2 capacity nsec 126720 bsize 512
> uba: device 2 capacity nsec 126720 bsize 512
>  uba: uba1
>  uba: uba1
> kobject_register failed for uba1 (-17)

Please try this (includes the right size for REQUEST SENSE, it's vital):

--- linux-2.6.9-rc1/drivers/block/ub.c	2004-08-25 17:19:30.000000000 -0700
+++ linux-2.6.9-rc1-ub/drivers/block/ub.c	2004-09-17 00:24:50.227539272 -0700
@@ -1185,9 +1213,17 @@
 		goto error;
 	}
 
+	/*
+	 * ``If the allocation length is eighteen or greater, and a device
+	 * server returns less than eithteen bytes of data, the application
+	 * client should assume that the bytes not transferred would have been
+	 * zeroes had the device server returned those bytes.''
+	 */
 	memset(&sc->top_sense, 0, UB_SENSE_SIZE);
+
 	scmd = &sc->top_rqs_cmd;
 	scmd->cdb[0] = REQUEST_SENSE;
+	scmd->cdb[4] = UB_SENSE_SIZE;
 	scmd->cdb_len = 6;
 	scmd->dir = UB_DIR_READ;
 	scmd->state = UB_CMDST_INIT;
@@ -1474,6 +1515,7 @@
 static int ub_bd_media_changed(struct gendisk *disk)
 {
 	struct ub_dev *sc = disk->private_data;
+	int ret;
 
 	if (!sc->removable)
 		return 0;
@@ -1493,10 +1535,10 @@
 		return 1;
 	}
 
-	/* The sd.c clears this before returning (one-shot flag). Why? */
-	/* P3 */ printk("%s: %s changed\n", sc->name,
-	    sc->changed? "is": "was not");
-	return sc->changed;
+	ret = sc->changed;
+	/* P3 */ printk("%s: %s changed\n", sc->name, ret ? "is": "was not");
+	sc->changed = 0;
+	return ret;
 }
 
 static struct block_device_operations ub_bd_fops = {

Regardless of the result, I'd like to see the dmesg, and
cat $(find /sys -name diag)

-- Pete
