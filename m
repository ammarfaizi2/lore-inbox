Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271089AbRHQKk3>; Fri, 17 Aug 2001 06:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271149AbRHQKkU>; Fri, 17 Aug 2001 06:40:20 -0400
Received: from pat.uio.no ([129.240.130.16]:12724 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S271089AbRHQKkO>;
	Fri, 17 Aug 2001 06:40:14 -0400
MIME-Version: 1.0
Message-ID: <15228.62614.121436.889705@charged.uio.no>
Date: Fri, 17 Aug 2001 12:40:22 +0200
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: trond.myklebust@fys.uio.no (Trond Myklebust), alan@redhat.com,
        linux-kernel@vger.kernel.org, adam@yggdrasil.com
Subject: Re: linux-2.4.9: atomic_dec_and_lock sometimes used while not defined
In-Reply-To: <200108171031.f7HAVAc16023@ns.caldera.de>
In-Reply-To: <shsu1z7c7qa.fsf@charged.uio.no>
	<200108171031.f7HAVAc16023@ns.caldera.de>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christoph Hellwig <hch@ns.caldera.de> writes:

     > Hi Trond, In article <shsu1z7c7qa.fsf@charged.uio.no> you
     > wrote:
    >> diff -u --recursive --new-file linux-2.4.9.orig/lib/Makefile
    >> linux-2.4.9/lib/Makefile
    >> --- linux-2.4.9.orig/lib/Makefile Wed Apr 25 22:31:03 2001
    >> +++ linux-2.4.9/lib/Makefile Fri Aug 17 11:52:35 2001
    >> @@ -16,6 +16,7 @@ obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) +=
    >> rwsem.o
    >>
    >> ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
    >> + export-objs += dec_and_lock.o
    >> obj-y += dec_and_lock.o endif

     > Nonono!  Please add it to export-objs _always_ not dependand on
     > some CONFIG_ symbol, that's how the 2.4 makefiles work.

Revised patch follows...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.9/lib/Makefile linux-2.4.9-atomic_lock/lib/Makefile
--- linux-2.4.9/lib/Makefile	Wed Apr 25 22:31:03 2001
+++ linux-2.4.9-atomic_lock/lib/Makefile	Fri Aug 17 12:38:24 2001
@@ -8,7 +8,7 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o rwsem-spinlock.o rwsem.o
+export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o
 
diff -u --recursive --new-file linux-2.4.9/lib/dec_and_lock.c linux-2.4.9-atomic_lock/lib/dec_and_lock.c
--- linux-2.4.9/lib/dec_and_lock.c	Sat Jul  8 01:22:48 2000
+++ linux-2.4.9-atomic_lock/lib/dec_and_lock.c	Fri Aug 17 12:22:49 2001
@@ -1,3 +1,4 @@
+#include <linux/module.h>
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 
@@ -34,4 +35,6 @@
 	spin_unlock(lock);
 	return 0;
 }
+
+EXPORT_SYMBOL(atomic_dec_and_lock);
 #endif
