Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266559AbUBLT2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUBLT2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:28:40 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:50633 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266559AbUBLT2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:28:13 -0500
Message-ID: <402BD3C4.1010905@colorfullife.com>
Date: Thu, 12 Feb 2004 20:28:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: userspace mptable parsing broken in 2.6
References: <20040211121350.GK12634@redhat.com>
In-Reply-To: <20040211121350.GK12634@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070004090207020402020907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070004090207020402020907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dave Jones wrote:

>Reading from some parts of /dev/mem is still broken in 2.6.3rc2,
>which breaks at least x86info.
>
>Manfred, in the end of the last thread on this at..
>http://www.ussg.iu.edu/hypermail/linux/kernel/0311.1/0373.html
>you mentioned you were going to add some code to /dev/mem for the
>DEBUG_PAGEALLOC case. Did you get anywhere with that?
>  
>
Sorry, I forgot about the issue.

What about the attached patch?

--
    Manfred

--------------070004090207020402020907
Content-Type: text/plain;
 name="patch-debugpagealloc-mem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-debugpagealloc-mem"

--- 2.6/drivers/char/mem.c	2004-02-08 13:08:30.000000000 +0100
+++ build-2.6/drivers/char/mem.c	2004-02-12 20:10:56.000000000 +0100
@@ -25,6 +25,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
 #include <linux/device.h>
+#include <linux/pagemap.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -151,10 +152,41 @@
 		}
 	}
 #endif
+#if CONFIG_DEBUG_PAGEALLOC
+	while (count) {
+		size_t i;
+		struct page *page;
+
+		i = PAGE_SIZE - (p%PAGE_SIZE);
+		if (i > count)
+			i = count;
+		if (virt_addr_valid(__va(p))) {
+			page = virt_to_page(__va(p));
+			get_page(page);
+			kernel_map_pages(page, 1, 1);
+		} else {
+			page = NULL;
+		}
+		if (copy_to_user(buf, __va(p), i)) {
+			if (page)
+				put_page(page);
+			return -EFAULT;
+		}
+		if (page)
+			put_page(page);
+		buf += i;
+		p += i;
+		count -= i;
+		read += i;
+	}
+#else
 	if (copy_to_user(buf, __va(p), count))
 		return -EFAULT;
+
+	p += count;
 	read += count;
-	*ppos += read;
+#endif
+	*ppos = p;
 	return read;
 }
 

--------------070004090207020402020907--

