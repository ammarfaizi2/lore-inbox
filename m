Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbTHYAGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 20:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTHYAGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 20:06:22 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:26795 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261350AbTHYAGU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 20:06:20 -0400
Message-Id: <200308250006.h7P06Ax0022635@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: selinux build failure
To: James Morris <jmorris@redhat.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
Date: Sun, 24 Aug 2003 02:21:08 +0200
References: <o4Fj.1rw.9@gated-at.bofh.it> <o4YO.1Fl.21@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:

> On Sun, 24 Aug 2003, Christoph Hellwig wrote:
> 
>> Argg, this is b0rked.  {asm,linux}/compat.h are for the 32bit compatiblity
>> code.  64bit arches don't have fcntl64 - see the #if BITS_PER_LONG == 32
>> around sys_fcntl64 in fcntl.c..
> 
> Indeed.  How about this?

Fixes the problem on 64 bit s390. I still get a __you_cannot_kmalloc_that_much
link error in avtab_init() and some more warnings about selinux:

security/selinux/hooks.c: In function `selinux_bprm_set_security':
security/selinux/hooks.c:1384: warning: cast to pointer from integer of different size
security/selinux/hooks.c:1430: warning: cast to pointer from integer of different size
security/selinux/hooks.c: In function `selinux_bprm_compute_creds':
security/selinux/hooks.c:1520: warning: cast from pointer to integer of different size
security/selinux/hooks.c: In function `selinux_getprocattr':
security/selinux/hooks.c:3147: warning: passing arg 3 of `security_sid_to_context' from incompatible pointer type
security/selinux/ss/ebitmap.c: In function `ebitmap_read':
security/selinux/ss/ebitmap.c:255: warning: int format, different type arg (arg 3)
security/selinux/ss/ebitmap.c:264: warning: int format, different type arg (arg 3)
security/selinux/ss/ebitmap.c:287: warning: int format, different type arg (arg 3)
security/selinux/ss/ebitmap.c:293: warning: int format, different type arg (arg 3)
security/selinux/ss/policydb.c: In function `policydb_read':
security/selinux/ss/policydb.c:1078: warning: int format, different type arg (arg 3)

The link error can be avoided by using vmalloc for htable, but there
may be better solutions.

===== security/selinux/ss/avtab.c 1.1 vs edited =====
--- 1.1/security/selinux/ss/avtab.c     Thu Jul 17 11:38:01 2003
+++ edited/security/selinux/ss/avtab.c  Sun Aug 24 02:02:24 2003
@@ -106,7 +106,7 @@
                }
                h->htable[i] = NULL;
        }
-       kfree(h->htable);
+       vfree(h->htable);
 }
 
 
@@ -138,7 +138,7 @@
 {
        int i;
 
-       h->htable = kmalloc(sizeof(*(h->htable)) * AVTAB_SIZE, GFP_KERNEL);
+       h->htable = vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);
        if (!h->htable)
                return -ENOMEM;
        for (i = 0; i < AVTAB_SIZE; i++)
===== security/selinux/ss/global.h 1.2 vs edited =====
--- 1.2/security/selinux/ss/global.h    Sun Aug 10 13:22:59 2003
+++ edited/security/selinux/ss/global.h Sun Aug 24 02:09:28 2003
@@ -8,6 +8,7 @@
 #include <linux/in.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
+#include <linux/vmalloc.h>
 
 #include "flask.h"
 #include "avc.h"
