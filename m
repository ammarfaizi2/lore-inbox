Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSLPKm7>; Mon, 16 Dec 2002 05:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSLPKm7>; Mon, 16 Dec 2002 05:42:59 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:13713 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262796AbSLPKm6>;
	Mon, 16 Dec 2002 05:42:58 -0500
Date: Mon, 16 Dec 2002 16:36:34 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: rusty@rustcorp.com.au
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [BUG] module-init-tools 0.9.3, rmmod modules with '-'
Message-ID: <20021216163634.A29099@in.ibm.com>
Reply-To: vamsi@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

It seems we cannot unload modules if they have a '-' in their name. 
filename2modname() in rmmod.c converts a '-' in the filename
to '_'. Why? Are dashes not allowed as part of module names?

For eg: (kernel 2.5.52/module-init-tools 0.9.3)

[root@llm10 test-modules]# ./insmod probe-test.o
[root@llm10 test-modules]# ./lsmod
Module                  Size  Used by
probe-test               943  0
[root@llm10 test-modules]# cat /proc/modules
probe-test 943 0
[root@llm10 test-modules]# ./rmmod -V
module-init-tools version 0.9.3
[root@llm10 test-modules]# ./rmmod probe-test
ERROR: Module probe_test does not exist in /proc/modules
                   ^note this

Editing filename2modname() to remove this special test for
'-' seems to fix it. But, this is done explicitly, so
I wonder if there is a deeper meaning to this. Can you
please take a look and explain?

Thanks,
Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
--
--- rmmod-old.c	2002-12-13 21:11:57.000000000 +0530
+++ rmmod.c	2002-12-13 21:10:44.000000000 +0530
@@ -157,9 +157,12 @@
 	else
 		afterslash++;
 
-	/* stop at first . */
+	/* Convert to underscores, stop at first . */
 	for (i = 0; afterslash[i] && afterslash[i] != '.'; i++) {
-		modname[i] = afterslash[i];
+		if (afterslash[i] == '-')
+			modname[i] = '_';
+		else
+			modname[i] = afterslash[i];
 	}
 	modname[i] = '\0';
 }
