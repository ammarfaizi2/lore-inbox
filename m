Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313497AbSDETNN>; Fri, 5 Apr 2002 14:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313496AbSDETND>; Fri, 5 Apr 2002 14:13:03 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:50131 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313492AbSDETMy>; Fri, 5 Apr 2002 14:12:54 -0500
Message-ID: <3CADF6E0.6060402@us.ibm.com>
Date: Fri, 05 Apr 2002 11:11:28 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020405
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andreas.bombe@munich.netsurf.de
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] remove BKL from ieee1394_core release function
Content-Type: multipart/mixed;
 boundary="------------030200010406050403090705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030200010406050403090705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I produced a similar patch for 2.5 which I discussed on the ieee1394 
mailing list a few weeks ago.  We decided that this was a safe and 
BKL-free approach.  Here is a patch to do the same thing for 2.4.19-pre6.

Please forward on to Marcello.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------030200010406050403090705
Content-Type: text/plain;
 name="ieee1394_core-bkl_remove-2.4.19-pre6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ieee1394_core-bkl_remove-2.4.19-pre6.patch"

--- linux-2.4.19-pre6-clean/drivers/ieee1394/ieee1394_core.c	Fri Apr  5 09:37:37 2002
+++ linux/drivers/ieee1394/ieee1394_core.c	Fri Apr  5 10:51:46 2002
@@ -906,17 +906,16 @@
 
 	/* printk("ieee1394_dispatch_open(%d)", blocknum); */
 
-	/* lock the whole kernel here, to prevent a driver from
-	   being unloaded between the file_ops lookup and the open */
-
-	lock_kernel();
-
 	read_lock(&ieee1394_chardevs_lock);
-	file_ops = ieee1394_chardevs[blocknum].file_ops;
 	module = ieee1394_chardevs[blocknum].module;
+	/* bump the reference count of the driver that
+	   will receive the open() */
+	INCREF(module);
+	file_ops = ieee1394_chardevs[blocknum].file_ops;
 	read_unlock(&ieee1394_chardevs_lock);
 
 	if(file_ops == NULL) {
+		DECREF(module);
 		goto out_fail;
 	}
 
@@ -924,10 +923,6 @@
 	   own file_operations */
 	file->f_op = file_ops;
 
-	/* bump the reference count of the driver that
-	   will receive the open() */
-	INCREF(module);
-	
 	/* at this point BOTH ieee1394 and the task-specific driver have
 	   an extra reference */
 
@@ -956,7 +951,6 @@
 		   and will be dropped by the VFS when the file is
 		   released. */
 		
-		unlock_kernel();
 		return 0;
 	}
 	       
@@ -966,7 +960,6 @@
 	   function returns. */
 	
 	file->f_op = &ieee1394_chardev_ops;
-	unlock_kernel();
 	return retval;
 
 #undef INCREF

--------------030200010406050403090705--

