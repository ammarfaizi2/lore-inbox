Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270073AbRHQKQ1>; Fri, 17 Aug 2001 06:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270067AbRHQKQH>; Fri, 17 Aug 2001 06:16:07 -0400
Received: from mons.uio.no ([129.240.130.14]:4743 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S270073AbRHQKP4>;
	Fri, 17 Aug 2001 06:15:56 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.9: atomic_dec_and_lock sometimes used while not defined
In-Reply-To: <200108161821.LAA02805@adam.yggdrasil.com>
	<shs8zgjdovh.fsf@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 17 Aug 2001 12:15:56 +0200
In-Reply-To: Trond Myklebust's message of "17 Aug 2001 11:20:18 +0200"
Message-ID: <shsu1z7c7qa.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> " " == Adam J Richter <adam@yggdrasil.com> writes:
    >> If I try to build a kernel that can do SMP and run on a 386,
    >> the linux-2.4.9 NFS client gets compiled with an undefined
    >> reference to atomic_dec_and_lock().

Bummer I found the bug. It's not a missing define, but a missing
export...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.9.orig/lib/Makefile linux-2.4.9/lib/Makefile
--- linux-2.4.9.orig/lib/Makefile	Wed Apr 25 22:31:03 2001
+++ linux-2.4.9/lib/Makefile	Fri Aug 17 11:52:35 2001
@@ -16,6 +16,7 @@
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
+  export-objs += dec_and_lock.o
   obj-y += dec_and_lock.o
 endif
 
diff -u --recursive --new-file linux-2.4.9.orig/lib/dec_and_lock.c linux-2.4.9/lib/dec_and_lock.c
--- linux-2.4.9.orig/lib/dec_and_lock.c	Sat Jul  8 01:22:48 2000
+++ linux-2.4.9/lib/dec_and_lock.c	Fri Aug 17 11:55:02 2001
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
