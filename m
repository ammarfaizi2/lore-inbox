Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUEGPKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUEGPKC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUEGPKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:10:02 -0400
Received: from mail.aknet.ru ([217.67.122.194]:27654 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S263614AbUEGPJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:09:55 -0400
Message-ID: <409BA6B1.7030809@aknet.ru>
Date: Fri, 07 May 2004 19:09:37 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040410
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in IO bitmap handling? Probably exploitable (2.6.5)
Content-Type: multipart/mixed;
 boundary="------------010809070002000601030101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------010809070002000601030101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hello.

The attached is the small program that
tries to write 0x20 to port 0x20.
Normally this should cause SIGSEGV, so
the program should crash.
I think there is a bug in the 2.6
kernels though, which makes it to not
crash if some trivial conditions are
met. Basically it seems that if any process
that obtained an IO access permissions
via ioperm(), exits without explicitly
"dropping" that permissions, the IO
permissions gets "inherited" by all
other processes in the system.
The cause seems to be that exit_thread()
only invalidates the per-thread io_bitmap
pointer, but doesn't invalidate the
per-TSS io_bitmap pointer as well. As the
per-thread pointer is invalidated,
__switch_to() doesn't take care of that
one either, so the per-TSS pointer stays
valid as long as some other process
does ioperm().
Here it is sufficient to start an X server
and exit it, and then the program that
is attached, will not get a SIGSEGV any
more, actually successing with the port
write.
I am also attaching the patch that seems
like fixing the problem - it invalidates
also the per-TSS io_bitmap pointer and
the problem goes away.

Can someone please confirm (or refute)
the presense of the bug there? Because
if it is really a bug, I suppose it can
be exploited, if not for getting root,
then at least to deadlock the machine.

--------------010809070002000601030101
Content-Type: text/plain;
 name="port.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="port.c"


#include <stdio.h>
#include <asm/io.h>

int main()
{
  outb(0x20, 0x20);
  printf("Fine, I am alive!\n");
  return 0;
}

--------------010809070002000601030101
Content-Type: text/plain;
 name="tss_iobtm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tss_iobtm.diff"


--- linux/arch/i386/kernel/process.c	2004-04-14 09:41:14.000000000 +0400
+++ linux/arch/i386/kernel/process.c	2004-05-07 14:54:13.000000000 +0400
@@ -293,8 +293,11 @@
 
 	/* The process may have allocated an io port bitmap... nuke it. */
 	if (unlikely(NULL != tsk->thread.io_bitmap_ptr)) {
+		int cpu = smp_processor_id();
+		struct tss_struct *tss = init_tss + cpu;
 		kfree(tsk->thread.io_bitmap_ptr);
 		tsk->thread.io_bitmap_ptr = NULL;
+		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 	}
 }
 

--------------010809070002000601030101
Content-Type: text/plain


Scanned by evaluation version of Dr.Web antivirus Daemon 
http://drweb.ru/unix/


--------------010809070002000601030101--
