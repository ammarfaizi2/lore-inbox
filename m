Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTE0RyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264007AbTE0Rwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:52:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39664 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264027AbTE0Rv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:51:58 -0400
Date: Tue, 27 May 2003 13:05:07 -0500
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: multipart/mixed; boundary=Apple-Mail-8-589579874
Subject: [CHECKER] [PATCH] zortran user-pointer fix
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Message-Id: <BFD891F0-906D-11D7-AED1-000A95A0560C@austin.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-8-589579874
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	delsp=yes;
	charset=US-ASCII;
	format=flowed

Here's what the Stanford checker said:
---------------------------------------------------------
[BUG] proc_dir_entry.write_proc

/home/junfeng/linux-2.5.63/drivers/media/video/ 
zoran_procfs.c:122:zoran_write_proc:
ERROR:TAINTED:122:122: passing tainted ptr 'buffer' to __memcpy
[Callstack:
/home/junfeng/linux-2.5.63/net/core/ 
pktgen.c:991:zoran_write_proc((tainted
1))]

	string = sp = vmalloc(count + 1);
	if (!string) {
		printk(KERN_ERR "%s: write_proc: can not allocate
memory\n", zr->name);
		return -ENOMEM;
	}

Error --->
	memcpy(string, buffer, count);
	string[count] = 0;
	DEBUG2(printk(KERN_INFO "%s: write_proc: name=%s count=%lu
data=%x\n", zr->name, file->f_dentry->d_name.name, count, (int) data));
	ldelim = " \t\n";
---------------------------------------------------------

Is this patch correct?

-- 
Hollis Blanchard
IBM Linux Technology Center

--Apple-Mail-8-589579874
Content-Disposition: attachment;
	filename=zortan-memcpy.diff
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="zortan-memcpy.diff"

--- linux-2.5.69/drivers/media/video/zoran_procfs.c.orig	2003-05-23 15:42:18.000000000 -0500
+++ linux-2.5.69/drivers/media/video/zoran_procfs.c	2003-05-23 15:42:40.000000000 -0500
@@ -119,7 +119,10 @@
 		printk(KERN_ERR "%s: write_proc: can not allocate memory\n", zr->name);
 		return -ENOMEM;
 	}
-	memcpy(string, buffer, count);
+	if (copy_from_user(string, buffer, count)) {
+		vfree(string);
+		return -EFAULT;
+	}
 	string[count] = 0;
 	DEBUG2(printk(KERN_INFO "%s: write_proc: name=%s count=%lu data=%x\n", zr->name, file->f_dentry->d_name.name, count, (int) data));
 	ldelim = " \t\n";

--Apple-Mail-8-589579874--

