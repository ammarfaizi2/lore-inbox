Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbTEWS7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 14:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTEWS7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 14:59:40 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:25330 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264138AbTEWS7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 14:59:38 -0400
Date: Fri, 23 May 2003 14:12:42 -0500
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: multipart/mixed; boundary=Apple-Mail-18-248034566
Subject: [PATCH] init/do_mounts_rd.c memory leak
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Message-Id: <86FA627A-8D52-11D7-BCE2-000A95A0560C@austin.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-18-248034566
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Another potential memory leak the Stanford checker caught at 2.5.48: 
while closing and opening floppy disks, buf could be allocated and 
never freed.

-- 
Hollis Blanchard
IBM Linux Technology Center


--Apple-Mail-18-248034566
Content-Disposition: attachment;
	filename=mount-rd-free.diff
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="mount-rd-free.diff"

--- init/do_mounts_rd.c.orig	2003-05-15 15:05:56.000000000 -0500
+++ init/do_mounts_rd.c	2003-05-15 15:06:30.000000000 -0500
@@ -206,12 +206,14 @@
 			rotate = 0;
 			if (close(in_fd)) {
 				printk("Error closing the disk.\n");
+				kfree(buf);
 				goto noclose_input;
 			}
 			change_floppy("disk #%d", disk);
 			in_fd = open(from, O_RDONLY, 0);
 			if (in_fd < 0)  {
 				printk("Error opening disk.\n");
+				kfree(buf);
 				goto noclose_input;
 			}
 			printk("Loading disk #%d... ", disk);

--Apple-Mail-18-248034566--

