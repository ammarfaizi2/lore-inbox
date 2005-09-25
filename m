Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVIYIDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVIYIDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 04:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVIYIDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 04:03:07 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:21605 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751236AbVIYIDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 04:03:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=jNhZMWkiYSCMIafMgNHxNVHQdsjGhz5DykicFlFPumEycDC/DuYya8r3TiXID9hw0tQ97+/YjLjkW36AFrTU5QMvZPV7eC3u9HvGjUSxbx56Gy8rNlcFUvilDRxbjbXlVOo27Gow/oqk6xeK6AYolI82wT+kHDPNHM4b8oWtZfo=  ;
Message-ID: <433659E1.8070905@yahoo.com.au>
Date: Sun, 25 Sep 2005 18:03:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: zwane@linuxpower.ca, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 01/04] brsem: implement big reader semaphore
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.FF1C2BEC@htj.dyndns.org> <43364F70.7010705@yahoo.com.au>
In-Reply-To: <43364F70.7010705@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------020608030606030301000403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020608030606030301000403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:

> What would be wrong with an array of NR_CPUS rwsems? The only
> tiny trick you would have to do AFAIKS is have up_read remember
> what rwsem down_read took, but that could be returned from
> down_read as a token.

Here's something to start with. Add initialisers / cacheline
alignment / percpu_alloc to taste.

For bonus points I guess you could change the implementation
to just a single waitqueue mechanism with NR_CPUs counters.

In fact, it probably needs quite a bit of work before it is
mainline-worthy, but as a proof of concept - do you see
anything wrong with it?

Nick

-- 
SUSE Labs, Novell Inc.


--------------020608030606030301000403
Content-Type: text/plain;
 name="brsem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="brsem.patch"

Index: linux-2.6/include/linux/brsem.h
===================================================================
--- /dev/null
+++ linux-2.6/include/linux/brsem.h
@@ -0,0 +1,18 @@
+#ifndef __BRSEM_H
+#define __BRSEM_H
+
+#include <linux/rwsem.h>
+struct brsem {
+	struct rw_semaphore cpu_sem[NR_CPUS];
+};
+
+#define BRSEM_READ_TRYLOCK_FAILED	-1
+typedef int brsem_read_t;
+
+brsem_read_t brsem_down_read(struct brsem *);
+brsem_read_t brsem_down_read_trylock(struct brsem *);
+void brsem_up_read(struct brsem *, brsem_read_t);
+void brsem_down_write(struct brsem *);
+void brsem_up_write(struct brsem *);
+
+#endif
Index: linux-2.6/lib/Makefile
===================================================================
--- linux-2.6.orig/lib/Makefile
+++ linux-2.6/lib/Makefile
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o brsem.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
Index: linux-2.6/lib/brsem.c
===================================================================
--- /dev/null
+++ linux-2.6/lib/brsem.c
@@ -0,0 +1,38 @@
+#include <linux/brsem.h>
+#include <linux/rwsem.h>
+#include <linux/smp.h>
+
+brsem_read_t brsem_down_read(struct brsem *brsem)
+{
+	brsem_read_t ret = smp_processor_id();
+	down_read(&brsem->cpu_sem[ret]);
+	return ret;
+}
+
+brsem_read_t brsem_down_read_trylock(struct brsem *brsem)
+{
+	brsem_read_t ret = smp_processor_id();
+	if (!down_read_trylock(&brsem->cpu_sem[ret]))
+		return BRSEM_READ_TRYLOCK_FAILED;
+	return ret;
+}
+
+void brsem_up_read(struct brsem *brsem, brsem_read_t token)
+{
+	up_read(&brsem->cpu_sem[token]);
+}
+
+void brsem_down_write(struct brsem *brsem)
+{
+	int i;
+	for (i = 0; i < NR_CPUS; i++)
+		down_write(&brsem->cpu_sem[i]);
+}
+
+void brsem_up_write(struct brsem *brsem)
+{
+	int i;
+	for (i = 0; i < NR_CPUS; i++)
+		up_write(&brsem->cpu_sem[i]);
+}
+

--------------020608030606030301000403--
Send instant messages to your online friends http://au.messenger.yahoo.com 
