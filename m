Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTEQR7m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 13:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTEQR7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 13:59:41 -0400
Received: from [193.126.32.23] ([193.126.32.23]:33409 "EHLO
	mail.paradigma.co.pt") by vger.kernel.org with ESMTP
	id S261743AbTEQR7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 13:59:40 -0400
Date: Sat, 17 May 2003 19:12:18 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: ioperm bitmap stuff for 2.4
Message-ID: <20030517181218.GA4000@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

[ let's see if three is the charm, the two previous attempts didnt make 
it to the list... ]

Hi people,


Is the ioperm patch necessary in 2.4 also? The fix by Brian Gerst was 
commited to the 2.5 branch 
(http://marc.theaimsgroup.com/?l=bk-commits-head&m=105275597307968&w=2) 
some days ago, and as of yesterday vendors are starting to ship a similar 
fix to their kernels, so I suppose it is indeed necessary. What about the 
attached patch? It applies to both 2.4.20 and .21-rc2, please review.


(Please forgive me if this has been discussed before, I did a quick 
search of the lkml archives and couldnt find anything relevant to 2.4)



Cheers,

			Nuno

--bp/iNruPH9dso1Pn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="2.4-042-ioperm-fix.patch"

--- linux-2.4.20-gw3/arch/i386/kernel/ioport.c	2003-05-16 23:42:47.000000000 +0100
+++ linux-2.4.20-gw4/arch/i386/kernel/ioport.c	2003-05-16 23:42:49.000000000 +0100
@@ -72,17 +72,18 @@
 		 */
 		memset(t->io_bitmap,0xff,(IO_BITMAP_SIZE+1)*4);
 		t->ioperm = 1;
-		/*
-		 * this activates it in the TSS
-		 */
-		tss->bitmap = IO_BITMAP_OFFSET;
 	}
 
 	/*
 	 * do it in the per-thread copy and in the TSS ...
 	 */
 	set_bitmap(t->io_bitmap, from, num, !turn_on);
-	set_bitmap(tss->io_bitmap, from, num, !turn_on);
+	if (tss->bitmap == IO_BITMAP_OFFSET) { /* already active? */
+		set_bitmap(tss->io_bitmap, from, num, !turn_on);
+	} else {
+		memcpy(tss->io_bitmap, t->io_bitmap, IO_BITMAP_SIZE);
+		tss->bitmap = IO_BITMAP_OFFSET; /* Activate it in the TSS */
+	}
 
 	return 0;
 }

--bp/iNruPH9dso1Pn--
