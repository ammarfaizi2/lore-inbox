Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310459AbSCBVZn>; Sat, 2 Mar 2002 16:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310458AbSCBVZc>; Sat, 2 Mar 2002 16:25:32 -0500
Received: from hera.cwi.nl ([192.16.191.8]:54970 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S310459AbSCBVZV>;
	Sat, 2 Mar 2002 16:25:21 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 2 Mar 2002 21:25:16 GMT
Message-Id: <UTC200203022125.VAA144817.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] swapfile.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.2 swapfile.c was broken:
In sys_swapon() we see

	swap_file = filp_open(name, O_RDWR, 0);
	if (IS_ERR(swap_file))
		goto bad_swap_2;

bad_swap_2:
	...
	if (swap_file)
		filp_close(swap_file, NULL);

and this oopses the kernel.
Below a trivial fix. Somebody with more time may come
back and polish stuff a little.

Andries

--- swapfile.c~	Sat Mar  2 18:23:19 2002
+++ swapfile.c	Sun Mar  3 23:08:48 2002
@@ -905,8 +905,10 @@
 	swap_file = filp_open(name, O_RDWR, 0);
 	putname(name);
 	error = PTR_ERR(swap_file);
-	if (IS_ERR(swap_file))
+	if (IS_ERR(swap_file)) {
+		swap_file = NULL;
 		goto bad_swap_2;
+	}
 
 	p->swap_file = swap_file;
 

[this was a patch relative to 2.5.6-pre2]
