Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154856-17483>; Mon, 10 May 1999 19:48:25 -0400
Received: by vger.rutgers.edu id <154760-17480>; Mon, 10 May 1999 18:54:44 -0400
Received: from heaton.cl.cam.ac.uk ([128.232.32.11]:2968 "EHLO heaton.cl.cam.ac.uk" ident: "exim") by vger.rutgers.edu with ESMTP id <155632-17480>; Mon, 10 May 1999 17:20:33 -0400
X-Mailer: exmh version 2.0.2+CL 2/24/98
To: linux-kernel@vger.rutgers.edu
cc: Steven.Hand@cl.cam.ac.uk
Subject: [patch] file position update when reading /dev/kmem
Mime-Version: 1.0
Content-Type: multipart/mixed ; boundary="==_Exmh_-7167040260"
Date: Mon, 10 May 1999 23:02:51 +0100
From: Steven Hand <Steven.Hand@cl.cam.ac.uk>
Message-Id: <E10gy8U-0004m5-00@heaton.cl.cam.ac.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

This is a multipart MIME message.

--==_Exmh_-7167040260
Content-Type: text/plain; charset=us-ascii


When read()'ing from /dev/kmem, the file position is incorrectly updated, which
bites you if you perform >1 read on the file before close()'ing it. AFAICS, the
bug has been around since at least 2.1.127. 

The tiny patch attached below is against 2.2.7 and should fix the problem.
Notice that the first part of the patch is simply an optimisation to avoid
calling vread() and iterating along every vmalloc'd area in the case that 
copy_to_user() has already done its stuff. The line involving the update
of *ppos is the important one.

S.



--==_Exmh_-7167040260
Content-Type: text/plain ; name="kmem_patch"; charset=us-ascii
Content-Description: kmem_patch
Content-Disposition: attachment; filename="kmem_patch"

--- v2.2.7/linux/drivers/char/mem.c	Mon May 10 22:29:38 1999
+++ linux/drivers/char/mem.c	Mon May 10 22:27:59 1999
@@ -247,11 +247,14 @@
 		count -= read;
 	}
 
-	virtr = vread(buf, (char *)p, count);
-	if (virtr < 0)
-		return virtr;
-	*ppos += p + virtr;
-	return virtr + read;
+	if(count) {
+		if((virtr = vread(buf, (char *)p, count)) < 0)
+			return virtr;
+		read += virtr;
+	}
+
+	*ppos += read;
+	return read;
 }
 
 /*

--==_Exmh_-7167040260--



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
