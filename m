Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263923AbRFMAit>; Tue, 12 Jun 2001 20:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263928AbRFMAij>; Tue, 12 Jun 2001 20:38:39 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:9991 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S263923AbRFMAig>; Tue, 12 Jun 2001 20:38:36 -0400
Date: Tue, 12 Jun 2001 18:38:32 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Minor "cleanup" patches for 2.4.5-ac kernels
Message-ID: <20010612183832.A29923@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some small, but in times important, "gotchas" in current
2.4.5-ac kernels.

When compiling SMP 'udelay' in current drivers/pci/quirks.c expands to:

   __udelay((15), cpu_data[(current->processor)]...

and a type for 'current' is not known, at least on alpha, so
the following seems to be in order:

--- linux-2.4.5ac/drivers/pci/quirks.c~	Tue Jun 12 16:31:12 2001
+++ linux-2.4.5ac/drivers/pci/quirks.c	Tue Jun 12 17:13:18 2001
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/sched.h>
 
 #undef DEBUG
 
There is no problem if SMP is not configured.

This one is replacing a symbol in sg.c to one which is exported
so 'sg.o' can be compiled as a valid module.

--- linux-2.4.5ac/drivers/scsi/sg.c~	Tue May 29 17:52:09 2001
+++ linux-2.4.5ac/drivers/scsi/sg.c	Tue May 29 18:40:17 2001
@@ -2603,7 +2603,7 @@
     num = (count < 10) ? count : 10;
     copy_from_user(buff, buffer, num);
     buff[num] = '\0';
-    sg_allow_dio = simple_strtol(buff, 0, 10) ? 1 : 0;
+    sg_allow_dio = simple_strtoul(buff, 0, 10) ? 1 : 0;
     return count;
 }
 
 
And this one, proposed already some few times by Ivan Kokshaysky,

--- 2.4.5-ac11/include/linux/binfmts.h	Mon Jun  4 14:19:00 2001
+++ linux/include/linux/binfmts.h	Mon Jun  4 20:24:50 2001
@@ -32,6 +32,9 @@ struct linux_binprm{
 	unsigned long loader, exec;
 };
 
+/* Forward declaration */
+struct mm_struct;
+
 /*
  * This structure defines the functions that are used to load the binary formats that
  * linux accepts.

kills a flood of warnings (at least on Alpha) about 'mm_struct'
defined on a parameter list.

Are there any reasons which would make any of those "bad"?

  Michal
